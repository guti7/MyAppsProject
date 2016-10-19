//
//  DetailViewController.swift
//  MyAppsProject
//
//  Created by Guti on 10/17/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var app: AppModel?
    
    // MARK: -IBOutlets
    
    @IBOutlet weak var appTitleLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: -IBActions
    
    @IBAction func addToWishListButton(_ sender: AnyObject) {
    }
    
    @IBAction func markAsDownloadedButton(_ sender: AnyObject) {
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appTitleLabel.text = app!.title
        genreLabel.text = app!.genre
        releaseDateLabel.text = app!.releaseDate
        
        // TODO: Download the image, by making a network call. 
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadPoster(urlString: String) {
        imageView.af_setImageWithURL(NSURL(string: urlString)!, placeholderImage: nil, filter: nil, progress: nil, progressQueue: dispatch_get_main_queue(), imageTransition: .None, runImageTransitionIfCached: false) { (response: Response<UIImage, NSError>) in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    self.backgroundView.image = value
                    self.randomMovie.movieImage = value
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
