Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B88C6E6A97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjDRRI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjDRRIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:08:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF035BE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:08:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u3so23037915ejj.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681837718; x=1684429718;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pa0596FLGoKuck4TwQ+3+R91cz83Mb/ak2URkKOAZDw=;
        b=xt2O5Y+tVv532NiCjYg/SDb4kiK90IX1EQWKX/pEx85YjHjZMrutu0YGHeosz4HQ1p
         Rj1JNoDV1JVR6oWP/dpKZ6IIY8CDRyiXvzCN5h7FDF445QYpTfYYTeiOWmvIlBkVrBdm
         LoefvfHw0MfbWp4OUTBf7gbNrbiRy5fC1/Kx0QSPxpE/HnBWufwwinfzVguyDg19UaZ3
         +Sk7fDC2K6LMrUKrZAeYksQkNqTeGaRdrtgiXdfTb87S54LTYjzLc6oygjNK/kH/Am7W
         7KMgPo1VQzvAB27G0oGrB93j/o0c01VjJyWlKTxQaZ1eKLDzkwxMooS/BonyeOoNq07I
         wiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837718; x=1684429718;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pa0596FLGoKuck4TwQ+3+R91cz83Mb/ak2URkKOAZDw=;
        b=GLC2GNghfF6aNY23aInyCPzNUd5qcGfn6UonTf+rR0NGh2iE0pmuW07uRQ67gJi5yN
         bfkCzXQZVKQmjiCcCy3e8+p8AbqqtBwF+i5SwuiEFV92bCfTYyEqyixxJ6Mes3J5caAV
         XNs5MHDs/twd5eTWnX/viU/NYzeX0ljGFkgNOdLYLX/GKmfWsAnlJ4QInHxcA6UsPono
         b6g3h/1BZ5ysHa2vlxtyxn72b1NiTl6zH/OBg38zcIYm92vKR2yj8zp5MjT5vPWNCxhe
         Hg2DpCBjP6Win2yKeW2fi8ovRM4V2WjkCjgWY2oykN0wIgpPYxQLXCCe1Px56SR0HXmu
         hrFA==
X-Gm-Message-State: AAQBX9fh+p3MYizRsVj5IQb3e6S+y71trgzhZ+K7TFQJhFkUdK+0Ly8l
        L35eMu3warG6mqq4E9990/abkw==
X-Google-Smtp-Source: AKy350bPHMJPXFQ656yxTVuavRDq9+h8S5I8N9qcl8CcAPHYqdb8NUtjU1vzSDCDHSbTX2gwwW40+A==
X-Received: by 2002:a17:906:b242:b0:931:cd1b:3c0 with SMTP id ce2-20020a170906b24200b00931cd1b03c0mr9594973ejb.3.1681837718100;
        Tue, 18 Apr 2023 10:08:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709062a1900b0094f614e43d0sm3812770eje.8.2023.04.18.10.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 10:08:37 -0700 (PDT)
Message-ID: <a00202fc-434b-0350-de02-39870fd96da9@linaro.org>
Date:   Tue, 18 Apr 2023 19:08:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 5/9] dt-bindings: gpio: Add HPE GXP GPIO
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-6-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418152824.110823-6-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 17:28, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Provide access to the registers and interrupts for GPIO. The GPIO
> will have two driver instances: One for host, the other for CPLD.

Are these different devices? What does it mean here "instance"? What are
the differences?

> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/gpio/hpe,gxp-gpio.yaml           | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
> new file mode 100644
> index 000000000000..1cf4cff26d5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/hpe,gxp-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP gpio controllers

s/gpio/GPIO/

> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +description:
> +  Interruptable GPIO drivers for the HPE GXP that covers multiple interfaces.
> +
> +properties:
> +  compatible:
> +    oneOf:

Drop oneOf.

> +      - items:

And items. You do not have here multiple choices and items.

> +          - enum:
> +              - hpe,gxp-gpio
> +              - hpe,gxp-gpio-pl
> +
> +  reg:
> +    minItems: 3
> +    maxItems: 6
> +
> +  reg-names:
> +    minItems: 3
> +    maxItems: 6
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  gpio-line-names:
> +    minItems: 1
> +    maxItems: 300

Hm, shouldn't line-names match all GPIOs? If someone provides just one
name, how do you know for which GPIO is it?

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

Use consistent quotes. Either ' or "

> +
> +additionalProperties: false

Put it after allOf: block.

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
> +            - description: CSM
> +            - description: fn2 virtual button
> +            - description: fn2 system status
> +            - description: vuhc status
> +            - description: external virtual button

I have doubts you describe actual one GPIO controller...

> +        reg-names:
> +          items:
> +            - const: csm
> +            - const: fn2-vbtn
> +            - const: fn2-stat
> +            - const: vuhc
> +            - const: vbtn
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
> +            - description: Programmable logic led
> +            - description: Programmable logic health led
> +            - description: Programmable logic interrupt interface
> +        reg-names:
> +          items:
> +            - const: pl-led
> +            - const: pl-health
> +            - const: pl-int
> +
> +examples:
> +  - |
> +        gpio@0 {

Weird indentation. Use 4 spaces for example indentation.

> +          compatible = "hpe,gxp-gpio";
> +          reg = <0x0 0x400>, <0x200046 0x1>, <0x200070 0x08>, <0x400064 0x80>, <0x5100030f 0x1>;
> +          reg-names = "csm", "fn2-vbtn", "fn2-stat", "vuhc", "vbtn";
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +          interrupt-parent = <&vic0>;
> +          interrupts = <10>;
> +          gpio-line-names =
> +          "IOP_LED1", "IOP_LED2", "IOP_LED3", "IOP_LED4", "IOP_LED5", "IOP_LED6", "IOP_LED7", "IOP_LED8",

Broken indentation and unnecessary line break before.

> +          "FAN1_INST", "FAN2_INST", "FAN3_INST", "FAN4_INST", "FAN5_INST", "FAN6_INST", "FAN7_INST",
> +          "FAN8_INST", "FAN1_FAIL", "FAN2_FAIL", "FAN3_FAIL", "FAN4_FAIL", "FAN5_FAIL", "FAN6_FAIL",
> +          "FAN7_FAIL", "FAN8_FAIL", "FAN1_ID", "FAN2_ID", "FAN3_ID", "FAN4_ID", "FAN5_ID", "FAN6_ID",
> +          "FAN7_ID", "FAN8_ID", "IDENTIFY", "HEALTH_RED", "HEALTH_AMBER", "POWER_BUTTON", "UID_PRESS",
> +          "SLP", "NMI_BUTTON", "RESET_BUTTON", "SIO_S5", "SO_ON_CONTROL", "PSU1_INST", "PSU2_INST",
> +          "PSU3_INST", "PSU4_INST", "PSU5_INST", "PSU6_INST", "PSU7_INST", "PSU8_INST", "PSU1_AC",
> +          "PSU2_AC", "PSU3_AC", "PSU4_AC", "PSU5_AC", "PSU6_AC", "PSU7_AC", "PSU8_AC", "PSU1_DC",
> +          "PSU2_DC", "PSU3_DC", "PSU4_DC", "PSU5_DC", "PSU6_DC", "PSU7_DC", "PSU8_DC", "", "", "", "",
> +          "", "", "", "", "", "", "", "", "", "";
> +        };
> +


Best regards,
Krzysztof

