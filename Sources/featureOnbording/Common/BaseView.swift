import UIKit

class BaseView: UIView {
    
    let baseScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        return scrollView
    }()
    
    let baseContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupLocalization()
        setupTapGesture()
        setupLanguageUpdateNotification()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        
        addSubview(baseScrollView)
        baseScrollView.addSubview(baseContentView)
    }
    
    func setupConstraints() {
        if #available(iOS 11.0, *) {
            baseScrollView.anchor(top: safeAreaLayoutGuide.topAnchor,
                                  bottom: safeAreaLayoutGuide.bottomAnchor)
            baseContentView.heightAnchor
                .constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.heightAnchor).isActive = true
        } else {
            baseScrollView.anchor(top: topAnchor,
                                  bottom: bottomAnchor)
            baseContentView.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor).isActive = true
        }
        
        baseScrollView.anchor(left: leftAnchor,
                              right: rightAnchor)
        
        baseContentView.anchor(top: baseScrollView.topAnchor,
                               left: baseScrollView.leftAnchor,
                               bottom: baseScrollView.bottomAnchor,
                               right: baseScrollView.rightAnchor)
        baseContentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func setupConstraintsWithoutBottomSafeArea() {
        // Scroll view
        if #available(iOS 11.0, *) {
            baseScrollView.anchor(top: safeAreaLayoutGuide.topAnchor)
        } else {
            baseScrollView.anchor(top: topAnchor)
        }
        
        baseScrollView.anchor(left: leftAnchor,
                              bottom: bottomAnchor,
                              right: rightAnchor)
        
        baseScrollView.contentInset = UIEdgeInsets(top: 0,
                                                   left: 0,
                                                   bottom: -34, // Bottom safe area
                                                   right: 0)
        
        // Content view
        let screenHeight = UIScreen.main.bounds.height
        let topSafeAreaInset = CGFloat(44)
        let heightWithoutTopSafeArea = screenHeight - topSafeAreaInset
        
        baseContentView.anchor(top: baseScrollView.topAnchor,
                               left: baseScrollView.leftAnchor,
                               bottom: baseScrollView.bottomAnchor,
                               right: baseScrollView.rightAnchor)
        
        baseContentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        baseContentView.heightAnchor
            .constraint(greaterThanOrEqualToConstant: heightWithoutTopSafeArea).isActive = true
        
    }
    
    func setupLocalization() {
        
    }
    
    static func getLocalizedText(forKey key: String) -> String {
        return LanguageManager.shared.getI18nStringValue(of: key)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        endEditing(true) // To hide keyboard
    }
    
    private func setupLanguageUpdateNotification() {
        let notificationName = Application.Constants.updateLanguageNotification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateLanguageText),
                                               name: NSNotification.Name(rawValue: notificationName),
                                               object: nil)
    }
    
    @objc func updateLanguageText() {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
