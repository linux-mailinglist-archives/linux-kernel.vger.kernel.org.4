Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F5672995
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjARUlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjARUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:40:59 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132073A844
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:40:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bk15so232984ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vO/4KjLR5OFSgF1jEIWY7wmER0epanj/ZLVzydWABo=;
        b=CLP+uaiQzHUdvSSDuWzdihPPqyUthH7f4vPLbCUoySgYOnia3LP2vD2od9HwH+VGtc
         sqGSUiVGksS55VFUqqIylQJ9h6dISv37BmOKjGGDgAFnV7IBQOxryX8Z4SmuPzFTErxl
         dTLBS5KgyjEef4YYKxsBm78Vterl8sJ233wMJQ+i60V9F0kG3IFL3ISh6um9Mb9Od0Z9
         aRWheTdYes2Ptj9DO2NhKksHIWnfPE0DIIc0gfPw7cxFFlThlGfAa4dNhInTtfD9CygX
         zn06WmlH1f7vvTc411chqBF3PkjnXdomfQLhT/anJzAOS2vxckk3mCVt9zt/j0Fwdpae
         TMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vO/4KjLR5OFSgF1jEIWY7wmER0epanj/ZLVzydWABo=;
        b=muBRPOWuBVmpXxFmm9gc3bbtxmqYNOhYtuLfpeETJZIMfKFqdzFCCu4yqkhjL4tEL4
         94oshIyvpeZGM7ncI04XUBLn3PBYpZJx7qaL0E1co07PkN333+ekWLX9QHcniqnR5c+h
         WTmL1/sa8yvik5YPW2KE8ubTD2IJB3vsLUEqGgQ1YzmK8C+uYLgB5Vt3spmaaPEyR7H/
         +KQfP+Sw2ykNG9YTmGi6vW9sWWzFspy+yjzhAzZG5LfNV1t8i0nPjXF3zvb43Pb91KTe
         Bq5gSwgNpW2x3KAlHlxnoioR28qSheo+oyog6nYEb+4JY//cydUxYLKWNdNWXGK47KYU
         MH2Q==
X-Gm-Message-State: AFqh2korLVw2bxoqcwxh1E885roma5YJ/8x7zlc0zGSNeGvveDCwVPWl
        7erHzuhGgB86bw3FJA0jPCn0DQ==
X-Google-Smtp-Source: AMrXdXvtas7dE8lOX47LZPKM/W6Ik6fEI1CUyDFqYVLL7rJxY8KO85yMqzDSUVWhCekBl+VTkw2UwA==
X-Received: by 2002:a17:906:758:b0:84d:12d8:e1e9 with SMTP id z24-20020a170906075800b0084d12d8e1e9mr7634780ejb.41.1674074455601;
        Wed, 18 Jan 2023 12:40:55 -0800 (PST)
Received: from [192.168.1.101] (abxh150.neoplus.adsl.tpnet.pl. [83.9.1.150])
        by smtp.gmail.com with ESMTPSA id b1-20020a1709063ca100b007af0f0d2249sm15176216ejh.52.2023.01.18.12.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 12:40:55 -0800 (PST)
Message-ID: <77fbf01f-58fc-55a2-415b-c39d991e7c96@linaro.org>
Date:   Wed, 18 Jan 2023 21:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add CPU idle-states
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230118203428.910992-1-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230118203428.910992-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.01.2023 21:34, Bhupesh Sharma wrote:
> Add CPU idle-state nodes and power-domains in Qualcomm sm6115 SoC dtsi.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 104 +++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 478c5d009272..29c05cbb5fd7 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -44,6 +44,8 @@ CPU0: cpu@0 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> @@ -59,6 +61,8 @@ CPU1: cpu@1 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD1>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU2: cpu@2 {
> @@ -70,6 +74,8 @@ CPU2: cpu@2 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD2>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU3: cpu@3 {
> @@ -81,6 +87,8 @@ CPU3: cpu@3 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> +			power-domains = <&CPU_PD3>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU4: cpu@100 {
> @@ -92,6 +100,8 @@ CPU4: cpu@100 {
>  			dynamic-power-coefficient = <282>;
>  			next-level-cache = <&L2_1>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			power-domains = <&CPU_PD4>;
> +			power-domain-names = "psci";
>  			L2_1: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> @@ -107,6 +117,8 @@ CPU5: cpu@101 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_1>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			power-domains = <&CPU_PD5>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU6: cpu@102 {
> @@ -118,6 +130,8 @@ CPU6: cpu@102 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_1>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			power-domains = <&CPU_PD6>;
> +			power-domain-names = "psci";
>  		};
>  
>  		CPU7: cpu@103 {
> @@ -129,6 +143,8 @@ CPU7: cpu@103 {
>  			enable-method = "psci";
>  			next-level-cache = <&L2_1>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> +			power-domains = <&CPU_PD7>;
> +			power-domain-names = "psci";
>  		};
>  
>  		cpu-map {
> @@ -168,6 +184,41 @@ core3 {
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
> +				min-residency-us = <800>;
I think this value is incorrect, see:

https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/tags/android-11.0.0_r0.56/qcom/bengal-pm.dtsi#99

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
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "domain-idle-state";
> +				idle-state-name = "cluster-power-collapse";
> +				arm,psci-suspend-param = <0x41000043>;
> +				entry-latency-us = <800>;
> +				exit-latency-us = <2118>;
> +				min-residency-us = <7376>;
These values vary per cluster, see qcom,pm-cluster-level@2 in the
file linked above.. We should either split that, or at least take
max() of each value between the two nodes to make sure the sleep
state is exited properly on both types of cores.

Konrad
> +			};
> +		};
>  	};
>  
>  	firmware {
> @@ -191,6 +242,59 @@ pmu {
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> +
> +		CPU_PD0: power-domain-cpu0 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD1: power-domain-cpu1 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD2: power-domain-cpu2 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD3: power-domain-cpu3 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD4: power-domain-cpu4 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD5: power-domain-cpu5 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD6: power-domain-cpu6 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD7: power-domain-cpu7 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CLUSTER_PD: power-domain-cpu-cluster0 {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_SLEEP_0>;
> +		};
>  	};
>  
>  	reserved_memory: reserved-memory {
