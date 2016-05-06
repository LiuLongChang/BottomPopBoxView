//
//  PopView.swift
//  BottomPopBoxView
//
//  Created by langyue on 16/5/6.
//  Copyright © 2016年 langyue. All rights reserved.
//

import UIKit


let SelectBtnWidth : CGFloat = 60


func RGBColor(Red : CGFloat,Green: CGFloat,Blue: CGFloat)->UIColor {
    return UIColor.init(red: Red/255.0, green: Green/255.0, blue: Blue/255.0, alpha: 1.0)
}






protocol  PopViewDelegate{
    
    func selectedIndex(index:NSInteger)->Void
    
}



class SelectBtnView: UIButton {
    
    convenience init(frame: CGRect,iconImageName:NSString,title:NSString) {
        self.init(frame:frame)
        
        let iconImageView = UIImageView(frame:CGRectMake(10, 5, 40, 40))
        iconImageView.image = UIImage(named: iconImageName as String)
        self.addSubview(iconImageView)
        
        let label = UILabel(frame: CGRectMake(0,CGRectGetMaxX(iconImageView.frame)+5,self.frame.size.width,15))
        label.text = title as String
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.lightGrayColor()
        self.addSubview(label)
        
    }
}









class PopView: UIView,UIScrollViewDelegate {
    
    
    
    var pageControl : UIPageControl!
    
    
    var delegate : PopViewDelegate!
    var bgView : UIView!
    
    
    
    var itemBtn : UIButton!
    
    
    
    convenience init(frame: CGRect,SourceArray array:NSArray,IconArray iconArray:NSArray) {
        self.init(frame:frame)
        self.createPopView(frame, array: array, iconArray: iconArray)
    }
    
    
    
    
    func createPopView(frame:CGRect,array:NSArray,iconArray:NSArray){
        
        let titleLabel = UILabel(frame: CGRectMake(0, 0, self.frame.size.width, 30))
        titleLabel.text = "分享"
        titleLabel.backgroundColor = RGBColor(242, Green: 245, Blue: 247)
        titleLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(titleLabel)
        
        let count = array.count
        var page = 0
        page = count/6
        if count%6 != 0 {
            page = page + 1
        }
        
        var row = 1
        if count>3 {
            row = 2
        }
        
        let nH = 30 + 80*row
        let nFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, CGFloat(nH))
        self.frame = nFrame
        
        let bgScrollView = UIScrollView(frame: CGRectMake(0,30,self.frame.size.width,self.frame.size.height))
        bgScrollView.backgroundColor = RGBColor(242, Green: 245, Blue: 247)
        bgScrollView.pagingEnabled = true
        bgScrollView.delegate = self
        bgScrollView.bounces = false
        bgScrollView.contentSize = CGSizeMake(self.frame.size.width * CGFloat(page), self.frame.size.height)
        self.addSubview(bgScrollView)
        
        
        pageControl = UIPageControl(frame: CGRectMake((self.frame.size.width - 100)/2.0,self.frame.size.height-15,100,15))
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPage = 0
        pageControl.numberOfPages = page
        self.addSubview(pageControl)
        
        
        
        var horizeSpace : CGFloat = 0.0
        if count > 3 {
            horizeSpace = (self.frame.size.width - SelectBtnWidth*3)/4.0
        }else{
            horizeSpace = (self.frame.size.width - SelectBtnWidth*CGFloat(count))/(CGFloat(count)+1)
        }
        
        let verticalSpace:CGFloat = 10
        for p in 0...page-1 {
            
            let multView = UIView(frame:CGRectMake(bgScrollView.frame.size.width * CGFloat(p),0,bgScrollView.frame.size.width,bgScrollView.frame.size.height))
            print("%@",NSStringFromCGRect(multView.frame))
            
            multView.backgroundColor = RGBColor(242, Green: 245, Blue: 247)
            bgScrollView.addSubview(multView)
            
            
            for i in p*6...array.count-1 {
                
                if i < (p+1)*6 {
                    
                    let column = (i%6)%3
                    let r = (i%6)/3
                    
                    let btnView = SelectBtnView(frame: CGRectMake(horizeSpace + (horizeSpace + SelectBtnWidth) * CGFloat(column), 5 + (verticalSpace + 70) * CGFloat(r), 60, 70),iconImageName: iconArray[i] as! NSString, title: array[i] as! NSString)
                    
                    btnView.addTarget(self, action: #selector(PopView.selectItem(_:)), forControlEvents: .TouchUpInside)
                    btnView.tag = i
                    print("%@",NSStringFromCGRect(btnView.frame))
                    btnView.backgroundColor = RGBColor(242, Green: 245, Blue: 247)
                    multView.addSubview(btnView)
                    
                }
                
            }
            
            
        }
        
    }
    
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/self.frame.size.width
        pageControl.currentPage = Int(page)
        
    }
    
    
    
    func selectItem(btn:UIButton){
        if (self.delegate != nil) {
            self.actionViewDismiss()
            self.delegate!.selectedIndex(btn.tag)
        }
    }
    
    
    
    
    
    
    
    func actionViewShow(){
        
        
        let delegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        bgView = UIView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height))
        bgView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        delegate.window!.addSubview(bgView)
        
        
        let tap = UITapGestureRecognizer(target: self,action:#selector(PopView.tapBgViewClick(_:)))
        tap.numberOfTapsRequired = 1
        bgView.userInteractionEnabled = true
        bgView.addGestureRecognizer(tap)
        delegate.window?.addSubview(self)
        
        
        UIView.animateWithDuration(0.358/2, animations: {
            
            self.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height)
            
            }) { (finished) in
               
        }
        
        
    }
    
    
    func tapBgViewClick(tap:UITapGestureRecognizer){
        
        self.actionViewDismiss()
        
    }
    
    
    func actionViewDismiss(){
        
        let delegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.window?.backgroundColor = UIColor.whiteColor()
        UIView.animateWithDuration(0.358/2, animations: {
            
            self.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height, self.frame.size.width, self.frame.size.height)
            
        }) { (finished) in
            self.bgView.removeFromSuperview()
        }
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    
}
