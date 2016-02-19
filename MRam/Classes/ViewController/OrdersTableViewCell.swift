//
//  OrdersTableViewCell.swift
//  MRam
//
//

import UIKit
import Stripe
import Alamofire
import SwiftyJSON

protocol OrderTableViewDelegate
{
    func hideSuccess()
    func showSucess()
}

class OrdersTableViewCell: UITableViewCell,UITextFieldDelegate
{
    
    var utilityObj = Utility()
    var stripCard = STPCard()
    var priceCost:String = ""
    var stripeToken:String = ""
    var cardDetails  = CardDetails()
    var orderVc:OrderVC = OrderVC()
    var delegate :OrderTableViewDelegate?
    
    @IBOutlet weak var m_ActivityLoader: UIActivityIndicatorView!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var address2TxtField: UITextField!
    @IBOutlet weak var address1TxtField: UITextField!
    @IBOutlet weak var monthTxtField: UITextField!
    @IBOutlet weak var cvvTxtField: UITextField!
    @IBOutlet weak var cardNumberTxtField: UITextField!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var streetTxtField: UITextField!
    @IBOutlet weak var commentTxtField: UITextField!
    @IBOutlet weak var countryTxtField: UITextField!
    @IBOutlet weak var zipCodeTxtField: UITextField!
    @IBOutlet weak var payButton: UIButton!
        {
        didSet {
            
            payButton.addTarget(self, action: "act_payButton:", forControlEvents: .TouchUpInside)
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        m_ActivityLoader.hidden = true
        m_ActivityLoader.stopAnimating()
        
        self.firstNameTxtField.text! = self.cardDetails.firstName
        self.lastNameTxtField.text! = self.cardDetails.lastName
        self.cardNumberTxtField.text! = self.cardDetails.cardNumber
        self.cvvTxtField.text! = self.cardDetails.cvv
        self.monthTxtField.text! = self.cardDetails.month
        self.yearTextField.text! = self.cardDetails.year
        self.address1TxtField.text! = self.cardDetails.address1
        self.address2TxtField.text! = self.cardDetails.address2
        self.cityTxtField.text! = self.cardDetails.city
        self.streetTxtField.text = self.cardDetails.street
        self.zipCodeTxtField.text! = self.cardDetails.zipcode
        self.countryTxtField.text! = self.cardDetails.country
        self.commentTxtField.text! = self.cardDetails.comment
    }
    
    func getValue(price:String)
    {
        priceCost = price
        payButton.setTitle("PAY $ " + price, forState: UIControlState.Normal)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        utilityObj.animateTextField(true, height:0, view: self.superview!)
        self.superview!.endEditing(true)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - TextField delegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool
    {
        if textField.keyboardType.rawValue == 4
        {
            let keyboardDoneButtonView = UIToolbar()
            keyboardDoneButtonView.sizeToFit()
            let item = UIBarButtonItem(title: "Done", style:.Plain, target: self, action: Selector("endEditingNow") )
            let toolbarButtons = [item]
            keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
            textField.inputAccessoryView = keyboardDoneButtonView
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        if textField == address1TxtField
        {
            utilityObj.animateTextField(true, height: 100, view: self.superview!)
        }
        else if textField == address2TxtField
        {
            utilityObj.animateTextField(true, height: 120, view: self.superview!)
        }
        else if textField == cityTxtField || textField == streetTxtField
        {
            utilityObj.animateTextField(true, height: 160, view: self.superview!)
        }
        else if textField == zipCodeTxtField || textField == countryTxtField
        {
            utilityObj.animateTextField(true, height: 240, view: self.superview!)
        }
        else if textField == commentTxtField
        {
            utilityObj.animateTextField(true, height: 300, view: self.superview!)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        utilityObj.animateTextField(true, height: 0, view: self.superview!)
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if firstNameTxtField == textField
        {
            lastNameTxtField.becomeFirstResponder()
        }
        else if lastNameTxtField == textField
        {
            cardNumberTxtField.becomeFirstResponder()
        }
        else if address1TxtField == textField
        {
            address2TxtField.becomeFirstResponder()
        }
        else if address2TxtField == textField
        {
            cityTxtField.becomeFirstResponder()
        }
        else if cityTxtField == textField
        {
            streetTxtField.becomeFirstResponder()
        }
        else if streetTxtField == textField
        {
            zipCodeTxtField.becomeFirstResponder()
        }
        else if zipCodeTxtField == textField
        {
            countryTxtField.becomeFirstResponder()
        }
        else if countryTxtField == textField
        {
            commentTxtField.becomeFirstResponder()
        }
        else if commentTxtField == textField
        {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        if textField == cardNumberTxtField
        {
            if string == " "
            {
                return false
            }
            if (range.length == 1 && string.isEmpty)
            {
                return true;
            }
            if range.location == 20
            {
                return false
            }
            var originalText = textField.text
            let replacementText = string.stringByReplacingOccurrencesOfString(" ", withString: "")
            
            let digits = NSCharacterSet.decimalDigitCharacterSet()
            for char in replacementText.unicodeScalars
            {
                if !digits.longCharacterIsMember(char.value)
                {
                    return false
                }
            }
            if (originalText?.characters.count)! % 5 == 0
            {
                originalText?.appendContentsOf(" ")
                textField.text = originalText
            }
        }
        else if textField == cvvTxtField
        {
            if range.location == 4
            {
                return false
            }
        }
        else if textField == monthTxtField || textField == yearTextField
        {
            if range.location == 2
            {
                return false
            }
        }
        return true
    }
    
    
    func endEditingNow()
    {
        self.superview?.endEditing(true)
    }
    
    
    func createToken()
    {
        let expMonth:UInt = UInt(monthTxtField.text!)!
        let expYear:UInt  = UInt(yearTextField.text!)!
        
        let card:STPCard = STPCard()
        card.number = cardNumberTxtField.text
        card.expMonth =  expMonth
        card.expYear = expYear
        card.cvc = cvvTxtField.text
        
        Stripe.createTokenWithCard(card)
            {
                token, error in
                if let token = token
                {
                    self.stripeToken = token.tokenId
                    self.payApi()
                }
                else
                {
                    self.utilityObj.showAlertMessage((error?.localizedDescription)!, alertTitle: "")
                    self.m_ActivityLoader.hidden = true
                    self.m_ActivityLoader.stopAnimating()
                }
        }
    }
    
    func act_payButton(sender:UIButton)
    {
        if firstNameTxtField.text!.isEmptyOrWhitespace()
        {
            self.utilityObj.showAlertMessage("First name field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if lastNameTxtField.text!.isEmptyOrWhitespace()
        {
            self.utilityObj.showAlertMessage("Last name field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if cardNumberTxtField.text!.isEmptyOrWhitespace()
        {
            self.utilityObj.showAlertMessage("Card number field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if cvvTxtField.text!.isEmptyOrWhitespace()
        {
            self.utilityObj.showAlertMessage("Cvv field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if monthTxtField.text!.isEmptyOrWhitespace()
        {
            self.utilityObj.showAlertMessage("Month field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if yearTextField.text!.isEmptyOrWhitespace()
        {
            self.utilityObj.showAlertMessage("Year field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if address1TxtField.text!.isEmptyOrWhitespace()
        {
            self.utilityObj.showAlertMessage("Address line 1 field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if cityTxtField.text!.isEmptyOrWhitespace()
        {
            self.utilityObj.showAlertMessage("City field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if streetTxtField.text!.isEmptyOrWhitespace()
        {
            self.utilityObj.showAlertMessage("Street field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if zipCodeTxtField.text!.isEmptyOrWhitespace()
        {
            self.utilityObj.showAlertMessage("Zip code field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if countryTxtField.text!.isEmptyOrWhitespace()
        {
            self.utilityObj.showAlertMessage("Country field can't be left blank. Kindly try again", alertTitle: "")
        }
        else
        {
            m_ActivityLoader.hidden = false
            m_ActivityLoader.startAnimating()
            utilityObj.delay(0.2, closure: createToken)
        }
    }
    
    func payApi()
    {
        let covertToInt:Float = Float(priceCost)!
        let covertPrice:Float = covertToInt * 100
        let productPrice:String = String(covertPrice)
        
        let inputJson = ["stripeToken":stripeToken,"amount":productPrice]
        Alamofire.request(.POST, KPAYURL , parameters: inputJson)
            .responseJSON { response in
                switch response.result
                {
                case .Success:
                    if let value = response.result.value
                    {
                        let json = JSON(value)
                        self.m_ActivityLoader.hidden = true
                        self.m_ActivityLoader.stopAnimating()
                        self.cardDetails.firstName = self.firstNameTxtField.text!
                        self.cardDetails.lastName = self.lastNameTxtField.text!
                        self.cardDetails.cardNumber = self.cardNumberTxtField.text!
                        self.cardDetails.cvv = self.cvvTxtField.text!
                        self.cardDetails.month = self.monthTxtField.text!
                        self.cardDetails.year = self.yearTextField.text!
                        self.cardDetails.address1 = self.address1TxtField.text!
                        self.cardDetails.address2 = self.address2TxtField.text!
                        self.cardDetails.city = self.cityTxtField.text!
                        self.cardDetails.zipcode = self.zipCodeTxtField.text!
                        self.cardDetails.country = self.countryTxtField.text!
                        self.cardDetails.comment = self.commentTxtField.text!
                        self.cardDetails.street = self.streetTxtField.text!
                        self.delegate?.showSucess()
                        self.utilityObj.delay(3.0, closure: (self.delegate?.hideSuccess)!)
                        
                        if !(json["description"].stringValue.isEmpty)
                        {
                            self.utilityObj.showAlertMessage(json["description"].stringValue, alertTitle: "")
                        }
                        else if !(json["error"].stringValue.isEmpty)
                        {
                            self.utilityObj.showAlertMessage(json["description"].stringValue, alertTitle: "")
                        }
                    }
                case .Failure:
                    self.utilityObj.showAlertMessage("Unable to connect with server", alertTitle: "")
                }
        }
    }
    
    
}
