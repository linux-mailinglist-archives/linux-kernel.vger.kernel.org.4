Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E36199E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiKDO3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiKDO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:29:28 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD5D275C4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:27:31 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l2so3086629qtq.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cx3NTEqeUFpYJivEyjqIc/bhKECFkt0KraO+zyCwmsY=;
        b=PHBSDYyL/GjLD/mSm4pzpvNS8RKR4x6/OlRjRhj9dEpx0pPqZDRSvOmBOZifVakovR
         Trnq3r+RJtsNDP/NGegpV94Q1qVrXKBM125kUi2/6TB3r7brpIFaLQHTzVHiiBAfbsPY
         mo/pqPplLxqAiG8XAsg4KLAyHI8OALs+S1PJVtCEftlKdLN9cmuKep2DHO/fHBQiHZ4j
         bj0LDYR3PSNrgGcITNaZw3HYlJ1yABLronHo8Ksz8It7DwIjl1VcxsRyfeguj3hQDqvq
         wnFU5qLSN5/tiYk5bq4dkrsBz+Tza99hnd8A5rqzsDr8Z3jNf9PtL547oHxmtwnXqUhT
         xHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cx3NTEqeUFpYJivEyjqIc/bhKECFkt0KraO+zyCwmsY=;
        b=zO42OXxURT+qk9aaQqnTNBYte0XR4xiKn4sCJ5T24/lDU2kM3JL2r1ytAznM1q5SW8
         YQGYlI82Rv4HfnPgoFzW94VHfgW0Lp0sHEz/7NJ4UU568cStpPJtLqZ9oTMCJK/ZX7xH
         znTBjzW5/72kbjKrj5sbiScEAip6MbdpSWA9L+TZmM3LBGaO7OpDkMuCyTVULVEWxFY1
         tay64ZA5atzPmBW/CGl+/p8CT+aeYDAHlZkll/W1UOLCiEI5NGnteYup9+3IJBWm2H2e
         q0nJc4wRt95NhvqaGJbD3JCkOzQdiDDyhCTkBM+bhlLZr2MTA6ZNypju2YuNEij86I3m
         LYnA==
X-Gm-Message-State: ACrzQf1rl8vdTP+dwUN4jJZQMD+yOwq9tfsFbk3ABuWpWdPmtf4czg4Y
        doPk2w9hZXb+LNYxxiLYVjUZSw==
X-Google-Smtp-Source: AMsMyM53/NKYT5NpP0tVfmwheInAWb9437rfiqvE2Gr/WvlAczq/97CEQdr9nE5EeNegVI5fFfklPg==
X-Received: by 2002:ac8:5f93:0:b0:394:13a:8ffe with SMTP id j19-20020ac85f93000000b00394013a8ffemr28928735qta.9.1667572050808;
        Fri, 04 Nov 2022 07:27:30 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id v20-20020a05622a189400b003a540320070sm2663198qtc.6.2022.11.04.07.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:27:30 -0700 (PDT)
Message-ID: <80097bdc-37eb-052a-8f32-47e4794bd425@linaro.org>
Date:   Fri, 4 Nov 2022 10:27:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 4/4] arm64: dts: qcom: sc7280: add
 sc7280-herobrine-audio-rt5682-3mic3.dtsi for evoker
Content-Language: en-US
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221104061941.2739938-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221104141515.v10.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104141515.v10.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
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

On 04/11/2022 02:19, Sheng-Liang Pan wrote:
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
>  .../sc7280-herobrine-audio-rt5682-3mic.dtsi   | 194 ++++++++++++++++++
>  .../boot/dts/qcom/sc7280-herobrine-evoker.dts |   2 +
>  2 files changed, 196 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
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

No need.

> +		audio-routing =

No need for line break.

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

Status is the last property.

> +	clock-frequency = <400000>;
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

Status is the last property.

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

Status is the last property.



Best regards,
Krzysztof

