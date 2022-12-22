Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B325654766
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiLVUkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiLVUj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:39:58 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF27121830
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:39:42 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w20so3066468ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J3zLUjblmA5mKEiIe8j3yE4p+xtYnnjTwcILFpQqr1k=;
        b=tRr0fSrAlAuA+8qQlf6oLPg79UCe7ol6ReGxgZcf4SGnzupfE2aHJbFlqo/Xdf1ZpD
         EUhGSYp97two/lSMQCeGDZH1GJNsVxsXvMvvD38+DHu7Sq5eZ1BFW2XhwLCo+2ha0JyD
         lgIjSKg7xcoL+s7mNNqu0XAT3rWGWibvbgNhJS4B2c+Y9rFJlbENBKxLwacYLZZ98Rfy
         dcOj9x0Wv+BHTGC8cFhNxffMDG4HFzfjSWLF5dCt8a8t80FD7Rv2ieahh0fmB+Jki8iJ
         d3IIXbNN1o2w8UX1LR8UD94QBRR1YJ8RZKLgnWorYG0np4Vki6JI3y0u+BpljqkAiSQU
         nYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3zLUjblmA5mKEiIe8j3yE4p+xtYnnjTwcILFpQqr1k=;
        b=tNh6BumCgopQyq8Xu4LYMsgpMu7m3FPfmm4fM8VfGFpABah78Bs7zQ+uSr+xg1KWwE
         CCKtI7AoBCG5bCQLfstMDcDRgRQoZuwJKBKv77sgrfifHykx8k2b+A2tBm6ywjahoX0l
         96ZjhHNmXXIl8ApMwD6JhptgjsIsaCmv3dJK+xoPCXDmfXeE9Y7tIOjNrlc1KCKcMsn4
         MO/ab7Fxfvss//jdtVDG41clbKluVCFefwNqtEYha29t/CCLH5umd1B+RwHVq4qxSfUB
         wqF+OEQmfu8tjIBrk+kXQ1Z95MhSZq+ds1JOJp05Q8cY70XgK81txRnUnKgAn9qKzPsg
         icJw==
X-Gm-Message-State: AFqh2kpCkFPm3iPTDsJ1wGKwdF6KwVyn6siK5xRkpP7p8uxNOSUN6YVW
        FapXtDWxlSEoG767Og4f092S6hSzhU9v7/o97q2CPw==
X-Google-Smtp-Source: AMrXdXs1KzVo1N9EgMkuU6lriJgDH0QGtfzhY/506RNYcwO3uIbIeNNlqQOdmKSv6PYn7R0RUAZgCGWR6PQQY3jYAqY=
X-Received: by 2002:a17:903:2154:b0:186:a394:aef7 with SMTP id
 s20-20020a170903215400b00186a394aef7mr453138ple.79.1671741582290; Thu, 22 Dec
 2022 12:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20221221141548.274408-1-conor@kernel.org> <20221222180627.GA1748427-robh@kernel.org>
 <Y6SuyiYC/oLB2VzL@spud> <CAHBxVyEZJeH6H00Jdcm2_=z-D2kYxVTgagYhmLoyJ2CPqcFbgg@mail.gmail.com>
 <Y6S7ENNXQe42ymTz@spud>
In-Reply-To: <Y6S7ENNXQe42ymTz@spud>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Thu, 22 Dec 2022 12:39:31 -0800
Message-ID: <CAHBxVyHn7NEYCJTCJYU3Pu4=t7TGssog3ywaxfd1TFXXF9f9+Q@mail.gmail.com>
Subject: Re: [PATCH v1] dt-bindings: riscv: add SBI PMU event mappings
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        opensbi@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 12:16 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Thu, Dec 22, 2022 at 11:55:29AM -0800, Atish Kumar Patra wrote:
> > On Thu, Dec 22, 2022 at 11:24 AM Conor Dooley <conor@kernel.org> wrote:
> > > On Thu, Dec 22, 2022 at 12:06:27PM -0600, Rob Herring wrote:
> > > > On Wed, Dec 21, 2022 at 02:15:49PM +0000, Conor Dooley wrote:
> > > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > > >
> > > > > The SBI PMU extension requires a firmware to be aware of the event to
> > > > > counter/mhpmevent mappings supported by the hardware. OpenSBI may use
> > > > > DeviceTree to describe the PMU mappings. This binding is currently
> > > > > described in markdown in OpenSBI (since v1.0 in Dec 2021) & used by QEMU
> > > > > since v7.2.0.
> > > > >
> > > > > Import the binding for use while validating dtb dumps from QEMU and
> > > > > upcoming hardware (eg JH7110 SoC) that will make use of the event
> > > > > mapping.
> > > > >
> > > > > Link: https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md
> > > > > Co-developed-by: Atish Patra <atishp@rivosinc.com>
> > > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > +description: |
> > > > > +  SBI PMU extension supports allow supervisor software to configure, start &
> > > > > +  stop any performance counter at anytime. Thus, a user can leverage full
> > > > > +  capability of performance analysis tools such as perf if the SBI PMU
> > > > > +  extension is enabled. The OpenSBI implementation makes the following
> > > > > +  assumptions about the hardware platform:
> > > > > +    MCOUNTINHIBIT CSR must be implemented in the hardware. Otherwise, the SBI
> > > > > +    PMU extension will not be enabled.
> > > > > +
> >
> > This is no longer true since OpenSBI commit b28f070. We should remove
> > this from OpenSBI docs as well.
>
> Since you know the detail of it, I volunteer you for that one ;)
>

Done.

> > > > > +    The platform must provide information about PMU event to counter mapping
> > > > > +    via device tree or platform specific hooks. Otherwise, the SBI PMU
> > > > > +    extension will not be enabled.
> > > > > +
> > > > > +    The platforms should provide information about the PMU event selector
> > > > > +    values that should be encoded in the expected value of MHPMEVENTx while
> > > > > +    configuring MHPMCOUNTERx for that specific event. This can be done via a
> > > > > +    device tree or platform specific hooks. The exact value to be written to
> > > > > +    the MHPMEVENTx is completely dependent on the platform. The generic
> > > > > +    platform writes the zero-extended event_idx as the expected value for
> > > > > +    hardware cache/generic events as suggested by the SBI specification.
> > > > > +
> >
> > But the larger question is these are OpenSBI implementation specific
> > assumptions. Should it be included in
> > the DT binding?
>
> Probably not. I'll drop it for v2.
>
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: riscv,pmu
> > > > > +
> > > > > +  riscv,event-to-mhpmevent:
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > > > +    description:
> > > > > +      Represents an ONE-to-ONE mapping between a PMU event and the event
> > > > > +      selector value that platform expects to be written to the MHPMEVENTx CSR
> > > > > +      for that event.
> > > > > +      The mapping is encoded in an array format where each row represents an
> > > >
> > > > s/array/matrix/
> > > >
> > > > > +      event. The first element represents the event idx while the second &
> > > > > +      third elements represent the event selector value that should be encoded
> > > > > +      in the expected value to be written in MHPMEVENTx.
> > > > > +      This property shouldn't encode any raw hardware event.
> > > > > +    minItems: 1
> > > > > +    maxItems: 255
> > >
> > > I copied these 255s from dt-schema somewhere as a sane max.
> > > Atish, is there a cap here or should we allow as many as someone likes?
> > > The md binding doesn't mention any limits - is it in the SBI spec?
> > > The strongest wording I saw there was "limited" & event idx is 20 bits
> > > wide as per the spec [0]. Does that make 2^20 the hard limit here?
> > >
> >
> > This is for hardware & cache events. The total number of events
> > defined there are 52 (10 HW + 42 Cache) events.
> > So 255 is a sane max that provides enough room for expansion in future
> > if required.
>
> WFM.
>
> > > > > +  riscv,raw-event-to-mhpmcounters:
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > > > +    description:
> > > > > +      Represents an ONE-to-MANY or MANY-to-MANY mapping between the rawevent(s)
> > > > > +      and all the MHPMCOUNTERx in a bitmap format that can be used to monitor
> > > > > +      that raw event.
> > > > > +      The encoding of the raw events are platform specific. The information is
> > > > > +      encoded in an array format where each row represents the specific raw
> > > > > +      event(s). The first element is a 64-bit match value where the invariant
> > > > > +      bits of range of events are set. The second element is a 64-bit mask that
> > > > > +      will have all the variant bits of the range of events cleared. All other
> > > > > +      bits should be set in the mask. The third element is a 32-bit value to
> > > > > +      represent bitmap of all MHPMCOUNTERx that can monitor these set of
> > > > > +      event(s). If a platform directly encodes each raw PMU event as a unique
> > > > > +      ID, the value of select_mask must be 0xffffffff_ffffffff.
> > > > > +    minItems: 1
> > > > > +    maxItems: 255
> > > > > +    items:
> > > > > +      $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > +      maxItems: 5
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > >
> > > > I assume at least one of the other properties must be present?
> > >
> > > Atish: (and +CC the OpenSBI list)
> > > Which properties are actually needed here? Or are any? The md binding
> > > in the OpenSBI sources doesn't seem to require anything other than the
> > > compatible?
> > >
> >
> > That's true. Opensbi allows the platform to define functions
> > to provide the mapping. Now that's an OpenSBI implementation thing.
> > Other implementations may choose to use it differently.
>
> In the case where the platform can define functions, the "bare" node
> with just the compatible is still required though in that case, right?
>

Yup.

> Thanks,
> Conor.
>
