//
//  LimitInputVC.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

protocol LimitInputViewProtocol{
    func clickBack()
}

extension LimitInputVC: LimitInputViewProtocol{
    func clickBack(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

class LimitInputVC: UIViewController {

    var limitInput:LimitInputView?
    var initVCDate:String?
    var text:String = ""
    var placehoder:String = "记录花销"
    var keyboardIsShow:Bool = false
    var completeInput:completeRespond?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LimitInputVC.keyboardWillShow(_:)),
                                                         name: UIKeyboardWillShowNotification,
                                                         object:self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LimitInputVC.keyboardWillHide(_:)),
                                                         name: UIKeyboardWillHideNotification,
                                                         object: self.view.window)
        setup()

    
    }
    
    func keyboardWillShow(notification:NSNotification){
        if keyboardIsShow == true {
            return
        }
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            var frame = limitInput?.characterNum?.frame
            frame?.origin.y = (frame?.origin.y)! - keyboardSize.height
            limitInput?.characterNum?.frame = frame!
        }
        keyboardIsShow = true
    }
    func keyboardWillHide(notification:NSNotification){
        if keyboardIsShow == false{
            return
        }
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            var frame = limitInput?.characterNum?.frame
            frame?.origin.y = (frame?.origin.y)! + keyboardSize.height
            limitInput?.characterNum?.frame = frame!
        }
        keyboardIsShow = false
    }
    
    private func setup(){
        let limitInput = LimitInputView(frame: self.view.frame)
        limitInput.delegate = self
        limitInput.initViewDate = initVCDate
        limitInput.placehoder = placehoder
        if text != ""{
            limitInput.textInput?.text = text
        }
        limitInput.completeInput = self.completeInput
        self.limitInput = limitInput
        self.view.addSubview(limitInput)
    }

}
