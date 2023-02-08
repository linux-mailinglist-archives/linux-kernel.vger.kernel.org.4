Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7833B68EA06
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjBHIio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjBHIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:38:42 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF64588B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:38:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id dr8so49280000ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3M36RLWQSE1ygMBMvnUOAalDXVqyZLOofNFnhzgK9M=;
        b=sZtoFgloUbTrGU6ndN/TgQJ4+ehIpi4DNQqZ/kodhJojF5GBEVzKoujDUbY/OLahIv
         K3xm/53uiZTVX17/LVfcAgI+NTVxE8AsUas2nGzTmFLo04NJKrbuIJK4xjHXWfJXTM36
         IgaX3+K7OBpZH8BhRFXCNzxWnf3c5g2KBoNh+P+5ZCusmKjxlhABll6HD9heZzqhAdTJ
         WqZr1VFG4+T/bYVHRUHho27FTiTBr4S5XII3m/7Y9xH74tJbGzupDkCLSgYF8m7UlqRD
         iDFZISBjTe4pIBjW0Yt8/v3MxIN7PXlckBM4iM+Tw6sSoxEgSQ9shSy9YHknWLu36Ggi
         MeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3M36RLWQSE1ygMBMvnUOAalDXVqyZLOofNFnhzgK9M=;
        b=P3dpLLxfkEgQAuZraRxTB2yaUYKMy8PFedzR9/3lglyKDbwvAU/Hys7ykqfoZ1U+1R
         fr4vUkeC/fhCclNiuj+syiXf34Be2O4tt1yAb5UDesxdLnmPyD1TIRtddajbq+67ynoA
         u6GDDnxwpe2FUTRMftbQza8pUdXUX+q/gW9ocrgCNe5A6LTjBAQLd3oxCFFtnMXdHOaj
         w8DTMTB0RgsnJXwju8AOG/I3He9O4jYOvUBEzkuhfwQQfa9ZJPpXK8F67XU6hmxYYpBb
         m9rftIWJwmzpnuVe48qfhZu9UlvkkRJiLMgALJkqPB/8nfSv3CKRXyT9tL+7LMK0Ge2I
         AnmA==
X-Gm-Message-State: AO0yUKXM36QjOxi6PjLVC6jxMuX7AoPFOyG0RSpttuIXnCqFmIqE+sLb
        qlVj6A95UnLglKREeX2xWPnXeg==
X-Google-Smtp-Source: AK7set8yZkcgcbxG1cIurycXSbPSDdDBgFix04S1M2m5B5rcNa3yOQTP7me7dQvmCIooIHSc8k8QvA==
X-Received: by 2002:a17:906:3950:b0:887:3c7e:5df with SMTP id g16-20020a170906395000b008873c7e05dfmr7549632eje.73.1675845514269;
        Wed, 08 Feb 2023 00:38:34 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id kb18-20020a1709070f9200b0088ef3c38a52sm8119132ejc.19.2023.02.08.00.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 00:38:33 -0800 (PST)
Message-ID: <387c7252-2b35-46a1-fb6a-34e58545188a@linaro.org>
Date:   Wed, 8 Feb 2023 09:38:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp: Add GPU related nodes
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, johan@kernel.org, mani@kernel.org
References: <20230208034052.2047681-1-quic_bjorande@quicinc.com>
 <20230208034052.2047681-3-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230208034052.2047681-3-quic_bjorande@quicinc.com>
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



On 8.02.2023 04:40, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add Adreno SMMU, GPU clock controller, GMU and GPU nodes for the
> SC8280XP.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 171 +++++++++++++++++++++++++
>  1 file changed, 171 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index fcd393444f47..94e8d0da9d7b 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -6,6 +6,7 @@
>  
>  #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
>  #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
> +#include <dt-bindings/clock/qcom,gpucc-sc8280xp.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>  #include <dt-bindings/interconnect/qcom,sc8280xp.h>
> @@ -2275,6 +2276,176 @@ tcsr: syscon@1fc0000 {
>  			reg = <0x0 0x01fc0000 0x0 0x30000>;
>  		};
>  
> +		gpu: gpu@3d00000 {
> +			compatible = "qcom,adreno-690.0", "qcom,adreno";
Did Qualcomm really pull off a chip this big with
patchlevel=0/first try? Nice.

> +			reg = <0 0x03d00000 0 0x40000>,
> +			      <0 0x03d9e000 0 0x1000>,
> +			      <0 0x03d61000 0 0x800>;
> +			reg-names = "kgsl_3d0_reg_memory",
> +				    "cx_mem",
> +				    "cx_dbgc";
> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
> +			iommus = <&adreno_smmu 0 0xc00>, <&adreno_smmu 1 0xc00>;
> +			operating-points-v2 = <&gpu_opp_table>;
> +			qcom,gmu = <&gmu>;
> +			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "gfx-mem";
> +			#cooling-cells = <2>;
> +
> +			status = "disabled";
> +
> +			gpu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-270000000 {
> +					opp-hz = /bits/ 64 <270000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					opp-peak-kBps = <451000>;
> +				};
> +
> +				opp-410000000 {
> +					opp-hz = /bits/ 64 <410000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					opp-peak-kBps = <1555000>;
> +				};
> +
> +				opp-500000000 {
> +					opp-hz = /bits/ 64 <500000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					opp-peak-kBps = <1555000>;
> +				};
> +
> +				opp-547000000 {
> +					opp-hz = /bits/ 64 <547000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
> +					opp-peak-kBps = <1555000>;
> +				};
> +
> +				opp-606000000 {
> +					opp-hz = /bits/ 64 <606000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					opp-peak-kBps = <2736000>;
> +				};
> +
> +				opp-640000000 {
> +					opp-hz = /bits/ 64 <640000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					opp-peak-kBps = <2736000>;
> +				};
> +
> +				opp-690000000 {
> +					opp-hz = /bits/ 64 <690000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +					opp-peak-kBps = <2736000>;
> +				};
> +			};
> +		};
> +
> +		gmu: gmu@3d6a000 {
> +			compatible="qcom,adreno-gmu-690.0", "qcom,adreno-gmu";
This needs a binding update.

> +			reg = <0 0x03d6a000 0 0x34000>,
> +			      <0 0x03de0000 0 0x10000>,
> +			      <0 0x0b290000 0 0x10000>,
> +			      <0 0x0b490000 0 0x10000>;
> +			reg-names = "gmu", "rscc", "gmu_pdc", "gmu_pdc_seq";
I think this should be a vertical list with so many entries.

> +			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hfi", "gmu";
> +			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> +				 <&gpucc GPU_CC_CXO_CLK>,
> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gpucc GPU_CC_AHB_CLK>,
> +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
> +				 <&aoss_qmp>;
> +			clock-names = "gmu",
> +				      "cxo",
> +				      "axi",
> +				      "memnoc",
> +				      "ahb",
> +				      "hub",
> +				      "smmu_vote",
> +				      "apb_pclk";
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>,
> +					<&gpucc GPU_CC_GX_GDSC>;
> +			power-domain-names = "cx",
> +					     "gx";
> +			iommus = <&adreno_smmu 5 0xc00>;
> +			operating-points-v2 = <&gmu_opp_table>;
> +
> +			status = "disabled";
> +
> +			gmu_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-200000000 {
> +					opp-hz = /bits/ 64 <200000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +				};
> +			};
> +		};
> +
> +		gpucc: clock-controller@3d90000 {
> +			compatible = "qcom,sc8280xp-gpucc";
> +			reg = <0 0x03d90000 0 0x9000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
> +				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
> +			clock-names = "bi_tcxo",
> +				      "gcc_gpu_gpll0_clk_src",
> +				      "gcc_gpu_gpll0_div_clk_src";
> +
> +			power-domains = <&rpmhpd SC8280XP_GFX>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +
> +			status = "disabled";
Is there any benefit in not enabling this by default?

> +		};
> +
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,sc8280xp-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
This needs a binding update.

> +			reg = <0 0x03da0000 0 0x20000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <2>;
> +			interrupts = <GIC_SPI 672 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
> +				 <&gpucc GPU_CC_AHB_CLK>,
> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
> +				 <&gpucc GPU_CC_CX_GMU_CLK>,
> +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
> +				 <&gpucc GPU_CC_HUB_AON_CLK>,
> +				 <&aoss_qmp>;
> +			clock-names = "gcc_gpu_memnoc_gfx_clk",
> +				      "gcc_gpu_snoc_dvm_gfx_clk",
> +				      "gpu_cc_ahb_clk",
> +				      "gpu_cc_hlos1_vote_gpu_smmu_clk",
> +				      "gpu_cc_cx_gmu_clk",
> +				      "gpu_cc_hub_cx_int_clk",
> +				      "gpu_cc_hub_aon_clk",
> +				      "apb_pclk";
You'll need to update the smmu bindings; I think this may
be overkill for the SMMU.. usually you need 3-4 clks at
max (snoc_dvm, memnoc, vote_smmu and some other thing).

> +
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> +
> +			status = "disabled";
Not sure if there's any benefit in disabling this.

Konrad
> +		};
> +
>  		usb_0_hsphy: phy@88e5000 {
>  			compatible = "qcom,sc8280xp-usb-hs-phy",
>  				     "qcom,usb-snps-hs-5nm-phy";
