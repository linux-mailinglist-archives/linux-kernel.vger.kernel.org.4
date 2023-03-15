Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505216BA63B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCOEcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCOEcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:32:43 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD55C5B81;
        Tue, 14 Mar 2023 21:32:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F4WTgc070653;
        Tue, 14 Mar 2023 23:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678854749;
        bh=7nZUFMVyqD2/KV+57P2UE4gMyx692dI3QnbfGkYg4CU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fbOKG/LiP7s02IvI0CDZ8b9D1BUdQGx/evTJ/uUCvDQmWWaE9iX5CfEoy2KBI9LhR
         gfUzGnhVz1/S894EaR/72x0QTBmdSTJ4iN+Y0Ymkajj3tebzXpyJRND48eFBMwIx0J
         dN/ZGgTPsVT1FGYyy0lzQJ2lESgyX3sUb2LWpZuw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F4WTHV035595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 23:32:29 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 23:32:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 23:32:29 -0500
Received: from [172.24.145.215] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F4WPUK062856;
        Tue, 14 Mar 2023 23:32:25 -0500
Message-ID: <dbc03a80-a1d2-1458-a0b8-f3038db3caf3@ti.com>
Date:   Wed, 15 Mar 2023 10:02:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 6/6] arm64: dts: ti: k3-am62a7-sk: Enable audio on
 AM62A
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
 <20230313-mcasp_upstream-v5-6-d6844707aa8a@ti.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v5-6-d6844707aa8a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/03/23 20:19, Jai Luthra wrote:
> Add nodes for audio codec and sound card, enable the audio serializer
> (McASP1) under use and update pinmux.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 77 +++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index 063e69e45163..1775ed154aff 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -122,6 +122,41 @@ led-0 {
>   			default-state = "off";
>   		};
>   	};
> +
> +	tlv320_mclk: clk-0 {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <12288000>;
> +	};
> +
> +	codec_audio: sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "AM62Ax-SKEVM";
> +		simple-audio-card,widgets =
> +			"Headphone",	"Headphone Jack",
> +			"Line",	"Line In",
> +			"Microphone",	"Microphone Jack";
> +		simple-audio-card,routing =
> +			"Headphone Jack",	"HPLOUT",
> +			"Headphone Jack",	"HPROUT",
> +			"LINE1L",		"Line In",
> +			"LINE1R",		"Line In",
> +			"MIC3R",		"Microphone Jack",
> +			"Microphone Jack",	"Mic Bias";
> +		simple-audio-card,format = "dsp_b";
> +		simple-audio-card,bitclock-master = <&sound_master>;
> +		simple-audio-card,frame-master = <&sound_master>;
> +		simple-audio-card,bitclock-inversion;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&mcasp1>;
> +		};
> +
> +		sound_master: simple-audio-card,codec {
> +			sound-dai = <&tlv320aic3106>;
> +			clocks = <&tlv320_mclk>;
> +		};
> +	};
>   };
>   
>   &main_pmx0 {
> @@ -200,6 +235,15 @@ AM62AX_IOPAD(0x130, PIN_INPUT, 0) /* (AB17) RGMII1_TXC */
>   			AM62AX_IOPAD(0x12c, PIN_INPUT, 0) /* (W16) RGMII1_TX_CTL */
>   		>;
>   	};
> +
> +	main_mcasp1_pins_default: main-mcasp1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62AX_IOPAD(0x090, PIN_INPUT, 2) /* (L19) GPMC0_BE0n_CLE.MCASP1_ACLKX */
> +			AM62AX_IOPAD(0x098, PIN_INPUT, 2) /* (R18) GPMC0_WAIT0.MCASP1_AFSX */
> +			AM62AX_IOPAD(0x08c, PIN_OUTPUT, 2) /* (K19) GPMC0_WEn.MCASP1_AXR0 */
> +			AM62AX_IOPAD(0x084, PIN_INPUT, 2) /* (L18) GPMC0_ADVn_ALE.MCASP1_AXR2 */
> +		>;
> +	};
>   };
>   
>   &main_i2c0 {
> @@ -234,6 +278,19 @@ exp1: gpio@22 {
>   				   "MCASP1_FET_SEL", "UART1_FET_SEL",
>   				   "PD_I2C_IRQ", "IO_EXP_TEST_LED";
>   	};
> +
> +	tlv320aic3106: audio-codec@1b {
> +		#sound-dai-cells = <0>;
> +		compatible = "ti,tlv320aic3106";
> +		reg = <0x1b>;
> +		ai3x-micbias-vg = <1>;		/* 2.0V */
> +		status = "okay";

No need for status property here I guess????

> +
> +		/* Regulators */
> +		AVDD-supply = <&vcc_3v3_sys>;
> +		IOVDD-supply = <&vcc_3v3_sys>;
> +		DRVDD-supply = <&vcc_3v3_sys>;

DVDD 1.8V supply here looks missing???

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

> +	};
>   };
>   
>   &sdhci1 {
> @@ -302,3 +359,23 @@ cpsw3g_phy0: ethernet-phy@0 {
>   		ti,min-output-impedance;
>   	};
>   };
> +
> +&mcasp1 {
> +	status = "okay";
> +	#sound-dai-cells = <0>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcasp1_pins_default>;
> +
> +	op-mode = <0>;          /* MCASP_IIS_MODE */
> +	tdm-slots = <2>;
> +
> +	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
> +	       1 0 2 0
> +	       0 0 0 0
> +	       0 0 0 0
> +	       0 0 0 0
> +	>;
> +	tx-num-evt = <32>;
> +	rx-num-evt = <32>;
> +};
> 
