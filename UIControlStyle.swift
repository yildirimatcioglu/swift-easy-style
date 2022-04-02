//
//  UIControlStyle.swift
//  Swift Easy Style
//
//  Created by Yildirim Atcioglu on 02.04.22.
//

import UIKit

extension Style.Attribute {
    enum Control: Hashable {
        
    }
}

extension Style {
    class Control: View {
        
    }
}

extension UIControl {
    func apply(style: Style.Control?) {
        super.apply(style: style)
    }
}
