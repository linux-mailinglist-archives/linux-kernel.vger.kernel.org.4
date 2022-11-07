Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2ED61EFD9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiKGKCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiKGKCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:02:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BAD186EA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:02:12 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v17so16668988edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiQSO7tk3ZBgaLRJVuX75TA/mL2Uw97YBIuCXfGO8DA=;
        b=VcUwTcK66r2spxjNhyn5wwm92gTtVclULlo55dRstmiurMuMFmhbzPJBZIPT3Wdyhx
         23Xo8WfeM+5gP8s1swjJTiVahKh75D5Ts8y9gGRMEnBt4Xp7skeV5hOdXgfjD7va6LHR
         qGBG/5ifV+hd6ykGw7XBcGmzU7v/6vIM5kpxVZNkXXhkXCwcyUU54TEO1vzohPSZH39d
         nxLN0kBkBl09NCcm7I6VpWtp1MpCDn5R4qr3oe6RFdMeANIhwv98BVpJBkUe8g89w9N9
         yluieuEJuPJMvYJLn2eHwFcMx0P7/bbr6M/hJ7U69rD1qqQZAeGWMInPiuiDDNRoLXRi
         dQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UiQSO7tk3ZBgaLRJVuX75TA/mL2Uw97YBIuCXfGO8DA=;
        b=HVve+qwpTxVCr0mYW+osPD8cbT3uHON4wDB3CESwTUctDyLHUVX0fjNlztXnxsnBM7
         Q5LG8xpPIn+/6MQmeGzBvzMWX1AQgMrMwFdvAENmcIDKC2hNfZ9fi3N/zL/AhsRqgu+M
         e3IJnMu5sPbmSxtnhiEU/t39bdMe0CM4JfmGF2XLh5M2152dGM2qUtuCHaxyrHS9Xwfq
         bK16NOtxN6Rqfes27D3qAi/zfO2Qmj1/7fnnBGzP2gecG+A7UuTHPK9ZPyZghDtLZNac
         SL0mCO2dWriV/rnu7C3fVxlwD9iKcAqT7LglikOlNi3MrRDNfc03vJnwLU+xCz1Ebl6o
         qLCg==
X-Gm-Message-State: ACrzQf3yfvU1NFEdzk6O2trG1c7yMN0AX9oBATX6Mp+5xW2zWDJC54bf
        8GEOp0Nh89GI9qo0IkpPSwSwGw==
X-Google-Smtp-Source: AMsMyM6wpWtV22G+DhkYuxU31+baAQbOEhO3uzD1W7kgDJk71hdXjdIi4EXU1tMLj2mAsuZtlHHjBQ==
X-Received: by 2002:a05:6402:1348:b0:461:c056:bf65 with SMTP id y8-20020a056402134800b00461c056bf65mr49991852edw.414.1667815330822;
        Mon, 07 Nov 2022 02:02:10 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id g22-20020a50ee16000000b004616b006871sm3921111eds.82.2022.11.07.02.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:02:10 -0800 (PST)
Message-ID: <95df3efb-fb96-e11e-5cd6-10f674385367@linaro.org>
Date:   Mon, 7 Nov 2022 11:02:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v11 4/5] arm64: dts: qcom: sc7280: add
 sc7280-herobrine-audio-rt5682-3mic3.dtsi for evoker
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221107094345.2838931-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221107173954.v11.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221107173954.v11.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
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



On 07/11/2022 10:43, Sheng-Liang Pan wrote:
> add specific 3mic setting as sc7280-herobrine-audio-rt5682-3mic.dtsi,
> so we can include sc7280-herobrine-audio-rt5682-3mic.dtsi for evoker
> as it uses rt5682 with 3 mics.
> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes in v11:
> - sort out the "Status" property with sc7280-herobrine-audio-rt5682-3mic.dtsi
> 
> Changes in v10:
> - add evoker include specific sc7280-herobrine-audio-rt5682-3mic.dtsi setting
> 
>   .../sc7280-herobrine-audio-rt5682-3mic.dtsi   | 195 ++++++++++++++++++
>   .../boot/dts/qcom/sc7280-herobrine-evoker.dts |   1 +
>   2 files changed, 196 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
> new file mode 100644
> index 0000000000000..cf34334451d6b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + *
> + * This file defines the common audio settings for the child boards
> + * using rt5682 codec and having 3 dmics connected to sc7280.
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/ {
> +	/* BOARD-SPECIFIC TOP LEVEL NODES */
> +	sound: sound {
> +		compatible = "google,sc7280-herobrine";
> +		model = "sc7280-rt5682-max98360a-3mic";
> +
> +		audio-routing =	"VA DMIC0", "vdd-micb",
> +				"VA DMIC1", "vdd-micb",
> +				"VA DMIC2", "vdd-micb",
> +				"VA DMIC3", "vdd-micb",
> +
> +				"Headphone Jack", "HPOL",
> +				"Headphone Jack", "HPOR";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		dai-link@0 {
> +			link-name = "MAX98360";
> +			reg = <0>;
> +
> +			cpu {
> +				sound-dai = <&lpass_cpu MI2S_SECONDARY>;
> +			};
> +
> +			codec {
> +				sound-dai = <&max98360a>;
> +			};
> +		};
> +
> +		dai-link@1 {
> +			link-name = "DisplayPort";
> +			reg = <1>;
> +
> +			cpu {
> +				sound-dai = <&lpass_cpu LPASS_DP_RX>;
> +			};
> +
> +			codec {
> +				sound-dai = <&mdss_dp>;
> +			};
> +		};
> +
> +		dai-link@2 {
> +			link-name = "ALC5682";
> +			reg = <2>;
> +
> +			cpu {
> +				sound-dai = <&lpass_cpu MI2S_PRIMARY>;
> +			};
> +
> +			codec {
> +				sound-dai = <&alc5682 0 /* aif1 */>;
> +			};
> +		};
> +
> +		dai-link@4 {
> +			link-name = "DMIC";
> +			reg = <4>;
> +
> +			cpu {
> +				sound-dai = <&lpass_cpu LPASS_CDC_DMA_VA_TX0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&lpass_va_macro 0>;
> +			};
> +		};
> +	};
> +};
> +
> +hp_i2c: &i2c2 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	alc5682: codec@1a {
> +		compatible = "realtek,rt5682s";
> +		reg = <0x1a>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hp_irq>;
> +
> +		#sound-dai-cells = <1>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <101 IRQ_TYPE_EDGE_BOTH>;
> +
> +		AVDD-supply = <&pp1800_alc5682>;
> +		MICVDD-supply = <&pp3300_codec>;
> +
> +		realtek,dmic1-data-pin = <1>;
> +		realtek,dmic1-clk-pin = <2>;
> +		realtek,jd-src = <1>;
> +		realtek,dmic-clk-rate-hz = <2048000>;
> +	};
> +};
> +
> +&lpass_cpu {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mi2s0_data0>, <&mi2s0_data1>, <&mi2s0_mclk>, <&mi2s0_sclk>, <&mi2s0_ws>,
> +			<&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	status = "okay";
> +
> +	dai-link@0 {
> +		reg = <MI2S_PRIMARY>;
> +		qcom,playback-sd-lines = <1>;
> +		qcom,capture-sd-lines = <0>;
> +	};
> +
> +	dai-link@1 {
> +		reg = <MI2S_SECONDARY>;
> +		qcom,playback-sd-lines = <0>;
> +	};
> +
> +	dai-link@5 {
> +		reg = <LPASS_DP_RX>;
> +	};
> +
> +	dai-link@25 {
> +		reg = <LPASS_CDC_DMA_VA_TX0>;
> +	};
> +};
> +
> +&lpass_va_macro {
> +	vdd-micb-supply = <&pp1800_l2c>;
> +	pinctrl-0 = <&lpass_dmic01_clk>, <&lpass_dmic01_data>, <&lpass_dmic23_clk>,
> +			<&lpass_dmic23_data>;
> +
> +	status = "okay";
> +};
> +
> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
> +
> +&lpass_dmic01_clk {
> +	drive-strength = <8>;
> +	bias-disable;
> +};
> +
> +&lpass_dmic01_clk_sleep {
> +	drive-strength = <2>;
> +};
> +
> +&lpass_dmic01_data {
> +	bias-pull-down;
> +};
> +
> +&lpass_dmic23_clk {
> +	drive-strength = <8>;
> +	bias-disable;
> +};
> +
> +&lpass_dmic23_clk_sleep {
> +	drive-strength = <2>;
> +};
> +
> +&lpass_dmic23_data {
> +	bias-pull-down;
> +};
> +
> +&mi2s0_data0 {
> +	drive-strength = <6>;
> +	bias-disable;
> +};
> +
> +&mi2s0_data1 {
> +	drive-strength = <6>;
> +	bias-disable;
> +};
> +
> +&mi2s0_mclk {
> +	drive-strength = <6>;
> +	bias-disable;
> +};
> +
> +&mi2s0_sclk {
> +	drive-strength = <6>;
> +	bias-disable;
> +};
> +
> +&mi2s0_ws {
> +	drive-strength = <6>;
> +	bias-disable;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> index dcdd4eecfe670..51f0401b11ed7 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> @@ -8,6 +8,7 @@
>   /dts-v1/;
>   
>   #include "sc7280-herobrine-evoker.dtsi"
> +#include "sc7280-herobrine-audio-rt5682-3mic.dtsi"
>   
>   / {
>   	model = "Google Evoker";
