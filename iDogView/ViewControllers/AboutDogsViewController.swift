//
//  AboutDogsViewController.swift
//  iDogView
//
//  Created by Kevin Tito on 7/3/18.
//  Copyright © 2018 Kevin Tito. All rights reserved.
//

import UIKit

class AboutDogsViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var uploadedAt: UILabel!
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
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
