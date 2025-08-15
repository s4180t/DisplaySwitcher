//
//  DisplaySwitcherApp.swift
//  DisplaySwitcher
//
//  A minimal macOS utility that switches the main display between built-in and external monitors.
//  Created by Vitalii Komar on 15.08.2025.
//

import SwiftUI
import CoreGraphics

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        performDisplaySwitch()
        
        // Exit after switch completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            NSApplication.shared.terminate(nil)
        }
    }
    
    private func performDisplaySwitch() {
        var displayCount: UInt32 = 0
        var result: CGError
        
        // Exit if only one display
        guard CGGetActiveDisplayList(0, nil, &displayCount) == .success, displayCount > 1 else {
            return
        }
        
        // Get all active displays
        var activeDisplays = Array<CGDirectDisplayID>(repeating: 0, count: Int(displayCount))
        guard CGGetActiveDisplayList(displayCount, &activeDisplays, &displayCount) == .success else {
            return
        }
        
        // Find target display to switch to
        let currentMain = CGMainDisplayID()
        guard let targetDisplay = activeDisplays.first(where: { $0 != currentMain }) else {
            return
        }
        
        // Begin configuration
        var config: CGDisplayConfigRef?
        guard CGBeginDisplayConfiguration(&config) == .success, let config = config else {
            return
        }
        
        // Identify built-in and external displays
        let builtInDisplay = activeDisplays.first { CGDisplayIsBuiltin($0) != 0 }
        let externalDisplay = activeDisplays.first { CGDisplayIsBuiltin($0) == 0 }
        
        if let builtin = builtInDisplay, let external = externalDisplay {
            let builtinBounds = CGDisplayBounds(builtin)
            
            if targetDisplay == builtin {
                // Built-in as main: built-in left, external right
                result = CGConfigureDisplayOrigin(config, builtin, 0, 0)
                guard result == .success else {
                    CGCancelDisplayConfiguration(config)
                    return
                }
                
                result = CGConfigureDisplayOrigin(config, external, Int32(builtinBounds.width), 0)
                guard result == .success else {
                    CGCancelDisplayConfiguration(config)
                    return
                }
            } else {
                // External as main: maintain built-in left, external right layout
                result = CGConfigureDisplayOrigin(config, external, 0, 0)
                guard result == .success else {
                    CGCancelDisplayConfiguration(config)
                    return
                }
                
                result = CGConfigureDisplayOrigin(config, builtin, -Int32(builtinBounds.width), 0)
                guard result == .success else {
                    CGCancelDisplayConfiguration(config)
                    return
                }
            }
        }
        
        // Apply configuration
        CGCompleteDisplayConfiguration(config, .permanently)
    }
}

@main
struct DisplaySwitcherApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
