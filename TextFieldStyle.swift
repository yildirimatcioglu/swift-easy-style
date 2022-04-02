//
//  TextFieldStyle.swift
//  Swift Easy Style
//
//  Created by Yildirim Atcioglu on 02.04.22.
//

import UIKit

extension Style.Attribute {
    enum TextField: Hashable {
        case font(UIFont)
        case text(color: UIColor?)
        case left(view: UIView?, mode: UITextField.ViewMode)
        case right(view: UIView?, mode: UITextField.ViewMode)
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .font:
                hasher.combine(0)
            case .text:
                hasher.combine(1)
            case .left:
                hasher.combine(2)
            case .right:
                hasher.combine(3)
            }
        }
        
        static func == (lhs: TextField, rhs: TextField) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }

        func apply(to textField: UITextField) {
            switch self {
            case .font(let font):
                textField.font = font
            case .text(let color):
                textField.textColor = color
            case let .left(view, mode):
                textField.leftView = view
                textField.leftViewMode = mode
            case let .right(view, mode):
                textField.rightView = view
                textField.rightViewMode = mode
            }
        }
    }
}

extension Style {
    class TextField: Control {
        @discardableResult
        func font(_ font: UIFont) -> Self {
            return insert(.textField(.font(font)))
        }
        
        @discardableResult
        func text(color: UIColor?) -> Self {
            return insert(.textField(.text(color: color)))
        }
        
        @discardableResult
        func left(view: UIView?, mode: UITextField.ViewMode) -> Self {
            return insert(.textField(.left(view: view, mode: mode)))
        }
        
        @discardableResult
        func right(view: UIView?, mode: UITextField.ViewMode) -> Self {
            return insert(.textField(.right(view: view, mode: mode)))
        }
    }
}

extension UITextField {
    func apply(style: Style.TextField?) {
        super.apply(style: style)
        
        for case let Style.Attribute.textField(attribute) in style?.attributes ?? [] {
            attribute.apply(to: self)
        }
    }
}
