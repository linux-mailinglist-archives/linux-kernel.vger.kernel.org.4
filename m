Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0381F6E7466
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjDSHwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjDSHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:51:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E94D118EA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:51:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-507bdc5ca2aso455804a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681890660; x=1684482660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KTFJRBbngRhZPhykIp7UPAX69ViWolw+6lsvVy+TTo=;
        b=yz8Mw058s8y146q4UzQQG+Iye1sY9VnaDs+54exDjugwZnpLY5wfeQW6kqfqNlhnl8
         A906oLwwJCS4cMVVZ9L40SPOExkE93MvrYUcd8hUy/dtOdwpFJrVYkXxrx2zcWmOyhyw
         i6tU9cTjn8Y9E2YoFVfXnSOfG3+ta/vXWg0GumKs8v+VMuijQChbtyjAAwGWnKyJq3MF
         nvaGmLSFNQ5oipiIl9WTdxcbPWwrP3IHxs2CvM0mrGhBrhInUavlJeseRgolz3adiKAr
         Tyj26sGvwlL9t0D/TXPpfvUIMzWSwDkGJodMvVeqcahttd7qOCI5VTJnXXdrKTfB/FD7
         HAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681890660; x=1684482660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KTFJRBbngRhZPhykIp7UPAX69ViWolw+6lsvVy+TTo=;
        b=Vp2nZ+5VzxyK6qL4NBEoyBoy1OxBULQdOZUHoaHFZjT4xO02X3Nv3ANEY7JxsKMbA3
         0Yeb6SSDIvbW55NtMt2FqWwsKyoqd+2fXsgXXa5OqGydyTSPtEcvFs7OlW8J+58Dm1qj
         o7RIJaETOtK3hbtGz9mk8yd18KIIQFOUnBCo67MaRNv4i8s8jSM0+x/+VGOXkDKAGweI
         Kc9tNvFXJXfm0ug9NISpFftyV41K4d/fG4abEDLBcRGmTP8Z2GA3RF5IJ64P1npPT81f
         8SRZmyMxX4kAO8HAtI7zw5zkmCTzfBFedocJXv2CahhgCPMTY9+uDVGpPnePNciQxIzC
         Eb5A==
X-Gm-Message-State: AAQBX9c74EFJKkY2/nEw1FjrCe9wnB8Z/2zJdxAlUNiU02cfSo5OARey
        Fdii14DWkJaUCgs+UPuDiYt/pKzY51Cw9yqmrAoGiQ==
X-Google-Smtp-Source: AKy350aWTPX1CH16HyMBiG8mr1sfla0oknBZ14FsmKCzgg47SSbk3rPjMWYPGms18WKGi2StzBsPLA==
X-Received: by 2002:aa7:c604:0:b0:504:aaba:9b0c with SMTP id h4-20020aa7c604000000b00504aaba9b0cmr5216511edq.31.1681890659684;
        Wed, 19 Apr 2023 00:50:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id c9-20020a056402100900b0050508605c1dsm7774156edu.37.2023.04.19.00.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:50:59 -0700 (PDT)
Message-ID: <e83733cf-b396-1ec7-4247-49d0f94e8517@linaro.org>
Date:   Wed, 19 Apr 2023 09:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/5] arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com,
        afd@ti.com
Cc:     s-vadapalli@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a-bhatia1@ti.com
References: <20230419061710.290068-1-j-choudhary@ti.com>
 <20230419061710.290068-3-j-choudhary@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230419061710.290068-3-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 08:17, Jayesh Choudhary wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> J784S4 SoC has a Main CPSW2G instance of the CPSW Ethernet Switch.
> 
> Add the device-tree nodes for the Main CPSW2G instance and enable it.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 48 +++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 68 ++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index f33815953e77..aef6f53ae8ac 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -105,6 +105,30 @@ vdd_sd_dv: regulator-TLV71033 {
>  };
>  
>  &main_pmx0 {
> +	main_cpsw2g_pins_default: main-cpsw2g-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x0b8, PIN_INPUT, 6) /* (AC34) MCASP1_ACLKX.RGMII1_RD0 */
> +			J784S4_IOPAD(0x0a0, PIN_INPUT, 6) /* (AD34) MCASP0_AXR12.RGMII1_RD1 */
> +			J784S4_IOPAD(0x0a4, PIN_INPUT, 6) /* (AJ36) MCASP0_AXR13.RGMII1_RD2 */
> +			J784S4_IOPAD(0x0a8, PIN_INPUT, 6) /* (AF34) MCASP0_AXR14.RGMII1_RD3 */
> +			J784S4_IOPAD(0x0b0, PIN_INPUT, 6) /* (AL33) MCASP1_AXR3.RGMII1_RXC */
> +			J784S4_IOPAD(0x0ac, PIN_INPUT, 6) /* (AE34) MCASP0_AXR15.RGMII1_RX_CTL */
> +			J784S4_IOPAD(0x08c, PIN_INPUT, 6) /* (AE35) MCASP0_AXR7.RGMII1_TD0 */
> +			J784S4_IOPAD(0x090, PIN_INPUT, 6) /* (AC35) MCASP0_AXR8.RGMII1_TD1 */
> +			J784S4_IOPAD(0x094, PIN_INPUT, 6) /* (AG35) MCASP0_AXR9.RGMII1_TD2 */
> +			J784S4_IOPAD(0x098, PIN_INPUT, 6) /* (AH36) MCASP0_AXR10.RGMII1_TD3 */
> +			J784S4_IOPAD(0x0b4, PIN_INPUT, 6) /* (AL34) MCASP1_AXR4.RGMII1_TXC */
> +			J784S4_IOPAD(0x09c, PIN_INPUT, 6) /* (AF35) MCASP0_AXR11.RGMII1_TX_CTL */
> +		>;
> +	};
> +
> +	main_cpsw2g_mdio_pins_default: main-cpsw2g-mdio-pins-default {
> +		pinctrl-single,pins = <
> +			J784S4_IOPAD(0x0c0, PIN_INPUT, 6) /* (AD38) MCASP1_AXR0.MDIO0_MDC */
> +			J784S4_IOPAD(0x0bc, PIN_INPUT, 6) /* (AD33) MCASP1_AFSX.MDIO0_MDIO */
> +		>;
> +	};
> +
>  	main_uart8_pins_default: main-uart8-pins-default {
>  		pinctrl-single,pins = <
>  			J784S4_IOPAD(0x040, PIN_INPUT, 14) /* (AF37) MCASP0_AXR0.UART8_CTSn */
> @@ -253,3 +277,27 @@ &mcu_cpsw_port1 {
>  	phy-mode = "rgmii-rxid";
>  	phy-handle = <&mcu_phy0>;
>  };
> +
> +&main_cpsw1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_cpsw2g_pins_default>;
> +};
> +
> +&main_cpsw1_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_cpsw2g_mdio_pins_default>;
> +
> +	main_phy0: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,min-output-impedance;
> +	};
> +};
> +
> +&main_cpsw1_port1 {
> +	status = "okay";
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&main_phy0>;
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 5fb7edf4f5a0..8bd8aebebe1c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -36,6 +36,12 @@ scm_conf: syscon@100000 {
>  		#size-cells = <1>;
>  		ranges = <0x00 0x00 0x00100000 0x1c000>;
>  
> +		cpsw1_phy_gmii_sel: phy@4034 {
> +			compatible = "ti,am654-phy-gmii-sel";
> +			reg = <0x4034 0x4>;
> +			#phy-cells = <1>;
> +		};
> +
>  		serdes_ln_ctrl: mux-controller-4080 {
>  			compatible = "mmio-mux";
>  			#mux-control-cells = <1>;
> @@ -777,6 +783,68 @@ cpts@310d0000 {
>  		};
>  	};
>  
> +	main_cpsw1: ethernet@c200000 {
> +		compatible = "ti,j721e-cpsw-nuss";
> +		#address-cells = <2>;
> +		#size-cells = <2>;

Fix order of your properties. reg/reg-names/ranges follow comaptible.

> +		reg = <0x00 0xc200000 0x00 0x200000>;
> +		reg-names = "cpsw_nuss";
> +		ranges = <0x00 0x00 0x00 0xc200000 0x00 0x200000>;
> +		dma-coherent;
> +		clocks = <&k3_clks 62 0>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
> +
> +		dmas = <&main_udmap 0xc640>,
> +		       <&main_udmap 0xc641>,
> +		       <&main_udmap 0xc642>,
> +		       <&main_udmap 0xc643>,
> +		       <&main_udmap 0xc644>,
> +		       <&main_udmap 0xc645>,
> +		       <&main_udmap 0xc646>,
> +		       <&main_udmap 0xc647>,
> +		       <&main_udmap 0x4640>;
> +		dma-names = "tx0", "tx1", "tx2", "tx3",
> +			    "tx4", "tx5", "tx6", "tx7",
> +			    "rx";
> +
> +		status = "disabled";
> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			main_cpsw1_port1: port@1 {
> +				reg = <1>;
> +				label = "port1";
> +				phys = <&cpsw1_phy_gmii_sel 1>;
> +				ti,mac-only;
> +				status = "disabled";
> +			};
> +		};
> +
> +		main_cpsw1_mdio: mdio@f00 {
> +			compatible = "ti,cpsw-mdio", "ti,davinci_mdio";
> +			reg = <0x00 0xf00 0x00 0x100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&k3_clks 62 0>;
> +			clock-names = "fck";
> +			bus_freq = <1000000>;
> +		};
> +
> +		cpts@3d000 {

Are you sure dtbs_check does not print any warnings?


Best regards,
Krzysztof

