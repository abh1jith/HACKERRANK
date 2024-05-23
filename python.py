/* GROWTH IN 2 DIMENSIONS
 * CODE BY ABHIJITH DAMERUPPALA
 */
'use strict';

const fs = require('fs');

process.stdin.resume();
process.stdin.setEncoding('utf-8');

let inputString = '';
let currentLine = 0;

process.stdin.on('data', function(inputStdin) {
    inputString += inputStdin;
});

process.stdin.on('end', function() {
    inputString = inputString.split('\n');

    main();
});

function readLine() {
    return inputString[currentLine++];
}



/*
 * Complete the 'countMax' function below.
 *
 * The function is expected to return a LONG_INTEGER.
 * The function accepts STRING_ARRAY upRight as parameter.
 */

function countMax(upRight) {
    // Write your code here
    let minRow = Infinity;
    let minCol = Infinity;
    
    for (let i = 0; i < upRight.length; i++) {
        const [r, c] = upRight[i].split(" ").map(Number);
        minRow = Math.min(minRow, r);
        minCol = Math.min(minCol, c);
    }
    
    return minRow * minCol;

}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);

    const upRightCount = parseInt(readLine().trim(), 10);

    let upRight = [];

    for (let i = 0; i < upRightCount; i++) {
        const upRightItem = readLine();
        upRight.push(upRightItem);
    }

    const result = countMax(upRight);

    ws.write(result + '\n');

    ws.end();
}
