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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var importedfiles: Array<Any> = Array()
    let FM = FileManager.default

    
    
    @IBOutlet weak var tableView: UITableView!
    
    
        @IBAction func ImportFiles(_ sender: UIBarButtonItem) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
        documentPicker.delegate = self as UIDocumentPickerDelegate
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
        
    }
    
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadFiles()
        
    }
    
    func loadFiles() {
        let dirPaths = FM.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDir = dirPaths[0].path
        let importedfiles = try! FM.contentsOfDirectory(atPath: docsDir)
        
        tableView.dataSource = self
        tableView.delegate = self
        self.importedfiles = importedfiles as Array
    }

    
    func deleteFile(filetodelete: String) {
        let dirPaths = FM.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDir = dirPaths[0].appendingPathComponent(filetodelete).path
        if FM.fileExists(atPath: docsDir) {
            do {
                try FM.removeItem(atPath: docsDir)
                print ("File deleted")
            } catch {
                print ("Could not delete file: \(error)")
            }
        }
    }
    
    
    func OpenFile(fileToLoad: String) {
        let SecondScreen = self.storyboard?.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
        let dirPaths = FM.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDir = dirPaths[0].appendingPathComponent(fileToLoad)
        SecondScreen.fileToLoad = docsDir
        self.present(SecondScreen, animated: true, completion: nil)
        
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
        
        let fileToLoad = self.importedfiles[indexPath.row]
        self.OpenFile(fileToLoad: fileToLoad as! String)
        
        print ("Cell \(indexPath.row) is selected")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
         let filetodelete = self.importedfiles[indexPath.row]
            self.deleteFile(filetodelete: filetodelete as! String)
            importedfiles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        }
    
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
                self.loadFiles()
                self.tableView.reloadData()
               
            }
            catch {
                print ("Error: \(error)")
            }
        }
    }
    
}





