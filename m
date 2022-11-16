Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AE862B4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiKPINz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiKPINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:13:37 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5F55F89
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:10:48 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id c25so20804219ljr.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xVc0wNpzgUJScPLjmPe7fS5lb3mOUGZNhIizdJg5WM=;
        b=CG1eLtlsAUF+skf9ULdeZCk4r+ZEaQCrv89Jm+JhW7CH3aAEAGsav3ikRarPPsPrYI
         ZyQdejhOw+np+3qtGez+e+stKmhvBmEevhR6RP+mhO6Zcc/UScBvtvmcT1iaLSJFitA/
         I14a92wrwI+9sQB1GrH/Ofe830M8Xq5ZSGAMBZ8dY+8ska+NhV6kp6kNQFduKXozehkb
         ZGXCaBALPvL+ooBPkNntAOhm77BXPY7W44PRPy3JT/vSvelW3FxQmpDFUfUVtE56l8Hd
         MKAgd6nJ0pSNPUQbhQfZzHJKOcsQL+2d7jiYC5l1CPbE+lBfKh9zGAaDL4Xqyao/JsfG
         rhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xVc0wNpzgUJScPLjmPe7fS5lb3mOUGZNhIizdJg5WM=;
        b=Od4CVYEdFigTvC5xjkAIRyuf/6fA7J8W/s8cN7bu0+iA4E18mGjRYjVd44VRf49Mcm
         OWSuwOb6UCafGjiPSOQP92rOKrlxsWSX6UesXlVo8qT9i6YCsT62SYZ6leeegggQq1X9
         C0sA9a3MTETnhF0Bo/6ha3b+1QWLDuDYj4kjSC9aWvfMthYOcWaA/gf/jTDwnveO0beX
         b36MJEV8OSMizYO+Yg4VvlB74fujbyS0djbr1YXgH+8F4ZjVGryTFEBQuonKclLrwJf6
         qQrA4DAiSbOpWJbH0RPX0fVnFgwhDIpofS1DHavYnuJknRHuNOU7nz+J30nLDSGnBk1W
         Q8UA==
X-Gm-Message-State: ANoB5plMpY9eKWb9dGQKECyD7XjZ4SlbcQSeaO1jjFBb8c0VCKKrEY2R
        Z0lumarX984A50exL2yoMeHfCw==
X-Google-Smtp-Source: AA0mqf6Rv6lfLTd3FTbjkyq9WMH27339EvUAzGFs+vPZJKMIZZ8bL5NIrFi4MFR5wZchfbg0F8l49A==
X-Received: by 2002:a2e:a90c:0:b0:277:4e4:d21a with SMTP id j12-20020a2ea90c000000b0027704e4d21amr7446419ljq.196.1668586246504;
        Wed, 16 Nov 2022 00:10:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q11-20020a2e874b000000b00277159d7f2esm2781969ljj.104.2022.11.16.00.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:10:45 -0800 (PST)
Message-ID: <5ff80fe0-eb23-9db0-ab75-189da5977901@linaro.org>
Date:   Wed, 16 Nov 2022 09:10:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp/sa8540p: add SoundWire and
 LPASS
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
 <20221115170242.150246-3-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115170242.150246-3-srinivas.kandagatla@linaro.org>
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

On 15/11/2022 18:02, Srinivas Kandagatla wrote:
> Add LPASS Codecs along with SoundWire controller for TX, RX, WSA and VA macros
> along with LPASS LPI pinctrl node.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 324 +++++++++++++++++++++++++
>  1 file changed, 324 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index e3cdd8bccb0c..a87d58bee1e0 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/thermal/thermal.h>
>  #include <dt-bindings/soc/qcom,gpr.h>
>  
> @@ -1115,6 +1116,9 @@ usb_2_ssphy1: phy@88f1e00 {
>  			};
>  		};
>  
> +		sound: sound {
> +		};

sound node is not part of SoC.

> +
>  		remoteproc_adsp: remoteproc@3000000 {
>  			compatible = "qcom,sc8280xp-adsp-pas";
>  			reg = <0 0x03000000 0 0x100>;
> @@ -1195,6 +1199,326 @@ q6prmcc: cc {
>  			};
>  		};
>  
> +		rxmacro: rxmacro@3200000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&rx_swr_active>;
> +			compatible = "qcom,sc8280xp-lpass-rx-macro";
> +			reg = <0 0x3200000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&q6prmcc LPASS_CLK_ID_RX_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&vamacro>;
> +
> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>, <19200000>;
> +
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +			clock-output-names = "mclk";
> +			#sound-dai-cells = <1>;
> +		};
> +
> +		/* RX */
> +		swr1: soundwire-controller@3210000 {
> +			reg = <0 0x3210000 0 0x2000>;
> +			compatible = "qcom,soundwire-v1.6.0";
> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&rxmacro>;
> +			clock-names = "iface";
> +			label = "RX";
> +			qcom,din-ports = <0>;
> +			qcom,dout-ports = <5>;
> +
> +			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x1F 0x1F 0x07 0x00>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0B 0x01 0x00>;
> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
> +			qcom,ports-hstart =		/bits/ 8 <0xFF 0x03 0xFF 0xFF 0xFF>;
> +			qcom,ports-hstop =		/bits/ 8 <0xFF 0x06 0xFF 0xFF 0xFF>;
> +			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xFF 0xFF>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0x00 0x01 0xFF 0xFF>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0x00>;
> +			#sound-dai-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
> +		txmacro: txmacro@3220000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&tx_swr_active>;
> +			compatible = "qcom,sc8280xp-lpass-tx-macro";
> +			reg = <0 0x3220000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,

Align the opening <

> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&vamacro>;
> +
> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>, <19200000>;
> +
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +			clock-output-names = "mclk";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#sound-dai-cells = <1>;
> +		};
> +
> +		/* TX */
> +		swr2: soundwire-controller@3330000 {
> +			reg = <0 0x3330000 0 0x2000>;
> +			compatible = "qcom,soundwire-v1.6.0";
> +			interrupts-extended = <&intc GIC_SPI 959 IRQ_TYPE_LEVEL_HIGH>,
> +						<&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "core", "wake";
> +
> +			clocks = <&vamacro>;
> +			clock-names = "iface";
> +			label = "TX";
> +
> +			qcom,din-ports = <4>;
> +			qcom,dout-ports = <0>;
> +			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03 0x03>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02 0x01>;
> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00 0x00>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
> +			qcom,ports-hstart =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
> +			qcom,ports-hstop =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
> +			qcom,ports-word-length =	/bits/ 8 <0xFF 0x00 0xFF 0xFF>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00 0x00>;
> +			qcom,port-offset = <1>;
> +			#sound-dai-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
> +		wsamacro: codec@3240000 {

Order nodes by unit address.

> +			compatible = "qcom,sc8280xp-lpass-wsa-macro";
> +			reg = <0 0x03240000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&vamacro>;
> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +					 <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>, <19200000>;
> +
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +			clock-output-names = "mclk";
> +			#sound-dai-cells = <1>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wsa_swr_active>;
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
> +			qcom,ports-offset2 =		/bits/ 8 <0xFF 0x00 0x1f 0xff 0x00 0x1f 0x00 0x00>;
> +			qcom,ports-hstart =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
> +			qcom,ports-hstop =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
> +			qcom,ports-word-length =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0xFF 0x01 0xFF 0xFF 0x01 0xFF 0xFF>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
> +			qcom,ports-lane-control =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
> +			qcom,port-offset = <1>;
> +			#sound-dai-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
> +		vamacro: codec@3370000 {
> +			compatible = "qcom,sc8280xp-lpass-va-macro";
> +			reg = <0 0x03370000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&q6prmcc LPASS_CLK_ID_TX_CORE_NPL_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				<&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +
> +			clock-names = "mclk", "npl", "macro", "dcodec";
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>;
> +
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
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
> +				<&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			clock-names = "core", "audio";
> +
> +			wsa_swr_active: wsa-swr-active-pins {

There is no way this passes bindings test. state suffix.

> +				clk {

pins suffix

> +					pins = "gpio10";
> +					function = "wsa_swr_clk";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-disable;
> +				};
> +
> +				data {
> +					pins = "gpio11";
> +					function = "wsa_swr_data";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-bus-hold;
> +
> +				};
> +			};
> +
> +			tx_swr_active: tx_swr-active-pins {
> +				clk {
> +					pins = "gpio0";
> +					function = "swr_tx_clk";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-disable;
> +				};
> +
> +				data {
> +					pins = "gpio1", "gpio2";
> +					function = "swr_tx_data";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-bus-hold;
> +				};
> +			};
> +
> +			rx_swr_active: rx_swr-active-pins {
> +				clk {
> +					pins = "gpio3";
> +					function = "swr_rx_clk";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-disable;
> +				};
> +
> +				data {
> +					pins = "gpio4", "gpio5";
> +					function = "swr_rx_data";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-bus-hold;
> +				};
> +			};
> +
> +			wsa2_swr_active: wsa2-swr-active-pins {
> +				clk {
> +					pins = "gpio15";
> +					function = "wsa2_swr_clk";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-disable;
> +				};
> +
> +				data {
> +					pins = "gpio16";
> +					function = "wsa2_swr_data";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-bus-hold;
> +				};
> +			};
> +
> +			dmic01_active: dmic01-active-pins {
> +				clk {
> +					pins = "gpio6";
> +					function = "dmic1_clk";
> +					drive-strength = <8>;
> +					output-high;
> +				};

Blank line

> +				data {
> +					pins = "gpio7";
> +					function = "dmic1_data";
> +					drive-strength = <8>;
> +					input-enable;
> +				};
> +			};
> +
> +			dmic01_sleep: dmic01-sleep-pins {
> +				clk {
> +					pins = "gpio6";
> +					function = "dmic1_clk";
> +					drive-strength = <2>;
> +					bias-disable;
> +					output-low;
> +				};
> +
> +				data {
> +					pins = "gpio7";
> +					function = "dmic1_data";
> +					drive-strength = <2>;
> +					pull-down;
> +					input-enable;
> +				};
> +			};
> +
> +			dmic02_active: dmic02-active-pins {
> +				clk {
> +					pins = "gpio8";
> +					function = "dmic2_clk";
> +					drive-strength = <8>;
> +					output-high;
> +				};

Blank line

> +				data {
> +					pins = "gpio9";
> +					function = "dmic2_data";
> +					drive-strength = <8>;
> +					input-enable;
> +				};
> +			};
> +

Best regards,
Krzysztof

