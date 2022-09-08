-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.1 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity my_net_fc3_weight_rom is 
    generic(
             DWIDTH     : integer := 16; 
             AWIDTH     : integer := 10; 
             MEM_SIZE    : integer := 840
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of my_net_fc3_weight_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 => "1010101001010001", 1 => "1010100110110111", 2 => "0010100100010100", 
    3 => "0010110000111011", 4 => "0010111010101011", 5 => "1010110100111011", 
    6 => "1011000001010110", 7 => "1010110101011110", 8 => "0010110001110111", 
    9 => "0010111000110010", 10 => "1011000100101010", 11 => "0001100101000101", 
    12 => "1010111110011011", 13 => "1011001101101111", 14 => "1010010011000011", 
    15 => "1010101001101010", 16 => "1010101101011101", 17 => "1010011101111001", 
    18 => "1011001111011001", 19 => "1011000101100110", 20 => "1010110011001001", 
    21 => "1010110000001100", 22 => "0010010111011000", 23 => "1010101001100010", 
    24 => "0010111111100000", 25 => "1011011000001011", 26 => "1010000000100111", 
    27 => "0010100100001111", 28 => "0010100010111111", 29 => "0010111011100111", 
    30 => "0010101011111100", 31 => "1010110000000100", 32 => "1010111010101101", 
    33 => "0001101000010110", 34 => "0010110110000101", 35 => "1010100100010111", 
    36 => "1011000111011110", 37 => "0010100000100101", 38 => "1011010001000100", 
    39 => "0010111101110100", 40 => "1010110100101001", 41 => "1011000111110001", 
    42 => "1010100110000101", 43 => "1010100101110000", 44 => "1011000010101001", 
    45 => "0010111111000000", 46 => "1010111101101110", 47 => "1010011111011010", 
    48 => "0010111110110101", 49 => "1010110000101010", 50 => "1011001110001100", 
    51 => "0010111001101110", 52 => "1010010100011111", 53 => "0010010001100011", 
    54 => "1010111000001100", 55 => "1011001000011011", 56 => "1010110100011011", 
    57 => "1010111000001101", 58 => "0001110010110010", 59 => "0010101011011010", 
    60 => "0010001101001101", 61 => "0010110110111101", 62 => "0010001011100110", 
    63 => "0011000100111111", 64 => "1010111100000100", 65 => "0010100011101000", 
    66 => "1010010100101101", 67 => "0011000101110011", 68 => "1000101001111101", 
    69 => "0010101110011010", 70 => "0010110001010110", 71 => "1010111111011001", 
    72 => "0010111100111010", 73 => "1010110101000000", 74 => "1011000011010110", 
    75 => "1011000001011001", 76 => "0010110100110010", 77 => "1011001010001110", 
    78 => "1010001011111001", 79 => "1011000000111000", 80 => "0010100000010010", 
    81 => "1010111101110010", 82 => "1010011010110000", 83 => "1010101001111101", 
    84 => "1001110011010011", 85 => "1010011100101101", 86 => "1010110110010111", 
    87 => "1011001000101011", 88 => "0011000001011000", 89 => "1011001010001011", 
    90 => "0010110110111000", 91 => "1011001100001101", 92 => "0010110111110100", 
    93 => "0011000010010010", 94 => "1011001010110101", 95 => "0001111111001000", 
    96 => "0011000101001011", 97 => "0010111110010010", 98 => "0001111111110100", 
    99 => "1011000110101000", 100 => "1010111111011001", 101 => "1011001001001000", 
    102 => "1011001000011100", 103 => "1010100101110011", 104 => "1010111001111001", 
    105 => "1010110100110011", 106 => "0010110010111110", 107 => "1011000010111011", 
    108 => "1010111010111100", 109 => "1010111010111010", 110 => "0010110101100110", 
    111 => "0010110101000111", 112 => "0010100001100100", 113 => "1011001101100011", 
    114 => "1010011001001101", 115 => "1011010001100101", 116 => "1010000110111100", 
    117 => "1011000001001100", 118 => "1011000001010101", 119 => "1010011111000001", 
    120 => "1010111000011000", 121 => "1001111010011110", 122 => "0010011100101110", 
    123 => "0010111011100101", 124 => "0010111110110011", 125 => "1011001100101110", 
    126 => "1010101011011010", 127 => "0010010001101011", 128 => "1010111110010000", 
    129 => "1011000011101001", 130 => "0010111111100110", 131 => "1010000110100001", 
    132 => "0010100001101010", 133 => "1010010000011100", 134 => "1011000111101011", 
    135 => "1011000110010011", 136 => "0010101101110110", 137 => "0011000001100010", 
    138 => "1011010111100011", 139 => "1011000011100000", 140 => "1010110000101110", 
    141 => "1011010001010101", 142 => "1010110000110111", 143 => "1010101111011100", 
    144 => "0011001010010010", 145 => "0010111010000100", 146 => "1011001100011000", 
    147 => "1010101110100010", 148 => "0010110100011100", 149 => "0010111100000101", 
    150 => "0010100010011000", 151 => "1011000001001101", 152 => "1010110100010100", 
    153 => "1010110111111101", 154 => "1010100010101000", 155 => "0011001011011000", 
    156 => "0001001010111010", 157 => "1011010000110111", 158 => "0010011001111000", 
    159 => "0001011001100101", 160 => "1011001000001110", 161 => "1011000000110010", 
    162 => "0010110100001110", 163 => "1011000110100100", 164 => "1010101010110110", 
    165 => "0010110000011010", 166 => "1011000010010001", 167 => "0001111000000101", 
    168 => "0001110100110100", 169 => "1011000011100000", 170 => "1010110111111111", 
    171 => "0011001011010110", 172 => "1010111001110110", 173 => "0010010101000111", 
    174 => "1010110110011110", 175 => "1011001010000110", 176 => "0010110000011101", 
    177 => "1010110100100110", 178 => "0010101111001000", 179 => "1011010001101101", 
    180 => "1011000100110011", 181 => "0010011001000110", 182 => "1011000110001000", 
    183 => "0010110011011000", 184 => "0001000110111010", 185 => "1010110100000111", 
    186 => "0010111010101110", 187 => "0010100011001100", 188 => "1001101001111100", 
    189 => "1010111000101100", 190 => "1010101001101100", 191 => "0010101011000010", 
    192 => "0010010001011111", 193 => "0011000110011111", 194 => "1010111100000001", 
    195 => "1010110001011100", 196 => "1001111110011110", 197 => "0010000110001100", 
    198 => "0011000000000011", 199 => "1010010001110111", 200 => "1010110100010011", 
    201 => "0011000100111011", 202 => "0001111101001001", 203 => "0010110100100011", 
    204 => "1011001010101011", 205 => "1001111000110101", 206 => "0010110010000110", 
    207 => "1010011101001001", 208 => "0010110001011001", 209 => "0011001010000000", 
    210 => "1010010100101001", 211 => "0010111000001000", 212 => "1010100101110100", 
    213 => "0010110010101110", 214 => "0011000001010010", 215 => "0011001011100111", 
    216 => "1010110101000010", 217 => "0010111110010110", 218 => "0010001100101110", 
    219 => "1010110001101111", 220 => "1010101111010010", 221 => "0010110100111001", 
    222 => "0011000101111100", 223 => "1010011111101000", 224 => "0010110010110110", 
    225 => "1010110110011011", 226 => "1010101111110010", 227 => "0011000000001101", 
    228 => "1011000100110111", 229 => "0010111101101101", 230 => "0010111111001000", 
    231 => "0010110110110010", 232 => "1010000001111101", 233 => "0010101100101100", 
    234 => "1010111010101000", 235 => "1010111101000110", 236 => "1010011010010101", 
    237 => "0010110010001111", 238 => "0010010000110100", 239 => "1001101001010011", 
    240 => "0010001100010010", 241 => "0010111011110110", 242 => "0010111100101001", 
    243 => "1011000000001100", 244 => "0010100100011011", 245 => "1010101000010111", 
    246 => "1011001000101001", 247 => "1011000000111110", 248 => "1010110110101110", 
    249 => "1011000011010111", 250 => "1011000010000010", 251 => "1010011111111000", 
    252 => "0010101101001011", 253 => "0010110001110001", 254 => "1010000111100010", 
    255 => "1011000001111000", 256 => "1010110111011100", 257 => "1010111010001110", 
    258 => "0010111110101100", 259 => "1010010110111111", 260 => "1011000011001111", 
    261 => "0010001010111100", 262 => "1010010100101101", 263 => "1010011111101110", 
    264 => "1010111100001101", 265 => "1010101111100011", 266 => "0010011101000111", 
    267 => "0010110000101101", 268 => "0010101101010001", 269 => "0011000010001101", 
    270 => "0001101001011011", 271 => "0010011110001110", 272 => "0010110101111100", 
    273 => "0010010001001010", 274 => "0010010011101001", 275 => "1010100111110110", 
    276 => "1010110100111011", 277 => "0011000110011111", 278 => "1011000011010011", 
    279 => "1011001100100011", 280 => "0010111100001011", 281 => "1010110000011110", 
    282 => "1001111111101100", 283 => "1011000001010100", 284 => "0000110110101111", 
    285 => "0010010001011100", 286 => "0011000100000101", 287 => "1010111101000010", 
    288 => "0011000000001000", 289 => "1010010101010101", 290 => "1010101000000111", 
    291 => "0010100101111010", 292 => "0010101101101000", 293 => "0010110011000101", 
    294 => "0010001000000101", 295 => "1010110010111011", 296 => "0011000001111010", 
    297 => "0010100011011100", 298 => "1010010000001110", 299 => "1010110001101110", 
    300 => "1011000010100011", 301 => "1010000111011000", 302 => "1010101000011011", 
    303 => "1011000010001010", 304 => "0010101101100111", 305 => "0010101010011010", 
    306 => "0010110110000110", 307 => "1010110001001101", 308 => "1010011100110000", 
    309 => "0010110100100101", 310 => "1011001011100110", 311 => "0010111110101010", 
    312 => "1011000011101100", 313 => "1011001000011101", 314 => "0001111110110110", 
    315 => "1010011110010000", 316 => "0010100110100001", 317 => "1010100101011110", 
    318 => "1010110111100001", 319 => "0010101110010100", 320 => "1010100111111111", 
    321 => "1010100010111101", 322 => "0001110101001010", 323 => "0010011011110110", 
    324 => "1010110011111001", 325 => "1010101111010010", 326 => "1010110100000010", 
    327 => "0011000010000001", 328 => "0010111110001110", 329 => "1011000000100101", 
    330 => "1011001011011110", 331 => "0010111010011111", 332 => "1010100001001101", 
    333 => "1010100000001101", 334 => "1010111110111100", 335 => "0011000011101001", 
    336 => "0010101000011110", 337 => "0010111000001101", 338 => "1011000001100001", 
    339 => "0010101001111111", 340 => "1010111011110001", 341 => "1011000010110101", 
    342 => "0010110110101111", 343 => "1011000000100110", 344 => "1010011100011110", 
    345 => "1010110110111111", 346 => "0010110110001001", 347 => "1010000110100010", 
    348 => "1010111011100110", 349 => "1010110010001110", 350 => "0010110001001101", 
    351 => "1010010111001010", 352 => "1010100100111111", 353 => "0010110110101110", 
    354 => "0010000100010011", 355 => "1011000001110100", 356 => "1001011110100000", 
    357 => "0010101011011001", 358 => "1011000010101000", 359 => "1011010001000010", 
    360 => "0001111010000011", 361 => "0010110110010001", 362 => "0010110101010000", 
    363 => "1010111010000101", 364 => "0010101001110000", 365 => "0011001001111001", 
    366 => "0001010001000011", 367 => "1011001111100000", 368 => "1010010110111010", 
    369 => "1010100111110100", 370 => "1010111111001100", 371 => "1010100000010110", 
    372 => "1010110111011100", 373 => "0010000010000100", 374 => "0001110000101010", 
    375 => "1011010000100011", 376 => "1010101111101100", 377 => "1011000000111000", 
    378 => "0010100110111010", 379 => "0010101001111011", 380 => "0010110111010010", 
    381 => "1011000010000000", 382 => "1011010011100010", 383 => "1010110010001001", 
    384 => "0011000100100011", 385 => "0011000110010011", 386 => "1001101100000000", 
    387 => "0010001001101110", 388 => "1011000011001100", 389 => "1010111111110000", 
    390 => "0010111000010110", 391 => "1010000111001110", 392 => "1010110111000110", 
    393 => "1010001010000101", 394 => "1010001111011101", 395 => "0010100111110111", 
    396 => "0011000100110101", 397 => "0010100011010011", 398 => "0010111100000110", 
    399 => "1011001011101011", 400 => "1010111110110010", 401 => "1010101000011001", 
    402 => "1010100001001010", 403 => "1001111001001010", 404 => "1010100101000110", 
    405 => "1011001111111101", 406 => "0010110011110000", 407 => "0011000101001000", 
    408 => "1011000110101110", 409 => "0010110000110010", 410 => "0010110001100001", 
    411 => "0010111100110110", 412 => "1010011010100001", 413 => "0011001011111010", 
    414 => "1011000000011110", 415 => "0011001010110010", 416 => "1010110110111000", 
    417 => "1010111110111101", 418 => "1010010011110000", 419 => "1010111111000010", 
    420 => "1010111100100000", 421 => "0010111011011011", 422 => "0010101110100000", 
    423 => "1010111110101001", 424 => "0001111000000000", 425 => "1011001100111010", 
    426 => "0010110111010100", 427 => "1011000101111111", 428 => "1011000001010100", 
    429 => "1010110000000010", 430 => "1010101001001110", 431 => "1011000000011101", 
    432 => "1011000110000011", 433 => "1010001110011011", 434 => "1011001011011010", 
    435 => "0011000001110101", 436 => "0010110011111001", 437 => "0010110110001001", 
    438 => "1010001010110011", 439 => "0011000001100101", 440 => "0010101010111010", 
    441 => "1010101111001101", 442 => "0010111110010000", 443 => "0010011001001001", 
    444 => "0010000111101111", 445 => "1010110101111000", 446 => "0001111011000101", 
    447 => "1011000010110111", 448 => "1010101110001001", 449 => "1010100001000100", 
    450 => "0010110011111010", 451 => "1010111011011001", 452 => "1010100110011000", 
    453 => "1010101100000000", 454 => "1011000001111101", 455 => "1010100111101110", 
    456 => "0011000111011110", 457 => "1010110100100000", 458 => "0010111110111001", 
    459 => "1010111111111001", 460 => "1010011010011110", 461 => "1010101011011111", 
    462 => "1010110010010000", 463 => "0010011011001110", 464 => "0010111110001110", 
    465 => "1010111011110001", 466 => "0010110011101000", 467 => "1010111011111100", 
    468 => "1011000111011011", 469 => "1010110010001011", 470 => "0010110000000001", 
    471 => "1010110011100010", 472 => "1010101010110101", 473 => "1010110001111001", 
    474 => "0010111101101101", 475 => "0011001010010111", 476 => "1011001010001000", 
    477 => "0001110010000010", 478 => "0010010010000001", 479 => "1010000101010001", 
    480 => "0010100110110100", 481 => "1011000101010101", 482 => "0011000001001101", 
    483 => "0010100001011111", 484 => "0010010111111101", 485 => "1010111101110100", 
    486 => "1001101100101110", 487 => "1010110100001000", 488 => "1010011010111100", 
    489 => "0010110111000000", 490 => "0010100001000111", 491 => "1010010101011001", 
    492 => "1010111100101111", 493 => "0010101001011110", 494 => "1010101110110000", 
    495 => "1010010000101101", 496 => "0010000101110101", 497 => "1010101011010010", 
    498 => "1010111101100101", 499 => "0010101001101000", 500 => "1010110001111001", 
    501 => "1011000110000000", 502 => "1010010011110011", 503 => "0011000001000100", 
    504 => "1010111101101110", 505 => "0010100011011100", 506 => "1011000001010110", 
    507 => "1010010010001110", 508 => "1011000101000001", 509 => "1011001101010110", 
    510 => "1011000110001100", 511 => "0010000100110100", 512 => "1010111110000000", 
    513 => "1011001010100010", 514 => "0010111001000111", 515 => "1010111111000111", 
    516 => "1010110101101000", 517 => "0010111100010011", 518 => "1010011100000011", 
    519 => "0010110111000001", 520 => "1011000000000111", 521 => "0010111000001011", 
    522 => "0010111011111110", 523 => "0011001001010101", 524 => "0010110010100111", 
    525 => "1010100001010111", 526 => "0010111000011000", 527 => "1010010001100110", 
    528 => "1011010000110111", 529 => "0010010011111101", 530 => "1011001001100011", 
    531 => "1011000011001100", 532 => "0011001111000101", 533 => "1011000001110011", 
    534 => "1011010100010001", 535 => "1011010000010011", 536 => "1010101010011100", 
    537 => "1010101100001110", 538 => "1010111010111110", 539 => "0001010100000010", 
    540 => "0010110010111110", 541 => "1010110011110111", 542 => "0011000010101111", 
    543 => "0010110111101010", 544 => "1011000000011001", 545 => "0010110110011001", 
    546 => "0010100110110101", 547 => "1010001101000011", 548 => "1011000110011000", 
    549 => "0010011010001001", 550 => "1010111011010110", 551 => "0010111111001110", 
    552 => "1010111111100000", 553 => "1011000101001101", 554 => "1010001011110100", 
    555 => "1010110011001110", 556 => "1010010001011110", 557 => "0010111111010001", 
    558 => "1010100011101010", 559 => "1010111110011100", 560 => "1010111110110011", 
    561 => "1011000110000100", 562 => "1011001110011011", 563 => "1010110011111110", 
    564 => "0011000100111111", 565 => "1010011110100010", 566 => "1010101110110110", 
    567 => "0010100111111101", 568 => "1010111010010110", 569 => "1010110000010000", 
    570 => "1010101110011011", 571 => "0010101111110101", 572 => "0010101001000100", 
    573 => "1011000111010010", 574 => "1010010110001111", 575 => "1011000111011010", 
    576 => "1010110100100101", 577 => "0011000010101100", 578 => "0011000011111100", 
    579 => "0010111001101100", 580 => "0010111100101001", 581 => "0010110111011111", 
    582 => "1001110010100010", 583 => "1010111011011101", 584 => "1010110011000111", 
    585 => "1010100101110110", 586 => "1011000101101100", 587 => "1011000001010000", 
    588 => "1010110101101111", 589 => "0010101011100110", 590 => "0010110011001010", 
    591 => "1011000101011010", 592 => "1011000100110000", 593 => "0010110110101010", 
    594 => "1011000111110010", 595 => "1010110111010111", 596 => "1011000001111011", 
    597 => "0011000001001000", 598 => "0010111000010011", 599 => "1010101010101111", 
    600 => "1010110110000000", 601 => "1011000011111010", 602 => "1011001000011000", 
    603 => "1001110101110110", 604 => "0010110000010111", 605 => "0010111100101111", 
    606 => "0001010011010101", 607 => "1011001001011111", 608 => "1010110111111100", 
    609 => "0001100100101100", 610 => "1011000111011010", 611 => "1011000010101101", 
    612 => "0010101111101001", 613 => "1010110000111010", 614 => "0010111001010111", 
    615 => "0010111000010110", 616 => "1011010011001100", 617 => "0010111111100011", 
    618 => "0010100001011001", 619 => "1011001011011010", 620 => "1011001110010010", 
    621 => "1010110010110110", 622 => "1010111111001000", 623 => "1011000001011100", 
    624 => "1010001101010000", 625 => "0010100111010000", 626 => "1010110000110011", 
    627 => "1011000000100011", 628 => "1011000001011001", 629 => "0010101101011111", 
    630 => "1010100101110010", 631 => "0010100000001010", 632 => "0010100100001010", 
    633 => "1010111110111111", 634 => "0010101011111010", 635 => "1010110100011100", 
    636 => "1011001101010100", 637 => "0011000000011001", 638 => "0010011101000110", 
    639 => "0001110001100101", 640 => "0011000101110100", 641 => "1011000100010100", 
    642 => "1010100111000101", 643 => "0011000100010010", 644 => "0010010100100000", 
    645 => "1010110100110010", 646 => "0011001001100101", 647 => "1011000111100011", 
    648 => "1010110011100110", 649 => "1010111111110010", 650 => "1011000010101110", 
    651 => "1011001011001100", 652 => "0010111110101111", 653 => "1010110111111000", 
    654 => "0001110111011011", 655 => "0010101111111000", 656 => "0010100100011101", 
    657 => "0010001111000101", 658 => "1010101010100000", 659 => "1010011110000001", 
    660 => "1011000001000111", 661 => "0010111000110111", 662 => "1010000111100111", 
    663 => "1010010001010111", 664 => "0010110001000100", 665 => "1010110111110001", 
    666 => "1011001000111101", 667 => "1010101101101000", 668 => "1010010000001010", 
    669 => "0010010011101000", 670 => "0010000111001010", 671 => "0010110001000101", 
    672 => "1010110100110111", 673 => "1011010010100111", 674 => "0011001000110011", 
    675 => "1010100001101101", 676 => "1010000010100010", 677 => "1011001100011101", 
    678 => "0001000100101111", 679 => "0010011000010110", 680 => "0010111011101011", 
    681 => "0010111100010001", 682 => "1011000001111001", 683 => "0010011001110100", 
    684 => "0010100111101110", 685 => "1001110101011110", 686 => "0011000110010100", 
    687 => "1011001001101010", 688 => "1010100010101011", 689 => "1011001100000001", 
    690 => "0011010100101111", 691 => "1011010010000101", 692 => "0010100110000000", 
    693 => "1010111110010000", 694 => "1011000111110100", 695 => "0011000000111110", 
    696 => "1010111010111000", 697 => "1011000100110101", 698 => "0010111110100111", 
    699 => "1011001010110101", 700 => "1010110010101111", 701 => "1010111010111100", 
    702 => "1010111101010101", 703 => "0010111111010000", 704 => "1010110110100010", 
    705 => "1010010000011110", 706 => "1010110101100111", 707 => "1010010011110000", 
    708 => "0011001010001110", 709 => "1010000100110001", 710 => "1011001111011001", 
    711 => "0010111000011000", 712 => "1011010100110110", 713 => "1010110010000110", 
    714 => "1010110011101000", 715 => "1011000000001011", 716 => "1010101100110011", 
    717 => "0011000001111101", 718 => "0010011100101001", 719 => "0010111110100101", 
    720 => "0010111000110001", 721 => "1011001101000000", 722 => "1011010100101000", 
    723 => "0011000011001100", 724 => "1010110010011110", 725 => "0001101001100011", 
    726 => "1011000101101111", 727 => "0010111011101000", 728 => "0010111001111000", 
    729 => "0011001011100100", 730 => "0010101001110011", 731 => "0010100110000000", 
    732 => "1010100010011000", 733 => "1010011000111000", 734 => "0010011110010001", 
    735 => "1011010000000011", 736 => "1010111101001010", 737 => "0010110110111110", 
    738 => "1010101110011010", 739 => "1011010000110000", 740 => "1010011111101010", 
    741 => "0010100101110110", 742 => "0010010010110100", 743 => "1011001110110011", 
    744 => "1010110100100001", 745 => "1011001010000111", 746 => "1011001001101100", 
    747 => "0010101010110101", 748 => "1010110000110001", 749 => "1010100100110000", 
    750 => "1001111010001010", 751 => "1010111010110110", 752 => "0010110111100111", 
    753 => "1010100011011011", 754 => "0010011000110010", 755 => "1011000111000010", 
    756 => "0010110000010010", 757 => "1010111000111011", 758 => "1010111101101000", 
    759 => "1010101010001110", 760 => "0010111011011000", 761 => "1011010000000101", 
    762 => "1010101100000000", 763 => "1011000111111110", 764 => "0010101001101001", 
    765 => "0010110011010010", 766 => "1011000110011110", 767 => "0010110010111101", 
    768 => "0010110110010011", 769 => "0010110101011000", 770 => "0010111000110011", 
    771 => "1011001010011011", 772 => "1010101010100110", 773 => "1010101100001000", 
    774 => "1010100011101100", 775 => "0010110011111100", 776 => "1010110110101010", 
    777 => "1010110100100001", 778 => "0011000110101010", 779 => "1010111000001011", 
    780 => "1011001011011001", 781 => "0010001000111000", 782 => "1010110001101101", 
    783 => "0010100111010010", 784 => "1011000001101010", 785 => "1011001010111011", 
    786 => "1011000001101010", 787 => "0010000110001010", 788 => "0010111100101101", 
    789 => "0010101101001100", 790 => "1010100000011101", 791 => "1001010110010100", 
    792 => "1011000100110111", 793 => "1010110010010110", 794 => "0011000000011001", 
    795 => "0010111100010000", 796 => "1010010111011001", 797 => "1011000101001000", 
    798 => "0010011010011000", 799 => "0001110110101011", 800 => "0010011011000001", 
    801 => "1010111010100110", 802 => "1011000011000010", 803 => "1011001001110010", 
    804 => "0010110100100100", 805 => "1010011001110110", 806 => "1001100110011001", 
    807 => "1011000100110010", 808 => "1010111010000110", 809 => "0010110000101111", 
    810 => "1010111110000101", 811 => "1010111101100110", 812 => "0010111101000010", 
    813 => "0010111011000101", 814 => "0011000101111101", 815 => "1011010000010011", 
    816 => "1011000101111011", 817 => "1010111000101000", 818 => "1011001101100111", 
    819 => "1010001110110110", 820 => "0010110111100000", 821 => "0001111000110010", 
    822 => "1010011011000110", 823 => "0010111000010101", 824 => "1010101001011001", 
    825 => "0010011001110010", 826 => "0010100111010111", 827 => "0010100011011101", 
    828 => "1010010111011010", 829 => "0010000001100111", 830 => "1011010000000101", 
    831 => "1011001010010011", 832 => "1011010011100000", 833 => "1011010000011001", 
    834 => "0010100111110010", 835 => "1011001100010110", 836 => "1010100001001000", 
    837 => "0010100000100010", 838 => "1010110111111111", 839 => "0011000001001000" );


begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity my_net_fc3_weight is
    generic (
        DataWidth : INTEGER := 16;
        AddressRange : INTEGER := 840;
        AddressWidth : INTEGER := 10);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of my_net_fc3_weight is
    component my_net_fc3_weight_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    my_net_fc3_weight_rom_U :  component my_net_fc3_weight_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


