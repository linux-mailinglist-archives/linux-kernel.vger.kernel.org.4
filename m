Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D60C648EAB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 13:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLJMbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 07:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLJMbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 07:31:37 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7722A6141
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:31:36 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a19so7684053ljk.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6R8r/VCnswD9bNbiIPd9uK6NspRqfrl1hwseDl8et58=;
        b=DQ4L2hWmrXP/0KrFothmtefJZbYb/r0ZAc9PLsTvKVvK8+rXRLpwspGHAbbIi8cpu4
         VSjFVut4D+HpN8upau3fIbyiN9xKcTArNrEISnyKeAhlQqi5ijCXfF+YYhCWFK+Ie3Xo
         NUT8hEDgzV+Qik5myxtCLLTE+DdBXiS0vHXD1nsIzgNVmTmDRkOFtcw8eXZTW1VjOPF7
         tB6vNLm4Ta5KfhXzjomqzmtL3eEztdGTQu3j6H/9uYmD992e+MeDvGM2F2fdlEUqOoPQ
         6IwqZkyqujxsWULV4u4WEOn1u5PRaL6rdtVFrPyhuiW+gK9kSDPxs8TOGxt7jbEXRoNL
         tRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6R8r/VCnswD9bNbiIPd9uK6NspRqfrl1hwseDl8et58=;
        b=6HQFyIkEACytwsQjVz5mofYRkAlIOshs1UHHlfBRzvlBI2ZGDGIDBhYqqhX10JcZUI
         2wtO1InduHXStYrFcwCiWwWH+hm6vfz7YHa5kMAj+ZzXjj7Y04cI4mjqQAFJ3gME3/fg
         BaGxS4oW5iY3iC81dOzBKd8TO0N4XiE8uQxt/Lkw1P2GADazddt+wEBMLClYkhtPnYYK
         qLWqE5iW6os3CgoAFaRX1OK6i1SiVdQ+JgCxFwT0l1aXjbPpk3m3afQ7Mvbyhh06SFZe
         8AmGSWbD07XW1vT2sTIjGXCzxvwfk2atBARMv/Elo6WNl2lrDCcuI54CuWqguT1cyy0L
         Qazg==
X-Gm-Message-State: ANoB5pn/HW87FQ7XK5G3S3GWQoIx8/uYbO9R2rZhbAl6vKntfQtHTYbp
        cQ4w24FJNNben6XYpobVf7vzJPz+HqzW/fwX
X-Google-Smtp-Source: AA0mqf6zQLudSfVoP+2ESlC9qRg45Z0hawTwkJbBvY4gjggHy74NHpNZMLavCGj6eOdmtmbHGDRyPw==
X-Received: by 2002:a2e:9d8b:0:b0:279:f30f:78db with SMTP id c11-20020a2e9d8b000000b00279f30f78dbmr2275693ljj.44.1670675494844;
        Sat, 10 Dec 2022 04:31:34 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id h9-20020a2e9ec9000000b0027738fd1eb6sm574877ljk.110.2022.12.10.04.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 04:31:34 -0800 (PST)
Message-ID: <f1aa7f4c-35e4-47d2-2443-8271175dc5af@linaro.org>
Date:   Sat, 10 Dec 2022 13:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8250: move sound and codec nodes
 out of soc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
 <20221210115704.97614-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221210115704.97614-4-krzysztof.kozlowski@linaro.org>
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



On 10.12.2022 12:57, Krzysztof Kozlowski wrote:
> The sound and codec nodes are not a property of a soc, but rather board
> as it describes the sound configuration.
* in this case, there exist SoC-internal codecs

 It also does not have unit
> address:
> 
>   sm8250-hdk.dtb: soc@0: sound: {} should not be valid under {'type': 'object'}
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 ++++++++++++-------------
>  arch/arm64/boot/dts/qcom/sm8250.dtsi    |  6 ++--
>  2 files changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> index 3ed8c84e25b8..b741b7da1afc 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> @@ -27,6 +27,25 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	wcd938x: codec {
> +		compatible = "qcom,wcd9380-codec";
> +		#sound-dai-cells = <1>;
> +		reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
> +		vdd-buck-supply = <&vreg_s4a_1p8>;
> +		vdd-rxtx-supply = <&vreg_s4a_1p8>;
> +		vdd-io-supply = <&vreg_s4a_1p8>;
> +		vdd-mic-bias-supply = <&vreg_bob>;
> +		qcom,micbias1-microvolt = <1800000>;
> +		qcom,micbias2-microvolt = <1800000>;
> +		qcom,micbias3-microvolt = <1800000>;
> +		qcom,micbias4-microvolt = <1800000>;
> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +		qcom,rx-device = <&wcd_rx>;
> +		qcom,tx-device = <&wcd_tx>;
> +	};
> +
>  	thermal-zones {
>  		camera-thermal {
>  			polling-delay-passive = <0>;
> @@ -631,27 +650,6 @@ &slpi {
>  	firmware-name = "qcom/sm8250/slpi.mbn";
>  };
>  
> -&soc {
> -	wcd938x: codec {
> -		compatible = "qcom,wcd9380-codec";
> -		#sound-dai-cells = <1>;
> -		reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
> -		vdd-buck-supply = <&vreg_s4a_1p8>;
> -		vdd-rxtx-supply = <&vreg_s4a_1p8>;
> -		vdd-io-supply = <&vreg_s4a_1p8>;
> -		vdd-mic-bias-supply = <&vreg_bob>;
> -		qcom,micbias1-microvolt = <1800000>;
> -		qcom,micbias2-microvolt = <1800000>;
> -		qcom,micbias3-microvolt = <1800000>;
> -		qcom,micbias4-microvolt = <1800000>;
> -		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> -		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> -		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> -		qcom,rx-device = <&wcd_rx>;
> -		qcom,tx-device = <&wcd_tx>;
> -	};
> -};
> -
>  &sound {
>  	compatible = "qcom,sm8250-sndcard";
>  	model = "SM8250-MTP-WCD9380-WSA8810-VA-DMIC";
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index d517d6a80bdc..fbbbae29e0c2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2826,9 +2826,6 @@ compute-cb@8 {
>  			};
>  		};
>  
> -		sound: sound {
> -		};
> -
>  		usb_1_hsphy: phy@88e3000 {
>  			compatible = "qcom,sm8250-usb-hs-phy",
>  				     "qcom,usb-snps-hs-7nm-phy";
> @@ -4910,6 +4907,9 @@ cpufreq_hw: cpufreq@18591000 {
>  		};
>  	};
>  
> +	sound: sound {
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <GIC_PPI 13
