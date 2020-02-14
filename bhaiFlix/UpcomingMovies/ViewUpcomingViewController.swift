//
//  ViewUpcomingViewController.swift
//  bhaiFlix
//
//  Created by Abhishek Saral on 2/13/20.
//  Copyright © 2020 Tech Knowns. All rights reserved.
//

import UIKit
import WebKit

class ViewUpcomingViewController: UIViewController, WKNavigationDelegate {

    var myUrl = URL(string: "https://www.google.com")
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let request = URLRequest(url: myUrl!)
        webView.load(request)
        

        // Do any additional setup after loading the view.
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
