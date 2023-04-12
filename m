Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4BF6DF6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjDLNNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjDLNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:13:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BCB93E8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:12:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso8036039wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681305170; x=1683897170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsrkVPeKsaynFnbWlBbnoqSaEozGzCnZBk6Qj0AOkSA=;
        b=ssqrDy/2cLPJMN/UfNNxohNjADmsWrmIPazYKu4Ca3VT51kMGJqUU1fvWcWP4RjuZo
         4dF+jf6yXYovywxAeb9lSaPiNCt6S4eT3K+uf9VRCmYJmFdY8L41VcIutelklqmDsd6V
         qEQiJk6+v2YoizYOHRkf0dteFBK+5GWCvEXstGpl1jIPIMOXUsz7nnNubKdh5OvNHnOL
         aDF6VeDl9OZ8cI5sC0EVKynLDlBXTOguFMXJZ/LRchX+pbtIPKdlFgmkzwneaoW2z/GQ
         VQFB2AhqMthknYvrUs8GSB/XmaDK1dHZobdQvl+1Y43TnONYn2GITk4eWX+S3A94HX6O
         2rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681305170; x=1683897170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsrkVPeKsaynFnbWlBbnoqSaEozGzCnZBk6Qj0AOkSA=;
        b=wTbDLaSSOUoorJq8DkfTpWJ5G/ZXeA8yMBydIJBNQqGdkHN+hX6equODePKknw4rOO
         dRfrlpMYGlfSmmWxhA8LE+btrbNzPZ5C6AVJhldGu4XW7qpYk1XKwoG6tbXnu2TilouP
         sxRIZGrUu/TArkc4RXD+YtqCsqfUaaHTwmv4f4NEgd0FHfZqEVciGnxlc8uCr+wOosZz
         zOtSx5ixIf/r0ynUIeuza84xW0IYF+VzyLTXgDb6P/RCag+d9q3WaM+xI0IOgvUb+fhg
         rpF93AF+5oWNKk+1u7Zui//GgygiwF2sRHlSKMNCsgjq3zDNMbxYTofHKBlCkItFSyN6
         24Dg==
X-Gm-Message-State: AAQBX9f7xB00yEgOO/3z3tHUDxrlL5C1fcgv0vb47UjMNL2qVf/D9jsd
        5q/TVhT+TsmVh1Fq/vOUReKCSA==
X-Google-Smtp-Source: AKy350ZBjsJyLl7Rt2Og/2cr2DuEAVD7N0GXPO8YRPue1Xvb87vVf08FN6CXsl6Q/928lyD+Npa9JA==
X-Received: by 2002:a05:600c:2142:b0:3ef:62cd:1ef with SMTP id v2-20020a05600c214200b003ef62cd01efmr4545069wml.25.1681305170583;
        Wed, 12 Apr 2023 06:12:50 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id z12-20020a7bc7cc000000b003ee63fe5203sm2311867wmk.36.2023.04.12.06.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 06:12:50 -0700 (PDT)
Message-ID: <7e53c0b1-3aed-da08-5c57-800ac2277bc6@baylibre.com>
Date:   Wed, 12 Apr 2023 15:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/27] dt-bindings: phy: mediatek,dsi-phy: Add compatible
 for MT6795 Helio X10
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
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
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <eb770f19-ada5-81bb-5ea3-798edabca70f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 15:03, AngeloGioacchino Del Regno wrote:
> Il 12/04/23 14:59, Alexandre Mergnat ha scritto:
>> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
>>> Add a compatible string for MediaTek Helio X10 MT6795: this SoC uses
>>> the same DSI PHY as MT8173.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno 
>>> <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml 
>>> b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>>> index 26f2b887cfc1..a9f78344efdb 100644
>>> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>>> @@ -24,6 +24,10 @@ properties:
>>>             - enum:
>>>                 - mediatek,mt7623-mipi-tx
>>>             - const: mediatek,mt2701-mipi-tx
>>> +      - items:
>>> +          - enum:
>>> +              - mediatek,mt6795-mipi-tx
>>> +          - const: mediatek,mt8173-mipi-tx
>>
>> AFAIK, it should be:
>>        - items:
>>            - const: mediatek,mt6795-mipi-tx
>>            - const: mediatek,mt8173-mipi-tx
>>
>> Since it isn't respected above for mt7623, it may be tolerated.
>> Please, take this comment as a suggestion, isn't a NAK from me.
>>
> 
> First of all, Thanks!
> I want to explain, though, the reason for that.
> 
> If you check all the commits, on some I did it as you just proposed, while
> on some others I did it with an enum before const: that's simply because I
> *totally expect* some to grow, while others (const - const) I was either
> unsure, or totally *not* expecting them to grow soon!


That's what I thought. IMHO, if someone add another compat later, he 
will be on charge to change the const by enum front of your 
"mediatek,mt6795-mipi-tx". But my opinion is probably not the most popular.

I will not make the same feedback for the other patches in this series.

-- 
Regards,
Alexandre

