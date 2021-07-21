//
//  NavigationBar.swift
//  astronomy
//
//  Created by dada on 2021/7/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    /**
    顯示alert dialog
    - parameter alertId:
    - parameter title:
    - parameter msg:
    - parameter okStr:
    - parameter cancelStr:
    */
    func showAlert(_ alertId:Int, title:String, msg:String, okStr:String, cancelStr:String){
        let alertController:UIAlertController=UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        if title != ""{
            let attributedTitle = NSAttributedString(string: title, attributes: [
                NSAttributedString.Key.font : FontStyle.sharedInstance.getFontSize20()//設定字的size
                ])
            alertController.setValue(attributedTitle, forKey: "attributedTitle")
        }
        
        if msg != ""{
            
            let attributedMessage = NSAttributedString(string: msg, attributes: [
                NSAttributedString.Key.font : FontStyle.sharedInstance.getFontSize18()//設定字的size
                ])
            
            alertController.setValue(attributedMessage, forKey: "attributedMessage")
        }
        
        if cancelStr != "" {
            let btnCancel = UIAlertAction(title: cancelStr, style: UIAlertAction.Style.cancel, handler: {
                (action: UIAlertAction!) -> Void in
                self.alertCancel(alertId)
            })
            alertController.addAction(btnCancel)
        }
        
        if okStr != "" {
            let btnOk = UIAlertAction(title: okStr, style: UIAlertAction.Style.default){
                (action: UIAlertAction!) -> Void in
                self.alertDo(alertId)
            }
            alertController.addAction(btnOk)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    /** alert點擊確認按鈕的callback */
    @objc func alertDo(_ alertId:Int){
        
    }
    
    /** alert點擊確認按鈕的callback */
    @objc func alertCancel(_ alertId:Int){
        
    }
    
    public enum NavigationItemPosition {
        case Left, Right
    }
    
    func setupNavigationTitle(_ title:String, textColor:UIColor = UIColor(rgb: 0x84827f)) {
        self.title = title

        var font: UIFont = .systemFont(ofSize: 20, weight: .light)
        if UIScreen.main.bounds.size.height == 568 { // se
            font = .systemFont(ofSize: 14, weight: .light)
        } else if UIScreen.main.bounds.size.height == 667 || UIDevice().name == "iPhone 11" { // i8 i11
            font = .systemFont(ofSize: 17, weight: .light)
        }

        self.navigationController?.navigationBar.titleTextAttributes = [
            .font: font,
            .foregroundColor: UIColor(rgb: 0x84827f),
            .kern: 1.0
        ]
    }
    
    /**
     設定navigation bar item
     
     - parameter act: item 點擊事件。
     - parameter position: item 位置，right or left。
     - parameter title: item 標題，沒有的話，傳入空字串。
     - parameter img: item 圖片檔名，沒有的話，傳入空字串。
     - parameter width: item 的寬。
     - parameter height: item 的長。
     */
    func addNavigationItem(_ act:Selector, position:NavigationItemPosition, title:String = "", img:String){
        let btn = UIButton(type: .system)
        
        if title != "" {//設定標題
            btn.setTitle(title, for: UIControl.State())
            btn.setTitleColor(UIColor.darkGray, for: UIControl.State())
        }
        
        if img != "" { //設定圖片
            btn.setBackgroundImage(UIImage(named: img), for: .normal)
        }
        
        btn.addTarget(self, action: act, for: UIControl.Event.touchUpInside)//加入點擊事件
        let item = UIBarButtonItem(customView: btn)
        var constantHeight: CGFloat = 22.0
        var constantWidth: CGFloat = 22.0
        
        if UIScreen.main.bounds.size.height == 568 { // se
            constantHeight = 20.0
            constantWidth = 20.0
        }
        
        item.customView?.heightAnchor.constraint(equalToConstant: constantHeight).isActive = true
        item.customView?.widthAnchor.constraint(equalToConstant: constantWidth).isActive = true
        
        //設定位置
        switch position {
        case .Left:
            self.navigationItem.leftBarButtonItem = item
            break
        case .Right:
            self.navigationItem.rightBarButtonItem = item
            break
        }
    }
    
    func matches(for regex: String, in text: String) -> Bool {
       do {
           let regex = try NSRegularExpression(pattern: regex)
           let nsString = text as NSString
           let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
           return !results.isEmpty
       } catch let error {
           print("invalid regex: \(error.localizedDescription)")
           return false
       }
    }
    
    func addNavBar(_ title: String = "", _ icon:String = "ic_back1", _ labelColor:Int = 0x84827f, _ isDissmiss:Bool = true){
        var x:CGFloat = 22
        var y:CGFloat = 33
        var width:CGFloat = 18
        var height:CGFloat = 18
        
        if UIScreen.main.bounds.size.height == 568 { // se
            
        } else if UIScreen.main.bounds.size.height == 667 { // i8
            
        } else if UIScreen.main.bounds.size.height == 736 { // i8 plus
            x = 26
            y = 42
            width = 20
            height = 20
        } else if UIDevice().name == "iPhone 11" { // i11
            x = 30
            y = 56
            width = 22
            height = 22
        } else if UIScreen.main.bounds.size.height == 812 { // i11 pro plus、 iX
            x = 30
            y = 56
            width = 20
            height = 20
        } else if UIDevice().name == "iPhone 11 Pro Max" { // i11 pro max
            x = 30
            y = 56
            width = 22
            height = 22
        }

        let btn = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
        btn.setImage(UIImage(named: icon)!.withRenderingMode(.alwaysOriginal), for: UIControl.State())
        if isDissmiss == true{
            btn.addTarget(self, action: #selector(BaseUIViewController.dismissView), for: UIControl.Event.touchUpInside)//加入點擊事件
        }else{
            btn.addTarget(self, action: #selector(BaseUIViewController.popView), for: UIControl.Event.touchUpInside)//加入點擊事件
        }
        btn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btn)
        btn.heightAnchor.constraint(equalToConstant: height).isActive = true
        btn.widthAnchor.constraint(equalToConstant: width).isActive = true
        btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: x).isActive = true
        btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: y).isActive = true
        
        if title != "" {
            let label = UILabel(frame: CGRect(x: 65, y: 14, width: 191, height: 20.5))
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            var font: UIFont = .systemFont(ofSize: 20)
            if UIScreen.main.bounds.size.height == 568 { // se
                font = .systemFont(ofSize: 14)
            } else if UIScreen.main.bounds.size.height == 667 || UIDevice().name == "iPhone 11" { // i8 i11
                font = .systemFont(ofSize: 17)
            }

            label.attributedText = NSAttributedString(string: title, attributes: [
                .font: font,
                .foregroundColor: UIColor(rgb: labelColor),
                .kern: 2.0
            ])

            self.view.addSubview(label)
            
            self.view.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 64).isActive = true
            label.leadingAnchor.constraint(equalTo: btn.trailingAnchor, constant: 21).isActive = true
            label.centerYAnchor.constraint(equalTo: btn.centerYAnchor).isActive = true
        }
    }
}

