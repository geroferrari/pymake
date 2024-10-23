from pymake.main import hello

def test_main():
    assert hello() == "Hello, World!"

def test_main_fail():
    assert hello() != "Hello"