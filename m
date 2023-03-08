Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D176B07DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCHNDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjCHNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:02:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CC7C2D88
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:00:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g3so65488003eda.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 05:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ff6ZYtge2XSaRFAxXPbBZN5DiMrvN5/dtH5AyaKgyL8=;
        b=n3ypomq0r4xqKWRNX37+zo1ENCoOWwDYXqUBlIpMF95kNEgV5ea5K7rKURWd2Wxzea
         u/bT1Ddu2qzrfZRXOhEVcm9zbFKD5Y/B5+r0PDGMs3yOkrzRc+KOufeiR5K8t+5jZCpz
         NUd5NuVD2WJImgy8L77gdcHjXBPZK/jAgKU9Y1Tovu4+ycz7Fff/ZAxrnPCrnYkR37et
         N35o/AKiMNSFMDdFBqHa79cfHjd0tHqDnKSIJajqoJEkwcgOiU9DbhOARZqvJYg+m/4/
         vi/yMrK0e5i3OubETIKPpThdOjjBHIBPMGc1Skk0HFHzZYMjrOgdlNO4IsSmWjA9zp9z
         I5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ff6ZYtge2XSaRFAxXPbBZN5DiMrvN5/dtH5AyaKgyL8=;
        b=qCMYgomYnIJ3UZsAat4HGy5IAqwwkXiv2ozgBpN1DX8Slc5EBqf80Od67AOiG4zMV3
         JqnPes9ZZTp6RVrwMYwQ2bApqbj4Ko4RhS8Xg/bp41WHGC6zDWpgmI/sHU7O/nzqKAbY
         nPDu7R8AoRVfMD3rPVlMviAjG2QzQtb63LEuU8nwt/bxLSvQCT3cj9OND/WJDQ/eJXeZ
         x+R8MsHAQiaJMNx9TqVJ64Mz3yg/IYTLoFQ1g+11mgwvr0eVZ+qpQ3X0VIVRZY2VyKRF
         ELrL7c+x3+aVfWU6DfetC0RnHEU6ayRCXImHNYXU96SMwahqwknjxMFV1akZjcCkhIds
         CTww==
X-Gm-Message-State: AO0yUKXcnw6k2Vb+qZeOFYQu+xwlpo4Ll2P/JKMpbebvw6bol4JfJqTp
        gpvwPkPraFa80WImWLIQ+aO+Yg==
X-Google-Smtp-Source: AK7set8ncW9Caj0o7EnqUzZQ3dpNtV2DGIwI/JnF+q/w4c5/fCdS1O4brp1e4xfOszekwmHMTnVpQg==
X-Received: by 2002:a17:906:348b:b0:8ef:3e41:e719 with SMTP id g11-20020a170906348b00b008ef3e41e719mr18057235ejb.63.1678280428709;
        Wed, 08 Mar 2023 05:00:28 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id i18-20020a50d752000000b004accf3a63cbsm8092336edj.68.2023.03.08.05.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 05:00:28 -0800 (PST)
Message-ID: <07e64710-6b91-9da6-f483-03706b7ea95a@linaro.org>
Date:   Wed, 8 Mar 2023 14:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 17/25] arm64: dts: colibri-imx8x: eval: Add spi-to-can
Content-Language: en-US
To:     Philippe Schenker <dev@pschenker.ch>, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
References: <20230308125300.58244-1-dev@pschenker.ch>
 <20230308125300.58244-18-dev@pschenker.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308125300.58244-18-dev@pschenker.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 13:52, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Add mcp2515 spi-to-can to &lpspi2.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
>  .../dts/freescale/imx8x-colibri-eval-v3.dtsi  | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
> index 625d2caaf5d1..e7e3cf462408 100644
> --- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi

There is no such file.

> @@ -11,6 +11,13 @@ aliases {
>  		rtc1 = &rtc;
>  	};
>  
> +	/* fixed crystal dedicated to mcp25xx */
> +	clk16m: clock-16mhz-fixed {

Drop "fixed".

> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <16000000>;
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  		pinctrl-names = "default";
> @@ -44,6 +51,18 @@ rtc_i2c: rtc@68 {
>  /* Colibri SPI */
>  &lpspi2 {
>  	status = "okay";
> +
> +	mcp2515: can@0 {
> +		compatible = "microchip,mcp2515";
> +		reg = <0>;
> +		interrupt-parent = <&lsio_gpio3>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		pinctrl-0 = <&pinctrl_can_int>;
> +		pinctrl-names = "default";
> +		clocks = <&clk16m>;

You just sorted all nodes in previous patches and add something
unsorted? What is then the style of order? Random name?

> +		spi-max-frequency = <10000000>;
> +		status = "okay";

Why do you need it?

> +	};
>  };
>  
>  /* Colibri UART_B */

Best regards,
Krzysztof

