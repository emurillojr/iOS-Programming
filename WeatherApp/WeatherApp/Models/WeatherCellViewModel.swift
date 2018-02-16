//
//  WeatherCellViewModel.swift
//  WeatherApp
//
//  Created by user135340 on 2/15/18.
//  Copyright © 2018 Murillo. All rights reserved.
//

//import Foundation
import UIKit

struct WeatherCellViewModel{
    let url: URL
    let day: String
    let description: String
    
    func loadImage(completion: @escaping (UIImage?) -> Void){
        guard let imageData = try? Data(contentsOf: url) else {
            return
        }
        
        let image = UIImage(data: imageData)
        DispatchQueue.main.async {
            completion(image)
        }
    }
}
