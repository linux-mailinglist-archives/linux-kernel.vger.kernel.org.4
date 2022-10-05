Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62EE5F55BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJENmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJENmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:42:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4005F91;
        Wed,  5 Oct 2022 06:42:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F5F666022BE;
        Wed,  5 Oct 2022 14:42:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664977340;
        bh=1Unni2kNmqjyicp5VGIMbg5//S+Jnj6DePPOdKiqYXc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fAGZk0RXIyvrco0hs7O+hE9ht56KacBs5hdhIIpZoXY/7fymvFsxd458StfTrLN6f
         IpXMKp1yWj3s+J5cTQ1GI98YGy5Yvtzb6jCIgJgqRDRfAs9WorYrAeDCR+c3TfjirF
         xNn/BnVQEgX7g+AuziDURgE0US0pH9h/l4afAB0ba8qzKV6VaJ3qL9/LAaUxcgqdo/
         Hp2ow0NOfvAcdpX7ekj0+VFynLBMCGbD638UaLzj1DfFv/ajgE1/TAWyBpBENnVp6f
         sMHhP/aNwlS4dtQTyoqH+npJAR4LB1mMGnCvhwbo5Ajv6Yc5iVd12hDn10ue1WHaeW
         8CQDR39Ge2Y1w==
Message-ID: <36ca5e72-db5d-65f6-db2c-1f0066842d18@collabora.com>
Date:   Wed, 5 Oct 2022 15:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        allen-kh.cheng@mediatek.com, seiya.wang@mediatek.com,
        tinghan.shen@mediatek.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
 <20221005113517.70628-4-angelogioacchino.delregno@collabora.com>
 <20221005133848.GA3278938-robh@kernel.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221005133848.GA3278938-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/10/22 15:38, Rob Herring ha scritto:
> On Wed, Oct 05, 2022 at 01:35:15PM +0200, AngeloGioacchino Del Regno wrote:
>> Convert the MediaTek watchdog bindings to schema.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/watchdog/mediatek,mtk-wdt.yaml   | 80 +++++++++++++++++++
>>   .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ----------
>>   2 files changed, 80 insertions(+), 42 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
>> new file mode 100644
>> index 000000000000..f43b5af92d40
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
>> @@ -0,0 +1,80 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/watchdog/mediatek,mtk-wdt.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek SoCs Watchdog timer
>> +
>> +maintainers:
>> +  - Matthias Brugger <matthias.bgg@gmail.com>
>> +
>> +description:
>> +  The watchdog supports a pre-timeout interrupt that fires
>> +  timeout-sec/2 before the expiry.
>> +
>> +allOf:
>> +  - $ref: watchdog.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt2712-wdt
>> +              - mediatek,mt6589-wdt
>> +              - mediatek,mt7986-wdt
>> +              - mediatek,mt8183-wdt
>> +              - mediatek,mt8186-wdt
>> +              - mediatek,mt8192-wdt
>> +              - mediatek,mt8195-wdt
> 
> The original binding only had 4 without a fallback. It's fine to add or
> change, but note the changes in the commit msg. Are all of these really
> each unique and not the same?
> 

Ok I will note the changes in the commit for v2. And... yes, they're really
each unique and not the same, as these are exposing a reset controller of
their own (as well with different platform data in the driver).

> 
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt2701-wdt
>> +              - mediatek,mt6582-wdt
>> +              - mediatek,mt6797-wdt
>> +              - mediatek,mt7622-wdt
>> +              - mediatek,mt7623-wdt
>> +              - mediatek,mt7629-wdt
>> +              - mediatek,mt8516-wdt
>> +          - const: mediatek,mt6589-wdt
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: Watchdog pre-timeout (bark) interrupt
>> +
>> +  mediatek,disable-extrst:
>> +    description: Disable sending output reset signal
>> +    type: boolean
>> +
>> +  timeout-sec: true
> 
> Drop this and use 'unevaluatedProperties'.
> 

Noted. Will do for v2.

Thanks!
Angelo


