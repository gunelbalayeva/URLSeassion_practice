//
//  ViewController.swift
//  PracticeURLSeassion
//
//  Created by User on 09.04.25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview:UITableView!
    @IBOutlet weak var activiteindicatorview:UIActivityIndicatorView!
    @IBOutlet weak var searcBarView:UISearchBar!
    private let networkService:Network = Network()
    private var userList:[UserModel] = []
    private var postList:[PostModel] = []
    private var myrefreshcontroller = UIRefreshControl()
    private var searchDispatchWorkItem :DispatchWorkItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.refreshControl = myrefreshcontroller
        myrefreshcontroller.addTarget(self, action: #selector(didRefreshData), for: .valueChanged)
        searcBarView.searchTextField.addTarget(self, action: #selector(didSearchText), for: .editingChanged)
        activiteindicatorview.startAnimating()
        fetchData()
    }
    
    @objc
    private func didSearchText() {
        searchDispatchWorkItem?.cancel()
        let newWorkItem = DispatchWorkItem {
            self.networkService.getSearchPosts(with: self.searcBarView.text ?? "") { postModel in
                self.postList = postModel
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
        }
        self.searchDispatchWorkItem = newWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: newWorkItem)
    }
                                        
                                                   

 private func fetchData(){
        networkService.getUsers { users in
            self.userList = users
            DispatchQueue.main.async{
                self.tableview.reloadData()
                self.activiteindicatorview.stopAnimating()
                self.myrefreshcontroller.endRefreshing()
            }
            
        }
    }
    //    DispatchQueue.main.asyncAfter(deadline: .now()+5){}
    @objc
   private func didRefreshData(){
        activiteindicatorview.startAnimating()
        fetchData()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = postList[indexPath.row].title
        cell.detailTextLabel?.text = postList[indexPath.row].body

        return cell
        
    }
}

