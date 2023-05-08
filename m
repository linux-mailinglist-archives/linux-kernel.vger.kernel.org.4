Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75426FB507
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjEHQ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjEHQ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:26:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451476A5A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:26:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so50293718a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683563171; x=1686155171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqUCuwJM/g3EFoSQacvWVUopp/6og/v2DquIG4Af4pU=;
        b=KM/Kg88ajUs3FzvWB1RV4nfiDTMs7+rQNMrzlKoxwAg/jJrdMxM4ysNI1ljdQiWLhz
         sAvs90yzW7qdRLYuekY1IrOX+zvOvCviOJgPBX/gMfaZG6zwODJvHgvsqajBmSLv9j/h
         gF2adaEq0RvZGO8jyAUzoisy2IvdMipjSp4rk4J2BlFQ0R1ibGfi+xYu0lb7+hYRdcq0
         rxwfMAxldAHhYp/SyrccFt/QawD84GtOwGdIgnnbBzuqqvhN2hmWso9hbq+EXEy9dWEs
         PqsrY+iyflMTUySz8edLQ4thBjPw7Z79ePq0v7nX74Yt/LYm0kF9o1RoIYQmDHgSjIBN
         ZgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683563171; x=1686155171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqUCuwJM/g3EFoSQacvWVUopp/6og/v2DquIG4Af4pU=;
        b=CrnsoRFWoIbvXe43c2QQGIWLbGqm3CSsyQ632SclXl2cndx9qFzix1qN1QZwQeymiN
         tZn7kv9bLAsc1HXTsxIlxH92HdtiSNAY5o6OcS6EqoKnDcDnAuwvQPO8mCCo5tcuICfO
         q3YdudNwr2ISUha7jYXRWTyXpmiHC2kzzxCWKd7ldTZKL2ue1oIWE01Ex3seSuyY51uN
         PGLR67GOnZpwcXixgm6jswyL1bmtkx7cnE9Vucp1PQhe/sNM432MnLvPneLKoH92Ezxi
         l8xUCgE/2oJfn+CmxR/7YDuzQqj0yypaEJsKyeJ/Xf33jUmiQoHGBuKdVsL9se2EsrjM
         0fFA==
X-Gm-Message-State: AC+VfDwHMGs3UCHaj3H5LyeywRiOSdDr4Kke8u01voG7Hs7CIk6GiGgp
        SK7hHHw2CoDimzYQedZqx0WuNA==
X-Google-Smtp-Source: ACHHUZ71x+olha/HAiNUgChvrth/xw9isR7HMRpGZqUGqURHtoYdN5yrKFOStwtnJOrRY1VgR3AuIg==
X-Received: by 2002:a17:907:724b:b0:94d:e2ef:1618 with SMTP id ds11-20020a170907724b00b0094de2ef1618mr8952057ejc.7.1683563170668;
        Mon, 08 May 2023 09:26:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id m24-20020a1709062b9800b009686a7dc71csm172272ejg.30.2023.05.08.09.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 09:26:10 -0700 (PDT)
Message-ID: <deb13eb1-7d6e-27a8-738d-70ba70358e71@linaro.org>
Date:   Mon, 8 May 2023 18:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230508104801.445261-1-claudiu.beznea@microchip.com>
 <20230508104801.445261-3-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508104801.445261-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 12:47, Claudiu Beznea wrote:
> Convert Atmel PMC documentation to yaml.

Please mention the changes against original binding. At least
clock-names look different, maybe more.

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/clock/at91-clock.txt  |  28 ----
>  .../bindings/clock/atmel,at91rm9200-pmc.yaml  | 154 ++++++++++++++++++
>  2 files changed, 154 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
> index 13f45db3b66d..57394785d3b0 100644
> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
> @@ -28,31 +28,3 @@ For example:
>  		#clock-cells = <0>;
>  	};
>  
> -Power Management Controller (PMC):
> -
> -Required properties:
> -- compatible : shall be "atmel,<chip>-pmc", "syscon" or
> -	"microchip,sam9x60-pmc"
> -	<chip> can be: at91rm9200, at91sam9260, at91sam9261,
> -	at91sam9263, at91sam9g45, at91sam9n12, at91sam9rl, at91sam9g15,
> -	at91sam9g25, at91sam9g35, at91sam9x25, at91sam9x35, at91sam9x5,
> -	sama5d2, sama5d3 or sama5d4.
> -- #clock-cells : from common clock binding; shall be set to 2. The first entry
> -  is the type of the clock (core, system, peripheral or generated) and the
> -  second entry its index as provided by the datasheet
> -- clocks : Must contain an entry for each entry in clock-names.
> -- clock-names: Must include the following entries: "slow_clk", "main_xtal"
> -
> -Optional properties:
> -- atmel,osc-bypass : boolean property. Set this when a clock signal is directly
> -  provided on XIN.
> -
> -For example:
> -	pmc: pmc@f0018000 {
> -		compatible = "atmel,sama5d4-pmc", "syscon";
> -		reg = <0xf0018000 0x120>;
> -		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> -		#clock-cells = <2>;
> -		clocks = <&clk32k>, <&main_xtal>;
> -		clock-names = "slow_clk", "main_xtal";
> -	};
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> new file mode 100644
> index 000000000000..58b702520600
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/atmel,at91rm9200-pmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
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
> +          - const: syscon

No improvements here. Why this is part of this group not the one at the
end? I already talked about this.

> +      - items:
> +          - enum:
> +              - atmel,at91sam9g15-pmc
> +              - atmel,at91sam9g20-pmc
> +              - atmel,at91sam9g25-pmc
> +              - atmel,at91sam9g35-pmc
> +              - atmel,at91sam9x25-pmc
> +              - atmel,at91sam9x35-pmc
> +          - enum:
> +              - atmel,at91sam9260-pmc
> +              - atmel,at91sam9x5-pmc
> +          - const: syscon
> +      - items:
> +          - enum:
> +              - atmel,at91rm9200-pmc
> +              - atmel,at91sam9g45-pmc
> +              - atmel,at91sam9n12-pmc
> +              - atmel,at91sam9rl-pmc
> +              - atmel,sama5d2-pmc
> +              - atmel,sama5d3-pmc
> +              - atmel,sama5d4-pmc
> +              - microchip,sam9x60-pmc
> +              - microchip,sama7g5-pmc
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    description: |
> +      - 1st cell is the clock type, one of PMC_TYPE_CORE, PMC_TYPE_SYSTEM,
> +        PMC_TYPE_PERIPHERAL, PMC_TYPE_GCK, PMC_TYPE_PROGRAMMABLE (as defined
> +        in <dt-bindings/clock/at91.h>)
> +      - 2nd cell is the clock identifier as defined in <dt-bindings/clock/at91.h
> +        (for core clocks) or as defined in datasheet (for system, peripheral,
> +        gck and programmable clocks).
> +    const: 2
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
> +
> +  atmel,osc-bypass:
> +    description: set when a clock signal is directly provided on XIN
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names
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
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - atmel,sama5d4-pmc
> +              - atmel,sama5d3-pmc
> +              - atmel,sama5d2-pmc

Keep similar order as in compatibles list, e.g. alphanumeric.

Best regards,
Krzysztof

