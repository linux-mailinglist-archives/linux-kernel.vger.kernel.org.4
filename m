Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97D7241E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbjFFMS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjFFMS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:18:27 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6364910CA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:18:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1a7e31dcaso64662741fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686053901; x=1688645901;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCGW5eVCHi2CHSD/setg/Kq6KUmLCOtYkxVRQlbxevU=;
        b=cwZRfsr8b+Y1r3wfwlfQ3EhRIoZE2T8lEowzTkGWzeHQNPGCmqdGm1M5sAmkEjP0VV
         8OPejkTHFMTkpGuIf6m/bD36ijTdMu4jgg6o2kojKnbKhZgeJ2MXWbJJTf9sMr2bXp4l
         UjmcFIvXbcevlKjCMTQhGaIhjQAuDAwwzDUcBJjf0EsuUhhpBx1rql+h+Rh57aPmXulH
         gxC0LFo0LMJZgkQINzQR1a6T6NwJz5iN9MaypEasTZaJk8D44BukIasGlfWfoNIFbCDA
         /R/p9isZJMudFlGYxFH2TZjk27H3a5MeownhRpItw3/locmCfgXHVO7sih4etvqM+9ET
         n1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053901; x=1688645901;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCGW5eVCHi2CHSD/setg/Kq6KUmLCOtYkxVRQlbxevU=;
        b=f0p8ouOJWyfOH0tm6RvRXAfEdD7+V5IQlE/3a++Yv320WhWLAnATAuPZXfL24B6ijz
         UnlOqgV2sk24XSHj5ug3/Dv3FK35kc8LR0bOqTWG2APyQWCfRuMAoAXIpUjrcTfTbXLO
         eaKzffUZOBAwg0YGwxyGKEirN1rmraK9VZQxhvSLOfA8Dw5+7HmO50RH91KStSq8BIp6
         5qSY7xeHTa/Mshn/sm4g20e10bHJC337JiltyKqbypWwMOIVp5FNxSSaSxUvREDuEm3I
         IKc3dfnmse4RotqYDTchUAwR1Uc7L4Ok6tFEfNwBx0ix5U/5hBZhK1QMmNJ6f1XmvLvx
         jRXg==
X-Gm-Message-State: AC+VfDxTEZMa9EvxskhP74gjnmJeSrbkF/URgADIw5PZsLSUwP6D67xt
        hJNggUwJUeacXnOyCkteSTQ3pA==
X-Google-Smtp-Source: ACHHUZ6C/uWLrE7sXUmPyCm4O+EcbIdisS2AdBHySFZDzsL9vZQ+o23bZQh+nRzIuLCY1ulwQHUUSw==
X-Received: by 2002:a2e:8613:0:b0:2b1:ec1a:88bc with SMTP id a19-20020a2e8613000000b002b1ec1a88bcmr1293030lji.43.1686053901581;
        Tue, 06 Jun 2023 05:18:21 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id j4-20020ac25504000000b004dc4becfcd6sm1450491lfk.54.2023.06.06.05.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:18:21 -0700 (PDT)
Message-ID: <3a9c1b7e-c1ac-61a1-0a67-8653f1027b35@linaro.org>
Date:   Tue, 6 Jun 2023 14:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de,
        maz@kernel.org, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, mani@kernel.org, robimarko@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
 <1685982557-28326-7-git-send-email-quic_rohiagar@quicinc.com>
 <fc579cdb-4594-bdc9-18f0-e16ab89e8eaf@linaro.org>
 <f2885b05-e6e7-6576-a0de-6f930cfd539f@quicinc.com>
 <1a74a7e5-f20d-39de-bb8f-4371f10a612c@linaro.org>
 <cebcdf94-f83d-7348-df69-b7f782c411ce@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2 06/10] arm64: dts: qcom: Add SDX75 platform and IDP
 board support
In-Reply-To: <cebcdf94-f83d-7348-df69-b7f782c411ce@quicinc.com>
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



On 6.06.2023 13:42, Rohit Agarwal wrote:
> 
> On 6/6/2023 3:06 PM, Konrad Dybcio wrote:
>>
>> On 6.06.2023 10:04, Rohit Agarwal wrote:
>>> On 6/5/2023 11:45 PM, Konrad Dybcio wrote:
>>>> On 5.06.2023 18:29, Rohit Agarwal wrote:
>>>>> Add basic devicetree support for SDX75 platform and IDP board from
>>>>> Qualcomm. The SDX75 platform features an ARM Cortex A55 CPU which forms
>>>>> the Application Processor Sub System (APSS) along with standard Qualcomm
>>>>> peripherals like GCC, TLMM, UART, QPIC, and BAM etc... Also, there
>>>>> exists the networking parts such as IPA, MHI, PCIE-EP, EMAC, and Modem
>>>>> etc..
>>>>>
>>>>> This commit adds basic devicetree support.
>>>> You just said that in the first sentence! :P
>>> Sorry :')
>>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/qcom/Makefile      |   1 +
>>>>>    arch/arm64/boot/dts/qcom/sdx75-idp.dts |  18 ++
>>>>>    arch/arm64/boot/dts/qcom/sdx75.dtsi    | 533 +++++++++++++++++++++++++++++++++
>>>>>    3 files changed, 552 insertions(+)
>>>>>    create mode 100644 arch/arm64/boot/dts/qcom/sdx75-idp.dts
>>>>>    create mode 100644 arch/arm64/boot/dts/qcom/sdx75.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>>>> index d42c595..4fd5a18 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>>>> @@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += sdm845-xiaomi-polaris.dtb
>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sdm845-shift-axolotl.dtb
>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sdm850-lenovo-yoga-c630.dtb
>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sdm850-samsung-w737.dtb
>>>>> +dtb-$(CONFIG_ARCH_QCOM)    += sdx75-idp.dtb
>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sm4250-oneplus-billie2.dtb
>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sm6115p-lenovo-j606f.dtb
>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sm6125-sony-xperia-seine-pdx201.dtb
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
>>>>> new file mode 100644
>>>>> index 0000000..1e08f25
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
>>>>> @@ -0,0 +1,18 @@
>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>> +/*
>>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>>>> + */
>>>>> +
>>>>> +/dts-v1/;
>>>>> +
>>>>> +#include "sdx75.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +    model = "Qualcomm Technologies, Inc. SDX75 IDP";
>>>>> +    compatible = "qcom,sdx75-idp", "qcom,sdx75";
>>>>> +
>>>> Stray newline
>>>>
>>>>> +};
>>>>> +
>>>>> +&tlmm {
>>>>> +    gpio-reserved-ranges = <110 6>;
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>>>> new file mode 100644
>>>>> index 0000000..3d1646b
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>>>>> @@ -0,0 +1,533 @@
>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>> +/*
>>>>> + * SDX75 SoC device tree source
>>>>> + *
>>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +#include <dt-bindings/clock/qcom,rpmh.h>
>>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>>>> +
>>>>> +/ {
>>>>> +    #address-cells = <2>;
>>>>> +    #size-cells = <2>;
>>>>> +    interrupt-parent = <&intc>;
>>>>> +
>>>>> +    chosen: chosen { };
>>>>> +
>>>>> +    memory@80000000 {
>>>> Please sort the top-level nodes alphabetically
>>>>
>>>>> +        device_type = "memory";
>>>>> +        reg = <0 0x80000000 0 0>;
>>>> Please use 0x0 for consistency
>>> Sure, Will make everywhere this as 0x0
>>>>> +    };
>>>>> +
>>>>> +    clocks { };
>>>>> +
>>>>> +    cpus {
>>>>> +        #address-cells = <2>;
>>>>> +        #size-cells = <0>;
>>>>> +
>>>>> +        CPU0: cpu@0 {
>>>>> +            device_type = "cpu";
>>>>> +            compatible = "arm,cortex-a55";
>>>>> +            reg = <0x0 0x0>;
>>>>> +            enable-method = "psci";
>>>>> +            power-domains = <&CPU_PD0>;
>>>>> +            power-domain-names = "psci";
>>>>> +            next-level-cache = <&L2_0>;
>>>> Missing newline before subnode
>>>>
>>>>> +            L2_0: l2-cache {
>>>>> +                compatible = "cache";
>>>>> +                next-level-cache = <&L3_0>;
>>>>> +                L3_0: l3-cache {
>>>>> +                    compatible = "cache";
>>>>> +                };
>>>>> +            };
>>>>> +        };
>>>> [...]
>>>>
>>>>> +        CLUSTER_PD: power-domain-cpu-cluster0 {
>>>>> +            #power-domain-cells = <0>;
>>>>> +            domain-idle-states = <&CLUSTER_SLEEP_0 &CX_RET &CLUSTER_SLEEP_1>;
>>>> Shouldn't CX_RET be the last one?
>>> Here seems to an issue with the naming that I added. CLUSTER_SLEEP_1 should actually be APPS_SLEEP
>>> which is deeper than CX_RET.
>>> So will update the names in the next.
>> Are you sure?
>>
>> Both the PSCI params and longer latency/residency times suggest
>> the reverse!
> The larger values of CLUSTER_SLEEP_1 of entry, exit and min suggests that it is deeper, right?
> When compared to other SoCs, I see the larger values signify that it is deeper.
> Please correct my understanding if I am wrong. Happy to learn !!!
Technically speaking Arm lets silicon vendors implement all this as they
wish, but the general idea is that lower power states correspond to higher
values in each bitfield (which is usually 4-bit- / 1-hex-digit-wide).

You can see the table 16 in [1] for what Arm recommends. Qualcomm doesn't
follow it though.

Lower power states usually require more things to go back to life and
hence the delays are higher as the HW needs to be physically switched on.

Konrad

[1] https://documentation-service.arm.com/static/5f905b78f86e16515cdc1fca

> 
> Thanks,
> Rohit.
>>
>> Konrad
>>> Thanks for pointing out.
>>> Rohit.
>>>> Konrad
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    firmware {
>>>>> +        scm: scm {
>>>>> +            compatible = "qcom,scm-sdx75", "qcom,scm";
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    pmu {
>>>>> +        compatible = "arm,armv8-pmuv3";
>>>>> +        interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +    };
>>>>> +
>>>>> +    reserved-memory {
>>>>> +        #address-cells = <2>;
>>>>> +        #size-cells = <2>;
>>>>> +        ranges;
>>>>> +
>>>>> +        gunyah_hyp_mem: gunyah-hyp@80000000 {
>>>>> +            reg = <0x0 0x80000000 0x0 0x800000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        hyp_elf_package_mem: hyp-elf-package@80800000 {
>>>>> +            reg = <0x0 0x80800000 0x0 0x200000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        access_control_db_mem: access-control-db@81380000 {
>>>>> +            reg = <0x0 0x81380000 0x0 0x80000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        qteetz_mem: qteetz@814e0000 {
>>>>> +            reg = <0x0 0x814e0000 0x0 0x2a0000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        trusted_apps_mem: trusted-apps@81780000 {
>>>>> +            reg = <0x0 0x81780000 0x0 0xa00000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        xbl_ramdump_mem: xbl-ramdump@87a00000 {
>>>>> +            reg = <0x0 0x87a00000 0x0 0x1c0000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        cpucp_fw_mem: cpucp-fw@87c00000 {
>>>>> +            reg = <0x0 0x87c00000 0x0 0x100000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        xbl_dtlog_mem: xbl-dtlog@87d00000 {
>>>>> +            reg = <0x0 0x87d00000 0x0 0x40000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        xbl_sc_mem: xbl-sc@87d40000 {
>>>>> +            reg = <0x0 0x87d40000 0x0 0x40000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        modem_efs_shared_mem: modem-efs-shared@87d80000 {
>>>>> +            reg = <0x0 0x87d80000 0x0 0x10000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        aop_image_mem: aop-image@87e00000 {
>>>>> +            reg = <0x0 0x87e00000 0x0 0x20000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        smem_mem: smem@87e20000 {
>>>>> +            reg = <0x0 0x87e20000 0x0 0xc0000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        aop_cmd_db_mem: aop-cmd-db@87ee0000 {
>>>>> +            compatible = "qcom,cmd-db";
>>>>> +            reg = <0x0 0x87ee0000 0x0 0x20000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        aop_config_mem: aop-config@87f00000 {
>>>>> +            reg = <0x0 0x87f00000 0x0 0x20000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        ipa_fw_mem: ipa-fw@87f20000 {
>>>>> +            reg = <0x0 0x87f20000 0x0 0x10000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        secdata_mem: secdata@87f30000 {
>>>>> +            reg = <0x0 0x87f30000 0x0 0x1000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        tme_crashdump_mem: tme-crashdump@87f31000 {
>>>>> +            reg = <0x0 0x87f31000 0x0 0x40000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        tme_log_mem: tme-log@87f71000 {
>>>>> +            reg = <0x0 0x87f71000 0x0 0x4000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        uefi_log_mem: uefi-log@87f75000 {
>>>>> +            reg = <0x0 0x87f75000 0x0 0x10000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        qdss_mem: qdss@88800000 {
>>>>> +            reg = <0x0 0x88800000 0x0 0x300000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        audio_heap_mem: audio-heap@88b00000 {
>>>>> +            compatible = "shared-dma-pool";
>>>>> +            reg = <0x0 0x88b00000 0x0 0x400000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        mpss_dsmharq_mem: mpss-dsmharq@88f00000 {
>>>>> +            reg = <0x0 0x88f00000 0x0 0x5080000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        q6_mpss_dtb_mem: q6-mpss-dtb@8df80000 {
>>>>> +            reg = <0x0 0x8df80000 0x0 0x80000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        mpssadsp_mem: mpssadsp@8e000000 {
>>>>> +            reg = <0x0 0x8e000000 0x0 0xf400000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        gunyah_trace_buffer_mem: gunyah-trace-buffer@bdb00000 {
>>>>> +            reg = <0x0 0xbdb00000 0x0 0x2000000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        smmu_debug_buf_mem: smmu-debug-buf@bfb00000 {
>>>>> +            reg = <0x0 0xbfb00000 0x0 0x100000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +
>>>>> +        hyp_smmu_s2_pt_mem: hyp-smmu-s2-pt@bfc00000 {
>>>>> +            reg = <0x0 0xbfc00000 0x0 0x400000>;
>>>>> +            no-map;
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    smem: qcom,smem {
>>>>> +        compatible = "qcom,smem";
>>>>> +        memory-region = <&smem_mem>;
>>>>> +        hwlocks = <&tcsr_mutex 3>;
>>>>> +    };
>>>>> +
>>>>> +    soc: soc {
>>>>> +        compatible = "simple-bus";
>>>>> +        #address-cells = <2>;
>>>>> +        #size-cells = <2>;
>>>>> +        ranges = <0 0 0 0 0x10 0>;
>>>>> +        dma-ranges = <0 0 0 0 0x10 0>;
>>>>> +
>>>>> +        tcsr_mutex: hwlock@1f40000 {
>>>>> +            compatible = "qcom,tcsr-mutex";
>>>>> +            reg = <0x0 0x01f40000 0x0 0x40000>;
>>>>> +            #hwlock-cells = <1>;
>>>>> +        };
>>>>> +
>>>>> +        pdc: interrupt-controller@b220000 {
>>>>> +            compatible = "qcom,sdx75-pdc", "qcom,pdc";
>>>>> +            reg = <0x0 0xb220000 0x0 0x30000>,
>>>>> +                  <0x0 0x174000f0 0x0 0x64>;
>>>>> +            qcom,pdc-ranges = <0 147 52>,
>>>>> +                      <52 266 32>,
>>>>> +                      <84 500 59>;
>>>>> +            #interrupt-cells = <2>;
>>>>> +            interrupt-parent = <&intc>;
>>>>> +            interrupt-controller;
>>>>> +        };
>>>>> +
>>>>> +        tlmm: pinctrl@f000000 {
>>>>> +            compatible = "qcom,sdx75-tlmm";
>>>>> +            reg = <0x0 0x0f000000 0x0 0x400000>;
>>>>> +            interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +            gpio-controller;
>>>>> +            #gpio-cells = <2>;
>>>>> +            gpio-ranges = <&tlmm 0 0 133>;
>>>>> +            interrupt-controller;
>>>>> +            #interrupt-cells = <2>;
>>>>> +            wakeup-parent = <&pdc>;
>>>>> +        };
>>>>> +
>>>>> +        apps_smmu: iommu@15000000 {
>>>>> +            compatible = "qcom,sdx75-smmu-500", "arm,mmu-500";
>>>>> +            reg = <0x0 0x15000000 0x0 0x40000>;
>>>>> +            #iommu-cells = <2>;
>>>>> +            #global-interrupts = <2>;
>>>>> +            dma-coherent;
>>>>> +            interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +        };
>>>>> +
>>>>> +        intc: interrupt-controller@17200000 {
>>>>> +            compatible = "arm,gic-v3";
>>>>> +            #interrupt-cells = <3>;
>>>>> +            interrupt-controller;
>>>>> +            #redistributor-regions = <1>;
>>>>> +            redistributor-stride = <0x0 0x20000>;
>>>>> +            reg = <0x0 0x17200000 0x0 0x10000>,
>>>>> +                  <0x0 0x17260000 0x0 0x80000>;
>>>>> +            interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +        };
>>>>> +
>>>>> +        timer@17420000 {
>>>>> +            compatible = "arm,armv7-timer-mem";
>>>>> +            reg = <0x0 0x17420000 0x0 0x1000>;
>>>>> +            #address-cells = <1>;
>>>>> +            #size-cells = <1>;
>>>>> +            ranges = <0 0 0 0x20000000>;
>>>>> +
>>>>> +            frame@17421000 {
>>>>> +                reg = <0x17421000 0x1000>,
>>>>> +                      <0x17422000 0x1000>;
>>>>> +                frame-number = <0>;
>>>>> +                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +            };
>>>>> +
>>>>> +            frame@17423000 {
>>>>> +                reg = <0x17423000 0x1000>;
>>>>> +                frame-number = <1>;
>>>>> +                interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +                status = "disabled";
>>>>> +            };
>>>>> +
>>>>> +            frame@17425000 {
>>>>> +                reg = <0x17425000 0x1000>;
>>>>> +                frame-number = <2>;
>>>>> +                interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +                status = "disabled";
>>>>> +            };
>>>>> +
>>>>> +            frame@17427000 {
>>>>> +                reg = <0x17427000 0x1000>;
>>>>> +                frame-number = <3>;
>>>>> +                interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +                status = "disabled";
>>>>> +            };
>>>>> +
>>>>> +            frame@17429000 {
>>>>> +                reg = <0x17429000 0x1000>;
>>>>> +                frame-number = <4>;
>>>>> +                interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +                status = "disabled";
>>>>> +            };
>>>>> +
>>>>> +            frame@1742b000 {
>>>>> +                reg = <0x1742b000 0x1000>;
>>>>> +                frame-number = <5>;
>>>>> +                interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +                status = "disabled";
>>>>> +            };
>>>>> +
>>>>> +            frame@1742d000 {
>>>>> +                reg = <0x1742d000 0x1000>;
>>>>> +                frame-number = <6>;
>>>>> +                interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +                status = "disabled";
>>>>> +            };
>>>>> +        };
>>>>> +
>>>>> +        apps_rsc: rsc@17a00000 {
>>>>> +            label = "apps_rsc";
>>>>> +            compatible = "qcom,rpmh-rsc";
>>>>> +            reg = <0x0 0x17a00000 0x0 0x10000>,
>>>>> +                  <0x0 0x17a10000 0x0 0x10000>,
>>>>> +                  <0x0 0x17a20000 0x0 0x10000>;
>>>>> +            reg-names = "drv-0", "drv-1", "drv-2";
>>>>> +            interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +
>>>>> +            power-domains = <&CLUSTER_PD>;
>>>>> +            qcom,tcs-offset = <0xd00>;
>>>>> +            qcom,drv-id = <2>;
>>>>> +            qcom,tcs-config = <ACTIVE_TCS    3>,
>>>>> +                      <SLEEP_TCS     2>,
>>>>> +                      <WAKE_TCS      2>,
>>>>> +                      <CONTROL_TCS   0>;
>>>>> +
>>>>> +            apps_bcm_voter: bcm_voter {
>>>>> +                compatible = "qcom,bcm-voter";
>>>>> +            };
>>>>> +        };
>>>>> +    };
>>>>> +
>>>>> +    timer {
>>>>> +        compatible = "arm,armv8-timer";
>>>>> +        interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>>>> +                 <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>>>> +                 <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>>>> +                 <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>>>>> +    };
>>>>> +};
