//
//  RequestViewController.swift
//  astronomy
//
//  Created by dada on 2021/7/20.
//

import Foundation
import UIKit
class RequestViewController: BaseUIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var dataList: [AstronomyModel] = []
    func setUI() {
        for view in self.view.subviews{
            view.removeFromSuperview()
        }
        // 取得螢幕的尺寸
        let fullScreenSize: CGSize =
          UIScreen.main.bounds.size
        // 設置底色
        self.view.backgroundColor = .white
        // 建立 UICollectionViewFlowLayout
        let layout: UICollectionViewFlowLayout = {
            let lt = UICollectionViewFlowLayout()
            // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
            lt.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
            // 設置每一行的間距
            lt.minimumLineSpacing = 5
            // 設置每個 cell 的尺寸
            lt.itemSize = CGSize(
                width: CGFloat(fullScreenSize.width)/3 - 10.0,
                height: CGFloat(fullScreenSize.width)/3 - 10.0)
            // 設置 header 及 footer 的尺寸
            lt.headerReferenceSize = CGSize(
              width: fullScreenSize.width, height: 0)
            lt.footerReferenceSize = CGSize(
              width: fullScreenSize.width, height: 0)
            return lt
        }()
        
        // 建立 UICollectionView
        let myCollectionViewFrame = CGRect(x: 0, y: 10, width: fullScreenSize.width, height: fullScreenSize.height - 10)
        let myCollectionView = UICollectionView(frame: myCollectionViewFrame, collectionViewLayout: layout)
        myCollectionView.backgroundColor = .white
        // 註冊 cell 以供後續重複使用
        myCollectionView.register(
          UICollectionViewCell.self,
          forCellWithReuseIdentifier: "cell")
        // 設置委任對象
        myCollectionView.delegate = self
        myCollectionView.dataSource = self

        // 加入畫面中
        self.view.addSubview(myCollectionView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setUI()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestDetailViewController") as! RequestDetailViewController
        vc.data = self.dataList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 依據前面註冊設置的識別名稱 "Cell" 取得目前使用的 cell
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "cell", for: indexPath)
        // 取得螢幕寬度
        let w = cell.contentView.frame.width
        // 建立一個 UILabel
        let titleLabel: UILabel = {
            let lb = UILabel()
            lb.frame = CGRect(
              x: 5, y: 5, width: w - 10.0, height: w - 10.0)
            lb.textAlignment = .left
            lb.textAlignment = .center
            lb.textColor = UIColor.white
            lb.numberOfLines = 4
            lb.text = self.dataList[indexPath.row].title
            return lb
        }()
        
        let imageView: ImageLoader = {
            let iv = ImageLoader()
            iv.frame = cell.contentView.frame
            iv.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0)
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()
        
        if let imgUrl = self.dataList[indexPath.row].url, imgUrl != ""{
            let url = URL(string: imgUrl)!
            imageView.loadImageWithUrl(url)
            cell.contentView.addSubview(imageView)
            cell.contentView.addSubview(titleLabel)
        }else{
            imageView.image = UIImage(named: "no-pic")
            cell.contentView.addSubview(imageView)
            cell.contentView.addSubview(titleLabel)
        }
        return cell
    }
    
  
    
}
