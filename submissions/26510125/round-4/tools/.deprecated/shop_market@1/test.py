def test(run,kit):
    x=run({'op':'catalog'},kit); assert x['status']==200
