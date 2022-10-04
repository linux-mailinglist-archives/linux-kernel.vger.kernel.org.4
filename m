Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58E75F47ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJDQxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiJDQxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:53:00 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D9761D43
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:52:53 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 64so10939500iov.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=aL8/4ylSjV3Io61UyQHDzJVYJowHqQccVNJUkp8FKTA=;
        b=IxH0+pXO2P+MqGRVz/H7WJvP1HbIYYkyYZB7irh5VJWizkxIF0h2eCuMjGieGIQcpw
         bw+rh1bB7dg/Qb0tLHZI0ytYW/OdFb90hOJ5RV3ScOgtCvjIx1Om3qhTA9jTlb8mLJIn
         5wegarRoGZr9QykFqElvNQTG+bI/Zk4qK0SRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aL8/4ylSjV3Io61UyQHDzJVYJowHqQccVNJUkp8FKTA=;
        b=2m42uVcxlNlm4TxiPVhxMiYtOtmsQmDv6KCjPjwytvaOp86t02uA431rmTd/z2Qn1S
         IFUNwq3CpnKG7jRZ6ZlhtRBZq6OgdHkogV5i/oheq20zcvC/C8mCnBfyT6eLVJCrmaMf
         2Bp+hD1Fx/2Ws1TilQ1LHjIi6J2SOpNrXLiRjE9TDdOzm9KuPTkj2FeuXbqQmEA8hknZ
         unntsDLCuUrjk1phrZ0WvX41ZAjwFy9UqJPs6hustQmp/3e9rJdewqHM2FxgaHqRoI9/
         bbjsgxnpDRUzwUYl8/3p1G+VdxqDbnvBW957HSJsjLbx201HOhE28/q0dqDIbNPWrvAC
         jJjw==
X-Gm-Message-State: ACrzQf06SJBDgtrbo+Jwss86UadoyaUr9TFTqQ5OIeUIdK5k8JxCt06a
        x2o9MI5iT0mizTGFvmh6iv7CZcyyGBWj0QyqILmQ
X-Google-Smtp-Source: AMsMyM7Se3DtSE/Wc78Mgi1W24wHma1rEzIygfvq5CSAN0hIoOqVJTWEmAy3qbs1+OkRh69n+prSHYSRiOf6FLzwjgM=
X-Received: by 2002:a05:6638:2046:b0:35a:ce4a:13a2 with SMTP id
 t6-20020a056638204600b0035ace4a13a2mr13386625jaj.164.1664902372592; Tue, 04
 Oct 2022 09:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220922060958.44203-1-samuel@sholland.org> <2546376.ElGaqSPkdT@phil>
 <2E96A836-764D-4D07-AB79-3861B9CC2B1F@jrtc27.com> <13396584.uLZWGnKmhe@phil>
 <CAOnJCUKdBpbj=KDz5oibB_N_SjOiMrkWcttczuGbisi_nMWaVA@mail.gmail.com>
 <Yy+Plxzj4bckXrhy@spud> <CAOnJCU+fA-pxLPRviqW2d7q-E__qJYkZKkCdiNHXhJBjWCRPaA@mail.gmail.com>
 <YzS5kT2CCBPxqLg+@spud> <CAOnJCUKn-rNwyw5BK7=hNM-vnJ=VROjipCiDtB4BL=LZ3kKAAg@mail.gmail.com>
 <YzifTW5Y7O191gCo@spud>
In-Reply-To: <YzifTW5Y7O191gCo@spud>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 4 Oct 2022 09:52:41 -0700
Message-ID: <CAOnJCUKtoiXKaS81BZyvpybFDkh-undHLqE5ZxoNmf9AtAtvfw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
To:     Conor Dooley <conor@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>, Dao Lu <daolu@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 1, 2022 at 1:13 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Wed, Sep 28, 2022 at 08:26:01PM -0700, Atish Patra wrote:
> > On Wed, Sep 28, 2022 at 2:16 PM Conor Dooley <conor@kernel.org> wrote:
> > >
> > > On Wed, Sep 28, 2022 at 12:21:55AM -0700, Atish Patra wrote:
> > > > On Sat, Sep 24, 2022 at 4:15 PM Conor Dooley <conor@kernel.org> wro=
te:
> > > > >
> > > > > On Fri, Sep 23, 2022 at 11:01:28AM -0700, Atish Patra wrote:
> > > > > > On Fri, Sep 23, 2022 at 12:18 AM Heiko Stuebner <heiko@sntech.d=
e> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > Am Donnerstag, 22. September 2022, 17:52:46 CEST schrieb Jess=
ica Clarke:
> > > > > > > > On 22 Sept 2022, at 16:45, Heiko Stuebner <heiko@sntech.de>=
 wrote:
> > > > > > > > >
> > > > > > > > > Am Donnerstag, 22. September 2022, 08:09:58 CEST schrieb =
Samuel Holland:
> > > > > > > > >> commit 8eb060e10185 ("arch/riscv: add Zihintpause suppor=
t") broke
> > > > > > > > >> building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc 1=
1.1.0):
> > > > > > > > >>
> > > > > > > > >> CC arch/riscv/kernel/vdso/vgettimeofday.o
> > > > > > > > >> In file included from <command-line>:
> > > > > > > > >> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_=
relax':
> > > > > > > > >> ././include/linux/compiler_types.h:285:33: warning: 'asm=
' operand 0 probably does not match constraints
> > > > > > > > >> 285 | #define asm_volatile_goto(x...) asm goto(x)
> > > > > > > > >> | ^~~
> > > > > > > > >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in exp=
ansion of macro 'asm_volatile_goto'
> > > > > > > > >> 41 | asm_volatile_goto(
> > > > > > > > >> | ^~~~~~~~~~~~~~~~~
> > > > > > > > >> ././include/linux/compiler_types.h:285:33: error: imposs=
ible constraint in 'asm'
> > > > > > > > >> 285 | #define asm_volatile_goto(x...) asm goto(x)
> > > > > > > > >> | ^~~
> > > > > > > > >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in exp=
ansion of macro 'asm_volatile_goto'
> > > > > > > > >> 41 | asm_volatile_goto(
> > > > > > > > >> | ^~~~~~~~~~~~~~~~~
> > > > > > > > >> make[1]: *** [scripts/Makefile.build:249: arch/riscv/ker=
nel/vdso/vgettimeofday.o] Error 1
> > > > > > > > >> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error =
2
> > > > > > > > >>
> > > > > > > > >> Having a static branch in cpu_relax() is problematic bec=
ause that
> > > > > > > > >> function is widely inlined, including in some quite comp=
lex functions
> > > > > > > > >> like in the VDSO. A quick measurement shows this static =
branch is
> > > > > > > > >> responsible by itself for around 40% of the jump table.
> > > > > > > > >>
> > > > > > > > >> Drop the static branch, which ends up being the same num=
ber of
> > > > > > > > >> instructions anyway. If Zihintpause is supported, we tra=
de the nop from
> > > > > > > > >> the static branch for a div. If Zihintpause is unsupport=
ed, we trade the
> > > > > > > > >> jump from the static branch for (what gets interpreted a=
s) a nop.
> > > > > > > > >>
> > > > > > > > >> Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause suppor=
t")
> > > > > > > > >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> > > > > > > > >> ---
> > > > > > > > >>
> > > > > > > > >> arch/riscv/include/asm/hwcap.h | 3 ---
> > > > > > > > >> arch/riscv/include/asm/vdso/processor.h | 25 ++++++++++-=
--------------
> > > > > > > > >> 2 files changed, 10 insertions(+), 18 deletions(-)
> > > > > > > > >>
> > > > > > > > >> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv=
/include/asm/hwcap.h
> > > > > > > > >> index 6f59ec64175e..b21d46e68386 100644
> > > > > > > > >> --- a/arch/riscv/include/asm/hwcap.h
> > > > > > > > >> +++ b/arch/riscv/include/asm/hwcap.h
> > > > > > > > >> @@ -68,7 +68,6 @@ enum riscv_isa_ext_id {
> > > > > > > > >> */
> > > > > > > > >> enum riscv_isa_ext_key {
> > > > > > > > >>    RISCV_ISA_EXT_KEY_FPU,          /* For 'F' and 'D' */
> > > > > > > > >> -  RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
> > > > > > > > >>    RISCV_ISA_EXT_KEY_MAX,
> > > > > > > > >> };
> > > > > > > > >>
> > > > > > > > >> @@ -88,8 +87,6 @@ static __always_inline int riscv_isa_e=
xt2key(int num)
> > > > > > > > >>            return RISCV_ISA_EXT_KEY_FPU;
> > > > > > > > >>    case RISCV_ISA_EXT_d:
> > > > > > > > >>            return RISCV_ISA_EXT_KEY_FPU;
> > > > > > > > >> -  case RISCV_ISA_EXT_ZIHINTPAUSE:
> > > > > > > > >> -          return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
> > > > > > > > >>    default:
> > > > > > > > >>            return -EINVAL;
> > > > > > > > >>    }
> > > > > > > > >> diff --git a/arch/riscv/include/asm/vdso/processor.h b/a=
rch/riscv/include/asm/vdso/processor.h
> > > > > > > > >> index 1e4f8b4aef79..789bdb8211a2 100644
> > > > > > > > >> --- a/arch/riscv/include/asm/vdso/processor.h
> > > > > > > > >> +++ b/arch/riscv/include/asm/vdso/processor.h
> > > > > > > > >> @@ -4,30 +4,25 @@
> > > > > > > > >>
> > > > > > > > >> #ifndef __ASSEMBLY__
> > > > > > > > >>
> > > > > > > > >> -#include <linux/jump_label.h>
> > > > > > > > >> #include <asm/barrier.h>
> > > > > > > > >> -#include <asm/hwcap.h>
> > > > > > > > >>
> > > > > > > > >> static inline void cpu_relax(void)
> > > > > > > > >> {
> > > > > > > > >> -  if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_I=
SA_EXT_KEY_ZIHINTPAUSE])) {
> > > > > > > > >> #ifdef __riscv_muldiv
> > > > > > > > >> -          int dummy;
> > > > > > > > >> -          /* In lieu of a halt instruction, induce a lo=
ng-latency stall. */
> > > > > > > > >> -          __asm__ __volatile__ ("div %0, %0, zero" : "=
=3Dr" (dummy));
> > > > > > > > >> +  int dummy;
> > > > > > > > >> +  /* In lieu of a halt instruction, induce a long-laten=
cy stall. */
> > > > > > > > >> +  __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (du=
mmy));
> > > > > > > > >> #endif
> > > > > > > > >> -  } else {
> > > > > > > > >> -          /*
> > > > > > > > >> -           * Reduce instruction retirement.
> > > > > > > > >> -           * This assumes the PC changes.
> > > > > > > > >> -           */
> > > > > > > > >> +  /*
> > > > > > > > >> +   * Reduce instruction retirement.
> > > > > > > > >> +   * This assumes the PC changes.
> > > > > > > > >> +   */
> > > > > > > > >> #ifdef __riscv_zihintpause
> > > > > > > > >> -          __asm__ __volatile__ ("pause");
> > > > > > > > >> +  __asm__ __volatile__ ("pause");
> > > > > > > > >> #else
> > > > > > > > >> -          /* Encoding of the pause instruction */
> > > > > > > > >> -          __asm__ __volatile__ (".4byte 0x100000F");
> > > > > > > > >> +  /* Encoding of the pause instruction */
> > > > > > > > >> +  __asm__ __volatile__ (".4byte 0x100000F");
> > > > > > > > >> #endif
> > > > > > > > >
> > > > > > > > > hmm, though before this part of the code was only ever ac=
cessed
> > > > > > > > > when the zhintpause extension was really available on the=
 running
> > > > > > > > > machine while now the pause instruction is called every t=
ime.
> > > > > > > > >
> > > > > > > > > So I'm just wondering, can't this run into some "illegal =
instruction"
> > > > > > > > > thingy on machines not supporting the extension?
> > > > > > > >
> > > > > > > > No. The encoding for pause was deliberately chosen to be on=
e of the
> > > > > > > > =E2=80=9Cuseless=E2=80=9D encodings of fence, with the hope=
 that existing
> > > > > > > > microarchitectures might take a while to execute it and thu=
s it would
> > > > > > > > still function as a slow-running instruction. It=E2=80=99s =
somewhat
> > > > > > > > questionable whether the div is even needed, the worst that=
 happens is
> > > > > > > > cpu_relax isn=E2=80=99t very relaxed and you spin a bit fas=
ter. Any
> > > > > > > > implementations where that=E2=80=99s true probably also don=
=E2=80=99t have fancy
> > > > > > > > clock/power management anyway, and div isn=E2=80=99t going =
to be a low-power
> > > > > > > > operation so the only real effect is likely hammering on co=
ntended
> > > > > > > > atomics a bit more, and who cares about that on the low cor=
e count
> > > > > > > > systems we have today.
> > > > > > >
> > > > > > > thanks a lot for that explanation, which made things a lot cl=
earer.
> > > > > > >
> > > > > > > So as you said, dropping the div part might make the function=
 even smaller,
> > > > > > > though somehow part of me would want to add some sort of comm=
ent to
> > > > > > > the function for when the next developer stumbles over the un=
conditional
> > > > > > > use of pause :-) .
> > > > > > >
> > > > > >
> > > > > > I agree. If that's what microarch will do, we can drop div alto=
gether.
> > > > > > Though microarch may be treated as nop even if it is undesirabl=
e.
> > > > > > IIRC, the div was introduced for the rocket chip which would in=
duce a
> > > > > > long latency stall with div instruction (zero as operands).
> > > > > >
> > > > > > Does any other core or newer rocket chip actually induce a late=
ncy
> > > > > > stall with div instruction ?
> > > > > > If not, it is equivalent to NOP as well. We can definitely remo=
ve the div.
> > > > > > The only cores affected will be the older rocket core.
> > > > > >
> > > > > > Tagging some folks to understand what their core does.
> > > > > >
> > > > > > @Paul Walmsley @Guo Ren @Conor Dooley ?
> > > > >
> > > > > I am no microarch expert by _any_ stretch of the imagination, but
> > > > > from a quick experiment it looks like the u54s on PolarFire SoC b=
ehave
> > > > > in the same way, and div w/ zero operands does in fact take signi=
ficantly
> > > > > longer than regular division (looks to be about 3x).
> > > > >
> > > >
> > > > Thanks. Do you have any data on how much the "pause" instruction ta=
kes.
> > >
> > > So these numbers you may consider as being pulled out of a magic hat
> > > as all I am doing is reading the counters from userspace and there is
> > > some variance etc. Plus the fact that I just started hacking at some
> > > existing code I had lying around as I'm pretty snowed under at the
> > > moment.
> > >
> > > Doing the following takes about 70 cycles on both a PolarFire SoC and=
 an
> > > unmatched:
> > >         long divisor =3D 2, dividend =3D 100000, dest;
> > >         asm("div %0, zero, zero" : "=3Dr" (dest));
> > > and equates to:
> > >         sd      a5,-48(s0)
> > >         div     a5,zero,zero
> > >
> > > Clocking in at about 40 cycles is some actual divisions, I just did t=
he
> > > following a dozen times, doing a trivial computation:
> > >         long divisor =3D 2, dividend =3D 100000, dest;
> > >         asm("div %0, %1, %2" : "=3Dr" (dividend) : "r" (dividend), "r=
" (divisor))
> > >
> > > ie, a load of the following:
> > >         sd      a5,-48(s0)
> > >         ld      a5,-48(s0)
> > >         ld      a4,-40(s0)
> > >         div     a5,a5,a4
> > >
> > > So clearly the div w/ zero args makes a difference...
> > >
> > > On PolarFire SoC, `0x100000F` takes approx 6 cycles. On my unmatched,=
 it
> > > takes approx 40. Again, I just had an asm block & called the instruct=
ion
> > > a number times and took the average - here it was 48 times.
> > >
> > > Take the actual numbers with a fist full of salt, but at least the
> > > relative numbers should be of some use to you.
> > >
> > > Hope that's somewhat helpful, maybe next week I can do something a
> > > little more useful for you...
> > >
> >
> > Thanks. It would be good to understand what happens when "pause" is
> > executed on these boards ?
>
> The actual pause instruction? uhh, so with the usual "I don't know what
> I am doing" disclaimer, I ran each of the .insn and pause instruction 48
> times in a row and checked the time elapsed via rdcycle & then ran that
> c program 1000 times in a bash loop. Got the below, the insns were run
> first and then the pauses.
>         insn    pause
> min     2.3     3.2
> max     9.5     10.6
> avg     27.0    29.1
> 5%      2.9     4.2
> 95%     18.1    19.1
>
> Swapping the pause & insn order around made a minor difference, but not
> enough to report on. I'd be very wary of drawing any real conclusions
> from this data, but at least both are roughly similar (and certainly not
> even close to doing the div w/ zero args.
>

Yeah. That's what I was expecting. So we can't drop the div for now. Otherw=
ise,
the existing hardware(don't support Zhintpause) suffers by spinning faster.

Thanks for running the experiments.

> Again, hope that is helpful?
> Conor.
>
> >
> > > Conor.
> > >
> > > > I understand that it is not available in these cores. Just wanted t=
o
> > > > understand if microarchitecture
> > > > actually takes a while executing the useless encoding as pointed ou=
t by Jessica.
> > > >
> > > > If that's the case, we can remove the div instruction altogether.
> > > > Otherwise, this patch will cause some performance regression
> > > > for existing SoC (HiFive unleashed has the same core. Not sure abou=
t
> > > > unmatched though).
> > > > This needs to be documented at least.
> > > >
> > > > > Hope that's helpful,
> > > > > Conor.
> > > > >
> > > > > (I just did a quick check of what pretty much amounted to a bunch=
 of
> > > > > div a5,zero,zero in a row versus div a5,a5,a5)
> > > > >
> > > > > >
> > > > > > (Please add anybody who may have an insight to execution flow o=
n
> > > > > > existing Linux capable cores)
> > > > > >
>


--=20
Regards,
Atish
