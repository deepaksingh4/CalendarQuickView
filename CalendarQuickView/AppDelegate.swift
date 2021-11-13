//
//  AppDelegate.swift
//  CalendarQuickView
//
//  Created by Michael Ellis on 10/29/21.
//

import Cocoa
import SwiftUI
import LaunchAtLogin

@main
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    
    /// Required window that is immediately closed and hidden
    var window: NSWindow!
    /// This is the Status Bar Item that is clicked to show the Calendar Quick View
    var statusBarItem: NSStatusItem?
    /// This NSMenu will show when the NSStatusItem is clicked, an alternative to NSPopover
    let menu = NSMenu()
    /// Holds the Calendar View, belongs to the NSMenu
    let menuItem = NSMenuItem()
    /// Displayed as the content of the NSMenuItem
    var hostingView: NSHostingView<StatusBarCalendar>?
    @AppStorage(AppStorageKeys.calendarSize) var calendarSize: CalendarSize = .small
    let eventKitManager = EventKitManager.shared
    /// This calculated var will provide a new CalendarView when the Calendar view is opened by user
    /// Making a new one will make sure the current date is set correctly on the calendar if the user doesn't restart their computer
    var newHostingView: NSHostingView<StatusBarCalendar> {
        let newView = NSHostingView(rootView: StatusBarCalendar())
        // Set the frame or it won't be shown
        var size: CGSize
        switch(self.calendarSize) {
        case .small:
            size = CGSize(width: 250, height: 300)
        case .medium:
            size = CGSize(width: 300, height: 360)
        case .large:
            size = CGSize(width: 400, height: 450)
        }
        // Alter size of window to accomodate displaying EKEvent info
        if eventKitManager.isEventFeatureEnabled {
            eventKitManager.checkCalendarAuthStatus() { hasAccess in
                if hasAccess {
                    self.eventKitManager.getEvents()
                    let eventCount = self.eventKitManager.events.count
                    let eventsToDisplay = Int(self.eventKitManager.numOfEventsToDisplay)
                    let eventDisplacement = CGFloat(eventCount > eventsToDisplay ? eventsToDisplay : eventCount) * 30
                    size.height += eventDisplacement
                }
            }
        }
        newView.frame = NSRect(x: 0, y: 0, width: size.width, height: size.height)
        return newView
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Set the view and status menu bar item
        self.hostingView = newHostingView
        menuItem.view = newHostingView
        menu.addItem(menuItem)
        // Allow this AppDelegate, conforming to NSMenuDelegate, to know when the Calendar Quick View button is clicked
        menu.delegate = self
        // Configure the status bar menu item
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.statusBarItem?.menu = menu
        self.statusBarItem?.button?.image = NSImage(systemSymbolName: "calendar", accessibilityDescription: "Quick View Calendar")
        StatusBarCalendar.openSettingsWindow()
    }
    
    func menuWillOpen(_ menu: NSMenu) {
        // Every time the menu bar view is opened it should show the current date
        // Example: User opens at 11:59PM, then re-opens at 12:01AM, two different dates
        menuItem.view = newHostingView
        if EventKitManager.shared.isAbleToAccessUserCalendar {
            
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func terminate() {
        NSApp.terminate(self)
    }
    
}

