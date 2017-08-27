//
//  BCATopUpViewController.swift
//  IosBlueprint
//
//  Created by Ibrahim Indosystem on 8/26/17.
//  Copyright © 2017 Indosytem. All rights reserved.
//

import UIKit

class BCATopUpViewController: UIViewController {

    @IBOutlet var amount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bcaSuccess" {
            
            let vc : TopUpSuccessViewController = segue.destination as! TopUpSuccessViewController
            vc.amountString  = "Rp. "+self.amount.text!.getCurrencyValue()
            vc.amountNumeric = Float(self.amount.text!)!
        }
    }

    @IBAction func topUpSubmit(_ sender: Any) {
        
        if self.amount.text == "" || self.amount.text == "0" {
            ErrorReporting.showMessage(title: "Perhatian", msg: "Total Amount harus di isi")
            return
        }
        
        if (self.amount.text! as NSString).floatValue < 10000.0 {
            ErrorReporting.showMessage(title: "Perhatian", msg: "Minimum transfer 10.000")
            return
        }
        
        let alertController = UIAlertController(title: "Perhatian", message: "Anda akan melakukan top up sebesar Rp. \(self.amount.text!.getCurrencyValue())", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Lanjut", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            if let field = alertController.textFields![0] as? UITextField {
                // store your data
                if field.text == "123456" {
                    self.performSegue(withIdentifier: "bcaSuccess", sender: nil)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
