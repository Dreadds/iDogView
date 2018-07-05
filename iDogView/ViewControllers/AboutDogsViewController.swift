//
//  AboutDogsViewController.swift
//  iDogView
//
//  Created by Kevin Tito on 7/3/18.
//  Copyright © 2018 Kevin Tito. All rights reserved.
//

import UIKit
//import SwiftyPlistManager

class AboutDogsViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var uploadedAt: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    var isFavorite: Bool = false
    //see data for "prepare function"
    var dog : Dog? {
        didSet {
            print("Set \(dog!.id)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Refresg view acordeng to dog object
        if let dog = dog{
            uploadedAt.text = dog.time
            if let url = URL(string: dog.url){
                logoImageView.af_setImage(withURL: url)
            }
            //Update favorite state
            isFavorite = dog.isFavorite()
            setFavoriteImage()
        }

        // Do any additional setup after loading the view.
        
        
        
    }
    
    func toggleFavorite() {
        isFavorite = !isFavorite
        if let dog = dog{
            dog.setFavorite(isFavorite: isFavorite)
            let store = iDogStore()
            print("Favorites: \(store.favoriteDogIdAsString())")
        }
        setFavoriteImage()
    }
    
    func setFavoriteImage() {
        let name = isFavorite ? "favorite-black" : "favorite-border"
        favoriteButton.setImage(UIImage(named: name), for: .normal)
    }

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        toggleFavorite()
    }
}
