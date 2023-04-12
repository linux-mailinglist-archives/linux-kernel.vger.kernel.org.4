Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ABB6DF663
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDLND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDLNDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:03:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832C340F2;
        Wed, 12 Apr 2023 06:03:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE81F6603102;
        Wed, 12 Apr 2023 14:03:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681304632;
        bh=n6UmEOVTw+KXN9/725bQQxVPB20qNDRrZSlz09sXOMo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AQGqtRCpfP1ZuiophrOrBi4nZp+IoEZLBUmkBU7M1yFW3J4w/j+9WFvTAaK4aAfy0
         5mYHWH2h9wjO2WBZ32CNT1xRWPLebR3bOjhc4EYA2r8GAUkpXyuAw45LR3pxru37GU
         TJBMilPa+oR0ba/Sl+XjUj2izfyuitVr5N5O7t6jLvyKSSm9hcJWe2N8F2ludKsfQs
         BPXQNPKykaAn/QFWyaCAVLBVUDCUiSYmVAgcgUuhU29wxTbleKy57mWETsDJ/lmNi4
         eoW0EreMLhn9a2r7hNzEA0Rgm3J1Ixu9cUE3XdTH20jdV2vDUVROKrAgOAx3yO8xAA
         GmQOR2WRqCCBw==
Message-ID: <eb770f19-ada5-81bb-5ea3-798edabca70f@collabora.com>
Date:   Wed, 12 Apr 2023 15:03:48 +0200
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20684378-cf3e-0299-d390-287b7bafbda5@baylibre.com>
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

Il 12/04/23 14:59, Alexandre Mergnat ha scritto:
> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
>> Add a compatible string for MediaTek Helio X10 MT6795: this SoC uses
>> the same DSI PHY as MT8173.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml 
>> b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>> index 26f2b887cfc1..a9f78344efdb 100644
>> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
>> @@ -24,6 +24,10 @@ properties:
>>             - enum:
>>                 - mediatek,mt7623-mipi-tx
>>             - const: mediatek,mt2701-mipi-tx
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt6795-mipi-tx
>> +          - const: mediatek,mt8173-mipi-tx
> 
> AFAIK, it should be:
>        - items:
>            - const: mediatek,mt6795-mipi-tx
>            - const: mediatek,mt8173-mipi-tx
> 
> Since it isn't respected above for mt7623, it may be tolerated.
> Please, take this comment as a suggestion, isn't a NAK from me.
> 

First of all, Thanks!
I want to explain, though, the reason for that.

If you check all the commits, on some I did it as you just proposed, while
on some others I did it with an enum before const: that's simply because I
*totally expect* some to grow, while others (const - const) I was either
unsure, or totally *not* expecting them to grow soon!

>>         - items:
>>             - enum:
>>                 - mediatek,mt8365-mipi-tx
> 
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> 

Thanks again!

Cheers,
Angelo
