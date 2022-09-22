Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109955E5C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiIVHSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiIVHSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:18:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072B5B776B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:18:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k10so13192567lfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ln6ZeHzfzIh7ZyAvFY4CPd7Whze3jXvv2P2xFSPlMGQ=;
        b=ErecUnfehksu48GfFXY1dB5cjHTxnXqpVDD2eczsRIHNXp0+fJGKID0aaV7oXQ+xM1
         7UzGFYZkEODN1QvfiSBIgr2dlG1gSVGBXkfNyZhTWIky0TloopA9PS41gknISZvJWgdo
         QOK/0CIOeWjFvLaLoww1LRicmQ3cwIddX6Gocz2h7pRmKyxD+qR0Q5uvuys1dFSs+hJk
         XfdKZr+7mkvgKE75usGv6nSPF1edW0PsXbToJ70O5MZXvT51FnFdZcXi9LzwtjvjJlgY
         C8aNoEY+6FTSxr0nEmsUcvgeMg0XhqVHnZF0/zZ3ESBQqElajl9A8qvfwjQvbTWOnYbF
         Hqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ln6ZeHzfzIh7ZyAvFY4CPd7Whze3jXvv2P2xFSPlMGQ=;
        b=5Vz2l+acevlpf4m5X0DQNh9PMbBdy/AQu0T2lBgoW/yXNzjrM++RF1qqeuKEaKYYE4
         NVlZEsg5ral2pEb+LJsjrgZUbu2hccZ1PVLI0WfhSZqhgOfr7r7WS2XwWpo0BKbaCByc
         Xt0mKtmRQuuu8m1L475zXoKnsmbRPEf1Zkbi0tFzxoD48MrbzE/AL+hGO9agmKAZAPar
         jsvlQg+X1ii3OnbF6e84UySUy6XcNfGi9i0xerlnpP9js+90b1VEXr7cI19TkwnvzSkh
         KnvEOiJAhbeu2ZMkyY8tKyRqFgUwNe3Tpq11RFW8I5oPRUBcesv0a4VmWAAas8FpjbIX
         gR3Q==
X-Gm-Message-State: ACrzQf1XbeppLiuJPeXisYct+/gRoAM8cGsVSB3NjgR9A0T0xVZcQ2nD
        hww714OH5EMbgw20BiKo5WMVxg==
X-Google-Smtp-Source: AMsMyM47YFDCy8AwIT5M8sGMUa+EUaCIIo1zk4WZ+rlWlbFfVtDdWjoBH6LrVg/wiXrtgWAh0UwMAA==
X-Received: by 2002:a05:6512:11e9:b0:49f:d530:9f25 with SMTP id p9-20020a05651211e900b0049fd5309f25mr749322lfs.533.1663831130309;
        Thu, 22 Sep 2022 00:18:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a7-20020a19f807000000b0048b256bb005sm804039lff.49.2022.09.22.00.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 00:18:49 -0700 (PDT)
Message-ID: <260bb17f-efc8-1287-3e03-f9b8e79a6e31@linaro.org>
Date:   Thu, 22 Sep 2022 09:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 04/17] dt-bindings: display: mediatek: add MT8195 hdmi
 bindings
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
References: <20220919-v1-0-4844816c9808@baylibre.com>
 <20220919-v1-4-4844816c9808@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919-v1-4-4844816c9808@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 18:56, Guillaume Ranquet wrote:
> Add mt8195 SoC bindings for hdmi and hdmi-ddc
> 
> Make port1 optional for mt8195 as it only supports HDMI tx for now.
> Requires a ddc-i2c-bus phandle.
> Requires a power-domains phandle.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
> index bdaf0b51e68c..abb231a0694b 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
> @@ -21,6 +21,10 @@ properties:
>        - mediatek,mt7623-hdmi
>        - mediatek,mt8167-hdmi
>        - mediatek,mt8173-hdmi
> +      - mediatek,mt8195-hdmi
> +
> +  clocks: true
> +  clock-names: true

????
Why is this moved?

>  
>    reg:
>      maxItems: 1
> @@ -28,20 +32,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  clocks:
> -    items:
> -      - description: Pixel Clock
> -      - description: HDMI PLL
> -      - description: Bit Clock
> -      - description: S/PDIF Clock
> -
> -  clock-names:
> -    items:
> -      - const: pixel
> -      - const: pll
> -      - const: bclk
> -      - const: spdif

Clock definition with constraints should stay here. You just customize
it per variant.

> -
>    phys:
>      maxItems: 1
>  
> @@ -58,6 +48,16 @@ properties:
>      description: |
>        phandle link and register offset to the system configuration registers.
>  
> +  ddc-i2c-bus:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'

Drop quotes

> +    description: Phandle to the ddc-i2c device

Isn't this property of panel?

> +
> +  power-domains:
> +    description:
> +      A phandle and PM domain specifier as defined by bindings
> +      of the power controller specified by phandle. See
> +      Documentation/devicetree/bindings/power/power-domain.yaml for details.

No need for this text. This is standard property. You miss maxItems.


> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>  
> @@ -76,7 +76,6 @@ properties:
>  
>      required:
>        - port@0
> -      - port@1
>  
>  required:
>    - compatible
> @@ -86,9 +85,55 @@ required:
>    - clock-names
>    - phys
>    - phy-names
> -  - mediatek,syscon-hdmi
>    - ports
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8195-hdmi
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: APB
> +            - description: HDCP
> +            - description: HDCP 24M
> +            - description: Split HDMI
> +        clock-names:
> +          items:
> +            - const: hdmi_apb_sel
> +            - const: hdcp_sel
> +            - const: hdcp24_sel
> +            - const: split_hdmi

Clocks are entirely different. I am not sure there is benefit in keeping
these devices in one bindings.

> +
> +      required:
> +        - power-domains
> +        - ddc-i2c-bus

Blank line,

> +    else:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Pixel Clock
> +            - description: HDMI PLL
> +            - description: Bit Clock
> +            - description: S/PDIF Clock
> +
> +        clock-names:
> +          items:
> +            - const: pixel
> +            - const: pll
> +            - const: bclk
> +            - const: spdif
> +
> +        ports:
> +          required:
> +            - port@1
> +
> +      required:
> +        - mediatek,syscon-hdmi
> +
>  additionalProperties: false
>  
>  examples:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
> new file mode 100644
> index 000000000000..3c80bcebe6d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek HDMI DDC Device Tree Bindings for mt8195

Drop Device Tree Bindings

> +
> +maintainers:
> +  - CK Hu <ck.hu@mediatek.com>
> +  - Jitao shi <jitao.shi@mediatek.com>
> +
> +description: |
> +  The HDMI DDC i2c controller is used to interface with the HDMI DDC pins.

Why is this different than existing ddc bindings?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8195-hdmi-ddc
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ddc-i2c
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    hdmiddc0: ddc_i2c {

No underscores in node names. Generic node names.


Best regards,
Krzysztof

