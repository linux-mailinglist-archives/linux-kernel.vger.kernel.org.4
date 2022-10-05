Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E165F4D73
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJEBko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJEBkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB452E5E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 18:40:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04C6F6155D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 01:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D213C433D7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 01:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664934039;
        bh=AYSIVwEdNy1glkHrJeNNQG08+BjgSYA2Cbajk+8RM2E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cDUhXGiUKrf/fcsddz/KouKI91TCsGKInNLeYl3ellL9Pi/6E3JDh5eTmEjTXnCbr
         9ICkXqsVH7XmV6aRJX77prtklSGppKN2d+H7PKFwyWeOOJNJO0I2i24ltuC1bEc/7q
         Q+5VzuuD7p/tGNpE4b3s9HEDybhyFNhwzSRg9dmnNKVkefKKiMBd7i6J5dXdA99vnQ
         Iiln/0GzjOwbUPE4FyqY6yVuOrMC1BVGV+vyxjfQF+FFEof8NSU8VBZzU8bqIfAMQ5
         2YdnvxEmFBqDSkERD+hTQ6/JRmD7k77LGSbnKxnLu1ZA8dROs5vy0EQEVgYsy+sZjk
         V6QVFFKySwnVg==
Received: by mail-oo1-f54.google.com with SMTP id g2-20020a4ac4c2000000b0047f703cbe86so1164023ooq.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 18:40:39 -0700 (PDT)
X-Gm-Message-State: ACrzQf1xm/ZyUZhEY6YCUP4LLS8uJk9vlKmoGh5C78I+yahBO4pcC7Su
        FdAez/G7MsSyte1Ylt5arxO6w89rlsXWftBMZ9s=
X-Google-Smtp-Source: AMsMyM4imQwX4AX/ulfzcBFvYU9a0D6GdxphaODPFoU1Cgjq+Aps0ruSEbQFvK/pMmlvSGspZMoaSCoyAq1pXyKMe58=
X-Received: by 2002:a9d:70c3:0:b0:65c:55fb:a153 with SMTP id
 w3-20020a9d70c3000000b0065c55fba153mr10641382otj.308.1664934038435; Tue, 04
 Oct 2022 18:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220922060958.44203-1-samuel@sholland.org> <2546376.ElGaqSPkdT@phil>
 <2E96A836-764D-4D07-AB79-3861B9CC2B1F@jrtc27.com> <13396584.uLZWGnKmhe@phil>
 <CAOnJCUKdBpbj=KDz5oibB_N_SjOiMrkWcttczuGbisi_nMWaVA@mail.gmail.com>
 <Yy+Plxzj4bckXrhy@spud> <CAOnJCU+fA-pxLPRviqW2d7q-E__qJYkZKkCdiNHXhJBjWCRPaA@mail.gmail.com>
 <YzS5kT2CCBPxqLg+@spud> <CAOnJCUKn-rNwyw5BK7=hNM-vnJ=VROjipCiDtB4BL=LZ3kKAAg@mail.gmail.com>
 <YzifTW5Y7O191gCo@spud> <CAOnJCUKtoiXKaS81BZyvpybFDkh-undHLqE5ZxoNmf9AtAtvfw@mail.gmail.com>
 <E5A6B840-A306-48E8-A60F-1D852B0639D6@jrtc27.com> <CAJF2gTSwm9UkbvKpWuPTPyNQhApJivwwfJ_A9YA6WoC4HNsxbg@mail.gmail.com>
 <1CECF1C3-6FA1-49CC-8A7A-1E18E401B88B@jrtc27.com>
In-Reply-To: <1CECF1C3-6FA1-49CC-8A7A-1E18E401B88B@jrtc27.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 5 Oct 2022 09:40:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTMJqpYdm4ebnBp8df0HfQSD0RBK5xNVa=mQbq0djBrYQ@mail.gmail.com>
Message-ID: <CAJF2gTTMJqpYdm4ebnBp8df0HfQSD0RBK5xNVa=mQbq0djBrYQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>, Dao Lu <daolu@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

,

On Wed, Oct 5, 2022 at 9:01 AM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 5 Oct 2022, at 01:38, Guo Ren <guoren@kernel.org> wrote:
> >
> > On Wed, Oct 5, 2022 at 1:24 AM Jessica Clarke <jrtc27@jrtc27.com> wrote=
:
> >>
> >> On 4 Oct 2022, at 17:52, Atish Patra <atishp@atishpatra.org> wrote:
> >>>
> >>> On Sat, Oct 1, 2022 at 1:13 PM Conor Dooley <conor@kernel.org> wrote:
> >>>>
> >>>> On Wed, Sep 28, 2022 at 08:26:01PM -0700, Atish Patra wrote:
> >>>>> On Wed, Sep 28, 2022 at 2:16 PM Conor Dooley <conor@kernel.org> wro=
te:
> >>>>>>
> >>>>>> On Wed, Sep 28, 2022 at 12:21:55AM -0700, Atish Patra wrote:
> >>>>>>> On Sat, Sep 24, 2022 at 4:15 PM Conor Dooley <conor@kernel.org> w=
rote:
> >>>>>>>>
> >>>>>>>> On Fri, Sep 23, 2022 at 11:01:28AM -0700, Atish Patra wrote:
> >>>>>>>>> On Fri, Sep 23, 2022 at 12:18 AM Heiko Stuebner <heiko@sntech.d=
e> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> Am Donnerstag, 22. September 2022, 17:52:46 CEST schrieb Jessi=
ca Clarke:
> >>>>>>>>>>> On 22 Sept 2022, at 16:45, Heiko Stuebner <heiko@sntech.de> w=
rote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> Am Donnerstag, 22. September 2022, 08:09:58 CEST schrieb Sam=
uel Holland:
> >>>>>>>>>>>>> commit 8eb060e10185 ("arch/riscv: add Zihintpause support")=
 broke
> >>>>>>>>>>>>> building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc 11.1=
.0):
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> CC arch/riscv/kernel/vdso/vgettimeofday.o
> >>>>>>>>>>>>> In file included from <command-line>:
> >>>>>>>>>>>>> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_rel=
ax':
> >>>>>>>>>>>>> ././include/linux/compiler_types.h:285:33: warning: 'asm' o=
perand 0 probably does not match constraints
> >>>>>>>>>>>>> 285 | #define asm_volatile_goto(x...) asm goto(x)
> >>>>>>>>>>>>> | ^~~
> >>>>>>>>>>>>> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expans=
ion of macro 'asm_volatile_goto'
> >>>>>>>>>>>>> 41 | asm_volatile_goto(
> >>>>>>>>>>>>> | ^~~~~~~~~~~~~~~~~
> >>>>>>>>>>>>> ././include/linux/compiler_types.h:285:33: error: impossibl=
e constraint in 'asm'
> >>>>>>>>>>>>> 285 | #define asm_volatile_goto(x...) asm goto(x)
> >>>>>>>>>>>>> | ^~~
> >>>>>>>>>>>>> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expans=
ion of macro 'asm_volatile_goto'
> >>>>>>>>>>>>> 41 | asm_volatile_goto(
> >>>>>>>>>>>>> | ^~~~~~~~~~~~~~~~~
> >>>>>>>>>>>>> make[1]: *** [scripts/Makefile.build:249: arch/riscv/kernel=
/vdso/vgettimeofday.o] Error 1
> >>>>>>>>>>>>> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Having a static branch in cpu_relax() is problematic becaus=
e that
> >>>>>>>>>>>>> function is widely inlined, including in some quite complex=
 functions
> >>>>>>>>>>>>> like in the VDSO. A quick measurement shows this static bra=
nch is
> >>>>>>>>>>>>> responsible by itself for around 40% of the jump table.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Drop the static branch, which ends up being the same number=
 of
> >>>>>>>>>>>>> instructions anyway. If Zihintpause is supported, we trade =
the nop from
> >>>>>>>>>>>>> the static branch for a div. If Zihintpause is unsupported,=
 we trade the
> >>>>>>>>>>>>> jump from the static branch for (what gets interpreted as) =
a nop.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
> >>>>>>>>>>>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >>>>>>>>>>>>> ---
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> arch/riscv/include/asm/hwcap.h | 3 ---
> >>>>>>>>>>>>> arch/riscv/include/asm/vdso/processor.h | 25 ++++++++++----=
-----------
> >>>>>>>>>>>>> 2 files changed, 10 insertions(+), 18 deletions(-)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/in=
clude/asm/hwcap.h
> >>>>>>>>>>>>> index 6f59ec64175e..b21d46e68386 100644
> >>>>>>>>>>>>> --- a/arch/riscv/include/asm/hwcap.h
> >>>>>>>>>>>>> +++ b/arch/riscv/include/asm/hwcap.h
> >>>>>>>>>>>>> @@ -68,7 +68,6 @@ enum riscv_isa_ext_id {
> >>>>>>>>>>>>> */
> >>>>>>>>>>>>> enum riscv_isa_ext_key {
> >>>>>>>>>>>>> RISCV_ISA_EXT_KEY_FPU, /* For 'F' and 'D' */
> >>>>>>>>>>>>> - RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
> >>>>>>>>>>>>> RISCV_ISA_EXT_KEY_MAX,
> >>>>>>>>>>>>> };
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> @@ -88,8 +87,6 @@ static __always_inline int riscv_isa_ext2=
key(int num)
> >>>>>>>>>>>>> return RISCV_ISA_EXT_KEY_FPU;
> >>>>>>>>>>>>> case RISCV_ISA_EXT_d:
> >>>>>>>>>>>>> return RISCV_ISA_EXT_KEY_FPU;
> >>>>>>>>>>>>> - case RISCV_ISA_EXT_ZIHINTPAUSE:
> >>>>>>>>>>>>> - return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
> >>>>>>>>>>>>> default:
> >>>>>>>>>>>>> return -EINVAL;
> >>>>>>>>>>>>> }
> >>>>>>>>>>>>> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch=
/riscv/include/asm/vdso/processor.h
> >>>>>>>>>>>>> index 1e4f8b4aef79..789bdb8211a2 100644
> >>>>>>>>>>>>> --- a/arch/riscv/include/asm/vdso/processor.h
> >>>>>>>>>>>>> +++ b/arch/riscv/include/asm/vdso/processor.h
> >>>>>>>>>>>>> @@ -4,30 +4,25 @@
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> #ifndef __ASSEMBLY__
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> -#include <linux/jump_label.h>
> >>>>>>>>>>>>> #include <asm/barrier.h>
> >>>>>>>>>>>>> -#include <asm/hwcap.h>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> static inline void cpu_relax(void)
> >>>>>>>>>>>>> {
> >>>>>>>>>>>>> - if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_E=
XT_KEY_ZIHINTPAUSE])) {
> >>>>>>>>>>>>> #ifdef __riscv_muldiv
> >>>>>>>>>>>>> - int dummy;
> >>>>>>>>>>>>> - /* In lieu of a halt instruction, induce a long-latency s=
tall. */
> >>>>>>>>>>>>> - __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy)=
);
> >>>>>>>>>>>>> + int dummy;
> >>>>>>>>>>>>> + /* In lieu of a halt instruction, induce a long-latency s=
tall. */
> >>>>>>>>>>>>> + __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy)=
);
> >>>>>>>>>>>>> #endif
> >>>>>>>>>>>>> - } else {
> >>>>>>>>>>>>> - /*
> >>>>>>>>>>>>> - * Reduce instruction retirement.
> >>>>>>>>>>>>> - * This assumes the PC changes.
> >>>>>>>>>>>>> - */
> >>>>>>>>>>>>> + /*
> >>>>>>>>>>>>> + * Reduce instruction retirement.
> >>>>>>>>>>>>> + * This assumes the PC changes.
> >>>>>>>>>>>>> + */
> >>>>>>>>>>>>> #ifdef __riscv_zihintpause
> >>>>>>>>>>>>> - __asm__ __volatile__ ("pause");
> >>>>>>>>>>>>> + __asm__ __volatile__ ("pause");
> >>>>>>>>>>>>> #else
> >>>>>>>>>>>>> - /* Encoding of the pause instruction */
> >>>>>>>>>>>>> - __asm__ __volatile__ (".4byte 0x100000F");
> >>>>>>>>>>>>> + /* Encoding of the pause instruction */
> >>>>>>>>>>>>> + __asm__ __volatile__ (".4byte 0x100000F");
> >>>>>>>>>>>>> #endif
> >>>>>>>>>>>>
> >>>>>>>>>>>> hmm, though before this part of the code was only ever acces=
sed
> >>>>>>>>>>>> when the zhintpause extension was really available on the ru=
nning
> >>>>>>>>>>>> machine while now the pause instruction is called every time=
.
> >>>>>>>>>>>>
> >>>>>>>>>>>> So I'm just wondering, can't this run into some "illegal ins=
truction"
> >>>>>>>>>>>> thingy on machines not supporting the extension?
> >>>>>>>>>>>
> >>>>>>>>>>> No. The encoding for pause was deliberately chosen to be one =
of the
> >>>>>>>>>>> =E2=80=9Cuseless=E2=80=9D encodings of fence, with the hope t=
hat existing
> >>>>>>>>>>> microarchitectures might take a while to execute it and thus =
it would
> >>>>>>>>>>> still function as a slow-running instruction. It=E2=80=99s so=
mewhat
> >>>>>>>>>>> questionable whether the div is even needed, the worst that h=
appens is
> >>>>>>>>>>> cpu_relax isn=E2=80=99t very relaxed and you spin a bit faste=
r. Any
> >>>>>>>>>>> implementations where that=E2=80=99s true probably also don=
=E2=80=99t have fancy
> >>>>>>>>>>> clock/power management anyway, and div isn=E2=80=99t going to=
 be a low-power
> >>>>>>>>>>> operation so the only real effect is likely hammering on cont=
ended
> >>>>>>>>>>> atomics a bit more, and who cares about that on the low core =
count
> >>>>>>>>>>> systems we have today.
> >>>>>>>>>>
> >>>>>>>>>> thanks a lot for that explanation, which made things a lot cle=
arer.
> >>>>>>>>>>
> >>>>>>>>>> So as you said, dropping the div part might make the function =
even smaller,
> >>>>>>>>>> though somehow part of me would want to add some sort of comme=
nt to
> >>>>>>>>>> the function for when the next developer stumbles over the unc=
onditional
> >>>>>>>>>> use of pause :-) .
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> I agree. If that's what microarch will do, we can drop div alto=
gether.
> >>>>>>>>> Though microarch may be treated as nop even if it is undesirabl=
e.
> >>>>>>>>> IIRC, the div was introduced for the rocket chip which would in=
duce a
> >>>>>>>>> long latency stall with div instruction (zero as operands).
> >>>>>>>>>
> >>>>>>>>> Does any other core or newer rocket chip actually induce a late=
ncy
> >>>>>>>>> stall with div instruction ?
> >>>>>>>>> If not, it is equivalent to NOP as well. We can definitely remo=
ve the div.
> >>>>>>>>> The only cores affected will be the older rocket core.
> >>>>>>>>>
> >>>>>>>>> Tagging some folks to understand what their core does.
> >>>>>>>>>
> >>>>>>>>> @Paul Walmsley @Guo Ren @Conor Dooley ?
> >>>>>>>>
> >>>>>>>> I am no microarch expert by _any_ stretch of the imagination, bu=
t
> >>>>>>>> from a quick experiment it looks like the u54s on PolarFire SoC =
behave
> >>>>>>>> in the same way, and div w/ zero operands does in fact take sign=
ificantly
> >>>>>>>> longer than regular division (looks to be about 3x).
> >>>>>>>>
> >>>>>>>
> >>>>>>> Thanks. Do you have any data on how much the "pause" instruction =
takes.
> >>>>>>
> >>>>>> So these numbers you may consider as being pulled out of a magic h=
at
> >>>>>> as all I am doing is reading the counters from userspace and there=
 is
> >>>>>> some variance etc. Plus the fact that I just started hacking at so=
me
> >>>>>> existing code I had lying around as I'm pretty snowed under at the
> >>>>>> moment.
> >>>>>>
> >>>>>> Doing the following takes about 70 cycles on both a PolarFire SoC =
and an
> >>>>>> unmatched:
> >>>>>> long divisor =3D 2, dividend =3D 100000, dest;
> >>>>>> asm("div %0, zero, zero" : "=3Dr" (dest));
> >>>>>> and equates to:
> >>>>>> sd a5,-48(s0)
> >>>>>> div a5,zero,zero
> >>>>>>
> >>>>>> Clocking in at about 40 cycles is some actual divisions, I just di=
d the
> >>>>>> following a dozen times, doing a trivial computation:
> >>>>>> long divisor =3D 2, dividend =3D 100000, dest;
> >>>>>> asm("div %0, %1, %2" : "=3Dr" (dividend) : "r" (dividend), "r" (di=
visor))
> >>>>>>
> >>>>>> ie, a load of the following:
> >>>>>> sd a5,-48(s0)
> >>>>>> ld a5,-48(s0)
> >>>>>> ld a4,-40(s0)
> >>>>>> div a5,a5,a4
> >>>>>>
> >>>>>> So clearly the div w/ zero args makes a difference...
> >>>>>>
> >>>>>> On PolarFire SoC, `0x100000F` takes approx 6 cycles. On my unmatch=
ed, it
> >>>>>> takes approx 40. Again, I just had an asm block & called the instr=
uction
> >>>>>> a number times and took the average - here it was 48 times.
> >>>>>>
> >>>>>> Take the actual numbers with a fist full of salt, but at least the
> >>>>>> relative numbers should be of some use to you.
> >>>>>>
> >>>>>> Hope that's somewhat helpful, maybe next week I can do something a
> >>>>>> little more useful for you...
> >>>>>>
> >>>>>
> >>>>> Thanks. It would be good to understand what happens when "pause" is
> >>>>> executed on these boards ?
> >>>>
> >>>> The actual pause instruction? uhh, so with the usual "I don't know w=
hat
> >>>> I am doing" disclaimer, I ran each of the .insn and pause instructio=
n 48
> >>>> times in a row and checked the time elapsed via rdcycle & then ran t=
hat
> >>>> c program 1000 times in a bash loop. Got the below, the insns were r=
un
> >>>> first and then the pauses.
> >>>> insn pause
> >>>> min 2.3 3.2
> >>>> max 9.5 10.6
> >>>> avg 27.0 29.1
> >>>> 5% 2.9 4.2
> >>>> 95% 18.1 19.1
> >>>>
> >>>> Swapping the pause & insn order around made a minor difference, but =
not
> >>>> enough to report on. I'd be very wary of drawing any real conclusion=
s
> >>>> from this data, but at least both are roughly similar (and certainly=
 not
> >>>> even close to doing the div w/ zero args.
> >>>>
> >>>
> >>> Yeah. That's what I was expecting. So we can't drop the div for now. =
Otherwise,
> >>> the existing hardware(don't support Zhintpause) suffers by spinning f=
aster.
> >>
> >> But does that actually matter in practice? If it doesn=E2=80=99t notic=
eable
> >> affect performance then you don=E2=80=99t need to keep the div. There =
are a lot
> >> of architectures that even just define cpu_relax() as barrier().
> > Div is not semantic accurate for standard code, it should be in
> > vendors' errata. I agree to leave nop as default and put a pause
> > instead after the feature is detected.
>
> Nobody=E2=80=99s suggesting a literal nop instruction, that would be wors=
e than
> either div or pause. It=E2=80=99s always safe to execute pause, the quest=
ion is
> just whether on existing systems that don=E2=80=99t implement Zihintpause=
 it
> gets executed too quickly such that performance is degraded due to
> spinning more aggressively.
Why do you ensure pause can't be an illegal instruction in some old machine=
?
Why do you ensure div could save power for all microarchitectures?

nop (default) -> div/<other instructions> (moved into vendor errata)
-> pause (when ZiHintPause feature detected)

>
> Jess
>
> >>
> >> Jess
> >>
> >>> Thanks for running the experiments.
> >>>
> >>>> Again, hope that is helpful?
> >>>> Conor.
> >>>>
> >>>>>
> >>>>>> Conor.
> >>>>>>
> >>>>>>> I understand that it is not available in these cores. Just wanted=
 to
> >>>>>>> understand if microarchitecture
> >>>>>>> actually takes a while executing the useless encoding as pointed =
out by Jessica.
> >>>>>>>
> >>>>>>> If that's the case, we can remove the div instruction altogether.
> >>>>>>> Otherwise, this patch will cause some performance regression
> >>>>>>> for existing SoC (HiFive unleashed has the same core. Not sure ab=
out
> >>>>>>> unmatched though).
> >>>>>>> This needs to be documented at least.
> >>>>>>>
> >>>>>>>> Hope that's helpful,
> >>>>>>>> Conor.
> >>>>>>>>
> >>>>>>>> (I just did a quick check of what pretty much amounted to a bunc=
h of
> >>>>>>>> div a5,zero,zero in a row versus div a5,a5,a5)
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> (Please add anybody who may have an insight to execution flow o=
n
> >>>>>>>>> existing Linux capable cores)
> >>>>>>>>>
> >>>>
> >>>
> >>>
> >>> --
> >>> Regards,
> >>> Atish
> >>
> >
> >
> > --
> > Best Regards
> > Guo Ren
>


--=20
Best Regards
 Guo Ren
