//
//  MovieDetailsViewController.swift
//  bhaiFlix
//
//  Created by Abhishek Saral on 2/12/20.
//  Copyright © 2020 Tech Knowns. All rights reserved.
//

import UIKit
import  AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie:[String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL (string: baseUrl + posterPath)!
        
        posterView.af_setImage(withURL: posterUrl)
        
        let backdropBaseUrl = "https://image.tmdb.org/t/p/w1280"
        var backdropPath: String {
            if movie["backdrop_path"] is NSNull {
                return movie["poster_path"] as! String
            } else {
                return movie["backdrop_path"] as! String
            }
        }
        let backdropUrl = URL (string: backdropBaseUrl + backdropPath)!
        
        backdropView.af_setImage(withURL: backdropUrl)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
