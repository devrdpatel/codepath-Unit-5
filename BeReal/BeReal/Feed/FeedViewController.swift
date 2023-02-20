//
//  FeedViewController.swift
//  BeReal
//
//  Created by Dev Patel on 2/15/23.
//

import UIKit
import ParseSwift

class FeedViewController: UIViewController {

    private var posts = [Post]() {
        didSet {
            // Reload table view anytine the data in var posts changes
            tableView.reloadData()
        }
    }
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        refreshControl.tintColor = .systemGray
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Latest Feed ...", attributes: .none)
        refreshControl.addTarget(self, action: #selector(viewWillAppear(_:)), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        queryPosts()
    }
    
    private func fetchNewPosts(_ sender: Any) {
        queryPosts()
    }
    
    private func queryPosts() {
        // 1. Create a query to fetch Posts
        // 2. Any properties that are Parse objects are stored by reference in Parse DB and as such need to explicitly use `include_:)` to be included in query results.
        // 3. Sort the posts by descending order based on the created at date
        
        let query = Post.query()
            .include("user")
            .order([.descending("createdAt")])
        
        // Fetch posts defined in query asynchronously
        query.find { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
        
        if let refreshControl = tableView.refreshControl {
            DispatchQueue.main.async {
                refreshControl.endRefreshing()
            }
        }
    }
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.configure(with: posts[indexPath.row])
        return cell
    }
}

extension FeedViewController: UITableViewDelegate { }
