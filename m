Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D0362843B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiKNPkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbiKNPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:40:03 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB017767E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:40:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id l12so19899047lfp.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nT6MgmNBvZWKRQFDoYARVRQ41WCdAZRAjkt/TvnRGaU=;
        b=cjmkbQ564vxesHH2AB77D897AVaKI5Ejrrdy0+4HI7NFl32fb9SIJ9l9wMSCm5qXfX
         f62rrso0vEVC5D9MMsQoZT/tZ6Mhb6vq0t71AvMkyxhM4f/Avh6Q6ofdwxT7HKB0FMTJ
         lOGtWCs6EgQoZBpw4jf1Y2XCaJTfL8+RGUFsfLZ03sPqMp0ff1WT3aSsyortAtibN3FJ
         PaPNvdkxjqwb/VzgkJTJVgZ/NNwtKBRBAcvmjBXti2wyHilvo1ovnEHV+XIOAuIvNMXf
         UY5JRp+MdYsgNhwHAbuQOIw1V+LlLOcPro80a84kvoHVGWJFFv6wH+bZfh9XrNGPmj4Y
         nilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT6MgmNBvZWKRQFDoYARVRQ41WCdAZRAjkt/TvnRGaU=;
        b=NoOG71d+lTiHpuMn64mXhQqDLow/L7OZPC52LAzrWnLQg0fnb75kMLc+DgZnbtpLfx
         G9vIAHMo1GhWuNioxvnHpiybgIICGFzoIk2gnQ0lcF2bmQs//IFTsJ9em85/43xO0dEc
         VNeBIb/MGwX0+ifzeIKXG90htaxzq2KAEkFJO/tUwEQheB9pCwpVFGLmEQbPFWbF5OJf
         6xjXLdBlQDVBkGPfl8jMcYzPPOgltYrcZLT/DMhrurShwKpch4SJQ8Qj9Y/jXW9bmQGK
         +ccLGx43gyhuozKHT5Tofv/9ktE60S8DvYNBl+2hJOW/U+aOApkm8Ac0p4Uhg4dftyGO
         +hQg==
X-Gm-Message-State: ANoB5pklXpvU2Nlw6RwDic4jbnfN4yZJvmFP5iw6Wy3PUkzP5uZb3FV4
        cv89OniPnxSLPpYbOxvuRIkVVA==
X-Google-Smtp-Source: AA0mqf6rMbuavD6VLXj06hA0/KezQJEXmLeavpaO/odyLjFvQ+qwF1ysjMMUHp97jmpFlqDSDaWkoA==
X-Received: by 2002:a05:6512:3ac:b0:4a2:25b5:a2aa with SMTP id v12-20020a05651203ac00b004a225b5a2aamr4968464lfp.531.1668440400258;
        Mon, 14 Nov 2022 07:40:00 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id o22-20020ac25e36000000b0049fbf5facf4sm1853204lfg.75.2022.11.14.07.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:39:59 -0800 (PST)
Message-ID: <f52157c7-d198-9c26-089a-c5227a1c1f4f@linaro.org>
Date:   Mon, 14 Nov 2022 16:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8450-hdk: add sound support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221114152130.385871-1-krzysztof.kozlowski@linaro.org>
 <20221114152130.385871-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221114152130.385871-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 14/11/2022 16:21, Krzysztof Kozlowski wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Add sound support to SM8450 HDK board.  Tested setup so far is only two
> speakers (working) and head-phones (only one channel working).
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 161 ++++++++++++++++++++++++
>   1 file changed, 161 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index 4d75f9db08c2..c177283b6764 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -6,6 +6,8 @@
>   /dts-v1/;
>   
>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
>   #include "sm8450.dtsi"
>   
>   / {
> @@ -421,6 +423,147 @@ &uart7 {
>   	status = "okay";
>   };
>   
> +&soc {

soc should go before uart alphabetically.


Other than that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Konrad

> +	wcd938x: codec {
> +		compatible = "qcom,wcd9380-codec";
> +
> +		qcom,micbias1-microvolt = <1800000>;
> +		qcom,micbias2-microvolt = <1800000>;
> +		qcom,micbias3-microvolt = <1800000>;
> +		qcom,micbias4-microvolt = <1800000>;
> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +		qcom,rx-device = <&wcd_rx>;
> +		qcom,tx-device = <&wcd_tx>;
> +
> +		reset-gpios = <&tlmm 43 GPIO_ACTIVE_HIGH>;
> +		#sound-dai-cells = <1>;
> +
> +		vdd-buck-supply = <&vreg_s10b_1p8>;
> +		vdd-rxtx-supply = <&vreg_s10b_1p8>;
> +		vdd-io-supply = <&vreg_s10b_1p8>;
> +		vdd-mic-bias-supply = <&vreg_bob>;
> +	};
> +};
> +
> +&sound {
> +	compatible = "qcom,sm8450-sndcard";
> +	model = "SM8450-HDK";
> +	audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
> +			"SpkrRight IN", "WSA_SPK2 OUT",
> +			"IN1_HPHL", "HPHL_OUT",
> +			"IN2_HPHR", "HPHR_OUT",
> +			"AMIC1", "MIC BIAS1",
> +			"AMIC2", "MIC BIAS2",
> +			"AMIC3", "MIC BIAS3",
> +			"AMIC4", "MIC BIAS3",
> +			"AMIC5", "MIC BIAS4";
> +
> +	wcd-playback-dai-link {
> +		link-name = "WCD Playback";
> +		cpu {
> +			sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
> +		};
> +
> +		codec {
> +			sound-dai = <&wcd938x 0>, <&swr1 0>, <&rxmacro 0>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6apm>;
> +		};
> +	};
> +
> +	wcd-playback-dai-link {
> +		link-name = "WCD Playback";
> +		cpu {
> +			sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
> +		};
> +
> +		codec {
> +			sound-dai = <&wcd938x 0>, <&swr1 0>, <&rxmacro 0>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6apm>;
> +		};
> +	};
> +
> +	wsa-dai-link {
> +		link-name = "WSA Playback";
> +		cpu {
> +			sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
> +		};
> +
> +		codec {
> +			sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&wsamacro 0>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6apm>;
> +		};
> +	};
> +
> +	va-dai-link {
> +		link-name = "VA Capture";
> +		cpu {
> +			sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6apm>;
> +		};
> +	};
> +};
> +
> +&swr0 {
> +	right_spkr: speaker@0,1{
> +		compatible = "sdw10217020200";
> +		reg = <0 1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spkr_1_sd_n_active>;
> +		powerdown-gpios = <&tlmm 1 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "SpkrRight";
> +		#thermal-sensor-cells = <0>;
> +		vdd-supply = <&vreg_s10b_1p8>;
> +	};
> +
> +	left_spkr: speaker@0,2{
> +		compatible = "sdw10217020200";
> +		reg = <0 2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spkr_2_sd_n_active>;
> +		powerdown-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "SpkrLeft";
> +		#thermal-sensor-cells = <0>;
> +		vdd-supply = <&vreg_s10b_1p8>;
> +	};
> +};
> +
> +&swr1 {
> +	status = "okay";
> +
> +	wcd_rx: codec@0,4 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 4>;
> +		qcom,rx-port-mapping = <1 2 3 4 5>;
> +	};
> +};
> +
> +&swr2 {
> +	status = "okay";
> +
> +	wcd_tx: codec@0,3 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 3>;
> +		/* ports: adc1_2, adc3_4, dmic0_3_mbhc, dmic4_7 */
> +		qcom,tx-port-mapping = <1 1 2 3>;
> +	};
> +};
> +
>   &ufs_mem_hc {
>   	status = "okay";
>   
> @@ -461,3 +604,21 @@ &usb_1_qmpphy {
>   	vdda-phy-supply = <&vreg_l6b_1p2>;
>   	vdda-pll-supply = <&vreg_l1b_0p91>;
>   };
> +
> +&tlmm {
> +	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
> +		pins = "gpio1";
> +		function = "gpio";
> +		drive-strength = <4>;
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	spkr_2_sd_n_active: spkr-2-sd-n-active-state {
> +		pins = "gpio89";
> +		function = "gpio";
> +		drive-strength = <4>;
> +		bias-disable;
> +		output-low;
> +	};
> +};
