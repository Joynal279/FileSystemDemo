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
        saveDataToFile(studentList)
        let data = getDataFromFile() // get Prjoect Typle list of data
        print("data List: \(data)")
        
    }
    
    func getDataFromFile() -> [Project] {
        let path = getDocumentDirectory().appendingPathComponent("projectDirectoryFile")
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
    
    func saveDataToFile(_ projects : [Project]){
        let recData = try! JSONEncoder().encode(projects)
        let path = getDocumentDirectory().appendingPathComponent("projectDirectoryFile")
        do{
            try recData.write(to: path)
        }catch{
            print("Error Saving Projects : \(error)")
        }
    }
    
    func saveInUserDefaults(){
        UserDefaults.standard.set(UIImage(named: "planeImage")?.pngData(), forKey: "data")
        let getData = UserDefaults.standard.data(forKey: "data")
        
        let image = UIImageView(frame: CGRect(x: 10, y: 100, width: 100, height: 100))
        self.view.addSubview(image)
        image.image = UIImage(data: getData!)
    }
    
    func getDocumentDirectory() -> URL {
        //find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //just sent first one, which ought to be the only one
        return paths[0]
    }
}


