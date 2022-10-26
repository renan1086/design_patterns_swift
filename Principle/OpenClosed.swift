import Foundation

class Product {
    var name: String
    var color: Color
    var size: Size

    init(_ name: String,_ color: Color,_ size: Size) {
        self.name = name
        self.color = color
        self.size = size
    }
}

protocol Specification {
    associatedtype T
    func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ items: [T], _ spec: Spec) -> [T]
    where Spec.T == T;
}

class ColorSpecification: Specification {
    typealias T = Product
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.color == color
    }
}

class SizeSpecification: Specification {
    typealias T = Product
    let size: Size
    
    init(size: Size) {
        self.size   = size
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.size == size
    }
}

class AndSpecification<T, SpecA:Specification, SpecB: Specification> : Specification
where SpecA.T == SpecB.T, T == SpecA.T, T == SpecB.T
{
    let first: SpecA
    let second: SpecB

    init(first: SpecA, second: SpecB) {
        self.first = first
        self.second = second
    }

    func isSatisfied(_ item: T) -> Bool {
        return first.isSatisfied(item) && second.isSatisfied(item)
    }
}

class BetterFilter : Filter {
    
    
    typealias T = Product
    
    func filter<Spec>(_ items: [Product], _ spec: Spec) -> [Product] where Spec : Specification, Product == Spec.T {
        var result = [Product]()
        for item in items
        {
            if spec.isSatisfied(item) {
                result.append(item)
            }
        }
       return result
    }
}
