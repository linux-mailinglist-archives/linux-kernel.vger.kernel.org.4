Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3416A92C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCCIm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCCImZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:42:25 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F40439CFF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:42:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g3so7432773eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 00:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677832937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TST4cThQaK2erJHSPGfkkNJ8p/M75cq++a+eKVWZxF0=;
        b=l2xARqmNJdkYpMikLbVGrC4i/RCs/fqN3ecwn0vLc1zzqa7tvF+Wqi2lKOU/Z2LNVR
         aDHcWJdCYYxNZ4krZW0lnO4QeghXuUIUKg4K0SZT4WZ0f6CDVmQS4MdAya/ABryWGHDh
         U/XEz7pKAT+YoD4PBXrzhKnpWJk9IvLjibPtc2QoWJmX4wpkQ0ox9s0/tJB25QPyky4p
         NVkZmhMiERVYb2Fm0AHlMRqbYi5LuMYUciiKGsfFNrCS5PDF0PN/RpkAxvOKFEPHhhU+
         eyHDvk/viU3Q4jmnibBXDPYvml76gMdtP+wdxQPslME1hZ32yCOGHmIMqTSFn7rU4Czm
         vqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677832937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TST4cThQaK2erJHSPGfkkNJ8p/M75cq++a+eKVWZxF0=;
        b=5DrXzdvRuzuSerq4MqD/mj38Yd83LPnLCpsgBYdImh3XCOQzg2bFATxD4X2l68H+Iw
         yQs66/ZZ/N+F8lkAXWaGhZ28/qGAfWpUIljLMo18EAhcBbW/WPBKQKbHyRuymzrtEZWR
         Cc46tu/Tx5o9MVEP1GMZY07x+3ya123Xa03YmTqxJUnvkUsWtt+jkPktUyka4izAFQ3v
         IF/I2JzIRBYLGanXpLqSvCYqEZDH6RxfNl1AdcdHgMMqTRaLRrC2IoC2T6E8UYp9LmVx
         rS7R/u8Jlf91xgzqriZ1loLDUNbkisx8JjjZktl5Jk/r/rAdwK/qiqrWxopaP8Q6Cqc/
         qYcA==
X-Gm-Message-State: AO0yUKXtfRgqEknHbfBy7xBwB+r0TmKSyjei3aJInpUIC8KU5wvW0Eey
        /T+XyLdBuHhhhLULnJ1DsstPXQ==
X-Google-Smtp-Source: AK7set/FrDQkpv9xuFORleilLGkXPiWO2nkWOv+hJMBasSr31CouErbTswY9pCqI+LeMu4hoEacOqQ==
X-Received: by 2002:a17:907:728e:b0:8b1:807e:d4d2 with SMTP id dt14-20020a170907728e00b008b1807ed4d2mr1140561ejc.34.1677832937187;
        Fri, 03 Mar 2023 00:42:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906a21000b008cafeec917dsm701191ejy.101.2023.03.03.00.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 00:42:16 -0800 (PST)
Message-ID: <711f0e08-a8c8-45ef-08cf-6ca4f166ed4a@linaro.org>
Date:   Fri, 3 Mar 2023 09:42:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 02/11] media: dt-bindings: starfive,jh7110-mipi-csi2:
 add binding docmuent
Content-Language: en-US
To:     "jack.zhu" <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230302091921.43309-1-jack.zhu@starfivetech.com>
 <20230302091921.43309-3-jack.zhu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302091921.43309-3-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 10:19, jack.zhu wrote:
> Add DT binding document for Starfive MIPI CSI2 receiver

Subject: drop second/last, redundant "add binding document". The
"dt-bindings" prefix is already stating that these are bindings and it
is a document. Write something useful instead.

> 
> Signed-off-by: jack.zhu <jack.zhu@starfivetech.com>
> ---
>  .../media/starfive,jh7110-mipi-csi2.yaml      | 177 ++++++++++++++++++
>  1 file changed, 177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/starfive,jh7110-mipi-csi2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-mipi-csi2.yaml
> new file mode 100644
> index 000000000000..6569fac9e856
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/starfive,jh7110-mipi-csi2.yaml
> @@ -0,0 +1,177 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

Why for patch 1 and 2 you are using difference SPDX?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/starfive,jh7110-mipi-csi2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Starfive JH7110 MIPI CSI-2 receiver
> +
> +maintainers:
> +  - Jack Zhu <jack.zhu@starfivetech.com>
> +  - Changhuang Liang <changhuang.liang@starfivetech.com>
> +
> +description: |-

Drop |-

> +  The JH7110 MIPI CSI-2 receiver device is responsible for handling CSI2
> +  protocol based camera sensor data stream.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - starfive,jh7110-csi2rx
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: CSI2Rx system clock
> +      - description: Gated Register bank clock for APB interface
> +      - description: pixel Clock for Stream interface 0
> +      - description: pixel Clock for Stream interface 1
> +      - description: pixel Clock for Stream interface 2
> +      - description: pixel Clock for Stream interface 3
> +
> +  clock-names:
> +    items:
> +      - const: sys_clk
> +      - const: p_clk
> +      - const: pixel_if0_clk
> +      - const: pixel_if1_clk
> +      - const: pixel_if2_clk
> +      - const: pixel_if3_clk

Drop _clk suffixes

> +
> +  resets:
> +    items:
> +      - description: CSI2Rx system reset
> +      - description: Gated Register bank reset for APB interface
> +      - description: pixel reset for Stream interface 0
> +      - description: pixel reset for Stream interface 1
> +      - description: pixel reset for Stream interface 2
> +      - description: pixel reset for Stream interface 3
> +
> +  reset-names:
> +    items:
> +      - const: sys_rst

Drop _rst suffixes

> +      - const: p_rst
> +      - const: pixel_if0_rst
> +      - const: pixel_if1_rst
> +      - const: pixel_if2_rst
> +      - const: pixel_if3_rst
> +
> +  phys:
> +    maxItems: 1
> +    description: MIPI D-PHY
> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Input port node, single endpoint describing the CSI-2 transmitter.
> +
> +        properties:
> +          endpoint:
> +            $ref: video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              bus-type:
> +                items:

This is not an array.

> +                  - const: 4
> +
> +              clock-lanes:
> +                maxItems: 1

Not an array...

> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +                items:
> +                  maximum: 4
> +
> +            required:
> +              - bus-type

Since this is fixed 4, do you actually require it? Why?

> +              - clock-lanes
> +              - data-lanes
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port node
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - phys
> +  - phy-names
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

Drop blank line

> +    csi2rx: csi-bridge@19800000 {

Maybe just "csi@"?
> +        compatible = "starfive,jh7110-csi2rx";
> +        reg = <0x19800000 0x10000>;
> +        clocks = <&ispcrg 7>,
> +            <&ispcrg 6>,

Indentation looks odd... did you align it?

> +            <&ispcrg 8>,
> +            <&ispcrg 9>,
> +            <&ispcrg 10>,
> +            <&ispcrg 11>;
> +        clock-names = "sys_clk", "p_clk",
> +            "pixel_if0_clk", "pixel_if1_clk",
> +            "pixel_if2_clk", "pixel_if3_clk";
> +        resets = <&ispcrg 9>,
> +            <&ispcrg 4>,
> +            <&ispcrg 5>,
> +            <&ispcrg 6>,
> +            <&ispcrg 7>,
> +            <&ispcrg 8>;
> +        reset-names = "sys_rst", "p_rst",
> +            "pixel_if0_rst", "pixel_if1_rst",
> +            "pixel_if2_rst", "pixel_if3_rst";
> +        phys = <&csi_phy>;
> +        phy-names = "dphy";


Best regards,
Krzysztof

