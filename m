Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ABC6417B4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 17:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLCQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 11:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiLCQQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 11:16:04 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471B11FCE2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 08:16:03 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so11976214lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 08:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bD03bVAr2iRseyt7Z+8nLolk6RYMguFA3ru+zDfKFMM=;
        b=o9/RlvvDYYwY5KsPSCjczoM6q8vsomAbcIlrw61mPK6fHOat9QSs0st3ZoiXFzY1wJ
         8whp8YUpNpoPafWT9Z6Z/dYPXAcx1ELGDuA8Uu7H2mXC/KpVNZHyeMeePMl8pBJsf3v7
         xWmrZ8c1pZPpGy449dWbRwpe30qysF6Eh5tjGdvIy/MeeRVdfxWhVneVP2yFAL4ZIILQ
         r6KEPkxbGqx5f2+BxlYfVjedNmFZxtUbllt54+MZUQIrQr8Vx5YnyTCXhBFQfkgcHbIr
         zGgjJpcBARCFb6ROL7I3dOM69QRuI+LdEqvtPDjTpdlCIk4qI8ffPZELBMhK+091SFlO
         igxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bD03bVAr2iRseyt7Z+8nLolk6RYMguFA3ru+zDfKFMM=;
        b=huA6TjMyFU67sTYtxuTW2VxkRbwb8NEjRhe1fmV9jPVYZnfWSGmRRYMa40X3BZzjFl
         5o0Ra9PYmGriN86580fWhV5qE2R6qAYB3suf19JH22BWx+9zCFe+AS8sn2fHSDU5+hLp
         jOVn9209E4jySPxg4HRp6W8DAC1VmKGhA1znEpA7Gg2wTQ0rDs7W0gd8DtqxzSkVulZ4
         9fGJGq6W9l6rEZUAnF6Ud7hBZn7Li4kkTl6Xt39Wv7xz/HzVmYPYs3tWCieySk7aDgmP
         NuNKmRKpSOWJbOdODDVtymEbkZfr5xz2yErFFxW5J7ClBqAkqyZ6uGoDuNhxj2/yOmgh
         IO6g==
X-Gm-Message-State: ANoB5pkXwV268TGeVMS6GUrp7ew0w7/9pbbsrYivbfx96kvvcnbj5YFI
        VmNLea40QQ0Y633lRWJV+YD2iX+3T65UouS+
X-Google-Smtp-Source: AA0mqf62DakCGjQVZGOvewXxurdp/mQKndP8v5YWqF3mkB05oeeEoaxouRFzREW9XQN9ha5Lov6y7A==
X-Received: by 2002:a05:6512:340b:b0:4a2:5897:2b44 with SMTP id i11-20020a056512340b00b004a258972b44mr28024130lfr.431.1670084161572;
        Sat, 03 Dec 2022 08:16:01 -0800 (PST)
Received: from [192.168.1.101] (95.49.124.10.neoplus.adsl.tpnet.pl. [95.49.124.10])
        by smtp.gmail.com with ESMTPSA id q15-20020a2e914f000000b0027706d22878sm914398ljg.94.2022.12.03.08.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Dec 2022 08:16:01 -0800 (PST)
Message-ID: <cffb7424-7fad-da98-94ca-2f30802633cb@linaro.org>
Date:   Sat, 3 Dec 2022 17:15:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: use generic node names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221203161443.97656-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221203161443.97656-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.12.2022 17:14, Krzysztof Kozlowski wrote:
> According to Devicetree specification, the node names should be somewhat
> generic.  Use "amplifier" for max98360a and "-regulator" for fixed
> regulators.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi     | 8 ++++----
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi      | 6 +++---
>  .../arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi | 2 +-
>  .../arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  | 6 +++---
>  5 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> index 70e52fdb606a..d3cf64c16dcd 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
> @@ -10,22 +10,22 @@
>  / {
>  	/* BOARD-SPECIFIC TOP LEVEL NODES */
>  
> -	max98360a_1: max98360a_1 {
> +	max98360a_1: amplifier-1 {
>  		compatible = "maxim,max98360a";
>  		#sound-dai-cells = <0>;
>  	};
>  
> -	max98360a_2: max98360a_2 {
> +	max98360a_2: amplifier-2 {
>  		compatible = "maxim,max98360a";
>  		#sound-dai-cells = <0>;
>  	};
>  
> -	max98360a_3: max98360a_3 {
> +	max98360a_3: amplifier-3 {
>  		compatible = "maxim,max98360a";
>  		#sound-dai-cells = <0>;
>  	};
>  
> -	pp3300_touch: pp3300-touch {
> +	pp3300_touch: pp3300-touch-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "pp3300_touch";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
> index 5e563655baec..ed12ee35f06b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland.dtsi
> @@ -13,7 +13,7 @@
>  /delete-node/ &usb_c1;
>  
>  / {
> -	avdd_lcd: avdd-lcd {
> +	avdd_lcd: avdd-lcd-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "avdd_lcd";
>  
> @@ -25,7 +25,7 @@ avdd_lcd: avdd-lcd {
>  		vin-supply = <&pp5000_a>;
>  	};
>  
> -	avee_lcd: avee-lcd {
> +	avee_lcd: avee-lcd-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "avee_lcd";
>  
> @@ -37,7 +37,7 @@ avee_lcd: avee-lcd {
>  		vin-supply = <&pp5000_a>;
>  	};
>  
> -	v1p8_mipi: v1p8-mipi {
> +	v1p8_mipi: v1p8-mipi-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "v1p8_mipi";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
> index 070b3acb7baa..ebd6765e2afa 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
> @@ -8,7 +8,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  
>  / {
> -	pp3300_brij_ps8640: pp3300-brij-ps8640 {
> +	pp3300_brij_ps8640: pp3300-brij-ps8640-regulator {
>  		compatible = "regulator-fixed";
>  		status = "okay";
>  		regulator-name = "pp3300_brij_ps8640";
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
> index c1367999eafb..cb41ccdaccfd 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
> @@ -13,7 +13,7 @@
>  /delete-node/ &usb_c1;
>  
>  / {
> -	ppvar_lcd: ppvar-lcd {
> +	ppvar_lcd: ppvar-lcd-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "ppvar_lcd";
>  
> @@ -25,7 +25,7 @@ ppvar_lcd: ppvar-lcd {
>  		vin-supply = <&pp5000_a>;
>  	};
>  
> -	v1p8_disp: v1p8-disp {
> +	v1p8_disp: v1p8-disp-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "v1p8_disp";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
> index 123989ba97e1..9832e752da35 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
> @@ -10,7 +10,7 @@
>  #include "sc7180-trogdor.dtsi"
>  
>  / {
> -	avdd_lcd: avdd-lcd {
> +	avdd_lcd: avdd-lcd-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "avdd_lcd";
>  
> @@ -22,7 +22,7 @@ avdd_lcd: avdd-lcd {
>  		vin-supply = <&pp5000_a>;
>  	};
>  
> -	avee_lcd: avee-lcd {
> +	avee_lcd: avee-lcd-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "avee_lcd";
>  
> @@ -35,7 +35,7 @@ avee_lcd: avee-lcd {
>  	};
>  
>  	pp1800_ts:
> -	v1p8_mipi: v1p8-mipi {
> +	v1p8_mipi: v1p8-mipi-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "v1p8_mipi";
>  
