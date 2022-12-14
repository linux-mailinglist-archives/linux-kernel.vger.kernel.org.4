Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5FB64C879
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiLNLz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiLNLzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:55:25 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB3919C3B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:55:24 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so10040514lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPBqPNWuQqd8iPzh14Et+rK9vcZ1LSXVV8dYdeOHZ6c=;
        b=d9Opn6CX+6jaux+E3iVm2NyBgLI8PREjwy5MeY1Lrro99hlHyyMusWfNulvNGBmlT+
         sWGQZ8OgTIhBrmsKlFqcXkwlkcrtloR7cpiU8rWGJJXCR60EMB+ZWdogtIDrWTIoU08A
         kvlc23GJjhTezCWJOd8SAR0kl60znuGEnDz+GE2J+2TbHR2xW2/UVpC25uSeLT6QkS9e
         05VuKn+ani6pbjqRZC4uomXn8MA10l49E8Vsxi8w64EubWJyHX63wzGr3xKLbrtW8pec
         yWihcri1LwJFp2Ct6weofdnrfX95O39+t5SsoM899CKrAstmzP2KIvFoFEPW1SligMk1
         110g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPBqPNWuQqd8iPzh14Et+rK9vcZ1LSXVV8dYdeOHZ6c=;
        b=CBol4vKJ6I5+W6vnsjsoVrbX09LMiIKrZWwlXZBzlPJZ75hoEFHkLP9Uo9+wUX0Umc
         nRTOymZ5idPrP8JSAJYTc2wfjErbMhFnU+cAeg6swNphHVOJ3zYugA8RW4ASxy/Yuj2O
         PQxse2m6r454p2JPE7OfPlNl0ixYsJcQ+fUzeQEbQaojbKerEo+dFiR8vXZ7pCeUDblU
         R7QNXt2ZaFBeK0NMzh7NDMIN5MSp/bc97jMk1OZV/wsz8Kd+F7fMS3GvOjdbQFl+ZpQh
         OY++7b1HXAi4SjAmH05uNxyyJd7FD+f9h/ZBVu2fk9mrCqSgnoDNLYmEQR0wgHW4FSBE
         TE+Q==
X-Gm-Message-State: ANoB5pltfZGvuqPmYI0927XZUOJxpqC1buqNMF/9Dz0RxzCmG+pnhwHv
        Kae/H+19EhydgONAmSMsaNl6ew==
X-Google-Smtp-Source: AA0mqf77t8fHCzNIhykIbYiHIQrxYCkQ2IPp64vlW2pWDRXhqprSlUO5qUJL1uv9aHCthTDOMZGKsw==
X-Received: by 2002:a05:6512:acd:b0:4b6:f0ac:7af8 with SMTP id n13-20020a0565120acd00b004b6f0ac7af8mr3783419lfu.67.1671018922448;
        Wed, 14 Dec 2022 03:55:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24e90000000b004b551cdfe13sm771276lfr.279.2022.12.14.03.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 03:55:22 -0800 (PST)
Message-ID: <4ffd94b2-e72c-a081-4326-5bc254603ddf@linaro.org>
Date:   Wed, 14 Dec 2022 12:55:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/6] dt-bindings: pinctrl: mt7620: add proper function
 muxing binding
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20221213130430.172876-1-arinc.unal@arinc9.com>
 <20221213130430.172876-3-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213130430.172876-3-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2022 14:04, Arınç ÜNAL wrote:
> Not every function can be muxed to a group. Add proper binding which
> documents which function can be muxed to a group or set of groups.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/ralink,mt7620-pinctrl.yaml        | 632 +++++++++++++++++-
>  1 file changed, 596 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> index 6f17f3991640..06880c80ba80 100644
> --- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> @@ -29,47 +29,608 @@ patternProperties:
>          $ref: pinmux-node.yaml#
>  
>          properties:
> -          groups:
> -            description: The pin group to select.
> -            enum: [
> -              # common
> -              i2c, spi, wdt,
> -
> -              # For MT7620 SoC
> -              ephy, mdio, nd_sd, pa, pcie, rgmii1, rgmii2, spi refclk,
> -              uartf, uartlite, wled,
> -
> -              # For MT7628 and MT7688 SoCs
> -              gpio, i2s, p0led_an, p0led_kn, p1led_an, p1led_kn, p2led_an,
> -              p2led_kn, p3led_an, p3led_kn, p4led_an, p4led_kn, perst, pwm0,
> -              pwm1, refclk, sdmode, spi cs1, spis, uart0, uart1, uart2,
> -              wled_an, wled_kn,
> -            ]
> -
>            function:
> -            description: The mux function to select.
> -            enum: [
> -              # common
> -              gpio, i2c, refclk, spi,
> -
> -              # For MT7620 SoC
> -              ephy, gpio i2s, gpio uartf, i2s uartf, mdio, nand, pa,
> -              pcie refclk, pcie rst, pcm gpio, pcm i2s, pcm uartf,
> -              rgmii1, rgmii2, sd, spi refclk, uartf, uartlite, wdt refclk,
> -              wdt rst, wled,
> -
> -              # For MT7628 and MT7688 SoCs
> -              antenna, debug, i2s, jtag, p0led_an, p0led_kn,
> -              p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
> -              p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1, pwm_uart2,
> -              rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7, spi cs1,
> -              spis, sw_r, uart0, uart1, uart2, utif, wdt, wled_an, wled_kn, -,
> -            ]
> +            description:
> +              A string containing the name of the function to mux to the group.
> +            anyOf:
> +              - description: For MT7620 SoC
> +                enum: [ephy, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, mdio, nand, pa,
> +                       pcie refclk, pcie rst, pcm gpio, pcm i2s, pcm uartf, refclk,
> +                       rgmii1, rgmii2, sd, spi, spi refclk, uartf, uartlite, wdt refclk,
> +                       wdt rst, wled]
> +
> +              - description: For MT7628 and MT7688 SoCs
> +                enum: [antenna, debug, gpio, i2c, i2s, jtag, p0led_an, p0led_kn,
> +                       p1led_an, p1led_kn, p2led_an, p2led_kn, p3led_an, p3led_kn,
> +                       p4led_an, p4led_kn, pcie, pcm, perst, pwm, pwm0, pwm1, pwm_uart2,
> +                       refclk, rsvd, sdxc, sdxc d5 d4, sdxc d6, sdxc d7, spi, spi cs1,
> +                       spis, sw_r, uart0, uart1, uart2, utif, wdt, wled_an, wled_kn, -]
> +
> +          groups:
> +            description:
> +              An array of strings. Each string contains the name of a group.
>  
>          required:
>            - groups
>            - function
>  
> +        allOf:
> +          - if:
> +              properties:
> +                function:
> +                  const: antenna
> +            then:
> +              properties:
> +                groups:
> +                  enum: [i2s]

I have doubts such setup is maintainable and readable. I would suggest
to leave just few - maybe for gpio, jtag, refclk, utif.


Best regards,
Krzysztof

