def add_to_tree(node, parts):
    if not parts:
        return node

    if not node:
        node = {}

    (head, *tail) = parts
    if len(tail) > 0:
        node[head] = add_to_tree(node.get(head), tail)
    else:
        node[head] = None

    return node


def collapse_kv(key, value):
    if value and len(value) == 1:
        kk, kv = [*value.items()][0]
        return collapse_kv(key + "_" + kk, kv)
    else:
        return key, value


def collapse_node(node):
    if node is None:
        return

    nnode = {}
    for k, v in node.items():
        kk, kv = collapse_kv(k, v)
        nnode[kk] = collapse_node(kv)
    return nnode


def show_tree(node, indent=0):
    if node is None:
        return
    for key, value in node.items():
        print(" " * indent + key)
        show_tree(value, indent + 2)


root = None
with open("tmp/api", "r") as f:
    for line in f:
        parts = line.strip().split("_")
        root = add_to_tree(root, parts)

show_tree(collapse_node(root))
