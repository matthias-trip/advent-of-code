import Foundation

extension String {
    func leftPadding(toLength length: Int, withPad char: Character = " ") -> String {
        String(repeating: char, count: max(0, length - count)) + self
    }
}
