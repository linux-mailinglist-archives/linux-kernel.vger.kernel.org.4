Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479286193AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiKDJiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKDJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:38:10 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DB326552
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:38:09 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D30873EEDF;
        Fri,  4 Nov 2022 10:38:06 +0100 (CET)
Message-ID: <0060c22a-0dfe-40bf-c877-7fb86c97872b@somainline.org>
Date:   Fri, 4 Nov 2022 10:38:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v10 4/4] arm64: dts: qcom: sc7280: add
 sc7280-herobrine-audio-rt5682-3mic3.dtsi for evoker
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221104061941.2739938-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221104141515.v10.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221104141515.v10.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 07:19, Sheng-Liang Pan wrote:
> add specific 3mic setting as sc7280-herobrine-audio-rt5682-3mic.dtsi,
> so we can include sc7280-herobrine-audio-rt5682-3mic.dtsi for evoker
> as it uses rt5682 with 3 mics.
>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
>
> Changes in v10:
> - add evoker include specific sc7280-herobrine-audio-rt5682-3mic.dtsi setting
>
>   .../sc7280-herobrine-audio-rt5682-3mic.dtsi   | 194 ++++++++++++++++++
>   .../boot/dts/qcom/sc7280-herobrine-evoker.dts |   2 +
>   2 files changed, 196 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
> new file mode 100644
> index 0000000000000..01bc8ee93b19a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
> @@ -0,0 +1,194 @@
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
> +		status = "okay";

I don't see it being disabled anywhere, probably can drop this line.


> +		audio-routing =
> +			"VA DMIC0", "vdd-micb",
> +			"VA DMIC1", "vdd-micb",
> +			"VA DMIC2", "vdd-micb",
> +			"VA DMIC3", "vdd-micb",
> +
> +			"Headphone Jack", "HPOL",
> +			"Headphone Jack", "HPOR";
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
> +	status = "okay";
> +	clock-frequency = <400000>;

Status last in all nodes, please.


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
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mi2s0_data0>, <&mi2s0_data1>, <&mi2s0_mclk>, <&mi2s0_sclk>, <&mi2s0_ws>,
> +			<&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
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
> +	status = "okay";
> +	vdd-micb-supply = <&pp1800_l2c>;
> +	pinctrl-0 = <&lpass_dmic01_clk>, <&lpass_dmic01_data>, <&lpass_dmic23_clk>,
> +			<&lpass_dmic23_data>;
> +};
> +
> +&mi2s0_data0 {

Keep the node references sorted alphabetically, please.


Konrad

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
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> index dcdd4eecfe670..d608682f9742b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dts
> @@ -8,6 +8,8 @@
>   /dts-v1/;
>   
>   #include "sc7280-herobrine-evoker.dtsi"
> +#include "sc7280-herobrine-audio-rt5682-3mic.dtsi"
> +
>   
>   / {
>   	model = "Google Evoker";
