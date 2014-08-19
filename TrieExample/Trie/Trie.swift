//
//  Copyright (c) 2014 Jan Gorman. All rights reserved.
//

import Foundation

public struct Trie {

    private var rootNode = TrieNode()

    public init() {
    }

    public mutating func insert(word: String) {
        rootNode.insert(word)
    }

    public mutating func remove(word: String) {
        let filteredWords = allWords().filter { $0 != word }
        if filteredWords.count == 0 {
            rootNode = TrieNode()
        } else {
            for word in filteredWords {
                rootNode.insert(word)
            }
        }
    }

    private func allWords() -> [String] {
        var allWords = [String]()
        for node in rootNode.children.values {
            allWords += node.words()
        }
        return allWords
    }

    public func wordsForPrefix(prefix: String) -> [String]? {
        var lastNode = rootNode
        for character in prefix {
            if let aNode = lastNode.nodeForCharacter(character) {
                lastNode = aNode
            }
        }
        return lastNode === rootNode ? nil : lastNode.words()
    }

}