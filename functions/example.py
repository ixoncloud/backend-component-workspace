from ixoncdkingress.function.context import FunctionContext

@FunctionContext.expose
def greet(context: FunctionContext, name: str = 'person'):
    """
    A simple example function that greets someone.
    """
    del context

    return f'Greetings {name}!'
