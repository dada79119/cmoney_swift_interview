//
//  RequestDetailViewController.swift
//  astronomy
//
//  Created by dada on 2021/7/20.
//

import Foundation
import UIKit

class RequestDetailViewController: BaseUIViewController {
    var data: AstronomyModel = AstronomyModel(description: "", copyright: "", title: "", url: "", apod_site: "", media_type: "", hdurl: "")
    
    func setUI() {
        for view in self.view.subviews{
            view.removeFromSuperview()
        }
        let y: CGFloat = self.isLandscape ? 40 : 100
        let scrollview = UIScrollView(frame: CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height))
        let stack: UIStackView = {
            let st = UIStackView()
            st.frame = CGRect(x: 10, y: 10, width: scrollview.frame.width - 20, height: scrollview.frame.height)
            st.axis = .vertical
            st.isLayoutMarginsRelativeArrangement = true

            st.distribution = .fill
            st.spacing = 10
            return st
        }()
        
        let lbDate: UILabel = {
            let lb = UILabel()
            lb.numberOfLines = 0
            lb.textAlignment = .center
            lb.font = FontStyle.sharedInstance.getFontSize20()
            lb.text = self.data.date
            lb.sizeToFit()
            return lb
        }()
        stack.addArrangedSubview(lbDate)
        
        let imageView: ImageLoader = {
            let iv = ImageLoader()
            iv.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0)
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()
        if let imgUrl = self.data.hdurl, imgUrl != ""{
            let url = URL(string: imgUrl)!
            imageView.loadImageWithUrl(url)
            stack.addArrangedSubview(imageView)
        }else{
            imageView.image = UIImage(named: "no-pic")
            stack.addArrangedSubview(imageView)
        }
        let lbTitle: UILabel = {
            let lb = UILabel()
            lb.textAlignment = .center
            
            lb.numberOfLines = 0
            lb.font = FontStyle.sharedInstance.getFontSize22Blod()
            lb.text = self.data.title
            lb.sizeToFit()
            return lb
        }()
        stack.addArrangedSubview(lbTitle)
        let lbCopyRight: UILabel = {
            let lb = UILabel()
            lb.numberOfLines = 0
            lb.textAlignment = .center
            lb.font = FontStyle.sharedInstance.getFontSize20Blod()
            lb.text = self.data.copyright
            lb.sizeToFit()
            return lb
        }()
        stack.addArrangedSubview(lbCopyRight)
        
        let lbDescription: UILabel = {
            let lb = UILabel()
            lb.numberOfLines = 0
            lb.textAlignment = .left
            lb.font = FontStyle.sharedInstance.getFontSize18()
            lb.text = self.data.description
            lb.sizeToFit()
            return lb
        }()
        stack.addArrangedSubview(lbDescription)
        
        scrollview.addSubview(stack)
        scrollview.contentSize = CGSize(width: stack.frame.width, height: stack.frame.height + y)
        self.view.addSubview(scrollview)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUI()
    }
   
}
