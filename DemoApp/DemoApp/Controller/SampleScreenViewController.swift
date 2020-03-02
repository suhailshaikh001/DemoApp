//
//  SampleScreenViewController.swift
//  DemoApp
//
//  Created by Suhail Shaikh on 02/03/20.
//  Copyright © 2020 Demo.com. All rights reserved.
//

import UIKit

class SampleScreenViewController: UIViewController {

    //Views
    let authorCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    //Variables
    var authorList : Author?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Settings
        self.navigationItem.title = "Lorem Picsum"
        
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumLineSpacing = 5
        
        authorCollectionView.setCollectionViewLayout(layout, animated: true)
        authorCollectionView.backgroundColor = .clear
        self.authorCollectionView.dataSource = self
        self.authorCollectionView.delegate = self
        
        self.authorCollectionView.register(UINib(nibName: "AuthorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellName.authorCell.rawValue)
        
        //Method callings
        setupConstraints()
        getAuthorListWS()
    }
    
    //MARK:- Custom methods
    fileprivate func setupConstraints(){
        
        self.view.addSubview(authorCollectionView)
        
        //author collection view
        self.authorCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        self.authorCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15).isActive = true
        self.authorCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        self.authorCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
    }
    
    //MARK:- Web service
    fileprivate func getAuthorListWS(){
        
        if CheckInternet.Connection(){
            
            let url = baseURL + getAuthorListURL
            let strUrl = URL(string: url)
            
            let newSession = URLSession.shared
            var newRequest = URLRequest(url: strUrl!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
            newRequest.httpMethod = httpMethod.GET.rawValue
            
            newSession.dataTask(with: newRequest, completionHandler: {(data, response, error) in
                
                if data != nil{
                    
                    do{
//                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                        print(json)
                        
                        let jsonResponse = try JSONDecoder().decode(Author.self, from: data!)
                        self.authorList = jsonResponse
                        
                        DispatchQueue.main.async {
                            self.authorCollectionView.reloadData()
                        }
                        
                    }
                    catch{
                        alertViewForAlert(title: "Error", message: error.localizedDescription, action: "Ok")
                    }
                }
                else{
                    alertViewForAlert(title: "Error", message: error!.localizedDescription, action: "Ok")
                }
                
            }).resume()
            
        }
        else{
            alertViewForAlert(title: "No internet", message: "Please connect to internet.", action: "Ok")
        }
    }

}

extension SampleScreenViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.authorList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.authorCollectionView.dequeueReusableCell(withReuseIdentifier: cellName.authorCell.rawValue, for: indexPath) as! AuthorCollectionViewCell
        
        cell.authorNameLabel.text = self.authorList![indexPath.item].author
        
        let url = baseURL + getAuthorImageURL + "\(self.authorList![indexPath.item].id)"
        let imgUrl = URL(string: url)
        
        if let data = try? Data(contentsOf: imgUrl!){
            DispatchQueue.main.async {
                cell.authorImageView.image = UIImage(data: data)
            }
            
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = CGFloat()
        var height = CGFloat()
        
        if UIDevice.current.orientation.isLandscape{
            width = self.authorCollectionView.frame.size.width / 3
            height = self.authorCollectionView.frame.size.height / 2
        }
        else{
            width = self.authorCollectionView.frame.size.width / 3
            height = self.authorCollectionView.frame.size.height / 5
        }
        
        
        
        return CGSize(width: width, height: height)
    }
    
}
