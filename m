Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0B462A099
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKORpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKORpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:45:16 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A05AF65
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:45:14 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so25603528lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktFqyp/Rm7QWpojzrGiNCwzcmoQvFUVTLeVqQXyRL2E=;
        b=zClz1YsFjc8okOvQZEorgxDeHvppucxz+HmyexDyEK/zP72d7Q8scAcDv8vi47wSxl
         SCNvs+QhGQPbjWqnJ6VFhHYJsTr1/+j4c58gm6rDdqYWZSWWqFi3hZ9ubMO//DIVEmkx
         OSdfV3RIEwHJbhlia3uEl6WJAMEG55eVaaXWTTiCAgCoIwfHfcJ5HKbyuT67EZ5it1iE
         wDGFWnlSFnS7seuJ1b96Hg86k6nuf0ba5OI/zY1DJ0Fa/Md2VQjkKU6HHv/Gh1EBGf/Y
         BsoLT7Kt0Mq9K6mOJf6TCXbPx+S28yRtKGGypm+4Ew38BuLa2AumGfU6+mEoiIbBgf4T
         Uk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ktFqyp/Rm7QWpojzrGiNCwzcmoQvFUVTLeVqQXyRL2E=;
        b=Dh023gc0R8wH6H2JvSefJ9zBezd/6Ot/XOoHsQZhq2y3Bf9seo3Z/0GriDCnrqvRCU
         V0peVIk2ooM3mq+F/65WsiEfDYEjfvcoLfcaBE1/d3S8oCySpl+NIeKEtExEK1O0Pxjx
         UZTJ7OXMtgmxcTnbrhxnnISWXg8V8enuodLepIgTxsahfeiAy7rA+32wa6GbntrV+75b
         cRzhw5cKLn2knZMh/UFnTEPQQAUc2jq0aX+xd1QcNPeYn5tbOJOqVXV7zy0v7vuMC/C1
         6yo/wKjMGx73qGeASRoI7N59ZJg+xCXy9XKH++QRCIeXfHcR7j7VRux+f4jmH3UytNwk
         KNGQ==
X-Gm-Message-State: ANoB5pmR5DJ+wuijwG7JteNHohMXuz1s6NtjAQYLOvu5iqJeYdOR4W2Q
        dddSLujlWDdH3rA/yhKBPwUHPA==
X-Google-Smtp-Source: AA0mqf6SCWsAOWM1sk7FJ82RYqWcwIiKGQ8XkF5+ENu7RISvrWLFzn9SsUBE6uj9MHkP1ps8bSfDcw==
X-Received: by 2002:a19:441a:0:b0:4aa:c879:5bc with SMTP id r26-20020a19441a000000b004aac87905bcmr5906785lfa.498.1668534311275;
        Tue, 15 Nov 2022 09:45:11 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id m28-20020a056512015c00b00497b198987bsm2297512lfo.26.2022.11.15.09.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:45:10 -0800 (PST)
Message-ID: <d18cc5ab-51fe-07c3-660a-9730355eebc6@linaro.org>
Date:   Tue, 15 Nov 2022 18:45:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp/sa8540p: add SoundWire and
 LPASS
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
 <20221115170242.150246-3-srinivas.kandagatla@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221115170242.150246-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 324 +++++++++++++++++++++++++
>   1 file changed, 324 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index e3cdd8bccb0c..a87d58bee1e0 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -11,6 +11,7 @@
>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
>   #include <dt-bindings/thermal/thermal.h>
>   #include <dt-bindings/soc/qcom,gpr.h>
>   
> @@ -1115,6 +1116,9 @@ usb_2_ssphy1: phy@88f1e00 {
>   			};
>   		};
>   
> +		sound: sound {
> +		};
> +
>   		remoteproc_adsp: remoteproc@3000000 {
>   			compatible = "qcom,sc8280xp-adsp-pas";
>   			reg = <0 0x03000000 0 0x100>;
> @@ -1195,6 +1199,326 @@ q6prmcc: cc {
>   			};
>   		};
>   
> +		rxmacro: rxmacro@3200000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&rx_swr_active>;
> +			compatible = "qcom,sc8280xp-lpass-rx-macro";
Hi!

Please make compatible and reg go first, pinctrl cango after 
assigned-clock-rates. Applies to all cases.

> +			reg = <0 0x3200000 0 0x1000>;
Please pad the address field to 8 hex digits. Applies to all cases.


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
Please use lowercase hex throughout dt.


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
This will not pass dtbs_check. The top-level node names need to end in 
-state, whereas their children's (if there are any) need to end in -pins.

See the example in 
Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml.

Also, please sort them somehow. If they all concern contiguous GPIO 
blocks, maybe sorting by GPIO number would make sense?

> +				clk {
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
No underscores in node names.

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
bias-pull-down?

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
> +				data {
> +					pins = "gpio9";
> +					function = "dmic2_data";
> +					drive-strength = <8>;
> +					input-enable;
> +				};
> +			};
> +
> +			dmic02_sleep: dmic02-sleep-pins {
> +				clk {
> +					pins = "gpio8";
> +					function = "dmic2_clk";
> +					drive-strength = <2>;
> +					bias-disable;
> +					output-low;
> +				};
> +
> +				data {
> +					pins = "gpio9";
> +					function = "dmic2_data";
> +					drive-strength = <2>;
> +					pull-down;
bias-pull-down?

Konrad
> +					input-enable;
> +				};
> +			};
> +		};
> +
>   		usb_0_qmpphy: phy-wrapper@88ec000 {
>   			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
>   			reg = <0 0x088ec000 0 0x1e4>,
