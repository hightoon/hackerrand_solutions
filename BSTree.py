#!/usr/bin/python

"""
    implementation of binary search tree
    reference: 
        http://cslibrary.stanford.edu/110/BinaryTrees.html
"""

# Node data structure
class Node:
    def __init__(self, data):
        self.left = None
        self.right = None
        self.data = data

    def __str__(self):
        return "Node:%s"%(str(self.data))  


class BSTree:
    def __init__(self, data=None):
        self._root = data 

    def get_node(self, data):
        return self._get_node(self._root, data)
    
    def _get_node(self, node, data):
        if node is None:
            return None
        if node.data == data:
            return node
        elif data < node.data:
            return self._get_node(node.left, data)
        else:
            return self._get_node(node.right, data) 

    def insert(self, data):
        if self._root is None:
            self._root = Node(data)
        else:
            self._insert(self._root, data)

    def _insert(self, node, data):
        if node is None:
            return
        if data < node.data:
            if node.left is None:
                node.left = Node(data)
            else:
                self._insert(node.left, data)
        else:
            if node.right is None:
                node.right = Node(data)
            else:
                self._insert(node.right, data)

    def create(self, data):
        "create tree by insert root node"
        self._root = Node(data)

    def traverse(self, node):
        if node is None:
            return
        else:
            print node.data
            self.traverse(node.left)
            #print node.data 
            self.traverse(node.right)
            #print node.data

    def depth(self, start_node, end_node):
        if start_node is None or end_node is None:
            return 0
        if start_node.data < end_node.data:
            #print start_node.data, end_node.data
            return 1 + self.depth(start_node.right, end_node)
        elif start_node.data > end_node.data:
            #print start_node.data, end_node.data
            return 1 + self.depth(start_node.left, end_node)
        else:
            return 0
    
    def path_length(self, data1, data2):
        return self._node_path_length(self.get_node(data1),
                                      self.get_node(data2))

    def _node_path_length(self, node1, node2):
        "path length from node1 to node2" 
        return self._path_len(self._root, node1, node2)

    def _path_len(self, node, node1, node2):
        if node is None or node1 is None or node2 is None:
            return 0
        if (node1.data < node.data and node2.data > node.data) or\
           (node1.data > node.data and node2.data < node.data):
            return self.depth(node, node1) + self.depth(node, node2)
        elif node1.data < node.data and node2.data < node.data:
            return 1 + self._path_len(node.left, node1, node2)
        elif node1.data > node.data and node2.data > node.data:
            return 1 + self._path_len(node.right, node1, node2)
        elif node.data == node1.data:
            return self.depth(node, node2)
        elif node.data == node2.data:
            return self.depth(node, node1)

    @property
    def root(self):
        return self._root
        

if __name__ == '__main__':
    bt = BSTree()
    #bt.create(7)
    #for i in xrange(5):
    #    bt.insert(bt.root, i)
    #for i in xrange(8,12):
    #    bt.insert(bt.root, i)
    #bt.traverse(bt.root) 
    #print bt.path_length(Node(1), Node(3))
    #n = bt.get_node(3)
    #print n.data
    #print "path length of 3, 10: %d"%(bt.path_length(3, 10))
    num_of_nodes = int(raw_input('').strip())
    data = [int(x) for x in raw_input('').strip().split()]
    for d in data:
        bt.insert(d)
    bt.traverse(bt.root)
 


