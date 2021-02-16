import ObjectMapper

class JsonParser {

    func parse<T: ImmutableMappable>(filename: String) throws -> T {
        guard let path = CoinKit.bundle?.path(forResource: filename, ofType: "json") else {
            throw ParseError.notFound
        }

        let text = try String(contentsOfFile: path, encoding: .utf8)
        if let dataText = text.data(using: .utf8),
           let dictionary = try JSONSerialization.jsonObject(with: dataText, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {

            return try T(JSON: dictionary)
        }
        throw ParseError.cantParse
    }

}

extension JsonParser {

    enum ParseError: Error {
        case notFound
        case cantParse
    }

}
