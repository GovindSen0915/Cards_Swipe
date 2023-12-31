//
//  NewView.swift
//  VC_Over_View
//
//  Created by Govind Sen on 07/09/23.
//
//


import Foundation
import UIKit

protocol CustomViewProtocol: AnyObject {
    func didTapNextButton()
    func didTapPreviousButton()
}

class CustomView: UIView {
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var outerView: UIView!
    
    weak var delegate: CustomViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
        self.outerView.layer.cornerRadius = 12
        self.outerView.layer.borderWidth = 1
        self.outerView.layer.borderColor = .init(genericCMYKCyan: 0, magenta: 0, yellow: 0, black: 1, alpha: 0)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: CustomView.self)
        if let viewToAdd = bundle.loadNibNamed("CustomView", owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    func setup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.cornerRadius = 12;
    }
    
    @IBAction func speakerButtonAction(_ sender: UIButton) {
        
    }
    
    @IBAction func previousButtonAction(_ sender: UIButton) {
        self.delegate?.didTapPreviousButton()
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        self.delegate?.didTapNextButton()
    }
    
}
