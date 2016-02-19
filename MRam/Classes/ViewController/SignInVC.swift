//
//  SignIN.swift
//  MRam
//

import UIKit
import Alamofire
import SwiftyJSON


class SignInVC: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var m_ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var m_FacebookButton: UIButton!
    @IBOutlet weak var m_PasswordTxtFd: UITextField!
    @IBOutlet weak var m_EmailTxtFd: UITextField!
    
    var utilityClassObj = Utility()
    var userInfo = User()
    
    //MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.hidden = true
        
        m_ActivityIndicator.hidden = true
        
        m_FacebookButton.layer.cornerRadius = 30
        m_FacebookButton.layer.borderWidth = 2
        m_FacebookButton.layer.borderColor = UIColor(red: 54.0/255.0, green: 101.0/255.0, blue: 225.0/255.0, alpha: 1.0).CGColor
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    //MARK: - TextField delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.view.endEditing(true);
        
        if m_EmailTxtFd == textField
        {
            m_PasswordTxtFd.becomeFirstResponder()
        }
        if m_PasswordTxtFd == textField
        {
            login()
        }
        return false
    }
    
    
    func login()
    {
        if m_EmailTxtFd.text!.isEmptyOrWhitespace()
        {
            utilityClassObj.showAlertMessage("Email field can't be left blank. Kindly try again", alertTitle: "")
        }
        else if !(utilityClassObj.validateEmail(m_EmailTxtFd.text!))
        {
            utilityClassObj.showAlertMessage("Kindly enter a valid email and try again", alertTitle: "")
        }
        else if m_PasswordTxtFd.text!.isEmptyOrWhitespace()
        {
            utilityClassObj.showAlertMessage("Password field can't be left blank. Kindly try again", alertTitle: "")
        }
        else
        {
            if !(utilityClassObj.validateEmail(m_EmailTxtFd.text!))
            {
                utilityClassObj.showAlertMessage("You have entered an invalid email address. Kindly try again.", alertTitle: "")
                m_PasswordTxtFd.becomeFirstResponder()
            }
            else
            {
                m_ActivityIndicator.hidden = false
                m_ActivityIndicator.startAnimating()
                utilityClassObj.delay(0.2, closure: loginApi)
            }
        }
    }
    
    func loginApi()
    {
        let inputJson = ["client_id": KCLIENTID ,"username" : m_EmailTxtFd.text! as String , "password" : m_PasswordTxtFd.text! as String , "connection" : "Username-Password-Authentication" ]
        Alamofire.request(.POST, KLOGINURL , parameters: inputJson)
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
                            self.utilityClassObj.showAlertMessage(json["error_description"].stringValue, alertTitle: "")
                        }
                        else if !(json["error"].stringValue.isEmpty)
                        {
                            self.utilityClassObj.showAlertMessage(json["error_description"].stringValue, alertTitle: "")
                        }
                        else
                        {
                            self.userInfo.userName = self.m_EmailTxtFd.text! as String
                            self.userInfo.email = self.m_EmailTxtFd.text! as String
                            self.userInfo.accessToken = json["access_token"].stringValue
                            
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
    
    @IBAction func act_SignIn(sender: AnyObject)
    {
        login()
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
