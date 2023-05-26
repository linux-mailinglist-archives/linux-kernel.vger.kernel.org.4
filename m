Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1BD7127B2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbjEZNiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243756AbjEZNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:38:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA09D8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:38:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so5484815e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685108283; x=1687700283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRNhz/1ssZp7GmMjGCU/2aCWcpCSy7S5uy3uYHdmw7Y=;
        b=UK2zb07TRRz408dzHN0N/0vYmIJfV431IB7X8ANOYPkRHJPIfACk52Z+ortc1DPIGR
         ym3FHdPARthYj9fHb1Y77DWDBlDDxcN6mz8VnzkIC83BfLSOozkYbj6WeZWqN84w5zhB
         48eJuVq+F92uKNK/YsObvKq0i/YjH6oNpyqSFUqJOYhaJC+bb8iExFUzUgidocdy+UQ7
         v+fwn+FgrB1OTSQpbGwM5C0/mHtFV4UHHIgIasF4MVW0cfxPC89wAdiYN3fUfwQ4kTEF
         DjUMj8J6g4qvUnl762VOKsF3aEmswJ4TZUDK1gGmpRlkYSNOvnChdVdAh3HR0Oix55pz
         EQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685108283; x=1687700283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRNhz/1ssZp7GmMjGCU/2aCWcpCSy7S5uy3uYHdmw7Y=;
        b=PCKaDzyP+cVpmgdrq5nKo332uqOA0wtI4zcbQ44ZlC/Lfok+rEuIX3SzY835P5H+j9
         xgYsGZZx/Mw80C27finwGkjv4v6JX9mw4ALOgWh729lhiRguz1UOVVzszo75cqpmPtNe
         M0Vce3cC+APx330x/8ltVAPBxA4zuR6GDdo+0wkcxatni/vqJLP22gXMpkUcCdAyAZHe
         M1/eWmH6AZCKvTlzhDF9e4tVnJ3f6YDt2PEfZUBpwEh3WPAxne7q4UuUf6v+YJmkGZTC
         0Yptm+H5P7xCqCFO4oP+yvBfh5j8aBsj0z1CzZhtW2JcLIjYJSlzHl8zagc+/tza/XCE
         yoxw==
X-Gm-Message-State: AC+VfDxQvH558qlcbSAtn5T3uFEk3w8rdoL97JBzsd41LJQxUw/HZgRG
        gV/UxWa9dV4yf8Yi2igVVSrLmw==
X-Google-Smtp-Source: ACHHUZ4/TvkidQGqm2je1FAQ3GSQm0puIZ2fO6yxBGt5bIoGb3dqxAif8j+LCNz9JMwYn75vWYsdtg==
X-Received: by 2002:a7b:c412:0:b0:3f5:fa8e:aaa3 with SMTP id k18-20020a7bc412000000b003f5fa8eaaa3mr1595377wmi.28.1685108283226;
        Fri, 26 May 2023 06:38:03 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c294b00b003f6129d2e30sm8900220wmd.1.2023.05.26.06.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 06:38:02 -0700 (PDT)
Message-ID: <cae30437-f9bc-6e7a-8371-bba7eeff1e8f@linaro.org>
Date:   Fri, 26 May 2023 14:38:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/8] arm64: dts: qcom: msm8916: Fix regulator constraints
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
 <20230510-msm8916-regulators-v1-3-54d4960a05fc@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230510-msm8916-regulators-v1-3-54d4960a05fc@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 19:48, Stephan Gerhold wrote:
> The regulator constraints for most MSM8916 devices (except DB410c) were
> originally taken from Qualcomm's msm-3.10 vendor device tree (for lack
> of better documentation). Unfortunately it turns out that Qualcomm's
> voltages are slightly off as well and do not match the voltage
> constraints applied by the RPM firmware.
> 
> This means that we sometimes request a specific voltage but the RPM
> firmware actually applies a much lower or higher voltage. This is
> particularly critical for pm8916_l11 which is used as SD card VMMC
> regulator: The SD card can choose a voltage from the current range of
> 1.8 - 2.95V. If it chooses to run at 1.8V we pretend that this is fine
> but the RPM firmware will still silently end up configuring 2.95V.
> This can be easily reproduced with a multimeter or by checking the
> SPMI hardware registers of the regulator.
> 
> Fix this by making the voltages match the actual "specified range" in
> the PM8916 Device Specification which is enforced by the RPM firmware.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>   arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts           | 14 +++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts       | 14 +++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts             | 14 +++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts         | 14 +++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts             | 12 ++++++------
>   arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts       | 14 +++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts       | 14 +++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 14 +++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi   | 14 +++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi    | 14 +++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts     | 14 +++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi                  | 14 +++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts      | 12 ++++++------
>   13 files changed, 89 insertions(+), 89 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> index 13cd9ad167df..0d517804e44e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> @@ -159,13 +159,13 @@ &smd_rpm_regulators {
>   	vdd_l7-supply = <&pm8916_s4>;
>   
>   	s3 {
> -		regulator-min-microvolt = <1200000>;
> -		regulator-max-microvolt = <1300000>;
> +		regulator-min-microvolt = <1250000>;
> +		regulator-max-microvolt = <1350000>;

Where are you getting these 5s from ?

>   	};
>   
>   	s4 {
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <2100000>;
> +		regulator-min-microvolt = <1850000>;
> +		regulator-max-microvolt = <2150000>;
>   	};
>   
>   	l1 {
> @@ -199,7 +199,7 @@ l7 {
>   	};
>   
>   	l8 {
> -		regulator-min-microvolt = <2850000>;
> +		regulator-min-microvolt = <2900000>;
>   		regulator-max-microvolt = <2900000>;
>   	};
>   
> @@ -209,12 +209,12 @@ l9 {
>   	};
>   
>   	l10 {
> -		regulator-min-microvolt = <2700000>;
> +		regulator-min-microvolt = <2800000>;
>   		regulator-max-microvolt = <2800000>;
>   	};
>   
>   	l11 {
> -		regulator-min-microvolt = <1800000>;
> +		regulator-min-microvolt = <2950000>;

Wouldn't 1v8 be the right voltage for eMMC !SD though have you tested 
eMMC instead of SD ?

---
bod

