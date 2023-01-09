Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6567866234B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjAIKkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjAIKke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:40:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220B018B25
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:40:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g10so5932723wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4s8gyEzGa9/+YTwIpz0gyA7IbtzObVaZ/2VL3lFmQvk=;
        b=NtCgVGxhd1xgSS3YJnIlYU0+MKNzVXLXNpjv8RNiEuGDFiWInSeoJLHit34IPv88kB
         FDf52/pLYN6HK46HQq5DjH0eT7Xl2+HlwljDAAGC8eH1qQgnQ1er2nl5w64eUvL7xfLk
         /S5rp+HuMkUfHPtFk0R0pAjh5xwdpgjk9mhMnE1BjDhvfI6QkBOJ1nwbe8WMVDB0B91W
         /EwREiQPmGcBdNU8yZqGjQQfUP8BVMuCTP4C/gFKQlkOfQLPrKyH+znm18FkTYXTCe86
         /XX9sAGrjFZH2lPgkgZRLWS1MtWH7WKAuYQtOQTk5P+wW08sDG0DThMYlxuU1+75K88f
         G7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4s8gyEzGa9/+YTwIpz0gyA7IbtzObVaZ/2VL3lFmQvk=;
        b=r0W2YUUVo+/LoweeWeF3mNlDzV0Z+Y0kQooC8gd1SMPwLqBNUO/B0EiG+59Kp2faR9
         xR4iL6pYx1mneExIaQ1F5hA1Mdyg/KJsO0p4pV9stZo23HJTDgzonBTNpgpuOquxNPcc
         oRQwHx3vxr2A8yJGouAK4yjJHJIZomjFlA4GczTwTBP0LAZdXHMbU6n20ExfzH+iHueM
         J328Dfkj7l4CVND800HshPRSaFaUOBM+bSQQQKbTc/FZ2lSPC2O/xjlPEjf7Ffxp395o
         8IZfcy/GQe2Kw6khPqgCKVr54HmbUZh0AZ3C+mAsSvqSq75YwHBrkWKktkV59aoqxxGy
         YNKw==
X-Gm-Message-State: AFqh2koM0ZDBuR4D5ksVIBmb2fdBaGmCN8+k1ZUpb4gYTog5Ss9jpZFy
        g5Y+jsYEg3+tpv6swaS9Djkq/w==
X-Google-Smtp-Source: AMrXdXse61lmDq4roPhoyaYQAiAAXVFtRcexCG4n018s3Pt/lzdOFaILzt7m+hq/2bhn1ayr/SCgBQ==
X-Received: by 2002:a05:600c:1d0e:b0:3cf:8957:a441 with SMTP id l14-20020a05600c1d0e00b003cf8957a441mr12170318wms.12.1673260830651;
        Mon, 09 Jan 2023 02:40:30 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c2caa00b003cfd58409desm15901325wmc.13.2023.01.09.02.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:40:30 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:40:29 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        atishp@rivosinc.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        apatel@ventanamicro.com, will@kernel.org, mark.rutland@arm.com,
        opensbi@lists.infradead.org, samuel@sholland.org
Subject: Re: [PATCH v4] dt-bindings: riscv: add SBI PMU event mappings
Message-ID: <20230109104029.3cwbngqiydlpl7z2@orel>
References: <20230108215047.3165032-1-conor@kernel.org>
 <20230109092715.bwomqoeosif43lr2@orel>
 <Y7vpxW1AeEOhcxUf@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7vpxW1AeEOhcxUf@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 10:17:41AM +0000, Conor Dooley wrote:
> On Mon, Jan 09, 2023 at 10:27:15AM +0100, Andrew Jones wrote:
> > On Sun, Jan 08, 2023 at 09:50:48PM +0000, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > 
> > > The SBI PMU extension requires a firmware to be aware of the event to
> > > counter/mhpmevent mappings supported by the hardware. OpenSBI may use
> > > DeviceTree to describe the PMU mappings. This binding is currently
> > > described in markdown in OpenSBI (since v1.0 in Dec 2021) & used by QEMU
> > > since v7.2.0.
> > > 
> > > Import the binding for use while validating dtb dumps from QEMU and
> > > upcoming hardware (eg JH7110 SoC) that will make use of the event
> > > mapping.
> > > 
> > > Link: https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md
> > > Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc # Performance Monitoring Unit Extension
> > > Co-developed-by: Atish Patra <atishp@rivosinc.com>
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > > Changes in v4:
> > > - A bunch of minor description/comment changes suggested by Drew
> > > 
> > > Changes in v3:
> > > - align descriptions to SBI spec (and fix a misinterpretation of mine)
> > > - switch to a nested items description, since the descriptions are for
> > >   the elements of each entry, not the entries themselves
> > > 
> > > Changes in v2:
> > > - use the schema mechanism for dependancies between properties
> > > - +CC perf maintainers...
> > > - move the matrix element descriptions into regular item descriptions
> > >   rather than doing so freeform in the property description
> > > - drop some description text that no longer applies since changes were
> > >   made to the SBI spec
> > > - drop mention of the "generic platform" which is OpenSBI specific
> > > - drop the min/max items from the matrices, they don't appear to be
> > >   needed?
> > > 
> > > Note:
> > > OpenSBI is BSD-2-Clause licensed so I am unsure as to whether I can
> > > submit it with a dual license.
> > > ---
> > >  .../devicetree/bindings/perf/riscv,pmu.yaml   | 160 ++++++++++++++++++
> > >  1 file changed, 160 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> > > new file mode 100644
> > > index 000000000000..5e7a54e3d91b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> > > @@ -0,0 +1,160 @@
> > > +# SPDX-License-Identifier: BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/perf/riscv,pmu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: RISC-V SBI PMU events
> > > +
> > > +maintainers:
> > > +  - Atish Patra <atishp@rivosinc.com>
> > > +
> > > +description: |
> > > +  The SBI PMU extension allows supervisor software to configure, start and
> > > +  stop any performance counter at anytime. Thus, a user can leverage all
> > > +  capabilities of performance analysis tools, such as perf, if the SBI PMU
> > > +  extension is enabled. The following constraints apply:
> > > +
> > > +    The platform must provide information about PMU event to counter mappings
> > > +    via device tree or platform specific hooks. Otherwise, the SBI PMU
> > > +    extension will not be enabled.
> > > +
> > > +    Platforms should provide information about the PMU event selector values
> > > +    that should be encoded in the expected value of MHPMEVENTx while configuring
> > > +    MHPMCOUNTERx for that specific event. This can be done via a device tree or
> > > +    platform specific hooks. The exact value to be written to MHPMEVENTx is
> > > +    completely dependent on the platform.
> > 
> > The previous two paragraphs reference 'platform specific hooks'. I don't
> > think this DT-specific description, as opposed to the more general OpenSBI
> > description it's derived from, should reference the hooks, as "hooks"
> > aren't defined in this context.
> 
> Do you have any suggestion about how it should be worded? It is
> apparently valid to have only a compatible string in the dt-binding and
> rely on using platform hooks to communicate the mapping. In that case,
> the dt-binding only communicates the presence of SBI PMU support.
> IMO, if we don't mention that that is a valid way, the fact that we only
> require a compatible for a DT to be valid looks like a mistake in the
> binding.

Maybe just replace 'platform specific hooks' with 'in a platform specific
way'? I'm mostly just hung up on "hooks" (pun definitely intended), as
this document lives in the Linux repo and there aren't any hooks.

Thanks,
drew

> 
> Thanks,
> Conor.
> 
> > > +    For information on the SBI specification see the section "Performance
> > > +    Monitoring Unit Extension" of:
> > > +      https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: riscv,pmu
> > > +
> > > +  riscv,event-to-mhpmevent:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +    description:
> > > +      Represents an ONE-to-ONE mapping between a PMU event and the event
> > > +      selector value that the platform expects to be written to the MHPMEVENTx
> > > +      CSR for that event.
> > > +      The mapping is encoded in an matrix format where each element represents
> > > +      an event.
> > > +      This property shouldn't encode any raw hardware event.
> > > +    items:
> > > +      items:
> > > +        - description: event_idx, a 20-bit wide encoding of the event type and
> > > +            code. Refer to the SBI specification for a complete description of
> > > +            the event types and codes.
> > > +        - description: upper 32 bits of the event selector value for MHPMEVENTx
> > > +        - description: lower 32 bits of the event selector value for MHPMEVENTx
> > > +
> > > +  riscv,event-to-mhpmcounters:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +    description:
> > > +      Represents a MANY-to-MANY mapping between a range of events and all the
> > > +      MHPMCOUNTERx in a bitmap format that can be used to monitor these range
> > > +      of events. The information is encoded in an matrix format where each
> > > +      element represents a certain range of events and corresponding counters.
> > > +      This property shouldn't encode any raw event.
> > > +    items:
> > > +      items:
> > > +        - description: first event_idx of the range of events
> > > +        - description: last event_idx of the range of events
> > > +        - description: bitmap of MHPMCOUNTERx for this event
> > > +
> > > +  riscv,raw-event-to-mhpmcounters:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +    description:
> > > +      Represents an ONE-to-MANY or MANY-to-MANY mapping between the rawevent(s)
> > > +      and all the MHPMCOUNTERx in a bitmap format that can be used to monitor
> > > +      that raw event.
> > > +      The encoding of the raw events are platform specific. The information is
> > > +      encoded in a matrix format where each element represents the specific raw
> > > +      event(s).
> > > +      If a platform directly encodes each raw PMU event as a unique ID, the
> > > +      value of variant must be 0xffffffff_ffffffff.
> > > +    items:
> > > +      items:
> > > +        - description:
> > > +            upper 32 invariant bits for the range of events
> > > +        - description:
> > > +            lower 32 invariant bits for the range of events
> > > +        - description:
> > > +            upper 32 bits of the variant bit mask for the range of events
> > > +        - description:
> > > +            lower 32 bits of the variant bit mask for the range of events
> > > +        - description:
> > > +            bitmap of all MHPMCOUNTERx that can monitor the range of events
> > > +
> > > +dependencies:
> > > +  "riscv,event-to-mhpmevent": [ "riscv,event-to-mhpmcounters" ]
> > > +  "riscv,event-to-mhpmcounters": [ "riscv,event-to-mhpmevent" ]
> > > +
> > > +required:
> > > +  - compatible
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    pmu {
> > > +        compatible = "riscv,pmu";
> > > +        riscv,event-to-mhpmevent = <0x0000B 0x0000 0x0001>;
> > > +        riscv,event-to-mhpmcounters = <0x00001 0x00001 0x00000001>,
> > > +                                      <0x00002 0x00002 0x00000004>,
> > > +                                      <0x00003 0x0000A 0x00000ff8>,
> > > +                                      <0x10000 0x10033 0x000ff000>;
> > > +        riscv,raw-event-to-mhpmcounters =
> > > +            /* For event ID 0x0002 */
> > > +            <0x0000 0x0002 0xffffffff 0xffffffff 0x00000f8>,
> > > +            /* For event ID 0-4 */
> > > +            <0x0 0x0 0xffffffff 0xfffffff0 0x00000ff0>,
> > > +            /* For event ID 0xffffffff0000000f - 0xffffffff000000ff */
> > > +            <0xffffffff 0x0 0xffffffff 0xffffff0f 0x00000ff0>;
> > > +    };
> > > +
> > > +  - |
> > > +    /*
> > > +     * For HiFive Unmatched board the encodings can be found here
> > > +     * https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf
> > > +     *
> > > +     * This example also binds standard SBI PMU hardware IDs to U74 PMU event
> > > +     * codes, U74 uses a bitfield for events encoding, so several U74 events
> > > +     * can be bound to a single perf ID.
> > > +     * See SBI PMU hardware IDs in arch/riscv/include/asm/sbi.h
> > > +     */
> > > +    pmu {
> > > +          compatible = "riscv,pmu";
> > > +          riscv,event-to-mhpmevent =
> > > +              /* SBI_PMU_HW_CACHE_REFERENCES -> Instruction or Data cache/ITIM busy */
> > > +              <0x00003 0x00000000 0x1801>,
> > > +              /* SBI_PMU_HW_CACHE_MISSES -> Instruction or Data cache miss or MMIO access */
> > > +              <0x00004 0x00000000 0x0302>,
> > > +              /* SBI_PMU_HW_BRANCH_INSTRUCTIONS -> Conditional branch retired */
> > > +              <0x00005 0x00000000 0x4000>,
> > > +              /* SBI_PMU_HW_BRANCH_MISSES -> Branch or jump misprediction */
> > > +              <0x00006 0x00000000 0x6001>,
> > > +              /* L1D_READ_MISS -> Data cache miss or MMIO access */
> > > +              <0x10001 0x00000000 0x0202>,
> > > +              /* L1D_WRITE_ACCESS -> Data cache write-back */
> > > +              <0x10002 0x00000000 0x0402>,
> > > +              /* L1I_READ_ACCESS -> Instruction cache miss */
> > > +              <0x10009 0x00000000 0x0102>,
> > > +              /* LL_READ_MISS -> UTLB miss */
> > > +              <0x10011 0x00000000 0x2002>,
> > > +              /* DTLB_READ_MISS -> Data TLB miss */
> > > +              <0x10019 0x00000000 0x1002>,
> > > +              /* ITLB_READ_MISS-> Instruction TLB miss */
> > > +              <0x10021 0x00000000 0x0802>;
> > > +          riscv,event-to-mhpmcounters = <0x00003 0x00006 0x18>,
> > > +                                        <0x10001 0x10002 0x18>,
> > > +                                        <0x10009 0x10009 0x18>,
> > > +                                        <0x10011 0x10011 0x18>,
> > > +                                        <0x10019 0x10019 0x18>,
> > > +                                        <0x10021 0x10021 0x18>;
> > > +          riscv,raw-event-to-mhpmcounters = <0x0 0x0 0xffffffff 0xfc0000ff 0x18>,
> > > +                                            <0x0 0x1 0xffffffff 0xfff800ff 0x18>,
> > > +                                            <0x0 0x2 0xffffffff 0xffffe0ff 0x18>;
> > > +    };
> > > -- 
> > > 2.39.0
> > >
> > 
> > Besides the comment above,
> > 
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > 
> > Thanks,
> > drew
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv


