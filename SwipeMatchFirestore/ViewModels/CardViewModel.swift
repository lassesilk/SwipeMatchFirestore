//
//  CardViewModel.swift
//  SwipeMatchFirestore
//
//  Created by Lasse Silkoset on 23/12/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

//View model is supposed to represent the state of our view
class CardViewModel {
    //Define the properties that our view will display/render out
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0 {
        didSet {
            let imageUrl = imageNames[imageIndex]
//            let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex, imageUrl)
        }
    }
    
    //Reactive programming
    var imageIndexObserver: ((Int, String?) -> ())?
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)    }
    
    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
}
    
}
