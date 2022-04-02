# swift-easy-style
This repo includes easy implementation of styling for UI elements with Swift Language

# Usage:


        let labelStyle = Style.Label()
            .font(.system(32))
            .numberOfLines(0)
            .text("Hello World!")
            
        titleLabel.apply(style: labelStyle)
        
       let buttonStyle = Style.Button()
            .font(.system(32)
            .title(color: .black, for: .normal)
            .title(color: .white, for: .highlighted)
            .title(color: .white, for: .selected)
            .background(color: .white)
            .border(color: .red)
            .border(width: 0.5)
            .corner(radius: 2)
