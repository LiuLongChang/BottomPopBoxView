//
//  ViewController.swift
//  BottomPopBoxView
//
//  Created by langyue on 16/5/6.
//  Copyright © 2016年 langyue. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PopViewDelegate {
    
    var bgView : UIView!
    
    
    var actionView : PopView =  PopView(frame: CGRectMake(0,UIScreen.mainScreen().bounds.size.height , UIScreen.mainScreen().bounds.size.width, 0), SourceArray:["QQ","QQ","QQ","QQ","QQ","QQ","QQ","QQ","QQ"], IconArray:["sns_icon_24","sns_icon_24","sns_icon_24","sns_icon_24","sns_icon_24","sns_icon_24","sns_icon_24","sns_icon_24","sns_icon_24"])
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.actionView.delegate = self
        
    }
    
    
    func selectedIndex(index:NSInteger)->Void{
        
        print("index = %ld",index)
        
    }
    
    
    
    @IBAction func btnAction(sender: UIButton) {
        
        
        
        self.actionView.actionViewShow()

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

