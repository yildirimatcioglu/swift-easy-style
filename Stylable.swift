//
//  Stylable.swift
//  Swift Easy Style
//
//  Created by Yildirim Atcioglu on 02.04.22.
//

import UIKit

class Style {
    enum Attribute: Hashable {
        case layer(Layer)
        case view(View)
        case label(Label)
        case button(Button)
        case imageView(ImageView)
        case textField(TextField)
    }
    
    init() {
        
    }
    
    init(with parent: Style) {
        for attr in parent.attributes {
            insert(attr)
        }
    }
    
    var attributes = Set<Attribute>()
    
    @discardableResult
    func insert(_ attribute: Attribute) -> Self {
        attributes.update(with: attribute)
        return self
    }
}
