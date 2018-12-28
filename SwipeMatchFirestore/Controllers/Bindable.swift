//
//  Bindable.swift
//  SwipeMatchFirestore
//
//  Created by Lasse Silkoset on 26/12/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) ->())?
    
    func bind(observer: @escaping (T?) ->()) {
        self.observer = observer
    }
}
