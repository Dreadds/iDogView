//
//  DogsViewController.swift
//  iDogView
//
//  Created by Kevin Tito on 7/3/18.
//  Copyright © 2018 Kevin Tito. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

private let reuseIdentifier = "Cell"

class DogsCell: UICollectionViewCell {
    @IBOutlet var pictureImageView: UIImageView!
    
    func updateViews(from dog: Dog) {
        if let url = URL(string: dog.url){
            pictureImageView.af_setImage(withURL: url)
        }
    }
}

class DogsViewController: UICollectionViewController {
    var dogs: [Dog] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getDogs()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dogs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DogsCell
    
        // Configure the cell
        cell.updateViews(from: dogs[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func getDogs() {
        let parameters = ["limit": "5"]
        Alamofire.request(DogApi.getDogs, parameters: parameters)
        .validate()
        .responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                let error = json["status"].stringValue
                if error != "null"{
                    //let dogs = Dog.buildAll(from: json["data"].arrayValue)
                    self.dogs = Dog.buildAll(from: json["data"].arrayValue)
                    self.collectionView!.reloadData()
                    //print("Found \(dogs.count) Dogs")
                }
            case .failure(let error):
                print("Networking Error: \(error.localizedDescription)")
            }
            
        })
    }

}
