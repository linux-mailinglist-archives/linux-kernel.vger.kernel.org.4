Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC0A600082
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJPPOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJPPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:14:10 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF5243608
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:14:04 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id z18so6158002qvn.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DspOqI6hz1WLm7j7CT74yx9oCWpDom4lXqndSWVe65o=;
        b=vKviUKik+NtbN8d+7cD8EEEU0D6LG8XTdYhXVq6aOJezwwYZOYx2EjVdFPII3ADqkI
         aQvkba1pJvH+d5GFuTCb8bazjIRA31ofQ86tX93GSJgqW7dIhzVJHXFs3M4HwqQ1mud1
         Q61yQK0ytFn0rVfuh5E/lNzf9wj+8TpL9zC/nbycqQKMOVBXPmOhNAum6I/M09J/efuJ
         YB7wGp/bU4Oz0oEyYYDyE9tcYZEgBuExiJblVxUhaH/LrgscEOlyL9d9lTMSmzLu5aNU
         FPnwU5Zkkd/ffVO1arPH6eS8PmIC9fFZ1ctudD3QUFIkNxRKP5Zsv/4B4tM9iY7cUqXj
         oVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DspOqI6hz1WLm7j7CT74yx9oCWpDom4lXqndSWVe65o=;
        b=fgXz9PCby+yJpqt0CeTyMQKvyEo0kfNOavOMlphI3AHJsbHDHL6NX83OXR7nvvlkw3
         W5UNlm12LdMnK1Ekvp2CJ/0psZi81zjaUG61pgs++B3omRn6mZ4OpfExMuK4neFr5jGv
         HRIXzk39e6gM5vviVB0was425l6m35IUpum50/Dhm4HmrsfN530sktUIhatixOrmE6nE
         rf/Jwk1kcfmEYU/81bJ1kK1g57J/Ak62YMl7Z1Mdg1khuavmxZ1SB8eNPEvVSppSCVvQ
         NzT9/KOo4hbvMqSqOyKImxmOQQIIAUGDEa3BpCY8mInTAK7oOLp8T7RzJfrtjI0X+DD5
         PYjA==
X-Gm-Message-State: ACrzQf2IC6xSCExBIqIbaAvICRH2BvXvxYTdzdilNUUcUEmzldozWM8W
        1IdNsaYNLz84v189EMfz14eCtg==
X-Google-Smtp-Source: AMsMyM4UTeOjEM4QLiZGPdKafjQN8x9XSIZC4D7aRxQF/zyPAl1f7s/nq7gXSsvhB1qw3J0xSWKOlQ==
X-Received: by 2002:a05:6214:250c:b0:4b1:a1e7:1d89 with SMTP id gf12-20020a056214250c00b004b1a1e71d89mr5378511qvb.1.1665933243673;
        Sun, 16 Oct 2022 08:14:03 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9b13:d679:7b5b:6921? ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id cn4-20020a05622a248400b00304fe5247bfsm6037943qtb.36.2022.10.16.08.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 08:14:02 -0700 (PDT)
Message-ID: <c11f92be-1d86-17e4-e3bb-05e7b17d5fc8@linaro.org>
Date:   Sun, 16 Oct 2022 11:14:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 5/6] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
 <CGME20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833@epcas5p3.samsung.com>
 <20221014102151.108539-6-p.rajanbabu@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014102151.108539-6-p.rajanbabu@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 06:21, Padmanabhan Rajanbabu wrote:
> Add device tree node for I2S0 and I2S1 CPU DAI instances for Tesla
> FSD board
> 
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd-evb.dts      |  8 +++++
>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 14 ++++++++
>  arch/arm64/boot/dts/tesla/fsd.dtsi         | 38 ++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> index 1db6ddf03f01..c0a4509499ab 100644
> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> @@ -41,3 +41,11 @@
>  &ufs {
>  	status = "okay";
>  };
> +
> +&tdm_0 {

Alphabetical order against other label-overrides.

> +	status = "okay";
> +};
> +
> +&tdm_1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> index e3852c946352..ff6f5d4b16dd 100644
> --- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> @@ -339,6 +339,20 @@
>  		samsung,pin-pud = <FSD_PIN_PULL_UP>;
>  		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
>  	};
> +
> +	i2s0_bus: i2s0-bus {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +		samsung,pins = "gpd1-0", "gpd1-1", "gpd1-2", "gpd1-3", "gpd1-4";
> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
> +		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
> +		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
> +	};
> +
> +	i2s1_bus: i2s1-bus {
> +		samsung,pins = "gpd2-0", "gpd2-1", "gpd2-2", "gpd2-3", "gpd2-4";
> +		samsung,pin-function = <FSD_PIN_FUNC_2>;
> +		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
> +		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
> +	};
>  };
>  
>  &pinctrl_pmu {
> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
> index f35bc5a288c2..5decad45a1b6 100644
> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> @@ -32,6 +32,8 @@
>  		spi0 = &spi_0;
>  		spi1 = &spi_1;
>  		spi2 = &spi_2;
> +		tdm0 = &tdm_0;
> +		tdm1 = &tdm_1;

Why?

>  	};
>  
>  	cpus {
> @@ -809,6 +811,42 @@
>  			status = "disabled";
>  		};
>  
> +		tdm_0: tdm@140e0000 {

Node names should be generic, so this looks like i2s.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "samsung,exynos7-i2s";
> +			reg = <0x0 0x140E0000 0x0 0x100>;
> +			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&pdma1 14>, <&pdma1 13>, <&pdma1 12>;
> +			dma-names = "tx", "rx", "tx-sec";
> +			#clock-cells = <1>;
> +			#sound-dai-cells = <1>;
> +			clocks = <&clock_peric PERIC_HCLK_TDM0>,
> +				 <&clock_peric PERIC_HCLK_TDM0>,
> +				 <&clock_peric PERIC_PCLK_TDM0>;
> +			clock-names = "i2s_opclk0", "i2s_opclk1", "iis";

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

Best regards,
Krzysztof

