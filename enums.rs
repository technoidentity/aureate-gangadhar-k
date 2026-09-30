enum Directions{
    up,
    down,
    right,
    left,
}
fn main(){
    let directions = Directions::up;
    match directions {
        Directions::up => println!("Up"),
        Directions::down => println!("Down"),
        Directions::right => println!("Right"),
        Directions::left => println!("Left"),
    }
}
