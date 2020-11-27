//
//  CustomeEmailTF.swift
//  KodexCoreNetwork
//
//  Created by Jawad on 11/26/20.
//

import UIKit
public protocol CustomeEmailTFDelegate: class {
    func emailDidBeginEditing(_ textField: UITextField)
    func emailDidEndEditing(_ textField: UITextField)
    func textFieldDidChanged(replacementString string: String)
}

open class CustomEmailTF: UIView  {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tickImgWidth: NSLayoutConstraint!
    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var contentView: UIView!
    var view: UIView!
    var isEmailValid : Bool = false
    public var delegate : CustomeEmailTFDelegate?
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
    
    public func setError(){
        self.contentView.borderWidth = 1
        self.contentView.borderColor = ProjectColor.redColor
    }
    
    public func removeError(){
        self.contentView.borderWidth = 0
        self.contentView.borderColor = .clear
    }
    
    private func setupView(){
        self.textField.font = ProjectFont.PopinsRegular(16.0).font()
        self.textField.delegate = self
        self.textField.placeHolderColor = ProjectColor.placeholderColor
        self.textField.placeholder = "Email"
    }
}

extension CustomEmailTF : UITextFieldDelegate{
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.emailDidBeginEditing(textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.emailDidEndEditing(textField)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text! + string
        if text.isValidEmail(){
            self.tickImage.isHidden = false
            self.tickImgWidth.constant = 20
            self.isEmailValid = true
        }else{
            self.tickImage.isHidden = true
            self.tickImgWidth.constant = 0
            self.isEmailValid = false
        }
        
        if self.contentView.borderWidth == 1 {
            self.removeError()
        }
        delegate?.textFieldDidChanged(replacementString: text)
        return true
    }
}
