Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2728619393
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiKDJc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiKDJc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:32:26 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8760627933
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:32:24 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 139F9401A0;
        Fri,  4 Nov 2022 10:32:21 +0100 (CET)
Message-ID: <23a0dc6b-b704-c094-96dc-cf2c083ef55e@somainline.org>
Date:   Fri, 4 Nov 2022 10:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026200429.162212-1-quic_molvera@quicinc.com>
 <20221026200429.162212-4-quic_molvera@quicinc.com>
 <ae4b2333-d243-17ee-1ebd-6b1c89eef9f3@linaro.org>
 <d109cbdf-1b0e-ff67-879c-d0955da4898e@quicinc.com>
 <9eaaf256-8de2-ddc9-ac95-aed9b0670f5e@linaro.org>
 <4832b716-6caf-cf72-1c7e-f21a0670cbaa@quicinc.com>
 <5109d728-ebea-21ca-3ee1-15710dfd6f1b@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <5109d728-ebea-21ca-3ee1-15710dfd6f1b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 05:05, Trilok Soni wrote:
> + Adding Konrad, Bjorn is already there in this email
>
> On 11/3/2022 2:13 PM, Melody Olvera wrote:
>>
>>
>> On 11/2/2022 9:24 AM, Krzysztof Kozlowski wrote:
>>> On 31/10/2022 17:49, Melody Olvera wrote:
>>>>
>>>> On 10/27/2022 8:21 AM, Krzysztof Kozlowski wrote:
>>>>> On 26/10/2022 16:04, Melody Olvera wrote:
>>>>>> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
>>>>>> descriptions of CPUs, GCC, RPMHCC, QUP, TLMM, and 
>>>>>> interrupt-controller
>>>>>> to boot to shell with console on these SoCs.
>>>>>>
>>>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>>>> ---
>>>>>>   arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1406 
>>>>>> +++++++++++++++++++++++++
>>>>> Please use scripts/get_maintainers.pl to get a list of necessary 
>>>>> people
>>>>> and lists to CC.  It might happen, that command when run on an older
>>>>> kernel, gives you outdated entries.  Therefore please be sure you 
>>>>> base
>>>>> your patches on recent Linux kernel.
>>>> Sure thing; we talked about this on a different patch.
>>>>>> arch/arm64/boot/dts/qcom/qru1000.dtsi |   27 +
>>>>>>   2 files changed, 1433 insertions(+)
>>>>>>   create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>>>>>   create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi 
>>>>>> b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>>>>> new file mode 100644
>>>>>> index 000000000000..76474106e931
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>>>>> @@ -0,0 +1,1406 @@
>>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>>> +/*
>>>>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All 
>>>>>> rights reserved.
>>>>>> + */
>>>>> (...)
>>>>>
>>>>>> +
>>>>>> +    soc: soc@0 {
>>>>>> +        #address-cells = <2>;
>>>>>> +        #size-cells = <2>;
>>>>>> +        ranges = <0 0 0 0 0x10 0>;
>>>>>> +        dma-ranges = <0 0 0 0 0x10 0>;
>>>>>> +        compatible = "simple-bus";
>>>>>> +
>>>>>> +        gcc: clock-controller@80000 {
>>>>>> +            compatible = "qcom,gcc-qdu1000", "syscon";
>>>>>> +            reg = <0x0 0x80000 0x0 0x1f4200>;
>>>>>> +            #clock-cells = <1>;
>>>>>> +            #reset-cells = <1>;
>>>>>> +            #power-domain-cells = <1>;
>>>>>> +            clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
>>>>>> +            clock-names = "bi_tcxo", "sleep_clk";
>>>>>> +        };
>>>>>> +
>>>>>> +        gpi_dma0: dma-controller@900000  {
>>>>>> +            compatible = "qcom,sm6350-gpi-dma";
>>>>> You should add here a specific compatible as well. Same in other 
>>>>> places.
>>>>> All places. I had impression we talked about this few times, so I 
>>>>> don't
>>>>> know what is missing on your side.
>>>>>
>>>>> This must be:
>>>>> "qcom,qdu1000-gpi-dma", "qcom,sm6350-gpi-dma"
>>>> Got it. I talked to Stephan and he said either your suggestion or 
>>>> just using
>>>> preexisting compatibles would be ok. I thought it might be cleaner 
>>>> to not
>>>> have the qdu compats, but I'm fine either way.

We use specific compats so that if it turns out this specific SoC (or 
rather the

bundled firmware) has some peculiar bugs, we can retroactively only 
apply them

to that specific SoC by adding the compatible somewhere in .c code if 
need be.


>>>>>> +            #dma-cells = <3>;
>>>>>> +            reg = <0x0 0x900000 0x0 0x60000>;
>>>>>> +            interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +            dma-channels = <12>;
>>>>>> +            dma-channel-mask = <0x3f>;
>>>>>> +            iommus = <&apps_smmu 0xf6 0x0>;
>>>>>> +        };
>>>>>> +
>>>>> (...)
>>>>>
>>>>>
>>>>>> +
>>>>>> +        tlmm: pinctrl@f000000 {
>>>>>> +            compatible = "qcom,qdu1000-tlmm";
>>>>>> +            reg = <0x0 0xf000000 0x0 0x1000000>;
>>>>>> +            interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +            gpio-controller;
>>>>>> +            #gpio-cells = <2>;
>>>>>> +            interrupt-controller;
>>>>>> +            #interrupt-cells = <2>;
>>>>>> +            gpio-ranges = <&tlmm 0 0 151>;
>>>>>> +            wakeup-parent = <&pdc>;
>>>>>> +
>>>>>> +            qup_uart0_default: qup-uart0-default-state {
>>>>>> +                pins = "gpio6", "gpio7", "gpio8", "gpio9";
>>>>>> +                function = "qup00";
>>>>>> +            };
>>>>>> +
>>>>>> +            qup_i2c1_data_clk: qup-i2c1-data-clk-state {
>>>>>> +                pins = "gpio10", "gpio11";
>>>>>> +                function = "qup01";
>>>>>> +                drive-strength = <2>;
>>>>> Can we have some generic agreement where to put drive-strengths 
>>>>> and bias?
>>>>>
>>>>> See also:
>>>>> https://lore.kernel.org/linux-devicetree/20221026200357.391635-2-krzysztof.kozlowski@linaro.org/ 
>>>>>
>>>>>
>>>>> https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/ 
>>>>>

I agree with Doug on having 'generic' drive-strength. Moreover, maybe 
even adding some property like

bias-type = <NONE/PULL_DOWN/...> would be cool to make it more flexible 
so that we could trim off

A LOT of repeated lines (remember, most boards are more or less copies 
of the reference design for a

given platform like QRD or CRD) going forward.


>>>> Not sure how much two-sense I have for the conversation at large, 
>>>> but generally I agree with Doug's
>>>> point in the first paragraph. Pulls for this soc are consistent 
>>>> across boards so I don't think it makes
>>>> sense to move them to the board files here. I vote that these stay 
>>>> here.
>>> I would be great if Konrad and Bjorn shared their opinion on this... 
>>> but
>>> wait, you did not Cc all maintainers... Eh.
>> I'm not sure why this is being brought up again; we've already 
>> discussed this here
>> https://lore.kernel.org/all/9707bf67-1b22-8a77-7193-fc909b4f49de@quicinc.com/ 
>>
>> Would you like to discuss this issue here, on the next version, or 
>> not at all?
>>
>> On a side note, I'm uncomfortable with how our continued interactions 
>> are going
>> and do not believe this to be conductive to continued collaboration. 
>> I would ask that
>> we keep our correspondence polite and professional moving forward.
>
> I have added Konrad and Bjorn is already there on the thread. Our 
> understanding is that CCing maintainers comment is for next patch 
> series after this one.

BTW: you can feed git send-email with 
--cc-cmd='./scripts/get_maintainer.pl --norolestats' and

it'll pick the right people for you (most of the time, anyway).


>
> Bjorn, please check and comment on above? If requires we should start 
> writing the guidelines for MSM boards since lot of comments are based 
> on the experience or knowledge in the community Vs caught by tools - 
> so it is easy to be missed by developers submitting new boards. Thoughts?

Big yes! Some of the points should probably even be raised wrt the DT 
spec itself, such as property order.


Konrad

>
> ---Trilok Soni
>
>
