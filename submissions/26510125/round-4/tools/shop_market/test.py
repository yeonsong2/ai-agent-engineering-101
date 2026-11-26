def test(run,kit):
    x=run({'op':'inventory'},kit); assert x['status']==200
