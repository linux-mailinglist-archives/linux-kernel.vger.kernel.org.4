Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52D6F6C42
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjEDMr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEDMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:47:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A0749FC
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:47:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94ef0a8546fso71413866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683204473; x=1685796473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbqmEvSI8fNnq/copnGLAXkGX86AYweHmXiMD8VPVeY=;
        b=eKDW7e2kSJUwvj9cuUAef9rRN5YE1ZPGTM8A2q/DhOtAQ/RxCw+vjayCwzmsLREXQz
         h/zrn0FI9uL5uk8ofeNGy2gLnybDyYlrRDA7wrUk2gDj9FPaDxMIxqEcBzKFRX2pzJ+3
         4zdT67vYlEZ/Ai9Em508YZNSRz0fJncw1ilURfL/zUfgjmDXCfpGxqeeMO+0DXLl/YXv
         CcioFf+cHII6yQSILoE0aMq0NDnPYH50PYzCsMAs2xY/RJWflrEW0HI2nhW1NdQ0G4Pu
         Nfmk3jxBe+UtO29v4X8lXiaGqJJrWVv5esn1ji9fVL0rNiSSQd/sDKpWBHiEpLj0j6Io
         UMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683204473; x=1685796473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbqmEvSI8fNnq/copnGLAXkGX86AYweHmXiMD8VPVeY=;
        b=NR+SCbi1PUXI9DddNd4oi0f+LBGd/stLJQY62sp2jZCb6WIu7Am4yrujAk/+oqiqcR
         uTu6mgg8RGjFpIGSU7os/Wq4evyltYEImYSrWNoOT2OZeT1dSzzb14cVdcx4Zs++Ip4V
         NAwYSbfxQw6PX5mv2cZcq6V9Bt3Bwtxg3pvl2dDiJkRPRglXHKReePQ8hGhULy42l6/8
         HPNQKH0YOH2cGb5fS9ZQs3Rpc/KMKjNvIUxxL2s0xe/iiOnUvZ4ufcZFJl4QDG6M42hX
         aRJtuMBP7Czouvgwszfd07v29jAerpn/LLl5hW+Nl+QhghXnUChIi93Uu8s4hqI5LxBg
         MZXQ==
X-Gm-Message-State: AC+VfDxGwmt1YAQhLtTc8UalGs64PUeQ4IfFFF8dXcsQMVSiAlvN8cai
        uWH1FMUR/n/aAJ8Xr1GBBHiKVg==
X-Google-Smtp-Source: ACHHUZ5a5T0CbH2FVRK40w4xfIAoT1WHLaqmHed+xyVHOrOBsjEmHjTvIBxh1FKgrAEezuTq2URoRQ==
X-Received: by 2002:a17:907:e90:b0:965:c58f:f8b9 with SMTP id ho16-20020a1709070e9000b00965c58ff8b9mr272891ejc.19.1683204473160;
        Thu, 04 May 2023 05:47:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id w14-20020a170907270e00b009659fed3612sm1083638ejk.24.2023.05.04.05.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:47:52 -0700 (PDT)
Message-ID: <a964eeef-1db0-0d8a-e2a5-9e4c5fd8b2f0@linaro.org>
Date:   Thu, 4 May 2023 14:47:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert to
 yaml
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230504060729.689579-1-claudiu.beznea@microchip.com>
 <20230504060729.689579-3-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504060729.689579-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 08:07, Claudiu Beznea wrote:
> Convert Atmel PMC documentation to yaml.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Thank you for your patch. There is something to discuss/improve.


> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> new file mode 100644
> index 000000000000..c4023c3a85f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/atmel,at91rm9200-pmc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both.

> +
> +title: Atmel Power Management Controller (PMC)
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  The power management controller optimizes power consumption by controlling all
> +  system and user peripheral clocks. The PMC enables/disables the clock inputs
> +  to many of the peripherals and to the processor.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: atmel,at91sam9260-pmc

Why this is separate, not part of bottom enum?

> +          - const: syscon

> +      - items:
> +          - enum:
> +              - atmel,at91sam9g20-pmc
> +          - enum:
> +              - atmel,at91sam9260-pmc

This should be const. You cannot have here different compatibles.

> +          - const: syscon
> +      - items:
> +          - enum:
> +              - atmel,at91sam9g15-pmc
> +              - atmel,at91sam9g25-pmc
> +              - atmel,at91sam9g35-pmc
> +              - atmel,at91sam9x25-pmc
> +              - atmel,at91sam9x35-pmc
> +          - enum:
> +              - atmel,at91sam9x5-pmc
> +          - const: syscon
> +      - items:
> +          - enum:
> +              - atmel,at91sam9g45-pmc
> +              - atmel,at91sam9n12-pmc
> +              - atmel,at91sam9rl-pmc
> +              - atmel,at91rm9200-pmc

Order by name?

> +              - atmel,sama5d4-pmc
> +              - atmel,sama5d3-pmc
> +              - atmel,sama5d2-pmc
> +              - microchip,sam9x60-pmc
> +              - microchip,sama7g5-pmc
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 2

Explain what the cells are for in description. Having '2' for clock
controller is not obvious.

> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  atmel,osc-bypass:
> +    type: boolean
> +    description: set when a clock signal is directly provided on XIN
> +
> +

Just one blank line.

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names

Keep the same order here as they appear in properties:.


> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,sam9x60-pmc
> +              - microchip,sama7g5-pmc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: td_slck
> +            - const: md_slck
> +            - const: main_xtal
> +      required:
> +        - clock-names
> +        - clocks

Drop required: here. It's already in top-level. Same in places below.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - atmel,at91rm9200-pmc
> +              - atmel,at91sam9260-pmc
> +              - atmel,at91sam9g20-pmc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: slow_xtal
> +            - const: main_xtal
> +      required:
> +        - clock-names
> +        - clocks
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - atmel,sama5d4-pmc
> +              - atmel,sama5d3-pmc
> +              - atmel,sama5d2-pmc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: slow_clk
> +            - const: main_xtal
> +      required:
> +        - clock-names
> +        - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmc: clock-controller@f0018000 {
> +        compatible = "atmel,sama5d4-pmc", "syscon";
> +        reg = <0xf0018000 0x120>;
> +        interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;

interrupt looks a bit odd. Are you sure it is correct?

> +        #clock-cells = <2>;
> +        clocks = <&clk32k>, <&main_xtal>;
> +        clock-names = "slow_clk", "main_xtal";
> +    };
> +
> +...

Best regards,
Krzysztof

