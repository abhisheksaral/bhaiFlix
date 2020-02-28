//
//  ViewUpcomingViewController.swift
//  bhaiFlix
//
//  Created by Abhishek Saral on 2/13/20.
//  Copyright © 2020 Tech Knowns. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKNavigationDelegate {

    var myUrl = URL(string: "https://www.google.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let webView = WKWebView(frame: view.frame)
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        let request = URLRequest(url: myUrl!)
        webView.load(request)
        
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
