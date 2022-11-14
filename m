Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1F627826
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiKNIwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiKNIvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:51:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378B919C35
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:51:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC752B80D3D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96004C43144
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668415911;
        bh=uZ6+oZTLze1RKQfy58a8amMFqHnw789Td23AGSCHtXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lCF1l6R0QHqHBEgAwkFs41Mq8X/5pmSYwjf4HHSKyGR2mHcUV3d6IlqmJtKb/LI9E
         3Ad6WcTeAG1FhluiLkN2udUwDM0rYfTFP5Z03i7DrAcKaEcdicUWapLmfjIx0K7FJ+
         hispusMGc5BcZZev8VVgV94ZFbwud756X6FMyvpviaqOvJoLDEg6t4Ij+CHDSW9NO0
         RiS/itbKQLSLhQOHT7zYvUJ/8D5siRGUvagWI/AI3bv07BbeQYWAbyc0tcvj/a5+gE
         TAeuoTvL5kkxehigYKhHkhsp8sJaaKp7C+d6pc23+agcVtXjD/QlXkQU2ERCa0ZDaI
         orNj7TpkCdpig==
Received: by mail-ed1-f53.google.com with SMTP id u24so16188589edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:51:51 -0800 (PST)
X-Gm-Message-State: ANoB5pkcxxqhuawzBrr5HzQtpyr9DIWvy371WV/r0/Iulgo7PbWyj9RP
        eSMNFYCOfiX4lme7ZIR5W1VJweS8bFvakzGiu+s=
X-Google-Smtp-Source: AA0mqf7qhwODcSzEnMktD1O+POdwX3zA8dKEBfwBToLtnxi5yPWlk99CR/lzZf1vCg2j4ALp32CgXdpN/jcQxT0zyY4=
X-Received: by 2002:a05:6402:3715:b0:462:32bf:613a with SMTP id
 ek21-20020a056402371500b0046232bf613amr10033261edb.78.1668415909711; Mon, 14
 Nov 2022 00:51:49 -0800 (PST)
MIME-Version: 1.0
References: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn>
 <1664326209-13995-4-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7N-N2400ivdczJrfJ9Ht12JUbOADxExF87wVPFEj_c_g@mail.gmail.com>
 <dd3fc4ab-6bbb-2fa5-8d5e-b8206b42518c@loongson.cn> <CAAhV-H4ok2r2FarFszwYJ6Hah4m7ieNf6egnXyZhUf1ESDUhXg@mail.gmail.com>
 <a528e970-29ac-2fcb-b749-cfae3fbe5a18@loongson.cn>
In-Reply-To: <a528e970-29ac-2fcb-b749-cfae3fbe5a18@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 14 Nov 2022 16:51:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7uaFeND1-iSHmLXMFJonRTbiu81EnFGjyHZ0uN9bVXZw@mail.gmail.com>
Message-ID: <CAAhV-H7uaFeND1-iSHmLXMFJonRTbiu81EnFGjyHZ0uN9bVXZw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] LoongArch: Add kretprobe support
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Mon, Nov 14, 2022 at 4:32 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
> On 2022/11/14 =E4=B8=8B=E5=8D=882:50, Huacai Chen wrote:
>
> > On Mon, Nov 14, 2022 at 2:11 PM Jinyang He <hejinyang@loongson.cn> wrot=
e:
> >> On 2022/11/14 =E4=B8=8B=E5=8D=8812:43, Huacai Chen wrote:
> >>
> >>> Hi, Tiezhu and Jinyang,
> >>>
> >>> On Wed, Sep 28, 2022 at 8:50 AM Tiezhu Yang <yangtiezhu@loongson.cn> =
wrote:
> >>>> Use the generic kretprobe trampoline handler to add kretprobe
> >>>> support for LoongArch.
> >>>>
> >>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >>>> ---
> >>>>    arch/loongarch/Kconfig                     |  1 +
> >>>>    arch/loongarch/kernel/Makefile             |  2 +-
> >>>>    arch/loongarch/kernel/kprobes.c            | 24 ++++++++
> >>>>    arch/loongarch/kernel/kprobes_trampoline.S | 97 +++++++++++++++++=
+++++++++++++
> >>>>    4 files changed, 123 insertions(+), 1 deletion(-)
> >>>>    create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
> >>>>
> >>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >>>> index 8debd70..877be6a 100644
> >>>> --- a/arch/loongarch/Kconfig
> >>>> +++ b/arch/loongarch/Kconfig
> >>>> @@ -95,6 +95,7 @@ config LOONGARCH
> >>>>           select HAVE_IRQ_EXIT_ON_IRQ_STACK
> >>>>           select HAVE_IRQ_TIME_ACCOUNTING
> >>>>           select HAVE_KPROBES
> >>>> +       select HAVE_KRETPROBES
> >>>>           select HAVE_MOD_ARCH_SPECIFIC
> >>>>           select HAVE_NMI
> >>>>           select HAVE_PCI
> >>>> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/=
Makefile
> >>>> index ff98d8a..48f50607 100644
> >>>> --- a/arch/loongarch/kernel/Makefile
> >>>> +++ b/arch/loongarch/kernel/Makefile
> >>>> @@ -33,6 +33,6 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) +=3D unwind_prolog=
ue.o
> >>>>
> >>>>    obj-$(CONFIG_PERF_EVENTS)      +=3D perf_event.o perf_regs.o
> >>>>
> >>>> -obj-$(CONFIG_KPROBES)          +=3D kprobes.o
> >>>> +obj-$(CONFIG_KPROBES)          +=3D kprobes.o kprobes_trampoline.o
> >>>>
> >>>>    CPPFLAGS_vmlinux.lds           :=3D $(KBUILD_CFLAGS)
> >>>> diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel=
/kprobes.c
> >>>> index c11f6e0..ca3f1dc 100644
> >>>> --- a/arch/loongarch/kernel/kprobes.c
> >>>> +++ b/arch/loongarch/kernel/kprobes.c
> >>>> @@ -306,6 +306,30 @@ int __init arch_populate_kprobe_blacklist(void)
> >>>>                                            (unsigned long)__irqentry=
_text_end);
> >>>>    }
> >>>>
> >>>> +/* Called from __kretprobe_trampoline */
> >>>> +void __used *trampoline_probe_handler(struct pt_regs *regs)
> >>>> +{
> >>>> +       return (void *)kretprobe_trampoline_handler(regs, NULL);
> >>>> +}
> >>>> +NOKPROBE_SYMBOL(trampoline_probe_handler);
> >>>> +
> >>>> +void arch_prepare_kretprobe(struct kretprobe_instance *ri,
> >>>> +                           struct pt_regs *regs)
> >>>> +{
> >>>> +       ri->ret_addr =3D (kprobe_opcode_t *)regs->regs[1];
> >>>> +       ri->fp =3D NULL;
> >>>> +
> >>>> +       /* Replace the return addr with trampoline addr */
> >>>> +       regs->regs[1] =3D (unsigned long)&__kretprobe_trampoline;
> >>>> +}
> >>>> +NOKPROBE_SYMBOL(arch_prepare_kretprobe);
> >>>> +
> >>>> +int arch_trampoline_kprobe(struct kprobe *p)
> >>>> +{
> >>>> +       return 0;
> >>>> +}
> >>>> +NOKPROBE_SYMBOL(arch_trampoline_kprobe);
> >>>> +
> >>>>    int __init arch_init_kprobes(void)
> >>>>    {
> >>>>           return 0;
> >>>> diff --git a/arch/loongarch/kernel/kprobes_trampoline.S b/arch/loong=
arch/kernel/kprobes_trampoline.S
> >>>> new file mode 100644
> >>>> index 0000000..9888ab8
> >>>> --- /dev/null
> >>>> +++ b/arch/loongarch/kernel/kprobes_trampoline.S
> >>>> @@ -0,0 +1,97 @@
> >>>> +/* SPDX-License-Identifier: GPL-2.0+ */
> >>>> +#include <linux/linkage.h>
> >>>> +#include <asm/stackframe.h>
> >>>> +
> >>>> +       .text
> >>>> +
> >>>> +       .macro save_all_base_regs
> >>>> +       cfi_st  zero, PT_R0
> >>>> +       cfi_st  ra, PT_R1
> >>>> +       cfi_st  tp, PT_R2
> >>>> +       cfi_st  a0, PT_R4
> >>>> +       cfi_st  a1, PT_R5
> >>>> +       cfi_st  a2, PT_R6
> >>>> +       cfi_st  a3, PT_R7
> >>>> +       cfi_st  a4, PT_R8
> >>>> +       cfi_st  a5, PT_R9
> >>>> +       cfi_st  a6, PT_R10
> >>>> +       cfi_st  a7, PT_R11
> >>>> +       cfi_st  t0, PT_R12
> >>>> +       cfi_st  t1, PT_R13
> >>>> +       cfi_st  t2, PT_R14
> >>>> +       cfi_st  t3, PT_R15
> >>>> +       cfi_st  t4, PT_R16
> >>>> +       cfi_st  t5, PT_R17
> >>>> +       cfi_st  t6, PT_R18
> >>>> +       cfi_st  t7, PT_R19
> >>>> +       cfi_st  t8, PT_R20
> >>>> +       cfi_st  u0, PT_R21
> >>>> +       cfi_st  fp, PT_R22
> >>>> +       cfi_st  s0, PT_R23
> >>>> +       cfi_st  s1, PT_R24
> >>>> +       cfi_st  s2, PT_R25
> >>>> +       cfi_st  s3, PT_R26
> >>>> +       cfi_st  s4, PT_R27
> >>>> +       cfi_st  s5, PT_R28
> >>>> +       cfi_st  s6, PT_R29
> >>>> +       cfi_st  s7, PT_R30
> >>>> +       cfi_st  s8, PT_R31
> >>>> +       addi.d  t0, sp, PT_SIZE
> >>>> +       LONG_S  t0, sp, PT_R3
> >>>> +       csrrd   t0, LOONGARCH_CSR_CRMD
> >>>> +       andi    t0, t0, 0x7 /* extract bit[1:0] PLV, bit[2] IE */
> >>>> +       LONG_S  t0, sp, PT_PRMD
> >>>> +       .endm
> >>>> +
> >>>> +       .macro restore_all_base_regs
> >>>> +       cfi_ld  zero, PT_R0
> >>>> +       cfi_ld  tp, PT_R2
> >>>> +       cfi_ld  a0, PT_R4
> >>>> +       cfi_ld  a1, PT_R5
> >>>> +       cfi_ld  a2, PT_R6
> >>>> +       cfi_ld  a3, PT_R7
> >>>> +       cfi_ld  a4, PT_R8
> >>>> +       cfi_ld  a5, PT_R9
> >>>> +       cfi_ld  a6, PT_R10
> >>>> +       cfi_ld  a7, PT_R11
> >>>> +       cfi_ld  t0, PT_R12
> >>>> +       cfi_ld  t1, PT_R13
> >>>> +       cfi_ld  t2, PT_R14
> >>>> +       cfi_ld  t3, PT_R15
> >>>> +       cfi_ld  t4, PT_R16
> >>>> +       cfi_ld  t5, PT_R17
> >>>> +       cfi_ld  t6, PT_R18
> >>>> +       cfi_ld  t7, PT_R19
> >>>> +       cfi_ld  t8, PT_R20
> >>>> +       cfi_ld  u0, PT_R21
> >>>> +       cfi_ld  fp, PT_R22
> >>>> +       cfi_ld  s0, PT_R23
> >>>> +       cfi_ld  s1, PT_R24
> >>>> +       cfi_ld  s2, PT_R25
> >>>> +       cfi_ld  s3, PT_R26
> >>>> +       cfi_ld  s4, PT_R27
> >>>> +       cfi_ld  s5, PT_R28
> >>>> +       cfi_ld  s6, PT_R29
> >>>> +       cfi_ld  s7, PT_R30
> >>>> +       cfi_ld  s8, PT_R31
> >>>> +       LONG_L  t0, sp, PT_PRMD
> >>>> +       li.d    t1, 0x7 /* mask bit[1:0] PLV, bit[2] IE */
> >>>> +       csrxchg t0, t1, LOONGARCH_CSR_CRMD
> >>>> +       .endm
> >>> Do you think we need to save and restore all regs here?
> >>>
> >>> Huacai
> >> Hi, Huacai,
> >>
> >>
> >> Note that it is not function context. In the original kprobe design, i=
t is
> >> triggered by 'break' and then trap into exception with all pt_regs sav=
ed.
> >> The all pt_regs will be visible to the user. So I think in this versio=
n
> >> we should also support all regs to user. BTW, due to all exceptions is
> >> trapped by 'break' something in pt_regs is not needed, like estat,
> >> badvaddr and so on.
> > OK, but I still have some questions:
> > 1, Why $r0 need save/restore?
>
> Surely $r0 can be not saved, as now we do not have strange purpose
> to make PT_R0 as a flag.
>
>
> > 2, Why save $r1 but not restore?
> My wrong idea is $r1 should be saved at CSR_ERA, to plays it like
> exception happened. But its value always equal the address of
> __kretprobe_trampoline. The kretprobe is something like fgraph. The real
> return address is returned by trampoline_probe_handler. And at present,
> the real return address is replaced in pt_regs->csr_era in
> __kretprobe_trampoline_handler(). So the $r1 saved in CSR_ERA will
> be destroied at __kretprobe_trampoline_handler() actually.
> That's why $r1 saved also is not needed.
>
> And both way to get return address from return value or get return addres=
s
>
> from pt_regs is same on LoongArch because arch_kretprobe_fixup_return()
>
> does nothing. But I think get return address from pt_regs is more reliabl=
e.
>
>
> > 3, What is the purpose of CRMD magic?
>
> PT_CRMD magic is just exception context. It gives us a chance e.g.
> set ie off at func head, and ie on at func return.
ARM64 and RISC-V don't have such magics, so maybe they are unneeded?

Huacai
>
>
> Thanks,
>
> Jinyang
>
> >
> >>>> +
> >>>> +SYM_CODE_START(__kretprobe_trampoline)
> >>>> +       addi.d  sp, sp, -PT_SIZE
> >>>> +       save_all_base_regs
> >>>> +
> >>>> +       move a0, sp /* pt_regs */
> >>>> +
> >>>> +       bl trampoline_probe_handler
> >>>> +
> >>>> +       /* use the result as the return-address */
> >>>> +       move ra, a0
> >>>> +
> >>>> +       restore_all_base_regs
> >>>> +       addi.d  sp, sp, PT_SIZE
> >>>> +
> >>>> +       jr ra
> >>>> +SYM_CODE_END(__kretprobe_trampoline)
> >>>> --
> >>>> 2.1.0
> >>>>
> >>>>
>
