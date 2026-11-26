def test(run, kit):
    result=run({'urls':['https://market.ourolabs.ai/.well-known/agent-card.json']},kit)
    assert result
