//
//  TransferViewController.swift
//  IosBlueprint
//
//  Created by Ibrahim Indosystem on 8/26/17.
//  Copyright © 2017 Indosytem. All rights reserved.
//

import UIKit

class TransferViewController: UIViewController {

    var logoImage = ""
    var amount = ""
    var numericAmount :Float = 0
    
    @IBOutlet var transferAmount: UILabel!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var message: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        BCAService.transfer(amount: numericAmount){
            resp in
            
            print(resp)
        }
        
        self.logo.image = UIImage(named: logoImage)
        self.transferAmount.text = amount
        self.message.text = "Transaksi anda berhasil, segera dalam beberapa menit saldo \(logoImage.uppercased()) anda akan bertambah sebesar"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
