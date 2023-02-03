from ixoncdkingress.cbc.context import CbcContext

def greet(context: CbcContext, name: str = 'person'):
    """
    A simple example function that greets someone.
    """
    del context

    return f'Greetings {name}!'
