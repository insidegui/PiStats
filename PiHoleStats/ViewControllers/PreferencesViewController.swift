//
//  PreferencesViewController.swift
//  PiHoleStats
//
//  Created by Fernando Bunn on 22/05/2020.
//  Copyright © 2020 Fernando Bunn. All rights reserved.
//

import Cocoa
import Preferences
import SwiftUI

/*
 I've decided to use this third party library (Preferences)
 because there's an annoying bug with SwiftUI TabBar + List
 that breaks the rendering and state of the selected item
 More info here:
 https://twitter.com/fcbunn/status/1269301540923363333?s=21
 */

class PreferencesViewController {
    let piholeListProvider: PiholeListProvider
    let preferences: UserPreferences
    
    init(preferences: UserPreferences, piholeListProvider: PiholeListProvider) {
        self.preferences = preferences
        self.piholeListProvider = piholeListProvider
    }
    
    lazy var preferencesWindowController = PreferencesWindowController(
        panes: [
            Preferences.Pane(
                identifier: Preferences.PaneIdentifier(rawValue: "piholes"),
                title: "Pi-holes",
                toolbarIcon: NSImage(named: NSImage.userAccountsName)!
            ) {
                PiholeConfigView(piholeListViewModel: PiholeListViewModel(piholeListProvider: self.piholeListProvider)).environmentObject(self.piholeListProvider)
            },
            
            Preferences.Pane(
                identifier: Preferences.PaneIdentifier(rawValue: "preferences"),
                title: "Preferences",
                toolbarIcon: NSImage(named: NSImage.preferencesGeneralName)!
            ) {
                PreferencesView().environmentObject(self.preferences)
            },
            
            Preferences.Pane(
                identifier: Preferences.PaneIdentifier(rawValue: "about"),
                title: "About",
                toolbarIcon: NSImage(named: NSImage.applicationIconName)!
            ) {
                AboutView()
            }
        ], animated: false
    )
    
    func show() {
        preferencesWindowController.show()
    }
}
