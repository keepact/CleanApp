import Foundation
import Domain

public final class SignUpPresenter {
    private let alertView: AlertView
    private let emailValidator: EmailValidator
    private let addAccount: AddAccount
    private let loadingView: LoadingView
    
    public init(alertView: AlertView, emailValidator: EmailValidator, addAccount: AddAccount, loadingView: LoadingView) {
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.addAccount = addAccount
        self.loadingView = loadingView
    }
    public func signUp(viewModel: SignUpViewModel) {
       if let message = validate(viewModel: viewModel) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Validation fails", message: message))
       } else {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        addAccount.add(addAccountModel: SignUpMapper.toAddAccountModel(viewModel: viewModel)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure: self.alertView.showMessage(viewModel: AlertViewModel(title: "Error", message: "Something unexpected happend, try again in a few minutes."))
            case .success: self.alertView.showMessage(viewModel: AlertViewModel(title: "Success", message: "Account successfuly created."))
            }
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            }
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
