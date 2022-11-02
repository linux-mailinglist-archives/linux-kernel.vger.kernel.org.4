Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0A6163E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiKBNbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiKBNbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:31:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772502AC42
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:31:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g12so28275462lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt810txVALNNyUdY4OEJ1D3fYrKTdtnWDD3u56EERwI=;
        b=3xmqrEhp6kIZuyPMYnSPokp0VKivtqklDyyWKzYNWn7RZ9r32jO+TYfFJYvac4ILFA
         HN8cAoqwO36KNOPekRjuxDsqK6LQuARHGNBy7DDo2ods9roVUhZI42CQh5OFNUZKbTfG
         F9gCKBM7koia5e0VuYUIfiKOHb3GGXspmKJ7JmSWnnDslrPKhxbER3LVZJ8JhFK+Is6V
         V64OO2OHY3kFRAvTWv/NIU604DON7dRgX2bQETft6CwN1IGmZVn9qrvWFUZ5OmHKlnZ2
         TVsTmVfPlMVH8huodx3nlqli2FqtWsmNB+OZqtu3f39Bn7ooCpAkDJ2DQH11Qrs6wy8W
         5zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt810txVALNNyUdY4OEJ1D3fYrKTdtnWDD3u56EERwI=;
        b=3d4vU3d/jsqON3AHulCD1uBVqnA/hKCwb6bFuyiBepEYM/8d3aCGe4mz985STQkGmc
         Gm5F/Fou73bGHK+XPYurVWLRonV6tIQ6tKkasW0x+GLbZOWvHFmfNIh7TicK6qnhyfe9
         LkuGUMtWrERifpE099xJNBbJ9x6phV+wjdZfK4mwsLnuCXIsrlV2b7NkeRAXESkNuSa0
         dF/YpJCGJ5/CAtKRLyfPS1pkVP8j6n3S+I/vmsfWaeo2nl5sTr/8apebh9e9bF2d1ZUb
         4KGOl5Vtj6rkTZ7JOHoRe4dT25Hnd7mUdeY2N6PQXdWVEhhDS5tzSxB1d3Db/creObBP
         rqIw==
X-Gm-Message-State: ACrzQf3NadMbiYcMlxUDHyUD9Nc5zSvqGTF2he51fITve2SW1aIKnXhp
        LPGPSRtRVG+mAg96gi4eT9ibpTIbLD2fTYj6YpRCyA==
X-Google-Smtp-Source: AMsMyM7NEe/GaJR4NF+KA5B639tBCDJwn4kT6yPPjmVJnVe6xV1T07jvraVMLccE++55BYXBEE26QqdBGn1uy3S8WHM=
X-Received: by 2002:ac2:5e33:0:b0:4a2:1d16:5cc2 with SMTP id
 o19-20020ac25e33000000b004a21d165cc2mr8578793lfg.620.1667395887603; Wed, 02
 Nov 2022 06:31:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Nov 2022 13:31:27 +0000
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v2-0-8419dcf4f09d@baylibre.com> <20220919-v2-2-8419dcf4f09d@baylibre.com>
 <c91ee3ce-3f30-a3ef-bb38-8571e488b6b6@linaro.org>
In-Reply-To: <c91ee3ce-3f30-a3ef-bb38-8571e488b6b6@linaro.org>
MIME-Version: 1.0
Date:   Wed, 2 Nov 2022 13:31:26 +0000
Message-ID: <CABnWg9t3w4o4rmNosvYCpqG-h8DESerajH7OsXEYofRf2kr1Xg@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] dt-bindings: display: mediatek: add MT8195 hdmi bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        David Airlie <airlied@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jitao shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     stuart.lee@mediatek.com, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, mac.shen@mediatek.com,
        linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 18:08, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>On 14/10/2022 11:15, Guillaume Ranquet wrote:
>> Add mt8195 SoC bindings for hdmi and hdmi-ddc
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>>  .../bindings/display/mediatek/mediatek,hdmi.yaml   | 67 +++++++++++++++++-----
>>  .../display/mediatek/mediatek,mt8195-hdmi-ddc.yaml | 51 ++++++++++++++++
>>  2 files changed, 104 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>> index bdaf0b51e68c..955026cd7ca5 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>> @@ -21,26 +21,21 @@ properties:
>>        - mediatek,mt7623-hdmi
>>        - mediatek,mt8167-hdmi
>>        - mediatek,mt8173-hdmi
>> +      - mediatek,mt8195-hdmi
>>
>>    reg:
>>      maxItems: 1
>>
>> -  interrupts:
>> -    maxItems: 1
>> -
>
>This change is not really explained in commit msg...
>
>>    clocks:
>> -    items:
>> -      - description: Pixel Clock
>> -      - description: HDMI PLL
>> -      - description: Bit Clock
>> -      - description: S/PDIF Clock
>> +    minItems: 4
>> +    maxItems: 4
>>
>>    clock-names:
>> -    items:
>> -      - const: pixel
>> -      - const: pll
>> -      - const: bclk
>> -      - const: spdif
>> +    minItems: 4
>> +    maxItems: 4
>> +
>> +  interrupts:
>> +    maxItems: 1
>>
>>    phys:
>>      maxItems: 1
>> @@ -58,6 +53,9 @@ properties:
>>      description: |
>>        phandle link and register offset to the system configuration registers.
>>
>> +  power-domains:
>> +    maxItems: 1
>> +
>>    ports:
>>      $ref: /schemas/graph.yaml#/properties/ports
>>
>> @@ -86,9 +84,50 @@ required:
>>    - clock-names
>>    - phys
>>    - phy-names
>> -  - mediatek,syscon-hdmi
>>    - ports
>>
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: mediatek,mt8195-hdmi
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: APB
>> +            - description: HDCP
>> +            - description: HDCP 24M
>> +            - description: Split HDMI
>> +        clock-names:
>> +          items:
>> +            - const: hdmi_apb_sel
>> +            - const: hdcp_sel
>> +            - const: hdcp24_sel
>> +            - const: split_hdmi
>> +
>> +      required:
>> +        - power-domains
>> +    else:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: Pixel Clock
>> +            - description: HDMI PLL
>> +            - description: Bit Clock
>> +            - description: S/PDIF Clock
>> +
>> +        clock-names:
>> +          items:
>> +            - const: pixel
>> +            - const: pll
>> +            - const: bclk
>> +            - const: spdif
>> +
>> +      required:
>> +        - mediatek,syscon-hdmi
>> +
>>  additionalProperties: false
>>
>>  examples:
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
>> new file mode 100644
>> index 000000000000..0fe0a2a2f17f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Mediatek HDMI DDC for mt8195
>> +
>> +maintainers:
>> +  - CK Hu <ck.hu@mediatek.com>
>> +  - Jitao shi <jitao.shi@mediatek.com>
>> +
>> +description: |
>> +  The HDMI DDC i2c controller is used to interface with the HDMI DDC pins.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt8195-hdmi-ddc
>
>I think I wrote it - you already have bindings for HDMI DDC. I doubt
>that these are different and it looks like you model the bindings
>according to your driver. That's not the way.

Hi Krzysztof,

I've made a separate binding as this new IP is integrated into the
HDMI hw block.
The difference it makes is that the hw is slightly simpler to describe
as the IP doesn't
have it's own range of registers or an interrupt line.

I can use the "legacy mediatek mtk ddc binding" if I modify it to have
the reg and
interrupt properties not being required for mt8195.

Would that work better for you?

>
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ddc
>> +
>> +  mediatek,hdmi:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      A phandle to the mt8195 hdmi controller
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    hdmiddc0: ddc_i2c {
>
>Node names should be generic - ddc.
>https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
>No underscores in node names.
>
>Additionally I2C devices have addresses on the bus. Why this one doesn't?
>

This is an i2c adapter, not a device.
And as it lives inside the HDMI hw block, I've omitted using an address here.

Is this valid? or should this be expressed differently?

Thx,
Guillaume.

>> +      compatible = "mediatek,mt8195-hdmi-ddc";
>> +      mediatek,hdmi = <&hdmi0>;
>> +      clocks = <&clk26m>;
>> +      clock-names = "ddc";
>> +    };
>> +
>> +...
>>
>
>Best regards,
>Krzysztof
>
