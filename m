Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED97D6BFF71
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 06:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCSFn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 01:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCSFn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 01:43:56 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6E186AD;
        Sat, 18 Mar 2023 22:43:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id AD8FF426FC;
        Sun, 19 Mar 2023 05:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1679204630; bh=84MOaiyVp1I295Lym01yKlMptuceSpHgF0iohhd12CQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HyZ7B58EnY35cal+hIqu11M/hPwZh9NCy90YPkREhETJ291Y52e5qk0l8fjJfEahl
         5qetA9I4LA44I5W1vCmrIlqr8C8nrDkgLiWCgpSpcPAN6EV1G7LR/Uixq5zciYbF2I
         RQU+zXG26yJDVdW4Fe6b/s5hBew8aebAbEKdUzgYHR17SQf734odA0IzcIbgnCfnu8
         dHN61hpnCYJQEChAiTC3eTpK53XKemwuOMhgd2vVGpiH9sN+Kwk883oWLIWYShqd5d
         AbbndVd2zlEs/cV6WEG99rRE3COgVNHCZaqm8g1/AOywrcSmR7UrU/1hSFbbLzZk8W
         fK7XZ4+jcSl/w==
Message-ID: <fca00ce8-3b56-9641-9eb9-f25382f29675@marcan.st>
Date:   Sun, 19 Mar 2023 14:43:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: watchdog: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
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
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230317233643.3969019-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2023 08.36, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml   | 2 +-
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml       | 2 +-
>  Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml     | 2 +-
>  .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml         | 2 +-
>  .../devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml          | 2 +-
>  .../devicetree/bindings/watchdog/faraday,ftwdt010.yaml          | 2 +-
>  Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml | 2 +-
>  Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml   | 2 +-
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml     | 2 +-
>  Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml     | 2 +-
>  .../devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml    | 2 +-
>  Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml   | 2 +-
>  Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml      | 2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)

For apple:

Acked-by: Hector Martin <marcan@marcan.st>

> 
> diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> index 026c2e5e77aa..274519fc24fd 100644
> --- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Allwinner A10 Watchdog
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>  maintainers:
>    - Chen-Yu Tsai <wens@csie.org>
> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> index e58c56a6fdf6..20435a77e079 100644
> --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Apple SoC Watchdog
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>  maintainers:
>    - Sven Peter <sven@svenpeter.dev>
> diff --git a/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> index e3a1d79574e2..fa05d6252982 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ARM Secure Monitor Call based watchdog
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>  maintainers:
>    - Julius Werner <jwerner@chromium.org>
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> index a9635c03761c..b28f7b57c36b 100644
> --- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Eugen Hristev <eugen.hristev@microchip.com>
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml
> index a926809352b8..428004e7f0c3 100644
> --- a/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: BCM63xx and BCM7038 watchdog timer
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>  maintainers:
>    - Florian Fainelli <f.fainelli@gmail.com>
> diff --git a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> index 6ecd429f76b5..6e135f48b3ba 100644
> --- a/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/faraday,ftwdt010.yaml
> @@ -15,7 +15,7 @@ description: |
>    SoCs and others.
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> index 8562978aa0c8..d3790f1a96a2 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Anson Huang <Anson.Huang@nxp.com>
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> index 38079e1b6a44..1a6490c43d89 100644
> --- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Maxim 63xx Watchdog Timers
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>    - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
>  
>  maintainers:
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> index e2c9bf1aec38..50c5c48ee6fb 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
> @@ -115,7 +115,7 @@ required:
>    - clocks
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>    - if:
>        not:
> diff --git a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> index 92df6e453f64..9387e4caa0fd 100644
> --- a/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Synopsys Designware Watchdog Timer
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>  maintainers:
>    - Jamie Iles <jamie@jamieiles.com>
> diff --git a/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
> index 70c005fdd197..ba0709314360 100644
> --- a/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Keiji Hayashibara <hayashibara.keiji@socionext.com>
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml
> index a8e266f80c20..2cb1a2ed0f7b 100644
> --- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml
> @@ -11,7 +11,7 @@ maintainers:
>    - Christophe Roullier <christophe.roullier@foss.st.com>
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> index 2f33635876ff..fc553211e42d 100644
> --- a/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml
> @@ -18,7 +18,7 @@ description:
>    to directly reset the SoC.
>  
>  allOf:
> -  - $ref: "watchdog.yaml#"
> +  - $ref: watchdog.yaml#
>  
>  properties:
>    compatible:


- Hector
