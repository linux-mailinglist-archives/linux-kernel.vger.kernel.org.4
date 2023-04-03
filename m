Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286DE6D510D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjDCSw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjDCSwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:52:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B68A2D6D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:52:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h25so39344488lfv.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680547939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdkM6igYr2rvDGZ/puVAK0hnxL7d85y+2Gx+34VN4Qs=;
        b=TjUPF7u69AFcDQbVFBS337l4G+LyOdg2xZaDmEirRpI1+ikM0XjknpsGiUugeGvsTQ
         RVBe3C39CUvCvtO7sGWO8UJUzPSML/BhcX2dXj2uZ8unxioJOYYfQZKzJx3orvN1XZsf
         BwBMMDLvbo/0MZ5YI3i4sqAzal1hFwfXoNuIiL0hpIq0LPE0kCz7A7lpqz4vJSEQb+cf
         yDf1Gov1QQ9lFjC4CYETPXrdqOCPhcAlzvZoGdbeuKc6ZIULLmFdLSnFmLeJnrFAGyf6
         lK0qe6c8GBruXheILsMBLm5dTCdsZax1zIBk86OpR+f/Ba+sSNIC3SHkcgXmZKvRrIBJ
         unvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdkM6igYr2rvDGZ/puVAK0hnxL7d85y+2Gx+34VN4Qs=;
        b=hVKmQUSC+H9hp4ZyhvjEIgTjgwJvim2kn+Dlve0Se+Ijw2NTvp5f1bxg+AoBtI0cq4
         Ts9nOJMOnpRVpVkXRWDUzUtJKEkMQNwjGH/hM10sRT7U0OR99Zy0o8PkUQiscft1C0xw
         6ezcIS4sY6j09/2Z31VbMNN0U2I4bbkziEjV5Q8RlFRgHYRk9xOwk7el3HvFnxSDl1Wj
         8zirRsLcDM7tAMh4PUW86iyDdo0YMcn2lnC4kCsdlmAmUQMBI+wALY0OqEfc1PIIVlB4
         /IlmHzwUpGHehFZN5CpC+KFQwbmK9R9ieBJvt4Khb1bqt9rsZxLpx1Pls/FEQb1yj+uV
         dCAg==
X-Gm-Message-State: AAQBX9fMqf+evUOw7cG9BFFleBjOwihPbbcK6dQZLCrx674LIGe28Fdq
        IFe1inLXe0I9xUiytgYo4HMcmQ==
X-Google-Smtp-Source: AKy350Z5S2hEeZ7KFuUAX3nMQJJDXHQlkxLNH9vm/jDjnH0szKNfE7GYl0EhnSxVBxfsRuOVilwnfg==
X-Received: by 2002:ac2:5291:0:b0:4b9:a91c:b0c9 with SMTP id q17-20020ac25291000000b004b9a91cb0c9mr9906339lfm.7.1680547939635;
        Mon, 03 Apr 2023 11:52:19 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id m11-20020ac24acb000000b004e95a1aca1bsm1880605lfp.87.2023.04.03.11.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 11:52:19 -0700 (PDT)
Message-ID: <2492cd8f-8edc-4335-3af0-770e581e6355@linaro.org>
Date:   Mon, 3 Apr 2023 20:52:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sm6350: Add GPU nodes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
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
        linux-kernel@vger.kernel.org
References: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
 <20230315-topic-lagoon_gpu-v1-4-a74cbec4ecfc@linaro.org>
 <CR8J7A4RGCHZ.293RWUBS367M2@otso>
 <22cfb674-eb2b-ff77-da87-cf6b520e592d@linaro.org>
 <d279d2fa-e255-1e43-780c-6bdac437469d@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <d279d2fa-e255-1e43-780c-6bdac437469d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.04.2023 20:50, Dmitry Baryshkov wrote:
> On 18/03/2023 15:45, Konrad Dybcio wrote:
>>
>>
>> On 17.03.2023 09:56, Luca Weiss wrote:
>>> On Thu Mar 16, 2023 at 12:16 PM CET, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>
>>>> Add Adreno, GPU SMMU and GMU nodes to hook up everything that
>>>> the A619 needs to function properly.
>>>>
>>>> Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>> [...]
>>
>>> What about adding interconnect already? I also have opp-peak-kBps
>>> additions in the opp table for that. I'll attach the diff I have at the
>>> end of the email.
>> I believe the GMU takes care of it internally (or at least should)
>> with the bandwidth tables we send in a6xx_hfi.c : a6xx_hfi_send_bw_table()
> 
> We should still declare the interconnects. If at some point we attempt to fill these tables in a proper way, the interconnects will be required to get addresses of the nodes.
A619 has all the "proper" data filled in. This should arguably
be switched to per-SoC and not per-GPU btw.

The interconnect endpoints should be looked up through the cmd_db
function like Bjorn did in the A690 patchset.

Konrad
> 
>>
>>
>> [...]
>>
>>>>   +        adreno_smmu: iommu@3d40000 {
>>>
>>> This and gmu should be above gpucc @3d90000?
>> Absolutely.
>>
>> Konrad
>>>
>>>> +            compatible = "qcom,sm6350-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
>>>> +            reg = <0 0x03d40000 0 0x10000>;
>>>> +            #iommu-cells = <1>;
>>>> +            #global-interrupts = <2>;
>>>> +            interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
>>>> +
>>>> +            clocks = <&gpucc GPU_CC_AHB_CLK>,
>>>> +                 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
>>>> +                 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
>>>> +            clock-names = "ahb",
>>>> +                      "bus",
>>>> +                      "iface";
>>>> +
>>>> +            power-domains = <&gpucc GPU_CX_GDSC>;
>>>> +        };
>>>> +
>>>> +        gmu: gmu@3d6a000 {
>>>> +            compatible = "qcom,adreno-gmu-619.0", "qcom,adreno-gmu";
>>>> +            reg = <0 0x03d6a000 0 0x31000>,
>>>> +                  <0 0x0b290000 0 0x10000>,
>>>> +                  <0 0x0b490000 0 0x10000>;
>>>> +            reg-names = "gmu",
>>>> +                    "gmu_pdc",
>>>> +                    "gmu_pdc_seq";
>>>> +
>>>> +            interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            interrupt-names = "hfi",
>>>> +                      "gmu";
>>>> +
>>>> +            clocks = <&gpucc GPU_CC_AHB_CLK>,
>>>> +                 <&gpucc GPU_CC_CX_GMU_CLK>,
>>>> +                 <&gpucc GPU_CC_CXO_CLK>,
>>>> +                 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
>>>> +                 <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
>>>> +            clock-names = "ahb",
>>>> +                      "gmu",
>>>> +                      "cxo",
>>>> +                      "axi",
>>>> +                      "memnoc";
>>>> +
>>>> +            power-domains = <&gpucc GPU_CX_GDSC>,
>>>> +                    <&gpucc GPU_GX_GDSC>;
>>>> +            power-domain-names = "cx",
>>>> +                         "gx";
>>>> +
>>>> +            iommus = <&adreno_smmu 5>;
>>>> +
>>>> +            operating-points-v2 = <&gmu_opp_table>;
>>>> +
>>>> +            status = "disabled";
>>>> +
>>>> +            gmu_opp_table: opp-table {
>>>> +                compatible = "operating-points-v2";
>>>> +
>>>> +                opp-200000000 {
>>>> +                    opp-hz = /bits/ 64 <200000000>;
>>>> +                    opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>>>> +                };
>>>> +            };
>>>> +        };
>>>> +
>>>>           mpss: remoteproc@4080000 {
>>>>               compatible = "qcom,sm6350-mpss-pas";
>>>>               reg = <0x0 0x04080000 0x0 0x4040>;
>>>>
>>>> -- 
>>>> 2.39.2
>>>
>>> Here's the diff I have for interconnect on top of this:
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>> index 4954cbc2c0fc..51c5ac679a32 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>> @@ -1142,6 +1142,8 @@ gpu: gpu@3d00000 {
>>>               iommus = <&adreno_smmu 0>;
>>>               operating-points-v2 = <&gpu_opp_table>;
>>>               qcom,gmu = <&gmu>;
>>> +            interconnects = <&gem_noc MASTER_GRAPHICS_3D 0 &clk_virt SLAVE_EBI_CH0 0>;
>>> +            interconnect-names = "gfx-mem";
>>>               nvmem-cells = <&gpu_speed_bin>;
>>>               nvmem-cell-names = "speed_bin";
>>>   @@ -1157,42 +1159,49 @@ gpu_opp_table: opp-table {
>>>                   opp-850000000 {
>>>                       opp-hz = /bits/ 64 <850000000>;
>>>                       opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
>>> +                    opp-peak-kBps = <8371200>;
>>>                       opp-supported-hw = <0x02>;
>>>                   };
>>>                     opp-800000000 {
>>>                       opp-hz = /bits/ 64 <800000000>;
>>>                       opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
>>> +                    opp-peak-kBps = <8371200>;
>>>                       opp-supported-hw = <0x04>;
>>>                   };
>>>                     opp-650000000 {
>>>                       opp-hz = /bits/ 64 <650000000>;
>>>                       opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
>>> +                    opp-peak-kBps = <6220000>;
>>>                       opp-supported-hw = <0x08>;
>>>                   };
>>>                     opp-565000000 {
>>>                       opp-hz = /bits/ 64 <565000000>;
>>>                       opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>>> +                    opp-peak-kBps = <5412000>;
>>>                       opp-supported-hw = <0x10>;
>>>                   };
>>>                     opp-430000000 {
>>>                       opp-hz = /bits/ 64 <430000000>;
>>>                       opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>>> +                    opp-peak-kBps = <4068000>;
>>>                       opp-supported-hw = <0xff>;
>>>                   };
>>>                     opp-355000000 {
>>>                       opp-hz = /bits/ 64 <355000000>;
>>>                       opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
>>> +                    opp-peak-kBps = <3072000>;
>>>                       opp-supported-hw = <0xff>;
>>>                   };
>>>                     opp-253000000 {
>>>                       opp-hz = /bits/ 64 <253000000>;
>>>                       opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>>> +                    opp-peak-kBps = <2188000>;
>>>                       opp-supported-hw = <0xff>;
>>>                   };
>>>               };
>>>
> 
