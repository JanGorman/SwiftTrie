//
//  Copyright (c) 2014 Jan Gorman. All rights reserved.
//

import Foundation

class TrieNode {

    private var parent: TrieNode?
    var children = [Character:TrieNode]()
    private var char: Character?
    private var isLeaf = true
    private var isWord = false

    init() {
    }

    convenience init(char: Character, parent: TrieNode) {
        self.init()
        self.char = char
        self.parent = parent
    }

    func insert(word: String) {
        isLeaf = false
        let firstChar = word[word.startIndex]
        addChildNodeForChar(firstChar)

        if countElements(word) > 1 {
            addWordToChildNode(word, atChar: firstChar)
        } else {
            children[firstChar]?.isWord = true
        }
    }

    private func addChildNodeForChar(char: Character) {
        if children[char] as TrieNode! == nil {
            let childNode = TrieNode(char: char, parent: self)
            children[char] = childNode
        }
    }

    private func addWordToChildNode(word: String, atChar char: Character) {
        let index = advance(word.startIndex, 1)
        children[char]?.insert(word.substringFromIndex(index))
    }

    func nodeForCharacter(char: Character) -> TrieNode? {
        return children[char]
    }

    func words() -> [String] {
        var words = [String]()
        if isWord {
            words.append(asString())
        }
        if !isLeaf {
            for child in children.values {
                for word in child.words() {
                    words.append(word)
                }
            }
        }
        return words
    }

    func asString() -> String {
        if parent == nil {
            return ""
        }
        return parent!.asString() + char!
    }

}