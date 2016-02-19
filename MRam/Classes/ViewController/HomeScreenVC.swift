//
//  MRam
//
//

import UIKit

class HomeScreenVC: UIViewController {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.hidden = true
    }
}

