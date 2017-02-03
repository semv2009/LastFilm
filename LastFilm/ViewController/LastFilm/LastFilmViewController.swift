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
    var firstRun = false
    
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
        showLoadingView(self.navigationController?.view, text: "Loading films...")
        viewModel.loadFilms() { [unowned self] result in
            self.hideLoadingView()
            self.firstRun = true
            switch result {
            case .success(_):
                self.tableView.addSubview(self.refreshControl)
                self.tableView.reloadData()
            case .failure(let error):
                self.emptyList()
                self.refreshControl.removeFromSuperview()
                self.showErrorAlert(error: error)
            }
        }
    }
    
    func emptyList() {
        if firstRun {
            let view = EmptyView()
            view.delegate = self
            self.tableView.backgroundView = view
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
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
    }
    
    func refresh(_ sender: AnyObject) {
        viewModel.loadFilms() { [unowned self] result in
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self.tableView.reloadData()
                    case .failure(let error):
                        self.showErrorAlert(error: error)
                    }
                }
                
                sleep(1)
                
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
}

extension LastFilmViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        if viewModel.tableSource.count == 0 {
            emptyList()
        }
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
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension LastFilmViewController: EmptyViewDelegate {
    func emptyViewDidClickButton(emptyView: EmptyView) {
        firstLoadData()
    }
}
