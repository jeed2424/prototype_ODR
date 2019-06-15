//
//  NewViewController.swift
//  OpenDocument
//
//  Created by Jérémie Beaudoin on 5/27/19.
//  Copyright © 2019 Jérémie Beaudoin. All rights reserved.
//

import UIKit
import WebKit
import MobileCoreServices

class NewViewController: UIViewController {
    

    
    @IBOutlet var webView: WKWebView!
    var fileToLoad: URL?
    
    override func loadView() {
        webView = WKWebView()
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = fileToLoad else { return }
        let contents = try! String(contentsOf: url, encoding: .utf8)
        print(contents)
        webView.loadHTMLString(contents, baseURL: nil)
        
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
