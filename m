Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32F7634F64
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiKWFLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiKWFL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:11:29 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A3EEA103;
        Tue, 22 Nov 2022 21:11:28 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B39725C003D;
        Wed, 23 Nov 2022 00:11:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 23 Nov 2022 00:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669180285; x=
        1669266685; bh=eogm4ppMAc25OF3LnRI9k1TWSra/SrVN7IBRyFCgOQc=; b=Y
        xg+/ff25c/CXj8ksv96a00I815P3NxuythMmL3t0SDezXO01kjZ4MTbGr5eRz/rs
        syjmF3Ke2M2q/jR3DjYqDFo03XXGVViWaBUjmq7puXG6N+DxqF8529EzN+oVSOtT
        rDf+9C9hJUyDMKtcrY0HURjuA6+WTB8QCanW/syvD4+Yayemf/FlZY38ar+LtdKe
        dxXNLiGhrDWlgkHScbLzwPoHOfQPJI30I7Ouhn0nFyUJj+vNNQA00TV3W2Hr9/33
        PEmYzLD8G+1iiEXSeYqU7w6rA7lbq5seoOvwvssF3NoK3RchNHnxTElxEQv6bDa/
        8yg2UcKlfFuHLX74L2iBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669180285; x=
        1669266685; bh=eogm4ppMAc25OF3LnRI9k1TWSra/SrVN7IBRyFCgOQc=; b=l
        elf/BSfx3+Tfs4B595lO+jPOVPptIF09t6e1/BC4eMH5dUgji8QbBWLTQQEVVSsp
        zx3Dc2Sms1mDe5qTMbjZu/8RzT+TsUMNCZG9yZnCM10uoCT/6CmtsDgylHy8+CiD
        zWcZhMflDATtIKt6TEjVpOFC/7X2NvZkBW8P5jbcEkKd+94rlfWSmpo3DFdiqLEO
        6hTIuiIHM4MZPqNLS5R8QtBECu5DKvimCDZqljN8Zt9M5KEVQZ6S61NekZ0Ru2ps
        SeS53YhRlCfH6uqZtTkMkSZ5IaxbUgMfftlrdn4FXoZmYMjzPl2cCK6itXB77IEg
        kEf9qm/khbTfJa+pPuYjg==
X-ME-Sender: <xms:fat9Y0szua3jffDXHzt-r-jnV2R8zwihQ9R9kCWuepw7CPBFNAiv5w>
    <xme:fat9YxdVCve7d21aKqgKJAxI0WXdrwCVwYyGSsCxaOvX_fgN0JT8EfCKiC_LsP97g
    kfxa3os8WbWZWlVUw>
X-ME-Received: <xmr:fat9Y_w8bdJ2d9Jc3dVMXwis8oONz0Hfn146-DyWOxpM6fHMEM3wMUaYyHErdkHiXesxIzrudZnNUXfeK_31Kga6NzEGhF0rgmTQSoaiKlilQ7LwXXZG7QevHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedtgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdeitdejvdejveffveejffffjeekfefhgeehjeeijefgkedtfeeh
    leetfeekvdfgnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgr
    mhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:fat9Y3PLgMJFqtf_kQUKAJdFhAQGWhnnUd8cAc8-XOJGl5N6WrGs8A>
    <xmx:fat9Y0-25wtoUFaKCQJOVhAsrF-ECOH7mSVf1eKGw0ArMaEh4csWZw>
    <xmx:fat9Y_U1LlN_41gWZ-vcu-f8MJ24VM6OGl_xL2iBYqcPW8m4uJ3ZQg>
    <xmx:fat9Y_WvwQwLDZaXOg4UY7_1cB6mLKg8JzdF1e4ZLCUGfQ1Q3begiQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Nov 2022 00:11:24 -0500 (EST)
Message-ID: <57114829-c205-dece-abdb-1100947286d4@sholland.org>
Date:   Tue, 22 Nov 2022 23:11:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>, conor.dooley@microchip.com
Cc:     apatel@ventanamicro.com, anup@brainfault.org,
        Conor Dooley <conor@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
References: <mhng-6299f108-11af-4e70-9981-d7e7b3be0b9a@palmer-ri-x1c9>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
In-Reply-To: <mhng-6299f108-11af-4e70-9981-d7e7b3be0b9a@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 11/22/22 09:28, Palmer Dabbelt wrote:
> On Tue, 22 Nov 2022 03:19:43 PST (-0800), conor.dooley@microchip.com wrote:
>> On Tue, Nov 22, 2022 at 11:06:15AM +0530, Anup Patel wrote:
>>> On Tue, Nov 22, 2022 at 10:46 AM Palmer Dabbelt <palmer@rivosinc.com>
>>> wrote:
>>> >
>>> > On Mon, 21 Nov 2022 19:45:07 PST (-0800), anup@brainfault.org wrote:
>>> > > On Tue, Nov 22, 2022 at 2:27 AM Palmer Dabbelt
>>> <palmer@rivosinc.com> wrote:
>>> > >>
>>> > >> From: Palmer Dabbelt <palmer@rivosinc.com>
>>> > >>
>>> > >> As per [1], whether or not the core can wake up from non-retentive
>>> > >> suspend is a platform-specific detail.  We don't have any way to
>>> encode
>>> > >> that, so just stop using them until we've sorted that out.
>>> > >>
>>> > >> Link:
>>> https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
>>> > >> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
>>> > >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>> > >
>>> > > This is just unnecessary maintenance churn and it's not the
>>> > > right way to go. Better to fix this the right way instead of having
>>> > > a temporary fix.
>>> > >
>>> > > I had already sent-out a patch series 5 months back to describe
>>> > > this in DT:
>>> > >
>>> https://lore.kernel.org/lkml/20220727114302.302201-1-apatel@ventanamicro.com/
>>> > >
>>> > > No one has commented/suggested anything (except Samuel
>>> > > Holland and Sudeep Holla).
>>> >
>>> > I see some comments from Krzysztof here
>>> >
>>> <https://lore.kernel.org/lkml/7a0477a0-9f0f-87d6-4070-30321745f4cc@linaro.org/>
>>> > as well.  Looks like everyone is pointing out that having our CPU
>>> nodes
>>> > encode timers is a bad idea, my guess is that they're probably right.
>>>
>>> Adding a separate timer DT node, creates a new set of compatibility
>>> issues for existing platforms. I am fine updating my series to have
>>> separate timer DT node but do we want to go in this direction ?
>>
>> I don't really follow. How is there a compatibility issue created by
>> adding a new node that is not added for a new property? Both will
>> require changes to the device tree. (You need not reply here, I am going
>> to review the other thread, it's been on my todo list for too long. Been
>> caught up with non-coherent stuff & our sw release cycle..)
>>
>>> Even if ARM has a separate timer DT node, the timers are still part
>>> of the CPU. It depends on how we see the DT bindings aligning with
>>> actual HW.
>>>
>>> >
>>> > > Please review this series. I can quickly address comments to
>>> > > make this available for Linux-6.2. Until this series is merged,
>>> > > the affected platforms can simply remove non-retentive suspend
>>> > > states from their DT.
>>> >
>>> > That leaves us with a dependency between kernel versions and DT
>>> > bindings: kernels with the current driver will result in broken
>>> systems
>>> > with the non-retentive suspend states in the DT they boot with when
>>> > those states can't wake up the CPU.
>>
>> Can someone point me at a (non D1 or virt) system that has suspend
>> states in the DT that would need fixing?
>>
>>> This is not a new problem we are facing. Even in the ARM world,
>>> the DT bindings grew organically over time based on newer platform
>>> requirements.
>>>
>>> Now that we have a platform which does not want the time
>>> C3STOP feature, we need to first come-up with DT bindings
>>> to support this platform instead of temporarily disabling
>>> features which don't work on this platform.
>>
>> It's the opposite surely? It should be "now that we have a platform that
>> *does want* the C3STOP feature", right?
> 
> IMO we just shouldn't be turning on C3STOP at all.  Sure it's making the
> problem here go away, but it's trying to emulate a bunch of Intel timer
> features we don't have on RISC-V and ending up in a bunch of fallback
> paths.

While the comment in include/linux/clockchips.h and the name of the flag
imply that C3STOP is Intel-specific, it really isn't. The flag is used
on ARM, MIPS, and PowerPC as well.

However we do it, the end goal here is making tick_broadcast_enter()
return nonzero (when called from inside cpuidle_enter_state()), thus
inhibiting Linux from using idle states with the "local-timer-stop"
property set in the DT.

Looking down inside tick_broadcast_oneshot_control(), it appears
CLOCK_EVT_FEAT_C3STOP really is required to make this happen.

What are you referring to by "fallback paths"?

We could add another CLOCK_EVT_FEAT_??? flag, but how should it differ
from CLOCK_EVT_FEAT_C3STOP?

> If we need some workaround in the timer subsystem to sort out the
> non-retentive states then we can sort that out, but my guess is that
> vendors are just going to 3

(your message got cut off here)

>>> > > With all due respect, NACK to this patch from my side.
>>
>> As Samuel pointed out that the D1 doesn't actually use the timer in
>> question, I think we are okay here?
> 
> IIUC it just should use the sunxi timer driver, but that requires some
> priority changes (and presumably breaks

(and here too)

D1 currently uses sun4i_tick (rating 350) over riscv_timer_clockevent
(rating 100). The ratings are fine as is.

> That said, I guess I'm confused about what's actually broken here.  My
> understanding of the problem is: The D1's firmware disables some
> interrupts during non-retentive suspend, which results in SBI timers
> failing to wake up the core.

The D1's hardware cannot deliver the RISC-V architectural timer
interrupt while the C906 core is powered off. It cannot deliver the
RISC-V architectural external interrupt either, but the SoC provides a
side channel for all of the PLIC inputs, so they _can_ wake up the CPU.
So the net result is that the CLINT is the only peripheral unable to
wake the CPU.

> The patch to add C3STOP makes the core
> come back from sleep, but that results in a bunch of other timer-related
> issues.

No, C3STOP _inhibits_ Linux from entering idle states that both:
 1) rely on that clockevent device to wake the local CPU, and
 2) cause that clockevent device to stop working, as signified by the
    CPUIDLE_FLAG_TIMER_STOP flag, which is set by the local-timer-stop
    property in the idle state DT node.

That means entering the idle state is allowed if Linux can solve that
first condition by finding another clockevent device on some other CPU
to wake the local CPU with an IPI. That is the purpose of the broadcast
timer mechanism.

In the case of the D1, since it is single core, there is no other CPU to
broadcast a timer event. So if riscv_timer_clockevent is the only
clockevent device, then tick_broadcast_enter() should return nonzero,
and find_deepest_state() will pick a retentive idle state instead.

This is the already-existing mechanism for only entering idle states we
can reliably wake up from. :)

> So IMO we should revert the C3STOP patch as it's causing regressions

I agree that clearly something is going wrong in the Linux code to cause
problems on SMP systems like PolarFire. I do not really understand the
broadcast timer internals, but what I do know is:
 1) By setting CLOCK_EVT_FEAT_C3STOP, we inhibit the RISC-V timer from
    being used as the broadcast timer (tick_check_broadcast_device()),
    and IIUC fall back to kernel/time/tick-broadcast-hrtimer.c. Maybe
    something goes wrong there?
 2) The broadcast timer wakes up CPUs via IPIs. Maybe something goes
    wrong with IPI delivery? (This raises the question of if we need
    another DT property for receiving IPIs in non-retentive suspend.)

But neither of these should affect behavior when not using broadcast timers.

> (ie, old workloads break in order to make new ones work).  Seems like
> folks mostly agree on that one?

Well, for the D1 specifically, there is no new workload that the C3STOP
patch makes work. Non-retentive suspend worked there already, as I have
explained. The patch was always about being compliant to the spec.

> I also think we should stop entering non-retentive suspend until we can
> sort out how reliably wake up from it, as the SBI makes that a
> platform-specific detail.  If the answer there is "non-retentive suspend
> is fine on the D1 as long as we don't use the SBI timers" then that
> seems fine, we just need some way to describe that in Linux -- that
> doesn't fix other platforms and other interrupts, but at least it's a
> start.

We need some way to describe the situation from the SBI implementation
to Linux.

Non-retentive suspend is fine on the D1 as long as either one of these
conditions is met:
 1) we don't use the SBI timers, or
 2) the SBI timer implementation does not use the CLINT

And it is up to the SBI implementation which timer hardware it uses, so
the SBI implementation needs to patch this information in to the DT at
runtime.

Regards,
Samuel

