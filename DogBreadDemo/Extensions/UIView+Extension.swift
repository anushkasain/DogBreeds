//
//  UIView+Extension.swift
//  DogBreadDemo
//
//  Created by Anushka Sain on 24/06/24.
//

import Foundation
import UIKit

extension UIView{
    
    func addBorder(corenrRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor){
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = corenrRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.masksToBounds = true
    }
}
