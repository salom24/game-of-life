
struct Cell {x: i32, y: i32, value: i8}

struct World {cells: Vec<Cell>}
impl World {
    fn new() -> World {
        World{cells: Vec::new()}
    }
    fn add(&mut self, x: i32, y: i32) {
        if self.index(x, y).is_none() {
            self.cells.push(Cell{x, y, value: 0});
        }
    }
    fn remove(&mut self, x: i32, y: i32) {
        if let Some(i) = self.index(x, y) {
            self.cells.remove(i);
        }
    }
    fn index(&self, x: i32, y: i32) -> Option<usize> {
        return self.cells.iter().position(|c| c.x == x && c.y == y);
    }
    fn value_add(&mut self, x: i32, y: i32) {
        match self.index(x, y) {
            Some(i) => self.cells[i].value += 1,
            None => {
                self.add(x, y);
                self.value_add(x, y)
            }
        };
    }
    fn draw(&self) {
        let mut board: [String;20] = Default::default();
        for y in 0..20 {
            for x in 0..20 {
                match self.index(x, y) {
                    Some(_) => board[y as usize].push_str("* "),
                    None => board[y as usize].push_str("  ")
                }
            }
        }
        for line in &board {
            println!("{}", line);
        }
    }
    fn step(&mut self) {
        let mut nb = World::new();
        for c in &self.cells {
            for x in (c.x-1)..=(c.x+1) {
                for y in (c.y-1)..=(c.y+1) {
                    if x != c.x || y != c.y {
                        nb.value_add(x, y);
                    } else {
                        nb.add(x, y);
                    }
                }
            }
        }
        for c in &nb.cells {
            if c.value == 3 {
                self.add(c.x, c.y);
            } else if c.value != 2 {
                self.remove(c.x, c.y);
            }
        }
    }
}


use std::time::Duration;
use std::thread::sleep;

fn main() {
    let mut world = World::new();
    world.add(3, 6);
    world.add(4, 6);
    world.add(5, 6);
    world.add(6, 6);
    world.add(7, 6);
    world.add(8, 6);
    world.add(9, 6);
    loop {
        world.draw();
        sleep(Duration::from_millis(500));
        world.step();
    }
}
