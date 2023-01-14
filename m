Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8007F66ADB0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 21:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjANUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 15:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjANUdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 15:33:49 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665FDE397
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:33:46 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o20so5727413lfk.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1c49+52AKjhgHCmMOvtJtYeeDgs+DiWpo3802s5y8mc=;
        b=hp1yWVNFbZSVMTYzP9a6Hwm4HQF++c0Vg0UmahDAe2LZUbnBRz2bkVuod796jemFxL
         6G2eeQoyArpnyfJj/k7M2w0uLsKL7DloG3MJ5i6VvvPPKNPnC20C6AS+vbQR5odUSMMD
         0QC4v1z3t7QcyFz8ebfqlQq3eCGoR2LZgr9zqnwkBjfsnSUIsjoWM+lA5qVgGytTkhB8
         GBc2jVoErd7sObPBessGbzLJgQnXwsnUWD8Gq0AAkGcrcTTSuVcAqdM9nWRz0KtDq7gm
         2hF0kEgrmj1FnnbtR2Tg1gbDUwWQAXeaZVAT5QuPvFIC+d4TJjB01xrCq4s6rqcrc9sp
         m4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1c49+52AKjhgHCmMOvtJtYeeDgs+DiWpo3802s5y8mc=;
        b=y2KCjSAU03QN9Ru87vFEI42NJn6/qEli/mB7qO9e9jddt/iV8GFNgz/K0CUza6IXRy
         GvOoU8IPqtgsGuIFNn/57Czza+m1LnmTxSQlZm+9Ne22j2ZfaEwcVbmeT3qJffuEPioz
         pFN8nwSERXLhbl/uOO03N0Y8Cetd+Yl0r8GdHi6RPXk+nUYpiuNQdvQ9Er1lnfwKJm0K
         cis5FjXxgIDCH8MVmOCgYImThk8nJY9AYtZ8qKc9rS1f7cHY4EkFfkZoEY5AQMER3wmX
         uV5+o0bWAYegQN2MJMtbyKFRPQaXdGXbGY+7OikCMRbkushYoqYrAcC6ytg/XqnKn03o
         DwxQ==
X-Gm-Message-State: AFqh2kpJfDYrOiivcXN1VG9xCy+ySOMk10BxenHTRVHusJS1Puj9LWWp
        /qeDkz9bAB5FY1WNsRT3WlTgI+WeuRLpBktX
X-Google-Smtp-Source: AMrXdXtH1n81gSO/XHdagk8KtCmu6qlCbMUbZaEjGUc/qip0XeM0SdxI2e00+11TLjp3zQpGPkIvtA==
X-Received: by 2002:a05:6512:1582:b0:4b6:e494:a98d with SMTP id bp2-20020a056512158200b004b6e494a98dmr26161055lfb.44.1673728425127;
        Sat, 14 Jan 2023 12:33:45 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id j11-20020a056512344b00b004cafd4cc1fdsm4414726lfr.5.2023.01.14.12.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 12:33:44 -0800 (PST)
Message-ID: <032a1f37-9432-df35-c62d-fd501d8f50e6@linaro.org>
Date:   Sat, 14 Jan 2023 21:33:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sdm845-audio-wcd9340: commonize
 pinctrl
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
 <20230113162245.117324-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230113162245.117324-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.01.2023 17:22, Krzysztof Kozlowski wrote:
> Pin configuration fow WCD9340 is the same in all users, so move it to
> common file to reduce the code duplication (which still allows further
> customizations per board).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Modulo the file name thing from [2/6]

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi | 15 +++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts        | 11 -----------
>  .../dts/qcom/sdm845-xiaomi-beryllium-common.dtsi  | 11 -----------
>  .../arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts | 10 ----------
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts     | 11 -----------
>  arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts  | 11 -----------
>  6 files changed, 15 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> index 5bcce7d0d709..33718cb95c83 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
> @@ -32,6 +32,10 @@ wcd9340: codec@1,0 {
>  			#clock-cells = <0>;
>  			clock-frequency = <9600000>;
>  			clock-output-names = "mclk";
> +
> +			pinctrl-0 = <&wcd_intr_default>;
> +			pinctrl-names = "default";
> +
>  			qcom,micbias1-microvolt = <1800000>;
>  			qcom,micbias2-microvolt = <1800000>;
>  			qcom,micbias3-microvolt = <1800000>;
> @@ -67,3 +71,14 @@ swm: swm@c85 {
>  		};
>  	};
>  };
> +
> +&tlmm {
> +	wcd_intr_default: wcd-intr-default-state {
> +		pins = "gpio54";
> +		function = "gpio";
> +
> +		input-enable;
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 3726465acbde..33ec79afbb62 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -971,15 +971,6 @@ sdc2_card_det_n: sd-card-det-n-state {
>  		function = "gpio";
>  		bias-pull-up;
>  	};
> -
> -	wcd_intr_default: wcd-intr-default-state {
> -		pins = "gpio54";
> -		function = "gpio";
> -
> -		input-enable;
> -		bias-pull-down;
> -		drive-strength = <2>;
> -	};
>  };
>  
>  &uart3 {
> @@ -1085,8 +1076,6 @@ &venus {
>  };
>  
>  &wcd9340 {
> -	pinctrl-0 = <&wcd_intr_default>;
> -	pinctrl-names = "default";
>  	clock-names = "extclk";
>  	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
>  	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index e530a676b250..a7a3f7ce2809 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -466,15 +466,6 @@ sdc2_card_det_n: sd-card-det-n-state {
>  		function = "gpio";
>  		bias-pull-up;
>  	};
> -
> -	wcd_intr_default: wcd-intr-default-state {
> -		pins = "gpio54";
> -		function = "gpio";
> -
> -		input-enable;
> -		bias-pull-down;
> -		drive-strength = <2>;
> -	};
>  };
>  
>  &uart6 {
> @@ -543,8 +534,6 @@ &venus {
>  };
>  
>  &wcd9340 {
> -	pinctrl-0 = <&wcd_intr_default>;
> -	pinctrl-names = "default";
>  	clock-names = "extclk";
>  	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
>  	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index f81619c8a3ba..1ceeea0885b9 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -616,14 +616,6 @@ sde_dsi_suspend: sde-dsi-suspend-state {
>  		drive-strength = <2>;
>  		bias-pull-down;
>  	};
> -
> -	wcd_intr_default: wcd-intr-default-state {
> -		pins = "gpio54";
> -		function = "gpio";
> -		input-enable;
> -		bias-pull-down;
> -		drive-strength = <2>;
> -	};
>  };
>  
>  &uart6 {
> @@ -700,8 +692,6 @@ &venus {
>  };
>  
>  &wcd9340 {
> -	pinctrl-0 = <&wcd_intr_default>;
> -	pinctrl-names = "default";
>  	clock-names = "extclk";
>  	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
>  	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index 5586c95aa1ff..f3dd0ff1d5c6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -628,15 +628,6 @@ i2c11_hid_active: i2c11-hid-active-state {
>  		drive-strength = <2>;
>  	};
>  
> -	wcd_intr_default: wcd-intr-default-state {
> -		pins = "gpio54";
> -		function = "gpio";
> -
> -		input-enable;
> -		bias-pull-down;
> -		drive-strength = <2>;
> -	};
> -
>  	lid_pin_active: lid-pin-state {
>  		pins = "gpio124";
>  		function = "gpio";
> @@ -747,8 +738,6 @@ &venus {
>  };
>  
>  &wcd9340 {
> -	pinctrl-0 = <&wcd_intr_default>;
> -	pinctrl-names = "default";
>  	clock-names = "extclk";
>  	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
>  	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> index 40223704a2c7..fc9369eafd23 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> @@ -552,15 +552,6 @@ pen_rst_l: pen-rst-l-state {
>  		 */
>  		output-high;
>  	};
> -
> -	wcd_intr_default: wcd-intr-default-state {
> -		pins = "gpio54";
> -		function = "gpio";
> -
> -		input-enable;
> -		bias-pull-down;
> -		drive-strength = <2>;
> -	};
>  };
>  
>  &uart6 {
> @@ -656,8 +647,6 @@ &venus {
>  };
>  
>  &wcd9340 {
> -	pinctrl-0 = <&wcd_intr_default>;
> -	pinctrl-names = "default";
>  	clock-names = "extclk";
>  	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
>  	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
