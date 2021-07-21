//
//  ViewController.swift
//  astronomy
//
//  Created by dada on 2021/7/20.
//

import UIKit

class ViewController: BaseUIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnRequest: UIButton!
    lazy var jsonData: [AstronomyModel] = []
    
    func setUI() {
        self.lbTitle.text = "Astronomy Picture of the Day"
        self.lbTitle.font = FontStyle.sharedInstance.getFontSize20()
        self.lbTitle.textAlignment = .center
        self.lbTitle.textColor = UIColor.darkGray
        self.btnRequest.setTitle("Request ",for: .normal)
        self.btnRequest.titleLabel?.font = FontStyle.sharedInstance.getFontSize20()
        self.btnRequest.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func setupData() {
        let url = "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json"
        self.loadJson(urlString: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode([AstronomyModel].self,
                                                            from: data)
                    self.jsonData = decodedData
                    DispatchQueue.main.async(execute: {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
                        vc.dataList = self.jsonData
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                } catch {
                    print("decode error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.setupData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }


}

