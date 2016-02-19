//
//  Utility.swift
//  GroupR
//
//

import UIKit

@objc protocol UtilityDelegate
{
    optional func AlertCompleted(title: String);
    optional func AlertCompleted(title: String ,tag:String);
    optional func ApiCallCompleted(result: NSDictionary, error: NSError?);
    optional func ApiCallImageUploadCompleted(result: NSDictionary);
    optional func ApiCallImageUploadFailed(error: NSError?);
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}
class Utility
{
    var delegate : UtilityDelegate?
    var str_LinkedInEmail:String!
    var str_LinkedInId:String!
    var str_LinkedInUserName:String!
    var str_LinkedInUserimage:String!
    
    init()
    {
        
    }
    
    // MARK: - Validate Email
    func validateEmail(emailstring:NSString)->Bool
    {
        let emailReg:NSString = "[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES%@", emailReg)
        var aRange:NSRange!
        if emailTest.evaluateWithObject(emailstring)
        {
            aRange = emailstring.rangeOfString(".", options:NSStringCompareOptions.BackwardsSearch , range: NSMakeRange(0, emailstring.length))
            let indexOfDot:Int = aRange.location as Int
            if aRange.location != NSNotFound
            {
                var topLevelDomain:NSString = emailstring.substringFromIndex(indexOfDot)
                topLevelDomain = topLevelDomain.lowercaseString
                var TLD:NSSet!
                TLD = NSSet(objects: ".aero", ".asia", ".biz", ".cat", ".com", ".coop", ".edu", ".gov", ".info", ".int", ".jobs", ".mil", ".mobi", ".museum", ".name", ".net", ".org", ".pro", ".tel", ".travel", ".ac", ".ad", ".ae", ".af", ".ag", ".ai", ".al", ".am", ".an", ".ao", ".aq", ".ar", ".as", ".at", ".au", ".aw", ".ax", ".az", ".ba", ".bb", ".bd", ".be", ".bf", ".bg", ".bh", ".bi", ".bj", ".bm", ".bn", ".bo", ".br", ".bs", ".bt", ".bv", ".bw", ".by", ".bz", ".ca", ".cc", ".cd", ".cf", ".cg", ".ch", ".ci", ".ck", ".cl", ".cm", ".cn", ".co", ".cr", ".cu", ".cv", ".cx", ".cy", ".cz", ".de", ".dj", ".dk", ".dm", ".do", ".dz", ".ec", ".ee", ".eg", ".er", ".es", ".et", ".eu", ".fi", ".fj", ".fk", ".fm", ".fo", ".fr", ".ga", ".gb", ".gd", ".ge", ".gf", ".gg", ".gh", ".gi", ".gl", ".gm", ".gn", ".gp", ".gq", ".gr", ".gs", ".gt", ".gu", ".gw", ".gy", ".hk", ".hm", ".hn", ".hr", ".ht", ".hu", ".id", ".ie", " No", ".il", ".im", ".in", ".io", ".iq", ".ir", ".is", ".it", ".je", ".jm", ".jo", ".jp", ".ke", ".kg", ".kh", ".ki", ".km", ".kn", ".kp", ".kr", ".kw", ".ky", ".kz", ".la", ".lb", ".lc", ".li", ".lk", ".lr", ".ls", ".lt", ".lu", ".lv", ".ly", ".ma", ".mc", ".md", ".me", ".mg", ".mh", ".mk", ".ml", ".mm", ".mn", ".mo", ".mp", ".mq", ".mr", ".ms", ".mt", ".mu", ".mv", ".mw", ".mx", ".my", ".mz", ".na", ".nc", ".ne", ".nf", ".ng", ".ni", ".nl", ".no", ".np", ".nr", ".nu", ".nz", ".om", ".pa", ".pe", ".pf", ".pg", ".ph", ".pk", ".pl", ".pm", ".pn", ".pr", ".ps", ".pt", ".pw", ".py", ".qa", ".re", ".ro", ".rs", ".ru", ".rw", ".sa", ".sb", ".sc", ".sd", ".se", ".sg", ".sh", ".si", ".sj", ".sk", ".sl", ".sm", ".sn", ".so", ".sr", ".st", ".su", ".sv", ".sy", ".sz", ".tc", ".td", ".tf", ".tg", ".th", ".tj", ".tk", ".tl", ".tm", ".tn", ".to", ".tp", ".tr", ".tt", ".tv", ".tw", ".tz", ".ua", ".ug", ".uk", ".us", ".uy", ".uz", ".va", ".vc", ".ve", ".vg", ".vi", ".vn", ".vu", ".wf", ".ws", ".ye", ".yt", ".za", ".zm", ".zw")
                
                if (topLevelDomain.length != 0) && (TLD.containsObject(topLevelDomain))
                {
                    return true
                    
                }
            }
        }
        return false
    }
    
    // MARK: - Show an alert message
    func showAlertMessage(message:String, alertTitle:String)
    {
        let alertMessage = UIAlertView(title:alertTitle, message:message, delegate: nil, cancelButtonTitle: "OK")
        alertMessage.show()
    }
    
    func showAlert(title: String, message: String,btnsText: [String], view: UIViewController)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        for(var i=0; i<btnsText.count; i++)
        {
            alert.addAction(UIAlertAction(title: btnsText[i], style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in self.delegate?.AlertCompleted!(alert.title!)}))
        }
        view.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String,btnsText: [String], view: UIViewController , tag:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.accessibilityLabel = tag
        for(var i=0; i<btnsText.count; i++)
        {
            alertController.addAction(UIAlertAction(title: btnsText[i], style: UIAlertActionStyle.Default, handler:
                {(alert: UIAlertAction!) in self.delegate?.AlertCompleted!(alert.title!,tag: alertController.accessibilityLabel!)}))
        }
        view.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - TextField Animation
    func animateTextField(up:Bool, height:CGFloat, view:UIView)
    {
        if up == true
        {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                view.frame = CGRectMake(view.frame.origin.x, -height, view.frame.width, view.frame.height)
            })
        }
        else
        {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                view.frame = CGRectMake(view.frame.origin.x, height, view.frame.width, view.frame.height)
            })
        }
        
    }
    
    
    func delay(delay:Double, closure:()->())
    {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func getStoryBoardName()->UIStoryboard
    {
        var str_XibName:NSString!
        
        str_XibName = NSString(format: "Main") as String
        let mainStoryBoard = UIStoryboard(name: str_XibName as String, bundle: NSBundle.mainBundle())
        
        return mainStoryBoard
    }
    
    
    class func listConstraints (var v:UIView?)
    {
        if v == nil
        {
            v = UIApplication.sharedApplication().keyWindow
        }
        for vv in v!.subviews 
        {
            let arr1 = vv.constraintsAffectingLayoutForAxis(.Horizontal)
            let arr2 = vv.constraintsAffectingLayoutForAxis(.Vertical)
            NSLog("\n\n%@\nH: %@\nV:%@", vv, arr1, arr2);
            if vv.subviews.count > 0
            {
                self.listConstraints(vv)
            }
        }
    }
}

extension CGRect
{
    var center : CGPoint
        {
            return CGPointMake(self.midX, self.midY)
    }
    
    func sizeByDelta(dw dw:CGFloat, dh:CGFloat) -> CGSize
    {
        return CGSizeMake(self.width + dw, self.height + dh)
    }
    
}

extension NSLayoutConstraint
{
    class func reportAmbiguity (var v:UIView?)
    {
        if v == nil {
            v = UIApplication.sharedApplication().keyWindow
        }
        for vv in v!.subviews 
        {
            if vv.subviews.count > 0 {
                self.reportAmbiguity(vv)
            }
        }
    }
}

extension String {
    
    func contains(find: String) -> Bool{
        return self.rangeOfString(find) != nil
    }
}

extension UILabel
{
    func setSizeFont (sizeFont: CGFloat)
    {
        self.font =  UIFont(name: self.font.fontName, size: sizeFont)
        self.sizeToFit()
    }
}

extension String {
    func isEmptyOrWhitespace() -> Bool {
        
        if(self.isEmpty) {
            return true
        }
        
        return (self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "")
    }
    
    
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}


