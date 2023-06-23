use array::ArrayTrait;

#[derive(Component, Copy, Drop, Serde)]
#[component(indexed = true)]
struct Rectangle {
    height: u8,
    width: u8, 
}

#[derive(Component, Copy, Drop, Serde)]
struct Position {
    x: u8,
    y: u8,
}

#[derive(Component, Copy, Drop, Serde)]
struct ShapePosition {
    z1: Position,
    z2: Position,
    z3: Position,
    z4: Position,
}

#[derive(Component, Copy, Drop, Serde)]
enum Shape {
    Square: (),
    Line: (),
}

#[derive(Component, Copy, Drop, Serde)]
enum Orientation {
    North: (),
    East: (),
    South: (),
    West: (),
}

trait PositionCalculator {
    fn square_default() -> ShapePosition;
    fn line_east_default() -> ShapePosition;
    fn line_north_default() -> ShapePosition;
}

impl Coordinates of PositionCalculator {
    fn square_default() -> ShapePosition {
        ShapePosition {
            z1: Position { x: 0, y: 0 },
            z2: Position { x: 0, y: 1 },
            z3: Position { x: 1, y: 0 },
            z4: Position { x: 1, y: 1 },
        }
    }

    fn line_east_default() -> ShapePosition {
        ShapePosition {
            z1: Position { x: 0, y: 0 },
            z2: Position { x: 0, y: 1 },
            z3: Position { x: 0, y: 2 },
            z4: Position { x: 0, y: 3 },
        }
    }

    fn line_north_default() -> ShapePosition {
        ShapePosition {
            z1: Position { x: 0, y: 0 },
            z2: Position { x: 1, y: 0 },
            z3: Position { x: 2, y: 0 },
            z4: Position { x: 3, y: 0 },
        }
    }

    // non-default positions will be based on random values,
    // making sure the shape fits in the box width wise, and
    // the height will be the same for (shape, orientation).
}

