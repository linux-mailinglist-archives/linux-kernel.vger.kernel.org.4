Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F6770D785
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbjEWIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjEWIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:33:25 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6A2698
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:30:02 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2af1822b710so65644911fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684830541; x=1687422541;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ru8/Ayqf4dTtmxHSBTZW4Z/WyG04tjjI1uvhJ1HwfeI=;
        b=abJjwkmDgJj5c2H3Ph/PaFWs5c3ixfxVuxTVw6cdn0Sl5+HIwtdFR0r2wAmVtzNdTN
         AazJsKfhIiipws0rgDYu5IZ8lN/amDTcBOIwQHOREIkh+o9OmnEt4x+I7LEow3bxxTcq
         3k5PYk7/e2VEDw+dBu8ynUPX6FkwfvS724LdiRKYHBgHyY+Ng6P75dP/eufPhOXJUJCj
         v4Huuvj6qOxVJ28ntsfINKdAy/7XFwqgvblBZsOr/apNa/CBOBGkOw8Qy//fqF4lU9Os
         k7ZqeeO9wl4UiKV0Gb3fjqwoR2+ia/oZH6S00HacjPDlAYG7GsSVeTbNz9BKdQRvbgFV
         5DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684830541; x=1687422541;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ru8/Ayqf4dTtmxHSBTZW4Z/WyG04tjjI1uvhJ1HwfeI=;
        b=FP2KrNXXyEZrwP3JIXsg4igs1EXkYY6Hqh7qYOz533tNZkCLnC4erFtWHaJLkrJmCY
         GcskQAOthOl9pWdxaUqj286IXza3HY8DZrpU7HsldcW8JuWSuTPVoSM13RuzXPIl7Cxu
         4P47KvtCLkdYJ9FOeem+0gLAEeK6ztHcAl30UXtF0JZeFWTIkaGeZIMD/jciE4HRuauD
         Gmle66NyJ2gJ2lKL1UTg8+4gEWUkaui1coqPsCtypfgBQLbCQkMq1K2Ce5Z1/5Hc9rVZ
         i2ECv7y72UVQwyh5rWQhFYBAstJ7lMA067nwJZaPrr/yeZ3LqfC6bIAhXFJyUDoAcy2l
         mpGg==
X-Gm-Message-State: AC+VfDwhCd9ERKUqpzwN+VifBGoval44W1t3J/oScBndOQIkUiUobq0b
        Po8pig7R8gLqQQ6jd+a+JvgPJQ==
X-Google-Smtp-Source: ACHHUZ7Z6KxAfOGRGBcH8la8DINFLT/esIUVa3YUF9vwrpNYh17uiO2t/tJt2bcDRLkVCG33/nVWUw==
X-Received: by 2002:a2e:3809:0:b0:2ad:94cd:3cb7 with SMTP id f9-20020a2e3809000000b002ad94cd3cb7mr4535421lja.51.1684830540807;
        Tue, 23 May 2023 01:29:00 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id y14-20020a2eb00e000000b002af0464353bsm1465866ljk.106.2023.05.23.01.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 01:29:00 -0700 (PDT)
Message-ID: <df1b3440-d007-0658-0739-9a939b143a32@linaro.org>
Date:   Tue, 23 May 2023 10:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc8280xp: Add GPU related nodes
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, johan@kernel.org, mani@kernel.org
References: <20230523011522.65351-1-quic_bjorande@quicinc.com>
 <20230523011522.65351-3-quic_bjorande@quicinc.com>
 <097944b0-fa7a-ad4d-1c3d-e74ab2b977de@linaro.org>
In-Reply-To: <097944b0-fa7a-ad4d-1c3d-e74ab2b977de@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.05.2023 09:59, Konrad Dybcio wrote:
> 
> 
> On 23.05.2023 03:15, Bjorn Andersson wrote:
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
>> Add Adreno SMMU, GPU clock controller, GMU and GPU nodes for the
>> SC8280XP.
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>> ---
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> 
>>
>> Changes since v1:
>> - Dropped gmu_pdc_seq region from &gmu, as it shouldn't have been used.
>> - Added missing compatible to &adreno_smmu.
>> - Dropped aoss_qmp clock in &gmu and &adreno_smmu.
>>  
>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 169 +++++++++++++++++++++++++
>>  1 file changed, 169 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index d2a2224d138a..329ec2119ecf 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -6,6 +6,7 @@
>>  
>>  #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
>>  #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
>> +#include <dt-bindings/clock/qcom,gpucc-sc8280xp.h>
>>  #include <dt-bindings/clock/qcom,rpmh.h>
>>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>  #include <dt-bindings/interconnect/qcom,sc8280xp.h>
>> @@ -2331,6 +2332,174 @@ tcsr: syscon@1fc0000 {
>>  			reg = <0x0 0x01fc0000 0x0 0x30000>;
>>  		};
>>  
>> +		gpu: gpu@3d00000 {
>> +			compatible = "qcom,adreno-690.0", "qcom,adreno";
>> +
>> +			reg = <0 0x03d00000 0 0x40000>,
>> +			      <0 0x03d9e000 0 0x1000>,
>> +			      <0 0x03d61000 0 0x800>;
>> +			reg-names = "kgsl_3d0_reg_memory",
>> +				    "cx_mem",
>> +				    "cx_dbgc";
>> +			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
>> +			iommus = <&adreno_smmu 0 0xc00>, <&adreno_smmu 1 0xc00>;
>> +			operating-points-v2 = <&gpu_opp_table>;
>> +
>> +			qcom,gmu = <&gmu>;
>> +			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
>> +			interconnect-names = "gfx-mem";
I also noticed downstream adds additional votes for L3 (*not* LLCC), should
we explore that?

Konrad
>> +			#cooling-cells = <2>;
>> +
>> +			status = "disabled";
>> +
>> +			gpu_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-270000000 {
>> +					opp-hz = /bits/ 64 <270000000>;
>> +					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +					opp-peak-kBps = <451000>;
>> +				};
>> +
>> +				opp-410000000 {
>> +					opp-hz = /bits/ 64 <410000000>;
>> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
>> +					opp-peak-kBps = <1555000>;
>> +				};
>> +
>> +				opp-500000000 {
>> +					opp-hz = /bits/ 64 <500000000>;
>> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>> +					opp-peak-kBps = <1555000>;
>> +				};
>> +
>> +				opp-547000000 {
>> +					opp-hz = /bits/ 64 <547000000>;
>> +					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
>> +					opp-peak-kBps = <1555000>;
>> +				};
>> +
>> +				opp-606000000 {
>> +					opp-hz = /bits/ 64 <606000000>;
>> +					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>> +					opp-peak-kBps = <2736000>;
>> +				};
>> +
>> +				opp-640000000 {
>> +					opp-hz = /bits/ 64 <640000000>;
>> +					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
>> +					opp-peak-kBps = <2736000>;
>> +				};
>> +
>> +				opp-690000000 {
>> +					opp-hz = /bits/ 64 <690000000>;
>> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
>> +					opp-peak-kBps = <2736000>;
>> +				};
>> +			};
>> +		};
>> +
>> +		gmu: gmu@3d6a000 {
>> +			compatible = "qcom,adreno-gmu-690.0", "qcom,adreno-gmu";
>> +			reg = <0 0x03d6a000 0 0x34000>,
>> +			      <0 0x03de0000 0 0x10000>,
>> +			      <0 0x0b290000 0 0x10000>;
>> +			reg-names = "gmu", "rscc", "gmu_pdc";
>> +			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hfi", "gmu";
>> +			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
>> +				 <&gpucc GPU_CC_CXO_CLK>,
>> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
>> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
>> +				 <&gpucc GPU_CC_AHB_CLK>,
>> +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
>> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
>> +			clock-names = "gmu",
>> +				      "cxo",
>> +				      "axi",
>> +				      "memnoc",
>> +				      "ahb",
>> +				      "hub",
>> +				      "smmu_vote";
>> +			power-domains = <&gpucc GPU_CC_CX_GDSC>,
>> +					<&gpucc GPU_CC_GX_GDSC>;
>> +			power-domain-names = "cx",
>> +					     "gx";
>> +			iommus = <&adreno_smmu 5 0xc00>;
>> +			operating-points-v2 = <&gmu_opp_table>;
>> +
>> +			status = "disabled";
> I've recently discovered that - and I am not 100% sure - all GMUs are
> cache-coherent. Could you please ask somebody at qc about this?
> 
>> +
>> +			gmu_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-200000000 {
>> +					opp-hz = /bits/ 64 <200000000>;
>> +					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>> +				};
> Missing 500MHz + RPMH_REGULATOR_LEVEL_SVS
> 
> (that may be used in the future for hw scheduling)
>> +			};
>> +		};
>> +
>> +		gpucc: clock-controller@3d90000 {
>> +			compatible = "qcom,sc8280xp-gpucc";
>> +			reg = <0 0x03d90000 0 0x9000>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
>> +				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
>> +			clock-names = "bi_tcxo",
>> +				      "gcc_gpu_gpll0_clk_src",
>> +				      "gcc_gpu_gpll0_div_clk_src";
> FWIW the driver doesn't use clock-names, but the binding defines it,
> so I suppose it's fine
> 
>> +
>> +			power-domains = <&rpmhpd SC8280XP_GFX>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +
>> +			status = "disabled";
>> +		};
>> +
>> +		adreno_smmu: iommu@3da0000 {
>> +			compatible = "qcom,sc8280xp-smmu-500", "qcom,adreno-smmu",
>> +				     "qcom,smmu-500", "arm,mmu-500";
>> +			reg = <0 0x03da0000 0 0x20000>;
>> +			#iommu-cells = <2>;
>> +			#global-interrupts = <2>;
>> +			interrupts = <GIC_SPI 672 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
>> +				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
>> +				 <&gpucc GPU_CC_AHB_CLK>,
>> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
>> +				 <&gpucc GPU_CC_CX_GMU_CLK>,
>> +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
>> +				 <&gpucc GPU_CC_HUB_AON_CLK>;
>> +			clock-names = "gcc_gpu_memnoc_gfx_clk",
>> +				      "gcc_gpu_snoc_dvm_gfx_clk",
>> +				      "gpu_cc_ahb_clk",
>> +				      "gpu_cc_hlos1_vote_gpu_smmu_clk",
>> +				      "gpu_cc_cx_gmu_clk",
>> +				      "gpu_cc_hub_cx_int_clk",
>> +				      "gpu_cc_hub_aon_clk";
>> +
>> +			power-domains = <&gpucc GPU_CC_CX_GDSC>;
>> +
>> +			status = "disabled";
> This one should be dma-coherent (per downstream, plus 8350's mmu is for sure)
> 
> Konrad
>> +		};
>> +
>>  		usb_0_hsphy: phy@88e5000 {
>>  			compatible = "qcom,sc8280xp-usb-hs-phy",
>>  				     "qcom,usb-snps-hs-5nm-phy";
