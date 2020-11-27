//
//  HeaderView.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 11/27/20.
//

import UIKit

public protocol HeaderViewDelegate{
    func onMenuBtnClick(isMenu : Bool)
}
class HeaderView: UIView {
    var delegate : HeaderViewDelegate?
    var view: UIView!
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        setupView()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
        setupView()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.view = view
    }
    
    private func setupView(){
        self.view.bounceAnimationView()
    }
    
    @IBAction func onClickMenu(_ sender : UIButton){
        sender.bounceAnimationView()
        delegate?.onMenuBtnClick(isMenu: true)
    }
    
}
