Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F206DF6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDLNSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjDLNSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:18:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112DA7ABF;
        Wed, 12 Apr 2023 06:17:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B32D26603102;
        Wed, 12 Apr 2023 14:17:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681305445;
        bh=kWaXsEK0eZOcZEFNa/wRIg4Y8oDz609JLlK3U1zI9vs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ijaIa/bTYqS4pI+GbN0q3iYFpCbrjvFi6mUY+gW5iKphea997GuAq5lrjcRD4dTza
         tsfwTtFjO03ygljQz7j1jlnUrvZCjOoNypSlvvVzlqgJukqvVTxoDEh5G5yS3K57xC
         0bqqKhngFD/JBhIHW0lneWDqez/IW5GMilTqgZuJ9CxsIymlhk2BpW57dVN+qOKM5m
         CYjeoILzbttz1wIyfZgfY1mXlrowZbETlVXM9edw3x4u+apT1BM81e7HHDOsuV/wAn
         uzrqHv7YB8ffDzeX74DusX+jhOkc2dArNZhIcjQD222MBsqQEipgE9qHLCxCAxsG+k
         wkAyrXEvCEwIw==
Message-ID: <e129b3ff-90b1-3df7-871e-09fba0a960f4@collabora.com>
Date:   Wed, 12 Apr 2023 15:17:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 02/27] dt-bindings: phy: mediatek,dsi-phy: Add compatible
 for MT6795 Helio X10
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>, matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-3-angelogioacchino.delregno@collabora.com>
 <20684378-cf3e-0299-d390-287b7bafbda5@baylibre.com>
 <eb770f19-ada5-81bb-5ea3-798edabca70f@collabora.com>
 <7e53c0b1-3aed-da08-5c57-800ac2277bc6@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <7e53c0b1-3aed-da08-5c57-800ac2277bc6@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/04/23 15:12, Alexandre Mergnat ha scritto:
> On 12/04/2023 15:03, AngeloGioacchino Del Regno wrote:
>> Il 12/04/23 14:59, Alexandre Mergnat ha scritto:
>>> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
>>>> Add a compatible string for MediaTek Helio X10 MT6795: this SoC uses
>>>> the same DSI PHY as MT8173.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno 
>>>> <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml 
>>>> b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>>>> index 26f2b887cfc1..a9f78344efdb 100644
>>>> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>>>> @@ -24,6 +24,10 @@ properties:
>>>>             - enum:
>>>>                 - mediatek,mt7623-mipi-tx
>>>>             - const: mediatek,mt2701-mipi-tx
>>>> +      - items:
>>>> +          - enum:
>>>> +              - mediatek,mt6795-mipi-tx
>>>> +          - const: mediatek,mt8173-mipi-tx
>>>
>>> AFAIK, it should be:
>>>        - items:
>>>            - const: mediatek,mt6795-mipi-tx
>>>            - const: mediatek,mt8173-mipi-tx
>>>
>>> Since it isn't respected above for mt7623, it may be tolerated.
>>> Please, take this comment as a suggestion, isn't a NAK from me.
>>>
>>
>> First of all, Thanks!
>> I want to explain, though, the reason for that.
>>
>> If you check all the commits, on some I did it as you just proposed, while
>> on some others I did it with an enum before const: that's simply because I
>> *totally expect* some to grow, while others (const - const) I was either
>> unsure, or totally *not* expecting them to grow soon!
> 
> 
> That's what I thought. IMHO, if someone add another compat later, he will be on 
> charge to change the const by enum front of your "mediatek,mt6795-mipi-tx". But my 
> opinion is probably not the most popular.
> 
> I will not make the same feedback for the other patches in this series.
> 

I honestly don't know what's the most popular opinion about that... but whatever,
in any case... just want to make sure to communicate that I don't really have
strong opinions about doing it one way or the other.

The arguments in favor and against that are probably 1:1... :-D

Cheers!
Angelo
