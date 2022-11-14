Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09215627D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiKNMWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbiKNMWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:22:04 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4526823E83
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:22:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d6so18940241lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1JbND9I/oGAoZ5QeK97YX04HZ+u3HHk671wXIKC2eU=;
        b=t5C9BlX6SP88q5LXx0DSyZ4cvskyBX6EUtU+l/hbDmW5g/rvr6DnVRjp/1QE5Grdyj
         fqeeGXv/yBpymGx9L40jWKCDPt+LVAYJIccJOgo0WtWUlX+lICcit3UsG+nQDS7Q97SA
         fDQ8GxRRNLMSa7uVq65CPVio7Qg3iN870ssh4gJ7T2/vBG77rdWVLQO1YVNqPplJmp4S
         fHRrhbuWv5VjynzTA8slDGgSIUpfMbmNw54zeAlwzHx7MXrVsI+LF7arL3QA7rn6d2m9
         t/NYbun1f658EIoutLjuZbvfOcyeypBslMhb5EGXDOTlJ5o8AiS5wDYAasbUpRZGJXxo
         luOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1JbND9I/oGAoZ5QeK97YX04HZ+u3HHk671wXIKC2eU=;
        b=e+pTQpA5a5taRhYwplq2mHqqJRrKu8m1wWl5wRHpuBnJx7tTUXaFMSByrnCBPzbmc+
         3YgixchJZVcZJbDz2gwrAiiGlk+p4EB/EzeTHtR26Sd23zLahaaZHrD/N6ftOuRZmIn5
         pzxOUrDpO20h1ope3j/T7eysF7+tB6/xpiiACJJPzSy/sUc4kZfY1kbgusqP0uKwIjyn
         Wr0szYeiFByNWYSpI+22IFQ4INlOAPcYJPKV5wYdkwFb0y7OCbMyCV8s5lJneyhxi1pt
         ANXe/SDEzuDyWeMQ6V6q/j/JAJZvf45sbp0H+DTlnbZglKoIXgi8I1V+TtMb7oFM/pfF
         MoFw==
X-Gm-Message-State: ANoB5pkOG5obohUbXfrR3TnF3JHVWF9zywzQSKmQBJOMaAfpMZ4B4vQG
        ivY6Sfx8qIUq1wj41qEyXkDZbg==
X-Google-Smtp-Source: AA0mqf5RSiYx3DBBvWio+i5yS7x/0wF3WApBlwadRV4R1syUBktYZ9VocAF/bwY2Ll6Xb1CUfSO7Eg==
X-Received: by 2002:ac2:4bd5:0:b0:4a2:3b95:d889 with SMTP id o21-20020ac24bd5000000b004a23b95d889mr4240788lfq.676.1668428520536;
        Mon, 14 Nov 2022 04:22:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k10-20020a2ea26a000000b0027712379ec8sm1999245ljm.28.2022.11.14.04.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 04:21:59 -0800 (PST)
Message-ID: <3f469c79-fc4e-9c29-9c47-6dd8e28484a5@linaro.org>
Date:   Mon, 14 Nov 2022 13:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller
 bindings
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-5-apatel@ventanamicro.com>
 <9be58cb4-4ee8-a6e0-7a0a-f2f581e394d3@linaro.org>
 <CAK9=C2X55CG6tjjiTPrecnnZZiwTOS1BSH3UTPa-fLBm38WdLA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAK9=C2X55CG6tjjiTPrecnnZZiwTOS1BSH3UTPa-fLBm38WdLA@mail.gmail.com>
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

On 14/11/2022 13:06, Anup Patel wrote:
> On Mon, Nov 14, 2022 at 3:19 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 11/11/2022 05:42, Anup Patel wrote:
>>> We add DT bindings document for RISC-V incoming MSI controller (IMSIC)
>>> defined by the RISC-V advanced interrupt architecture (AIA) specification.
>>>
>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>> ---
>>>  .../interrupt-controller/riscv,imsic.yaml     | 174 ++++++++++++++++++
>>>  1 file changed, 174 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
>>> new file mode 100644
>>> index 000000000000..05106eb1955e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
>>> @@ -0,0 +1,174 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/interrupt-controller/riscv,imsic.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: RISC-V Incoming MSI Controller (IMSIC)
>>> +
>>> +maintainers:
>>> +  - Anup Patel <anup@brainfault.org>
>>> +
>>> +description:
>>> +  The RISC-V advanced interrupt architecture (AIA) defines a per-CPU incoming
>>> +  MSI controller (IMSIC) for handling MSIs in a RISC-V platform. The RISC-V
>>> +  AIA specification can be found at https://github.com/riscv/riscv-aia.
>>> +
>>> +  The IMSIC is a per-CPU (or per-HART) device with separate interrupt file
>>> +  for each privilege level (machine or supervisor). The configuration of
>>> +  a IMSIC interrupt file is done using AIA CSRs and it also has a 4KB MMIO
>>> +  space to receive MSIs from devices. Each IMSIC interrupt file supports a
>>> +  fixed number of interrupt identities (to distinguish MSIs from devices)
>>> +  which is same for given privilege level across CPUs (or HARTs).
>>> +
>>> +  The arrangement of IMSIC interrupt files in MMIO space of a RISC-V platform
>>> +  follows a particular scheme defined by the RISC-V AIA specification. A IMSIC
>>> +  group is a set of IMSIC interrupt files co-located in MMIO space and we can
>>> +  have multiple IMSIC groups (i.e. clusters, sockets, chiplets, etc) in a
>>> +  RISC-V platform. The MSI target address of a IMSIC interrupt file at given
>>> +  privilege level (machine or supervisor) encodes group index, HART index,
>>> +  and guest index (shown below).
>>> +
>>> +  XLEN-1           >=24                                 12    0
>>> +  |                  |                                  |     |
>>> +  -------------------------------------------------------------
>>> +  |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
>>> +  -------------------------------------------------------------
>>> +
>>> +  The device tree of a RISC-V platform will have one IMSIC device tree node
>>> +  for each privilege level (machine or supervisor) which collectively describe
>>> +  IMSIC interrupt files at that privilege level across CPUs (or HARTs).
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/interrupt-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - vendor,chip-imsics
>>
>> There is no such vendor... As Conor pointed out, this does not look
>> correct. Compatibles must be real and specific.
> 
> Previously, Rob had suggest to:
> 1) Mandate two compatible strings: one for implementation and
>     and second for specification
> 2) Since this is new specification with QEMU being the only
>     implementation, we add "vendor,chip-imsics" as dummy
>     implementation specific string for DT schema checkers
>     to pass the examples. Once we have an actual implementation,
>    we will replace this dummy string.
> 
> Refer, https://www.spinics.net/lists/devicetree/msg442720.html

And Rob did not propose vendor as vendor and chip-imsics as device. Read
his message again.

> 
>>
>>> +      - const: riscv,imsics
>>> +
>>> +  reg:
>>> +    minItems: 1
>>> +    maxItems: 128
>>
>> Is there a DTS with 128 reg items?
> 
> Not at the moment since this is a new specification.
> 
> The value "128" is because maximum number of
> IMSIC groups on an system with both IMSIC and
> APLIC is 128 where each IMSIC group has a
> separate base address. This is not a hard limit so
> I am willing to drop it as well.

Is "separate base address" really a separate different range or just
spaced by few registers?

> 
>>
>>> +    description:
>>> +      Base address of each IMSIC group.
>>> +
>>> +  interrupt-controller: true
>>> +
>>> +  "#interrupt-cells":
>>> +    const: 0
>>> +
>>> +  msi-controller: true
>>
>> You want then msi-controller.yaml schema and you can drop properties
>> described there.
> 
> Okay, I will include msi-controller.yaml in the next revision.
> 
>>
>>> +
>>> +  interrupts-extended:
>>> +    minItems: 1
>>> +    maxItems: 32768
>>
>> I just wonder if you are not putting some random stuff here... just like
>> this "vendor" company.
>>
>> 32768 inputs it is quite a big chip. Are you sure you have so many pins
>> or internal connections?
> 
> The interrupts-extended property describes the association of IMSIC
> interrupt files with the HARTs. If there are N HARTs then we will have
> N entries in the interrupts-extended (just like the existing PLIC DT bindings).
> 
> For example, if the first entry points to HART1 and the second entry points
> to HART0 then the first interrupt file is associated with HART1 and the
> second interrupt file is associated with HART0.
> 
> Currently, the "maxItems" limit reflects the max IMSICs which an APLIC
> domain can target on a system with both IMSIC and APLIC.
> 
> Actually, there is a typo here. The "maxItems" should be 16384 as-per
> the frozen AIA specification. I will update "maxItems" accordingly in
> next patch revision.
> 
>>
>>> +    description:
>>> +      This property represents the set of CPUs (or HARTs) for which given
>>> +      device tree node describes the IMSIC interrupt files. Each node pointed
>>> +      to should be a riscv,cpu-intc node, which has a riscv node (i.e. RISC-V
>>> +      HART) as parent.
>>> +
>>> +  riscv,num-ids:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    minimum: 63
>>> +    maximum: 2047
>>> +    description:
>>> +      Specifies how many interrupt identities are supported by IMSIC interrupt
>>> +      file.
>>> +
>>> +  riscv,num-guest-ids:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    minimum: 63
>>> +    maximum: 2047
>>> +    description:
>>> +      Specifies how many interrupt identities are supported by IMSIC guest
>>> +      interrupt file. When not specified the number of interrupt identities
>>> +      supported by IMSIC guest file is assumed to be same as specified by
>>> +      the riscv,num-ids property.
>>> +
>>> +  riscv,slow-ipi:
>>> +    type: boolean
>>> +    description:
>>> +      The presence of this property implies that software interrupts (i.e.
>>> +      IPIs) using IMSIC software injected MSIs is slower compared to other
>>> +      software interrupt mechanisms (such as SBI IPI) on the underlying
>>> +      RISC-V platform.
>>
>> Is this a property of software or hardware?
> 
> This is a property of hardware (or implementation) because IPIs
> in IMSIC are software injected MSIs so if IMSIC is trap-n-emulated
> by a hypervisor then all writes to MSI register will trap to hypervisor
> in which case IPI injection via IMSIC is slow.
> 
> The presence of "riscv,slow-ipi" DT property provides a hint to
> driver that using IPIs through IMSIC is slow on this platform so
> if there are other IPI mechanisms (such as SBI IPI calls) then
> OS should prefer those mechanisms.

If this is specific to implementation, why it is not included already in
the compatible?

The name is anyway too vague. What is "slow"? Describe real
characteristics of hardware, e.g. trapped via hypervisor.
> 
>>
>>> +
>>> +  riscv,guest-index-bits:
>>> +    minimum: 0
>>> +    maximum: 7
>>> +    description:
>>> +      Specifies number of guest index bits in the MSI target address. When
>>> +      not specified it is assumed to be 0.
>>> +
>>> +  riscv,hart-index-bits:
>>> +    minimum: 0
>>> +    maximum: 15
>>> +    description:
>>> +      Specifies number of HART index bits in the MSI target address. When
>>> +      not specified it is estimated based on the interrupts-extended property.
>>> +
>>> +  riscv,group-index-bits:
>>> +    minimum: 0
>>> +    maximum: 7
>>> +    description:
>>> +      Specifies number of group index bits in the MSI target address. When
>>> +      not specified it is assumed to be 0.
>>
>> Then default: 0.
> 
> Okay, I will update.
> 
>>
>>> +
>>> +  riscv,group-index-shift:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    minimum: 24
>>> +    maximum: 55
>>> +    description:
>>> +      Specifies the least significant bit of the group index bits in the
>>
>> Please drop everywhere "Specifies the" and instead just describe the
>> hardware.
> 
> Okay, I will update.
> 
>>
>>> +      MSI target address. When not specified it is assumed to be 24.
>>> +
>>> +additionalProperties: false
>>
>> unevaluatedProperties: false and drop all properties already described
>> by other schemas.
> 
> Okay, I will update.
> 
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupt-controller
>>> +  - msi-controller
>>> +  - interrupts-extended
>>> +  - riscv,num-ids
>>> +
>>> +examples:
>>> +  - |
>>> +    // Example 1 (Machine-level IMSIC files with just one group):
>>> +
>>> +    imsic_mlevel: interrupt-controller@24000000 {
>>> +      compatible = "vendor,chip-imsics", "riscv,imsics";
>>> +      interrupts-extended = <&cpu1_intc 11>,
>>> +                            <&cpu2_intc 11>,
>>> +                            <&cpu3_intc 11>,
>>> +                            <&cpu4_intc 11>;
>>> +      reg = <0x28000000 0x4000>;
>>> +      interrupt-controller;
>>> +      #interrupt-cells = <0>;
>>> +      msi-controller;
>>> +      riscv,num-ids = <127>;
>>> +    };
>>> +
>>> +  - |
>>> +    // Example 2 (Supervisor-level IMSIC files with two groups):
>>> +
>>> +    imsic_slevel: interrupt-controller@28000000 {
>>> +      compatible = "vendor,chip-imsics", "riscv,imsics";
>>
>> Please run scripts/checkpatch.pl and fix reported warnings.
> 
> I did not see any warnings with ./scripts/checkpatch.pl.
> 
> Is there any parameter of checkpatch.pl which I should try ?

You should see here or with your DTS warnings about undocumented vendor
prefix.

Best regards,
Krzysztof

