//
//  LayerStyle.swift
//  Swift Easy Style
//
//  Created by Yildirim Atcioglu on 02.04.22.
//

import UIKit

extension Style.Attribute {
    enum Layer: Hashable {
        case corner(radius: CGFloat)
        case border(Border)
        case masksToBounds(Bool)

        enum Border: Hashable {
            case color(UIColor?)
            case width(CGFloat)
            
            func hash(into hasher: inout Hasher) {
                switch self {
                case .color:
                    hasher.combine(0)
                case .width:
                    hasher.combine(1)
                }
            }
            
            static func == (lhs: Border, rhs: Border) -> Bool {
                return lhs.hashValue == rhs.hashValue
            }
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .corner:
                hasher.combine(0)
            case .border(let border):
                hasher.combine(1)
                hasher.combine(border.hashValue)
            case .masksToBounds:
                hasher.combine(2)
            }
        }
        
        static func == (lhs: Layer, rhs: Layer) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
        
        func apply(to layer: CALayer) {
            switch self {
            case .corner(let radius):
                layer.cornerRadius = radius
            case .border(.color(let color)):
                layer.borderColor = color?.cgColor
            case .border(.width(let width)):
                layer.borderWidth = width
            case .masksToBounds(let value):
                layer.masksToBounds = value
            }
        }
    }
}

extension Style {
    class Layer: Style {
        @discardableResult
        func corner(radius: CGFloat) -> Self {
            return insert(.layer(.corner(radius: radius)))
        }
        
        @discardableResult
        func border(color: UIColor?) -> Self {
            return insert(.layer(.border(.color(color))))
        }
        
        @discardableResult
        func border(width: CGFloat) -> Self {
            return insert(.layer(.border(.width(width))))
        }
        
        @discardableResult
        func masksToBounds(_ value: Bool) -> Self {
            return insert(.layer(.masksToBounds(value)))
        }
    }
}

extension CALayer {
    func apply(style: Style.Layer?) {
        for case let Style.Attribute.layer(attribute) in style?.attributes ?? [] {
            attribute.apply(to: self)
        }
    }
}
