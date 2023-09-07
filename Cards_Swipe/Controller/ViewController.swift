//
//  ViewController.swift
//  Cards_Swipe
//
//  Created by Govind Sen on 07/09/23.
//

import UIKit

class SwipeCellModel {
    
}

class ViewController: UIViewController {
    
    var swipeableView: ZLSwipeableView!
    var swipeViewsArray: [SwipeCellModel] = []
    
    var viewIndex = 0
    var loadCardsFromXib = false
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeableView.nextView = {
            return self.nextCardView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        
        swipeableView = ZLSwipeableView()
        view.addSubview(swipeableView)
        
        swipeableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            swipeableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            swipeableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            swipeableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            swipeableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        swipeableView.allowedDirection = [Direction.Left, Direction.Right]
    }
    
    func nextCardView() -> UIView? {
        if viewIndex >= swipeViewsArray.count {
            viewIndex = 0
        }
        
        let cardView = CustomView(frame: swipeableView.bounds)
        cardView.delegate = self
        viewIndex += 1
        
        if loadCardsFromXib {
            let contentView = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first! as! UIView
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.backgroundColor = cardView.backgroundColor
            cardView.addSubview(contentView)
        }
        return cardView
    }
    
}

extension ViewController: CustomViewProtocol {
    func didTapNextButton() {
        swipeableView.swipeTopView(inDirection: .Left)
    }
    
    func didTapPreviousButton() {
        swipeableView.rewind()
    }
}

