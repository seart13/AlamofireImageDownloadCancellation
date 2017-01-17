import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    
    private let spacingXY: CGFloat = 10
    private let collectionViewLayout = UICollectionViewFlowLayout()
    private let collectionView: UICollectionView
    
    required init?(coder aDecoder: NSCoder) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 2 * spacingXY, height: 100)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: spacingXY, bottom: spacingXY, right: spacingXY)
        
        collectionView.dataSource = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "imageCell")
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
        collectionView.reloadData()
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
    }

    override func viewWillLayoutSubviews() {
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        cell.setImage(with: URL(string: "http://thecatapi.com/api/images/get?cachebreaker=\(indexPath.row)")!)
        return cell
    }
}
