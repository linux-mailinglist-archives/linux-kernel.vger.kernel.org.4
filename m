Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC869674727
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjASXYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjASXYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:24:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3392A37F04
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:24:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q8so2787689wmo.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mvP+cAd7hqfutgxVUlMnflOc7xzidb88YL6WgRrDqMg=;
        b=ARP6+oi/eLFlqfNoETz+oPqKv2sA0/Xle6yb8zx6XXgKQT8wlul08+9XSxJXJwtlVq
         wA13lEoZA9bUM9FZFgBJhdv4TaXoBu/a/XWXB1B35mxR7XjddFYufZQQMtjQirxPp22z
         /ckqPdAWXFkqz6I3poEbiJ/JGPofHDptCQxcGgDXMSMoOz7zwdmR7mbU75lV8MEk1lEB
         jm8r1KGn7VTZNh99jcYJMo+D5zpUMNYHAC/c/oZAIxfdRlzCj/eaDYzi15/WFu7W1I8c
         SF6Wht9LWKV5nOMnlqmN/bfr2buhqGg5Zf1/Bx6Fhie0ucRVYd71FgPKVbbFk368CLNf
         Rs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvP+cAd7hqfutgxVUlMnflOc7xzidb88YL6WgRrDqMg=;
        b=dUNGJ4qTsNFae6ow7tdolY+MdbHgSLmb0Vg/Hk9mCDI/M6UXU6BW7asd6iad28K7oS
         HhZt2tx9Seedq7ADBNUueMbMatWJO4ywxyaHQs6I/MPzZoj6wuo3hP5Ayrc0YE1VNBhC
         SGFcK/gwBS3+Rq7UIQ+Iw+P1wvJGhpPMU0hW2jrPZas4lBbjrt9DMokovANeubItNV8l
         k5ZNkAsxauc5HWzjgaVh2D6lT0NPouRLLxW08CFkowb4gT/EKNX8jcsCcl4D7Quo8R5/
         5nVczPKt72nASw8j5MbkN2ukXEhbyPl6MTL/Wtzc0jtg6mTmx6CPl/7LhnEs8Mk0yQ4A
         NrtA==
X-Gm-Message-State: AFqh2ko7dM2d8YRqXy7k+1ULQZjJ4LMFa5STLYb3SQs3xTqtK2k3KQxr
        8ZEGSEJy/1AePPyM+k8dxUlALA==
X-Google-Smtp-Source: AMrXdXuLbELwbnjxiNRumFgelDvnJ41KcIKBn8UJLczIupzLNP1N77LHkY4MzA/1pZoT39jTVZtaOg==
X-Received: by 2002:a05:600c:4928:b0:3d3:4aa6:4fe6 with SMTP id f40-20020a05600c492800b003d34aa64fe6mr12107930wmp.3.1674170658631;
        Thu, 19 Jan 2023 15:24:18 -0800 (PST)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c2cad00b003cfa622a18asm621282wmc.3.2023.01.19.15.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 15:24:18 -0800 (PST)
Message-ID: <46acf2f4-3272-c33d-887f-05d4f4aad4d7@linaro.org>
Date:   Thu, 19 Jan 2023 23:24:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFT PATCH v2 4/6] arm64: dts: qcom: sdm845: move audio to
 separate file
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20230118103458.107434-1-krzysztof.kozlowski@linaro.org>
 <20230118103458.107434-4-krzysztof.kozlowski@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230118103458.107434-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2023 10:34, Krzysztof Kozlowski wrote:
> Re-organize SDM845 sound components into separate, audio DTSI which
> should be included and customized by the SDM845 boards wanting audio.
> The DTSI includes:
> 1. WCD9340 codec node because it is not a property of the SoC, but board.
> 2. Common sound DAI links, shared with all sound cards.

Hi Krzysztof,

I know I already reported this on IRC, I thought I'd duplicate the info
here for completeness sake.

Due to how the sound node is parsed the device numbers in alsa are
derived from the index of the sound/mmX-dai-link child nodes.

For boards which use more than 3 FE's this causes breaking changes in
userspace, as the slim-dai-link and slimcap-dai-link nodes now come
before the other mmX-dai-link nodes, for example with my OnePlus 6
patches "aplay -l" shows:

card 0: O6 [OnePlus 6], device 0: MultiMedia1 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: O6 [OnePlus 6], device 1: MultiMedia2 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: O6 [OnePlus 6], device 2: MultiMedia3 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: O6 [OnePlus 6], device 5: MultiMedia4 (*) [] <-- 5 instead of 3
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: O6 [OnePlus 6], device 6: MultiMedia5 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: O6 [OnePlus 6], device 7: MultiMedia6 (*) []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

This breaks the UCM configs shipped by postmarketOS and Mobian - though
none of it is "upstream".

Would it be reasonable to add all 6 FE DAI's and then disable the unused
ones on a per-board basis?

> 
> The Xiaomi Polaris, although includes WCD9340 codec, it lacks sound
> node, so it stays disabled.
> 
> On all others boards not using audio, keep the Slimbus node disabled as
> it is empty.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Move also sound node.
> 2. Rewrite commit msg.
> 
> RFC - please kindly test the boards.
> ---
>  .../boot/dts/qcom/sdm845-audio-wcd9340.dtsi   | 125 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  55 +-------
>  .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  53 +-------
>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |   1 +
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  60 +--------
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  59 ++-------
>  .../boot/dts/qcom/sdm850-samsung-w737.dts     |  60 ++-------
>  7 files changed, 151 insertions(+), 262 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> new file mode 100644
> index 000000000000..0a94fde6741d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SDM845 SoC device tree source
> + *
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +&slim {
> +	status = "okay";
> +
> +	slim@1 {
> +		reg = <1>;
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		wcd9340_ifd: ifd@0,0 {
> +			compatible = "slim217,250";
> +			reg = <0 0>;
> +		};
> +
> +		wcd9340: codec@1,0 {
> +			compatible = "slim217,250";
> +			reg = <1 0>;
> +			slim-ifc-dev = <&wcd9340_ifd>;
> +
> +			#sound-dai-cells = <1>;
> +
> +			interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			#clock-cells = <0>;
> +			clock-frequency = <9600000>;
> +			clock-output-names = "mclk";
> +			qcom,micbias1-microvolt = <1800000>;
> +			qcom,micbias2-microvolt = <1800000>;
> +			qcom,micbias3-microvolt = <1800000>;
> +			qcom,micbias4-microvolt = <1800000>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			wcdgpio: gpio-controller@42 {
> +				compatible = "qcom,wcd9340-gpio";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x42 0x2>;
> +			};
> +
> +			swm: swm@c85 {
> +				compatible = "qcom,soundwire-v1.3.0";
> +				reg = <0xc85 0x40>;
> +				interrupts-extended = <&wcd9340 20>;
> +
> +				qcom,dout-ports = <6>;
> +				qcom,din-ports = <2>;
> +				qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1f 0x3f 0x7 0x1f 0x3f 0x0f 0x0f>;
> +				qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x6 0x12 0x0d 0x07 0x0a>;
> +				qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1f 0x00 0x00 0x1f 0x00 0x00>;
> +
> +				#sound-dai-cells = <1>;
> +				clocks = <&wcd9340>;
> +				clock-names = "iface";
> +				#address-cells = <2>;
> +				#size-cells = <0>;
> +			};
> +		};
> +	};
> +};
> +
> +&sound {
> +	compatible = "qcom,sdm845-sndcard";
> +	status = "disabled";
> +
> +	mm1-dai-link {
> +		link-name = "MultiMedia1";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +		};
> +	};
> +
> +	mm2-dai-link {
> +		link-name = "MultiMedia2";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
> +		};
> +	};
> +
> +	mm3-dai-link {
> +		link-name = "MultiMedia3";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
> +		};
> +	};
> +
> +	sound_slim_dai_link: slim-dai-link {
> +		link-name = "SLIM Playback";
> +		cpu {
> +			sound-dai = <&q6afedai SLIMBUS_0_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +
> +		codec {
> +			sound-dai = <&wcd9340 0>;
> +		};
> +	};
> +
> +	slimcap-dai-link {
> +		link-name = "SLIM Capture";
> +		cpu {
> +			sound-dai = <&q6afedai SLIMBUS_0_TX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +
> +		codec {
> +			sound-dai = <&wcd9340 1>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 4833e89affc2..11b0554a6aea 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
>  
> @@ -726,27 +727,7 @@ &quat_mi2s_sd2_active
>  		"MM_DL2",  "MultiMedia2 Playback",
>  		"MM_DL4",  "MultiMedia4 Playback",
>  		"MultiMedia3 Capture", "MM_UL3";
> -
> -	mm1-dai-link {
> -		link-name = "MultiMedia1";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
> -		};
> -	};
> -
> -	mm2-dai-link {
> -		link-name = "MultiMedia2";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
> -		};
> -	};
> -
> -	mm3-dai-link {
> -		link-name = "MultiMedia3";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
> -		};
> -	};
> +	status = "okay";
>  
>  	mm4-dai-link {
>  		link-name = "MultiMedia4";
> @@ -769,35 +750,11 @@ codec {
>  			sound-dai = <&lt9611_codec 0>;
>  		};
>  	};
> +};
>  
> -	slim-dai-link {
> -		link-name = "SLIM Playback";
> -		cpu {
> -			sound-dai = <&q6afedai SLIMBUS_0_RX>;
> -		};
> -
> -		platform {
> -			sound-dai = <&q6routing>;
> -		};
> -
> -		codec {
> -			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
> -		};
> -	};
> -
> -	slimcap-dai-link {
> -		link-name = "SLIM Capture";
> -		cpu {
> -			sound-dai = <&q6afedai SLIMBUS_0_TX>;
> -		};
> -
> -		platform {
> -			sound-dai = <&q6routing>;
> -		};
> -
> -		codec {
> -			sound-dai = <&wcd9340 1>;
> -		};
> +&sound_slim_dai_link {
> +	codec {
> +		sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
>  	};
>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index 5de8b4c372fc..54eabacdc031 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
>  
> @@ -384,57 +385,7 @@ &sound {
>  		"AMIC1", "MIC BIAS1",
>  		"AMIC2", "MIC BIAS2",
>  		"AMIC3", "MIC BIAS3";
> -
> -	mm1-dai-link {
> -		link-name = "MultiMedia1";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
> -		};
> -	};
> -
> -	mm2-dai-link {
> -		link-name = "MultiMedia2";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
> -		};
> -	};
> -
> -	mm3-dai-link {
> -		link-name = "MultiMedia3";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
> -		};
> -	};
> -
> -	slim-dai-link {
> -		link-name = "SLIM Playback";
> -		cpu {
> -			sound-dai = <&q6afedai SLIMBUS_0_RX>;
> -		};
> -
> -		platform {
> -			sound-dai = <&q6routing>;
> -		};
> -
> -		codec {
> -			sound-dai = <&wcd9340 0>;
> -		};
> -	};
> -
> -	slimcap-dai-link {
> -		link-name = "SLIM Capture";
> -		cpu {
> -			sound-dai = <&q6afedai SLIMBUS_0_TX>;
> -		};
> -
> -		platform {
> -			sound-dai = <&q6routing>;
> -		};
> -
> -		codec {
> -			sound-dai = <&wcd9340 1>;
> -		};
> -	};
> +	status = "okay";
>  };
>  
>  &tlmm {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index a80c3dd9a2da..f81619c8a3ba 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
>  #include "pm8005.dtsi"
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0f1cb2c8addd..27d1917f5358 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3831,65 +3831,7 @@ slim: slim-ngd@171c0000 {
>  			iommus = <&apps_smmu 0x1806 0x0>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -
> -			slim@1 {
> -				reg = <1>;
> -				#address-cells = <2>;
> -				#size-cells = <0>;
> -
> -				wcd9340_ifd: ifd@0,0 {
> -					compatible = "slim217,250";
> -					reg = <0 0>;
> -				};
> -
> -				wcd9340: codec@1,0 {
> -					compatible = "slim217,250";
> -					reg = <1 0>;
> -					slim-ifc-dev = <&wcd9340_ifd>;
> -
> -					#sound-dai-cells = <1>;
> -
> -					interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
> -					interrupt-controller;
> -					#interrupt-cells = <1>;
> -
> -					#clock-cells = <0>;
> -					clock-frequency = <9600000>;
> -					clock-output-names = "mclk";
> -					qcom,micbias1-microvolt = <1800000>;
> -					qcom,micbias2-microvolt = <1800000>;
> -					qcom,micbias3-microvolt = <1800000>;
> -					qcom,micbias4-microvolt = <1800000>;
> -
> -					#address-cells = <1>;
> -					#size-cells = <1>;
> -
> -					wcdgpio: gpio-controller@42 {
> -						compatible = "qcom,wcd9340-gpio";
> -						gpio-controller;
> -						#gpio-cells = <2>;
> -						reg = <0x42 0x2>;
> -					};
> -
> -					swm: swm@c85 {
> -						compatible = "qcom,soundwire-v1.3.0";
> -						reg = <0xc85 0x40>;
> -						interrupts-extended = <&wcd9340 20>;
> -
> -						qcom,dout-ports = <6>;
> -						qcom,din-ports = <2>;
> -						qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1f 0x3f 0x7 0x1f 0x3f 0x0f 0x0f>;
> -						qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x6 0x12 0x0d 0x07 0x0a>;
> -						qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1f 0x00 0x00 0x1f 0x00 0x00>;
> -
> -						#sound-dai-cells = <1>;
> -						clocks = <&wcd9340>;
> -						clock-names = "iface";
> -						#address-cells = <2>;
> -						#size-cells = <0>;
> -					};
> -				};
> -			};
> +			status = "disabled";
>  		};
>  
>  		lmh_cluster1: lmh@17d70800 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index d55ffd69155e..b979d8ae8698 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm850.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  
>  /*
> @@ -522,57 +523,7 @@ &sound {
>  		"MM_DL1",  "MultiMedia1 Playback",
>  		"MM_DL3",  "MultiMedia3 Playback",
>  		"MultiMedia2 Capture", "MM_UL2";
> -
> -	mm1-dai-link {
> -		link-name = "MultiMedia1";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
> -		};
> -	};
> -
> -	mm2-dai-link {
> -		link-name = "MultiMedia2";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
> -		};
> -	};
> -
> -	mm3-dai-link {
> -		link-name = "MultiMedia3";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
> -		};
> -	};
> -
> -	slim-dai-link {
> -		link-name = "SLIM Playback";
> -		cpu {
> -			sound-dai = <&q6afedai SLIMBUS_0_RX>;
> -		};
> -
> -		platform {
> -			sound-dai = <&q6routing>;
> -		};
> -
> -		codec {
> -			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
> -		};
> -	};
> -
> -	slimcap-dai-link {
> -		link-name = "SLIM Capture";
> -		cpu {
> -			sound-dai = <&q6afedai SLIMBUS_0_TX>;
> -		};
> -
> -		platform {
> -			sound-dai = <&q6routing>;
> -		};
> -
> -		codec {
> -			sound-dai = <&wcd9340 1>;
> -		};
> -	};
> +	status = "okay";
>  
>  	slim-wcd-dai-link {
>  		link-name = "SLIM WCD Playback";
> @@ -590,6 +541,12 @@ codec {
>  	};
>  };
>  
> +&sound_slim_dai_link {
> +	codec {
> +		sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
> +	};
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <0 4>, <81 4>;
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> index 6730804f4e3e..75773b06701b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm850.dtsi"
> +#include "sdm845-audio-wcd9340.dtsi"
>  #include "pm8998.dtsi"
>  
>  /*
> @@ -436,7 +437,6 @@ dai@2 {
>  };
>  
>  &sound {
> -	compatible = "qcom,sdm845-sndcard";
>  	model = "Samsung-W737";
>  
>  	audio-routing =
> @@ -447,57 +447,7 @@ &sound {
>  		"MM_DL1",  "MultiMedia1 Playback",
>  		"MM_DL3",  "MultiMedia3 Playback",
>  		"MultiMedia2 Capture", "MM_UL2";
> -
> -	mm1-dai-link {
> -		link-name = "MultiMedia1";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
> -		};
> -	};
> -
> -	mm2-dai-link {
> -		link-name = "MultiMedia2";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
> -		};
> -	};
> -
> -	mm3-dai-link {
> -		link-name = "MultiMedia3";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
> -		};
> -	};
> -
> -	slim-dai-link {
> -		link-name = "SLIM Playback";
> -		cpu {
> -			sound-dai = <&q6afedai SLIMBUS_0_RX>;
> -		};
> -
> -		platform {
> -			sound-dai = <&q6routing>;
> -		};
> -
> -		codec {
> -			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
> -		};
> -	};
> -
> -	slimcap-dai-link {
> -		link-name = "SLIM Capture";
> -		cpu {
> -			sound-dai = <&q6afedai SLIMBUS_0_TX>;
> -		};
> -
> -		platform {
> -			sound-dai = <&q6routing>;
> -		};
> -
> -		codec {
> -			sound-dai = <&wcd9340 1>;
> -		};
> -	};
> +	status = "okay";
>  
>  	slim-wcd-dai-link {
>  		link-name = "SLIM WCD Playback";
> @@ -515,6 +465,12 @@ codec {
>  	};
>  };
>  
> +&sound_slim_dai_link {
> +	codec {
> +		sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
> +	};
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <0 6>, <85 4>;
>  

-- 
Kind Regards,
Caleb (they/them)
