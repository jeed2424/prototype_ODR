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

class NewViewController: UIViewController, WKUIDelegate {
    
    
    func ViewFile(filePath: String) {
        let url = URL.init(fileURLWithPath: filePath)
       
        let request = URLRequest(url: url)
        FileToLoad.load(request)
    }
    

    
    @IBOutlet weak var FileToLoad: WKWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
