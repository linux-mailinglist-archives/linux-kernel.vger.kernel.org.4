Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B42269916F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBPKfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBPKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:35:36 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881126877
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:35:06 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a9so1424949ljr.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hK+neZ3A9ezmQ3LtMVZ4gSz8RYGyYejMFdpYpzA4Lw=;
        b=lcZlxY09vmRdjZwkKDUtsPtOhh4D8e8hAmLG5quNTxBQNUdT5AX/qACIuBObTx+ur7
         nje39iWoD5SCm1h4EBwTHHDon3UScA1wVaGf1PKvG+lkMdVkItuSQlj54ovnvhR0Wk+V
         Uo44OaBNLr+vAQJGNhdZjAdKG8jPAcXKatzd/rGsYmmPNGXJp6iup1zZiGOVAwsFiEBL
         WDe9xziyTOKlkLK5c+2KuvnFWaJF2btUOPfWYa9piIDJ7igbFBeT6vr5nawiV6VpbS75
         gXHjJ68QHntH+U6SHki63uKALEXNlsgzlHUEWCEOVzAaP/gVy/msniX22u30VNScCZVe
         sUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hK+neZ3A9ezmQ3LtMVZ4gSz8RYGyYejMFdpYpzA4Lw=;
        b=hvV1LnV6eisnuZMmBIfxqGsp5VlkjpJAWsxX2zOa/iVCqa2SkIKoabHR+P5IRg3GwI
         XSU0eDShVfDTYrh+h9f61CJMNlJVOKfvFB77kOu61EjeoTinpdbSmgxALCvHT+KoidrQ
         Jenfx9mANvCRFa/lZbW7fSCAZp4KhZweTzj5H1Ihx8HMRjgmVBXhTGsTICP8pP2l4S7U
         Woz1ya5ZmqZtDmPXLZ8l0E6X5wKgEIIIic9hEsk2OAsPo/VQgzPCSD22J1FuP9ehhwvv
         vT5jvtlxr7s4Wx2leUdDriXqjhUqxMcpOUoD/2xeIEBD5rvgflDIH+SuAyAHcbCWMfKm
         omFQ==
X-Gm-Message-State: AO0yUKXKmb/m9ItPPficL0csQgFFDHWyRBss7Shq7mCK5jG5Zvnm7pd/
        tyztfZIAFiczIoC/LQuSG++FXg==
X-Google-Smtp-Source: AK7set+iY55rVKzrmDqrO4lrqVA3D5LG263mVMA/Zu06/sBkfFM76s91p/vnypeceJq/piO0KOsYHw==
X-Received: by 2002:a2e:a98c:0:b0:293:7bce:2374 with SMTP id x12-20020a2ea98c000000b002937bce2374mr2213931ljq.33.1676543691275;
        Thu, 16 Feb 2023 02:34:51 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id g28-20020a2eb5dc000000b002934196e762sm142732ljn.54.2023.02.16.02.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:34:50 -0800 (PST)
Message-ID: <69bbe1ef-9ea9-b577-7660-c2997fa66f5c@linaro.org>
Date:   Thu, 16 Feb 2023 11:34:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RESEND PATCH 02/12] arm64: dts: qcom: sc7280: Supply clock from
 cpufreq node to CPUs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
 <20230215070400.5901-3-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230215070400.5901-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.02.2023 08:03, Manivannan Sadhasivam wrote:
> Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
> to the CPU cores. But this relationship is not represented in DTS so far.
> 
> So let's make cpufreq node as the clock provider and CPU nodes as the
> consumers. The clock index for each CPU node is based on the frequency
> domain index.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index bdcb74925313..d9b6e028cdac 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -168,6 +168,7 @@ CPU0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x0>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
>  					   &LITTLE_CPU_SLEEP_1
> @@ -193,6 +194,7 @@ CPU1: cpu@100 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x100>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
>  					   &LITTLE_CPU_SLEEP_1
> @@ -214,6 +216,7 @@ CPU2: cpu@200 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x200>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
>  					   &LITTLE_CPU_SLEEP_1
> @@ -235,6 +238,7 @@ CPU3: cpu@300 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x300>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
>  					   &LITTLE_CPU_SLEEP_1
> @@ -256,6 +260,7 @@ CPU4: cpu@400 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x400>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&BIG_CPU_SLEEP_0
>  					   &BIG_CPU_SLEEP_1
> @@ -277,6 +282,7 @@ CPU5: cpu@500 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x500>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&BIG_CPU_SLEEP_0
>  					   &BIG_CPU_SLEEP_1
> @@ -298,6 +304,7 @@ CPU6: cpu@600 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x600>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&BIG_CPU_SLEEP_0
>  					   &BIG_CPU_SLEEP_1
> @@ -319,6 +326,7 @@ CPU7: cpu@700 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x700>;
> +			clocks = <&cpufreq_hw 2>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&BIG_CPU_SLEEP_0
>  					   &BIG_CPU_SLEEP_1
> @@ -5337,6 +5345,7 @@ cpufreq_hw: cpufreq@18591000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
>  			clock-names = "xo", "alternate";
>  			#freq-domain-cells = <1>;
> +			#clock-cells = <1>;
>  		};
>  	};
>  
