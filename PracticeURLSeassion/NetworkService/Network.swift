//
//  Network.swift
//  PracticeURLSeassion
//
//  Created by User on 09.04.25.
//

import UIKit

class Network {
    
    func getUsers(completion: @escaping ([UserModel])->Void){
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let request = URLRequest(url: url)
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Something went wrong in data task\(error)")
                return
            }
            if let data = data {
                do {
                    let users = try JSONDecoder().decode([UserModel].self, from: data)
                    completion(users)
                    print("User: \(users)")
                } catch {
                    print("Decoding error: \(error)")
                }
            }        }
        task.resume()
    }
    
    func getSearchPosts(with query: String, completion: @escaping ([PostModel]) -> Void) {
        let url = URL(string: "https://dummyjson.com/posts/search?q=\(query)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Something went wrong in getting searchPost: \(error)")
                return
            }
            if let data = data {
                do {
                    let posts = try JSONDecoder().decode(PostListModel.self, from: data)
                    completion(posts.posts)
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }
        task.resume()
    }

    
    
}
