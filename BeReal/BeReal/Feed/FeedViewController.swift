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
        refreshControl.addTarget(self, action: #selector(fetchNewPosts), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        queryPosts()
    }
    
    @objc private func fetchNewPosts(_ sender: Any) {
        queryPosts()
    }
    
    private func queryPosts() {
        // 1. Create a query to fetch Posts
        // 2. Any properties that are Parse objects are stored by reference in Parse DB and as such need to explicitly use `include_:)` to be included in query results.
        // 3. Sort the posts by descending order based on the created at date
        
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: (-1), to: Date())!
        
        let query = Post.query()
            .include("user")
            .order([.descending("createdAt")])
            .where("createdAt" >= yesterdayDate) // Only include posts that are less than 24 hours old
            .limit(10) // Limit to 10 posts max
        
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
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Logout of \(User.current?.username ?? "current account")?", message: nil, preferredStyle: .alert)
        
        let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
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
