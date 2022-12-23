Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB76654D58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiLWITM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiLWITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:19:09 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3515E33CC7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:19:07 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bf43so6186570lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYP0kVcMdH1JUs4mFaaNK4geOaH1AZDQCGqMj2yIKIs=;
        b=pdq34oqAbkBhwBwUFlF/oNI9TXjHWTAlercAm21EmG1yw57s8BN+3+PK9J1MTUm/aI
         iPFPLKjO/z0O6oRoao7susVVkp89RygzTu6XcdErl7SXfRX4eP0xLowVRIDYe3pHDuFz
         4LOHdyfle7hzOCbSuUdd8WEEHFV6dxC02pJWIvgp0p2s7XbjblQLtJsbRFHnzj0rYLfn
         8GKaFUvyOkWGS2jTDr1hRs4MkkG2W852bwHaJYs9yMdpLmDzaJRXXUk6WZpCFr1Oh1VG
         NNVbVfc/B0qHMuovFe6sXraotcyuKZXUcOX3C2yUPRpFhgUw3jWFX+j3u7iVKfwYRHNs
         lgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYP0kVcMdH1JUs4mFaaNK4geOaH1AZDQCGqMj2yIKIs=;
        b=iwG/YgGffJN0FCDTSlPNrQyvfWxLx/l/gG3CqRPN4FEqu+dQb79Rc9ZaY0L8SjnTH3
         UDFo11U96sqNZXE4t7OiefxH2Z6SakY4Z7rb/N9o3X3QBpcE+hPFrlqtxdiXxXHOyCVe
         iOOmUjlj4AoptKr3dwbcfkwHKubdL4kBoruamFRCF1NgPrXLm1ElxellFiyVz6LUEOge
         /2A4Ev0sLj7qquWSC4Gl6USF2S2xoxLfKcpWn1YnVlum1KHszJMXbhQxOBFTMJ8K7qq2
         4V2j+xOSE+G9VFBQooXR+GevASyA3bYqINgDQ4rBcmTlp70Lgf1ksQ4GgRWW9dbrXUou
         yZ8g==
X-Gm-Message-State: AFqh2kojiOAwpAMXpq/RE/QF+vLZGVyRCGPARy5/RlTqytYLhD2dojXV
        C4OPs+zUlOI96T/BCtK3W/MvjQ==
X-Google-Smtp-Source: AMrXdXv0EsqcoNgrB8S0klzfZzdakYkrtNwEy2lBcFG/Z1ptO4Z0atMnnFqWPhzHtMGuDvPfLx3Mew==
X-Received: by 2002:a05:6512:1513:b0:4a4:a7d7:4769 with SMTP id bq19-20020a056512151300b004a4a7d74769mr2639547lfb.8.1671783545552;
        Fri, 23 Dec 2022 00:19:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q30-20020a19431e000000b004b373f61a60sm421582lfa.96.2022.12.23.00.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 00:19:04 -0800 (PST)
Message-ID: <01a5f912-10d2-d5fe-023e-e2e6613ac03b@linaro.org>
Date:   Fri, 23 Dec 2022 09:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: adc: add ADS7924
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>, hvilleneuve@dimonoff.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222203610.2571287-1-hugo@hugovil.com>
 <20221222203610.2571287-4-hugo@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222203610.2571287-4-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 21:36, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add device tree bindings document for the Texas Instruments ADS7924
> ADC.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../bindings/iio/adc/ti,ads7924.yaml          | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> new file mode 100644
> index 000000000000..5408ec95e417
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads7924.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS7924 4 channels 12 bits I2C analog to digital converter
> +
> +maintainers:
> +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> +
> +description: |
> +  Texas Instruments ADS7924 4 channels 12 bits I2C analog to digital converter
> +
> +  Specifications:
> +    https://www.ti.com/lit/gpn/ads7924
> +
> +properties:
> +  compatible:
> +    const: ti,ads7924
> +
> +  vref-supply:
> +    description:
> +      The regulator supply for the ADC reference voltage (AVDD)
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      GPIO used for controlling the reset pin

Drop description, it's obvious (unless you want to actually describe
some pieces of the hardware).

> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vref-supply
> +  - "#address-cells"
> +  - "#size-cells"

Keep the same order as in properties. This one is more common (reg after
compatible).

> +
> +additionalProperties: false
> +
> +patternProperties:

patternProperties go immediately after properties.

> +  "^channel@[0-3]+$":
> +    type: object

additionalProperties: false on this level

> +    description:
> +      Child nodes needed for each channel that the platform uses.

I cannot understand this sentence at all. Instead describe the hardware
you are here representing. What's this?

> +
> +    properties:
> +      reg:
> +        description: |
> +          0: Voltage over AIN0 and GND.
> +          1: Voltage over AIN1 and GND.
> +          2: Voltage over AIN2 and GND.
> +          3: Voltage over AIN3 and GND.
> +        items:
> +          - minimum: 0
> +            maximum: 3
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@48 {
> +            compatible = "ti,ads7924";
> +            reg = <0x48>;
> +            vref-supply = <&ads7924_reg>;
> +            reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            channel@0 {
> +              reg = <0>;

Messed indentation. Keep 4 spaces.

> +              label = "CH0";
> +            };
> +            channel@1 {
> +              reg = <1>;
> +              label = "CH1";
> +            };
> +            channel@2 {
> +              reg = <2>;
> +              label = "CH2";
> +            };
> +            channel@3 {
> +              reg = <3>;
> +              label = "CH3";
> +            };
> +        };
> +    };
> +...

Best regards,
Krzysztof

