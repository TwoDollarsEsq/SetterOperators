precedencegroup infixl0 {
    associativity: left
}

infix operator ..: infixl0
infix operator .=: infixl0

public func ..<Root, Value>(
    root: Root,
    keyPath: WritableKeyPath<Root, Value>
) -> (Value) -> Root {
    {
        var modified = root
        modified[keyPath: keyPath] = $0
        return modified
    }
}

public func ..<Root: AnyObject, Value>(
    root: Root,
    keyPath: ReferenceWritableKeyPath<Root, Value>
) -> (Value) -> Root {
    {
        root[keyPath: keyPath] = $0
        return root
    }
}

public func .=<Root, Value>(setter: (Value) -> Root, value: Value) -> Root {
    setter(value)
}
