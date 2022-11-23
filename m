Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C20635A86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiKWKul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiKWKuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:50:17 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A2B169014
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:36:25 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id e205so18557511oif.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=izA04ojZdOp2vjbcI8Xn4ulA1Qxsgm2W27nMnOIGQck=;
        b=isMAWLed394yYNRK/lL7MVNTnt2iMRbDcNnDLftsejKVjQGNiOMxfOYk5PyOw8psK6
         8Kp9MPlwlThDRQ8UA6tbYx3m4SEEF4vD83cpLJIxGdFrK4TfLLFVpXvJKUS3HtJFIjjc
         L9j/XRt3yjsxYgcJeR4oQpUx6pJiv858NAzh2nkCjtyLPUncce4Wdh/F9WmmUXh+zOr+
         cfGXhju1N0tjkmOdEQpsIPeyeGN313vmqqFjx9T88MMoe1yg8Mo2yUI1O28I0uJcWX1d
         x8hZCahrcZyFLXkyACWYBWs4vJOwuxK6Mklti2+Flvv4TQcSY1b1QV1RX6xIRjkAExRk
         dp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izA04ojZdOp2vjbcI8Xn4ulA1Qxsgm2W27nMnOIGQck=;
        b=jueOh+EKwTFUAMRx5W5fQXCOn2nwJ6MYH2XRYFXLKAFb6wu45lWQxomKlKFoEk3Nb6
         SSLYbcBJQHlgPHZNB/S+NZp6jFYSnRgZ2qlR+ixWCqnbUwuDknK0glYLi0IqSKU5TzaV
         s9P1w6zZQA2K4bJdm+/WhlGy1wRhkye+QhK94A63qoDt1vPOPsM4v3z2AgeXJLmUimA6
         JAHEDYisjuKNT8lUM42jtmTbz92uJUD4Tw8vdG5J9Db8tvVjpEGk/5iDo6lxY7SfD4zM
         C2thTMvtAeJrxDIA5wAp0y6y3XdCsgJFkUZhBDzXQOfG2CKiBbTunGWziRhKKkJGzuzl
         j72A==
X-Gm-Message-State: ANoB5pnw/LrHbK2dYSFssYFmKQICLLMwiVaUSLg/I36M7O0odVD+NRHp
        ar9ROu1UpfWQ4ss5PtFAVGdc3oCuijDB7uG3DImRnA==
X-Google-Smtp-Source: AA0mqf50VTeMlsDVEgYgYG7IyvQVE93NFVtPO8FdFRlII63eSio8SrUq1CxeOj+jJnGfz2UPHPFAp4VoOTSwCFZJd3Q=
X-Received: by 2002:aca:1b02:0:b0:359:c377:6f7 with SMTP id
 b2-20020aca1b02000000b00359c37706f7mr3711054oib.271.1669199782907; Wed, 23
 Nov 2022 02:36:22 -0800 (PST)
MIME-Version: 1.0
References: <CAAhSdy0Fs9ZVoRgtz92RgLnFPvgwUzCP_KpK9SCOiVsA-t3p3Q@mail.gmail.com>
 <mhng-3f44cc1f-7305-41c5-a1cf-dfed096bd364@palmer-ri-x1c9>
 <CAK9=C2USZHdfBQrrgd2Rs3u3_gTyscpRgxvPU5P6ptOPu1+Axg@mail.gmail.com>
 <Y3ywTzv3vbgRXQGG@wendy> <CAAhSdy1UwBQwX2jnmJXUAAjFL5TZXTUrs9yf9DRMSH=GV4BcHg@mail.gmail.com>
 <Y33xb0jxZqdexzRc@wendy>
In-Reply-To: <Y33xb0jxZqdexzRc@wendy>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 23 Nov 2022 16:06:12 +0530
Message-ID: <CAK9=C2UtAee8eqE_Y3X-9VG3EqSc-GKr0ACe5wcr_MZZ7hrHMg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 3:40 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> Hey Anup,
>
> On Wed, Nov 23, 2022 at 09:56:31AM +0530, Anup Patel wrote:
> > On Tue, Nov 22, 2022 at 4:50 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> > >
> > > On Tue, Nov 22, 2022 at 11:06:15AM +0530, Anup Patel wrote:
> > > > On Tue, Nov 22, 2022 at 10:46 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> > > > >
> > > > > On Mon, 21 Nov 2022 19:45:07 PST (-0800), anup@brainfault.org wrote:
> > > > > > On Tue, Nov 22, 2022 at 2:27 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> > > > > >>
> > > > > >> From: Palmer Dabbelt <palmer@rivosinc.com>
> > > > > >>
> > > > > >> As per [1], whether or not the core can wake up from non-retentive
> > > > > >> suspend is a platform-specific detail.  We don't have any way to encode
> > > > > >> that, so just stop using them until we've sorted that out.
> > > > > >>
> > > > > >> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
> > > > > >> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> > > > > >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > > > >
> > > > > > This is just unnecessary maintenance churn and it's not the
> > > > > > right way to go. Better to fix this the right way instead of having
> > > > > > a temporary fix.
> > > > > >
> > > > > > I had already sent-out a patch series 5 months back to describe
> > > > > > this in DT:
> > > > > > https://lore.kernel.org/lkml/20220727114302.302201-1-apatel@ventanamicro.com/
> > > > > >
> > > > > > No one has commented/suggested anything (except Samuel
> > > > > > Holland and Sudeep Holla).
> > > > >
> > > > > I see some comments from Krzysztof here
> > > > > <https://lore.kernel.org/lkml/7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org/>
> > > > > as well.  Looks like everyone is pointing out that having our CPU nodes
> > > > > encode timers is a bad idea, my guess is that they're probably right.
> > > >
> > > > Adding a separate timer DT node, creates a new set of compatibility
> > > > issues for existing platforms. I am fine updating my series to have
> > > > separate timer DT node but do we want to go in this direction ?
> > >
> > > I don't really follow. How is there a compatibility issue created by
> > > adding a new node that is not added for a new property? Both will
> > > require changes to the device tree. (You need not reply here, I am going
> > > to review the other thread, it's been on my todo list for too long. Been
> > > caught up with non-coherent stuff & our sw release cycle..)
> >
> > Adding a new timer DT node would mean, the RISC-V timer driver
> > will now be probed using the compatible to the new DT node whereas
> > the RISC-V timer driver is currently probed using CPU DT nodes.
>
> Ahh, that is what I have missed. I'll continue my thoughts on this in
> the dt-binding thread.
>
> > > > Even if ARM has a separate timer DT node, the timers are still part
> > > > of the CPU. It depends on how we see the DT bindings aligning with
> > > > actual HW.
> > > >
> > > > >
> > > > > > Please review this series. I can quickly address comments to
> > > > > > make this available for Linux-6.2. Until this series is merged,
> > > > > > the affected platforms can simply remove non-retentive suspend
> > > > > > states from their DT.
> > > > >
> > > > > That leaves us with a dependency between kernel versions and DT
> > > > > bindings: kernels with the current driver will result in broken systems
> > > > > with the non-retentive suspend states in the DT they boot with when
> > > > > those states can't wake up the CPU.
> > >
> > > Can someone point me at a (non D1 or virt) system that has suspend
> > > states in the DT that would need fixing?
> >
> > For the QEMU virt machine, the default non-retentive suspend state was
> > tested using a temporary DTB provided separately via QEMU command
> > line. The QEMU virt machine does not have its own HART suspend
> > states so OpenSBI will functionally emulate default retentive/non-retentive
> > suspend states.
>
> So since I asked for non D1 or virt systems, that's a no & no DTs
> actually needs to be fixed :)
>
> > > > This is not a new problem we are facing. Even in the ARM world,
> > > > the DT bindings grew organically over time based on newer platform
> > > > requirements.
> > > >
> > > > Now that we have a platform which does not want the time
> > > > C3STOP feature, we need to first come-up with DT bindings
> > > > to support this platform instead of temporarily disabling
> > > > features which don't work on this platform.
> > >
> > > It's the opposite surely? It should be "now that we have a platform that
> > > *does want* the C3STOP feature", right?
> >
> > Yes, we can think this way as well.
>
> No, there's no "thinking" involved here from what I can tell. Pre-D1
> systems do not seem to need the flag and the D1 does want that flag for
> its riscv,timer. We have to operate with respect to hardware timelines
> & the corresponding software implementations, not specs in this context.
>
> If it was the case that you proposed, there would be no chance for
> regressions if someone updates their kernel but not their DT.
>
> > > > > > With all due respect, NACK to this patch from my side.
> > >
> > > As Samuel pointed out that the D1 doesn't actually use the timer in
> > > question, I think we are okay here?
> >
> > Yes, that's why D1 needs the C3STOP flag.
>
> I don't understand what you mean here, you don't appear to be replying
> to what I said.
>
> I was saying that the current D1 configuration does not actually use
> the timer-riscv driver as there's another one that has a higher rating
> & therefore we are okay to not apply this patch as my revert will not
> cause it to be put into sleep states that it cannot return from.
>
> Your reply makes no sense to me in that context.

Sorry for the confusion, I should have written a more complete sentence.

D1 does not use the RISC-V timer but it still needs to set the C3STOP
flag to inform the timer subsystem that the RISC-V timer will not work
in suspend state.

Regards,
Anup
