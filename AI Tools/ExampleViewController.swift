import UIKit

/// The main view controller that manages the text editing interface and highligts available AI tools.
final class ExampleViewController: UIViewController {
    /// The text view used for input and displaying attributed content.
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.backgroundColor = .systemBackground
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        textView.showsVerticalScrollIndicator = true
        textView.isEditable = true
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.textColor = .label
        return textView
    }()
    
    /// A vertical stack view that holds buttons.
    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    /// A custom gradient button for triggering actions.
    private let saveButton = GradientButton()
    
    /// A custom button subclass with gradient background and touch animations.
    final class GradientButton: UIButton {
        private let gradientLayer = CAGradientLayer()
        
        /// Initializes the button with a frame.
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        /// Initializes the button from a coder.
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        /// Common initializer to setup the gradient background, configuration and actions.
        private func commonInit() {
            gradientLayer.colors = [
                UIColor.systemIndigo.cgColor,
                UIColor.systemPurple.cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            layer.insertSublayer(gradientLayer, at: 0)
            
            var config = UIButton.Configuration.gray()
            config.baseForegroundColor = .label
            config.title = "Show Magic ✨"
            config.titleTextAttributesTransformer = .init({ incoming in
                var outgoing = incoming
                outgoing.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
                return outgoing
            })
            config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
            configuration = config
            
            layer.cornerRadius = 12
            layer.masksToBounds = true
            setupActions()
        }
        
        /// Sets up touch down and touch up animations.
        private func setupActions() {
            addTarget(self, action: #selector(animateTouchDown), for: [.touchDown])
            addTarget(self, action: #selector(animateTouchUp), for: [.touchUpInside])
        }
        
        /// Animates the button on touch down.
        @objc private func animateTouchDown() {
            UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState], animations: {
                self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            })
        }
        
        /// Animates the button on touch release.
        @objc private func animateTouchUp() {
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                self.transform = .identity
            })
        }
        
        /// Updates gradient layer's frame and corner radius on layout changes.
        override func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.frame = bounds
            gradientLayer.cornerRadius = layer.cornerRadius
        }
    }
    
    /// Called after the view has been loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupAttributedText()
    }
    
    /// Sets up the UI by adding subviews and activating layout constraints.
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add buttons to stack view.
        buttonStack.addArrangedSubview(saveButton)
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Available on 18.2 +"
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.textAlignment = .center
        buttonStack.addArrangedSubview(descriptionLabel)
        
        // Add subviews to main view.
        view.addSubview(buttonStack)
        view.addSubview(textView)
        textView.delegate = self
        
        NSLayoutConstraint.activate([
            // Button stack constraints.
            buttonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // TextView constraints.
            textView.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    /// Binds button actions to corresponding selectors.
    private func setupActions() {
        saveButton.addTarget(self, action: #selector(showWritingToolsAction), for: .touchUpInside)
    }
    
    /// Shows the writing tools for the text view.
    @objc private func showWritingToolsAction() {
        textView.becomeFirstResponder()
        textView.scrollsToTop = true
        textView.showWritingTools(textView)
    }
}

// MARK: - UITextViewDelegate

extension ExampleViewController: UITextViewDelegate {
    /// Called when the writing tools are dismissed.
    func textViewWritingToolsDidEnd(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}

// MARK: - Attributed Text Setup

extension ExampleViewController {
    /// Configures the attributed text for the text view.
    private func setupAttributedText() {
        let attributedText = NSMutableAttributedString()
        
        // Title styles.
        let mainTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 28, weight: .bold),
            .foregroundColor: UIColor.label
        ]
        
        let sectionTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 22, weight: .bold),
            .foregroundColor: UIColor.secondaryLabel
        ]
        
        // Regular text style.
        let bodyAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.label
        ]
        
        // Main title.
        attributedText.append(NSAttributedString(string: "Apple Intelligence: The Future of Smart Technology\n\n",
                                                   attributes: mainTitleAttributes))
        
        // Introduction.
        attributedText.append(NSAttributedString(string: "Apple's approach to artificial intelligence and machine learning represents a unique blend of innovation and privacy-focused development. Unlike many tech giants that rely heavily on cloud processing, Apple emphasizes on-device intelligence, ensuring user data remains secure while delivering powerful features.\n\n",
                                                   attributes: bodyAttributes))
        
        // Core Technologies.
        attributedText.append(NSAttributedString(string: "Core Technologies\n\n",
                                                   attributes: sectionTitleAttributes))
        
        attributedText.append(NSAttributedString(string: "The Neural Engine, integrated into Apple Silicon chips, powers features like Face ID, photography enhancement, and Siri's natural language processing. This dedicated hardware accelerates machine learning tasks while maintaining energy efficiency. Combined with the CoreML framework, developers can integrate advanced AI capabilities into their apps without compromising user privacy or device performance.\n\n",
                                                   attributes: bodyAttributes))
        
        textView.attributedText = attributedText
    }
}

// MARK: - Preview

@available(iOS 17, *)
#Preview {
    ExampleViewController()
}
