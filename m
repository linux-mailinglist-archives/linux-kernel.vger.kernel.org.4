Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2353A71FD8D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbjFBJVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjFBJUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:20:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAE11984
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:19:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f122ff663eso2362759e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685697554; x=1688289554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XssEmpMFkM6nmR9KxRcGle4QAbUsRRTRja63gRHBmNY=;
        b=FZBBJPS+TXTO0d8Yw9wtOHycmDI39jbAkbqz7ry+BZBQdw3XcWNrCRF0xTKAXv6+Wu
         JoflIPKA4NOt6HCd7yTuDeEBjnGNhh6XXCPbPD+jgx5JSPXXL4+eg5zKs2JxldJ7adXp
         3K49DhyNKgzez/HE5gPYQgi/SvV/3XoZEkiR5oUqQWJJuMPRdFBJB9I80BdhgVOOShEF
         94kqnJtVRyCKHGgOYpwMCfIV0u00xkKUiHDsVFdDJk4mJdWC8vvsyJaaOENyGcXvpb7i
         QJrgbxsrt1AhwTdUV37HqZgkQVPPo1skCkhJPZfbrXUQrEl3mj3Bm3OzpCRrmj6+67Ma
         KU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685697554; x=1688289554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XssEmpMFkM6nmR9KxRcGle4QAbUsRRTRja63gRHBmNY=;
        b=QMxW17200axkx46Uy6YDAIEIQcnZbcis+jy+ubtnZCXMa//x9Hlyc7T3RZWISUHyxw
         I7j9MKzkUkjpkjOyqqTAKa4PS/9ZC2/5Z+4949hG9RhwPSAUkvm8mtTPr1lLj1e42/ll
         VLPjX35i800haEMgQgKxAl2lD7pdNiFGBn0k70GOyCmyt0TS5Ofu7Dg5U+SUrUx+FnJW
         HDCLPqJCnCFUgf/iH5OM6+MRgoaNJU8waduzIyfBRRHZhwkszahkjIhr2COakq0VhksA
         Kdr1/hXJ9r19MiQ51/GQYqAjo+lzbHKqRKz5v/5bTkGAE6NYayp58Ne+7VPpDHj3iwL7
         xjCg==
X-Gm-Message-State: AC+VfDxSdubMyypOCoITfEf2JxShPjt04C6lpxXc30RUAXSarjsOpfdC
        3QcogbyNMdCOekIG/pcOaz3jSw==
X-Google-Smtp-Source: ACHHUZ5MsdjY+bJWxOsnjEbeGfcZkWkRrlAm496JTI70Wj/9zEN+Nm8rM4NIQZlr6MhmsOE3ZLgtdQ==
X-Received: by 2002:a19:ac0b:0:b0:4f4:cebe:a7aa with SMTP id g11-20020a19ac0b000000b004f4cebea7aamr1362848lfc.39.1685697553940;
        Fri, 02 Jun 2023 02:19:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id a11-20020a056512020b00b004f4cabba7desm100699lfo.74.2023.06.02.02.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:19:13 -0700 (PDT)
Message-ID: <68365854-6071-0014-7970-5f3df3332f12@linaro.org>
Date:   Fri, 2 Jun 2023 11:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/6] arm64: dts: qcom: sm8150: Use 2 interconnect cells
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230602062016.1883171-1-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230602062016.1883171-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.06.2023 08:20, Abel Vesa wrote:
> Use two interconnect cells in order to optionally support a path tag.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
>  * This patch was not part of v1
> 
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 60 ++++++++++++++--------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 197c016aaeba..50a21062ea24 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -55,8 +55,8 @@ CPU0: cpu@0 {
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
> -			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
>  			power-domains = <&CPU_PD0>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -84,8 +84,8 @@ CPU1: cpu@100 {
>  			next-level-cache = <&L2_100>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
> -			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
>  			power-domains = <&CPU_PD1>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -108,8 +108,8 @@ CPU2: cpu@200 {
>  			next-level-cache = <&L2_200>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
> -			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
>  			power-domains = <&CPU_PD2>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -132,8 +132,8 @@ CPU3: cpu@300 {
>  			next-level-cache = <&L2_300>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
> -			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
>  			power-domains = <&CPU_PD3>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -156,8 +156,8 @@ CPU4: cpu@400 {
>  			next-level-cache = <&L2_400>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
> -			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
>  			power-domains = <&CPU_PD4>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -180,8 +180,8 @@ CPU5: cpu@500 {
>  			next-level-cache = <&L2_500>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
> -			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
>  			power-domains = <&CPU_PD5>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -204,8 +204,8 @@ CPU6: cpu@600 {
>  			next-level-cache = <&L2_600>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
> -			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
>  			power-domains = <&CPU_PD6>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -228,8 +228,8 @@ CPU7: cpu@700 {
>  			next-level-cache = <&L2_700>;
>  			qcom,freq-domain = <&cpufreq_hw 2>;
>  			operating-points-v2 = <&cpu7_opp_table>;
> -			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
>  			power-domains = <&CPU_PD7>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -1760,49 +1760,49 @@ spi15: spi@c94000 {
>  		config_noc: interconnect@1500000 {
>  			compatible = "qcom,sm8150-config-noc";
>  			reg = <0 0x01500000 0 0x7400>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		system_noc: interconnect@1620000 {
>  			compatible = "qcom,sm8150-system-noc";
>  			reg = <0 0x01620000 0 0x19400>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		mc_virt: interconnect@163a000 {
>  			compatible = "qcom,sm8150-mc-virt";
>  			reg = <0 0x0163a000 0 0x1000>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		aggre1_noc: interconnect@16e0000 {
>  			compatible = "qcom,sm8150-aggre1-noc";
>  			reg = <0 0x016e0000 0 0xd080>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		aggre2_noc: interconnect@1700000 {
>  			compatible = "qcom,sm8150-aggre2-noc";
>  			reg = <0 0x01700000 0 0x20000>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		compute_noc: interconnect@1720000 {
>  			compatible = "qcom,sm8150-compute-noc";
>  			reg = <0 0x01720000 0 0x7000>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		mmss_noc: interconnect@1740000 {
>  			compatible = "qcom,sm8150-mmss-noc";
>  			reg = <0 0x01740000 0 0x1c100>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> @@ -2120,7 +2120,7 @@ crypto: crypto@1dfa000 {
>  				 <&apps_smmu 0x506 0x0011>,
>  				 <&apps_smmu 0x508 0x0011>,
>  				 <&apps_smmu 0x512 0x0000>;
> -			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
> +			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 0 &mc_virt SLAVE_EBI_CH0 0>;
>  			interconnect-names = "memory";
>  		};
>  
> @@ -3547,14 +3547,14 @@ opp-202000000 {
>  		dc_noc: interconnect@9160000 {
>  			compatible = "qcom,sm8150-dc-noc";
>  			reg = <0 0x09160000 0 0x3200>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		gem_noc: interconnect@9680000 {
>  			compatible = "qcom,sm8150-gem-noc";
>  			reg = <0 0x09680000 0 0x3e200>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> @@ -3659,7 +3659,7 @@ usb_2_dwc3: usb@a800000 {
>  		camnoc_virt: interconnect@ac00000 {
>  			compatible = "qcom,sm8150-camnoc-virt";
>  			reg = <0 0x0ac00000 0 0x1000>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> @@ -3668,8 +3668,8 @@ mdss: display-subsystem@ae00000 {
>  			reg = <0 0x0ae00000 0 0x1000>;
>  			reg-names = "mdss";
>  
> -			interconnects = <&mmss_noc MASTER_MDP_PORT0 &mc_virt SLAVE_EBI_CH0>,
> -					<&mmss_noc MASTER_MDP_PORT1 &mc_virt SLAVE_EBI_CH0>;
> +			interconnects = <&mmss_noc MASTER_MDP_PORT0 0 &mc_virt SLAVE_EBI_CH0 0>,
> +					<&mmss_noc MASTER_MDP_PORT1 0 &mc_virt SLAVE_EBI_CH0 0>;
>  			interconnect-names = "mdp0-mem", "mdp1-mem";
>  
>  			power-domains = <&dispcc MDSS_GDSC>;
> @@ -4334,7 +4334,7 @@ osm_l3: interconnect@18321000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
>  			clock-names = "xo", "alternate";
>  
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  		};
>  
>  		cpufreq_hw: cpufreq@18323000 {
