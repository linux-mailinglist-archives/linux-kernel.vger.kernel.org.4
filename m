Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46291664B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjAJSv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbjAJSvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:51:05 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE62AD5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:45:10 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so19865536lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r72VFpd126SVRp5izXfMxgZdcpDCUEYYWgR5nwMd9is=;
        b=Fq/njbAFF7cXV6cWxJ7T5acnJBmiPXyo6XeyxmFxPlj8GTIBwFA3htMJA9Kem423Z6
         dDvNF8aJhOiepBvLZ6ePHdHNTWA2TV7jvIIEMibFwHwWzu2MYeBOJJpMvoUaMsj8YSjw
         wKTGLOcGzYl1I49kaZ5uDmh/mQimNuOIRXP5kYRvYeQUxUEto400nMpDm8JNZ4JPwulc
         dvyc692BjpEvlx3S8qA5LAbFaNPXO7pys7G/U5L48HDrtkcgjtGFXiyn7/W4K1i8bn8a
         uXbhnqYpiZ/z+i+CUjR0gQPHqDU6qHomxdwQ10S4muLPeRgOA/VYzHmtbGTMf7eU2dOm
         /anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r72VFpd126SVRp5izXfMxgZdcpDCUEYYWgR5nwMd9is=;
        b=qTS61OiJYO+cTw7OKsZcUGcc22hQylUecvcjmAcLDQwT2uJCibnfOLCMpsVU1tPJUe
         YNhslr9zh8SVQSYbQ3/suR5a6pQI4kuYdMq2nhla1Zmz1OeiGCmpvVluSDmmV/UL6M2d
         B47cvcNs15p7xAwiZwZu81/iu09y963OA16QGUCUH2yQdqdW4m0ebXSZdaJxMxMJ0EhL
         kAFcI1IX4kyotMk+uRPQKAZ7cao6EtVf8LyTMiKoelLKS454jLgbQDf3powvYHpEd8zC
         5m/vARPqTpYU37fiWTwiUgsm9Qq+lXe73dkyz63hdy16Bbn6CsKoXutw9o6b5y9Zmyen
         WPYw==
X-Gm-Message-State: AFqh2kp/2iKd6EoNZwS4o8p0zaU4UtFnwo4WX+KOScIFUnH93ku+j1Y3
        O3DHeCYDc0FY8R2i5oD06se/wQ==
X-Google-Smtp-Source: AMrXdXuK4pTSV9lCbdmYxvuj5dxvvbSjOkT4CFhrrCbEanzbGL7Ve5N0mpMUMsD1ZZyYHU/TocrAFA==
X-Received: by 2002:a05:6512:3750:b0:4a4:68b9:66cc with SMTP id a16-20020a056512375000b004a468b966ccmr17364714lfs.23.1673376308994;
        Tue, 10 Jan 2023 10:45:08 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id n1-20020a05651203e100b004b591829352sm2300535lfq.64.2023.01.10.10.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 10:45:08 -0800 (PST)
Message-ID: <0cc9f893-cf26-362b-d59a-fbbaa980cd96@linaro.org>
Date:   Tue, 10 Jan 2023 19:45:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: msm8998: Configure CPRh
Content-Language: en-US
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        angelogioacchino.delregno@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110175605.1240188-1-konrad.dybcio@linaro.org>
 <20230110175605.1240188-6-konrad.dybcio@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230110175605.1240188-6-konrad.dybcio@linaro.org>
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



On 10.01.2023 18:56, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Now that the CPR v3/v4/Hardened is ready, enable it on MSM8998.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Konrad: separate from adding cpufreq, sort nodes and use lowercase hex]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
This patch has many things wrong, please ignore..

Konrad
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 325 ++++++++++++++++++++++++++
>  1 file changed, 325 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index af29a4bfd109..84f73484441f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -139,6 +139,9 @@ CPU0: cpu@0 {
>  			capacity-dmips-mhz = <1024>;
>  			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
>  			next-level-cache = <&L2_0>;
> +			operating-points-v2 = <&cpu_gold_opp_table>;
> +			power-domains = <&apc_cprh 0>;
> +			power-domain-names = "cprh";
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> @@ -153,6 +156,9 @@ CPU1: cpu@1 {
>  			capacity-dmips-mhz = <1024>;
>  			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
>  			next-level-cache = <&L2_0>;
> +			operating-points-v2 = <&cpu_gold_opp_table>;
> +			power-domains = <&apc_cprh 0>;
> +			power-domain-names = "cprh";
>  		};
>  
>  		CPU2: cpu@2 {
> @@ -163,6 +169,9 @@ CPU2: cpu@2 {
>  			capacity-dmips-mhz = <1024>;
>  			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
>  			next-level-cache = <&L2_0>;
> +			operating-points-v2 = <&cpu_gold_opp_table>;
> +			power-domains = <&apc_cprh 0>;
> +			power-domain-names = "cprh";
>  		};
>  
>  		CPU3: cpu@3 {
> @@ -173,6 +182,9 @@ CPU3: cpu@3 {
>  			capacity-dmips-mhz = <1024>;
>  			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
>  			next-level-cache = <&L2_0>;
> +			operating-points-v2 = <&cpu_gold_opp_table>;
> +			power-domains = <&apc_cprh 0>;
> +			power-domain-names = "cprh";
>  		};
>  
>  		CPU4: cpu@100 {
> @@ -183,6 +195,9 @@ CPU4: cpu@100 {
>  			capacity-dmips-mhz = <1536>;
>  			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
>  			next-level-cache = <&L2_1>;
> +			operating-points-v2 = <&cpu_silver_opp_table>;
> +			power-domains = <&apc_cprh 1>;
> +			power-domain-names = "cprh";
>  			L2_1: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> @@ -197,6 +212,9 @@ CPU5: cpu@101 {
>  			capacity-dmips-mhz = <1536>;
>  			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
>  			next-level-cache = <&L2_1>;
> +			operating-points-v2 = <&cpu_silver_opp_table>;
> +			power-domains = <&apc_cprh 1>;
> +			power-domain-names = "cprh";
>  		};
>  
>  		CPU6: cpu@102 {
> @@ -207,6 +225,9 @@ CPU6: cpu@102 {
>  			capacity-dmips-mhz = <1536>;
>  			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
>  			next-level-cache = <&L2_1>;
> +			operating-points-v2 = <&cpu_silver_opp_table>;
> +			power-domains = <&apc_cprh 1>;
> +			power-domain-names = "cprh";
>  		};
>  
>  		CPU7: cpu@103 {
> @@ -217,6 +238,9 @@ CPU7: cpu@103 {
>  			capacity-dmips-mhz = <1536>;
>  			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
>  			next-level-cache = <&L2_1>;
> +			operating-points-v2 = <&cpu_silver_opp_table>;
> +			power-domains = <&apc_cprh 1>;
> +			power-domain-names = "cprh";
>  		};
>  
>  		cpu-map {
> @@ -310,6 +334,65 @@ scm {
>  		};
>  	};
>  
> +	cpu_gold_opp_table: opp-table-gold {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-2208000000 {
> +			opp-hz = /bits/ 64 <2208000000>;
> +			required-opps = <&cprh_opp3>;
> +		};
> +
> +		opp-1113600000 {
> +			opp-hz = /bits/ 64 <1113600000>;
> +			required-opps = <&cprh_opp2>;
> +		};
> +
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			required-opps = <&cprh_opp1>;
> +		};
> +	};
> +
> +	cpu_silver_opp_table: opp-table-silver {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-1843200000 {
> +			opp-hz = /bits/ 64 <1843200000>;
> +			required-opps = <&cprh_opp3>;
> +		};
> +
> +		opp-1094400000 {
> +			opp-hz = /bits/ 64 <1094400000>;
> +			required-opps = <&cprh_opp2>;
> +		};
> +
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			required-opps = <&cprh_opp1>;
> +		};
> +	};
> +
> +	cprh_opp_table: opp-table-cprh {
> +		compatible = "operating-points-v2-qcom-level";
> +
> +		cprh_opp1: opp1 {
> +			opp-level = <1>;
> +			qcom,opp-fuse-level = <1>;
> +		};
> +
> +		cprh_opp2: opp2 {
> +			opp-level = <2>;
> +			qcom,opp-fuse-level = <2>;
> +		};
> +
> +		cprh_opp3: opp3 {
> +			opp-level = <3>;
> +			qcom,opp-fuse-level = <2 3>;
> +		};
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> @@ -839,6 +922,174 @@ qfprom: qfprom@784000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  
> +			cpr_efuse_speedbin: speedbin@133 {
> +				reg = <0x133 0x8>;
> +				bits = <5 3>;
> +			};
> +
> +			cpr_fuse_revision: cpr_fusing_rev@13e {
> +				reg = <0x13e 0x1>;
> +				bits = <3 3>;
> +			};
> +
> +			/* CPR Ring Oscillator: Power Cluster */
> +			cpr_ro_sel3_pwrcl: rosel3_pwrcl@218 {
> +				reg = <0x218 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			cpr_ro_sel2_pwrcl: rosel2_pwrcl@218 {
> +				reg = <0x218 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			cpr_ro_sel1_pwrcl: rosel1_pwrcl@219 {
> +				reg = <0x219 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			cpr_ro_sel0_pwrcl: rosel0_pwrcl@219 {
> +				reg = <0x219 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			/* CPR Init Voltage: Power Cluster */
> +			cpr_init_voltage3_pwrcl: ivolt3_pwrcl@21a {
> +				reg = <0x21a 0x1>;
> +				bits = <0 6>;
> +			};
> +
> +			cpr_init_voltage2_pwrcl: ivolt2_pwrcl@21a {
> +				reg = <0x21a 0x1>;
> +				bits = <6 6>;
> +			};
> +
> +			cpr_init_voltage1_pwrcl: ivolt1_pwrcl@21b {
> +				reg = <0x21b 0x1>;
> +				bits = <4 6>;
> +			};
> +
> +			cpr_init_voltage0_pwrcl: ivolt0_pwrcl@21c {
> +				reg = <0x21c 0x1>;
> +				bits = <2 6>;
> +			};
> +
> +			/* CPR Target Quotients: Power Cluster */
> +			cpr_quot3_pwrcl: quot3_pwrcl@21d {
> +				reg = <0x21d 0x2>;
> +				bits = <6 12>;
> +			};
> +
> +			cpr_quot2_pwrcl: quot2_pwrcl@21f {
> +				reg = <0x21f 0x2>;
> +				bits = <2 11>;
> +			};
> +
> +			cpr_quot1_pwrcl: quot1_pwrcl@220 {
> +				reg = <0x220 0x2>;
> +				bits = <6 12>;
> +			};
> +
> +			cpr_quot0_pwrcl: quot0_pwrcl@222 {
> +				reg = <0x222 0x2>;
> +				bits = <2 12>;
> +			};
> +
> +			/* CPR Quotient Offsets: Power Cluster */
> +			cpr_quot_offset3_pwrcl: qoff3_pwrcl@226 {
> +				reg = <0x226 0x1>;
> +				bits = <1 7>;
> +			};
> +
> +			cpr_quot_offset2_pwrcl: qoff2_pwrcl@227 {
> +				reg = <0x227 0x1>;
> +				bits = <0 7>;
> +			};
> +
> +			cpr_quot_offset1_pwrcl: qoff1_pwrcl@227 {
> +				reg = <0x227 0x1>;
> +				bits = <7 6>;
> +			};
> +
> +			/* CPR Ring Oscillator: Performance Cluster */
> +			cpr_ro_sel3_perfcl: rosel3_perfcl@229 {
> +				reg = <0x229 0x1>;
> +				bits = <6 4>;
> +			};
> +
> +			cpr_ro_sel2_perfcl: rosel2_perfcl@22a {
> +				reg = <0x22a 0x1>;
> +				bits = <2 4>;
> +			};
> +
> +			cpr_ro_sel1_perfcl: rosel1_perfcl@22a {
> +				reg = <0x22a 0x1>;
> +				bits = <6 4>;
> +			};
> +
> +			cpr_ro_sel0_perfcl: rosel0_perfcl@22b {
> +				reg = <0x22b 0x1>;
> +				bits = <2 4>;
> +			};
> +
> +			/* CPR Init Voltage: Performance Cluster */
> +			cpr_init_voltage3_perfcl: ivolt3_perfcl@22b {
> +				reg = <0x22b 0x1>;
> +				bits = <6 6>;
> +			};
> +
> +			cpr_init_voltage2_perfcl: ivolt2_perfcl@22c {
> +				reg = <0x22c 0x1>;
> +				bits = <4 6>;
> +			};
> +
> +			cpr_init_voltage1_perfcl: ivolt1_perfcl@22d {
> +				reg = <0x22d 0x1>;
> +				bits = <2 6>;
> +			};
> +
> +			cpr_init_voltage0_perfcl: ivolt0_perfcl@22e {
> +				reg = <0x22e 0x1>;
> +				bits = <0 6>;
> +			};
> +
> +			/* CPR Target Quotients: Performance Cluster */
> +			cpr_quot3_perfcl: quot3_perfcl@22f {
> +				reg = <0x22f 0x2>;
> +				bits = <4 11>;
> +			};
> +
> +			cpr_quot2_perfcl: quot2_perfcl@231 {
> +				reg = <0x231 0x2>;
> +				bits = <0 12>;
> +			};
> +
> +			cpr_quot1_perfcl: quot1_perfcl@232 {
> +				reg = <0x232 0x2>;
> +				bits = <4 12>;
> +			};
> +
> +			cpr_quot0_perfcl: quot0_perfcl@234 {
> +				reg = <0x234 0x2>;
> +				bits = <0 12>;
> +			};
> +
> +			/* CPR Quotient Offsets: Performance Cluster */
> +			cpr_quot_offset3_perfcl: qoff3_perfcl@237 {
> +				reg = <0x237 0x1>;
> +				bits = <7 6>;
> +			};
> +
> +			cpr_quot_offset2_perfcl: qoff2_perfcl@238 {
> +				reg = <0x238 0x1>;
> +				bits = <6 7>;
> +			};
> +
> +			cpr_quot_offset1_perfcl: qoff1_perfcl@239 {
> +				reg = <0x239 0x1>;
> +				bits = <5 3>;
> +			};
> +
>  			qusb2_hstx_trim: hstx-trim@23a {
>  				reg = <0x23a 0x1>;
>  				bits = <0 4>;
> @@ -2998,6 +3249,80 @@ frame@17928000 {
>  			};
>  		};
>  
> +		apc_cprh: power-controller@179c8000 {
> +			compatible = "qcom,msm8998-cprh", "qcom,cprh";
> +			reg = <0x0179c4000 0x4000>, <0x0179c8000 0x4000>;
> +			clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
> +			clock-names = "ref";
> +			operating-points-v2 = <&cprh_opp_table>;
> +			#power-domain-cells = <1>;
> +
> +			nvmem-cells = <&cpr_efuse_speedbin>,
> +				      <&cpr_fuse_revision>,
> +				      <&cpr_quot0_pwrcl>,
> +				      <&cpr_quot1_pwrcl>,
> +				      <&cpr_quot2_pwrcl>,
> +				      <&cpr_quot3_pwrcl>,
> +				      <&cpr_quot_offset1_pwrcl>,
> +				      <&cpr_quot_offset2_pwrcl>,
> +				      <&cpr_quot_offset3_pwrcl>,
> +				      <&cpr_init_voltage0_pwrcl>,
> +				      <&cpr_init_voltage1_pwrcl>,
> +				      <&cpr_init_voltage2_pwrcl>,
> +				      <&cpr_init_voltage3_pwrcl>,
> +				      <&cpr_ro_sel0_pwrcl>,
> +				      <&cpr_ro_sel1_pwrcl>,
> +				      <&cpr_ro_sel2_pwrcl>,
> +				      <&cpr_ro_sel3_pwrcl>,
> +				      <&cpr_quot0_perfcl>,
> +				      <&cpr_quot1_perfcl>,
> +				      <&cpr_quot2_perfcl>,
> +				      <&cpr_quot3_perfcl>,
> +				      <&cpr_quot_offset1_perfcl>,
> +				      <&cpr_quot_offset2_perfcl>,
> +				      <&cpr_quot_offset3_perfcl>,
> +				      <&cpr_init_voltage0_perfcl>,
> +				      <&cpr_init_voltage1_perfcl>,
> +				      <&cpr_init_voltage2_perfcl>,
> +				      <&cpr_init_voltage3_perfcl>,
> +				      <&cpr_ro_sel0_perfcl>,
> +				      <&cpr_ro_sel1_perfcl>,
> +				      <&cpr_ro_sel2_perfcl>,
> +				      <&cpr_ro_sel3_perfcl>;
> +			nvmem-cell-names = "cpr_speed_bin",
> +					   "cpr_fuse_revision",
> +					   "cpr0_quotient1",
> +					   "cpr0_quotient2",
> +					   "cpr0_quotient3",
> +					   "cpr0_quotient4",
> +					   "cpr0_quotient_offset2",
> +					   "cpr0_quotient_offset3",
> +					   "cpr0_quotient_offset4",
> +					   "cpr0_init_voltage1",
> +					   "cpr0_init_voltage2",
> +					   "cpr0_init_voltage3",
> +					   "cpr0_init_voltage4",
> +					   "cpr0_ring_osc1",
> +					   "cpr0_ring_osc2",
> +					   "cpr0_ring_osc3",
> +					   "cpr0_ring_osc4",
> +					   "cpr1_quotient1",
> +					   "cpr1_quotient2",
> +					   "cpr1_quotient3",
> +					   "cpr1_quotient4",
> +					   "cpr1_quotient_offset2",
> +					   "cpr1_quotient_offset3",
> +					   "cpr1_quotient_offset4",
> +					   "cpr1_init_voltage1",
> +					   "cpr1_init_voltage2",
> +					   "cpr1_init_voltage3",
> +					   "cpr1_init_voltage4",
> +					   "cpr1_ring_osc1",
> +					   "cpr1_ring_osc2",
> +					   "cpr1_ring_osc3",
> +					   "cpr1_ring_osc4";
> +		};
> +
>  		intc: interrupt-controller@17a00000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x17a00000 0x10000>,       /* GICD */
