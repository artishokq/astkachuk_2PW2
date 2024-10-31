//
//  ColorModel.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 28.10.2024.
//

import UIKit

struct ColorModel {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    
    init(red: CGFloat = 1.0, green: CGFloat = 0.0, blue: CGFloat = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    // Рандомный цвет
    init(random: Bool) {
        self.red = CGFloat.random(in: 0...1)
        self.green = CGFloat.random(in: 0...1)
        self.blue = CGFloat.random(in: 0...1)
    }
    
    // Цвет по Hex-коду
    init?(hexString: String) {
        guard let color = UIColor(hexString: hexString) else { return nil }
        
        let ciColor = CIColor(color: color)
        self.red = ciColor.red
        self.green = ciColor.green
        self.blue = ciColor.blue
    }
    
    func getColor() -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
