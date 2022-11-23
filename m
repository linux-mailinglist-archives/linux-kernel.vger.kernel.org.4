Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB4635FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbiKWNdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbiKWNcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:32:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C908FB1F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:16:35 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id r12so28160235lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27mw8siOPkDIXlgNJdWjP1EThUf9Il+jNuPtzyYLBjc=;
        b=URztD1dtrqF03HEca5SX2tYyCe+iQM39wF99L/HrtAWa5vw10ASpSauiSETyL3DQ80
         NuKdUdc9Yhqa3et9vdAFP4EFxkWB/3aSc5VNL4pHE1BFRihBQO56UfiP5TCJw3hk8cvW
         z/SjPqy41A9U6d2mpT9v4QHFsl0MvxmZx/FuLfGDMADud6h6Tmpt331vH1jCJ47Ii2BE
         zO+SCfXaZaNRUWcsZ/5PITp22yqI8TAHgix25WLVEy9dX7IWQMrzlGgRu4HI7Pl1PpSe
         uT+W0mesfwB5WCl/UnIYDQHdSaCRdEBmDtKPRPbpHD6KP12QdhxpbsmC/yi97ryp2cNM
         bUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27mw8siOPkDIXlgNJdWjP1EThUf9Il+jNuPtzyYLBjc=;
        b=lNv4FrGOAHhKwWcR8rxEQIl1BBz0n08EnZKoorhXXHkkR73tLWpOwVIXVLyA4wxA0V
         zhDk3u0N1EibQv3w/Jj2/BXtzYvoAkI0ghV2fZcKrBjqJmJLnPXpl05OYNEDQEqApPt0
         K1T/2R0KCW77A3WPIFbR9RCDhhxRZwBy7S2OYj4zHI2W43Xr873IrvnbG/rk+o4OpLrc
         3xlNMchO3yczSF6d4e/sMqrAh2Q8S6b1XKjZYiEdl6wsIHew8zMAvkzIrqYpFMuwPDV/
         y6UULZEzUUH/IutzL1HebVrcfzwqW4D+gN60Gy/PZUDriEihVNNpFcG77UOtU6KK2Sbe
         a79A==
X-Gm-Message-State: ANoB5pkjdNdAVdkvQVdLw0aALGlqPEux/gb6oPoCEhdU8vsFv4NWnU2Q
        32SIrEtHGKHyIT+QQN15YhU5FA==
X-Google-Smtp-Source: AA0mqf5fGzQ0qt+Ihj3pfhI9P6aigyg3fZaWiL46HeyGmwhajNcfWrAnb6Oa5LtmWUGV7hW3fqzH0g==
X-Received: by 2002:ac2:4219:0:b0:4a2:2701:7d29 with SMTP id y25-20020ac24219000000b004a227017d29mr10167832lfh.322.1669209393232;
        Wed, 23 Nov 2022 05:16:33 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id e15-20020ac24e0f000000b00498fc3d4d15sm2868084lfr.190.2022.11.23.05.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 05:16:32 -0800 (PST)
Message-ID: <bf38822a-f303-c362-e633-1ec94081095a@linaro.org>
Date:   Wed, 23 Nov 2022 14:16:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: sc8280xp: add SoundWire and
 LPASS
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221123104342.26140-1-srinivas.kandagatla@linaro.org>
 <20221123104342.26140-3-srinivas.kandagatla@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221123104342.26140-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.11.2022 11:43, Srinivas Kandagatla wrote:
> Add LPASS Codecs along with SoundWire controller for TX, RX, WSA and VA macros
> along with LPASS LPI pinctrl node.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 320 +++++++++++++++++++++++++
>  1 file changed, 320 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index e8b6f67b928e..c2e61c8db332 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,gpr.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  / {
> @@ -1668,6 +1669,322 @@ q6prmcc: clock-controller {
>  			};
>  		};
>  
> +		rxmacro: rxmacro@3200000 {
> +			compatible = "qcom,sc8280xp-lpass-rx-macro";
> +			reg = <0 0x03200000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&vamacro>;
> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +					  <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>, <19200000>;
> +
> +			clock-output-names = "mclk";
> +			#clock-cells = <0>;
> +			#sound-dai-cells = <1>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&rx_swr_default>;
> +		};
> +
> +		/* RX */
> +		swr1: soundwire-controller@3210000 {
> +			compatible = "qcom,soundwire-v1.6.0";
> +			reg = <0 0x03210000 0 0x2000>;
> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&rxmacro>;
> +			clock-names = "iface";
> +			label = "RX";
> +
> +			qcom,din-ports = <0>;
> +			qcom,dout-ports = <5>;
> +
> +			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x1f 0x1f 0x07 0x00>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0B 0x01 0x00>;
> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
> +			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
> +
> +			#sound-dai-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
> +		txmacro: txmacro@3220000 {
> +			compatible = "qcom,sc8280xp-lpass-tx-macro";
> +			reg = <0 0x03220000 0 0x1000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&tx_swr_default>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&vamacro>;
> +
> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +					  <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>, <19200000>;
> +			clock-output-names = "mclk";
> +
> +			#clock-cells = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#sound-dai-cells = <1>;
> +		};
> +
> +		wsamacro: codec@3240000 {
> +			compatible = "qcom,sc8280xp-lpass-wsa-macro";
> +			reg = <0 0x03240000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&vamacro>;
> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +					  <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>, <19200000>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "mclk";
> +			#sound-dai-cells = <1>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wsa_swr_default>;
> +		};
> +
> +		/* WSA */
> +		swr0: soundwire-controller@3250000 {
> +			reg = <0 0x03250000 0 0x2000>;
> +			compatible = "qcom,soundwire-v1.6.0";
> +			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&wsamacro>;
> +			clock-names = "iface";
> +
> +			qcom,din-ports = <2>;
> +			qcom,dout-ports = <6>;
> +
> +			qcom,ports-sinterval-low =	/bits/ 8 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x0f 0x0f>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x01 0x02 0x0c 0x06 0x12 0x0d 0x07 0x0a>;
> +			qcom,ports-offset2 =		/bits/ 8 <0xff 0x00 0x1f 0xff 0x00 0x1f 0x00 0x00>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0x01 0xff 0xff 0x01 0xff 0xff>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +
> +			#sound-dai-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
> +		/* TX */
> +		swr2: soundwire-controller@3330000 {
> +			compatible = "qcom,soundwire-v1.6.0";
> +			reg = <0 0x03330000 0 0x2000>;
> +			interrupts-extended = <&intc GIC_SPI 959 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "core", "wake";
> +
> +			clocks = <&vamacro>;
> +			clock-names = "iface";
> +			label = "TX";
> +			#sound-dai-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +
> +			qcom,din-ports = <4>;
> +			qcom,dout-ports = <0>;
> +			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03 0x03>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02 0x01>;
> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00 0x00>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-word-length =	/bits/ 8 <0xff 0x00 0xff 0xff>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00 0x00>;
> +		};
> +
> +		vamacro: codec@3370000 {
> +			compatible = "qcom,sc8280xp-lpass-va-macro";
> +			reg = <0 0x03370000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			clock-names = "mclk", "macro", "dcodec", "npl";
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "fsgen";
> +			#sound-dai-cells = <1>;
> +		};
> +
> +		lpass_tlmm: pinctrl@33c0000 {
> +			compatible = "qcom,sc8280xp-lpass-lpi-pinctrl";
> +			reg = <0 0x33c0000 0x0 0x20000>,
> +			      <0 0x3550000 0x0 0x10000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&lpass_tlmm 0 0 18>;
> +
> +			clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			clock-names = "core", "audio";
> +
> +			tx_swr_default: tx-swr-default-state {
> +				clk-pins {
> +					pins = "gpio0";
> +					function = "swr_tx_clk";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-disable;
> +				};
> +
> +				data-pins {
> +					pins = "gpio1", "gpio2";
> +					function = "swr_tx_data";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-bus-hold;
> +				};
> +			};
> +
> +			rx_swr_default: rx-swr-default-state {
> +				clk-pins {
> +					pins = "gpio3";
> +					function = "swr_rx_clk";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-disable;
> +				};
> +
> +				data-pins {
> +					pins = "gpio4", "gpio5";
> +					function = "swr_rx_data";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-bus-hold;
> +				};
> +			};
> +
> +			dmic01_default: dmic01-default-state {
> +				clk-pins {
> +					pins = "gpio6";
> +					function = "dmic1_clk";
> +					drive-strength = <8>;
> +					output-high;
> +				};
> +
> +				data-pins {
> +					pins = "gpio7";
> +					function = "dmic1_data";
> +					drive-strength = <8>;
> +					input-enable;
> +				};
> +			};
> +
> +			dmic01_sleep: dmic01-sleep-state {
> +				clk-pins {
> +					pins = "gpio6";
> +					function = "dmic1_clk";
> +					drive-strength = <2>;
> +					bias-disable;
> +					output-low;
> +				};
> +
> +				data-pins {
> +					pins = "gpio7";
> +					function = "dmic1_data";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +					input-enable;
> +				};
> +			};
> +
> +			dmic02_default: dmic02-default-state {
> +				clk-pins {
> +					pins = "gpio8";
> +					function = "dmic2_clk";
> +					drive-strength = <8>;
> +					output-high;
> +				};
> +
> +				data-pins {
> +					pins = "gpio9";
> +					function = "dmic2_data";
> +					drive-strength = <8>;
> +					input-enable;
> +				};
> +			};
> +
> +			dmic02_sleep: dmic02-sleep-state {
> +				clk-pins {
> +					pins = "gpio8";
> +					function = "dmic2_clk";
> +					drive-strength = <2>;
> +					bias-disable;
> +					output-low;
> +				};
> +
> +				data-pins {
> +					pins = "gpio9";
> +					function = "dmic2_data";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +					input-enable;
> +				};
> +			};
> +
> +			wsa_swr_default: wsa-swr-default-state {
> +				clk-pins {
> +					pins = "gpio10";
> +					function = "wsa_swr_clk";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-disable;
> +				};
> +
> +				data-pins {
> +					pins = "gpio11";
> +					function = "wsa_swr_data";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-bus-hold;
> +
> +				};
> +			};
> +
> +			wsa2_swr_default: wsa2-swr-default-state {
> +				clk-pins {
> +					pins = "gpio15";
> +					function = "wsa2_swr_clk";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-disable;
> +				};
> +
> +				data-pins {
> +					pins = "gpio16";
> +					function = "wsa2_swr_data";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-bus-hold;
> +				};
> +			};
> +		};
> +
>  		usb_0_qmpphy: phy-wrapper@88ec000 {
>  			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
>  			reg = <0 0x088ec000 0 0x1e4>,
> @@ -2507,6 +2824,9 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  		};
>  	};
>  
> +	sound: sound {
> +	};
> +
>  	thermal-zones {
>  		cpu0-thermal {
>  			polling-delay-passive = <250>;
