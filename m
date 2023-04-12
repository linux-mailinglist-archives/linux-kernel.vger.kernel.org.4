Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087266DF6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjDLNVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjDLNVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:21:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B493C9766;
        Wed, 12 Apr 2023 06:21:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2599F6603102;
        Wed, 12 Apr 2023 14:21:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681305679;
        bh=BEatgd20PaT+FoAtz5LJF9JNJB6ziiidFfTfPNIX/YM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fsD0pPPDgNntnWVZcg0I3MYaS53hmASFtfvk2zOkcJ9TJZiqgyjcdHRrgEqLsg32h
         QpEOr5iKO0Ea1oRKd9TFMqf2RHhd0m5UjbO3GPw5vZh4WF19HkG6o3Zi2Giq7egCgN
         9u4b/aW/K8IKCNgyJ2EdGPdlzlvp51x2AnsimSLEbc5Z5RZ9hIau+owIMC8ThfilW+
         bVQ1xfnX8cu6G6PYHP/ZZiMRLmCTrOoLr+ZVHoV6gZY90ykb8E/LqSvsieF4Sg3zAy
         ul7/TGTo6KI8Zv0auPlCa3hscCYQrEopSi478gvEP2mBehdLl0DAgHOTXBHEMUN0Ey
         S3UbQhNG6eqAg==
Message-ID: <8bc72da0-d872-53fb-6753-f826efa3a51b@collabora.com>
Date:   Wed, 12 Apr 2023 15:21:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 05/27] dt-bindings: display: mediatek: dsi: Add compatible
 for MediaTek MT6795
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>
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
 <20230412112739.160376-6-angelogioacchino.delregno@collabora.com>
 <b9424113-f812-2f2d-5068-b04bb789e0de@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b9424113-f812-2f2d-5068-b04bb789e0de@gmail.com>
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

Il 12/04/23 14:36, Matthias Brugger ha scritto:
> 
> 
> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
>> Add a compatible string for MediaTek Helio X10 MT6795, using the same
>> DSI block as MT8173.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../display/mediatek/mediatek,dsi.yaml        | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml 
>> b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
>> index 4707b60238b0..12441b937684 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
>> @@ -22,13 +22,18 @@ allOf:
>>   properties:
>>     compatible:
>> -    enum:
>> -      - mediatek,mt2701-dsi
>> -      - mediatek,mt7623-dsi
>> -      - mediatek,mt8167-dsi
>> -      - mediatek,mt8173-dsi
>> -      - mediatek,mt8183-dsi
>> -      - mediatek,mt8186-dsi
>> +    oneOf:
>> +      - enum:
>> +          - mediatek,mt2701-dsi
>> +          - mediatek,mt7623-dsi
>> +          - mediatek,mt8167-dsi
>> +          - mediatek,mt8173-dsi
>> +          - mediatek,mt8183-dsi
>> +          - mediatek,mt8186-dsi
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt6795-dsi
>> +          - const: mediatek,mt8173-dsi
> 
> Same here, why not const?
> 

For both DPI and DSI: many other SoCs can work with the same handling
as MT8173, that's all the ones from the same era, one example is MT6765,
MT6755... as well as MT6752 and 67533 afaik.

...that's why :-)

Cheers,
Angelo

>>     reg:
>>       maxItems: 1


