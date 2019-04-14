from itertools import combinations


def main(list_, val):
    for i in range(2, len(list_) + 1):
        for vals in combinations(list_, i):
            if sum(vals) == val:
                return list(vals)
                

print(main([1, 14, 2, 3, 4, 5, 6, 8, 9], 6))