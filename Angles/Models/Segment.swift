//
//  Segment.swift
//  Angles
//
//  Created by Petru Lutenco on 18.05.2022.
//

import Foundation
import CoreGraphics

struct Segment: Equatable {
    let head: CGPoint
    let tail: CGPoint
    
    func reversed() -> Self {
        Segment(head: tail, tail: head)
    }
}

extension Segment {
    func angleWith(segment: Segment) -> Angle {
        let o = self.head
        let b = self.tail
        
        var a = CGPoint.zero
        
        let delta = self.head.minus(point: segment.head )
        
        a = segment.tail.plus(point: delta)

        return Angle(origin: o, firstArm: a, secondArm: b)
    }
}
