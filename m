Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D0C716B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjE3RtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjE3RtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:49:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8122AE8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:49:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so5606806e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685468951; x=1688060951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C14w8ZbZwqbSJ78rPIZ4/ajQpCacHTn447tX8ErKnNs=;
        b=bWndEjOxx0vbpmAE07rfp0QXX9tGilmB5KrvT/ZSLRHVX3NK+QcHHyyOpt5SUoSPfd
         ezLOKINnQWNdc0GnOwlPcUL7fjqoV51286P45dPP4VRmHmkBhkniuhO0sQXoAuCzG+LX
         WuuJs9lJlRsN0DnLY1SQMTgUTQ26uVb0hQ+fw4FXGhvrCPxrUgPW/YpiDsJw1XinpVXg
         h9DgQDNF/GjARb64qksFtqVNFLpWflZOIvEfC1Uxdd0YeX8X8jt5yFXk09VZrnQIhfv4
         h+Zkakgz1sMiFedqXooxnzZnWdIP7nZwyyLaZw/foBeerR8wyKEV5N6fmSnwV8XNGlIS
         ZiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685468951; x=1688060951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C14w8ZbZwqbSJ78rPIZ4/ajQpCacHTn447tX8ErKnNs=;
        b=BbJMXxSSTDevCZLdCVRxlZdGjyixoWJL1sQfExFjMZOafmgOSb4NSPq4JFCaan4uwK
         83VQvJ74yFICBhz5CSpZHooEkPpRbek69kwDv8gfaX+JmJm8gMp2HeIvReCat0q6vhGH
         uDKMg2X6Fh7w8U8PYjBgQQW7uhe86+RiUpTWRgSemTzSEv4AFhKHFjhatHJvDXgrYnDk
         cqzWXwhSrQFAGOicl/R2R34OH83FXwROvVm7Y1ramo3P5grtl08b+VqCcKFDLHpRZpl6
         laJOAbGu+eMOBFDRWef0dW+LwgNi/kV4fHMAXK8GzHfmUzH7uPHExaaBhPLWubLTEeHO
         BqOw==
X-Gm-Message-State: AC+VfDwTAqqy8KBIC0GmT3dJdTwxQg14dZgY1QmaYUqZZKZHcrP8GsNo
        xTpX7aB3svRPEDyhHlpFMPaMNQ==
X-Google-Smtp-Source: ACHHUZ5IwzRp5EmDWCfGdlnufmxVG7i5tfibYTWRZ+eo4yR8af1IaKPboweBWlV4dO4e+BGS1z/xZQ==
X-Received: by 2002:ac2:5a1d:0:b0:4f3:a55a:bace with SMTP id q29-20020ac25a1d000000b004f3a55abacemr1271313lfn.7.1685468951005;
        Tue, 30 May 2023 10:49:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id q7-20020ac25107000000b004f3b4a9a60esm410025lfb.106.2023.05.30.10.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 10:49:07 -0700 (PDT)
Message-ID: <f839fd42-2d04-30b2-65b4-23df37a52f81@linaro.org>
Date:   Tue, 30 May 2023 19:49:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 5/8] arm64: dts: qcom: Add SDX75 platform and IDP board
 support
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robimarko@gmail.com,
        quic_gurus@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
 <1684487350-30476-6-git-send-email-quic_rohiagar@quicinc.com>
 <405186ab-46df-fcf1-2894-a08c4b42c069@linaro.org>
 <ec664db0-ae0f-5046-25c4-315d0a2c8a3f@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ec664db0-ae0f-5046-25c4-315d0a2c8a3f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.05.2023 13:40, Rohit Agarwal wrote:
> Thanks for reviewing. Sorry for the late reply was on leave.
> 
> On 5/19/2023 10:58 PM, Konrad Dybcio wrote:
>>
>> On 19.05.2023 11:09, Rohit Agarwal wrote:
>>> Add basic devicetree support for SDX75 platform and IDP board from
>>> Qualcomm. The SDX75 platform features an ARM Cortex A55 CPU which forms
>>> the Application Processor Sub System (APSS) along with standard Qualcomm
>>> peripherals like GCC, TLMM, UART, QPIC, and BAM etc... Also, there
>>> exists the networking parts such as IPA, MHI, PCIE-EP, EMAC, and Modem
>>> etc..
>>>
>>> This commit adds basic devicetree support.
>>>
>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/Makefile      |   1 +
>>>   arch/arm64/boot/dts/qcom/sdx75-idp.dts |  19 ++
>>>   arch/arm64/boot/dts/qcom/sdx75.dtsi    | 534 +++++++++++++++++++++++++++++++++
>>>   3 files changed, 554 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/sdx75-idp.dts
>>>   create mode 100644 arch/arm64/boot/dts/qcom/sdx75.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index d42c595..4fd5a18 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += sdm845-xiaomi-polaris.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sdm845-shift-axolotl.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sdm850-lenovo-yoga-c630.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sdm850-samsung-w737.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)    += sdx75-idp.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm4250-oneplus-billie2.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm6115p-lenovo-j606f.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm6125-sony-xperia-seine-pdx201.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
>>> new file mode 100644
>>> index 0000000..e2e803b
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
>>> @@ -0,0 +1,19 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sdx75.dtsi"
>>> +
>>> +/ {
>>> +    model = "Qualcomm Technologies, Inc. SDX75 IDP";
>>> +    compatible = "qcom,sdx75-idp", "qcom,sdx75";
>>> +    qcom,board-id = <0x2010022 0x302>;
>> You should be able to get by without qcom,{msm,board}-id.
> Actually the bootloader requires the msm and board id. Shouldn't this become a necessary field then?
We generally discourage that, especially since at least on the LA front
it became unnecessary (no msm-id and appended dtb -> abl picks the only
one present).. I'm not sure at what point in product dev the SDX75 is,
but if we could get rid of that requirement, it'd be very nice..

OTOH getting rid of it just on one device and keeping it necessary with
fw builds that have been distributed to vendors sounds wouldn't be
very beneficial either :/ 


Konrad
>>
>>> +
>>> +};
>>> +
>>> +&tlmm {
>>> +    gpio-reserved-ranges = <110 6>;
>>> +};
>>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>> new file mode 100644
>>> index 0000000..c2b8810
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>> @@ -0,0 +1,534 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * SDX75 SoC device tree source
>>> + *
>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + *
>>> + */
>>> +
>>> +#include <dt-bindings/clock/qcom,rpmh.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> +
>>> +/ {
>>> +    #address-cells = <2>;
>>> +    #size-cells = <2>;
>>> +    qcom,msm-id = <556 0x10000>;
>>> +    interrupt-parent = <&intc>;
>>> +
>>> +    chosen: chosen { };
>>> +
>>> +    memory {
>> The memory node should have a unit address.
> Sure will update this.
>>
>>> +        device_type = "memory";
>>> +        reg = <0 0 0 0>;
>>> +    };
>>> +
>>> +    clocks { };
>>> +
>>> +    cpus {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <0>;
>>> +
>> [...]
>>
>>> +
>>> +        CLUSTER_PD: power-domain-cpu-cluster0 {
>>> +            #power-domain-cells = <0>;
>>> +            domain-idle-states = <&CLUSTER_SLEEP_0 &CX_RET &CLUSTER_SLEEP_1>;
>> Is CLUSTER_SLEEP_1 deeper than CX retention?
> Yes
>>
>>> +        };
>>> +    };
>>> +
>>> +    firmware {
>>> +        scm: scm {
>>> +            compatible = "qcom,scm-sdx75", "qcom,scm";
>>> +        };
>>> +    };
>>> +
>>> +    pmu {
>>> +        compatible = "arm,armv8-pmuv3";
>>> +        interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>>> +    };
>>> +
>>> +    reserved-memory {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +        ranges;
>>> +
>>> +        gunyah_hyp_mem: memory@80000000 {
>> reserved memory subnodes should have meaningful node names, e.g.
>>
>> hypervisor@800...
> Will update this.
>>
>>> +            reg = <0x0 0x80000000 0x0 0x800000>;
>>> +            no-map;
>>> +        };
>>> +
>> [...]
>>
>>> +
>>> +    smem: qcom,smem {
>>> +        compatible = "qcom,smem";
>>> +        memory-region = <&smem_mem>;
>>> +        hwlocks = <&tcsr_mutex 3>;
>>> +    };
>>> +
>>> +    soc: soc {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +        ranges;
>> Are the SoC buses limited to 32b addresses?
> No, Will fix this in the next.
>>
>>> +        compatible = "simple-bus";
>> Compatible should go first.
> Yes, Ok.
>>> +
>>> +        tcsr_mutex: hwlock@1f40000 {
>>> +            compatible = "qcom,tcsr-mutex";
>>> +            reg = <0x0 0x01f40000 0x0 0x40000>;
>>> +            #hwlock-cells = <1>;
>>> +        };
>>> +
>>> +        pdc: interrupt-controller@b220000 {
>>> +            compatible = "qcom,sdx75-pdc", "qcom,pdc";
>>> +            reg = <0x0 0xb220000 0x0 0x30000>,
>>> +                  <0x0 0x174000f0 0x0 0x64>;
>>> +            qcom,pdc-ranges = <0 147 52>,
>>> +                      <52 266 32>,
>>> +                      <84 500 59>;
>>> +            #interrupt-cells = <2>;
>>> +            interrupt-parent = <&intc>;
>>> +            interrupt-controller;
>>> +        };
>>> +
>>> +        tlmm: pinctrl@f000000 {
>>> +            compatible = "qcom,sdx75-tlmm";
>>> +            reg = <0x0 0x0f000000 0x0 0x400000>;
>>> +            interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
>>> +            gpio-controller;
>>> +            #gpio-cells = <2>;
>>> +            gpio-ranges = <&tlmm 0 0 133>;
>>> +            interrupt-controller;
>>> +            #interrupt-cells = <2>;
>>> +            wakeup-parent = <&pdc>;
>>> +        };
>>> +
>>> +        apps_smmu: iommu@15000000 {
>>> +            compatible = "qcom,sdx75-smmu-500", "arm,mmu-500";
>>> +            reg = <0x0 0x15000000 0x0 0x40000>;
>>> +            #iommu-cells = <2>;
>>> +            #global-interrupts = <2>;
>>> +            interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
>> Many newer SoCs have dma-coherent SMMUs. Is this the case here?
> Yes, Will add the dma-coherent property here.
>>
>>> +        };
>>> +
>>> +        intc: interrupt-controller@17200000 {
>>> +            compatible = "arm,gic-v3";
>>> +            #interrupt-cells = <3>;
>>> +            interrupt-controller;
>>> +            #redistributor-regions = <1>;
>>> +            redistributor-stride = <0x0 0x20000>;
>>> +            reg = <0x0 0x17200000 0x0 0x10000>,
>>> +                  <0x0 0x17260000 0x0 0x80000>;
>>> +            interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>>> +        };
>>> +
>>> +        timer@17420000 {
>>> +            compatible = "arm,armv7-timer-mem";
>>> +            #address-cells = <2>;
>>> +            #size-cells = <2>;
>>> +            ranges;
>>> +            reg = <0x0 0x17420000 0x0 0x1000>;
>>> +            clock-frequency = <19200000>;
>> clock-frequency is discouraged, unless strictly necessary.
>>
>> Since gh is running, the timer is already programmed so it should be
>> fine to drop this.
>>
>> [...]
>>
>>> +    timer {
>>> +        compatible = "arm,armv8-timer";
>>> +        interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                 <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                 <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                 <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>>> +        clock-frequency = <19200000>;
>> Ditto
> Ok Thanks for the info. Dropping the clock frequency property in the next version.
> 
> Thanks,
> Rohit.
>>
>> Konrad
>>> +    };
>>> +};
