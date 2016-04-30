function result = nonRepeatingRand(top, count)

    diff = randi(top - 1, 1, count);
    result = rem(cumsum(diff) + randi(1, 1, count) - 1, top) + 1;

end