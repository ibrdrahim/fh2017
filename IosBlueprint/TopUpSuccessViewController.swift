//
//  TopUpSuccessViewController.swift
//  IosBlueprint
//
//  Created by Ibrahim Indosystem on 8/26/17.
//  Copyright © 2017 Indosytem. All rights reserved.
//

import UIKit

class TopUpSuccessViewController: UIViewController {
    
    var amountString = ""
    var amountNumeric :Float = 0.0
    @IBOutlet var amount: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
        BCAService.topup(amount: amountNumeric){
            resp in
            print(resp)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amount.text = amountString

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
