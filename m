Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B376598E5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiL3Nm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiL3Nmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:42:51 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761461ADBA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:42:48 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bf43so31785118lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=983TfHkac1zoLLZNOo1G/P2rbHBWZJH70ymZx4ERoZM=;
        b=PVU/TkknWqqAQJY+NsdYGcm0hS+VksojD6MazP63J9R7X8c+QfDAxRxLoly0sVmaXY
         DmkDxeRFC2SgbX7SHPJAx6CmjiCKKU47WZWLXk6o1iXEfr8WnQLGyreJSwYHpZJq3H5G
         xu++m1r+Ov7P41PZ5UurSgfsdgCXCia+Rf6cqleJB1aSVP0KtRc+G8A1S011D4OAXIdr
         ev6XHExu5teYRgWCRzelm9V4uKF8kmdc1Pfoxt92ir2kZweLw3e5RrFhwC3BS0TAfrpq
         NCNeUCvyO1wi/19muKO35hthF6BrQwI2N4/X1TCbqm8tUUyV6Cpv+x7MWQvqvvtCwJKk
         WctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=983TfHkac1zoLLZNOo1G/P2rbHBWZJH70ymZx4ERoZM=;
        b=l2ruTnLfwe2Mtce13jajmkiFcNHb480XvRnn+IcAMH8/tBuHkJniQ2E/M+W9dwQfJl
         plYBMEF1ar5viuAaJVauADMK4UZnQLUpg6OHzO3JJz2JOO9Q8sw9hvE4TF7FVndadBqw
         ihDPKw+wrsqgQdKVCAvOpIael32Ov5HJ8ib31auaPx2KLr4Bx8OAdkPIebCQOU793XgA
         x5KIHo7TlekIzsu1y5LP0aJUPd34d/AK+IOdwzuvW0tx2b2TR6TSN76hmOKe4qsHFBD9
         Wfr00C65bS5dg8hb+jyc76edroAyyuelkk+TTVkoL3VAo6saggFGCvsbuJ9jVQtkExzd
         YSmQ==
X-Gm-Message-State: AFqh2kr3P/taaWhubrNVHo0rlBL1VxDqM8v/LtU96hWHDquBWQURqJNC
        nwmwIgLu+MkhibruEJ1IPUfa8Q==
X-Google-Smtp-Source: AMrXdXvBo+PUX10ICfd0UGqjX9eVGOxRSVPicSQl0XgZKFjQ2YIiosZMxA+SwC0YWUJ/FDVpxZM8YA==
X-Received: by 2002:a05:6512:169e:b0:4ca:fa2d:2686 with SMTP id bu30-20020a056512169e00b004cafa2d2686mr8207830lfb.35.1672407766802;
        Fri, 30 Dec 2022 05:42:46 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id c18-20020ac25f72000000b004a2386b8cf5sm3479671lfc.215.2022.12.30.05.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 05:42:46 -0800 (PST)
Message-ID: <97e5d783-faa3-f19c-9b3c-ff608bce9183@linaro.org>
Date:   Fri, 30 Dec 2022 14:42:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: add missing space before {
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221230134006.48111-1-krzysztof.kozlowski@linaro.org>
 <20221230134006.48111-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221230134006.48111-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.12.2022 14:40, Krzysztof Kozlowski wrote:
> Add missingh whitespace between node name/label and opening {.
redundant 'h'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8996.dtsi                        | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180.dtsi                         | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi        | 2 +-
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts   | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts         | 2 +-
>  arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts             | 2 +-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi                         | 2 +-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi                         | 2 +-
>  arch/arm64/boot/dts/qcom/sm8350.dtsi                         | 2 +-
>  arch/arm64/boot/dts/qcom/sm8450.dtsi                         | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index d2b3fdf2df13..cbdf7c1f31b9 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -3292,7 +3292,7 @@ blsp2_i2c6: i2c@75ba000 {
>  			status = "disabled";
>  		};
>  
> -		blsp2_spi6: spi@75ba000{
> +		blsp2_spi6: spi@75ba000 {
>  			compatible = "qcom,spi-qup-v2.2.1";
>  			reg = <0x075ba000 0x600>;
>  			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index c20e48da44f8..031320baec3d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3419,7 +3419,7 @@ watchdog@17c10000 {
>  			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> -		timer@17c20000{
> +		timer@17c20000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0 0 0 0x20000000>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
> index 7fc0b6bfc0d6..552646c073e2 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
> @@ -70,7 +70,7 @@ &pcie1_phy {
>  	status = "okay";
>  };
>  
> -&pm8350c_pwm_backlight{
> +&pm8350c_pwm_backlight {
>  	/* Set the PWM period to 200 microseconds (5kHz duty cycle) */
>  	pwms = <&pm8350c_pwm 3 200000>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 0201c6776746..1a5a5764e6a1 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -743,7 +743,7 @@ left_spkr: wsa8830-left@0,1 {
>  		vdd-supply = <&vreg_s10b>;
>  	};
>  
> -	right_spkr: wsa8830-right@0,2{
> +	right_spkr: wsa8830-right@0,2 {
>  		compatible = "sdw10217020200";
>  		reg = <0 2>;
>  		pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index c3453f291286..64de4ed9b0c8 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -541,7 +541,7 @@ &venus {
>  	firmware-name = "qcom/sdm845/beryllium/venus.mbn";
>  };
>  
> -&wcd9340{
> +&wcd9340 {
>  	pinctrl-0 = <&wcd_intr_default>;
>  	pinctrl-names = "default";
>  	clock-names = "extclk";
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index 501232bdf9cf..d9581f4440b3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -745,7 +745,7 @@ &venus {
>  	status = "okay";
>  };
>  
> -&wcd9340{
> +&wcd9340 {
>  	pinctrl-0 = <&wcd_intr_default>;
>  	pinctrl-names = "default";
>  	clock-names = "extclk";
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> index 9215066146ff..6730804f4e3e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> @@ -654,7 +654,7 @@ &venus {
>  	firmware-name = "qcom/sdm850/samsung/w737/qcvss850.mbn";
>  };
>  
> -&wcd9340{
> +&wcd9340 {
>  	pinctrl-0 = <&wcd_intr_default>;
>  	pinctrl-names = "default";
>  	clock-names = "extclk";
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 90dec84055c3..5886710b3c65 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -4124,7 +4124,7 @@ timer@17c20000 {
>  			reg = <0x0 0x17c20000 0x0 0x1000>;
>  			clock-frequency = <19200000>;
>  
> -			frame@17c21000{
> +			frame@17c21000 {
>  				frame-number = <0>;
>  				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index ab5a2851a314..6c7adce6c9b8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2397,7 +2397,7 @@ aoncc: clock-controller@3380000 {
>  			clock-names = "core", "audio", "bus";
>  		};
>  
> -		lpass_tlmm: pinctrl@33c0000{
> +		lpass_tlmm: pinctrl@33c0000 {
>  			compatible = "qcom,sm8250-lpass-lpi-pinctrl";
>  			reg = <0 0x033c0000 0x0 0x20000>,
>  			      <0 0x03550000 0x0 0x10000>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 1d5b52b13cc2..a7da48b7e788 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1598,7 +1598,7 @@ lpass_ag_noc: interconnect@3c40000 {
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> -		compute_noc: interconnect@a0c0000{
> +		compute_noc: interconnect@a0c0000 {
>  			compatible = "qcom,sm8350-compute-noc";
>  			reg = <0 0x0a0c0000 0 0xa180>;
>  			#interconnect-cells = <1>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 73df5494d49c..33db6b6c4123 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -3519,7 +3519,7 @@ qup_uart20_default: qup-uart20-default-state {
>  
>  		};
>  
> -		lpass_tlmm: pinctrl@3440000{
> +		lpass_tlmm: pinctrl@3440000 {
>  			compatible = "qcom,sm8450-lpass-lpi-pinctrl";
>  			reg = <0 0x3440000 0x0 0x20000>,
>  			      <0 0x34d0000 0x0 0x10000>;
