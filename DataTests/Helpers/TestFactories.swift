import Foundation

func makeInvalidData() -> Data {
    return Data("Invalid_data".utf8)
}

func makeUrl() -> URL {
    return URL(string: "http://any-url.com")!
}

