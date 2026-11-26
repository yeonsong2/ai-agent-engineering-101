import httpx

def run(args,kit):
    base=kit.market; op=args.get('op'); h={'authorization':'Bearer '+kit.token('shop')}
    paths={'catalog':'/api/catalog','demand':'/api/demand','restock':'/api/restock','prices':'/api/supply-prices','inventory':'/api/inventory'}
    if op in paths:
        r=httpx.get(base+paths[op],headers=h,timeout=20); return {'status':r.status_code,'body':r.json()}
    if op=='buy':
        sku=args['sku']; qty=int(args['qty'])
        r=httpx.post(base+'/api/supply',json={'sku':sku,'qty':qty},headers=h,timeout=20)
        if r.status_code!=402: return {'status':r.status_code,'body':r.json()}
        q=r.json(); p=q['pay']; tx=kit.pay(p['to'],int(p['wei']),p.get('data','0x'),role='shop')
        r2=httpx.post(base+'/api/supply',json={'quote':q['quote'],'tx_hash':tx},headers=h,timeout=30)
        return {'quote':q,'status':r2.status_code,'body':r2.json()}
    return {'error':'unknown op'}
