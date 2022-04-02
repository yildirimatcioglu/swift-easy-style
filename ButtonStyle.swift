//
//  ButtonStyle.swift
//  Swift Easy Style
//
//  Created by Yildirim Atcioglu on 02.04.22.
//

import UIKit

extension Style.Attribute {
    enum Button: Hashable {
        case font(UIFont)
        case title(color: UIColor?, state: UIControl.State)
        case image(image: UIImage?, state: UIControl.State)

        func hash(into hasher: inout Hasher) {
            switch self {
            case .font:
                hasher.combine(0)
            case .title:
                hasher.combine(1)
            case .image:
                hasher.combine(2)
            }
        }
        
        static func == (lhs: Button, rhs: Button) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
        
        func apply(to button: UIButton) {
            switch self {
            case .font(let value):
                button.titleLabel?.font = value
            case .title(let color, let state):
                button.setTitleColor(color, for: state)
            case .image(let image, let state):
                button.setImage(image, for: state)
            }
        }
    }
}

extension Style {
    class Button: Control {
        @discardableResult
        func font(_ font: UIFont) -> Self {
            return insert(.button(.font(font)))
        }
        
        @discardableResult
        func title(color: UIColor?, for state: UIControl.State) -> Self {
            return insert(.button(.title(color: color, state: state)))
        }
        
        @discardableResult
        func image(image: UIImage?, for state: UIControl.State) -> Self {
            return insert(.button(.image(image: image, state: state)))
        }
    }
}

extension UIButton {
    func apply(style: Style.Button?) {
        super.apply(style: style)
        
        for case let Style.Attribute.button(attribute) in style?.attributes ?? [] {
            attribute.apply(to: self)
        }
    }
}
