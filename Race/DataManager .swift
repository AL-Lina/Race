//
//  DataManager .swift
//  Race
//
//  Created by Alina Sakovskaya on 10.09.23.
//

import UIKit

final class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    
    func saveImage(_ image: UIImage?) -> String? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
              let image else {
            return nil
        }
        
        let fileName = UUID().uuidString
        let fileURL = directory.appendingPathComponent(fileName)
        
        let data = image.jpegData(compressionQuality: 1.0)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch let error {
                print(error)
                return nil
            }
        }
        
        do {
            try data?.write(to: fileURL)
            return fileName
        } catch {
            return nil
        }
    }
    
    func loadImage(fileName: String) -> UIImage? {
        guard let directore = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileUrl = directore.appendingPathComponent(fileName)
        let image = UIImage(contentsOfFile: fileUrl.path)
        return image
    }
}
