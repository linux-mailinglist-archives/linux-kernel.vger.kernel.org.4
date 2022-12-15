Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4DB64DBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLONBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiLONBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:01:16 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE251929C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:01:14 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 1so15564872lfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5FoNmZ2y7OvNSXeAdJOjPOi5B43bhKY55Ut4SC6yPI=;
        b=dQofIBAbvq1f/lIPyNV7TmkQRttU+iLW9uPmRqUmjX1dD0MFzzQfmtp6Aclbvve8Kl
         u+RFVbFxwFx5fzSsDnaqn4kv6TYOzD7PMmL8ld+Mvhw6GJfpM5VUwR7o+/YpZ6XpQJSr
         uDKFI9IrWJWcuf8GLnWVR8xEVabXO9etIaIDHLMMctGIRhFhAdT56gAsyObI3UnDowPm
         O2BkZ3BIdDJSOT3xzB4kvYsfpy9N8hkoVUgZrmmIkKnbxzTJOHRrvNG3uhz9isP30TdJ
         vGhnvOTyTgWL7LdigdgX2UYb7L7PjZSNPvX6h8Ysklb3hJqP7tGn/RCGLJrdxc7TsjCj
         xHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5FoNmZ2y7OvNSXeAdJOjPOi5B43bhKY55Ut4SC6yPI=;
        b=K/OGY4ag6dbCSg5FFODJqxuPbsaUls//KPUpqJ5QVQPz4tek9x5tTainOkK1uxGshC
         5ozzkNMGTPkc1s7RoDhyJ1hE4oM/g2xz5/bT+vm+eF3sK4GMAWAEor/Ikyn3vFvknfm8
         SbAE9A2r2Di4lhA23FTz6ENPz4O8o+YGi3NLjQs839Hvh8jIa1cIySaLR/YqJwG4aIwb
         D/i0OtmHya4bQkfQFT3Ds+F3jkD1WLfBJgXI0hubq8LvbtINFS/lSTQgA1m97tKSv/jZ
         fGx6ONulPR1TbzGYhCBIx+YrgNiFXDZN0BTJkXfpF7JQqXqtcu3yUux16dfMRJ83gBpC
         BY4Q==
X-Gm-Message-State: AFqh2kqpsmD7CaLpV+XS9pzwwuJM9/XLPeKAdHcXDH7srFc1Z43J9KTR
        ZxC2zhqzsHoR7h83dtaOidFkqA==
X-Google-Smtp-Source: AMrXdXviiX6Y8Rpt3DXG7k5zgTiGCmKNfesRwsEKsVv7/PobaYLHBzweRhwBi68nm+0410tgRC5geQ==
X-Received: by 2002:a19:c515:0:b0:4bb:7028:f6b6 with SMTP id w21-20020a19c515000000b004bb7028f6b6mr794180lfe.49.1671109272992;
        Thu, 15 Dec 2022 05:01:12 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id v1-20020ac258e1000000b004946b549a19sm1157622lfo.45.2022.12.15.05.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 05:01:11 -0800 (PST)
Message-ID: <5ed623d6-3ca2-a1c4-9277-6768df5a63fe@linaro.org>
Date:   Thu, 15 Dec 2022 14:01:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sa8295p-adp: use pm8450a dtsi
Content-Language: en-US
To:     Eric Chanudet <echanude@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>
References: <20221214210908.1788284-1-echanude@redhat.com>
 <20221214210908.1788284-2-echanude@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221214210908.1788284-2-echanude@redhat.com>
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



On 14.12.2022 22:09, Eric Chanudet wrote:
> Include the dtsi to use a single pmic descriptions.
> Both sa8295p-adp and sa8540p-adp have the same spmi pmic apparently.
> 
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 79 +-----------------------
>  1 file changed, 1 insertion(+), 78 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index 84cb6f3eeb56..889259df3287 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/spmi/spmi.h>
>  
>  #include "sa8540p.dtsi"
> +#include "pm8450a.dtsi"
I feel like naming it  sa8540p-pmics.dtsi (like sc8280xp-pmics.dtsi)
would be more representative of what's really going on (unless it's
a single chip providing 4 virtual PMICs on different SIDs).

Konrad
>  
>  / {
>  	model = "Qualcomm SA8295P ADP";
> @@ -260,84 +261,6 @@ &remoteproc_nsp1 {
>  	status = "okay";
>  };
>  
> -&spmi_bus {
> -	pm8450a: pmic@0 {
> -		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> -		reg = <0x0 SPMI_USID>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		rtc@6000 {
> -			compatible = "qcom,pm8941-rtc";
> -			reg = <0x6000>;
> -			reg-names = "rtc", "alarm";
> -			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
> -			wakeup-source;
> -		};
> -
> -		pm8450a_gpios: gpio@c000 {
> -			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
> -			reg = <0xc000>;
> -			gpio-controller;
> -			gpio-ranges = <&pm8450a_gpios 0 0 10>;
> -			#gpio-cells = <2>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -	};
> -
> -	pm8450c: pmic@4 {
> -		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> -		reg = <0x4 SPMI_USID>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		pm8450c_gpios: gpio@c000 {
> -			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
> -			reg = <0xc000>;
> -			gpio-controller;
> -			gpio-ranges = <&pm8450c_gpios 0 0 10>;
> -			#gpio-cells = <2>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -	};
> -
> -	pm8450e: pmic@8 {
> -		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> -		reg = <0x8 SPMI_USID>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		pm8450e_gpios: gpio@c000 {
> -			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
> -			reg = <0xc000>;
> -			gpio-controller;
> -			gpio-ranges = <&pm8450e_gpios 0 0 10>;
> -			#gpio-cells = <2>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -	};
> -
> -	pm8450g: pmic@c {
> -		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> -		reg = <0xc SPMI_USID>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		pm8450g_gpios: gpio@c000 {
> -			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
> -			reg = <0xc000>;
> -			gpio-controller;
> -			gpio-ranges = <&pm8450g_gpios 0 0 10>;
> -			#gpio-cells = <2>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -		};
> -	};
> -};
> -
>  &ufs_mem_hc {
>  	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
>  
