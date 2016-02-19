//
//  SignUP.swift
//  MRam
//
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpVC:UIViewController,UITextFieldDelegate
{
    
    @IBOutlet weak var m_FacebookButton: UIButton!
    @IBOutlet weak var m_ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var m_PasswordTxtFd: UITextField!
    @IBOutlet weak var m_EmailTxtFd: UITextField!
    @IBOutlet weak var m_NameTxtFd: UITextField!
    
    var  utilityClassObj = Utility()
    var userInfo = User()
    
    //MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        m_ActivityIndicator.hidden = true
        
        m_FacebookButton.layer.cornerRadius = 30
        m_FacebookButton.layer.borderWidth = 2
        m_FacebookButton.layer.borderColor = UIColor(red: 54.0/255.0, green: 101.0/255.0, blue: 225.0/255.0, alpha: 1.0).CGColor
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    //MARK: -  Textfield delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.view.endEditing(true);
        if m_NameTxtFd == textField
        {
            m_EmailTxtFd.becomeFirstResponder()
        }
        else if m_EmailTxtFd == textField
        {
            m_PasswordTxtFd.becomeFirstResponder()
        }
        
        if m_PasswordTxtFd == textField
        {
            signUpValidation()
        }
        return false;
    }
    
    //MARK: - Additinal methods
    
    func signUpValidation()
    {
        if m_NameTxtFd.text!.isEmptyOrWhitespace()
        {
            utilityClassObj.showAlertMessage("Name field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if m_NameTxtFd.attributedText?.length < 6 || m_NameTxtFd.attributedText?.length > 20
        {
            utilityClassObj.showAlertMessage("Kindly enter the name with a minimum 6 characters and maximum of 20 characters and try again", alertTitle: "")
        }
        else if m_EmailTxtFd.text!.isEmpty
        {
            utilityClassObj.showAlertMessage("Email field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if !(utilityClassObj.validateEmail(m_EmailTxtFd.text!))
        {
            utilityClassObj.showAlertMessage("You have entered an invalid email address. Kindly try again.", alertTitle: "")
        }
        else if m_PasswordTxtFd.text!.isEmptyOrWhitespace()
        {
            utilityClassObj.showAlertMessage("Password field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if m_PasswordTxtFd.attributedText?.length < 6 ||  m_PasswordTxtFd.attributedText?.length > 12
        {
            utilityClassObj.showAlertMessage("Kindly enter the password with a minimum of 6 characters and maximum of 12 characters and try again", alertTitle: "")
        }
        else
        {
            m_ActivityIndicator.hidden = false
            m_ActivityIndicator.startAnimating()
            utilityClassObj.delay(0.2, closure:signUpApi)
        }
    }
    
    func signUpApi()
    {
        let inputJson = ["client_id": KCLIENTID,"email" : m_EmailTxtFd.text! as String, "password" : m_PasswordTxtFd.text! as String , "connection" : "Username-Password-Authentication" ]
        
        Alamofire.request(.POST, KSIGNUPURL, parameters: inputJson)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                
                self.m_ActivityIndicator.hidden = true
                self.m_ActivityIndicator.stopAnimating()
                
                switch response.result
                {
                case .Success:
                    if let value = response.result.value
                    {
                        let json = JSON(value)
                        
                        if !(json["description"].stringValue.isEmpty)
                        {
                            self.utilityClassObj.showAlertMessage(json["description"].stringValue, alertTitle: "")
                        }
                        else if !(json["error"].stringValue.isEmpty)
                        {
                            self.utilityClassObj.showAlertMessage(json["description"].stringValue, alertTitle: "")
                        }
                        else
                        {
                            self.userInfo.userName = json["email"].stringValue
                            self.userInfo.id = json["_id"].stringValue
                            self.userInfo.email = json["email"].stringValue
                            
                            let productsVC = self.storyboard?.instantiateViewControllerWithIdentifier("ProductsVC") as! ProductsVC
                            let navCont:UINavigationController = UINavigationController(rootViewController: productsVC)
                            UIApplication.sharedApplication().keyWindow?.rootViewController = navCont
                        }
                    }
                case .Failure:
                    self.utilityClassObj.showAlertMessage("Unable to connect with the server", alertTitle: "")
                }
        }
    }
    
    //MARK: - IBAction methods
    
    @IBAction func act_SignUp(sender: AnyObject)
    {
        signUpValidation()
    }
    
    @IBAction func act_Facebook(sender: AnyObject)
    {
        utilityClassObj.showAlertMessage("Not part of this build", alertTitle: "")
    }
    
    @IBAction func act_Back(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
