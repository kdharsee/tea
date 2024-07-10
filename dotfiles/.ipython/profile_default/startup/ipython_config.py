try:
    from IPython.core import ultratb
    ultratb.VerboseTB._tb_highlight = "bg:ansired"
except Exception:
    print("Error patching background color for tracebacks, they'll be the ugly default instead")
