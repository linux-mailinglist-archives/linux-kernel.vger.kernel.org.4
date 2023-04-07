Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FBD6DAAA3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbjDGJIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbjDGJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:07:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925DAD13
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:07:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id 11so7078676ejw.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680858469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gmZaXoh5OynzC86VaTh4Y6BvZrzd/QsKcjbYpPnZc0=;
        b=Xz8iLJoj3e6atCdL3Uvpx3dUFJKuQsv2GH4wcE8UI1rl0GJXVuGqUZSpj/tONGDCPj
         u8p85UbDTJ+HLqeJw/YnZ4faLPx8LKpc5WxqDRLvWk4Dm2L4FADqlBBqPrBu1wi3SYbE
         VWTQxTC/mD01K1EMTJjuUX+c+d9o3V18k4jh9u2v4RPghw4ULoS0s0mnPxMUe79FszTG
         i/V4jO5WXAVR45hsrXNpPVrlhEDYZgMlwW14UpvVRRneT11I4dIY0LQb5/6mivQg2wCs
         nSCdNOjcDV+yKsQl2QK9+Glg+KHIL5XRN0dDAlWrj9Arx16pzha2SfsFfWN15bz7gFC1
         mkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680858469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gmZaXoh5OynzC86VaTh4Y6BvZrzd/QsKcjbYpPnZc0=;
        b=fgG+X6wJWp/E3jjxbQUbxAw9uz8eqrGtyG8NLGp+tuD7vViQ6jfkjVKbUL6vej3pQz
         2w7LGanH8dyaRcW0niI0YliHmgjXoiA0KHAnk9oA1ZXmaRfEXcuAXn1bqYi/8aZ/5VPf
         /Db3VoipndjZfDH+GHeWRFF4DL0DGKT5G6q2/FOLAihA7KDRcygPtdcBMHcy5fZyAWaw
         VOjFzM2BFe4u4CclHkU4XYJt5jzX2sSH5+iljyK/dX78v156QBmRjfFX9/yI3YgN2hB/
         G65Oc1+IXDDtHe7LnwjTBKR8ya7GXeJ2YAue5/D4mXvboArWUYa6xP+sxfsbPXy+ZBgb
         v3jw==
X-Gm-Message-State: AAQBX9eArQW8zXCbXennEgnooE4lS2fB9P7YPOJHImKRo6t3SRnQJO+V
        eevL8xcbpeBZZoO0/t7917WSyA==
X-Google-Smtp-Source: AKy350bMxNw13TzLGoIgRzK5ovfvLEWUmmgDUnmQBPIUls264bsoQ74I1vJcA7PJ/i7xcVI2UzdWtQ==
X-Received: by 2002:a17:906:39d3:b0:8de:502e:2061 with SMTP id i19-20020a17090639d300b008de502e2061mr1172023eje.3.1680858469115;
        Fri, 07 Apr 2023 02:07:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:14a3:366:3172:3c37? ([2a02:810d:15c0:828:14a3:366:3172:3c37])
        by smtp.gmail.com with ESMTPSA id lf24-20020a170906ae5800b00933d64cd447sm1826425ejb.121.2023.04.07.02.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 02:07:48 -0700 (PDT)
Message-ID: <e716d33d-bd39-3f84-3e2e-18cfaf0439cd@linaro.org>
Date:   Fri, 7 Apr 2023 11:07:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/7] dt-bindings: net: dsa: mediatek,mt7530: disallow
 reset without mediatek,mcm
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        arinc9.unal@gmail.com, Andrew Lunn <andrew@lunn.ch>,
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
 <20230406080141.22924-5-arinc.unal@arinc9.com>
 <d5769d8f-29f3-063e-0562-487b1b509d3c@linaro.org>
 <194d3bad-c30a-df07-5fab-3264f739c599@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <194d3bad-c30a-df07-5fab-3264f739c599@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 21:19, Arınç ÜNAL wrote:
> On 6.04.2023 22:08, Krzysztof Kozlowski wrote:
>> On 06/04/2023 10:01, arinc9.unal@gmail.com wrote:
>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>
>>> The resets and reset-names properties are used only if mediatek,mcm is
>>> used. Set them to false if mediatek,mcm is not used.
>>>
>>> Remove now unnecessary 'reset-names: false' from MT7988.
>>>
>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>> ---
>>>   .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml         | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>> index 9d99f7303453..3fd953b1453e 100644
>>> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
>>> @@ -282,6 +282,10 @@ allOf:
>>>         required:
>>>           - resets
>>>           - reset-names
>>> +    else:
>>> +      properties:
>>> +        resets: false
>>> +        reset-names: false
>>>   
>>>     - dependencies:
>>>         interrupt-controller: [ interrupts ]
>>> @@ -324,7 +328,6 @@ allOf:
>>>         properties:
>>>           gpio-controller: false
>>>           mediatek,mcm: false
>>> -        reset-names: false
>>
>> I don't see such hunk in linux-next.
> 
> This was added very recently so it's only on net-next at the moment.

OK, I was checking one few days old.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

