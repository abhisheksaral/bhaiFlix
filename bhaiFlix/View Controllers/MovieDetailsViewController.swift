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
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    var movieVideos = [[String:Any]]()
    
    var movie:[String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        posterView.isUserInteractionEnabled = true
        posterView.addGestureRecognizer(tapGestureRecognizer)
        
        posterView.layer.shadowOffset = .zero
        posterView.layer.shadowColor = UIColor.systemBlue.cgColor
        posterView.layer.shadowRadius = 20
        posterView.layer.shadowOpacity = 1
        posterView.layer.shadowPath = UIBezierPath(rect: posterView.bounds).cgPath
        posterView.layer.masksToBounds = false
        
        
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = 1
        animation.toValue = 0.2
        animation.autoreverses = true
        animation.duration = 1
        animation.repeatCount = Float.infinity
        
        posterView.layer.add(animation, forKey: nil)
        
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
        
        let id = movie["id"] as! Int
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
            self.movieVideos = dataDictionary["results"] as! [[String:Any]]

           }
        }
        task.resume()
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let upcomingVideoViewController = segue.destination as! MovieTrailerViewController
        
        var youtubeURL = URL(string: "https://www.youtube.com/")
        
        if movieVideos.count != 0 {
            youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(movieVideos[0]["key"]!)")
        } else {
            youtubeURL = URL(string: "https://www.youtube.com/")
        }
        
        upcomingVideoViewController.myUrl = youtubeURL
        
    }
    

}
