Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC6E73DE8E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjFZMMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjFZML4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:11:56 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1AAE74;
        Mon, 26 Jun 2023 05:11:43 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id ABEF87F98;
        Mon, 26 Jun 2023 20:11:36 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 20:11:36 +0800
Received: from [192.168.125.124] (113.72.146.167) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 20:11:34 +0800
Message-ID: <d7ec3f9a-ae9a-28cb-e511-21463a52b11b@starfivetech.com>
Date:   Mon, 26 Jun 2023 20:11:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 5/5] riscv: dts: starfive: Add JH7110 PWM-DAC support
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230626110909.38718-1-hal.feng@starfivetech.com>
 <20230626110909.38718-6-hal.feng@starfivetech.com>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20230626110909.38718-6-hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.167]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/26 19:09, Hal Feng wrote:
> Add PWM-DAC support for StarFive JH7110 SoC.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Reviewed-by: Walker Chen <walker.chen@starfivetech.com>

> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 50 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 13 +++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 19b5954ee72d..5ca66a65e722 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -36,6 +36,34 @@ gpio-restart {
>  		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
>  		priority = <224>;
>  	};
> +
> +	pwmdac_dit: pwmdac-dit {
> +		compatible = "starfive,jh7110-pwmdac-dit";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "StarFive-PWMDAC-Sound-Card";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		simple-audio-card,dai-link@0 {
> +			reg = <0>;
> +			format = "left_j";
> +			bitclock-master = <&sndcpu0>;
> +			frame-master = <&sndcpu0>;
> +			status = "okay";
> +
> +			sndcpu0: cpu {
> +				sound-dai = <&pwmdac>;
> +			};
> +
> +			codec {
> +				sound-dai = <&pwmdac_dit>;
> +			};
> +		};
> +	};
>  };
>  
>  &dvp_clk {
> @@ -191,6 +219,22 @@ GPOEN_SYS_I2C6_DATA,
>  		};
>  	};
>  
> +	pwmdac_pins: pwmdac-0 {
> +		pwmdac-pins {
> +			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>,
> +				 <GPIOMUX(34, GPOUT_SYS_PWMDAC_RIGHT,
> +					      GPOEN_ENABLE,
> +					      GPI_NONE)>;
> +			bias-disable;
> +			drive-strength = <2>;
> +			input-disable;
> +			input-schmitt-disable;
> +			slew-rate = <0>;
> +		};
> +	};
> +
>  	uart0_pins: uart0-0 {
>  		tx-pins {
>  			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
> @@ -250,6 +294,12 @@ GPOEN_DISABLE,
>  	};
>  };
>  
> +&pwmdac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwmdac_pins>;
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins>;
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index cfda6fb0d91b..bbb3f65e6f80 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -387,6 +387,19 @@ tdm: tdm@10090000 {
>  			status = "disabled";
>  		};
>  
> +		pwmdac: pwmdac@100b0000 {
> +			compatible = "starfive,jh7110-pwmdac";
> +			reg = <0x0 0x100b0000 0x0 0x1000>;
> +			clocks = <&syscrg JH7110_SYSCLK_PWMDAC_APB>,
> +				 <&syscrg JH7110_SYSCLK_PWMDAC_CORE>;
> +			clock-names = "apb", "core";
> +			resets = <&syscrg JH7110_SYSRST_PWMDAC_APB>;
> +			dmas = <&dma 22>;
> +			dma-names = "tx";
> +			#sound-dai-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		stgcrg: clock-controller@10230000 {
>  			compatible = "starfive,jh7110-stgcrg";
>  			reg = <0x0 0x10230000 0x0 0x10000>;
