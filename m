Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B607C6DE520
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDKTuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKTux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:50:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F39E2D77
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:50:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z8so13670840lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681242648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOaG+PaHenUckG/HmcCcVyiFAGvfVYsjP1gKXvLt2sQ=;
        b=J0q5NPXG+H8BAby7O6g2YcHLXCo4+0dRypQpWSlXYUf+22+ThYj80nRh2c8dF1kJML
         IUa0sk0CdVDCwCUwM3S/6+gTywNXhZC/4AwMpUmlHvRq5oPuPgDYBdVtlinYO3yzCGVn
         x9XpoURBuY/TWj5m22OI30xpNyADp6YqQCRN/dHpSbTO4m81KLIFTcUyuw4mQZ6b6kmU
         b0O6+rbhEiOOcFRCwK90/mcG1eGnNpNudTmjtASHmMj+CQozJbHSdF0z6OZdJpjAMiqe
         LxmhynN6wwyo6HiW8+5PoEyg74eUy6t5F88TaRf31eSIgtCg5EERBaplLTAKffnhViYn
         52nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681242648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOaG+PaHenUckG/HmcCcVyiFAGvfVYsjP1gKXvLt2sQ=;
        b=Hf3WH8JxTVWOp6la8oeG3AoWN06n2NGeBNsX79FFdBtylF8WBuTbIZ0f7oUmxyZbdu
         dnyL8BQ55mgR2OSuDmdIzEvtsIPJj8dCSuC5UQh8cLtdBrdyn9bEGjBDCD2XFhyb2TcB
         ZJXaId7n+XrEXpoHFlm9NbYss74dkWz0aTjcLTK4pIfYlbojKpdDX0+R8kauwQ8x2xUG
         kKVNHyWMY1uxrJSWjBOJxaYnfRDC6a5hSebFjXv2u5c8Ij5N8cJEGjea2AH4zGsZ+m37
         3ZgMhbG0Og9YezQ3wxqJi08SX4BVZ6CNg8Aln3yJlGKXLcwPDttAEPXpDZ6EmClMpfF+
         NtIg==
X-Gm-Message-State: AAQBX9cI2EIlEAwTOh6kNdgV5mIawOxbfVP4BHH6cS8StGIewVGLWuOs
        g+4fSj1J6VQEUD9P9xn/BvHPxg==
X-Google-Smtp-Source: AKy350aYtghLr2w5tKRLDF4OjwB0D514YZIPVY+ttfl5WYaiNDwkx4YnlL0vMDYjUsFepxoQsC4mCw==
X-Received: by 2002:a05:6512:3b2a:b0:4d8:86c1:477d with SMTP id f42-20020a0565123b2a00b004d886c1477dmr98465lfv.18.1681242647825;
        Tue, 11 Apr 2023 12:50:47 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id b7-20020ac24107000000b004e9b307d2c8sm2656277lfi.238.2023.04.11.12.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 12:50:47 -0700 (PDT)
Message-ID: <923fb538-a28a-2172-569f-b58349157d49@linaro.org>
Date:   Tue, 11 Apr 2023 21:50:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: sa8775p: add the GPU IOMMU node
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230411125910.401075-1-brgl@bgdev.pl>
 <20230411125910.401075-8-brgl@bgdev.pl>
 <6c75d434-bb5d-278f-a125-d096fd6b387d@linaro.org>
 <CAMRc=MdLckYzUjDQzbNUaaviuABEDXcs0ctW6+-3fZiCbvfYQA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAMRc=MdLckYzUjDQzbNUaaviuABEDXcs0ctW6+-3fZiCbvfYQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.04.2023 16:41, Bartosz Golaszewski wrote:
> On Tue, Apr 11, 2023 at 3:16 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 11.04.2023 14:59, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Add the Adreno GPU IOMMU for sa8775p-based platforms.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 37 +++++++++++++++++++++++++++
>>>  1 file changed, 37 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> index 191b510b5a1a..11f3d80dd869 100644
>>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> @@ -7,6 +7,7 @@
>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>  #include <dt-bindings/clock/qcom,rpmh.h>
>>>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>>> +#include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
>>>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
>>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> @@ -605,6 +606,42 @@ gpucc: clock-controller@3d90000 {
>>>                       #power-domain-cells = <1>;
>>>               };
>>>
>>> +             adreno_smmu: iommu@3da0000 {
>>> +                     compatible = "qcom,sa8775p-smmu-500", "qcom,adreno-smmu",
>>> +                                  "arm,mmu-500";
>> Err.. does it even boot like this? You dropped the qcom,smmu-500 compatible
>> which means it's getting bound to the generic SMMU driver (without
>> QC quirks). If that was a mistake, you should have had all 4
>>
>> "qcom,sa8775p-smmu-500", qcom,adreno-smmu, "qcom,smmu-500", "arm,mmu-500"
>>
>> Without falling into the qc-specific codepaths, the Adreno compat does
>> nothing.
>>
> 
> I did that initially, then noticed dtbs_check fails because the
> existing adreno GPUs implementing "arm,smmu-500" expect three
> compatibles like in this commit. I did that and the driver still
> probed the same so I assumed all's good. You're right of course, the
> adreno impl is not being assigned without "qcom,smmu-500". Are the
> bindings wrong in this case and should it be something like the
> following?
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index d966dc65ce10..cd1b052a7242 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -84,6 +84,7 @@ properties:
>                - qcom,sm8150-smmu-500
>                - qcom,sm8250-smmu-500
>            - const: qcom,adreno-smmu
> +          - const: qcom,smmu-500
>            - const: arm,mmu-500
>        - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
>          items:
> 
> Bartosz
Check

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-joerg/arm-smmu/bindings&id=5c3686616b1840b3143b227eb58fb1c1621d204e

Konrad
> 
>> Konrad
>>> +                     reg = <0x0 0x03da0000 0x0 0x20000>;
>>> +                     #iommu-cells = <2>;
>>> +                     #global-interrupts = <2>;
>>> +                     dma-coherent;
>>> +                     power-domains = <&gpucc GPU_CC_CX_GDSC>;
>>> +                     clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
>>> +                              <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
>>> +                              <&gpucc GPU_CC_AHB_CLK>,
>>> +                              <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
>>> +                              <&gpucc GPU_CC_CX_GMU_CLK>,
>>> +                              <&gpucc GPU_CC_HUB_CX_INT_CLK>,
>>> +                              <&gpucc GPU_CC_HUB_AON_CLK>;
>>> +                     clock-names = "gcc_gpu_memnoc_gfx_clk",
>>> +                                   "gcc_gpu_snoc_dvm_gfx_clk",
>>> +                                   "gpu_cc_ahb_clk",
>>> +                                   "gpu_cc_hlos1_vote_gpu_smmu_clk",
>>> +                                   "gpu_cc_cx_gmu_clk",
>>> +                                   "gpu_cc_hub_cx_int_clk",
>>> +                                   "gpu_cc_hub_aon_clk";
>>> +                     interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
>>> +             };
>>> +
>>>               pdc: interrupt-controller@b220000 {
>>>                       compatible = "qcom,sa8775p-pdc", "qcom,pdc";
>>>                       reg = <0x0 0x0b220000 0x0 0x30000>,
