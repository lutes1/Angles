//
//  ViewController.swift
//  Angles
//
//  Created by Petru Lutenco on 17.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultTextField: UITextView!
    @IBOutlet weak var drawingView: DrawingView!

    @IBAction func clearAllPoints(_ sender: Any) {
        defer {
            resultTextField.textColor = .gray
            resultTextField.text = "Draw your polygon..."
        }
        
        drawingView.clear()
    }
    
    @IBAction func calculateAngles(_ sender: Any) {
        defer {
            resultTextField.textColor = .black
        }
        
        resultTextField.text = ""
        
        let points = drawingView.points
        
        guard points.count > 2 else {
            resultTextField.text = "Keep on adding more points..."
            return
        }
        
        var segments: [Segment] = .init()
        var angles: [Angle] = .init()
        
        // Create segments based on the points array
        for (index, point) in points.enumerated() {
            let nextPoint = points.last == point ? points.first : points[index + 1]
            let segment = Segment(head: point, tail: nextPoint!)
            segments.append(segment)
        }
        
        guard let firstSegment = segments.first else {
            return
        }
        
        // Create segments based on the points array
        for segment in segments.filter({ segment in segment != firstSegment }) {
            let angle = firstSegment.angleWith(segment: segment)
            let reversedAngle = firstSegment.angleWith(segment: segment.reversed())
            
            let smallestAngle = angle.value > reversedAngle.value ? reversedAngle: angle
            
            angles.append(smallestAngle)
            
            resultTextField.text.append("smallest angle is : \(smallestAngle.value)")
            resultTextField.text.append("\n")
        }
        
        var resultSegments: [SegmentResultModel] = []
        let smallestAngle = angles.min(by: { $0.value < $1.value })
        let indexOfSmallestAngle = angles.firstIndex(where: { $0.value == smallestAngle?.value })!
        
        for (index, segment) in segments.enumerated() {
            let segmentResult = SegmentResultModel(segment: segment, hasClosestInclination: index == indexOfSmallestAngle + 1)
            resultSegments.append(segmentResult)
        }

        drawingView.segments = resultSegments
        drawingView.setNeedsDisplay()
    }
}
