//
//  WebtoonData.swift
//  NaverWebtoonExample
//
//  Created by 박솔미 on 2022/07/26.
//

struct WebtoonData {
    var title_image : String!
    var title : String!
    var rating : Float!
    var author : String!
    
    init(_ title:String, _ title_image:String, _ rating:Float, _ author:String) {
        
        self.title = title
        self.title_image = title_image
        self.rating = rating
        self.author = author
    }
}
