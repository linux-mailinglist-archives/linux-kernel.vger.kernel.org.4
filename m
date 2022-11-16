Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1786662B7B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbiKPKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiKPKUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:20:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE586240A0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:20:15 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id l12so28747632lfp.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5aL5bBi60VmhqGVX72Tovv8qAE3jwwDAyPtMKlL6HE=;
        b=wv1Rjpzver6kq6z8NbdV4T1E76qcaNaLDz6q3Rvw7By5YY0RPRD1F0hqzutIoDsetS
         C4m4l4XlGMvyAi0wVsC14xsVDXz0g+bBnJT+wfYLUcfLzOuluiQ6KefISglcBxXFA3tW
         ZjEQ/axFtBqsyJP2nfD4LIsMty0T2KAoowXW9msmzg8Gjg3dXiaJJgJXHI4pGFSj4G4J
         ZNx7aswnACe3YZDYaDwaGOApFPcFhOS5mycWsefEV4FQyf7U3AcD2Y6lJWa0POqNk3Th
         LUuJz4+WP53hu0qDOpn+bcvoR93Lm7u8CYgobUCGA7Fq82wooue/mgaAAE5kU+nqDPtc
         jiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5aL5bBi60VmhqGVX72Tovv8qAE3jwwDAyPtMKlL6HE=;
        b=PLFYwC6GWN9wZPpZnElOyb+b0NQne3SiigPKSitHvotloTkQBWnWy4vPpbgovL2eFC
         7InD8s3nC8wkc6l3qEgzTy9TP+7Rlld00JuBVi75+irlpU2AvwGgI059vVaRHUsc0Jc1
         QBLZhlKn3d+4L/zhNYO02AP+wkAPnwxm15WwBbO0f7TEa94ab8cylkbnU7QXAM8BwCFx
         SD609sQ35kezLb1G/oErERjb7RjYZS5YfUYus8GZJqcb7sPcO3iVX1aRVAqrEwBvCnnB
         EBAS2uNOY2KO9t1Ri7uPfkZJhI4Hm0wVAUMeuzNk7Ky+bxEPAF+xfIMr9LiJFj+gUmj4
         Nhhg==
X-Gm-Message-State: ANoB5pkOiqUoiNMEeSN3NlsvwGac7VifjqVEdR6yDcB0TQQDBDYxKpQD
        zdhA22Z9FK0mGy1s6xwSSAfdMA==
X-Google-Smtp-Source: AA0mqf7DjJOS1Z8RO0dZMtfkcsuHYYLSvIv01UUZZYZQZyOrZnyIv2DcMuXv4/b/VK+75F8OWDIvyQ==
X-Received: by 2002:ac2:5f1d:0:b0:4b0:246a:f728 with SMTP id 29-20020ac25f1d000000b004b0246af728mr7392296lfq.534.1668594014092;
        Wed, 16 Nov 2022 02:20:14 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id d25-20020a19e619000000b004ab52b0bcf9sm2519623lfh.207.2022.11.16.02.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 02:20:13 -0800 (PST)
Message-ID: <7605af5f-a828-5df7-48b8-b543edb0f9b1@linaro.org>
Date:   Wed, 16 Nov 2022 11:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8450: add Soundwire and LPASS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116101314.52887-1-krzysztof.kozlowski@linaro.org>
 <20221116101314.52887-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116101314.52887-3-krzysztof.kozlowski@linaro.org>
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



On 16/11/2022 11:13, Krzysztof Kozlowski wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Add Soundwire controllers, Low Power Audio SubSystem (LPASS) devices and
> LPASS pin controller.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Use lower-case hex.
> 
> Changes since v1:
> 1. Whitespace cleanups.
> 2. Correct include - do not use deprecated one.
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 295 +++++++++++++++++++++++++++
>   1 file changed, 295 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 4b0a1eee8bd9..747440d0445a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -15,6 +15,7 @@
>   #include <dt-bindings/interconnect/qcom,sm8450.h>
>   #include <dt-bindings/soc/qcom,gpr.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>   #include <dt-bindings/thermal/thermal.h>
>   
>   / {
> @@ -2097,6 +2098,212 @@ compute-cb@3 {
>   			};
>   		};
>   
> +		wsa2macro: codec@31e0000 {
> +			compatible = "qcom,sm8450-lpass-wsa-macro";
> +			reg = <0 0x031e0000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&vamacro>;
> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>, <19200000>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "wsa2-mclk";
> +			#sound-dai-cells = <1>;
I think I'm being a bit too picky, but #-cells could go as the last 
bunch of properties.


> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wsa2_swr_active>;
> +		};
> +
> +		/* WSA2 */
> +		swr4: soundwire-controller@31f0000 {
> +			reg = <0 0x031f0000 0 0x2000>;
> +			compatible = "qcom,soundwire-v1.7.0";
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&wsa2macro>;
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
> +		rxmacro: codec@3200000 {
> +			compatible = "qcom,sm8450-lpass-rx-macro";
> +			reg = <0 0x3200000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&vamacro>;
> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>, <19200000>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "mclk";
> +			#sound-dai-cells = <1>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&rx_swr_active>;
> +		};
> +
> +		swr1: soundwire-controller@3210000 {
> +			reg = <0 0x3210000 0 0x2000>;
> +			compatible = "qcom,soundwire-v1.7.0";
Some nodes have reg and compatible flipped.

> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&rxmacro>;
> +			clock-names = "iface";
> +			label = "RX";
> +			qcom,din-ports = <0>;
> +			qcom,dout-ports = <5>;
> +
> +			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x1f 0x1f 0x07 0x00>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x00>;
> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
> +			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
> +			#sound-dai-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
> +		txmacro: codec@3220000 {
> +			compatible = "qcom,sm8450-lpass-tx-macro";
> +			reg = <0 0x3220000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&vamacro>;
> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +					   <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>, <19200000>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "mclk";
> +			#sound-dai-cells = <1>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&tx_swr_active>;
> +		};
> +
> +		wsamacro: codec@3240000 {
> +			compatible = "qcom,sm8450-lpass-wsa-macro";
> +			reg = <0 0x03240000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&vamacro>;
> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
> +
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>, <19200000>;
> +
> +			#clock-cells = <0>;
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
> +			compatible = "qcom,soundwire-v1.7.0";
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
> +			qcom,port-offset = <1>;
> +			#sound-dai-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
> +		swr2: soundwire-controller@33b0000 {
> +			reg = <0 0x33b0000 0 0x2000>;
> +			compatible = "qcom,soundwire-v1.7.0";
> +			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "core", "wake";
> +
> +			clocks = <&vamacro>;
> +			clock-names = "iface";
> +			label = "TX";
> +
> +			qcom,din-ports = <4>;
> +			qcom,dout-ports = <0>;
> +			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x01 0x03 0x03>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x01 0x01>;
> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00 0x00>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x01 0x02 0x00 0x00>;
> +			qcom,port-offset = <1>;
> +			#sound-dai-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
> +		vamacro: codec@33f0000 {
> +			compatible = "qcom,sm8450-lpass-va-macro";
> +			reg = <0 0x033f0000 0 0x1000>;
> +			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			clock-names = "mclk", "macro", "dcodec", "npl";
> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "fsgen";
> +			#sound-dai-cells = <1>;
> +		};
> +
>   		remoteproc_adsp: remoteproc@30000000 {
>   			compatible = "qcom,sm8450-adsp-pas";
>   			reg = <0 0x030000000 0 0x100>;
> @@ -3030,6 +3237,91 @@ qup_uart20_default: qup-uart20-default-state {
>   
>   		};
>   
> +		lpass_tlmm: pinctrl@3440000{
> +			compatible = "qcom,sm8450-lpass-lpi-pinctrl";
> +			reg = <0 0x3440000 0x0 0x20000>,
> +			      <0 0x34d0000 0x0 0x10000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&lpass_tlmm 0 0 23>;
> +
> +			clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			clock-names = "core", "audio";
> +
> +			wsa_swr_active: wsa-swr-active-state {
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
> +				};
> +			};
> +
> +			tx_swr_active: tx-swr-active-state {
> +				clk-pins {
> +					pins = "gpio0";
> +					function = "swr_tx_clk";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-disable;
> +				};
> +
> +				data-pins {
> +					pins = "gpio1", "gpio2", "gpio14";
> +					function = "swr_tx_data";
> +					drive-strength = <2>;
> +					slew-rate = <1>;
> +					bias-bus-hold;
> +				};
> +			};
> +
> +			rx_swr_active: rx-swr-active-state {
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
> +			wsa2_swr_active: wsa2-swr-active-state {
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
>   		apps_smmu: iommu@15000000 {
>   			compatible = "qcom,sm8450-smmu-500", "arm,mmu-500";
>   			reg = <0 0x15000000 0 0x100000>;
> @@ -3507,6 +3799,9 @@ lpass_ag_noc: interconnect@3c40000 {
>   		};
>   	};
>   
> +	sound: sound {
> +	};
You asked another folk working on sa8540p to not include sound in the 
SoC dtsi.

Konrad

> +
>   	thermal-zones {
>   		aoss0-thermal {
>   			polling-delay-passive = <0>;
