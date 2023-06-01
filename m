Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C8B719394
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjFAGwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjFAGwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:52:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AE1E7
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:52:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51456392cbbso3824617a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685602361; x=1688194361;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwHjtYUJdsrG0msa7NqJ4u/zdOc48mf7/9J/cZ8t3qw=;
        b=f6HY72hazd+X+w8farWypvyNbzn6fqFqVLPC+t+g+O4NhxBfngmkXaub5dH0qzzFav
         i46eAnYCIN0GrS8xebB8w5+rKb7m9j+xIBPzVpppQUiC0D7afBzciV3nhYr/gJmlD7xC
         X3VeT92JdBVAH8xbxAc8dk36PzXNcaaL7hXII8Q1AJn4muBAbeoAFbSYqfy1uJOpvIzB
         YV8C1jEet5WRgebAbtLdOtczF+hYQWM25KfOBfaqkBP+9Oi8AGY6zNWYBAf5OpgmVcFr
         cmMgK83OtSQZKOEKspcYmgsG1Vv6p1mShW/3i3j/8ZhvGlYK9rtwbOfWmClN71bAw7mb
         rrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685602361; x=1688194361;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwHjtYUJdsrG0msa7NqJ4u/zdOc48mf7/9J/cZ8t3qw=;
        b=NMn3kV56ZJpa8I3BVq3Wlzl12nGF4rJZS27VHXyHlJo/UxVlupIAubkkeDmS6ADsGE
         3tqkc+gyqNtT3EF/ZX/8D6SKm7Jyy6JSqtJ833FR9k/Lujspko3y9fhQt88p1VaAbBWw
         emHsqhWdPnmJ0q+htSXKYVzibSdAKntAZRBCPDzKi6iPJQDbPeMbFde1dngg20TQszQ1
         dr8GDFp2j9+tLWAU6qWNSkCNAete8sfq883o1lWTXnB/WGX6qZRARUFQTIYq71s7ve/R
         K3rf3iHTDPDLLfYWwG2YVdQnbHtC3GfhfUQkz52gqt4rSJ3XL5b2H1ZO4P08mHzbDo+Y
         GOpw==
X-Gm-Message-State: AC+VfDw2uKtv9cwBH7AxCJPlFAk4dlXV1EyJR1Z+vEq9h3sk3zmzFfUE
        d60r/40KdJeaTeU9vPMheEEKvA==
X-Google-Smtp-Source: ACHHUZ5X8WXupXGClZmCaYhvGoANbWJPo9nSu6RiGguENudLRzJcQf0nyid7qvw/WFo2NpWqsVwGXw==
X-Received: by 2002:a17:907:7b95:b0:96f:8afc:b310 with SMTP id ne21-20020a1709077b9500b0096f8afcb310mr954904ejc.3.1685602361435;
        Wed, 31 May 2023 23:52:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709062b4700b0096f6a131b9fsm9980710ejg.23.2023.05.31.23.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 23:52:41 -0700 (PDT)
Message-ID: <d8ee85b8-464b-1302-ecc9-e6c39d0f3eaf@linaro.org>
Date:   Thu, 1 Jun 2023 08:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/5] dt-bindings: gpio: Add HPE GXP GPIO
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
 <20230531151918.105223-2-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531151918.105223-2-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 17:19, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Provide access to the register regions and interrupt for GPIO. There
> will be two drivers available. The first driver under the hpe,gxp-gpio
> binding will provide GPIO information for the VUHC, CSM, and FN2
> host interfaces. The second driver under the hpe,gxp-gpio-pl will
> provide GPIO information from the CPLD interface. The main difference
> and need for two separate bindings is they have different interrupt
> parents. The other is hpe,gxp-gpio is a combination of physical
> and virtual GPIOs where as hpe,gxp-gpio-pl are all physical
> GPIOs from the CPLD.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> 
> v2:
>  *Put binding patch before the driver in the series
>  *Improved patch description
>  *Removed oneOf and items in compatible definition
>  *Moved additionalProperties definition to correct spot in file
>  *Fixed indentation on example

I don't think it was fixed.

>  *Improved description in .yaml
> ---
>  .../bindings/gpio/hpe,gxp-gpio.yaml           | 190 ++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
> new file mode 100644
> index 000000000000..b92b7d72d39b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
> @@ -0,0 +1,190 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/hpe,gxp-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP gpio controllers
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +description:
> +  Interruptable GPIO drivers for the HPE GXP that covers multiple interfaces
> +  of both physical and virtual GPIO pins.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hpe,gxp-gpio
> +      - hpe,gxp-gpio-pl
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 6
> +
> +  reg-names:
> +    minItems: 2
> +    maxItems: 6
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-line-names:
> +    minItems: 80
> +    maxItems: 300
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - hpe,gxp-gpio
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: CSM GPIO interface
> +            - description: fn2 virtual button GPIO
> +            - description: fn2 system status GPIO
> +            - description: vuhc GPIO status interface
> +        reg-names:
> +          items:
> +            - const: csm
> +            - const: fn2-vbtn
> +            - const: fn2-stat
> +            - const: vuhc
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - hpe,gxp-gpio-pl
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Programmable logic device GPIO
> +            - description: Programmable logic device interrupt GPIO
> +        reg-names:
> +          items:
> +            - const: base
> +            - const: interrupt
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio@0 {
> +        compatible = "hpe,gxp-gpio";
> +        reg = <0x0 0x400>, <0x200046 0x1>, <0x200070 0x08>, <0x400064 0x80>;
> +        reg-names = "csm", "fn2-vbtn", "fn2-stat", "vuhc";
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        interrupt-parent = <&vic0>;
> +        interrupts = <10>;
> +        gpio-line-names = "IOP_LED1", "IOP_LED2",
> +        "IOP_LED3", "IOP_LED4",

Broken indentation. This is aligned with opening " in previous line.

> +        "IOP_LED5", "IOP_LED6",
> +        "IOP_LED7", "IOP_LED8",
> +        "FAN1_INST", "FAN2_INST",
> +        "FAN3_INST", "FAN4_INST",
> +        "FAN5_INST", "FAN6_INST",
> +        "FAN7_INST", "FAN8_INST",
> +        "FAN1_FAIL", "FAN2_FAIL",
> +        "FAN3_FAIL", "FAN4_FAIL",
> +        "FAN5_FAIL", "FAN6_FAIL",
> +        "FAN7_FAIL", "FAN8_FAIL",
> +        "FAN1_ID", "FAN2_ID",
> +        "FAN3_ID", "FAN4_ID",
> +        "FAN5_ID", "FAN6_ID",
> +        "FAN7_ID", "FAN8_ID",
> +        "IDENTIFY", "HEALTH_RED",
> +        "HEALTH_AMBER", "POWER_BUTTON",
> +        "UID_PRESS", "SLP",
> +        "NMI_BUTTON", "RESET_BUTTON",
> +        "SIO_S5", "SO_ON_CONTROL",
> +        "PSU1_INST", "PSU2_INST",
> +        "PSU3_INST", "PSU4_INST",
> +        "PSU5_INST", "PSU6_INST",
> +        "PSU7_INST", "PSU8_INST",
> +        "PSU1_AC", "PSU2_AC",
> +        "PSU3_AC", "PSU4_AC",
> +        "PSU5_AC", "PSU6_AC",
> +        "PSU7_AC", "PSU8_AC",
> +        "PSU1_DC", "PSU2_DC",
> +        "PSU3_DC", "PSU4_DC",
> +        "PSU5_DC", "PSU6_DC",
> +        "PSU7_DC", "PSU8_DC",
> +        "", "",
> +        "", "",
> +        "", "",
> +        "", "",
> +        "", "",
> +        "", "",
> +        "", "";
> +    };
> +
> +  - |
> +    gpio@51000300 {
> +        compatible = "hpe,gxp-gpio-pl";
> +        reg = <0x51000300 0x40>, <0x51000380 0x10>;
> +        reg-names = "base", "interrupt";

One example is enough, because this almost does not differ from previous.

Best regards,
Krzysztof

