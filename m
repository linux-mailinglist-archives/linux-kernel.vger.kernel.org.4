Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D8A6CC106
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjC1Ndi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjC1Nda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:33:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38332C646;
        Tue, 28 Mar 2023 06:33:09 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SDWPex089069;
        Tue, 28 Mar 2023 08:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680010345;
        bh=aB8VDVursHBhSRpjTqNMEt7G12Bx19HNcYhCVoNfJmM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=nrhZA0DS35CDRsS1R1eXfZnyzdYejvfCnOnUDIngnHq3SiFen4uOgOad/78uwuj7s
         ghvOb1KQmoPvsF+utPXQ081d0SU41WLd3tKWJOcrbQPOMz660VivPeHcYaOWEOE8Se
         c2PEetdKu1712QOnHn+3jv1JpFol93v5Jkt4N89o=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SDWPiL011196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 08:32:25 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 08:32:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 08:32:25 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SDWPH8126210;
        Tue, 28 Mar 2023 08:32:25 -0500
Date:   Tue, 28 Mar 2023 08:32:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jai Luthra <j-luthra@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v8 3/6] arm64: dts: ti: k3-am625-sk: Enable audio on AM62
 SK
Message-ID: <20230328133225.edi4eynptt5e4oul@headset>
References: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
 <20230313-mcasp_upstream-v8-3-4408134eb2f3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230313-mcasp_upstream-v8-3-4408134eb2f3@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:59-20230328, Jai Luthra wrote:
> Add nodes for audio codec and sound card, enable the audio serializer
> (McASP1) under use from SK-AM62 E2 [1] onwards and update pinmux.
> 
> Keep all audio related nodes in the common dtsi as they are exactly the
> same between SK-AM62 and SK-AM62-LP.
> 
> Link: https://www.ti.com/lit/zip/sprr448 [1]
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts       | 11 ++++
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts         | 11 ++++
>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 77 ++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> index b2ca19e3042e..5ed6b1abe87d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
> @@ -70,6 +70,17 @@ vddshv_sdio: regulator-4 {
>  		states = <1800000 0x0>,
>  			 <3300000 0x1>;
>  	};
> +
> +	vcc_1v8: regulator-5 {
> +		/* output of TPS62824DMQ */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_3v3_sys>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>  };
>  
>  &main_pmx0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> index cdc0858dd1b2..2b861681e548 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> @@ -87,6 +87,17 @@ vdd_sd_dv: regulator-4 {
>  		states = <1800000 0x0>,
>  			 <3300000 0x1>;
>  	};
> +
> +	vcc_1v8: regulator-5 {
> +		/* output of TPS6282518DMQ */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_3v3_sys>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
>  };

If the regulators are common, maybe we should first move the regulators
to common dtsi?

>  
>  &main_pmx0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> index 54318a07d50c..2500cb9ba323 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -81,6 +81,41 @@ led-0 {
>  			default-state = "off";
>  		};
>  	};
> +
> +	tlv320_mclk: clk-0 {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <12288000>;
> +	};
> +
> +	codec_audio: sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "AM62x-SKEVM";
> +		simple-audio-card,widgets =
> +			"Headphone",	"Headphone Jack",
> +			"Line",		"Line In",
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
>  };
>  
>  &main_pmx0 {
> @@ -175,6 +210,15 @@ main_usb1_pins_default: main-usb1-pins-default {
>  			AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18/E16) USB1_DRVVBUS */
>  		>;
>  	};
> +
> +	main_mcasp1_pins_default: main-mcasp1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x090, PIN_INPUT, 2) /* (M24) GPMC0_BE0N_CLE.MCASP1_ACLKX */
> +			AM62X_IOPAD(0x098, PIN_INPUT, 2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX */
> +			AM62X_IOPAD(0x08c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEN.MCASP1_AXR0 */
> +			AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23) GPMC0_ADVN_ALE.MCASP1_AXR2 */
> +		>;
> +	};
>  };
>  
>  &wkup_uart0 {
> @@ -205,6 +249,19 @@ &main_i2c1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_i2c1_pins_default>;
>  	clock-frequency = <400000>;
> +
> +	tlv320aic3106: audio-codec@1b {
> +		#sound-dai-cells = <0>;
> +		compatible = "ti,tlv320aic3106";
> +		reg = <0x1b>;
> +		ai3x-micbias-vg = <1>;	/* 2.0V */
> +
> +		/* Regulators */
> +		AVDD-supply = <&vcc_3v3_sys>;
> +		IOVDD-supply = <&vcc_3v3_sys>;
> +		DRVDD-supply = <&vcc_3v3_sys>;
> +		DVDD-supply = <&vcc_1v8>;
> +	};
>  };
>  
>  &sdhci0 {
> @@ -272,3 +329,23 @@ &usb1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_usb1_pins_default>;
>  };
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
> -- 
> 2.40.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
