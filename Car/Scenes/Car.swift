//
//  Car.swift
//  Car
//
//  Created by macbook air on 01/03/2019.
//  Copyright © 2019 Lytkin Artem. All rights reserved.
//

import UIKit

class Car: UIView {
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        let arrowImage = UIImageView(image: UIImage(named: "arrow"))
        self.addSubview(arrowImage)
        
        arrowImage.frame = self.frame
    }
}
