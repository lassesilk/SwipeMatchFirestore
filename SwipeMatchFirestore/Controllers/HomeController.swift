//
//  ViewController.swift
//  SwipeMatchFirestore
//
//  Created by Lasse Silkoset on 23/12/2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let buttonsStackView = HomeBottomControlsStackView()
    let cardsDeckView = UIView()
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
                User(name: "Glenn", age: 2, profession: "Katt", imageNames: ["UNADJUSTEDNONRAW_thumb_10a8", "UNADJUSTEDNONRAW_thumb_10b1", "UNADJUSTEDNONRAW_thumb_10f4"]),
                User(name: "Hartz", age: 28, profession: "Kjøpmann", imageNames: ["UNADJUSTEDNONRAW_thumb_ff5", "UNADJUSTEDNONRAW_thumb_1fc"]),
                Advertiser(title: "Bord Til Salgs", brandName: "Wye", posterPhotoName: "UNADJUSTEDNONRAW_thumb_119c")
                ] as [ProducesCardViewModel]
        let viewModels = producers.map({return $0.toCardViewModel() })
        return viewModels
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        setupLayout()
        setupDummyCards()
        
    }
    
    @objc func handleSettings() {
        let registrationController = RegistrationController()
        present(registrationController, animated: true)
    }
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            
            cardView.cardViewModel = cardVM
            
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
    
    
}


