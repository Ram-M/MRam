//
//  Order.swift
//  MRam
//
//

import UIKit

class OrderVC: UIViewController,UITableViewDelegate,UITableViewDataSource,OrderTableViewDelegate
{
    
    
    @IBOutlet weak var m_SuccesImgVw: UIImageView!
    @IBOutlet weak var m_OrderTableView: UITableView!
    
    var priceDetails:String = ""
    var utilityClassObj = Utility()
    
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
    //MARK: - Tableview delegate methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("orderCell", forIndexPath: indexPath) as! OrdersTableViewCell
        cell.delegate = self
        cell.getValue(priceDetails)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 650
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 1
    }
    
    //MARK: - IBAction method
    @IBAction func act_Back(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK:- protocol method
    func hideSuccess()
    {
        m_SuccesImgVw.hidden = true
        let productsVC = self.storyboard?.instantiateViewControllerWithIdentifier("ProductsVC") as! ProductsVC
        let navCont:UINavigationController = UINavigationController(rootViewController: productsVC)
        UIApplication.sharedApplication().keyWindow?.rootViewController = navCont
    }
    
    func showSucess()
    {
        m_SuccesImgVw.hidden = false
    }
    
}
