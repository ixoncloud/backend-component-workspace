from ixoncdkingress.function.context import FunctionContext

@FunctionContext.expose
def greet(context: FunctionContext, name: str = 'person'):
    """
    A simple example function that greets someone.
    """
    return f'Greetings {name}, my username is {context.config["serviceAccount"]["username"]}!'
