Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434C749589
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjGFGYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjGFGX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:23:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7060D1FED
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:22:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98df3dea907so35480766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 23:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688624576; x=1691216576;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9HBGNjA/AFaYPQtAfARvvX4VPrQmoZY1RYa/BV2PKyw=;
        b=jQUEjdB/XzCIlnlw7mfxPpowKF/8Bb9UIhtQIfj2jkkVohOJQjHMYFFLaYw0RwNGl8
         YaZoUjjpOwP4Ra8Ps8aR88ZtTjrKo+MEvrzM/XFa4UmJ37FpKwEMqxXcK8BTzXoHX5pU
         URxfLiqjCXREHmhij11331U6N8byRxOJxrCt07BNrOfMxe4wN2R0cvBlZAO5G0PXtyGj
         XKsmm5yH1YE6sq54M1Y0hOS29fOmS9yxQ3Ajvc/vcSt29N2YzoDwskCj/bGgYBZ7zFgd
         Omavvkai6NfdVaeB8JuH3fqquUL62S/RuyFoa2GjBroz+vkDVYWr3odccgU1nTIRdzH/
         tUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688624576; x=1691216576;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HBGNjA/AFaYPQtAfARvvX4VPrQmoZY1RYa/BV2PKyw=;
        b=MuUp8kCFAzGnm5bhw88ZGj9Ax3KtplPzAE9DuA/aRT6fP3eSmUK+85Y2oioHwqp0nA
         odvaebtwHqjs8i5GtqRFpV7+sG0EUVXrtMTzkJ915Ue+tMoPKsDayCLk3s5Zh+wyI7lq
         MuTIDHXBJlGUYYjAFuTca+vJxxeNXR8P9miuX/c4kb6J/8EQD2AhtE3KnR5NbgLmUKDz
         6eJICsSb6xpccQ0idIAjgXSNN8TbTPauxunFGn/o6Gyc83c1q3utLgDAmUbLDlRTavh8
         q8Y9m5VwW/EWGRFkoKeehFdorPQk7CvkEyuMycwCjXV44yw6OafxxHveS+EgagRcDXB5
         SWwg==
X-Gm-Message-State: ABy/qLb4EQD2FDGNhaMu8fq97Ngp5J6RTQP7wqdqKWxxZakJIEYLZjBw
        u7REs0KqT0qCXUstphYuEkzhnA==
X-Google-Smtp-Source: APBJJlECTV1XySP1t2wRIGpWXPZNKDpC1/U0MAaYZTvZDI1ciIxeA5aoBkBeICCqVtb8gSTOtE3wLw==
X-Received: by 2002:a17:907:8184:b0:992:6656:4043 with SMTP id iy4-20020a170907818400b0099266564043mr540927ejc.53.1688624576526;
        Wed, 05 Jul 2023 23:22:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id c24-20020a170906171800b009933eccf46fsm381745eje.6.2023.07.05.23.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 23:22:55 -0700 (PDT)
Message-ID: <046d4744-9521-7b5d-759c-6dedbafd9205@linaro.org>
Date:   Thu, 6 Jul 2023 08:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/5] dt-bindings: gpio: Add HPE GXP GPIO
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230705194544.100370-1-nick.hawkins@hpe.com>
 <20230705194544.100370-2-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705194544.100370-2-nick.hawkins@hpe.com>
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

On 05/07/2023 21:45, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Provide access to the register regions and interrupt for GPIO. The
> driver under the hpe,gxp-gpio-pl will provide GPIO information from the
> CPLD interface. The CPLD interface represents all physical GPIOs. The
> GPIO interface with the CPLD allows use of interrupts.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> 
> v5:
>  *Removed use of gpio-gxp in favor of just supporting
>   hpe,gxp-gpio-pl for now as the full gpio-gxp will
>   require a much larger patchset

Bindings describe hardware, not drivers, and should be rather complete.


>  *Modified commit description to reflect removal of
>   hpe,gxp-gpio
> v4:
>  *Fix min and max values for regs
> v3:
>  *Remove extra example in examples
>  *Actually fixed indentation on example - Aligned
>   GPIO line names with " above.
> v2:
>  *Put binding patch before the driver in the series
>  *Improved patch description
>  *Removed oneOf and items in compatible definition
>  *Moved additionalProperties definition to correct spot in file
>  *Fixed indentation on example
>  *Improved description in .yaml
> ---
>  .../bindings/gpio/hpe,gxp-gpio.yaml           | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
> new file mode 100644
> index 000000000000..799643c1a0c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/hpe,gxp-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP gpio controllers

GPIO
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +
> +description:
> +  Interruptable GPIO drivers for the HPE GXP that covers multiple interfaces

"drivers" as Linux drivers? If so, then drop and rephrase to describe
hardware.

> +  of both physical and virtual GPIO pins.
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-gpio-pl> +
> +  reg:
> +    items:
> +      - description: pl base gpio
> +      - description: pl interrupt gpio
> +
> +  reg-names:
> +    items:
> +      - const: base
> +      - const: interrupt
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-line-names:
> +    maxItems: 80
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
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        gpio@51000300 {

Wrong indentation. Use 2 or 4 (preferred) spaces, not 8.

> +          compatible = "hpe,gxp-gpio-pl";
> +          reg = <0x51000300 0x7f>, <0x51000380 0x20>;
> +          reg-names = "base", "interrupt";
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +          interrupt-parent = <&vic0>;
> +          interrupts = <24>;
> +          gpio-line-names =
> +          "IOP_LED1", "IOP_LED2", "IOP_LED3", "IOP_LED4", "IOP_LED5", "IOP_LED6", "IOP_LED7", "IOP_LED8",

And this is even worse.

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

Best regards,
Krzysztof

