//
//  DrawingView.swift
//  Angles
//
//  Created by Petru Lutenco on 18.05.2022.
//

import Foundation
import UIKit

class DrawingView : UIView {
    
    var letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var points: [CGPoint] = []
    var segments: [SegmentResultModel] = []
    
    override func awakeFromNib() {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(onTap))
        self.addGestureRecognizer(recognizer)
    }
    
    func clear() {
        points = []
        segments = []
        setNeedsDisplay()
    }
    
    @objc func onTap(recognizer: UIGestureRecognizer) {
        let location = recognizer.location(in: self)
        points.append(location)
        setNeedsDisplay()
    }
    
    private func drawCalculatedSegments() {
        for segmentResult in segments {
            let c = UIGraphicsGetCurrentContext()
            c?.move(to: segmentResult.segment.head)
            c?.addLine(to: segmentResult.segment.tail)
            
            if segmentResult.hasClosestInclination {
                c?.setStrokeColor(UIColor.red.cgColor)
                c?.setLineWidth(7)
                c?.strokePath()
                c?.fillPath()
                c?.closePath()
            }
            else {
                c?.setStrokeColor(UIColor.black.cgColor)
                c?.setLineWidth(3)
                c?.strokePath()
                c?.fillPath()
                c?.closePath()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(rect)
        
        if !segments.isEmpty {
            drawCalculatedSegments()
            return
        }
        
        let path = UIBezierPath()
        
        let pointsCopy = points
        
        for point in pointsCopy {
            if point == points.first {
                path.move(to: point)
            }
            
            if point == points.last,
               points.count > 1,
               CGRect(origin: points.first!, size: .init(width: 10, height: 10)).offsetBy(dx: -5, dy: -5).contains(point) {
                points.removeLast()
                path.close()
                break
            }
            
            path.addLine(to: point)
        }
        
        for (index, point) in points.enumerated() {
            let font = UIFont.systemFont(ofSize: 30)
            let string = NSAttributedString(string: letters[index], attributes: [NSAttributedString.Key.font: font])
            string.draw(at: (point.offsetBy(dx: -10, dy: -50)))
            context?.addRect(.init(origin: point, size: .init(width: 10, height: 10)).offsetBy(dx: -5, dy: -5))
        }
        
        path.stroke()
    }
}
