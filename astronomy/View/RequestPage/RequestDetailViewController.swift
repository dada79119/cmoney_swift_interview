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
        let scrollview = UIScrollView(frame: self.view.frame)
        let stack: UIStackView = {
           let st = UIStackView()
            st.frame = CGRect(x: 10, y: 10, width: scrollview.frame.width - 20, height: scrollview.frame.height)
            st.axis = .vertical
            st.distribution = .fill
            st.spacing = 10
            return st
        }()
        
        let lbDate: UILabel = {
            let lb = UILabel()
            lb.tintColor = .black
            lb.textAlignment = .center
            lb.font = FontStyle.sharedInstance.getFontSize20()
            lb.text = self.data.date
            return lb
        }()
        stack.addArrangedSubview(lbDate)
        
        let imageView: ImageLoader = {
            let iv = ImageLoader()
            iv.frame = CGRect(x: 0, y: 0, width: stack.frame.width, height: 300)
            iv.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0)
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()
        if let imgUrl = self.data.hdurl, imgUrl != ""{
            let url = URL(string: imgUrl)!
            imageView.loadImageWithUrl(url)
            stack.addArrangedSubview(imageView)
        }
        let lbTitle: UILabel = {
            let lb = UILabel()
            lb.tintColor = .black
            lb.textAlignment = .center
            lb.font = FontStyle.sharedInstance.getFontSize20()
            lb.text = self.data.title
            lb.numberOfLines = 0
            return lb
        }()
        stack.addArrangedSubview(lbTitle)
        
        let lbCopyRight: UILabel = {
            let lb = UILabel()
            lb.tintColor = .black
            lb.textAlignment = .center
            lb.font = FontStyle.sharedInstance.getFontSize20()
            lb.text = self.data.copyright
            lb.numberOfLines = 0
            return lb
        }()
        stack.addArrangedSubview(lbCopyRight)
        
        
        let lbDescription = UILabel()
        lbDescription.numberOfLines = 0
        lbDescription.tintColor = .black
        lbDescription.textAlignment = .left
        lbDescription.font = FontStyle.sharedInstance.getFontSize18()
        lbDescription.text = self.data.description
        stack.addArrangedSubview(lbDescription)
        
        
        
        
        
        scrollview.addSubview(stack)
        scrollview.contentSize = CGSize(width: stack.frame.width, height: stack.frame.height)

        self.view.addSubview(scrollview)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
