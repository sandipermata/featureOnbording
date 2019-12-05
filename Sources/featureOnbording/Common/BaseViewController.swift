import UIKit

class BaseViewController: UIViewController {
    
    func showAlert(view: UIViewController,
                   title: String? = nil,
                   message: String?,
                   buttonText: String? = nil,
                   callback: ((UIAlertAction) -> Void)? = nil) {
        
        let cancelButtonText = buttonText ?? "Cancel"
        let alertMessage = message ?? "Something went wrong."
        
        let alertController = UIAlertController(title: nil,
                                                message: alertMessage,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: cancelButtonText,
                                                style: .default,
                                                handler: callback))
        
        view.present(alertController, animated: true, completion: nil)
    }
    
    func transformErrorModel(_ error: Error) -> String {
        let errorObject = error as? ErrorResponse
        let errorDescription = errorObject?.description ?? error.localizedDescription
        return errorDescription
    }
    
}
