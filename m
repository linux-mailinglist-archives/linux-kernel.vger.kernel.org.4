Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEB06D30B8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 14:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDAMVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 08:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDAMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 08:21:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D5C1A473
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 05:21:33 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 20so25762933lju.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680351692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZ2ewhbHO8gaVPhu+Agj8Vv62N4QLjibp6e4jDmUV/Y=;
        b=FPxzYjka4DKzGeWgiF70dDCv1l3rXWTAO67npQHzlvtK1jmylgS32BCQEz6um6UnWP
         S4qpjwyPcHTcu6fo9OmTt07m+TZa0mzIphw4WyCJA+1ki9ThfEOKoT3+VRKlajpQd3jW
         U9WvZ2dJqHzU9uJnrDIxkRkjR3ukttAn0U4ayxqqoeyTvEDakpL6M7BP+CVWt37oOeMC
         j/4P3WsBn76jnqHMPzlk0IqvqedlJocDD9gc86BbVsl0nzuh7EqybFfJYIA9+ptZ0kmf
         guXc4xLuJVTp1L+zlaTar8IqFQETeHJ2iE04VFMVcEXF4Ac1L7ufXY7oP8+F5D/myZJt
         2meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680351692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ2ewhbHO8gaVPhu+Agj8Vv62N4QLjibp6e4jDmUV/Y=;
        b=ZIbBzLLeqtGxjh561eJ3/yFVZjkkSVRhNYGgNVrw28EjL5KTfitqtUGxU0kp7POG8E
         FVp9rrgOZMuD357pbKl+yNWLFXqehsuBJcYefqF5uDL5uiDgcfu0p4HE0q0JkOdjVrLV
         sWWPyNipLhqE85fFKYfAdh8xzWKvxfL1d5n8ORALzKs7wdPPPAqJRc1f80e6equsqgbK
         OVA4xP1vWHbuLFStdYDPoyOcI+9SGbOoNXjpgHXWDXIIQdtUafmd0orIrYz4LONU/U2Z
         6cGHiRjPT3krhuvyL0w15POfockKTKf5YTzgWbk4EY9B4ayvRmwEUhpfp8PZUp9Qb/XZ
         ckYg==
X-Gm-Message-State: AAQBX9fq9bcL1zxEkmzgq1YXskH/9XzaaWNn/7/AaesSearXLbVrHkHq
        HgevsabSgET0wsOyrA5qpUbKNw==
X-Google-Smtp-Source: AKy350bvn9XtMMorAvyMJCKZdH+KM11VYlH3otHJHzrzFhCFLo17S89b+0vEhCvj2WBvTXf0iQZ8OQ==
X-Received: by 2002:a2e:9b81:0:b0:295:a8e6:6b15 with SMTP id z1-20020a2e9b81000000b00295a8e66b15mr3721567lji.4.1680351692004;
        Sat, 01 Apr 2023 05:21:32 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id e8-20020a2e8ec8000000b00293534d9757sm789793ljl.81.2023.04.01.05.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 05:21:31 -0700 (PDT)
Message-ID: <0ff99bb5-4792-270d-b03e-2638939f160f@linaro.org>
Date:   Sat, 1 Apr 2023 14:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RESEND PATCH v2 1/1] arm64: dts: qcom: sm6115: Add CPU
 idle-states
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org
References: <20230330193303.612475-1-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230330193303.612475-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.03.2023 21:33, Bhupesh Sharma wrote:
> Add CPU idle-state nodes and power-domains in Qualcomm sm6115 SoC dtsi.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> Changes since v1:
> - v1 can be viewed here: https://lore.kernel.org/lkml/e5cda4cf-5c2a-a7ed-9e1d-1fe9f2cbef40@linaro.org
> - Addressed Konrad's comments on v1 and added GDHS and Power Collapse
>   cluster power states.
> 
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 136 +++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 2a51c938bbcb..b63395d476ed 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -45,6 +45,8 @@ CPU0: cpu@0 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> @@ -61,6 +63,8 @@ CPU1: cpu@1 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD1>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU2: cpu@2 {
> @@ -73,6 +77,8 @@ CPU2: cpu@2 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD2>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU3: cpu@3 {
> @@ -85,6 +91,8 @@ CPU3: cpu@3 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD3>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU4: cpu@100 {
> @@ -97,6 +105,8 @@ CPU4: cpu@100 {
>  			dynamic-power-coefficient = <282>;
>  			next-level-cache = <&L2_1>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			power-domains = <&CPU_PD4>;
> +			power-domain-names = "psci";
>  			L2_1: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> @@ -113,6 +123,8 @@ CPU5: cpu@101 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_1>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			power-domains = <&CPU_PD5>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU6: cpu@102 {
> @@ -125,6 +137,8 @@ CPU6: cpu@102 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_1>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			power-domains = <&CPU_PD6>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU7: cpu@103 {
> @@ -137,6 +151,8 @@ CPU7: cpu@103 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_1>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			power-domains = <&CPU_PD7>;
> +			power-domain-names = "psci";
>  		};
>  
>  		cpu-map {
> @@ -176,6 +192,68 @@ core3 {
>  				};
>  			};
>  		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "silver-rail-power-collapse";
> +				arm,psci-suspend-param = <0x40000003>;
> +				entry-latency-us = <290>;
> +				exit-latency-us = <376>;
> +				min-residency-us = <1182>;
> +				local-timer-stop;
> +			};
> +
> +			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "gold-rail-power-collapse";
> +				arm,psci-suspend-param = <0x40000003>;
> +				entry-latency-us = <297>;
> +				exit-latency-us = <324>;
> +				min-residency-us = <1110>;
> +				local-timer-stop;
> +			};
> +		};
> +
> +		domain-idle-states {
> +			CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
> +				/* GDHS */
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x40000022>;
This 0x22 ending seems very sus.

The last nibble represents the core-level power state and the
penultimate one represents the same at cluster level. A value
of 2 in that cluster nibble is actually undefined by the PSCI spec,
whereas the value of 4 (as you have in all of the other idle
states, including D3G for the perf cluster) corresponds to
"Retention", so unless there's a very weird nuance in the
TZ for this SoC, it should probably end in 0x42.

Otherwise I think this LGTM now!

Konrad
> +				entry-latency-us = <360>;
> +				exit-latency-us = <421>;
> +				min-residency-us = <782>;
> +			};
> +
> +			CLUSTER_0_SLEEP_1: cluster-sleep-0-1 {
> +				/* Power Collapse */
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x41000044>;
> +				entry-latency-us = <800>;
> +				exit-latency-us = <2118>;
> +				min-residency-us = <7376>;
> +			};
> +
> +			CLUSTER_1_SLEEP_0: cluster-sleep-1-0 {
> +				/* GDHS */
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x40000042>;
> +				entry-latency-us = <314>;
> +				exit-latency-us = <345>;
> +				min-residency-us = <660>;
> +			};
> +
> +			CLUSTER_1_SLEEP_1: cluster-sleep-1-1 {
> +				/* Power Collapse */
> +				compatible = "domain-idle-state";
> +				arm,psci-suspend-param = <0x41000044>;
> +				entry-latency-us = <640>;
> +				exit-latency-us = <1654>;
> +				min-residency-us = <8094>;
> +			};
> +		};
>  	};
>  
>  	firmware {
> @@ -199,6 +277,64 @@ pmu {
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> +
> +		CPU_PD0: power-domain-cpu0 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_0_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD1: power-domain-cpu1 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_0_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD2: power-domain-cpu2 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_0_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD3: power-domain-cpu3 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_0_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD4: power-domain-cpu4 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_1_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD5: power-domain-cpu5 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_1_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD6: power-domain-cpu6 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_1_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD7: power-domain-cpu7 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_1_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CLUSTER_0_PD: power-domain-cpu-cluster0 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_0_SLEEP_0>, <&CLUSTER_0_SLEEP_1>;
> +		};
> +
> +		CLUSTER_1_PD: power-domain-cpu-cluster1 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_1_SLEEP_0>, <&CLUSTER_1_SLEEP_1>;
> +		};
>  	};
>  
>  	reserved_memory: reserved-memory {
