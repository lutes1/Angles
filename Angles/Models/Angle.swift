//
//  Angle.swift
//  Angles
//
//  Created by Petru Lutenco on 18.05.2022.
//

import Foundation
import CoreGraphics

struct Angle {
    let origin: CGPoint
    let firstArm: CGPoint
    let secondArm: CGPoint
    
    var value: CGFloat {
        get {
            origin.angleBetweenPoints(firstPoint: firstArm, secondPoint: secondArm) * 180 / .pi
        }
    }
}
