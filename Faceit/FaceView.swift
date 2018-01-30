//
//  FaceView.swift
//  Faceit
//
//  Created by Bogdan Sasko on 1/28/18.
//  Copyright © 2018 Bogdan Sasko. All rights reserved.
//

import UIKit

class FaceView: UIView {
    let viewScale: CGFloat = 0.9
    var skullRadius: CGFloat {
      return min(bounds.size.width, bounds.size.height) / 2 * viewScale
    }
    
    var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    enum Eye {
        case Left
        case Right
    }
    
    func getEyePosition(_ eyeType: Eye, _ skullCenterPos: CGPoint) -> CGPoint {
        let eyeRadius = skullRadius / 2 - 10
        var eyePos = skullCenter;
        
        eyePos.y -= eyeRadius
    
        switch (eyeType) {
        case .Left:
            eyePos.x -= eyeRadius
            break
        case .Right:
            eyePos.x += eyeRadius
            break
        }
        return eyePos;
    }
    
    func getEyePath(eyeType: Eye, skullCenterPos: CGPoint) -> UIBezierPath {
        var eyePos = getEyePosition(eyeType, skullCenterPos)
        let eye = UIBezierPath(arcCenter: eyePos, radius: CGFloat(25), startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: false)
        eye.lineWidth = 4
        eye.close()
        
        UIColor.white.set()
        eye.fill()

        UIColor.black.set()
        
        eyePos.x += 10;
        eyePos.y -= 15;
        let inEye = UIBezierPath(arcCenter: eyePos, radius: CGFloat(7), startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
        UIColor.black.set()
        inEye.fill();
        
        return eye;
    }
    
    func getMouthPath(skullCenterPos: CGPoint) -> UIBezierPath {
        let mousePos = CGPoint(x: skullCenterPos.x, y: skullCenterPos.y + 30)
        let mouthObject = UIBezierPath(arcCenter: mousePos, radius: 60, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)
        mouthObject.lineWidth = 4
        mouthObject.close()
        
        let mouthColor = UIColor.init(red: CGFloat(124/255.0), green: CGFloat(36/255.0), blue: CGFloat(68/255.0), alpha: CGFloat(1.0))
        mouthColor.setFill()
        mouthObject.fill();

        let tonguePos = CGPoint(x: mousePos.x, y: mousePos.y)
        let tongueObject = UIBezierPath(arcCenter: tonguePos, radius: 25, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)
        let tongueColor = UIColor.init(red: CGFloat(241/255.0), green: CGFloat(192/255.0), blue: CGFloat(220/255.0), alpha: CGFloat(1.0))
        tongueColor.setFill()
        tongueObject.fill()
        
        UIColor.black.set()
        return mouthObject
    }
    
    override func draw(_ rect: CGRect) {
        
        let skull = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: CGFloat(2.0*Double.pi), clockwise: false)
        skull.lineWidth = 5.0
        UIColor.yellow.set()
        skull.fill()
        UIColor.black.set()
        skull.stroke()
        
        getEyePath(eyeType: Eye.Left, skullCenterPos: skullCenter).stroke()
        getEyePath(eyeType: Eye.Right, skullCenterPos: skullCenter).stroke()
        
        getMouthPath(skullCenterPos: skullCenter).stroke();
    }

}
