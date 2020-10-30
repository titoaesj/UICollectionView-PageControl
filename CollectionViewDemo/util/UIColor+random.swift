//
//  UIColor+random.swift
//  CollectionViewDemo
//
//  Created by titoaesj on 29/10/20.
//

import UIKit

extension UIColor {
    public class var random: UIColor {
        return UIColor(red: CGFloat(drand48()),
                       green: CGFloat(drand48()),
                       blue: CGFloat(drand48()), alpha: 1.0)
    }
}
