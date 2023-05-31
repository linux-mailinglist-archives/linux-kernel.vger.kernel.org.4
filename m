Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2243717ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjEaI4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjEaIz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:55:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212AD11F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:55:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso6950009a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685523355; x=1688115355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6am1AiEAOxoY0UZIv4ELH1CWM+kxqYxNYLZvqz76ssg=;
        b=KJ9VJqUN4y/AWCB+TmVu/7+Wcfsbf2PMdAZ/EBxXIg0k7ZLBL47iPhc7dlWofUUUZt
         gRMN8SVOUmjSZPxZDPU02r1Ycf9HDxx+eaJx7pvMQWpOm/hkRlBeB8bbpq+iXRQ17zP5
         H7OVnccJr4h3PbPplpp9hO4Vi0y/dZ63HTgaaGcuLuOHK0hUoPjrYzLum0W57SmhO6KU
         o/7luo/H/ErlXIBrnY8cHEpv6p1ueEZ+X+e0ykJufWac7Et3nSM5dwkFDwVUWLnPcFcJ
         J6nADJ6tW5lw7NNaBRjxQmxqamOilRdkMZnOTYub2bQS+dFv+UMs32TKbgHY/3zcnHcj
         txlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523355; x=1688115355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6am1AiEAOxoY0UZIv4ELH1CWM+kxqYxNYLZvqz76ssg=;
        b=AfeFdrtuu35KLpKh4ArciscQMNNTP2OZwZeAaf7J5Qg/k9ROu3QANfvMCp02cU5L+w
         RiID0Zp25ejU48qcIIZoI8xVpfK5wxa0IHmTFoWxjuyX9y5shyUIQNFA4CwMVL4KNGbR
         +q/hJywtn9SzFlyNzumjM5f6fjbyLWqzSeFy7ZWsQNzroPdY315HUCdFmuH5QMV8WcQN
         gr07WQU1Gr/YcYBwHqPMnTMDR4uwnxqkPtbxHHiBEKqW+2k4WEEQs2DvuXZuYewryDi/
         z5lyksvXXDL4/GgLZvNz8S1BMYi+fKk+u/cZy9uYBoZJ2rZJW9djAuf9Yc0i1eoh76Ku
         PODg==
X-Gm-Message-State: AC+VfDw4tdMHSMzxNx+IvYBwBe415T6FxNUEDMr2ntG7CXgXjeVqg8hD
        1K0vkYyTTqQ9dJ5szmMRtnmupA==
X-Google-Smtp-Source: ACHHUZ7bt0BD77gr6LG3aEUlXExVX18Lo4MW6pqODLIuWHO4GmhfSjRNckCop3Gvd4nZktxjemKicQ==
X-Received: by 2002:a17:907:97c3:b0:974:b15:fcda with SMTP id js3-20020a17090797c300b009740b15fcdamr5145556ejc.54.1685523353731;
        Wed, 31 May 2023 01:55:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906151000b0096b15e4ffcesm8577273ejd.85.2023.05.31.01.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:55:53 -0700 (PDT)
Message-ID: <46eced08-5bf6-3e4b-7a91-ff4d16c7dab9@linaro.org>
Date:   Wed, 31 May 2023 10:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/3] dt-bindings: timer: atmel,at91sam9260-pit: convert
 to yaml
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20230530090758.1652329-1-claudiu.beznea@microchip.com>
 <20230530090758.1652329-2-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530090758.1652329-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 11:07, Claudiu Beznea wrote:
> Convert Microchip AT91 PIT bindings to YAML. Along with it clocks and
> clock-names bindings were added as the drivers needs it to ensure proper
> hardware functionality.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt | 12 ---
>  .../bindings/timer/atmel,at91sam9260-pit.yaml | 99 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 67a66bf74895..54d3f586403e 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -4,18 +4,6 @@ Chipid required properties:
>  - compatible: Should be "atmel,sama5d2-chipid" or "microchip,sama7g5-chipid"
>  - reg : Should contain registers location and length
>  
> -PIT Timer required properties:
> -- compatible: Should be "atmel,at91sam9260-pit"
> -- reg: Should contain registers location and length
> -- interrupts: Should contain interrupt for the PIT which is the IRQ line
> -  shared across all System Controller members.
> -
> -PIT64B Timer required properties:
> -- compatible: Should be "microchip,sam9x60-pit64b"
> -- reg: Should contain registers location and length
> -- interrupts: Should contain interrupt for PIT64B timer
> -- clocks: Should contain the available clock sources for PIT64B timer.
> -
>  System Timer (ST) required properties:
>  - compatible: Should be "atmel,at91rm9200-st", "syscon", "simple-mfd"
>  - reg: Should contain registers location and length
> diff --git a/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml b/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
> new file mode 100644
> index 000000000000..d0f3f80db4cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/atmel,at91sam9260-pit.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/atmel,at91sam9260-pit.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip AT91 Periodic Interval Timer (PIT)
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  Microchip AT91 periodic interval timer provides the operating system scheduler
> +  interrupt. It is designed to offer maximum accuracy and efficient management,
> +  even for systems with long response time.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: microchip,sama7g5-pit64b

From where do you have this compatible? Wasn't in old binding and commit
msg does not explain it.


> +          - const: microchip,sam9x60-pit64b
> +      - items:
> +          enum:

These are not items. Just enum.. Does it even work?

> +            - atmel,at91sam9260-pit
> +            - microchip,sam9x60-pit64b
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: atmel,at91sam9260-pit
> +    then:
> +      properties:
> +        interrupts:
> +          description:
> +            Shared interrupt between all system controller members (power management
> +            controller, watchdog, PIT, reset controller, real-time timer, real-time
> +            clock, memory controller, debug unit, system timer).
> +        clocks:
> +          maxItems: 1
> +
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 2
> +        clock-names:
> +          items:
> +            - const: pclk
> +            - const: gclk

interrupts? They are still required, so why no description here?

> +      required:
> +        - clock-names
> +
> +unevaluatedProperties: false

additionalProperties:false instead

> +

Best regards,
Krzysztof

