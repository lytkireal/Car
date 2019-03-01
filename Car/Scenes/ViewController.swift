//
//  ViewController.swift
//  Car
//
//  Created by macbook air on 01/03/2019.
//  Copyright © 2019 Lytkin Artem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var car: Car!
    let timeForOnePoint = 0.01
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        car = Car(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
        view.addSubview(car)
     
        car.center = view.center
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    
    @objc func tapGestureAction(_ gesture: UITapGestureRecognizer) {
        
        let tapCoordinate = gesture.location(in: view)
        let angle = calculateAngle(tapCoordinate: tapCoordinate, viewCoordinate: car.center)
        let tipTime = calculateTipTime(tapCoordinate: tapCoordinate, viewCoordinate: car.center)
        
        UIView.animate(withDuration: 0.6, animations: {
            self.car.transform = CGAffineTransform(rotationAngle: angle)
        }) { (completed) in
            guard completed else {return}
            UIView.animate(withDuration: tipTime, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.car.center = tapCoordinate
            })
        }
    }
    
    // MARK: - Helpers
    
    private func calculateTipTime(tapCoordinate: CGPoint, viewCoordinate: CGPoint) -> Double {
        let A = tapCoordinate
        let B = viewCoordinate
        let C = CGPoint(x: A.x, y: B.y)
        
        let BC = C.x - B.x
        let AC = B.y - A.y
        let AB = sqrt(BC * BC + AC * AC)
        
        let time = Double(AB) * timeForOnePoint
        
        return time
    }
    
    private func calculateAngle(tapCoordinate: CGPoint, viewCoordinate: CGPoint) -> CGFloat {
        let A = tapCoordinate
        let B = viewCoordinate
        let C = CGPoint(x: A.x, y: B.y)
        
        let BC = C.x - B.x
        let AC = B.y - A.y
        let AB = sqrt(BC * BC + AC * AC)
        
        let coefficient = BC > 0 ? 1.0 : -1.0
        
        let angle = acos(AC / AB) * CGFloat(coefficient)
        
        return angle
    }
}

