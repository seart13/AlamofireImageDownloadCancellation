import UIKit
import AlamofireImage

final class ImageCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private var imageUrl: URL?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    
    func setImage(with url: URL) {
        imageUrl = url
        
        imageView.af_setImage(
            withURL: url,
            placeholderImage: nil,
            filter: nil,
            progress: { [weak self] (progress: Progress) in
                let alpha = CGFloat(progress.fractionCompleted)
                self?.imageView.backgroundColor = UIColor.green.withAlphaComponent(alpha)
            },
            progressQueue: .main,
            imageTransition: .noTransition,
            runImageTransitionIfCached: false,
            completion: { [weak self] request in
                if let downloadUrl = request.request?.url, self?.imageUrl == downloadUrl {
                    self?.imageView.backgroundColor = .yellow // mark faled downloads
                }
            }
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.af_cancelImageRequest()
        imageView.image = nil
        imageView.backgroundColor = .white
    }
}
