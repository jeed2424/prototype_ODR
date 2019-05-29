//
//  ViewController.swift
//  OpenDocument
//
//  Created by Jérémie Beaudoin on 5/27/19.
//  Copyright © 2019 Jérémie Beaudoin. All rights reserved.
//

import UIKit
import MobileCoreServices
import Foundation

class ViewController: UIViewController, UITableViewDataSource {
    
    
    var importedfiles: NSArray! = NSArray()
    let FM = FileManager.default

    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        
        
    }
    
    @IBAction func ImportFiles(_ sender: UIBarButtonItem) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        documentPicker.delegate = self as UIDocumentPickerDelegate
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let dirPaths = FM.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDir = dirPaths[0].path
        let importedfiles = try! FM.contentsOfDirectory(atPath: docsDir)
        
            
        self.importedfiles! = importedfiles as NSArray
        
    }


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
    return importedfiles.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(
        withIdentifier: "cell",
        for: indexPath) as! TableViewCell
    
    cell.titleLabel.text = importedfiles[indexPath.row] as? String
    
    return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let file = self.importedfiles[indexPath.row]
        // you'd create a new FileViewController class
        let fileViewController = NewViewController(coder: file as! NSCoder)!
        // show the fileViewController however you want
        show(fileViewController, sender: self)
        
    }
    
}
        

extension ViewController: UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileUrl = urls.first else{
            return
        }
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileUrl = dir.appendingPathComponent(selectedFileUrl.lastPathComponent)
        
        if FM.fileExists(atPath: sandboxFileUrl.path){
            print ("File already exists!")
        }
        else{
            do{
                try FM.copyItem(at: selectedFileUrl, to: sandboxFileUrl)
                print ("Copied document!")
               
            }
            catch {
                print ("Error: \(error)")
            }
        }
    }
}

