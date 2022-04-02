//
//  LabelStyle.swift
//  Swift Easy Style
//
//  Created by Yildirim Atcioglu on 02.04.22.
//

import UIKit

extension Style.Attribute {
    enum Label: Hashable {
        case font(UIFont)
        case text(Text)
        case numberOfLines(Int)

        enum Text: Hashable {
            case color(UIColor?)
            case alignment(NSTextAlignment)
            
            static func == (lhs: Text, rhs: Text) -> Bool {
                return lhs.hashValue == rhs.hashValue
            }
        }
        
        func hash(into hasher: inout Hasher) {
            switch self {
            case .font:
                hasher.combine(0)
            case .text(let text):
                hasher.combine(1)
                hasher.combine(text.hashValue)
            case .numberOfLines:
                hasher.combine(2)
            }
        }
        
        static func == (lhs: Label, rhs: Label) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
        
        func apply(to label: UILabel) {
            switch self {
            case .font(let value):
                label.font = value
            case .text(.color(let color)):
                label.textColor = color
            case .text(.alignment(let alignment)):
                label.textAlignment = alignment
            case .numberOfLines(let value):
                label.numberOfLines = value
            }
        }
    }
}

extension Style {
    class Label: View {
        @discardableResult
        func font(_ font: UIFont) -> Self {
            return insert(.label(.font(font)))
        }
        
        @discardableResult
        func number(ofLines numberOfLines: Int) -> Self {
            return insert(.label(.numberOfLines(numberOfLines)))
        }
        
        @discardableResult
        func text(color: UIColor?) -> Self {
            return insert(.label(.text(.color(color))))
        }
        
        @discardableResult
        func text(alignment: NSTextAlignment) -> Self {
            return insert(.label(.text(.alignment(alignment))))
        }
    }
}

extension UILabel {
    func apply(style: Style.Label?) {
        super.apply(style: style)
        
        for case let Style.Attribute.label(attribute) in style?.attributes ?? [] {
            attribute.apply(to: self)
        }
    }
}
