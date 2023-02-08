Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4868EA15
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjBHIlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHIlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:41:49 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8E361B9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:41:46 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id dr8so49298975ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cowMgdVVce2YEU/O4CV7OH5p7i/M6pnk167JI1fR2k=;
        b=lXwiQ0w8eMY61i0eokC7ajHQEkZlNSftADlOJ+6X82cK7Z6ei+uW6QWXBtNe8LJbb/
         zTKJiSuqfawyscUdhw9s7vCnNyJk+1YQ0WnxMOR87LXDWDa5iRAXBHr0jUg/Lt6ESqNh
         g8WNN4LZoH/7zX+1bghWGzmpVd5/v8yq/Fgbwde30UE7NW4w1WhHaiDycLaphYYv78PT
         iSMvEnQhND8ZpT1Qa1dxMOdNlLFowZOcHh5Lb0IEUkZS91w8uFPlvl2WVJHSEJP2cKeG
         ZhB4m7vXVY4kBGyQB9u0iGExedDWWT0mV1lxj2djzqsoTA//YWwjFC8m43P+AnBuVpYM
         N3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cowMgdVVce2YEU/O4CV7OH5p7i/M6pnk167JI1fR2k=;
        b=1fvSS4svvgO1MF/Km3P2Css9HAeyZmGT4lCPZ6h8ENkkd771zqAzI5MwcJoicm5EDu
         5mbu/T0weYzj6f6QC9KMmnsjmNU7s+hPv996+ClIguO+sbCvWZDc3aviLsD0cRZ/bxgl
         EWYyuNWWcTPH7PxD0m8hqBwXrkkcbNbtl1Y52th6KlaOZg3JixJLkhtGIW1LfvGCCsCp
         mdWhqSylGIciWqGl72vc2NsWFeAjLJbSpduBUmHjkz2QVIPq8tj4gp6GWNtdAqUt8z4P
         uyE3cnmaUJ39KeI/6UyZCEkJDL4/FqOyfI1uGPfcwttdUNrqkVutPsEXkj4dnF58ZlSq
         CKOw==
X-Gm-Message-State: AO0yUKV7+W5vHmrShhIzMg+h840smqCbryUN1O7FqQpXDIgML08U6Fus
        YHOe/BOXpbCOdRYavwm2gSdsmg==
X-Google-Smtp-Source: AK7set9B9pZznYh5QAyqe1FIgEzHN27CtSxFMiPwNLjhR4yrdj7slXMuyUoTGhnxQZkcE+YQG380ZQ==
X-Received: by 2002:a17:906:7097:b0:888:94d3:37f5 with SMTP id b23-20020a170906709700b0088894d337f5mr5975771ejk.63.1675845705328;
        Wed, 08 Feb 2023 00:41:45 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id kq9-20020a170906abc900b008aa4705adb0sm1695789ejb.5.2023.02.08.00.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 00:41:44 -0800 (PST)
Message-ID: <61ca391d-05d4-d02b-f57e-5dd0297feceb@linaro.org>
Date:   Wed, 8 Feb 2023 09:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 5/5] arm64: dts: qcom: ipq5332: enable the CPUFreq
 support
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20230208042850.1687-1-quic_kathirav@quicinc.com>
 <20230208042850.1687-6-quic_kathirav@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230208042850.1687-6-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.02.2023 05:28, Kathiravan T wrote:
> Add the APCS, A53 PLL, cpu-opp-table nodes to bump the CPU frequency
> above 800MHz.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
> 	- No changes
> 
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 37 +++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index bdf33ef30e10..cec2828c51f8 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
> +#include <dt-bindings/clock/qcom,apss-ipq.h>
>  #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> @@ -35,6 +36,8 @@
>  			reg = <0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		CPU1: cpu@1 {
> @@ -43,6 +46,8 @@
>  			reg = <0x1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		CPU2: cpu@2 {
> @@ -51,6 +56,8 @@
>  			reg = <0x2>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		CPU3: cpu@3 {
> @@ -59,6 +66,8 @@
>  			reg = <0x3>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
> +			operating-points-v2 = <&cpu_opp_table>;
>  		};
>  
>  		L2_0: l2-cache {
> @@ -67,6 +76,16 @@
>  		};
>  	};
>  
> +	cpu_opp_table: opp-table-cpu{
opp-table-cpu {
+ sort this properly (by node name, not label), please

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-1488000000 {
Why only one (presumably FMAX) target? This sounds
very destructive to power consumption, and by extension
heat output.

The other changes generally look good fwiw.

Konrad
> +			opp-hz = /bits/ 64 <1488000000>;
> +			clock-latency-ns = <200000>;
> +		};
> +	};
> +
>  	firmware {
>  		scm {
>  			compatible = "qcom,scm-ipq5332", "qcom,scm";
> @@ -199,6 +218,24 @@
>  			};
>  		};
>  
> +		apcs_glb: mailbox@b111000 {
> +			compatible = "qcom,ipq5332-apcs-apps-global",
> +				     "qcom,ipq6018-apcs-apps-global";
> +			reg = <0x0b111000 0x1000>;
> +			#clock-cells = <1>;
> +			clocks = <&a53pll>, <&xo_board>;
> +			clock-names = "pll", "xo";
> +			#mbox-cells = <1>;
> +		};
> +
> +		a53pll: clock@b116000 {
> +			compatible = "qcom,ipq5332-a53pll";
> +			reg = <0x0b116000 0x40>;
> +			#clock-cells = <0>;
> +			clocks = <&xo_board>;
> +			clock-names = "xo";
> +		};
> +
>  		timer@b120000 {
>  			compatible = "arm,armv7-timer-mem";
>  			reg = <0x0b120000 0x1000>;
