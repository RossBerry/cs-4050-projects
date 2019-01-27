def sums_to_n(num):
    sums = []
    for n in range(1, num + 1):
        if num % n == 0 and n != num:
            sums.append([n for j in range(int(num / n))])
        if n != num:
            for k in range(n + 1, num + 1):
                sums_lst = sums[0][:-k] + [k]
                if sum(sums_lst) == num and sums_lst not in sums:
                    sums.append(sums_lst)
    return sums


def sum(lst):
    sum = 0
    for n in lst:
        sum += n
    return sum


def print_sums(sums):
    for sum in sums:
        line = ""
        for num in sum:
            line += str(num) + "+"
        line = line[:-1]
        print(line)

    
user_n = input("Enter n >> ")
sums = sums_to_n(int(user_n))
print_sums(sums)