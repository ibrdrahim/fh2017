//
//  DashboardViewController.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/14/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import UIKit
import CoreLocation

class MobileNumber: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}

class Ewallet {
    let id:Int
    let name:String
    let imageString:String
    var isSelected:Bool
    
    init(id:Int,name:String,imageString:String,isActive:Bool? = false) {
        self.id = id
        self.name = name
        self.imageString = imageString
        self.isSelected = isActive!
    }
}

class DashboardViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate {
    @IBOutlet var ewalletCollection: UICollectionView!
    @IBOutlet var promoCollection: UICollectionView!
    
    @IBOutlet var avatar: CircularUIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var balance: UILabel!
    @IBOutlet var foreignBalance: UILabel!
    @IBOutlet var location: UILabel!
    
    @IBOutlet var rate: UILabel!
    @IBOutlet var rateStat: UIImageView!

    @IBOutlet var transferAmount: UITextField!
    @IBOutlet var mobileNumber: UITextField!
    
    @IBOutlet var transferBtn: UIButton!
    
    var countryCode = "INR"
    var symbol = ""
    var balanceNumeric :Float = 0
    var rtBuy :Float = 0
    
    let locationManager = CLLocationManager()
    
//    @IBOutlet weak var content: UITextView!
//    @IBOutlet weak var token: UILabel!
    
    var promoImage = ["promo1","promo2","promo3"]
    
    var ewaletOption = [
        Ewallet(id: 0, name: "paytm", imageString: "paytm",isActive : true),
        Ewallet(id: 1, name: "mobikwik", imageString: "mobikwik")
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        transferAmount.text = ""
        
        BCAService.getUserData(){
            resp in
            
            self.userName.text = resp.userName
            self.balance.text = "Rp. "+resp.balance.getCurrencyValue()
            self.balanceNumeric = (resp.balance as NSString).floatValue
            self.mobileNumber.text = resp.phone
            
            
            BCAService.getRates(){
                resp in
                
                for rt in resp {
                    
                    if self.countryCode == rt.currency {
                        
                        self.symbol = BCAService.getSymbolForCurrencyCode(code: rt.currency) ?? ""
                        
                        self.rate.text = self.symbol+rt.buy+"/Rp"
                        self.rtBuy = (rt.buy as NSString).floatValue
                        let fBalance = self.balanceNumeric / (rt.buy as NSString).floatValue
                        self.foreignBalance.text = self.symbol+" "+String(describing: fBalance)
                    }
                    
                }
                
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        let nibName = UINib(nibName: "EwalletCollectionViewCell", bundle: nil)
        ewalletCollection.register(nibName, forCellWithReuseIdentifier: "ewalletcell")
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {        
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
//        super.viewDidLoad()
//        let oauth2Token = AuthService.getToken()
//        
//        token.text = oauth2Token
//        
//        self.navigationItem.setHidesBackButton(true, animated: false)
//        
//        // Do any additional setup after loading the view.
//    }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == ewalletCollection {
            return ewaletOption.count
        }else{
            
            return promoImage.count
        }
        
    }
    
    func selectWallet(btn:UIButton){
        
        for (index,_) in ewaletOption.enumerated() {
            ewaletOption[index].isSelected = index == btn.tag
        }
        
        ewalletCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == ewalletCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ewalletcell", for: indexPath) as! EwalletCollectionViewCell
            
            cell.logo.image = UIImage(named: ewaletOption[indexPath.item].imageString)
            cell.radioBtn.image = ewaletOption[indexPath.item].isSelected ? UIImage(named: "radio_on") : UIImage(named: "radio_off")
            cell.selectBtn.tag = indexPath.row
            cell.selectBtn.addTarget(self, action: #selector(selectWallet), for: .touchUpInside)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "promocell", for: indexPath)
            cell.backgroundView = UIImageView(image: UIImage(named: promoImage[indexPath.item]))
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == ewalletCollection {
            
            return CGSize(width : (collectionView.frame.width * 1/2) - 10, height : collectionView.frame.height)
        }
        
        return CGSize(width : (collectionView.frame.width * 2/3) - 10, height : collectionView.frame.height)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transfer" {
            
            let vc : TransferViewController = segue.destination as! TransferViewController
            
            let fBalance = (self.transferAmount.text! as NSString).floatValue / self.rtBuy
            
            vc.amount = self.symbol+String(describing:fBalance).getCurrencyValue()
            
            vc.numericAmount = (self.transferAmount.text! as NSString).floatValue
            
            for (index,_) in ewaletOption.enumerated() {
                if ewaletOption[index].isSelected == true{
                    vc.logoImage = ewaletOption[index].imageString
                }
            }
            
        }else if segue.identifier == "topup" {
            
            let vc : TopUpViewController = segue.destination as! TopUpViewController
            
            vc.saldo = String(describing:self.balanceNumeric).getCurrencyValue()
            vc.namaUser = self.userName.text!
            
        }
    }
    
    @IBAction func transfer_tap(_ sender: Any) {
        
        if self.transferAmount.text == "" || self.transferAmount.text == "0" {
            ErrorReporting.showMessage(title: "Perhatian", msg: "Jumlah transfer harus di isi")
            return
        }
        
        if (self.transferAmount.text! as NSString).floatValue < 10000.0 {
            ErrorReporting.showMessage(title: "Perhatian", msg: "Minimum transfer 10.000")
            return
        }
        
        if (self.transferAmount.text! as NSString).floatValue > self.balanceNumeric {
            ErrorReporting.showMessage(title: "Perhatian", msg: "Jumlah saldo anda tidak mencukupi")
            return
        }
        
        if self.mobileNumber.text == "" {
            ErrorReporting.showMessage(title: "Perhatian", msg: "Nomor Telepon harus di isi")
            return
        }
        
        // Create the alert controller
        
        let fBalance = (self.transferAmount.text! as NSString).floatValue / self.rtBuy
        
        let alertController = UIAlertController(title: "Perhatian", message: "Anda akan melakukan transfer \n total transfer : Rp. \(self.transferAmount.text!)\n Rate : \(symbol)\(fBalance)", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Lanjut", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            if let field = alertController.textFields![0] as? UITextField {
                // store your data
                if field.text == "123456" {
                    self.performSegue(withIdentifier: "transfer", sender: nil)
                }else{
                    ErrorReporting.showMessage(title: "Perhatian", msg: "Pin yang anda masukan salah")
                }
            } else {
                // user did not fill field
            }
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Batal", style: UIAlertActionStyle.cancel)
        
        alertController.addTextField { (textField) in
            textField.keyboardType = UIKeyboardType.numberPad
            textField.isSecureTextEntry = true
            textField.placeholder = "Pin Number"
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
//    @IBAction func logoutBtn_tap(_ sender: AnyObject) {
//        
//        
//       // sample of logout process
//       let auth =  AuthService()
//        auth.signOut()
//        
//        self.navigationController?.popToRootViewController(animated: true)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
