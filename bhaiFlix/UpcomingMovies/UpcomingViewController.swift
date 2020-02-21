//
//  UpcomingViewController.swift
//  bhaiFlix
//
//  Created by Abhishek Saral on 2/12/20.
//  Copyright © 2020 Tech Knowns. All rights reserved.
//

import UIKit
import AlamofireImage

class UpcomingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 0
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        
        layout.estimatedItemSize = CGSize(width: width, height: width*1.5)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1&region=US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
              // Store the movies in a property to use elsewhere
            self.movies = dataDictionary["results"] as! [[String:Any]]
              // TODO: Reload your table view data
            self.collectionView.reloadData()
            

           }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL (string: baseUrl + posterPath)!
        
        cell.posterView.af_setImage(withURL: posterUrl)
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Find the selected movie
        
        let cell = sender as! UICollectionViewCell
        //let indexPath = tableView.indexPath(for: cell)!
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.item]
        
        // Pass the selected movie to the details view controller
        
        let detailsViewController = segue.destination as! UpcomingDetailsViewController
        
        detailsViewController.movie = movie
        
        //tableView.deselectRow(at: indexPath, animated: true)
    }

}
