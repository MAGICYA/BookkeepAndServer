//
//  FlagBtn.swift
//  Timi
//
//  Created by 田子瑶 on 16/8/30.
//  Copyright © 2016年 田子瑶. All rights reserved.
//

import UIKit

class FlagBtn: UIButton {
    
    private var flagImage:UIImageView = UIImageView()
    var showFlag:Bool{
        get{
            return !flagImage.hidden
        }
        set(newValue){
            flagImage.hidden = !newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFlag(frame)
    }
    private func setupFlag(frame:CGRect){
        let flagWidth = frame.width / 4
        let flagHeight = frame.height / 3
        let flagImage = UIImageView(frame: CGRectMake(10, 0, flagWidth, flagHeight))
        flagImage.image = UIImage(named: "menu_selected_icon")
        flagImage.hidden = true
        self.flagImage = flagImage
        self.addSubview(flagImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

