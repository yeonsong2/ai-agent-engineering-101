import httpx

def run(args, kit):
    result={}
    for url in args.get('urls',[]):
        try:
            r=httpx.get(url, timeout=15)
            result[url]={"status":r.status_code,"body":r.json()}
        except Exception as e:
            result[url]={"error":str(e)}
    return result
