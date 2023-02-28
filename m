Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351E96A5459
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjB1IYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjB1IY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:24:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D14CA0D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:24:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so8892110wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677572666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCa9eFA4MAuvdUpjEutbEhVDEXa13F9jRr5aGoUB3t8=;
        b=R97enwMN3XC+NbplCZTfX0/1FWjL0/ibd4Ss7LWrablB8qE+oj645pJM4lUVcG2EEO
         vT4qiDpVqbxagWtoO1z4PLBqy4XmiPInZ3XxdKejzfVzudVwj4+Hg09nkH1aPUwX0Kdu
         2ltBKOx6NpeHs8/c3p/XXEDTB/fCeTS/L//E0hZwGieMPAKebRtYtD+RKcM5udhu/3Y0
         Uryt7404F5L8593ZAXq4ttqTT7UQxkwlm5S4PepoiclPT6AdtZqf+SSJXIT1LKcYiFIS
         Sl49KwNlUkrQjzXfad09XVJMs2nWT2saj8lRZV5LrmtCdhYPKSeNONnLhSCJ7Xiyhnvl
         ZEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677572666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCa9eFA4MAuvdUpjEutbEhVDEXa13F9jRr5aGoUB3t8=;
        b=CE7kfVIpm/8pCtI3FOYDISaZOFa9qzckEsbdZNxsb/extNkzBllkq/uhrXIQWgTv6l
         YlRTvQKrDSvJYsjmQQDXu7x8ELgdCYWq6Kxz+F9ZuJEK9Qx1bZiedJYlgHbYCA1M+iqd
         1519AycuOsCHT5Qf1KLOTD3ZsbGnQVzrQMHD7IccLu+LBtYvnPW3nfDEd3zWSYxFjKSW
         p0N2TTen4nnocvBGSc6+6J7uupPAYovcJBMuTYOs+tlVlknKlCkydvXQ/L//fFTZRO9E
         8pDonWI4OiW1rZ2W+RICMGbIqLu1juqkJWP/i3Tqwje7xChfitz2buaUZ13oJ4VW1wQT
         XhAA==
X-Gm-Message-State: AO0yUKWcYfJNuMj7hfFIAIoeVQLkwaJkdCM5un6GI9qhRWqnMXicdI5T
        WakHGJXSa49fGdS3R7CutuCUbg==
X-Google-Smtp-Source: AK7set+561ScUMYHwh6Ics+VWI683XONjmmmO5cGE2PRQI2VyhOWzhywPrSMutxHQNhiUzsuMT3LiA==
X-Received: by 2002:a05:600c:1d29:b0:3eb:2708:86ce with SMTP id l41-20020a05600c1d2900b003eb270886cemr1337572wms.31.1677572665796;
        Tue, 28 Feb 2023 00:24:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcdef000000b003e200d3b2d1sm11651518wmj.38.2023.02.28.00.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 00:24:25 -0800 (PST)
Message-ID: <1cf02768-aa92-3ad4-af00-566c16128352@linaro.org>
Date:   Tue, 28 Feb 2023 09:24:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 09/16] dt-bindings: pinctrl: mediatek: rt305x: split
 binding
Content-Language: en-US
To:     arinc9.unal@gmail.com,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
 <20230222183932.33267-10-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230222183932.33267-10-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 19:39, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The RT3352 and RT5350 SoCs each contain different pin muxing information,
> therefore, should be split. This can be done now that there are compatible
> strings to distinguish them from other SoCs.
> 
> Split the schema out to mediatek,rt3352-pinctrl.yaml and
> mediatek,rt5350-pinctrl.yaml.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/mediatek,rt305x-pinctrl.yaml      |  78 +-----
>  .../pinctrl/mediatek,rt3352-pinctrl.yaml      | 247 ++++++++++++++++++
>  .../pinctrl/mediatek,rt5350-pinctrl.yaml      | 210 +++++++++++++++
>  3 files changed, 462 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,rt5350-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
> index 61fcf3ab1091..1e6c7e7f2fe2 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt305x-pinctrl.yaml
> @@ -11,8 +11,7 @@ maintainers:
>    - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>  
>  description:
> -  MediaTek RT305X pin controller for RT3050, RT3052, RT3350, RT3352 and RT5350
> -  SoCs.
> +  MediaTek RT305X pin controller for RT3050, RT3052, and RT3350 SoCs.
>    The pin controller can only set the muxing of pin groups. Muxing individual
>    pins is not supported. There is no pinconf support.
>  
> @@ -36,21 +35,9 @@ patternProperties:
>            function:
>              description:
>                A string containing the name of the function to mux to the group.
> -            anyOf:
> -              - description: For RT3050, RT3052 and RT3350 SoCs
> -                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio,
> -                       pcm gpio, pcm i2s, pcm uartf, rgmii, sdram, spi, uartf,
> -                       uartlite]
> -
> -              - description: For RT3352 SoC
> -                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
> -                       lna, mdio, pa, pcm gpio, pcm i2s, pcm uartf, rgmii, spi,
> -                       spi_cs1, uartf, uartlite, wdg_cs1]
> -
> -              - description: For RT5350 SoC
> -                enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led,
> -                       pcm gpio, pcm i2s, pcm uartf, spi, spi_cs1, uartf,
> -                       uartlite, wdg_cs1]
> +            enum: [gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio,
> +                   pcm gpio, pcm i2s, pcm uartf, rgmii, sdram, spi, uartf,
> +                   uartlite]
>  
>            groups:
>              description:
> @@ -69,17 +56,7 @@ patternProperties:
>              then:
>                properties:
>                  groups:
> -                  anyOf:
> -                    - description: For RT3050, RT3052 and RT3350 SoCs
> -                      enum: [i2c, jtag, mdio, rgmii, sdram, spi, uartf,
> -                             uartlite]
> -
> -                    - description: For RT3352 SoC
> -                      enum: [i2c, jtag, led, lna, mdio, pa, rgmii, spi, spi_cs1,
> -                             uartf, uartlite]
> -
> -                    - description: For RT5350 SoC
> -                      enum: [i2c, jtag, led, spi, spi_cs1, uartf, uartlite]
> +                  enum: [i2c, jtag, mdio, rgmii, sdram, spi, uartf, uartlite]
>  
>            - if:
>                properties:
> @@ -126,24 +103,6 @@ patternProperties:
>                  groups:
>                    enum: [jtag]
>  
> -          - if:
> -              properties:
> -                function:
> -                  const: led
> -            then:
> -              properties:
> -                groups:
> -                  enum: [led]
> -
> -          - if:
> -              properties:
> -                function:
> -                  const: lna
> -            then:
> -              properties:
> -                groups:
> -                  enum: [lna]
> -
>            - if:
>                properties:
>                  function:
> @@ -153,15 +112,6 @@ patternProperties:
>                  groups:
>                    enum: [mdio]
>  
> -          - if:
> -              properties:
> -                function:
> -                  const: pa
> -            then:
> -              properties:
> -                groups:
> -                  enum: [pa]
> -
>            - if:
>                properties:
>                  function:
> @@ -216,15 +166,6 @@ patternProperties:
>                  groups:
>                    enum: [spi]
>  
> -          - if:
> -              properties:
> -                function:
> -                  const: spi_cs1
> -            then:
> -              properties:
> -                groups:
> -                  enum: [spi_cs1]
> -
>            - if:
>                properties:
>                  function:
> @@ -243,15 +184,6 @@ patternProperties:
>                  groups:
>                    enum: [uartlite]
>  
> -          - if:
> -              properties:
> -                function:
> -                  const: wdg_cs1
> -            then:
> -              properties:
> -                groups:
> -                  enum: [spi_cs1]
> -
>          additionalProperties: false
>  
>      additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
> new file mode 100644
> index 000000000000..7a74c1602afc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,rt3352-pinctrl.yaml
> @@ -0,0 +1,247 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/mediatek,rt3352-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek RT3352 Pin Controller
> +
> +maintainers:
> +  - Arınç ÜNAL <arinc.unal@arinc9.com>
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +description:
> +  MediaTek RT3352 pin controller for RT3352 SoC.
> +  The pin controller can only set the muxing of pin groups. Muxing individual
> +  pins is not supported. There is no pinconf support.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,rt3352-pinctrl
> +      - ralink,rt305x-pinctrl
> +      - ralink,rt2880-pinmux

Following Rob's comments, you need to keep old compatibles when
splitting binding.

Best regards,
Krzysztof

