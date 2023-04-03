Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1536D5102
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjDCSuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjDCSuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:50:15 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3407810A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:50:13 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a44so12739402ljr.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680547811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34OsiV+HcR1Gi97aMPkJXnZL+SR4sm/mvS50rqlBF+Q=;
        b=amoM9RmfbP94Mds/R+ONKjXWMll2NfsHiIZvQ4QegviMRyQS9S6DWUP9+1jgfrPibR
         BPjT1XTaXj45lw0IKtexiqjMtrsszNEMDDpTb+Xwf+VJaNz/ccbcPuCyIqrmrIiq4ExU
         oFFPog8fInWwgYWCOUyQmcUu1+tfn4g/nw3qEL4wOf6yMYv3TVfPkKU6nrn0VE5G6mWo
         +HBUBk7b79AJBcmbpmNCqMZm0px3GvOOWfUsh47SUSxkI5kuqywvbTRpCB/FyB6Plds0
         DLln4iU/5mpejBwGuuHJMMS5squwgv2VQIvYo2zhIe3153hVQEDL9kp4flna9NfBPkt/
         VDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34OsiV+HcR1Gi97aMPkJXnZL+SR4sm/mvS50rqlBF+Q=;
        b=N2zH7JClImTknzoZCk4UMlhmWuazs+ZRnJWNvcs0e9UVqVeNHSypNfiStu9klCMRSJ
         nFEvftwfcNSvBnEpE2QAo31C3igN8n2r0sJQzMfSwOLDa0PeoF2ZzI1vdn0JTS8P/8yO
         yM7L22q+Dw8Q6xOXlRsHILCQaO7tQ7drbGu+EUlg2c5JRAxu+CvHe2Jr6kkcL0SBg0Ov
         o6VdB97S9B1y1+yMDcbq9iEoPEXpNe7xEqdgDlI1juAs9YC7/nEsDQTLCurHai8t7/gg
         vwk8GfJD7ySt9rRrsDKyMSood2ib4ih3ixUUMmU5gu39037NXk3ObOeYzXfHVuf3nNsD
         iqOg==
X-Gm-Message-State: AAQBX9eHCmK7w1UmnGzFw37gZuJjT+47YzpRQ+CQJRmXyLyjlTiavUmU
        aJEAeMIZExKFwdoArz9K5ADhVg==
X-Google-Smtp-Source: AKy350ali/QWGVvd1aGDfLcj89eKxHreHPi0Fm4xFgPrFBNVg6Mf1FVOeMpojAXfWL7BkeZLCQ/sVg==
X-Received: by 2002:a2e:9ad9:0:b0:29c:9617:842c with SMTP id p25-20020a2e9ad9000000b0029c9617842cmr168893ljj.7.1680547811276;
        Mon, 03 Apr 2023 11:50:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id l16-20020a2e9090000000b0029bd5a0f4a8sm1828099ljg.61.2023.04.03.11.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 11:50:10 -0700 (PDT)
Message-ID: <d279d2fa-e255-1e43-780c-6bdac437469d@linaro.org>
Date:   Mon, 3 Apr 2023 21:50:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sm6350: Add GPU nodes
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
 <20230315-topic-lagoon_gpu-v1-4-a74cbec4ecfc@linaro.org>
 <CR8J7A4RGCHZ.293RWUBS367M2@otso>
 <22cfb674-eb2b-ff77-da87-cf6b520e592d@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <22cfb674-eb2b-ff77-da87-cf6b520e592d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2023 15:45, Konrad Dybcio wrote:
> 
> 
> On 17.03.2023 09:56, Luca Weiss wrote:
>> On Thu Mar 16, 2023 at 12:16 PM CET, Konrad Dybcio wrote:
>>> From: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>
>>> Add Adreno, GPU SMMU and GMU nodes to hook up everything that
>>> the A619 needs to function properly.
>>>
>>> Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
> [...]
> 
>> What about adding interconnect already? I also have opp-peak-kBps
>> additions in the opp table for that. I'll attach the diff I have at the
>> end of the email.
> I believe the GMU takes care of it internally (or at least should)
> with the bandwidth tables we send in a6xx_hfi.c : a6xx_hfi_send_bw_table()

We should still declare the interconnects. If at some point we attempt 
to fill these tables in a proper way, the interconnects will be required 
to get addresses of the nodes.

> 
> 
> [...]
> 
>>>   
>>> +		adreno_smmu: iommu@3d40000 {
>>
>> This and gmu should be above gpucc @3d90000?
> Absolutely.
> 
> Konrad
>>
>>> +			compatible = "qcom,sm6350-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
>>> +			reg = <0 0x03d40000 0 0x10000>;
>>> +			#iommu-cells = <1>;
>>> +			#global-interrupts = <2>;
>>> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
>>> +
>>> +			clocks = <&gpucc GPU_CC_AHB_CLK>,
>>> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
>>> +				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
>>> +			clock-names = "ahb",
>>> +				      "bus",
>>> +				      "iface";
>>> +
>>> +			power-domains = <&gpucc GPU_CX_GDSC>;
>>> +		};
>>> +
>>> +		gmu: gmu@3d6a000 {
>>> +			compatible = "qcom,adreno-gmu-619.0", "qcom,adreno-gmu";
>>> +			reg = <0 0x03d6a000 0 0x31000>,
>>> +			      <0 0x0b290000 0 0x10000>,
>>> +			      <0 0x0b490000 0 0x10000>;
>>> +			reg-names = "gmu",
>>> +				    "gmu_pdc",
>>> +				    "gmu_pdc_seq";
>>> +
>>> +			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
>>> +			interrupt-names = "hfi",
>>> +					  "gmu";
>>> +
>>> +			clocks = <&gpucc GPU_CC_AHB_CLK>,
>>> +				 <&gpucc GPU_CC_CX_GMU_CLK>,
>>> +				 <&gpucc GPU_CC_CXO_CLK>,
>>> +				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
>>> +				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
>>> +			clock-names = "ahb",
>>> +				      "gmu",
>>> +				      "cxo",
>>> +				      "axi",
>>> +				      "memnoc";
>>> +
>>> +			power-domains = <&gpucc GPU_CX_GDSC>,
>>> +					<&gpucc GPU_GX_GDSC>;
>>> +			power-domain-names = "cx",
>>> +					     "gx";
>>> +
>>> +			iommus = <&adreno_smmu 5>;
>>> +
>>> +			operating-points-v2 = <&gmu_opp_table>;
>>> +
>>> +			status = "disabled";
>>> +
>>> +			gmu_opp_table: opp-table {
>>> +				compatible = "operating-points-v2";
>>> +
>>> +				opp-200000000 {
>>> +					opp-hz = /bits/ 64 <200000000>;
>>> +					opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>>> +				};
>>> +			};
>>> +		};
>>> +
>>>   		mpss: remoteproc@4080000 {
>>>   			compatible = "qcom,sm6350-mpss-pas";
>>>   			reg = <0x0 0x04080000 0x0 0x4040>;
>>>
>>> -- 
>>> 2.39.2
>>
>> Here's the diff I have for interconnect on top of this:
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> index 4954cbc2c0fc..51c5ac679a32 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>> @@ -1142,6 +1142,8 @@ gpu: gpu@3d00000 {
>>   			iommus = <&adreno_smmu 0>;
>>   			operating-points-v2 = <&gpu_opp_table>;
>>   			qcom,gmu = <&gmu>;
>> +			interconnects = <&gem_noc MASTER_GRAPHICS_3D 0 &clk_virt SLAVE_EBI_CH0 0>;
>> +			interconnect-names = "gfx-mem";
>>   			nvmem-cells = <&gpu_speed_bin>;
>>   			nvmem-cell-names = "speed_bin";
>>   
>> @@ -1157,42 +1159,49 @@ gpu_opp_table: opp-table {
>>   				opp-850000000 {
>>   					opp-hz = /bits/ 64 <850000000>;
>>   					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
>> +					opp-peak-kBps = <8371200>;
>>   					opp-supported-hw = <0x02>;
>>   				};
>>   
>>   				opp-800000000 {
>>   					opp-hz = /bits/ 64 <800000000>;
>>   					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
>> +					opp-peak-kBps = <8371200>;
>>   					opp-supported-hw = <0x04>;
>>   				};
>>   
>>   				opp-650000000 {
>>   					opp-hz = /bits/ 64 <650000000>;
>>   					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
>> +					opp-peak-kBps = <6220000>;
>>   					opp-supported-hw = <0x08>;
>>   				};
>>   
>>   				opp-565000000 {
>>   					opp-hz = /bits/ 64 <565000000>;
>>   					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>> +					opp-peak-kBps = <5412000>;
>>   					opp-supported-hw = <0x10>;
>>   				};
>>   
>>   				opp-430000000 {
>>   					opp-hz = /bits/ 64 <430000000>;
>>   					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>> +					opp-peak-kBps = <4068000>;
>>   					opp-supported-hw = <0xff>;
>>   				};
>>   
>>   				opp-355000000 {
>>   					opp-hz = /bits/ 64 <355000000>;
>>   					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
>> +					opp-peak-kBps = <3072000>;
>>   					opp-supported-hw = <0xff>;
>>   				};
>>   
>>   				opp-253000000 {
>>   					opp-hz = /bits/ 64 <253000000>;
>>   					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +					opp-peak-kBps = <2188000>;
>>   					opp-supported-hw = <0xff>;
>>   				};
>>   			};
>>

-- 
With best wishes
Dmitry

