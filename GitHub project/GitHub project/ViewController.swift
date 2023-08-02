//
//  ViewController.swift
//  GitHub project
//
//  Created by Yury Semenovich on 29.05.23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
 {
    private let сollectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 64)
//      layout.sectionInset = .init(top: 8, left: 0, bottom: 8, right: 0)
      
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.showsVerticalScrollIndicator = true

      return collectionView
    }()
    
    private var repositories = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(сollectionView)
        
        setupConstraints()
   
        сollectionView.delegate = self
        сollectionView.dataSource = self
        сollectionView.register(RepositoryCell.self, forCellWithReuseIdentifier: "RepositoryCell")
        
        task()
    }
    
    func task() {
        
        let task = URLSession.shared.dataTask(with: URL(string: "https://api.github.com/repositories?")!) { [weak self] data, response, error in
            guard let self else { return }
            if let data = data {
                if let repository = try? JSONDecoder().decode([Repository].self, from: data) {
                    print(repository)
                    self.repositories = repository
                    
                    DispatchQueue.main.async {
                        self.сollectionView.reloadData()
                    }
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        repositories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let repository = collectionView.dequeueReusableCell(withReuseIdentifier: "RepositoryCell", for: indexPath) as? RepositoryCell else {
            return UICollectionViewCell()
        }
        repository.setup(repository: repositories[indexPath.row])
        return repository
    }
    
    private func setupConstraints() {
        сollectionView.translatesAutoresizingMaskIntoConstraints = false
        сollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        сollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        сollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        сollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

struct Repository: Decodable {
    
    let id: Int
    let name: String
    let owner: Owner
    
    
}

struct Owner: Decodable {
    let id: Int
    let avatar_url: String
    let url: String
}

    


