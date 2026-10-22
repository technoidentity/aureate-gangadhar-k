use std::io;

struct Node {
    data: i32,
    left: Option<Box<Node>>,
    right: Option<Box<Node>>,
}

fn insert(root: &mut Option<Box<Node>>, value: i32) {
    if let Some(node) = root {
        if value < node.data {
            insert(&mut node.left, value);
        } else if value > node.data {
            insert(&mut node.right, value);
        }
    } else {
        *root = Some(Box::new(Node {
            data: value,
            left: None,
            right: None,
        }));
    }
}

fn inorder(root: &Option<Box<Node>>) {
    if let Some(node) = root {
        inorder(&node.left);
        print!("{} ", node.data);
        inorder(&node.right);
    }
}

fn main() {
    let mut root = None;
    let mut input = String::new();

    println!("Enter numbers:");
    io::stdin().read_line(&mut input).unwrap();

    for num in input.split_whitespace() {
        let number: i32 = num.parse().unwrap();
        insert(&mut root, number);
    }

    print!("Inorder: ");
    inorder(&root);
    println!();
}
