Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37118649E67
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiLLMEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiLLMEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:04:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2A10FDB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:04:21 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so18175742lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GoNWm7eWviu1XQleAWkGJOCSAZGAKYrroAB/LiGPlxI=;
        b=rI88Nnx9hsh22doOcrE9gKM29uDZxvYg4h96oG5sl6sCDzpNAhi6nBn6T1WyojzEZ4
         l4DPdyL8cICi64ONqFtEIWx1RgLtwcfairk1z2xX77uNKVgRdsmzWuZPQ/ziLxzFkcol
         9E/7Wt8V9fUD4ltCWNXuQvbTT4WdVhynv7gVMfF1S8KR3uN0FyV5HJ0EMdeX8X+KN/Tc
         yMLEnTGWvJ/f2lpBOE3GFJfVsPa4Nqk+qAuOPDSdiTjzd1NkBluMF5+s8ZE4E2y4sRlH
         2ZvvItn+kAeyNRTIY3vZ3+segX7K55V1151yMvu8zVrQMlMi8IqoRmcTgh6ZrAT2Dra+
         SkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoNWm7eWviu1XQleAWkGJOCSAZGAKYrroAB/LiGPlxI=;
        b=aj7lfLKa4AWT/zpClcBEtJDhQR63pyA2svj0vDMTPCqhWKnQ3keOrEiuxt79/kMVNp
         UTQO+AwiAFm12xAYnOUO/5qWt0HVNxERn/gYqpZZn94dXedxbSfQ6C4LMC2MCJKCrxMH
         CSiVqbWaU9vzH359gimBA52x4+AeqLhVmgczXpi5l+RbIJta/jw2s3NEPuVPtNd6CvKp
         knrV1/dOowCgZnONuRxRAD6hEri+U8rDRS8xy1guxmKzrLP5rnj8RlcKXCutZhzTyhQJ
         TAhVMSaGQNjLkxsw/MiaXGAAcsoeFzMv0zajjQL/x75YyYJZNpz5zuSpcF09BX2KFgDd
         aexw==
X-Gm-Message-State: ANoB5pmoQBF1ntrw+tyT0h7cYJ/I6ajlNLXGU0bNxv7RddNxJauJ38pV
        APSjUhn/FP/ghZNapqaGpRzEJg==
X-Google-Smtp-Source: AA0mqf6rRHK7su2hexYQyj7OOjXRm79AFeSnv5/vqClQGzwMDOuz5vMHVVqgmEuylyv3ZQOsoqcOcw==
X-Received: by 2002:a05:6512:3f0f:b0:4b5:39fa:6de with SMTP id y15-20020a0565123f0f00b004b539fa06demr5109519lfa.41.1670846659423;
        Mon, 12 Dec 2022 04:04:19 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id m19-20020a056512359300b00492e3c8a986sm1600064lfr.264.2022.12.12.04.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 04:04:19 -0800 (PST)
Message-ID: <ecb97537-ad31-4acc-4e5a-7f464c2912ab@linaro.org>
Date:   Mon, 12 Dec 2022 13:04:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: sdm845: order top-level nodes
 alphabetically
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org>
 <20221212100232.138519-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221212100232.138519-2-krzysztof.kozlowski@linaro.org>
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



On 12.12.2022 11:02, Krzysztof Kozlowski wrote:
> Order top-level nodes like memory, reserved-memory, opp-table-cpu
> alphabetically for easier code maintenance.  No functional change (same
> dtx_diff, except phandle changes).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 1. New patch
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 384 +++++++++++++--------------
>  1 file changed, 192 insertions(+), 192 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index a63dbd12230f..88e7d4061aae 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -69,122 +69,18 @@ aliases {
>  
>  	chosen { };
>  
> -	memory@80000000 {
> -		device_type = "memory";
> -		/* We expect the bootloader to fill in the size */
> -		reg = <0 0x80000000 0 0>;
> -	};
> -
> -	reserved-memory {
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		hyp_mem: hyp-mem@85700000 {
> -			reg = <0 0x85700000 0 0x600000>;
> -			no-map;
> -		};
> -
> -		xbl_mem: xbl-mem@85e00000 {
> -			reg = <0 0x85e00000 0 0x100000>;
> -			no-map;
> -		};
> -
> -		aop_mem: aop-mem@85fc0000 {
> -			reg = <0 0x85fc0000 0 0x20000>;
> -			no-map;
> -		};
> -
> -		aop_cmd_db_mem: aop-cmd-db-mem@85fe0000 {
> -			compatible = "qcom,cmd-db";
> -			reg = <0x0 0x85fe0000 0 0x20000>;
> -			no-map;
> -		};
> -
> -		smem@86000000 {
> -			compatible = "qcom,smem";
> -			reg = <0x0 0x86000000 0 0x200000>;
> -			no-map;
> -			hwlocks = <&tcsr_mutex 3>;
> -		};
> -
> -		tz_mem: tz@86200000 {
> -			reg = <0 0x86200000 0 0x2d00000>;
> -			no-map;
> -		};
> -
> -		rmtfs_mem: rmtfs@88f00000 {
> -			compatible = "qcom,rmtfs-mem";
> -			reg = <0 0x88f00000 0 0x200000>;
> -			no-map;
> -
> -			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> -		};
> -
> -		qseecom_mem: qseecom@8ab00000 {
> -			reg = <0 0x8ab00000 0 0x1400000>;
> -			no-map;
> -		};
> -
> -		camera_mem: camera-mem@8bf00000 {
> -			reg = <0 0x8bf00000 0 0x500000>;
> -			no-map;
> -		};
> -
> -		ipa_fw_mem: ipa-fw@8c400000 {
> -			reg = <0 0x8c400000 0 0x10000>;
> -			no-map;
> -		};
> -
> -		ipa_gsi_mem: ipa-gsi@8c410000 {
> -			reg = <0 0x8c410000 0 0x5000>;
> -			no-map;
> -		};
> -
> -		gpu_mem: gpu@8c415000 {
> -			reg = <0 0x8c415000 0 0x2000>;
> -			no-map;
> -		};
> -
> -		adsp_mem: adsp@8c500000 {
> -			reg = <0 0x8c500000 0 0x1a00000>;
> -			no-map;
> -		};
> -
> -		wlan_msa_mem: wlan-msa@8df00000 {
> -			reg = <0 0x8df00000 0 0x100000>;
> -			no-map;
> -		};
> -
> -		mpss_region: mpss@8e000000 {
> -			reg = <0 0x8e000000 0 0x7800000>;
> -			no-map;
> -		};
> -
> -		venus_mem: venus@95800000 {
> -			reg = <0 0x95800000 0 0x500000>;
> -			no-map;
> -		};
> -
> -		cdsp_mem: cdsp@95d00000 {
> -			reg = <0 0x95d00000 0 0x800000>;
> -			no-map;
> -		};
> -
> -		mba_region: mba@96500000 {
> -			reg = <0 0x96500000 0 0x200000>;
> -			no-map;
> -		};
> -
> -		slpi_mem: slpi@96700000 {
> -			reg = <0 0x96700000 0 0x1400000>;
> -			no-map;
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <38400000>;
> +			clock-output-names = "xo_board";
>  		};
>  
> -		spss_mem: spss@97b00000 {
> -			reg = <0 0x97b00000 0 0x100000>;
> -			no-map;
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32764>;
>  		};
>  	};
>  
> @@ -436,6 +332,18 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
>  		};
>  	};
>  
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-sdm845", "qcom,scm";
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the size */
> +		reg = <0 0x80000000 0 0>;
> +	};
> +
>  	cpu0_opp_table: opp-table-cpu0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
> @@ -701,32 +609,174 @@ pmu {
>  		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> -	timer {
> -		compatible = "arm,armv8-timer";
> -		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
> -	};
> +	psci: psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
>  
> -	clocks {
> -		xo_board: xo-board {
> -			compatible = "fixed-clock";
> -			#clock-cells = <0>;
> -			clock-frequency = <38400000>;
> -			clock-output-names = "xo_board";
> +		CPU_PD0: power-domain-cpu0 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>  		};
>  
> -		sleep_clk: sleep-clk {
> -			compatible = "fixed-clock";
> -			#clock-cells = <0>;
> -			clock-frequency = <32764>;
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
> +		CLUSTER_PD: power-domain-cluster {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_SLEEP_0>;
>  		};
>  	};
>  
> -	firmware {
> -		scm {
> -			compatible = "qcom,scm-sdm845", "qcom,scm";
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		hyp_mem: hyp-mem@85700000 {
> +			reg = <0 0x85700000 0 0x600000>;
> +			no-map;
> +		};
> +
> +		xbl_mem: xbl-mem@85e00000 {
> +			reg = <0 0x85e00000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		aop_mem: aop-mem@85fc0000 {
> +			reg = <0 0x85fc0000 0 0x20000>;
> +			no-map;
> +		};
> +
> +		aop_cmd_db_mem: aop-cmd-db-mem@85fe0000 {
> +			compatible = "qcom,cmd-db";
> +			reg = <0x0 0x85fe0000 0 0x20000>;
> +			no-map;
> +		};
> +
> +		smem@86000000 {
> +			compatible = "qcom,smem";
> +			reg = <0x0 0x86000000 0 0x200000>;
> +			no-map;
> +			hwlocks = <&tcsr_mutex 3>;
> +		};
> +
> +		tz_mem: tz@86200000 {
> +			reg = <0 0x86200000 0 0x2d00000>;
> +			no-map;
> +		};
> +
> +		rmtfs_mem: rmtfs@88f00000 {
> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0 0x88f00000 0 0x200000>;
> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;
> +		};
> +
> +		qseecom_mem: qseecom@8ab00000 {
> +			reg = <0 0x8ab00000 0 0x1400000>;
> +			no-map;
> +		};
> +
> +		camera_mem: camera-mem@8bf00000 {
> +			reg = <0 0x8bf00000 0 0x500000>;
> +			no-map;
> +		};
> +
> +		ipa_fw_mem: ipa-fw@8c400000 {
> +			reg = <0 0x8c400000 0 0x10000>;
> +			no-map;
> +		};
> +
> +		ipa_gsi_mem: ipa-gsi@8c410000 {
> +			reg = <0 0x8c410000 0 0x5000>;
> +			no-map;
> +		};
> +
> +		gpu_mem: gpu@8c415000 {
> +			reg = <0 0x8c415000 0 0x2000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: adsp@8c500000 {
> +			reg = <0 0x8c500000 0 0x1a00000>;
> +			no-map;
> +		};
> +
> +		wlan_msa_mem: wlan-msa@8df00000 {
> +			reg = <0 0x8df00000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		mpss_region: mpss@8e000000 {
> +			reg = <0 0x8e000000 0 0x7800000>;
> +			no-map;
> +		};
> +
> +		venus_mem: venus@95800000 {
> +			reg = <0 0x95800000 0 0x500000>;
> +			no-map;
> +		};
> +
> +		cdsp_mem: cdsp@95d00000 {
> +			reg = <0 0x95d00000 0 0x800000>;
> +			no-map;
> +		};
> +
> +		mba_region: mba@96500000 {
> +			reg = <0 0x96500000 0 0x200000>;
> +			no-map;
> +		};
> +
> +		slpi_mem: slpi@96700000 {
> +			reg = <0 0x96700000 0 0x1400000>;
> +			no-map;
> +		};
> +
> +		spss_mem: spss@97b00000 {
> +			reg = <0 0x97b00000 0 0x100000>;
> +			no-map;
>  		};
>  	};
>  
> @@ -1018,64 +1068,6 @@ slpi_smp2p_in: slave-kernel {
>  		};
>  	};
>  
> -	psci: psci {
> -		compatible = "arm,psci-1.0";
> -		method = "smc";
> -
> -		CPU_PD0: power-domain-cpu0 {
> -			#power-domain-cells = <0>;
> -			power-domains = <&CLUSTER_PD>;
> -			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> -		};
> -
> -		CPU_PD1: power-domain-cpu1 {
> -			#power-domain-cells = <0>;
> -			power-domains = <&CLUSTER_PD>;
> -			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> -		};
> -
> -		CPU_PD2: power-domain-cpu2 {
> -			#power-domain-cells = <0>;
> -			power-domains = <&CLUSTER_PD>;
> -			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> -		};
> -
> -		CPU_PD3: power-domain-cpu3 {
> -			#power-domain-cells = <0>;
> -			power-domains = <&CLUSTER_PD>;
> -			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> -		};
> -
> -		CPU_PD4: power-domain-cpu4 {
> -			#power-domain-cells = <0>;
> -			power-domains = <&CLUSTER_PD>;
> -			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> -		};
> -
> -		CPU_PD5: power-domain-cpu5 {
> -			#power-domain-cells = <0>;
> -			power-domains = <&CLUSTER_PD>;
> -			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> -		};
> -
> -		CPU_PD6: power-domain-cpu6 {
> -			#power-domain-cells = <0>;
> -			power-domains = <&CLUSTER_PD>;
> -			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> -		};
> -
> -		CPU_PD7: power-domain-cpu7 {
> -			#power-domain-cells = <0>;
> -			power-domains = <&CLUSTER_PD>;
> -			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> -		};
> -
> -		CLUSTER_PD: power-domain-cluster {
> -			#power-domain-cells = <0>;
> -			domain-idle-states = <&CLUSTER_SLEEP_0>;
> -		};
> -	};
> -
>  	soc: soc@0 {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -5771,4 +5763,12 @@ modem_alert0: trip-point0 {
>  			};
>  		};
>  	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
> +	};
>  };
