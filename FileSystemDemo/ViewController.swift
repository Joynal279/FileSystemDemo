//
//  ViewController.swift
//  FileSystemDemo
//
//  Created by Joynal Abedin on 11/6/22.
//

import UIKit

struct Project: Codable {
    let name: String
    let department: String
    let image: Data
}

class ViewController: UIViewController {
    
    var studentList: [Project] = [
        Project(name: "Joynal", department: "Science", image: (UIImage(named: "planeImage")?.pngData())!),
        Project(name: "AR Rahman", department: "Multimedia", image: (UIImage(named: "planeImage")?.pngData())!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //save Model
        savingProjectsToFile(studentList)
        let data = getData() // get Prjoect Typle list of data
        print("data List: \(data)")
    }
    
    func getData() -> [Project] {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("SavedProjectToFile")
        let recData : Data!
        do{
            recData = try Data(contentsOf: path)
        }catch{
            print("Error while Fetching from File : \(error)")
            return []
        }
        let retreiveArray = try! JSONDecoder().decode([Project].self, from: recData!)
        return retreiveArray
    }
    
    func savingProjectsToFile(_ projects : [Project]){
        let recData = try! JSONEncoder().encode(projects)
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("SavedProjectToFile")
        do{
            try recData.write(to: path)
        }catch{
            print("Error Saving Projects : \(error)")
        }
    }
}


