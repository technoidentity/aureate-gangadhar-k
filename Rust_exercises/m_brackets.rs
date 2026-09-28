pub fn brackets_are_balanced(string: &str) -> bool {
    let mut stack = Vec::new();

    for ch in string.chars() {
        match ch {
            '(' | '[' | '{' => stack.push(ch),

            ')' => {
                if stack.pop() != Some('(') {
                    return false;
                }
            }

            ']' => {
                if stack.pop() != Some('[') {
                    return false;
                }
            }

            '}' =>  {
                if stack.pop() != Some('{') {
                    return false;
                }
            }

            _ => {}
        }
    }

    stack.is_empty()
}
fn main() {
    println!("{}", brackets_are_balanced("{what is (42)}?"));
    println!("{}", brackets_are_balanced("[text}"));
    println!("{}", brackets_are_balanced("([]{})"));
}
