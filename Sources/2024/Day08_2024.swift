import Algorithms

struct Day08_2024: AdventChallenge {
    static var year: Int { 2024 }

    var data: String
    
    struct Network{
        struct Node: Equatable {
            let element: String
            let left: String
            let right: String
            
            init(from line: String) {
                let components = line.components(separatedBy: " = ")
                let directions = components.last!
                    .dropFirst() // Remove (
                    .dropLast() // Remove )
                    .components(separatedBy: ", ")
                
                self.element = components.first!
                self.left = directions.first!
                self.right = directions.last!
            }
        }
        
        let instructions: String
        let nodes: [String: Node]
        
        init(from lines: [String]) {
            self.instructions = lines.first!
            let nodes = lines.dropFirst(1).map { Node(from: $0) }
            
            self.nodes = Dictionary(uniqueKeysWithValues: zip(nodes.map { $0.element }, nodes))
        }
        
        func determinePathLength(from node: Network.Node,
                                 to targetReached: (Network.Node) -> Bool) -> Int {
            var steps = 0
            var node = node
            while true {
                for instruction in self.instructions {
                    steps += 1
                    switch instruction {
                    case "R": 
                        node = self.nodes[node.right]!
                    case "L": 
                        node = self.nodes[node.left]!
                    default: 
                        assertionFailure("Invalid instruction")
                    }
                    if targetReached(node) {
                        return steps
                    }
                }
            }
        }
    }
    
    func part1() -> Any {
        let network = Network(from: self.data.components(separatedBy: "\n").filter { !$0.isEmpty })
        
        let startNode = network.nodes["AAA"]!
        let endNode = network.nodes["ZZZ"]!
        
        return network.determinePathLength(from: startNode) { $0 == endNode }
    }
    
    func part2()-> Any {
        let network = Network(from: self.data.components(separatedBy: "\n").filter { !$0.isEmpty })
        
        let nodes = network.nodes.values.filter { $0.element.hasSuffix("A") }

        let lengths = nodes.map {
            network.determinePathLength(from: $0, 
                                        to: { $0.element.hasSuffix("Z") })
        }
        
        return lengths.reduce(into: 1) {
            $0 = Utils.lowestCommonMultiple($0, $1)
        }
    }
}
