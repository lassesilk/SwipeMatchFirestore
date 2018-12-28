//
//  CustomTextField.swift
//  SwipeMatchFirestore
//
//  Created by Lasse Silkoset on 25/12/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    let padding: CGFloat
    
    init(padding: CGFloat) {
        self.padding = padding
        super.init(frame: .zero)
        
        layer.cornerRadius = 25
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}