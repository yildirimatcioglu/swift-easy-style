//
//  ViewStyle.swift
//  Swift Easy Style
//
//  Created by Yildirim Atcioglu on 02.04.22.
//

import UIKit

extension Style.Attribute {
    enum View: Hashable {
        case background(color: UIColor?)
        case content(mode: UIView.ContentMode)
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .background:
                hasher.combine(0)
            case .content:
                hasher.combine(1)
            }
        }
        
        static func == (lhs: View, rhs: View) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }

        func apply(to view: UIView) {
            switch self {
            case .background(let color):
                view.backgroundColor = color
            case .content(let mode):
                view.contentMode = mode
            }
        }
    }
}

extension Style {
    class View: Layer {
        @discardableResult
        func background(color: UIColor?) -> Self {
            return insert(.view(.background(color: color)))
        }
        
        @discardableResult
        func content(mode: UIView.ContentMode) -> Self {
            return insert(.view(.content(mode: mode)))
        }
    }
}

extension UIView {
    func apply(style: Style.View?) {
        layer.apply(style: style)
        
        for case let Style.Attribute.view(attribute) in style?.attributes ?? [] {
            attribute.apply(to: self)
        }
    }
}
