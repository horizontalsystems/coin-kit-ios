import ObjectMapper

class JsonParser {

    func parse<T: ImmutableMappable>(filename: String) throws -> T {
        guard let path = CoinKit.bundle?.path(forResource: filename, ofType: "json") else {
            throw ParseError.notFound
        }

        let jsonString = try String(contentsOfFile: path, encoding: .utf8)
        return try T(JSONString: jsonString)
    }

}

extension JsonParser {

    enum ParseError: Error {
        case notFound
        case cantParse
    }

}
