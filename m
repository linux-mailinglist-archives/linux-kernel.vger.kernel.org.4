Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90365699188
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBPKhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjBPKgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:36:48 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617F55E44
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:36:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o20so2216502lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JW0EJLLZnjtc5Rcfkvi40WpRhRyZAMonDW3VQmeurE=;
        b=yzXttBf1kKa3GcyNUHCHisd7ta+C+4p+1Da1kfUuXpPyL7tA7mKigBSV2fYj/aWmYz
         bwx4j/ZykC9mmoixS3ryXfMXOOMOZmL1X8XjFdN/CF1nVkcIfP61OsMGTB49JlSEOv78
         ylQlGq9qwWnORdQOO/Uj9RRMEzWK13MWJgKeA0whYjG2FH8yl2qgZWGVJRcOTgFqCiYX
         V9v0OnrkJNa6BiYuj1Vd7KF0e6Ly+dfBjeLHNHhNjK83OI8Pv4a9pivlc7zbjpJzAshc
         yrAtjxWseSXdFpv0oNQwp9Ec2kqFRUwZkKQM9YqhtdBn2QyQfs/eqFfene4vI0uVsFqU
         3X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JW0EJLLZnjtc5Rcfkvi40WpRhRyZAMonDW3VQmeurE=;
        b=yIK4hEPeyBYMtU2TOtVFvKHMXtWWEh5C4l1ygeoyAucMzxXHwsXYsSnxPV2hyeyDM0
         uj6wIP/3m+USBmLnbQcGVzBowVjFfUBGK9U/kx7fyI8cOe+3G62s9anbI58RGKj9NAGN
         XAuH5cecxM4PEVIqj2azyfA2HFBY7ZbfBRiwlQ4MRYBvWv5QzsrIRzor8Jhf4nHnG6xC
         X6dpJy9dfUampVjHoPvSfIcjgaQFG7CgTny/rlr6/5xzvX7njjs5WI70hb2SrvXrbkmD
         i8tsK0D8rEADIO9/FpT7St4HjRAybleUOIza+o4upweVBU5jxqOx54mP+5SGot9NyaBD
         7Lbg==
X-Gm-Message-State: AO0yUKUa9CxxMdKG2eP/9U0/Cjc1ffSqslsCY3YeR4lhDgNb0+YTfHM+
        8SW7cDsFT9c43Vc4ssksGYLixg==
X-Google-Smtp-Source: AK7set9bDLo2KXqnfy06cq8SDtYjejF0UqV3SI7k8ZIMZ0EQ2wD7PrX42mQ+7fkiX2EWyaUv9/TRoQ==
X-Received: by 2002:ac2:4a8b:0:b0:4cb:3b24:8390 with SMTP id l11-20020ac24a8b000000b004cb3b248390mr1504447lfp.59.1676543780089;
        Thu, 16 Feb 2023 02:36:20 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id p3-20020a05651211e300b004db50ad07ffsm246087lfs.247.2023.02.16.02.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:36:19 -0800 (PST)
Message-ID: <0c7e3064-4ad0-949a-76a6-4da548892ce8@linaro.org>
Date:   Thu, 16 Feb 2023 11:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RESEND PATCH 04/12] arm64: dts: qcom: sm8550: Supply clock from
 cpufreq node to CPUs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
 <20230215070400.5901-5-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230215070400.5901-5-manivannan.sadhasivam@linaro.org>
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
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 9910006c32aa..21b4f668889d 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -68,6 +68,7 @@ CPU0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0 0>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			power-domains = <&CPU_PD0>;
> @@ -91,6 +92,7 @@ CPU1: cpu@100 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0 0x100>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_100>;
>  			power-domains = <&CPU_PD1>;
> @@ -110,6 +112,7 @@ CPU2: cpu@200 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0 0x200>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_200>;
>  			power-domains = <&CPU_PD2>;
> @@ -129,6 +132,7 @@ CPU3: cpu@300 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0 0x300>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_300>;
>  			power-domains = <&CPU_PD3>;
> @@ -148,6 +152,7 @@ CPU4: cpu@400 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0 0x400>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_400>;
>  			power-domains = <&CPU_PD4>;
> @@ -167,6 +172,7 @@ CPU5: cpu@500 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0 0x500>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_500>;
>  			power-domains = <&CPU_PD5>;
> @@ -186,6 +192,7 @@ CPU6: cpu@600 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0 0x600>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_600>;
>  			power-domains = <&CPU_PD6>;
> @@ -205,6 +212,7 @@ CPU7: cpu@700 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo";
>  			reg = <0 0x700>;
> +			clocks = <&cpufreq_hw 2>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_700>;
>  			power-domains = <&CPU_PD7>;
> @@ -3341,6 +3349,7 @@ cpufreq_hw: cpufreq@17d91000 {
>  				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
>  			#freq-domain-cells = <1>;
> +			#clock-cells = <1>;
>  		};
>  
>  		pmu@24091000 {
