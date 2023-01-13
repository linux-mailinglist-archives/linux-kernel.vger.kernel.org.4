Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52C7669CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjAMPlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjAMPlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:41:07 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727F07D25E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:32:49 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id x37so22810221ljq.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvGqtD0vaEdCq6Jrz2aJKXvMSqDV7y3ghbHDsmS6aUg=;
        b=WShKkgwSKxwnCM5q9NWeicjuMObQBy2sGtAadPAmoSPejSTxWmyHscrB8HuuxP2knT
         YzYQ8UAAWTq024aVnxQagCtBT11LXpl/LKjQkcDWRDWujkV7dfcxbrsq/o3z1NE6z1Tv
         agX/mrpXaZtag5WYqk8Ze7mOYg6wmocF9nl+JYnQ4P2kS+CVuUpN8nF8QpvsJNxp3Dt/
         5V3nmyDn1jCNG2KZEw10O5ZPrOKNlFGDNi6U3hjWbRs/q0bWtLtnp7BMYpICtE8E0tu2
         u7wX0Zm1zZylg07OBatuowBGLegdzLCZsHn0H5K1jKj0T4xULt3dQTpQ/AiaUW4u8cvj
         iFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvGqtD0vaEdCq6Jrz2aJKXvMSqDV7y3ghbHDsmS6aUg=;
        b=Ia+0RDxoaaFEMkNhNktmm5w1JjGqT5e6NPbZpjrOV2n/MBieghhBlePUKzC5F4D8Yh
         qjANA+v9fyqw1+nqK98Is3W7PyGDhaZ9tF/ywYJLE8VMoNgXf7hCV7ES5hF3cLTWOv34
         y8i9YhIf9sDlg2r2J8h69MExvgzESubUmhYYB7umUKyZQkvmBiuS20j7V+fLWi1yR6ch
         WDolmahNWGwMD3c/GLHQhcJFGH9YoLQ5wimnNeCsgS0/FVEnioJAuV9MLwahwh4Lmztl
         YZbGEqbckExQfX/NkRPgRR/25Hv0gw3+vwO2iJBcZExPydqs2OSZje+CHydC2TJDBcG3
         xg1g==
X-Gm-Message-State: AFqh2kp+7MXdlgADufBqSZr2ymaMFy+V1PtyXUAnn8howDkaX4JJdr3p
        RrbvkrB4JD/FTYwvXrgeZbuCbA==
X-Google-Smtp-Source: AMrXdXucRYt3swxHwKrnEfP7mbphGpw0NJKZN1uVdF19616i3aXJztERykz/cMkbkGdSi5Zxl070fA==
X-Received: by 2002:a2e:9310:0:b0:28b:6936:30bc with SMTP id e16-20020a2e9310000000b0028b693630bcmr662578ljh.31.1673623967774;
        Fri, 13 Jan 2023 07:32:47 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id r17-20020a2eb891000000b00288a8094a76sm1010768ljp.60.2023.01.13.07.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 07:32:46 -0800 (PST)
Message-ID: <4114bf50-67bf-e11c-5304-f2c6dcc0063d@linaro.org>
Date:   Fri, 13 Jan 2023 16:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq9574: Add cpufreq & RPM related
 nodes
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-6-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230113150310.29709-6-quic_devipriy@quicinc.com>
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



On 13.01.2023 16:03, devi priya wrote:
> Add CPU Freq and RPM related nodes in the device tree
These two are wildly different things, barely related to one
another and can very well be introduced in separate patches.
Please do so.

> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 80 +++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 5a2244b437ed..79fa5d91882c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-ipq9574.h>
>  #include <dt-bindings/reset/qcom,gcc-ipq9574.h>
> +#include <dt-bindings/clock/qcom,apss-ipq.h>
Please sort the includes alphabetically.

>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -75,6 +76,10 @@
>  			reg = <0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu0-supply = <&ipq9574_s1>;
Why is this cpu0-supply and the rest are cpu-supply? Neither of them
seem particularly documented, by the way..


>  		};
>  
>  		CPU1: cpu@1 {
> @@ -83,6 +88,10 @@
>  			reg = <0x1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu-supply = <&ipq9574_s1>;
>  		};
>  
>  		CPU2: cpu@2 {
> @@ -91,6 +100,10 @@
>  			reg = <0x2>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu-supply = <&ipq9574_s1>;
>  		};
>  
>  		CPU3: cpu@3 {
> @@ -99,6 +112,10 @@
>  			reg = <0x3>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu_opp_table>;
> +			cpu-supply = <&ipq9574_s1>;
>  		};
>  
>  		L2_0: l2-cache {
> @@ -107,6 +124,42 @@
>  		};
>  	};
>  
> +	cpu_opp_table: opp-table-cpu {
Alphabetically this goes after memory

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-936000000 {
> +			opp-hz = /bits/ 64 <936000000>;
> +			opp-microvolt = <725000>;
> +			clock-latency-ns = <200000>;
> +		};
Please add a newline between each subnode.

> +		opp-1104000000 {
> +			opp-hz = /bits/ 64 <1104000000>;
> +			opp-microvolt = <787500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp-1416000000 {
> +			opp-hz = /bits/ 64 <1416000000>;
> +			opp-microvolt = <862500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp-1488000000 {
> +			opp-hz = /bits/ 64 <1488000000>;
> +			opp-microvolt = <925000>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp-1800000000 {
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <987500>;
> +			clock-latency-ns = <200000>;
> +		};
> +		opp-2208000000 {
> +			opp-hz = /bits/ 64 <2208000000>;
> +			opp-microvolt = <1062500>;
> +			clock-latency-ns = <200000>;
> +		};
> +	};
> +
>  	memory@40000000 {
>  		device_type = "memory";
>  		/* We expect the bootloader to fill in the size */
> @@ -128,6 +181,11 @@
>  		#size-cells = <2>;
>  		ranges;
>  
> +		rpm_msg_ram: memory@60000 {
> +			reg = <0x0 0x00060000 0x0 0x6000>;
> +			no-map;
> +		};
> +
>  		tz_region: memory@4a600000 {
>  			reg = <0x0 0x4a600000 0x0 0x400000>;
>  			no-map;
> @@ -324,6 +382,28 @@
>  		};
>  	};
>  
> +	rpm-glink {
> +		compatible = "qcom,glink-rpm";
> +		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +		mboxes = <&apcs_glb 0>;
> +
> +		rpm_requests: glink-channel {
> +			compatible = "qcom,rpm-ipq9574";
> +			qcom,glink-channels = "rpm_requests";
> +
> +			regulators {
> +				compatible = "qcom,rpm-ipq9574-mp5496-regulators";
The regulators are board-specific and should not be included in the
SoC DTSI. If this is a very common configuration, you may split that
into ipq9574-mp5496.dtsi, for example. Or ipq9574-pmics.dtsi if it's
coupled with more PMICs.

> +
> +				ipq9574_s1: s1 {
> +					regulator-min-microvolt = <587500>;
> +					regulator-max-microvolt = <1075000>;
> +					regulator-always-on;
Won't this break CPU retention?

You're holding a vote on it from the CPU devices, so it should be
always enabled when the CPUs are oneline (as far as Linux is
concerned).


Or maybe Linux will think it's enabled and RPM will quietly park
it when it decides it's good to do so.. but will it with an active
request.. not sure, really.. just something to consider..

Konrad
> +				};
> +			};
> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
