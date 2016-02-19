//
//  Products.swift
//  MRam
//

import UIKit
import SwiftyJSON

class ProductsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UtilityDelegate
{
    
    var cardDetails  = CardDetails()
    var userInfo = User()
    var utilityObj = Utility()
    var productArr = [Products]()
    var selectedIndex:Int = 0
    
    @IBOutlet weak var m_ProductCollectionView: UICollectionView!
    
    //MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.hidden = true
        
        utilityObj.delegate = self
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.getProducts()
        m_ProductCollectionView.reloadData()
    }
    
    //MARK: - CollectionView delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return productArr.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = m_ProductCollectionView.dequeueReusableCellWithReuseIdentifier("ProductCell", forIndexPath: indexPath) as! ProductsCollectionViewCell
        cell.m_ProductsImgVw.image =  UIImage(named: productArr[indexPath.row].prod_url)
        cell.movieTitleLabel.text = productArr[indexPath.row].prod_title
        cell.priceLabel.text = "$" + productArr[indexPath.row].prod_cost
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let requiredWidth = (collectionView.bounds.size.width - 30)/2
        let targetSize = CGSize(width: requiredWidth, height: requiredWidth)
        return targetSize
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        selectedIndex = indexPath.item
        self.performSegueWithIdentifier("OrderVC", sender: indexPath)
    }
    
    func getProducts()
    {
        if let path = NSBundle.mainBundle().pathForResource("Products1", ofType: "json")
        {
            do
            {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null
                {
                    for (_,subJson):(String, JSON) in jsonObj["products"]
                    {
                        let teamUserDetails = Products(fromDict: subJson)
                        productArr.append(teamUserDetails)
                    }
                }
            }
            catch _ as NSError
            {
            }
        }
    }
    
    //MARK: - IBAction method
    @IBAction func act_Logout(sender: AnyObject)
    {
        utilityObj.showAlert("", message: "Are you sure you want to logout?", btnsText: ["Yes","No"], view: self)
    }
    
    //MARK: - Alert delegate method
    func AlertCompleted(title: String)
    {
        if title == "Yes"
        {
            let homeScreenVC = self.storyboard?.instantiateViewControllerWithIdentifier("HomeScreenVC") as! HomeScreenVC
            let appDomain = NSBundle.mainBundle().bundleIdentifier!
            NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
            let navCont:UINavigationController = UINavigationController(rootViewController: homeScreenVC)
            UIApplication.sharedApplication().keyWindow?.rootViewController = navCont
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let segueID = segue.identifier
        {
            switch segueID
            {
            case "OrderVC":
                let orderVC = segue.destinationViewController as! OrderVC
                orderVC.priceDetails = productArr[selectedIndex].prod_cost
            default:
                break
            }
        }
    }
    
}
