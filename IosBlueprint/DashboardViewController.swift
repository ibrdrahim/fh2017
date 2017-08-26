//
//  DashboardViewController.swift
//  IosBlueprint
//
//  Created by ibrahim on 11/14/16.
//  Copyright © 2016 Indosytem. All rights reserved.
//

import UIKit

class Ewallet {
    let id:Int
    let name:String
    let imageString:String
    
    init(id:Int,name:String,imageString:String) {
        self.id = id
        self.name = name
        self.imageString = imageString
    }
}

class DashboardViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    @IBOutlet var ewalletCollection: UICollectionView!
    @IBOutlet var promoCollection: UICollectionView!

//    @IBOutlet weak var content: UITextView!
//    @IBOutlet weak var token: UILabel!
    
    var promoImage = ["promo1","promo2","promo3"]
    
    var ewaletOption = [
        Ewallet(id: 0, name: "paytm", imageString: "paytm"),
        Ewallet(id: 1, name: "mobikwik", imageString: "mobikwik")
    ]
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        
        let nibName = UINib(nibName: "EwalletCollectionViewCell", bundle: nil)
        ewalletCollection.register(nibName, forCellWithReuseIdentifier: "ewalletcell")
        
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == ewalletCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ewalletcell", for: indexPath) as! EwalletCollectionViewCell
            
            cell.logo.image = UIImage(named: ewaletOption[indexPath.item].imageString)
            
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
