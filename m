Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9364665AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjAKL7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjAKL6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:58:38 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D01E0C0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:54:14 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s22so15758021ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87amYxxjuw2O3A5AUaxxYDc2vtYs2lif6mU7sZ39bg0=;
        b=ZBXYSTrciQf8pT0kv7SCuxtJTnSOLrZ61DKbNQV+VumC0PIwmvY5G5LwU6PJOWiXhg
         PAa2JbHrQ/VD7isf2LOZpAIh8k1Bb25MObE3qgDtw7NoZQGh/aqL+GV2Jr3FraldTufG
         ZBrmHvfAaVAWVWOaK1sR+IZfieciD9Lgr/7fgH8hu/ysTk9SI04vjvhTFfTbP3+Fl/cW
         0bklrPrswxf28r2MroubKCXON7dtwtZt7f+UE2qN9+cTsEVn9T84Lw+C9I1E2Tc7I5Y5
         lJydHpX6EddBk9FjGZrt9V4Xa26ylwTo2zWwT/2PRmHFrLagy0CxdSWVgtPqtOV2yYb0
         Ezcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87amYxxjuw2O3A5AUaxxYDc2vtYs2lif6mU7sZ39bg0=;
        b=Hv0oJK4PvXhpzZ3rwHJmy7EqTltTeaZ0rcqNretfaOQyWAhOKwawS91CCPy0nbPL4b
         jus0XD7jEDplNkI5wsnJNH9kQlqcvFIRA0zzCkSKpmWryuchryVLtNTnAxAabB7it16q
         /N2K5e8pOrB9JUoZO3ndB3ysqyYVERu2aHYl/7RPdodHwBBv/o/SHg4jpa2a6wSQOVzD
         tNekjki04UytHBR3j6nqXwAbL68Bcgfe+Gv0VAAv1LCoa/3Robr6h/vbU+/9SyUviVky
         1mGoUACk6PyRBbu2VBbAlttXcI/MH9VMube+cjWJDtaVWRMwonTZXaS1RlqDul4aIbhL
         6gdQ==
X-Gm-Message-State: AFqh2kqzD44tSfgR8ELcXmqEkXsvOr15rRGPY+37F1sjVo+Du1eNVTrB
        /7N98wyCNDxZdCumGI/ncg1JD5IBIdsugf7W
X-Google-Smtp-Source: AMrXdXu9cjTTlZKrBOV+brVcyFOQTawCq5l05CxPSgUhMLwjlEGzn8V8Dt/S7SnzqZIrBxXAMzzIGQ==
X-Received: by 2002:a05:651c:301:b0:27f:d652:f397 with SMTP id a1-20020a05651c030100b0027fd652f397mr10855210ljp.34.1673438052926;
        Wed, 11 Jan 2023 03:54:12 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id 13-20020a05651c128d00b00285ac292d58sm1039067ljc.80.2023.01.11.03.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 03:54:11 -0800 (PST)
Message-ID: <33218f23-93b7-2500-271b-0e57962637c4@linaro.org>
Date:   Wed, 11 Jan 2023 12:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sa8450p-pmics: rename pmic labels
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eric Chanudet <echanude@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230111082331.20641-1-johan+linaro@kernel.org>
 <20230111082331.20641-3-johan+linaro@kernel.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230111082331.20641-3-johan+linaro@kernel.org>
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



On 11.01.2023 09:23, Johan Hovold wrote:
> The SA8540P PMICs are named PMM8540. Rename the devicetree source labels
> to reflect this.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi | 24 ++++++++++-----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
> index 8c393f0bd6a8..1221be89b3de 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
> @@ -8,7 +8,7 @@
>  #include <dt-bindings/spmi/spmi.h>
>  
>  &spmi_bus {
> -	pm8450a: pmic@0 {
> +	pmm8540a: pmic@0 {
>  		compatible = "qcom,pm8150", "qcom,spmi-pmic";
>  		reg = <0x0 SPMI_USID>;
>  		#address-cells = <1>;
> @@ -22,62 +22,62 @@ rtc@6000 {
>  			wakeup-source;
>  		};
>  
> -		pm8450a_gpios: gpio@c000 {
> +		pmm8540a_gpios: gpio@c000 {
>  			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pm8450a_gpios 0 0 10>;
> +			gpio-ranges = <&pmm8540a_gpios 0 0 10>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  		};
>  	};
>  
> -	pm8450c: pmic@4 {
> +	pmm8540c: pmic@4 {
>  		compatible = "qcom,pm8150", "qcom,spmi-pmic";
>  		reg = <0x4 SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		pm8450c_gpios: gpio@c000 {
> +		pmm8540c_gpios: gpio@c000 {
>  			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pm8450c_gpios 0 0 10>;
> +			gpio-ranges = <&pmm8540c_gpios 0 0 10>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  		};
>  	};
>  
> -	pm8450e: pmic@8 {
> +	pmm8540e: pmic@8 {
>  		compatible = "qcom,pm8150", "qcom,spmi-pmic";
>  		reg = <0x8 SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		pm8450e_gpios: gpio@c000 {
> +		pmm8540e_gpios: gpio@c000 {
>  			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pm8450e_gpios 0 0 10>;
> +			gpio-ranges = <&pmm8540e_gpios 0 0 10>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  		};
>  	};
>  
> -	pm8450g: pmic@c {
> +	pmm8540g: pmic@c {
>  		compatible = "qcom,pm8150", "qcom,spmi-pmic";
>  		reg = <0xc SPMI_USID>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		pm8450g_gpios: gpio@c000 {
> +		pmm8540g_gpios: gpio@c000 {
>  			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
>  			gpio-controller;
> -			gpio-ranges = <&pm8450g_gpios 0 0 10>;
> +			gpio-ranges = <&pmm8540g_gpios 0 0 10>;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
