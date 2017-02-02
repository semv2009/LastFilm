//
//  LastFilmViewController.swift
//  LastFilm
//
//  Created by Семен Никулин on 02.02.17.
//  Copyright © 2017 niksemv. All rights reserved.
//

import UIKit

class LastFilmViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    var viewModel: LastFilmViewModel
    
    init(viewModel: LastFilmViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        configureTableView()
        configureNavigationBar()
        configureRefreshControl()
        firstLoadData()
    }
    
    func firstLoadData() {
        showLoadingView((self.navigationController?.view!)!, text: "Loading films...")
        viewModel.loadFilms() { result in
            switch result {
            case .success(_):
                self.tableView.reloadData()
                self.hideLoadingView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delaysContentTouches = true
        tableView.register(UINib(nibName: "FilmTableViewCell", bundle: nil), forCellReuseIdentifier: "FilmCell")
    }
    
    func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = false
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    func configureRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func refresh(_ sender: AnyObject) {
        viewModel.loadFilms() { result in
            switch result {
            case .success(_):
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LastFilmViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as? FilmTableViewCell {
                let film = viewModel.tableSource[indexPath.row]
            cell.updateUI(film: film)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = viewModel.tableSource[indexPath.row]
        let model = DetailFilmViewModel(film: film)
        self.navigationController?.pushViewController(DetailFilmViewController(viewModel: model), animated: true)
    }
}
