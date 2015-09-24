import types
import functools

queue = []

def enque(queue, enable_bullseye=False):
    def wrapper(func):
        @functools.wraps(func)
        def decorated(*args, **kwargs):
            ret = func(*args, **kwargs)
            context = kwargs.get('context', None) or func.func_defaults[0]
            if context:
                print('do something with %r' % context)
            return ret
        # queue the original function anyway
        queue.append(func)
        # if bullseye enabled, queue the decorated too
        if enable_bullseye:
            decorated.__BULLSEYE_ENABLED__ = True
            queue.append(decorated)
        return func
    return wrapper


class IAContext:
    pass


class Foo:

    @enque(queue)
    def bar_1(self, context=IAContext):
        print(context)

    @enque(queue, enable_bullseye=True)
    def bar_2(self, context=IAContext):
        print(context)

    @enque(queue, enable_bullseye=True)
    def bar_3(self, context=IAContext):
        print(context)

    @enque(queue, enable_bullseye=False)
    def bar_4(self, context=IAContext):
        print(context)

    def show(self):
        # run original ones
        print('run orignal ones'.center(70, '-'))
        for func in [i for i in queue if not getattr(i, '__BULLSEYE_ENABLED__', False)]:
            print(func)
            func = types.MethodType(func, self)
            func()

        print('run decorated ones'.center(70, '-'))
        for func in [i for i in queue if getattr(i, '__BULLSEYE_ENABLED__', False)]:
            print(func)
            func = types.MethodType(func, self)
            func(context='somewhat')

if __name__ == '__main__':
    f = Foo()
    f.show()
