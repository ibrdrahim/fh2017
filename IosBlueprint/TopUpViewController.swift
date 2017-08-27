//
//  TopUpViewController.swift
//  IosBlueprint
//
//  Created by Ibrahim Indosystem on 8/26/17.
//  Copyright © 2017 Indosytem. All rights reserved.
//

import UIKit

class TopUpViewController: UIViewController {
    
    var topUpMethod = "gopay"
    var namaUser = ""
    var saldo = ""
    
    @IBOutlet var gopayRadio: UIImageView!
    @IBOutlet var sakukuRadio: UIImageView!
    @IBOutlet var bcaRadio: UIImageView!
    
    @IBOutlet var userName: UILabel!
    @IBOutlet var balance: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        self.userName.text = namaUser
        self.balance.text = saldo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectTopUpOpt(_ sender: UIButton) {
        if sender.tag == 0 {
            bcaRadio.image = UIImage(named: "radio_off")
            sakukuRadio.image = UIImage(named: "radio_off")
            gopayRadio.image = UIImage(named: "radio_on")
            topUpMethod = "gopay"
        }else if sender.tag == 1{
            bcaRadio.image = UIImage(named: "radio_off")
            gopayRadio.image = UIImage(named: "radio_off")
            sakukuRadio.image = UIImage(named: "radio_on")
            topUpMethod = "sakuku"
        }else if sender.tag == 2{
            sakukuRadio.image = UIImage(named: "radio_off")
            gopayRadio.image = UIImage(named: "radio_off")
            bcaRadio.image = UIImage(named: "radio_on")
            topUpMethod = "bca"
        }
    }
    
    @IBAction func topupSubmit(_ sender: Any) {
        performSegue(withIdentifier: topUpMethod, sender: nil)
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
