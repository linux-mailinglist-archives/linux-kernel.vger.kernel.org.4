Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFFC6BF6A8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCQXub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCQXu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:50:29 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09242618B;
        Fri, 17 Mar 2023 16:50:27 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b5so3042981iow.0;
        Fri, 17 Mar 2023 16:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679097026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SM14c4SDFEi27tcVm3RxjN0T8KcC1VspEaUxWM0AoNg=;
        b=BuHxgAxINuWI76QQ6SB8O2xyxYZIRHVqdohjc0ZufdXjEpgzZ+GBAHsgL9XjOSsaNo
         EBGBUd6S2sy38nGqFfW2KPXxzCCxRqtmu5RhIoYSHMGjWf3ElJTKGqruCMKMzXKKtpzT
         5IN7X4TRQ07DEzqLumPpmq5fkWRJNVMC0qgvRdvtKvA2vQXarBXLRUxCL6Kw9UIaaqQa
         05hTVzS5rfBspqwy+H+IsWvOyPlLgo0BFIfG0rHUYVn5ZgGn3CuIbzBipkASQ0Y+fjQ7
         AHBn0+K47sBP5iKEp/Ldkww1FPu9RYqSsThpYN6Yka78ZbWyv9ytuP/FR7FcoSG6USt3
         UzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679097026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SM14c4SDFEi27tcVm3RxjN0T8KcC1VspEaUxWM0AoNg=;
        b=mwKpytxZ+PQQOYlTy3k1UHxRpk8rTftMAzdcRyOetPBTOg/ngLJvNYvAbXpVKP4mrf
         MGr3cgmRuOpDiXXgjq4pASel2Q4+cJHsgGz8T0r6AvWFp13NV0LMcSy3hzw45sPxacIg
         3uhzWZfHiTctgpD9xOpirfsRzEbKQ+B5sC9CWqEKxLypcCeJTAXyrdr5oiu+6VNB5wJd
         t1iRd5iaioc05oGD6mVdw66Quohr8fDR3UAZ3wAOBu3aAwVEcsSXQgynBkbdpMj+dmXl
         YANKrpMD+/0wSuuGdjBhMDAjBevRBwqMtDkugmizF1dUaj7oFMJN6rpWjN015MBNU25g
         2e8g==
X-Gm-Message-State: AO0yUKXfBG5f6LI78997iciDE300CM3nfgEhdAX5GHim+gE/EmC6DYzC
        D4C9kIZeNCcl84qeXx7ysoc=
X-Google-Smtp-Source: AK7set9GtSEJgse0DOJM1F79+7e2yvPGn4Ne+i+4mN5GJ7pxVhU35LcNW0ARL8Sn772qrJfk6PXvwg==
X-Received: by 2002:a6b:f307:0:b0:752:fd8e:5ee4 with SMTP id m7-20020a6bf307000000b00752fd8e5ee4mr306507ioh.1.1679097026384;
        Fri, 17 Mar 2023 16:50:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p15-20020a056638216f00b00403089c2a1dsm1111309jak.108.2023.03.17.16.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 16:50:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bd434625-8789-e169-3a4a-4952e5e8fde2@roeck-us.net>
Date:   Fri, 17 Mar 2023 16:50:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: watchdog: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Julius Werner <jwerner@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230317233643.3969019-1-robh@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230317233643.3969019-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 16:36, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml   | 2 +-
>   Documentation/devicetree/bindings/watchdog/apple,wdt.yaml       | 2 +-
>   Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml     | 2 +-
>   .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml         | 2 +-
>   .../devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml          | 2 +-
>   .../devicetree/bindings/watchdog/faraday,ftwdt010.yaml          | 2 +-
>   Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml | 2 +-
>   Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml   | 2 +-
>   Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml     | 2 +-
>   Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml     | 2 +-
>   .../devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml    | 2 +-
>   Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml   | 2 +-
>   Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml      | 2 +-
>   13 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> index 026c2e5e77aa..274519fc24fd 100644
> --- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Allwinner A10 Watchdog
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>   maintainers:
>     - Chen-Yu Tsai <wens@csie.org>
> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> index e58c56a6fdf6..20435a77e079 100644
> --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Apple SoC Watchdog
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>   maintainers:
>     - Sven Peter <sven@svenpeter.dev>
> diff --git a/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> index e3a1d79574e2..fa05d6252982 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: ARM Secure Monitor Call based watchdog
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>   maintainers:
>     - Julius Werner <jwerner@chromium.org>
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> index a9635c03761c..b28f7b57c36b 100644
> --- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> @@ -10,7 +10,7 @@ maintainers:
>     - Eugen Hristev <eugen.hristev@microchip.com>
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml
> index a926809352b8..428004e7f0c3 100644
> --- a/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: BCM63xx and BCM7038 watchdog timer
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>   maintainers:
>     - Florian Fainelli <f.fainelli@gmail.com>
> diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> index 6ecd429f76b5..6e135f48b3ba 100644
> --- a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> @@ -15,7 +15,7 @@ description: |
>     SoCs and others.
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> index 8562978aa0c8..d3790f1a96a2 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> @@ -10,7 +10,7 @@ maintainers:
>     - Anson Huang <Anson.Huang@nxp.com>
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> index 38079e1b6a44..1a6490c43d89 100644
> --- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Maxim 63xx Watchdog Timers
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>     - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
>   
>   maintainers:
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> index e2c9bf1aec38..50c5c48ee6fb 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> @@ -115,7 +115,7 @@ required:
>     - clocks
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>     - if:
>         not:
> diff --git a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> index 92df6e453f64..9387e4caa0fd 100644
> --- a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Synopsys Designware Watchdog Timer
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>   maintainers:
>     - Jamie Iles <jamie@jamieiles.com>
> diff --git a/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
> index 70c005fdd197..ba0709314360 100644
> --- a/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
> @@ -10,7 +10,7 @@ maintainers:
>     - Keiji Hayashibara <hayashibara.keiji@socionext.com>
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml
> index a8e266f80c20..2cb1a2ed0f7b 100644
> --- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml
> @@ -11,7 +11,7 @@ maintainers:
>     - Christophe Roullier <christophe.roullier@foss.st.com>
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> index 2f33635876ff..fc553211e42d 100644
> --- a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> @@ -18,7 +18,7 @@ description:
>     to directly reset the SoC.
>   
>   allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>   
>   properties:
>     compatible:

