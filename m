Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54F63ABA7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiK1O4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiK1O4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:56:14 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1961F9DA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:56:12 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id d3so13454951ljl.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOT7o7coi4TAoYXwjs3RFGYC2whGqK5WY9tHXZIG/1U=;
        b=yod1UQvqmzZ2TIMIRH2ba8qILPeb5EkucSvrGKXtDxb2SED5RDSZ3McHL31zJ1SZGh
         IKiLUpm9pxmN8TJOymI9j+szMpeBYi/ZVnpcqPfkc3fJ1hRK0lfYztqg2JOtpRNdvYO4
         csdle3fz04ml3iZxBqYvKEZwuOcPJ9LZ03gQlHzIFPmul1gKPjrbLO86fuk+vDDcWlpk
         FhA1Cg0GosabonZzoxLss42XnkNijGnf/MVNTWOmumhhZDLyqnXOtlQ91gjl3mCC9Wa0
         mauNA6nvYX1KLHK1QyTfoxNq0cGSb0qudhZvDFP0Xtl9H+gdMRjqTNK0zjc4jT0tgoeg
         bXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOT7o7coi4TAoYXwjs3RFGYC2whGqK5WY9tHXZIG/1U=;
        b=7LKyGKAfs8G+7HC45VbLxUcGxBG1x/S83xYFezUR3Ve+zH4SZGwqdq1Jf/fi9nI5Fx
         lAcahL6bhr6KIofSddyBCAi09HgM2h4jjAWNxF/bwg91Z8wUXEs1wrvsWpM4VsGMerZQ
         bubl50ukbnUqx9C3Hw3LhaGApvTxur7kWa1I74rxbl0xuzdnYGbp8L6w/e6Dzl7vZAPB
         sM26Go6rgMiYLwZ+kBcm0gTD4fWnKlmddgy9y8z42q9SOAf5mlVGJ3zsxO9kC5Lxj0gZ
         WlJvFl7NkFDEzKt27QuYQG+xFj9IYAQl+G0TkgIKd2Tef4RERoYcnf+sO2E2/KMu7t+O
         B9JA==
X-Gm-Message-State: ANoB5pk/QHjstOwDqfVV8ey+qMOUVZx1JWJ7Cd6Ch5nKN1xNgIPhBeYU
        +PQg5d92ccAHpzQFs/hXIQlY2ZZsHy94FQ==
X-Google-Smtp-Source: AA0mqf4qO15HyJ3tuVS2kA3l+CAlPoep6WVE5Xhje8cpzRISXqO+oS22pLp2MptiVm8KzyaVgoGszg==
X-Received: by 2002:a05:651c:201c:b0:279:a4b0:c34a with SMTP id s28-20020a05651c201c00b00279a4b0c34amr1992690ljo.435.1669647370814;
        Mon, 28 Nov 2022 06:56:10 -0800 (PST)
Received: from [192.168.1.101] (95.49.125.236.neoplus.adsl.tpnet.pl. [95.49.125.236])
        by smtp.gmail.com with ESMTPSA id t27-20020a2e8e7b000000b0026fbac7468bsm1217757ljk.103.2022.11.28.06.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 06:56:10 -0800 (PST)
Message-ID: <3751bf35-d202-99c2-fac1-12d3c69ad00a@linaro.org>
Date:   Mon, 28 Nov 2022 15:56:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sm8450: add Soundwire and LPASS
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221128131016.127860-1-krzysztof.kozlowski@linaro.org>
 <20221128131016.127860-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221128131016.127860-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.11.2022 14:10, Krzysztof Kozlowski wrote:
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v4:
> 1. Re-order few properties between Soundwire nodes, to keep them ordered
>    consistently.
> 2. Drop unsupported qcom,port-offset.
> 
> Changes since v3:
> 1. Re-order reg and sound-dai-cells.
> 
> Changes since v2:
> 1. Use lower-case hex.
> 
> Changes since v1:
> 1. Whitespace cleanups.
> 2. Correct include - do not use deprecated one.
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 292 +++++++++++++++++++++++++++
>  1 file changed, 292 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 7b63c56ff2f4..380405ec3452 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/interconnect/qcom,sm8450.h>
>  #include <dt-bindings/soc/qcom,gpr.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  / {
> @@ -2090,6 +2091,209 @@ compute-cb@3 {
>  			};
>  		};
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
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wsa2_swr_active>;
> +			#sound-dai-cells = <1>;
> +		};
> +
> +		/* WSA2 */
> +		swr4: soundwire-controller@31f0000 {
> +			compatible = "qcom,soundwire-v1.7.0";
> +			reg = <0 0x031f0000 0 0x2000>;
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
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			#sound-dai-cells = <1>;
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
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&rx_swr_active>;
> +			#sound-dai-cells = <1>;
> +		};
> +
> +		swr1: soundwire-controller@3210000 {
> +			compatible = "qcom,soundwire-v1.7.0";
> +			reg = <0 0x3210000 0 0x2000>;
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
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			#sound-dai-cells = <1>;
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
> +					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +			assigned-clock-rates = <19200000>, <19200000>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "mclk";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&tx_swr_active>;
> +			#sound-dai-cells = <1>;
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
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wsa_swr_active>;
> +			#sound-dai-cells = <1>;
> +		};
> +
> +		/* WSA */
> +		swr0: soundwire-controller@3250000 {
> +			compatible = "qcom,soundwire-v1.7.0";
> +			reg = <0 0x03250000 0 0x2000>;
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
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			#sound-dai-cells = <1>;
> +		};
> +
> +		swr2: soundwire-controller@33b0000 {
> +			compatible = "qcom,soundwire-v1.7.0";
> +			reg = <0 0x33b0000 0 0x2000>;
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
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x01 0x02 0x00 0x00>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			#sound-dai-cells = <1>;
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
>  		remoteproc_adsp: remoteproc@30000000 {
>  			compatible = "qcom,sm8450-adsp-pas";
>  			reg = <0 0x30000000 0 0x100>;
> @@ -3023,6 +3227,91 @@ qup_uart20_default: qup-uart20-default-state {
>  
>  		};
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
>  		apps_smmu: iommu@15000000 {
>  			compatible = "qcom,sm8450-smmu-500", "arm,mmu-500";
>  			reg = <0 0x15000000 0 0x100000>;
> @@ -3501,6 +3790,9 @@ lpass_ag_noc: interconnect@3c40000 {
>  		};
>  	};
>  
> +	sound: sound {
> +	};
> +
>  	thermal-zones {
>  		aoss0-thermal {
>  			polling-delay-passive = <0>;
