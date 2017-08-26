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

//    @IBOutlet weak var content: UITextView!
//    @IBOutlet weak var token: UILabel!
    
    var ewaletOption = [
        Ewallet(id: 0, name: "paytm", imageString: "paytm"),
        Ewallet(id: 1, name: "mobikwik", imageString: "mobikwik")
    ]
    
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
        return ewaletOption.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ewalletcell", for: indexPath) as! EwalletCollectionViewCell
        
        cell.logo.image = UIImage(named: ewaletOption[indexPath.item].imageString)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width : (collectionView.frame.width / 2) - 10, height : collectionView.frame.height)
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
