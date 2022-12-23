Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FE2654E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiLWJIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbiLWJIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:08:46 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20D81C403
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:08:43 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 1so6344474lfz.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7cF5JUH51zVHVlPOLsK2nJvYEtOSVvrKIi1yyd2e7E=;
        b=lbMRs9m4Hdtm7MzHQLvmKZFnUxvOsyYy1rz1k5k62x8Hkf6beO/SqwvrvIl3Mw13ii
         ZHbAGpVoMCAFyPJqj1NlNuRkxJsoIHy6mnNCSp1BiinSZSxD5jTHClzNOw7PqWW7zq4h
         eiCHC9572q/rnR7ONlW9zV1uhit8x9ErZU/AUB12TrNHodcF105zEU4S9R3puGxmDfzP
         6V0F01oX49DjzVAoDkPReTqkCm/+je8QX7w6zbjcA4SElBS24H2tsG8jML4MpAKZs4aA
         zpnRgLvxJrbb5AiHuxug318Tf49pu6MfAOP3G3EtI+FGIkW87o7L630JpI7R35GpW6kE
         EAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7cF5JUH51zVHVlPOLsK2nJvYEtOSVvrKIi1yyd2e7E=;
        b=GSKnFc3ZUWZ+Ts3AE2Tj4/IUeh6g6g+Wzf+LXEhoWsD3zDwZ+Is+edgyCqP2ZcipcX
         8pxAybteHqRzMvVnMGdsXHlVIAZxavUKzY05wvG0gt2GCOTjWFIkuLFYkz86KDKxfi1l
         3uDgmZK5P95nqC0/kxZWE4ZQIoRSCPHmigm4I3DbQR/5Z3f/tk3hg6fY7n+KrvHDNvru
         hcsPbRGmeTNA9CpNLhA4LijhT5fx+714TjUYW0DZC8mFnvCjS5pwVPQwddNsDYH8in93
         +KkxBvYhYFpvaJDvamv2If4HsrLjRXhZHtuMH0sfZNKaYyOUDulY1XG5N/HXp5rR24h3
         FoPw==
X-Gm-Message-State: AFqh2ko/aLbALL51JZCIHcdxe4BOwLvGq3dJ3oVUkKpEL1ySEcPTeRbe
        nSq8WkRS6S3HCrXWMvOLaY/k2Q==
X-Google-Smtp-Source: AMrXdXshjK45LD383xnMyQqPQ7Mw0nzMDgiMAe1dQJfsUE1wXTsvHdcfXdDTbYCXlllamDDSpbEx3g==
X-Received: by 2002:a05:6512:3b20:b0:4b5:178f:a14c with SMTP id f32-20020a0565123b2000b004b5178fa14cmr3092978lfv.16.1671786522290;
        Fri, 23 Dec 2022 01:08:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l18-20020ac24312000000b00485caa0f5dfsm449101lfh.44.2022.12.23.01.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 01:08:41 -0800 (PST)
Message-ID: <df7dd4aa-1a6c-51a6-d7e5-b313d986c64a@linaro.org>
Date:   Fri, 23 Dec 2022 10:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/7] arm64: dts: qcom: sc7280: audioreach: Add sound node
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        konrad.dybcio@linaro.org
References: <1671702170-24781-1-git-send-email-quic_srivasam@quicinc.com>
 <1671702170-24781-3-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1671702170-24781-3-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 10:42, Srinivasa Rao Mandadapu wrote:
> Add sound node for sc7280 based audioreach platforms.
> 
> Include audioreach dtsi into crd-rev3 platform specific dts file.
> Also remove phandle to sound node, as audio routing is same as
> audioreach specific dtsi file.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts         |  25 +----
>  .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 112 +++++++++++++++++++++
>  2 files changed, 113 insertions(+), 24 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> index b024626..aea8cbd 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> @@ -8,7 +8,7 @@
>  /dts-v1/;
>  
>  #include "sc7280-idp.dtsi"
> -#include "sc7280-audio-idp.dtsi"
> +#include "sc7280-herobrine-audioreach-wcd9385.dtsi"
>  #include "sc7280-idp-ec-h1.dtsi"
>  
>  / {
> @@ -88,29 +88,6 @@ ap_ts_pen_1v8: &i2c13 {
>  	pins = "gpio51";
>  };
>  
> -&sound {
> -	audio-routing =
> -		"IN1_HPHL", "HPHL_OUT",
> -		"IN2_HPHR", "HPHR_OUT",
> -		"AMIC1", "MIC BIAS1",
> -		"AMIC2", "MIC BIAS2",
> -		"VA DMIC0", "MIC BIAS1",
> -		"VA DMIC1", "MIC BIAS1",
> -		"VA DMIC2", "MIC BIAS3",
> -		"VA DMIC3", "MIC BIAS3",
> -		"TX SWR_ADC0", "ADC1_OUTPUT",
> -		"TX SWR_ADC1", "ADC2_OUTPUT",
> -		"TX SWR_ADC2", "ADC3_OUTPUT",
> -		"TX SWR_DMIC0", "DMIC1_OUTPUT",
> -		"TX SWR_DMIC1", "DMIC2_OUTPUT",
> -		"TX SWR_DMIC2", "DMIC3_OUTPUT",
> -		"TX SWR_DMIC3", "DMIC4_OUTPUT",
> -		"TX SWR_DMIC4", "DMIC5_OUTPUT",
> -		"TX SWR_DMIC5", "DMIC6_OUTPUT",
> -		"TX SWR_DMIC6", "DMIC7_OUTPUT",
> -		"TX SWR_DMIC7", "DMIC8_OUTPUT";
> -};
> -
>  &wcd9385 {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&wcd_reset_n>, <&us_euro_hs_sel>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> new file mode 100644
> index 0000000..1eac94e1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * sc7280 device tree source for boards using Max98360 and wcd9385 codec
> + * along with ADSP
> + *
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/soc/qcom,gpr.h>
> +#include <dt-bindings/clock/qcom,lpass-sc7280.h>
> +
> +/{
> +	/* BOARD-SPECIFIC TOP LEVEL NODES */
> +	sound: sound {
> +		compatible = "google,sc7280-herobrine";
> +		model = "SC7280-AUDIOREACH";
> +		status = "okay";
> +		adsp-mode;
> +		audio-routing =
> +		   "IN1_HPHL", "HPHL_OUT",
> +		   "IN2_HPHR", "HPHR_OUT",
> +		   "AMIC1", "MIC BIAS1",
> +		   "AMIC2", "MIC BIAS2",
> +		   "VA DMIC0", "MIC BIAS1",
> +		   "VA DMIC1", "MIC BIAS1",
> +		   "VA DMIC2", "MIC BIAS3",
> +		   "VA DMIC3", "MIC BIAS3",
> +		   "TX SWR_ADC0", "ADC1_OUTPUT",
> +		   "TX SWR_ADC1", "ADC2_OUTPUT",
> +		   "TX SWR_ADC2", "ADC3_OUTPUT",
> +		   "TX SWR_DMIC0", "DMIC1_OUTPUT",
> +		   "TX SWR_DMIC1", "DMIC2_OUTPUT",
> +		   "TX SWR_DMIC2", "DMIC3_OUTPUT",
> +		   "TX SWR_DMIC3", "DMIC4_OUTPUT",
> +		   "TX SWR_DMIC4", "DMIC5_OUTPUT",
> +		   "TX SWR_DMIC5", "DMIC6_OUTPUT",
> +		   "TX SWR_DMIC6", "DMIC7_OUTPUT",
> +		   "TX SWR_DMIC7", "DMIC8_OUTPUT";
> +
> +		qcom,msm-mbhc-hphl-swh = <1>;
> +		qcom,msm-mbhc-gnd-swh = <1>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#sound-dai-cells = <0>;
> +
> +		dai-link@0 {
> +			link-name = "WCD9385 Playback";
> +			reg = <0>;
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai  RX_CODEC_DMA_RX_0>;

Just one space.

> +			};
> +			codec {
> +				sound-dai = <&wcd9385 0>, <&swr0 0>, <&lpass_rx_macro 0>;
> +			};
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		dai-link@1 {
> +			link-name = "WCD9385 Capture";
> +			reg = <1>;
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai  TX_CODEC_DMA_TX_3>;
> +			};
> +			codec {
> +				sound-dai = <&wcd9385 1>, <&swr1 0>, <&lpass_tx_macro 0>;
> +			};
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		dai-link@2 {
> +			link-name = "MAX98360A";

Amplifier playback?

> +			reg = <3>;
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai SECONDARY_MI2S_RX>;
> +			};
> +
> +			codec {
> +				sound-dai =	 <&max98360a>;

No redundant whitespaces around =.


> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +
> +		dai-link@3 {
> +			link-name = "DMIC";
> +			reg = <4>;
> +
> +			cpu {
> +				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
> +			};
> +
> +			codec {
> +				sound-dai = <&lpass_va_macro 0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +	};
> +};

Best regards,
Krzysztof

