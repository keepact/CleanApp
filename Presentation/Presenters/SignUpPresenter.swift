import Foundation

public final class SignUpPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    
    public init(alertView: AlertView, emailValidator: EmailValidator) {
        self.alertView = alertView
        self.emailValidator = emailValidator
    }
    public func signUp(viewModel: SignUpViewModel) {
       if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation fails", message: message))
        }
    }
    
    private func validate(viewModel: SignUpViewModel) -> String? {
        if viewModel.name == nil || viewModel.name!.isEmpty {
            return "The field name is required"
        } else if viewModel.email == nil || viewModel.email!.isEmpty {
            return "The field email is required"
        } else if viewModel.password == nil || viewModel.password!.isEmpty {
            return "The field password is required"
        } else if viewModel.passwordConfirmation == nil || viewModel.passwordConfirmation!.isEmpty {
            return "The field confirm password is required"
        } else if viewModel.password != viewModel.passwordConfirmation {
            return "The field confirm password is invalid"
        } else if !emailValidator.isValid(email: viewModel.email!) {
            return "The field email is invalid"
        }
        return nil
    }
}

public struct SignUpViewModel {
   public var name: String?
   public var email: String?
   public var password: String?
   public var passwordConfirmation: String?
    
    public init(name: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
