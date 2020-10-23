
import Foundation

// MARK: - 扩展实现
// MARK: - Properties
public extension Xwg where Target == Character {
    
    /// SwifterSwift: Check if character is emoji.
    ///
    ///        Character("😀").isEmoji -> true
    ///
    var isEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        let scalarValue = String(target).unicodeScalars.first!.value
        switch scalarValue {
        case 0x1F600...0x1F64F, // Emoticons
        0x1F300...0x1F5FF, // Misc Symbols and Pictographs
        0x1F680...0x1F6FF, // Transport and Map
        0x1F1E6...0x1F1FF, // Regional country flags
        0x2600...0x26FF, // Misc symbols
        0x2700...0x27BF, // Dingbats
        0xE0020...0xE007F, // Tags
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
        127000...127600, // Various asian characters
        65024...65039, // Variation selector
        9100...9300, // Misc items
        8400...8447: // Combining Diacritical Marks for Symbols
            return true
        default:
            return false
        }
    }
    
    /// SwifterSwift: Integer from character (if applicable).
    ///
    ///        Character("1").int -> 1
    ///        Character("A").int -> nil
    ///
    var int: Int? {
        return Int(String(target))
    }
    
    /// SwifterSwift: String from character.
    ///
    ///        Character("a").string -> "a"
    ///
    var string: String {
        return String(target)
    }
    
    /// SwifterSwift: Return the character lowercased.
    ///
    ///        Character("A").lowercased -> Character("a")
    ///
    var lowercased: Character {
        return String(target).lowercased().first!
    }
    
    /// SwifterSwift: Return the character uppercased.
    ///
    ///        Character("a").uppercased -> Character("A")
    ///
    var uppercased: Character {
        return String(target).uppercased().first!
    }
}

