Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD61161067A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiJ0Xlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiJ0Xlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:41:52 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B7913D1B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:41:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 611015C0105;
        Thu, 27 Oct 2022 19:41:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 27 Oct 2022 19:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1666914107; x=
        1667000507; bh=G032cFkkJJwDvICoMjP1OrBVYRlJZIJ+SIsojS+9x8Q=; b=S
        5jJYcKgTkqxDorI3XYDq2oMfz9bR+58651vMVKwlzyS4yWoTbJxsOnYSDCVI73sB
        wQvfbs/vFp7iA199XA1pwKxEOuFXZLLxZzBd3c0I61Op3Ya8jw+Ugn2Vn5xylQZq
        h7kCUA1bWrcZs8s12YYsyBf/4s/frGfv5oqdT64Jlj8B44Dhfyh5EjCDkgKGCiEW
        ib6/6C0FqUfp2esRF6p7korNijLR4BNZ5nr5jRCrv+H3e3hD/+Zz1Dkmu3AOznxk
        PAlwhkh+DQSDzN4T8AKVPiAL6TbHNA7QDgyCnrQpqbWhUNZJfcnLAeIXk9rXAHkn
        TQ8tfivbwIGVyA/9g89wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666914107; x=
        1667000507; bh=G032cFkkJJwDvICoMjP1OrBVYRlJZIJ+SIsojS+9x8Q=; b=E
        AmnHEuKu/FUCuOG2z9q2ekXp6i2iG8VN6hMudQAzXXLMH2aPW+e0uNR5g4U1gbjH
        ysWCmfQ4YXnRpom9DEyIXtDF0eOTevVAmcRDl1D6srVQDIn+DZWWIsk7NA3acw/l
        G+AJp2p4e9mjCcYUMyEHKCbSe/0QgPl1LNm3vmqX7uHqHKQRaxs6Rf00A4U/mmDI
        NixaC7xiMAk8jqUseoLJOecl8FJfNOrl2ctTy/MG5sQslDjAv6KwdbFFD4MbQl7m
        Qr4OyBy4HENhvMUadfIib+kR4Ck7UtmQ8vIZscaqxBbR5SQs6SgkxosNbskMzQ5u
        spS3Qt309OJ3uPU1QptFw==
X-ME-Sender: <xms:OhdbY6UomKlVABQt-eI1xgvlNyFH69hAw4a725P67HwOu60ynWLQhw>
    <xme:OhdbY2moX8D7xf7EjDzvVt-p98FplufuRDm6Q_TI4EPExFUmwth0t0E3cfCc51B2Z
    BKMBzLfroIvG8O3uA>
X-ME-Received: <xmr:OxdbY-ZiNSBnwoGcyxk65_9E3U0aZKskLnfsLuK0kyGK8rGdqy5IuUEI6rsMIoxOv7sVRJcaIAv0poNunuqVjqJ1uznq0NmgWRUm-D2rKCYZy0CI6pHduAglaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdehgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdeitdejvdejveffveejffffjeekfefhgeehjeeijefgkedtfeeh
    leetfeekvdfgnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgr
    mhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:OxdbYxUsgZJ2zfi9Y-3eCr9zPk6Yx4FC0185ABMeDiOi_KptLEOCcw>
    <xmx:OxdbY0lnOoSyPaLv9kRehHVbyzWk50_VmCp8ZLKkRJegUkrwJw9M7w>
    <xmx:OxdbY2cs3MvAPoX19DikrrBu51LnXHBia1ZZNEkpUbW74d4FodUieA>
    <xmx:OxdbYxh8vSvPaMm2v8dHPQpIqKaAEiM1VJkaMWWRlExrtG9WmasSuw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Oct 2022 19:41:46 -0400 (EDT)
Message-ID: <40abce35-b8de-cd5c-f544-fcf344e7057c@sholland.org>
Date:   Thu, 27 Oct 2022 18:41:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, apatel@ventanamicro.com
Cc:     Conor Dooley <conor@kernel.org>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        dmitriy@oss-tech.org, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <mhng-298aa3f7-7054-4695-bcb6-89be226a786b@palmer-ri-x1c9a>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] clocksource/drivers/riscv: Events are stopped during CPU
 suspend
In-Reply-To: <mhng-298aa3f7-7054-4695-bcb6-89be226a786b@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 18:07, Palmer Dabbelt wrote:
> On Mon, 24 Oct 2022 01:04:55 PDT (-0700), apatel@ventanamicro.com wrote:
>> On Mon, Oct 24, 2022 at 10:31 AM Samuel Holland <samuel@sholland.org>
>> wrote:
>>>
>>> On 10/9/22 18:45, Palmer Dabbelt wrote:
>>> > On Thu, 29 Sep 2022 14:50:45 PDT (-0700), Conor Dooley wrote:
>>> >> On Sun, May 08, 2022 at 08:21:21PM -0500, Samuel Holland wrote:
>>> >>> Some implementations of the SBI time extension depend on hart-local
>>> >>> state (for example, CSRs) that are lost or hardware that is powered
>>> >>> down when a CPU is suspended. To be safe, the clockevents driver
>>> >>> cannot assume that timer IRQs will be received during CPU suspend.
>>> >>>
>>> >>> Fixes: 62b019436814 ("clocksource: new RISC-V SBI timer driver")
>>> >>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>> >>> ---
>>> >>>
>>> >>>  drivers/clocksource/timer-riscv.c | 2 +-
>>> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> >>>
>>> >>> diff --git a/drivers/clocksource/timer-riscv.c
>>> >>> b/drivers/clocksource/timer-riscv.c
>>> >>> index 1767f8bf2013..593d5a957b69 100644
>>> >>> --- a/drivers/clocksource/timer-riscv.c
>>> >>> +++ b/drivers/clocksource/timer-riscv.c
>>> >>> @@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long
>>> delta,
>>> >>>  static unsigned int riscv_clock_event_irq;
>>> >>>  static DEFINE_PER_CPU(struct clock_event_device,
>>> riscv_clock_event) = {
>>> >>>      .name            = "riscv_timer_clockevent",
>>> >>> -    .features        = CLOCK_EVT_FEAT_ONESHOT,
>>> >>> +    .features        = CLOCK_EVT_FEAT_ONESHOT |
>>> CLOCK_EVT_FEAT_C3STOP,
>>> >
>>> > This is listed as being x86-specific in the header, but there's a
>>> hanful
>>> > of other ports that enable it for timers as well.  Looks like arm is
>>> > setting this based on DT, which seems reasonable to me: we're working
>>> > around a firmware bug, there should be some way to turn off that
>>> > workaround for firmware that doesn't have the bug. Looks like Intel
>>> already
>>> > turns this off when ARAT is supported, which seems to be the case for
>>> > anything modern, so maybe we're just tripping up on some untested
>>> behavior here?
>>> > I'm not sure exactly how we should probe this, but having it only
>>> enabled
>>> > when we need the workaround seems like the right way to go.
>>>
>>> I opened an issue against the SBI spec about what exactly it requires,
>>> but I got no responses:
>>>
>>> https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98
>>>
>>> My interpretation of the SBI specification is that it does not require
>>> maintaining any hart-local state across a non-retentive hart suspend.
>>> Unless the SBI spec says the timer must fire during/after suspend, then
>>> there is no firmware bug.
> 
> IMO this is a grey area in the spec: it says both "The hart will
> automatically come out of suspended state and resume normal execution
> when it receives an interrupt or platform specific hardware event." but
> "sstatus.SIE = 0" on resume.  It's not clear _when_ "sstatus.SIE" must
> take the value 0 (ie, is it before sleeping or after taking up) and if
> "receives an interrupt" means _any_ interrupt, or just enabled interrupts.
> 
> I agree we can't say it's a firmware bug, though.  There's certainly
> some reading of the spec that allows for this -- even if there wasn't
> we'd still have to live with whatever the firmware does, but here I
> think it's just a Linux bug.
> 
>> SBI spec only defines the mechanism to enter HART suspend state. All
>> other details (such as timer interrupt firing during/after suspend)
>> are platform
>> or implementation specific which needs to be discovered from DT/ACPI.
> 
> From that bug it sounds like it's really platform-specific whether or
> not it's possible to wake up from non-retentive suspend, so maybe we
> should just add some sort of DT node that says "non-retentive suspend
> works" and then only use it on those systems?

No, this isn't about whether non-retentive suspend works generally. The
only behavior in question is specifically whether or not the _SBI timer
extension_ can wake from non-retentive suspend.

For example, on Allwinner D1, all PLIC inputs can wake from
non-retentive suspend. This includes several MMIO timers. But notably it
does not include the CLINT. And the CLINT is what OpenSBI chooses as the
backend for the SBI timer extension.

You could make an argument that OpenSBI should use one of those other
MMIO timers, and then the C3STOP flag would not be needed, but the SBI
spec does not _require_ doing this.

And (in the absence of a DT/ACPI property declaring otherwise), the
driver can only rely on what the standard requires.

>>> > That said, I'm not actually sure this C3STOP feature does what we want
>>> > given the commit description.  The timers on RISC-V are sort of in
>>> this
>>> > odd middle-ground between being per-CPU timers and system timers: the
>>> > time they produce is global (or at least close, due to the mtime
>>> > synchronization rules) but the actual interrupts are only one-shot and
>>> > only local.
>>>
>>> And if we cannot rely on the interrupt being delivered, we cannot rely
>>> on the SBI time extension to work across cpuidle entry.
>>
>> Just like ARM, we need a DT property to discover this platform specific
>> behaviour.
>>
>> I had sent out a small series to do this for DT.
>> Refer, "[PATCH v2 0/2] Improve CLOCK_EVT_FEAT_C3STOP feature setting"
>> https://lore.kernel.org/all/20220727114302.302201-1-apatel@ventanamicro.com/

This is a reasonable solution for me, if we can agree on the binding.

> I broadly agree with the "we should split out the timer node" stuff
> there.  It used to be part of the core, but it's not any more.  Looks
> like that was the hangup, though I'm not sure setting C3STOP is even the
> right fix any more...
> 
>>> > From poking around the code I think this just tries to
>>> > setup a periodic broadcast timer, but since we use software
>>> fallbacks to
>>> > emulate those we'll still end up losing the interrupts/ticks if the
>>> CPU
>>> > that was asked for an interrupt has gone to sleep and lost that state.
>>>
>>> So by extension, non-retentive cpuidle states cannot be used if the SBI
>>> timer is the only available timer, since there is no hardware broadcast
>>> timer to use as a backup.
>>>
>>> > I'm not sure if I'm just misunderstanding what's going on here,
>>> though.
>>> > Is there something that describes the behavior this fixes in more
>>> detail?
>>>
>>> The motivating scenario for this patch is the C906, where the MTIMER is
>>> in the same reset domain as the CPU, so the timer state is lost during
>>> non-retentive suspend. Without this patch, if riscv_timer_clockevent is
>>> the current clockevent driver, then the CPU fails to wake up from
>>> suspend. However, this same problem would occur on any CPU where the
>>> timer or interrupt delivery stops working during suspend.
>>
>> Yes, I recall CLOCK_EVT_FEAT_C3STOP was added for C906 but
>> we should go the DT/ACPI route.
> 
> I agree, though I think this should disable non-retentive suspend as
> opposed to setting C3STOP.

Please see above. Disabling non-retentive suspend is a much bigger
hammer than needed.

>> Regards,
>> Anup
>>
>>>
>>> >>>      .rating            = 100,
>>> >>>      .set_next_event        = riscv_clock_next_event,
>>> >>>  };
>>> >>
>>> >> After a bit of a painful bisection (with a misdirection into the
>>> v5.19
>>> >> printk reverts along the way) I have arrived at this commit for
>>> causing
>>> >> me some issues.
>>> >>
>>> >> If an AXI read to the PCIe controller on PolarFire SoC times out, the
>>> >> system will stall, with an expected:
>>> >>      io scheduler mq-deadline registered
>>> >>      io scheduler kyber registered
>>> >>      microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000
>>> >> ranges:
>>> >>      microchip-pcie 2000000000.pcie:      MEM
>>> >> 0x2008000000..0x2087ffffff -> 0x0008000000
>>> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: axi read request error
>>> >>      microchip-pcie 2000000000.pcie: axi read timeout
>>> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>      Freeing initrd memory: 7336K
>>> >>      mc_event_handler: 667402 callbacks suppressed
>>> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>      mc_event_handler: 666588 callbacks suppressed
>>> >> <truncated>
>>> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>     mc_event_handler: 666748 callbacks suppressed
>>> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>     rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>> >>     rcu:     0-...0: (1 GPs behind) idle=19f/1/0x4000000000000002
>>> >> softirq=34/36 fqs=2626
>>> >>         (detected by 1, t=5256 jiffies, g=-1151, q=1143 ncpus=4)
>>> >>     Task dump for CPU 0:
>>> >>     task:swapper/0       state:R  running task     stack:    0 pid:
>>> >> 1 ppid:     0 flags:0x00000008
>>> >>     Call Trace:
>>> >>     mc_event_handler: 666648 callbacks suppressed
>>> >>
>>> >>  With this patch applied, the system just locks up without RCU
>>> stalling:
>>> >>     io scheduler mq-deadline registered
>>> >>     io scheduler kyber registered
>>> >>     microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000
>>> >> ranges:
>>> >>     microchip-pcie 2000000000.pcie:      MEM
>>> >> 0x2008000000..0x2087ffffff -> 0x0008000000
>>> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: axi read request error
>>> >>     microchip-pcie 2000000000.pcie: axi read timeout
>>> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
>>> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
>>> >>     Freeing initrd memory: 7332K
>>> >>
>>> >> As of yet, I have no idea if RCU stalls for other reasons would
>>> also be
>>> >> lost.
>>> >
>>> > Sorry this broke stuff.  I'm not entirely sure why this would mask RCU
>>> > stalls, but it seems like we're hitting some pretty odd paths here and
>>> > I'm not sure this is expected to work at all for us.
>>>
>>> I'm confused here. The RCU stall is itself a bug, right? Are you sure
>>> this patch is wrongly masking the stall, or is it possibly just avoiding
>>> some buggy code and not causing a stall in the first place?

I still don't see why you consider this patch to have broken anything.
Can anyone explain why getting an RCU stall is better than not getting one?

Regards,
Samuel

