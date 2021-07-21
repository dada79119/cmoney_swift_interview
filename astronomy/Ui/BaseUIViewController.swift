//
//  BaseUIViewController.swift
//  astronomy
//
//  Created by dada on 2021/7/20.
//

import Foundation
import UIKit

class BaseUIViewController: UIViewController {
    var isLandscape: Bool = true
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.isLandscape = UIDevice.current.orientation.isLandscape
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - NotificationCenter
    @objc func popView(){
        self.view.endEditing(true)
        self.navigationController!.popViewController(animated: true)
    }
    
    @objc func dismissView(){
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    var activityIndicator = UIActivityIndicatorView()
    func loadJson(urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        

        activityIndicator.color = .darkGray
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async(execute: {
                        self.view.isUserInteractionEnabled = true
                        self.activityIndicator.stopAnimating()
                    })
                    completion(.failure(error))
                    
                }
                if let data = data {
                    DispatchQueue.main.async(execute: {
                        self.view.isUserInteractionEnabled = true
                        self.activityIndicator.stopAnimating()
                    })
                    completion(.success(data))
                }
                
            }
            urlSession.resume()
        }
    }
}

