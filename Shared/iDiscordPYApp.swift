//
//  iDiscordPYApp.swift
//  Shared
//
//  Created by Gabriel Linecker on 7/14/21.
//

import SwiftUI
import PythonKit
#if os(iOS)
import PythonSupport
#endif

@main
struct iDiscordPYApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = py.shared
            ContentView()
        }
    }
}

class py {
    // Singleton decleration
    static let shared = py()
    let discord: PythonObject
    let sys: PythonObject
    let os: PythonObject
    private init() {
        #if os(iOS)
            PythonSupport.initialize()
        #else
            PythonLibrary.useVersion(3)
        #endif
        sys = Python.import("sys")
        os = Python.import("os")
        #if os(iOS)
            sys.path.append(Bundle.main.bundlePath)
        #else
            sys.path.append(Bundle.main.bundlePath + "/Contents/Resources")
        #endif
        discord = Python.import("discord")
        print("Finished 'init', discord.py loaded.")
        print(Python.version)
        print(sys.path)
    }
}
