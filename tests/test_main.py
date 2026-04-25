from pytest import CaptureFixture

from main import main


def test_main_prints_greeting(capsys: CaptureFixture[str]) -> None:
    main()
    captured = capsys.readouterr()
    assert captured.out == "Hello from pyprojecttemplate!\n"
