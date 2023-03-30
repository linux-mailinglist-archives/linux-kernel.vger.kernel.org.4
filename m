Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27D56CFD24
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjC3HnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC3HnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:43:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C79B5B92
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:43:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c9so12956058lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680162191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zuZ7AJ+urGiuWJ6O4WJPaOH0rhv1jf2+srORpX4K/Y=;
        b=VFgq8bbjUfROWOqUvRrcNQlzsT4ilwA91/7+wugNbVngG3akeaii4iHP53uBR9EcLb
         Hh56rV0B0S9udnu6ZDFMczEtvJXVwy0onkcaLV5VbrsiDczd+riGAa8hTNBIPANFl92X
         3KzX4vKfh+vEAbz7AfUKCOkajNPVmK9Hr/VxMWHu+SqKYhEzfTlNxDFYUzvScP54achN
         IXaGIQvolcSN1bSUu7gesQ1e4W5+12gSoKlzJFBqLYPgtQ1xsUh16R8S2P1s/PIpgdCs
         LXmljO/YjAyEbuJd3r5mLoku2RelpvshyDOkadbLy24PUTfm4fslCCv4E82JyiZiaYC/
         dMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zuZ7AJ+urGiuWJ6O4WJPaOH0rhv1jf2+srORpX4K/Y=;
        b=nlrs2u2qSQzv8Qra7eenkb5PA5icffNrFXRlz2IdpBY05DQeT96Jmn5ycyC2l6l9dN
         DSJSs7WOLXSaj7AI7VL34gJg5KKzZ96UkcLu1QROUN3zEPm+RePM3dQZVWNH39epTbIC
         N6k3j5hiQ2+NIx4VwN6/3YMMqYfFeKKDva2yQ9VW1f2t/RV058R6ffKL2djEftHmcI3G
         YCYhWmGig+KZ+B4MJx/bOnL/QbNvTgg8QNdvg4EU7AP30SoK0P6FbCCmrJJIaEHaYvF8
         3cDEEYW1pxVCyyyw9MvH94TDv56se5ILkYmQC0KW/4UpVdYVU+YAQzC+hweTOr6OOZY6
         ltWA==
X-Gm-Message-State: AAQBX9fk8E8U6ITxjiHB7KNX2MvjhT/8lVRFMAg/ZeDgHA0LGrg4AxhB
        m/HZWKmT0WbAccaYwzB+kqKWXg==
X-Google-Smtp-Source: AKy350ZsAuQmcXRHoK+KQymYwvc+9+fujqTKeBRI50gKJ8CU7idfpzKcaaZoWyt6UOY23zghCl9J5g==
X-Received: by 2002:a19:ad44:0:b0:4db:38ba:ca61 with SMTP id s4-20020a19ad44000000b004db38baca61mr6228770lfd.53.1680162191597;
        Thu, 30 Mar 2023 00:43:11 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f16-20020ac25330000000b004e844eeb555sm5801328lfh.214.2023.03.30.00.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:43:11 -0700 (PDT)
Message-ID: <d455a90a-7e63-2254-75cb-70cb26ae7483@linaro.org>
Date:   Thu, 30 Mar 2023 09:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: add tdm node and sound card
Content-Language: en-US
To:     Walker Chen <walker.chen@starfivetech.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230329153320.31390-1-walker.chen@starfivetech.com>
 <20230329153320.31390-4-walker.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230329153320.31390-4-walker.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 17:33, Walker Chen wrote:
> Add the tdm controller node and sound card for the StarFive JH7110 SoC.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 87 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 34 ++++++++
>  2 files changed, 121 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 1155b97b593d..35137c2edf5d 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -62,6 +62,10 @@
>  	clock-frequency = <297000000>;
>  };
>  
> +&wm8960_mclk {
> +	clock-frequency = <24576000>;
> +};
> +
>  &i2srx_bclk_ext {
>  	clock-frequency = <12288000>;
>  };
> @@ -102,6 +106,14 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0_pins>;
>  	status = "okay";
> +
> +	wm8960: codec@1a {
> +		compatible = "wlf,wm8960";
> +		reg = <0x1a>;
> +		#sound-dai-cells = <0>;
> +
> +		wlf,shared-lrclk;
> +	};
>  };
>  
>  &i2c2 {
> @@ -214,6 +226,40 @@
>  			slew-rate = <0>;
>  		};
>  	};
> +
> +	tdm0_pins: tdm0-pins {
> +		tdm0-pins-tx {
> +			pinmux = <GPIOMUX(44, GPOUT_SYS_TDM_TXD,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-pull-up;
> +			drive-strength = <2>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +
> +		tdm0-pins-rx {
> +			pinmux = <GPIOMUX(61, GPOUT_HIGH,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_TDM_RXD)>;
> +			input-enable;
> +		};
> +
> +		tdm0-pins-sync {
> +			pinmux = <GPIOMUX(63, GPOUT_HIGH,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_TDM_SYNC)>;
> +			input-enable;
> +		};
> +
> +		tdm0-pins-pcmclk {
> +			pinmux = <GPIOMUX(38, GPOUT_HIGH,
> +					      GPOEN_DISABLE,
> +					      GPI_SYS_TDM_CLK)>;
> +			input-enable;
> +		};
> +	};
>  };
>  
>  &uart0 {
> @@ -221,3 +267,44 @@
>  	pinctrl-0 = <&uart0_pins>;
>  	status = "okay";
>  };
> +
> +&tdm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&tdm0_pins>;
> +	status = "okay";
> +};
> +
> +&sound0 {
> +	simple-audio-card,dai-link@0 {
> +		reg = <0>;
> +		status = "okay";

Why? Drop.

> +		format = "dsp_a";
> +		bitclock-master = <&dailink_master>;
> +		frame-master = <&dailink_master>;
> +
> +		widgets =

Drop line break.

> +				"Microphone", "Mic Jack",
> +				"Line", "Line In",
> +				"Line", "Line Out",
> +				"Speaker", "Speaker",
> +				"Headphone", "Headphone Jack";
> +		routing =

Drop unnecessary line break.

> +				"Headphone Jack", "HP_L",
> +				"Headphone Jack", "HP_R",
> +				"Speaker", "SPK_LP",
> +				"Speaker", "SPK_LN",
> +				"LINPUT1", "Mic Jack",
> +				"LINPUT3", "Mic Jack",
> +				"RINPUT1", "Mic Jack",
> +				"RINPUT2", "Mic Jack";
> +		cpu {
> +			sound-dai = <&tdm>;
> +		};
> +
> +		dailink_master:codec {

Missing space after label:.

> +			sound-dai = <&wm8960>;
> +			clocks = <&wm8960_mclk>;
> +			clock-names = "mclk";
> +		};
> +	};
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index b503b6137743..a89158d1d7a6 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -210,6 +210,12 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	wm8960_mclk: wm8960_mclk {

No underscores in node names. Use consistent naming - do you see here
any nodes named "mclk"?

Anyway this is some fake clock. Real clock should come out from wm8960.

> +		compatible = "fixed-clock";
> +		clock-output-names = "wm8960_mclk";
> +		#clock-cells = <0>;
> +	};
> +
>  	i2srx_bclk_ext: i2srx-bclk-ext-clock {
>  		compatible = "fixed-clock";
>  		clock-output-names = "i2srx_bclk_ext";
> @@ -375,6 +381,27 @@
>  			status = "disabled";
>  		};
>  
> +		tdm: tdm@10090000 {
> +			compatible = "starfive,jh7110-tdm";
> +			reg = <0x0 0x10090000 0x0 0x1000>;
> +			clocks = <&syscrg JH7110_SYSCLK_TDM_AHB>,
> +				 <&syscrg JH7110_SYSCLK_TDM_APB>,
> +				 <&syscrg JH7110_SYSCLK_TDM_INTERNAL>,
> +				 <&syscrg JH7110_SYSCLK_TDM_TDM>,
> +				 <&syscrg JH7110_SYSCLK_MCLK_INNER>,
> +				 <&tdm_ext>;
> +			clock-names = "tdm_ahb", "tdm_apb",
> +				      "tdm_internal", "tdm",
> +				      "mclk_inner", "tdm_ext";
> +			resets = <&syscrg JH7110_SYSRST_TDM_AHB>,
> +				 <&syscrg JH7110_SYSRST_TDM_APB>,
> +				 <&syscrg JH7110_SYSRST_TDM_CORE>;
> +			dmas = <&dma 20>, <&dma 21>;
> +			dma-names = "rx","tx";
> +			#sound-dai-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		stgcrg: clock-controller@10230000 {
>  			compatible = "starfive,jh7110-stgcrg";
>  			reg = <0x0 0x10230000 0x0 0x10000>;
> @@ -601,5 +628,12 @@
>  			#reset-cells = <1>;
>  			power-domains = <&pwrc JH7110_PD_VOUT>;
>  		};
> +
> +		sound0: snd-card0 {

1. Why card0?
2. Where is this node located? In MMIO bus? Run some basic checks on
your DTS before submitting upstream.
dtbs_check
dtbs W=1

3. Why this is even in the DTSI? This really looks wrong.

> +			compatible = "simple-audio-card";
> +			simple-audio-card,name = "Starfive-TDM-Sound-Card";
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Best regards,
Krzysztof

