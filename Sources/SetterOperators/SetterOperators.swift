precedencegroup infixl0 {
    associativity: left
}

infix operator ..: infixl0
infix operator .=: infixl0

/// Dives into instance using provided keyPath and creates a setter that expects value to set.
/// - Warning: This overload is for value-types and it creates a copy of an instance for each setting.
/// - Parameter root: Instance to create a setter for.
/// - Parameter keyPath: Specifies a path that should be updated in setter.
/// - Returns: A setter-closure that expects a value and returns updated instance.
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

/// Dives into instance using provided keyPath and creates a setter that expects value to set.
/// - Warning: This overload is for reference-types so it updates values in place capturing root object.
/// - Parameter root: Object to create a setter for.
/// - Parameter keyPath: Specifies a path that should be updated in setter.
/// - Returns: A setter-closure that expects a value and returns updated object.
public func ..<Root: AnyObject, Value>(
    root: Root,
    keyPath: ReferenceWritableKeyPath<Root, Value>
) -> (Value) -> Root {
    {
        root[keyPath: keyPath] = $0
        return root
    }
}

/// Combines a setter-closure with a new value to set.
/// - Parameter setter: A setter-closure that expects for parameter.
/// - Parameter value: A new value that should be set with setter-closer.
/// - Returns: Updated `Root` instance.
public func .=<Root, Value>(setter: (Value) -> Root, value: Value) -> Root {
    setter(value)
}
