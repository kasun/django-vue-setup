import simplest

root_router = simplest.router(path='/api')
v1_router = simplest.router(root_router, path='/v1')
