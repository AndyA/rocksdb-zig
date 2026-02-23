from functools import reduce


def common_prefix(names: list[str]) -> str:
    def common(a: list[str], b: list[str]) -> list[str]:
        lim = min(len(a), len(b))
        for i in range(lim):
            if a[i] != b[i]:
                return a[:i]
        return a[:lim]

    assert len(names) > 0
    parts = [n.split("_") for n in names]
    prefix = reduce(common, parts)
    return "_".join(prefix)


def pascal_case(name: str) -> str:
    return "".join([part.title() for part in name.split("_")])


def camel_case(name: str) -> str:
    if name == "":
        return name
    pascal = pascal_case(name)
    return pascal[0:1].lower() + pascal[1:]
