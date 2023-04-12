Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F6F6DFB82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjDLQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDLQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:39:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E4A268B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:39:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50489b16e6aso2793488a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681317573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wjsnIpfOQB8bXiCEyrFPNZ7eINu8y00FwWxIEZFO2H8=;
        b=Svb4qAOBP+hW/lCQsPo+DQoVQzZnNdUGZUthwNi58ITBxz8whyBqb0ZnH+ImgAFGRc
         p44f2selI+AQD100B9gCrOL6dfxkuKO8G84ICcoj9ugmWQo1EVuBciFpHTfP3MyGImEv
         oo00lqssDo8U18xmtpxVrjAoM7dojbhS8EA8Xx7Og3BcgpvQDykAv0ZaQg3a+FaAHwFj
         17l4KA5IADwEPyuy5ldHi+3zNK7mmfrXwu+ofdfF+LpIYFqOLbCzJX8tsuxpFWtzPFJd
         hX04/hRUBBwnAwVqES8lkohsYw+rIPeaWTlwCCoEj+MYiv7x53CKrb2pUXsiqMWHQVbn
         M4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjsnIpfOQB8bXiCEyrFPNZ7eINu8y00FwWxIEZFO2H8=;
        b=OZAs5+d5eNlo0ON3qLFZoOe3DKtWwSqp1SA0ZHSeHjioz1bi0VxMgOBAFCngAHR8L8
         /luQKjpIHnEj/p3kD1Rva+sOcJxk6Nf29ch695S2yW+Affkn0+h4J6sFlA8hND6p8sjp
         z6WctN8RCZ1S/CaHGaj2QmBw7fMJOVecNFIcrdTCiEV4E40ksbAdsAQBX3kJfKttwDZq
         Mw38FATUqJUgVEzCbyZmTq5LWBpJkRFqCMitnGzSDX0Kf5ehY1Ge28bN3RlhrP0kZR5S
         PiZIA5QuajcNpZM7hkQFk9hzi5QDaLwetIpwxQGNr37bU0WsfIL+bttHJY07CeQr7fX9
         ZIfw==
X-Gm-Message-State: AAQBX9eGcJXKOfpUtcrWMToKwBzjHUorMRti0TR7XUs6Gu8zBTRJ2Z0K
        Sr/776G0RxNYw1kP2I+K9NDRxA==
X-Google-Smtp-Source: AKy350aL10p8ZvO/uuBSLAFaGHPL+GVZnp473n+I6x+oIN043R05Kjx5EBQEvM6M53B/enOB1WnRKQ==
X-Received: by 2002:aa7:d58c:0:b0:504:b60a:e7e8 with SMTP id r12-20020aa7d58c000000b00504b60ae7e8mr3197279edq.20.1681317573432;
        Wed, 12 Apr 2023 09:39:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:938a:b3db:7c59:795e? ([2a02:810d:15c0:828:938a:b3db:7c59:795e])
        by smtp.gmail.com with ESMTPSA id c31-20020a509fa2000000b005049c1f1c60sm3535728edf.65.2023.04.12.09.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 09:39:33 -0700 (PDT)
Message-ID: <153a5ed0-5f4f-4879-2677-e5bce5453634@linaro.org>
Date:   Wed, 12 Apr 2023 18:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/7] dt-bindings: net: dsa: mediatek,mt7530: add port
 bindings for MT7988
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230406080141.22924-1-arinc.unal@arinc9.com>
 <20230406080141.22924-3-arinc.unal@arinc9.com>
 <23c8c4b5-baaa-b72b-4103-b415d970acf2@linaro.org>
 <5b3a10ff-e960-1c6e-3482-cb25200c83c6@arinc9.com>
 <951841d3-59a4-fa86-5b45-46afdb2942dd@linaro.org>
 <5a92419c-4d2c-a169-687b-026dc6094cd8@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5a92419c-4d2c-a169-687b-026dc6094cd8@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 11:46, Arınç ÜNAL wrote:
> On 7.04.2023 12:07, Krzysztof Kozlowski wrote:
>> On 06/04/2023 21:18, Arınç ÜNAL wrote:
>>> On 6.04.2023 22:07, Krzysztof Kozlowski wrote:
>>>> On 06/04/2023 10:01, arinc9.unal@gmail.com wrote:
>>>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>>
>>>>> The switch on MT7988 has got only port 6 as a CPU port. The only phy-mode
>>>>> to be used is internal. Add this.
>>>>>
>>>>> Some bindings are incorrect for this switch now, so move them to more
>>>>> specific places.
>>>>>
>>>>> Address the incorrect information of which ports can be used as a user
>>>>> port. Any port can be used as a user port.
>>>>>
>>>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>> ---
>>>>>    .../bindings/net/dsa/mediatek,mt7530.yaml     | 63 ++++++++++++++-----
>>>>>    1 file changed, 46 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>>>> index 7045a98d9593..605888ce2bc6 100644
>>>>> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>>>> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>>>> @@ -160,22 +160,6 @@ patternProperties:
>>>>>          "^(ethernet-)?port@[0-9]+$":
>>>>>            type: object
>>>>>    
>>>>> -        properties:
>>>>> -          reg:
>>>>> -            description:
>>>>> -              Port address described must be 5 or 6 for CPU port and from 0 to 5
>>>>> -              for user ports.
>>>>> -
>>>>> -        allOf:
>>>>> -          - if:
>>>>> -              required: [ ethernet ]
>>>>> -            then:
>>>>> -              properties:
>>>>> -                reg:
>>>>> -                  enum:
>>>>> -                    - 5
>>>>> -                    - 6
>>>>> -
>>>>
>>>> I have doubts that the binding is still maintainable/reviewable. First,
>>>> why do you need all above patterns after removal of entire contents?
>>>
>>> The 'type: object' item is still globally used. I'd have to define that
>>> on each definitions, I suppose?
>>
>> Doesn't it come from dsa.yaml/dsa-port.yaml schema?
> 
> It comes from dsa.yaml#/$defs/ethernet-ports which this schema already 
> refers to. I'll remove the patterns above.
> 
> Though 'type: object' is not there for "^(ethernet-)?port@[0-9]+$". I 
> think I should add it there as the dsa-port.yaml schema defines the 
> properties of the DSA switch port object. 

It has ref, which is enough.

> So the value matching the 
> "^(ethernet-)?port@[0-9]+$" regular expression is expected to be an 
> object conforming to the structure defined in dsa-port.yaml.
> 
> Does that make sense?

Hm, no, sorry, I still do not see what exactly is missing from
dsa.yaml/port that you need to define here.


Best regards,
Krzysztof

