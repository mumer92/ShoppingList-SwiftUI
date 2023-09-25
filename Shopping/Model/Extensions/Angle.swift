//
//  Angle.swift
//  ShoppingApp
//
//  Created by MuhammadUmer on 29/7/21.
//

import SwiftUI

extension Angle {
    init(offset: Double, ratio: Double) {
        self = .degrees(360 * offset - 90 + 360 * ratio)
    }
}
