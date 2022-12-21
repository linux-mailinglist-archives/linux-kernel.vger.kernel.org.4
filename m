Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07801652F96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiLUKfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiLUKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:34:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB01571C;
        Wed, 21 Dec 2022 02:34:09 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C142D6602CBE;
        Wed, 21 Dec 2022 10:34:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671618848;
        bh=dYnHLUJwsMgAqRqXR0SLLIpg7sZb52juTMDSydtg2x4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NJWuTs4kLFIVz6qdw1/352wJnSGg8W+CUVh5jJ4Fh0eCzdhJcGGEbC0udVFsDxFVg
         RhrTq8CShiU7b1sr1rsIXkCnufUZ77mMTIgsYMxBaEWp5gamaAqX5RtVXMadVMZ+tU
         wyYSJjGk8Wgs5PRaOWa+bpvVZkjvraBBNBTlepzIsoSByhjYhBl0pLWJbYJ1+cS4RF
         4YRefd0VGzzz9In7DgfUZBsm8TMJBzuV6uPAQ2RWKW55KeeKtfSl2YM25JvYFXG6qa
         aaZPhdVWbmLfRhlLpJRjBtC/m2IIGaSblzKqeYz7sL1YVpyWPtcWR337m4AryTNZtH
         9/VPFLvpFqUvQ==
Message-ID: <9ea3d941-e68a-ce48-5f34-264f925c4358@collabora.com>
Date:   Wed, 21 Dec 2022 11:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 5/6] dt-bindings: arm: mediatek: Add missing
 power-domains property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
 <20221221034407.19605-6-allen-kh.cheng@mediatek.com>
 <ec927229-cf03-136c-5629-22719110313a@collabora.com>
 <403b0310-070f-1ecc-2188-95c22859bae1@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <403b0310-070f-1ecc-2188-95c22859bae1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/12/22 11:33, Krzysztof Kozlowski ha scritto:
> On 21/12/2022 11:22, AngeloGioacchino Del Regno wrote:
>> Il 21/12/22 04:44, Allen-KH Cheng ha scritto:
>>> The "mediatek,mt8192-scp_adsp" binding requires a power domain to be
>>> specified.
>>>
>>> Fixes: 4a803990aeb1 ("dt-bindings: ARM: Mediatek: Add new document bindings of MT8192 clock")
>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>> ---
>>>    .../arm/mediatek/mediatek,mt8192-clock.yaml     | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
>>> index b57cc2e69efb..ce8dd2bfb533 100644
>>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
>>> @@ -40,6 +40,9 @@ properties:
>>>      reg:
>>>        maxItems: 1
>>>    
>>> +  power-domains:
>>> +    maxItems: 1
>>> +
>>>      '#clock-cells':
>>>        const: 1
>>>    
>>> @@ -47,13 +50,27 @@ required:
>>>      - compatible
>>>      - reg
>>>    
>>> +allOf:
>>
>> allOf is unnecessary here.
> 
> If you mean that "if:" can be without it, then it is better to have
> allOf. It grows often, so you avoid useless indentation change later.
> 
> 

Yes, that's what I mean. I've suggested so because I don't expect this list
to grow in the future.

Regards,
Angelo

