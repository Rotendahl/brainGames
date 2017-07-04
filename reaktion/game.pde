class Node {
    int xPos, yPos, number;
    boolean goal, active, wrong;

    Node(x, y) {
        this.xPos = x;
        this.yPos = y;
        this.number = round(random(10, 99));
        this.active = false;
        this.wrong = false;
        this.goal = false;
    }
    boolean isClicked(xInput, yInput) {
        return xInput > xPos && xInput < xPos + ringRed.width &&
            yInput > yPos && yInput < yPos + ringRed.width;
    }

    void drawNode() {
        if (this.active) {
            textSize(Hline.height * 3);
            if (this.wrong) {
                image(ringRed, this.xPos, this.yPos);
                text(number, xPos + ringRed.width / 2, yPos + ringRed.height / 2);
            } else if (this.goal) {
                image(ringYellow, this.xPos, this.yPos);
                text(number, xPos + ringRed.width / 2, yPos + ringRed.height / 2);
            } else {
                image(ringGreen, this.xPos, this.yPos);
                text(number, xPos + ringRed.width / 2, yPos + ringRed.height / 2);
            }
        } else {
            image(ringBlue, this.xPos, this.yPos);
        }
    }
}


class Board {
    Node[] nodes;
    int active;
    int minX = Hline.width;
    int maxX = width - Hline.width - ringRed.width;
    int midX = width * 0.5 - ringRed.width / 2;
    int midY = height * 0.5 - ringRed.height / 2;
    int rWid = ringRed.width / 2;
    int corretLeft;
    Board() {
        active = -1;
        genNodes();
        corretLeft = -1;
    }

    void genNodes() {
        nodes = {
            new Node(minX, Vline.height), // Top left
            new Node(maxX, Vline.height), // Top Right
            new Node(minX * 5, height * 0.2), // Top mid left
            new Node(maxX - minX * 5 + rWid, height * 0.2), // Top mid right
            new Node(minX + rWid, midY), // mid left
            new Node(maxX - rWid, midY), // mid right
            new Node(midX, midY), // mid mid
            new Node(minX * 5, height * 0.7), // Low mid left
            new Node(maxX - minX * 5 + rWid, height * 0.7), // Low mid right
            new Node(minX, height - Vline.height - rWid * 2), // bot left
            new Node(maxX, height - Vline.height - rWid * 2) // bot right
        }
    }

    void drawline(n1, n2) {
        strokeWeight(rWid / 4);
        stroke(73, 172, 218);
        line(nodes[n1].xPos + rWid, nodes[n1].yPos + rWid * 2 - rWid / 3,
            nodes[n2].xPos + rWid, nodes[n2].yPos + rWid / 2);

        line(nodes[n2].xPos + rWid, nodes[n2].yPos + rWid * 1.5,
            nodes[n1].xPos + rWid, nodes[n1].yPos + rWid / 3);
    }

    void drawBoard() {
        drawline(0, 2);
        drawline(2, 4);
        drawline(4, 9);
        drawline(9, 7);
        drawline(7, 6);
        drawline(6, 8);
        drawline(8, 10);
        drawline(10, 5);
        drawline(5, 3);
        drawline(3, 1);
        drawline(0, 1);
        for (i = 0; i < nodes.length; i++) {
            nodes[i].drawNode();
        }
    }

    void scaleBoard() {
        int[] nrs = new int[nodes.length];
        for (i = 0; i < nodes.length; i++) {
            nrs[i] = nodes[i].number;
        }
        genNodes();
        for (i = 0; i < nodes.length; i++) {
            nodes[i].number = nrs[i];
        }
    }
}
