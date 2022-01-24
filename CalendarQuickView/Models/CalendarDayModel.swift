//
//  CalendarDayModel.swift
//  CalendarQuickView
//
//  Created by Deepak on 23/01/22.
//

import Foundation
import SwiftUI

internal struct CalendarDayModel: Identifiable{
    
let id = UUID()
let date: Date
let fontSize: Font
let cellSize: CGFloat
let dayShape: DayDisplayShape
let month: Date
}
