Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED8B6545D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiLVSGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLVSGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:06:30 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5875C15804;
        Thu, 22 Dec 2022 10:06:29 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id c129so2627963oia.0;
        Thu, 22 Dec 2022 10:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnwlcEHISNopnq+CmFljTGKvcGCFq1+OvWw4yrNda2k=;
        b=Il+AyQwsNBwnxSZgBwJuj1YYR88XQf0rhM8fno5g57ZhR9OaMdMSfb95Qi+D3bKFNB
         /siKZc9lYxobyMscxakMk7SPzDJI0Uel0wxtYLmDyNG2825n/AMWzC7SYvi0OLd6/2sn
         hg+DFw7AF5oPcSfcHzwt+stQLrBfKWkaNZeDEc9VOvbnDfBfO5iAH0phxBYh2d9wLYAs
         PZvPniYYDVx3XKQhPZQCS+NxmCJ3fa9Vzqs5xiJItOBZQrPhNsxTFdBM41cUo6qzy9ns
         MTQEOgidpelqc+iP1evElXX2e+PupvtNTXkJT/1dC3mlrClF8NW7Puj3Mo6IhmwPYTVL
         Lp8w==
X-Gm-Message-State: AFqh2koz9sGqT26VZvTJwCOXKdsjrWSafU4XKQRLDN/TfuesjFcl4MmX
        XgSEHjIkMr98XC/NQlCqQA==
X-Google-Smtp-Source: AMrXdXtk+Mko16yvalIZW/LDiiAqzitC2SvlNmtRx2poVHSuQ4sMiV+x+LWhDW3u3x4vmThZkw7aiw==
X-Received: by 2002:a05:6808:2197:b0:360:d8ca:b809 with SMTP id be23-20020a056808219700b00360d8cab809mr12491600oib.28.1671732388461;
        Thu, 22 Dec 2022 10:06:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m1-20020a05683026c100b0067c87f23476sm596245otu.57.2022.12.22.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 10:06:28 -0800 (PST)
Received: (nullmailer pid 1797084 invoked by uid 1000);
        Thu, 22 Dec 2022 18:06:27 -0000
Date:   Thu, 22 Dec 2022 12:06:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        atishp@rivosinc.com, Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com
Subject: Re: [PATCH v1] dt-bindings: riscv: add SBI PMU event mappings
Message-ID: <20221222180627.GA1748427-robh@kernel.org>
References: <20221221141548.274408-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221141548.274408-1-conor@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 02:15:49PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The SBI PMU extension requires a firmware to be aware of the event to
> counter/mhpmevent mappings supported by the hardware. OpenSBI may use
> DeviceTree to describe the PMU mappings. This binding is currently
> described in markdown in OpenSBI (since v1.0 in Dec 2021) & used by QEMU
> since v7.2.0.
> 
> Import the binding for use while validating dtb dumps from QEMU and
> upcoming hardware (eg JH7110 SoC) that will make use of the event
> mapping.
> 
> Link: https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md
> Co-developed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I asked Rob on IRC about these bindings a few weeks ago & he said he
> would be willing to take them. I have modified wording slightly in the
> descriptions, but have mostly left things as close to the OpenSBI
> documentation as possible.

Please CC the perf maintainers. Might be crickets, but so they at least 
have a chance to see it.

> 
> I'm not super sure about what I've done with the properties being
> correct type wise, I went digging in bindings and am sorta using the
> first thing that "fit".
> 
> Since you wrote the md doc Atish, I put your co-developed-by. OpenSBI
> is BSD-2-Clause licensed so I am also unsure as to what license I can
> use for this binding since that's where I took it from.
> ---
>  .../devicetree/bindings/perf/riscv,pmu.yaml   | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> new file mode 100644
> index 000000000000..d65f937680af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/riscv,pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V SBI PMU events
> +
> +maintainers:
> +  - Atish Patra <atishp@rivosinc.com>
> +
> +description: |
> +  SBI PMU extension supports allow supervisor software to configure, start &
> +  stop any performance counter at anytime. Thus, a user can leverage full
> +  capability of performance analysis tools such as perf if the SBI PMU
> +  extension is enabled. The OpenSBI implementation makes the following
> +  assumptions about the hardware platform:
> +    MCOUNTINHIBIT CSR must be implemented in the hardware. Otherwise, the SBI
> +    PMU extension will not be enabled.
> +
> +    The platform must provide information about PMU event to counter mapping
> +    via device tree or platform specific hooks. Otherwise, the SBI PMU
> +    extension will not be enabled.
> +
> +    The platforms should provide information about the PMU event selector
> +    values that should be encoded in the expected value of MHPMEVENTx while
> +    configuring MHPMCOUNTERx for that specific event. This can be done via a
> +    device tree or platform specific hooks. The exact value to be written to
> +    the MHPMEVENTx is completely dependent on the platform. The generic
> +    platform writes the zero-extended event_idx as the expected value for
> +    hardware cache/generic events as suggested by the SBI specification.
> +
> +properties:
> +  compatible:
> +    const: riscv,pmu
> +
> +  riscv,event-to-mhpmevent:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description:
> +      Represents an ONE-to-ONE mapping between a PMU event and the event
> +      selector value that platform expects to be written to the MHPMEVENTx CSR
> +      for that event.
> +      The mapping is encoded in an array format where each row represents an

s/array/matrix/

> +      event. The first element represents the event idx while the second &
> +      third elements represent the event selector value that should be encoded
> +      in the expected value to be written in MHPMEVENTx.
> +      This property shouldn't encode any raw hardware event.
> +    minItems: 1
> +    maxItems: 255
> +    items:
> +      $ref: /schemas/types.yaml#/definitions/uint32-array

Huh? A property can only have 1 type. I wonder what the tools do with 
this...

> +      maxItems: 3

Better to do:

         items:
           - description: what's in the 1st word
           - description: what's in the 2nd word
           - description: what's in the 3rd word

And rework the overall description to not say the same thing.

> +
> +  riscv,event-to-mhpmcounters:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description:
> +      Represents a MANY-to-MANY mapping between a range of events and all the
> +      MHPMCOUNTERx in a bitmap format that can be used to monitor these range
> +      of events. The information is encoded in an array format where each
> +      row represents a certain range of events and corresponding counters.
> +      The first element represents starting of the pmu event id and 2nd column
> +      represents the end of the pmu event id. The third element represent a
> +      bitmap of all the MHPMCOUNTERx.
> +      This property is mandatory if event-to-mhpmevent is present. Otherwise,
> +      it can be omitted.

No need to state this in freeform text, use 'dependencies'.

> +      This property shouldn't encode any raw event.
> +    minItems: 1
> +    maxItems: 255
> +    items:
> +      $ref: /schemas/types.yaml#/definitions/uint32-array
> +      maxItems: 3
> +
> +  riscv,raw-event-to-mhpmcounters:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description:
> +      Represents an ONE-to-MANY or MANY-to-MANY mapping between the rawevent(s)
> +      and all the MHPMCOUNTERx in a bitmap format that can be used to monitor
> +      that raw event.
> +      The encoding of the raw events are platform specific. The information is
> +      encoded in an array format where each row represents the specific raw
> +      event(s). The first element is a 64-bit match value where the invariant
> +      bits of range of events are set. The second element is a 64-bit mask that
> +      will have all the variant bits of the range of events cleared. All other
> +      bits should be set in the mask. The third element is a 32-bit value to
> +      represent bitmap of all MHPMCOUNTERx that can monitor these set of
> +      event(s). If a platform directly encodes each raw PMU event as a unique
> +      ID, the value of select_mask must be 0xffffffff_ffffffff.
> +    minItems: 1
> +    maxItems: 255
> +    items:
> +      $ref: /schemas/types.yaml#/definitions/uint32-array
> +      maxItems: 5
> +
> +required:
> +  - compatible

I assume at least one of the other properties must be present?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmu {
> +        compatible = "riscv,pmu";
> +        riscv,event-to-mhpmevent = <0x0000B 0x0000 0x0001>;
> +        riscv,event-to-mhpmcounters = <0x00001 0x00001 0x00000001>,
> +                                      <0x00002 0x00002 0x00000004>,
> +                                      <0x00003 0x0000A 0x00000ff8>,
> +                                      <0x10000 0x10033 0x000ff000>;
> +        riscv,raw-event-to-mhpmcounters =
> +            /* For event ID 0x0002 */
> +            <0x0000 0x0002 0xffffffff 0xffffffff 0x00000f8>,
> +            /* For event ID 0-4 */
> +            <0x0 0x0 0xffffffff 0xfffffff0 0x00000ff0>,
> +            /* For event ID 0xffffffff0000000f - 0xffffffff000000ff */
> +            <0xffffffff 0x0 0xffffffff 0xffffff0f 0x00000ff0>;
> +    };
> +
> +  - |
> +    /*
> +     * For HiFive Unmatched board the encodings can be found here
> +     * https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf
> +     * This example also binds standard SBI PMU hardware id's to U74 PMU event
> +     * codes, U74 uses a bitfield for events encoding, so several U74 events
> +     * can be bound to single perf id.
> +     * See SBI PMU hardware id's in OpenSBI's include/sbi/sbi_ecall_interface.h
> +     */
> +    pmu {
> +          compatible = "riscv,pmu";
> +          riscv,event-to-mhpmevent =
> +              /* SBI_PMU_HW_CACHE_REFERENCES -> Instruction or Data cache/ITIM busy */
> +              <0x00003 0x00000000 0x1801>,
> +              /* SBI_PMU_HW_CACHE_MISSES -> Instruction or Data cache miss or MMIO access */
> +              <0x00004 0x00000000 0x0302>,
> +              /* SBI_PMU_HW_BRANCH_INSTRUCTIONS -> Conditional branch retired */
> +              <0x00005 0x00000000 0x4000>,
> +              /* SBI_PMU_HW_BRANCH_MISSES -> Branch or jump misprediction */
> +              <0x00006 0x00000000 0x6001>,
> +              /* L1D_READ_MISS -> Data cache miss or MMIO access */
> +              <0x10001 0x00000000 0x0202>,
> +              /* L1D_WRITE_ACCESS -> Data cache write-back */
> +              <0x10002 0x00000000 0x0402>,
> +              /* L1I_READ_ACCESS -> Instruction cache miss */
> +              <0x10009 0x00000000 0x0102>,
> +              /* LL_READ_MISS -> UTLB miss */
> +              <0x10011 0x00000000 0x2002>,
> +              /* DTLB_READ_MISS -> Data TLB miss */
> +              <0x10019 0x00000000 0x1002>,
> +              /* ITLB_READ_MISS-> Instruction TLB miss */
> +              <0x10021 0x00000000 0x0802>;
> +          riscv,event-to-mhpmcounters = <0x00003 0x00006 0x18>,
> +                                        <0x10001 0x10002 0x18>,
> +                                        <0x10009 0x10009 0x18>,
> +                                        <0x10011 0x10011 0x18>,
> +                                        <0x10019 0x10019 0x18>,
> +                                        <0x10021 0x10021 0x18>;
> +          riscv,raw-event-to-mhpmcounters = <0x0 0x0 0xffffffff 0xfc0000ff 0x18>,
> +                                            <0x0 0x1 0xffffffff 0xfff800ff 0x18>,
> +                                            <0x0 0x2 0xffffffff 0xffffe0ff 0x18>;
> +    };
> -- 
> 2.38.1
> 
> 
