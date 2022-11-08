Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9D621C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKHSuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKHStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:49:53 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA76E61BA5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:49:10 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v17so23902398edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFEI+OVj3meMKerE8m3XRj1WIR+3TY6afj77dwFQNKU=;
        b=zQNl4VxL6/HH42SQyC7RyGNCefk+IDdeZXh7OGPP3F7RD1rvw+/PIElhr53HAr6aYT
         HnDjRNSoe2b7aLI3Gfc5sp6PnIoQk9afxZBlaXYOGEpBBv1qaGGyWo/V1NnRkFPlILen
         SGIQVa4F0dwpf2ARHzGvsE26abq9gm0BU9eissEjf0Hjst4zGINgZjcvo4Wggp0s2o2E
         nZTKOpQcGUHEbsht43TxlgP7PyADnNBf+v28nf/RVrTvmnXgqsWS5V2JYn9Hk8kpofCJ
         yBDH/0QJkK4c4ASlZSgKWXD9TVt6pY3qdJPhpmjALcKZoX/YwVW2vI8hapbIoN+b73yj
         B9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iFEI+OVj3meMKerE8m3XRj1WIR+3TY6afj77dwFQNKU=;
        b=7CydgQDqIlJ5+CAzYuM9o6Tsu88Q0PxPOAAkdQMedhE/d5ovxI7TK46BI4Y01T/7N9
         SCDG5iKWQjKBy869zkb3IJIUgIKAL2F94zUIm1gmc4r2m5K7IJhNpBysPga14Vooj0ER
         gLJU/JPtZfzwAzXsX8TaHRkbbPsv4cuzBd3Y3vxJnK664fVD5aelXn4mU8QfttbpHrnX
         wvWA8FskWVUT+ruVm77W/vDSD/wEqDHv7NT6b9HhEvwDlTm5nU/i2BRTMtk9JurzjiuU
         AwwiytWf1F3b/BdJ6CLi8UNcAcs4f1y91m/GviOqjBmu9DMWvrW6+WGmXr5sgJbvuLha
         9peQ==
X-Gm-Message-State: ACrzQf1GP0Xpsmk+mRwrFrmXNBQcBJAHNGI2KAReDQjf2Q8RHEf1c4cz
        00VrWpgKlGNTvmhLwimI5/lxUQ==
X-Google-Smtp-Source: AMsMyM7DLtgr+46W3y81zE9KYE2rJh3K9Swfz6w7mHqc/kxaNTcNqq9Ah0sjkBOh7YlgfOAjnwcjJA==
X-Received: by 2002:aa7:d8c4:0:b0:461:8d31:41fc with SMTP id k4-20020aa7d8c4000000b004618d3141fcmr57059380eds.202.1667933349379;
        Tue, 08 Nov 2022 10:49:09 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id a1-20020a05640213c100b004614c591366sm5828499edx.48.2022.11.08.10.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:49:08 -0800 (PST)
Message-ID: <41242ffc-fd61-ded1-0647-bba1efb60a1e@linaro.org>
Date:   Tue, 8 Nov 2022 19:49:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 2/3] ARM: dts: qcom-msm8960: use define for interrupt
 constants
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221108184529.26857-1-krzysztof.kozlowski@linaro.org>
 <20221108184529.26857-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221108184529.26857-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/11/2022 19:45, Krzysztof Kozlowski wrote:
> Replace GIC_PPI, GIC_SPI and interrupt type numbers with appropriate
> defines.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm/boot/dts/qcom-msm8960-cdp.dts |  2 +-
>   arch/arm/boot/dts/qcom-msm8960.dtsi    | 22 ++++++++++++----------
>   2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> index cb0f612e6c90..3a484ac53917 100644
> --- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> +++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
> @@ -42,7 +42,7 @@ ethernet@0 {
>   		compatible = "micrel,ks8851";
>   		reg = <0>;
>   		interrupt-parent = <&msmgpio>;
> -		interrupts = <90 8>;
> +		interrupts = <90 IRQ_TYPE_LEVEL_LOW>;
>   		spi-max-frequency = <5400000>;
>   		vdd-supply = <&ext_l2>;
>   		vdd-io-supply = <&pm8921_lvs6>;
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index 30abf53b062d..2f32e734f18d 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -17,7 +17,7 @@ / {
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> -		interrupts = <1 14 0x304>;
> +		interrupts = <GIC_PPI 14 0x304>;
>   
>   		cpu@0 {
>   			compatible = "qcom,krait";
> @@ -52,7 +52,7 @@ memory {
>   
>   	cpu-pmu {
>   		compatible = "qcom,krait-pmu";
> -		interrupts = <1 10 0x304>;
> +		interrupts = <GIC_PPI 10 0x304>;
>   		qcom,no-pc-write;
>   	};
>   
> @@ -105,9 +105,9 @@ intc: interrupt-controller@2000000 {
>   		timer@200a000 {
>   			compatible = "qcom,kpss-timer",
>   				     "qcom,kpss-wdt-msm8960", "qcom,msm-timer";
> -			interrupts = <1 1 0x301>,
> -				     <1 2 0x301>,
> -				     <1 3 0x301>;
> +			interrupts = <GIC_PPI 1 0x301>,
> +				     <GIC_PPI 2 0x301>,
> +				     <GIC_PPI 3 0x301>;
>   			reg = <0x0200a000 0x100>;
>   			clock-frequency = <27000000>,
>   					  <32768>;
> @@ -119,7 +119,7 @@ msmgpio: pinctrl@800000 {
>   			gpio-controller;
>   			gpio-ranges = <&msmgpio 0 0 152>;
>   			#gpio-cells = <2>;
> -			interrupts = <0 16 0x4>;
> +			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
>   			reg = <0x800000 0x4000>;
> @@ -255,7 +255,7 @@ ssbi@500000 {
>   			pmicintc: pmic {
>   				compatible = "qcom,pm8921";
>   				interrupt-parent = <&msmgpio>;
> -				interrupts = <104 8>;
> +				interrupts = <104 IRQ_TYPE_LEVEL_LOW>;
>   				#interrupt-cells = <2>;
>   				interrupt-controller;
>   				#address-cells = <1>;
> @@ -265,7 +265,8 @@ pwrkey@1c {
>   					compatible = "qcom,pm8921-pwrkey";
>   					reg = <0x1c>;
>   					interrupt-parent = <&pmicintc>;
> -					interrupts = <50 1>, <51 1>;
> +					interrupts = <50 IRQ_TYPE_EDGE_RISING>,
> +						     <51 IRQ_TYPE_EDGE_RISING>;
>   					debounce = <15625>;
>   					pull-up;
>   				};
> @@ -274,7 +275,8 @@ keypad@148 {
>   					compatible = "qcom,pm8921-keypad";
>   					reg = <0x148>;
>   					interrupt-parent = <&pmicintc>;
> -					interrupts = <74 1>, <75 1>;
> +					interrupts = <74 IRQ_TYPE_EDGE_RISING>,
> +						     <75 IRQ_TYPE_EDGE_RISING>;
>   					debounce = <15>;
>   					scan-delay = <32>;
>   					row-hold = <91500>;
> @@ -283,7 +285,7 @@ keypad@148 {
>   				rtc@11d {
>   					compatible = "qcom,pm8921-rtc";
>   					interrupt-parent = <&pmicintc>;
> -					interrupts = <39 1>;
> +					interrupts = <39 IRQ_TYPE_EDGE_RISING>;
>   					reg = <0x11d>;
>   					allow-set-time;
>   				};
