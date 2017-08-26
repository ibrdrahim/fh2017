//
//  ScrollingFormViewController.swift
//  Aditama
//
//  Created by ibrahim on 2/1/17.
//  Copyright © 2017 Indosytem. All rights reserved.
//

import UIKit

class ScrollingFormViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var activeFieldRect: CGRect?
    var keyboardRect: CGRect?
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView(){
        
        self.registerForKeyboardNotifications()
        
        registerView(mView: self.view)
        
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(self.view)
        
        self.view = scrollView
    }
    
    func registerView(mView:UIView){
        for view in mView.subviews {
            if view is NIBView {
                registerView(mView: view)
            }else if view is UITextView {
                let tv = view as! UITextView
                tv.delegate = self
            } else if view is UITextField {
                let tf = view as! UITextField
                tf.delegate = self
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.sizeToFit()
        scrollView.contentSize = scrollView.frame.size
        super.viewDidLayoutSubviews()
    }
    
    deinit {
        self.deregisterFromKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(ScrollingFormViewController.keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ScrollingFormViewController.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification)
    {
        let info : NSDictionary = notification.userInfo! as NSDictionary
        keyboardRect = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        adjustForKeyboard()
    }
    
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        keyboardRect = nil
        adjustForKeyboard()
    }
    
    func adjustForKeyboard() {
        if keyboardRect != nil && activeFieldRect != nil {
            scrollView.isScrollEnabled = true
            let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardRect!.size.height, 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            scrollView.scrollRectToVisible(activeFieldRect!, animated: true)
        } else {
            let contentInsets : UIEdgeInsets = UIEdgeInsets.zero
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            scrollView.isScrollEnabled = false
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewWillAppear(textView: textView)
        
        activeFieldRect = textView.frame
        adjustForKeyboard()
        
        textViewAppeared(textView: textView)
    }
    
    func textViewWillAppear(textView: UITextView){
        
    }
    
    func textViewAppeared(textView: UITextView){
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewWillDisappear(textView: textView)
        
        activeFieldRect = nil
        adjustForKeyboard()
        
        textViewDisappeared(textView: textView)
    }
    
    func textViewWillDisappear(textView: UITextView){
        
    }
    
    func textViewDisappeared(textView: UITextView){
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textFieldWillAppear(textField: textField)
        
        activeFieldRect = textField.frame
        adjustForKeyboard()
        
        textFieldAppeared(textField: textField)
    }
    
    func textFieldAppeared(textField: UITextField){
        
    }
    
    func textFieldWillAppear(textField: UITextField){
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textFieldWillDisappear(textField: textField)
        
        activeFieldRect = nil
        adjustForKeyboard()
        
        textFieldDisappeared(textField: textField)
    }
    
    func textFieldWillDisappear(textField: UITextField){
        
    }
    
    func textFieldDisappeared(textField: UITextField){
        
    }
}
