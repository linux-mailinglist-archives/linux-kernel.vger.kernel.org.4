Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E20164DBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiLOMxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLOMxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:53:36 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A3C2AE31
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:53:34 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id g7so15518028lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzuTwguU6zlNPvH6NtvofqMe3Eg6IAdo9YpChL64+wE=;
        b=YeNUaK+uY4/JoLxFyM2wXAZHSvgHR/m6b0Ux926pQWP3eUpP70jAFiV/1KetjiOwc4
         n52tLFETjiVRZU6g2shz03jh6NimFlWmKvfXSLKVDY+dxfpZyo9/CtGwYHYQFByD2M6P
         QF/vF7qtQbZY3vzE4zLM3xcn3Vs5bztTNlEVLyFBea239BjlTxQ+ROxlLVGCfc9a9TAP
         fsUYnJQuWOXE9D3mSczudjh6z9wSKhTGVPEnyav4WFzlk9hj5IUTMMVctnfmORYihc65
         CKH/7eQNXvI1Zh7uXrJ8viWrmmuhbc3+PSk08U/foICqZOh0MNvkqw1WTsCYocsnGZJZ
         v/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzuTwguU6zlNPvH6NtvofqMe3Eg6IAdo9YpChL64+wE=;
        b=xfIdR9VnLQyZJqHN8GDIwqZ5REHqYDAlyQtMGMGAMJQOtgxpyCKMnc5uTcUfbOuxdl
         33VecRU4rsYsPDbpdHT6eBvBC9BiqTFyASQMncBJTe78ZyuYfLGnOI1f9Ndl+ForEyEd
         R+2GQdujBP362a6kzsDowfKyd7gvR2iiGW2nYBo68Y0TJqlsOMAJRRrXHSATWGA2m6MX
         vGRijzKwFItn90WnHrlXXqoDH7MBw6NArawACrQsTicWcrzLbaFXilCyg8DYrBZiBraH
         tfUI5xDi+3u7Y9zx6F/pj4khsU6rPcjSwAIGtGy0OU27GOAftGsGmwjnD7sTAoy5J6w+
         BINg==
X-Gm-Message-State: ANoB5pmxHg9H4U7At84fytV51YHnFtO+GG07NPJi4gQhB83PylDUf/B5
        WFMEugRrtGYRN8lJS+AbejctFNJUgpKGQ7ki
X-Google-Smtp-Source: AA0mqf62BpWofCGRFTgm6po8++hNAbFTE1z7qiNL4ToMJidjt+wuG42V2otBjI44X5CeAApwaC3LLg==
X-Received: by 2002:ac2:443c:0:b0:4b5:5bc1:678c with SMTP id w28-20020ac2443c000000b004b55bc1678cmr7565946lfl.21.1671108813094;
        Thu, 15 Dec 2022 04:53:33 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id f6-20020a056512360600b004b4a0482a53sm1150861lfs.231.2022.12.15.04.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 04:53:32 -0800 (PST)
Message-ID: <d49ff4c8-4ea8-1a79-04c6-199a38e1cb2b@linaro.org>
Date:   Thu, 15 Dec 2022 13:53:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/7] arm64: dts: qcom: sc8280xp: rename qup0_i2c4 to
 i2c4
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
References: <20221214171145.2913557-1-bmasney@redhat.com>
 <20221214171145.2913557-4-bmasney@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221214171145.2913557-4-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8
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



On 14.12.2022 18:11, Brian Masney wrote:
> In preparation for adding the missing SPI and I2C nodes to
> sc8280xp.dtsi, it was decided to rename all of the existing qupX_
> uart, spi, and i2c nodes to drop the qupX_ prefix. Let's go ahead
> and rename qup0_i2c4 to i2c4. Note that some nodes are moved in the
> file by this patch to preserve the expected sort order in the file.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Link: https://lore.kernel.org/lkml/20221212182314.1902632-1-bmasney@redhat.com/
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> This is a new patch that's introduced in v2.
> 
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 58 +++++++++----------
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 58 +++++++++----------
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  2 +-
>  3 files changed, 59 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 0de1bdb68e2c..c37a9d93a2a8 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -228,6 +228,27 @@ vreg_l9d: ldo9 {
>  	};
>  };
>  
> +&i2c4 {
> +	clock-frequency = <400000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_default>;
> +
> +	status = "okay";
> +
> +	touchscreen@10 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x10>;
> +
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vreg_misc_3p3>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts0_default>;
> +	};
> +};
> +
>  &i2c21 {
>  	clock-frequency = <400000>;
>  
> @@ -334,27 +355,6 @@ &qup0 {
>  	status = "okay";
>  };
>  
> -&qup0_i2c4 {
> -	clock-frequency = <400000>;
> -
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&qup0_i2c4_default>;
> -
> -	status = "okay";
> -
> -	touchscreen@10 {
> -		compatible = "hid-over-i2c";
> -		reg = <0x10>;
> -
> -		hid-descr-addr = <0x1>;
> -		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
> -		vdd-supply = <&vreg_misc_3p3>;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&ts0_default>;
> -	};
> -};
> -
>  &qup1 {
>  	status = "okay";
>  };
> @@ -494,6 +494,14 @@ hastings_reg_en: hastings-reg-en-state {
>  &tlmm {
>  	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>  
> +	i2c4_default: i2c4-default-state {
> +		pins = "gpio171", "gpio172";
> +		function = "qup4";
> +
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
>  	i2c21_default: i2c21-default-state {
>  		pins = "gpio81", "gpio82";
>  		function = "qup21";
> @@ -598,14 +606,6 @@ wake-n-pins {
>  		};
>  	};
>  
> -	qup0_i2c4_default: qup0-i2c4-default-state {
> -		pins = "gpio171", "gpio172";
> -		function = "qup4";
> -
> -		bias-disable;
> -		drive-strength = <16>;
> -	};
> -
>  	tpad_default: tpad-default-state {
>  		int-n-pins {
>  			pins = "gpio182";
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index d7af2040cbcb..ec06b6216408 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -282,6 +282,28 @@ vreg_l9d: ldo9 {
>  	};
>  };
>  
> +&i2c4 {
> +	clock-frequency = <400000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_default>;
> +
> +	status = "okay";
> +
> +	/* FIXME: verify */
> +	touchscreen@10 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x10>;
> +
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vreg_misc_3p3>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts0_default>;
> +	};
> +};
> +
>  &i2c21 {
>  	clock-frequency = <400000>;
>  
> @@ -554,28 +576,6 @@ &qup0 {
>  	status = "okay";
>  };
>  
> -&qup0_i2c4 {
> -	clock-frequency = <400000>;
> -
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&qup0_i2c4_default>;
> -
> -	status = "okay";
> -
> -	/* FIXME: verify */
> -	touchscreen@10 {
> -		compatible = "hid-over-i2c";
> -		reg = <0x10>;
> -
> -		hid-descr-addr = <0x1>;
> -		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
> -		vdd-supply = <&vreg_misc_3p3>;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&ts0_default>;
> -	};
> -};
> -
>  &qup1 {
>  	status = "okay";
>  };
> @@ -698,6 +698,13 @@ hall_int_n_default: hall-int-n-state {
>  		bias-disable;
>  	};
>  
> +	i2c4_default: i2c4-default-state {
> +		pins = "gpio171", "gpio172";
> +		function = "qup4";
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
>  	i2c21_default: i2c21-default-state {
>  		pins = "gpio81", "gpio82";
>  		function = "qup21";
> @@ -801,13 +808,6 @@ wake-n-pins {
>  		};
>  	};
>  
> -	qup0_i2c4_default: qup0-i2c4-default-state {
> -		pins = "gpio171", "gpio172";
> -		function = "qup4";
> -		bias-disable;
> -		drive-strength = <16>;
> -	};
> -
>  	tpad_default: tpad-default-state {
>  		int-n-pins {
>  			pins = "gpio182";
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 929365cff555..f1111cd7f679 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -858,7 +858,7 @@ qup0: geniqup@9c0000 {
>  
>  			status = "disabled";
>  
> -			qup0_i2c4: i2c@990000 {
> +			i2c4: i2c@990000 {
>  				compatible = "qcom,geni-i2c";
>  				reg = <0 0x00990000 0 0x4000>;
>  				clock-names = "se";
