Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8FB62B357
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiKPGfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiKPGev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:34:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DE12DD2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 22:34:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDEACB81ACB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51553C433C1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668580487;
        bh=V22BgxTJQvo7vvpSBXolDtXyeZMf8nSLNQ7zZy4L1YQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OB7WyX82uzkKJpi0sYxZnY7XzZcZoiC1cSS/cDFrxFco7FFzwm+0Cw/htWarkcDJw
         pPzSbv3c4hGsLSEvcuhYhRRGTdscaSTpGzrr2SHH1hvbNs57PzU00nk6mType6hb1B
         XpAkoHC33j0BX2zeo2NGfSPfYnDsYcdZln8CrgG0zPPqZbSkZjQc/9wV+BA61qDsi5
         MNByVcXLfQvq/Ctqb8aXFkZnEoM+jLTmuCKO+jNkJaNp4jYK0okb1X1kUkPHysISJm
         CwNDk6DyCiLIxim/2utcUQXCbmj4PEd8Mwa5u2aoIVRlMfE/Rn2jtopAbD7pjoHwVl
         BGX04QLw3uQlw==
Received: by mail-ed1-f45.google.com with SMTP id u24so25085170edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 22:34:47 -0800 (PST)
X-Gm-Message-State: ANoB5pmeubZGZRtdOXMjb73lVRtoX4msZD23nalIXIxtz9SpGtgYHWyP
        u2UqMAA9J/e46mY7BSt7Uq1nVCSZ44o1s3Jrc4U=
X-Google-Smtp-Source: AA0mqf6TxifyHRI+WD4g8dUY2QGeoGMVHsb62hMs+XwysFm/GWxz2qhwhxZOqk5vFTNfmxnGARPf2vwj7jtQtqmX+eE=
X-Received: by 2002:aa7:c515:0:b0:462:a25f:f0f2 with SMTP id
 o21-20020aa7c515000000b00462a25ff0f2mr17790890edq.156.1668580485339; Tue, 15
 Nov 2022 22:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20221116025324.1624-1-zhangqing@loongson.cn> <20221116025324.1624-6-zhangqing@loongson.cn>
In-Reply-To: <20221116025324.1624-6-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 16 Nov 2022 14:34:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7SLDmr196DYVecaqbrmyL99ugy0NB-NwtCt=uh9Sbj2w@mail.gmail.com>
Message-ID: <CAAhV-H7SLDmr196DYVecaqbrmyL99ugy0NB-NwtCt=uh9Sbj2w@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] LoongArch/ftrace: Add HAVE_DYNAMIC_FTRACE_WITH_REGS
 support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Qing,

On Wed, Nov 16, 2022 at 10:53 AM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> This patch implements CONFIG_DYNAMIC_FTRACE_WITH_REGS on LoongArch, which allows
> a traced function's arguments (and some other registers) to be captured
> into a struct pt_regs, allowing these to be inspected and modified.
>
> Co-developed-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/Kconfig              |  1 +
>  arch/loongarch/include/asm/ftrace.h |  3 +++
>  arch/loongarch/kernel/ftrace_dyn.c  | 17 ++++++++++++++
>  arch/loongarch/kernel/mcount_dyn.S  | 36 +++++++++++++++++++++++++++--
>  4 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 615ce62422b8..12e3e91a68ae 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -90,6 +90,7 @@ config LOONGARCH
>         select HAVE_DEBUG_STACKOVERFLOW
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_DYNAMIC_FTRACE
> +       select HAVE_DYNAMIC_FTRACE_WITH_REGS
>         select HAVE_EBPF_JIT
>         select HAVE_EXIT_THREAD
>         select HAVE_FAST_GUP
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> index 76ca58767f4d..a3f974a7a5ce 100644
> --- a/arch/loongarch/include/asm/ftrace.h
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -28,6 +28,9 @@ struct dyn_ftrace;
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>  #define ftrace_init_nop ftrace_init_nop
>
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#define ARCH_SUPPORTS_FTRACE_OPS 1
> +#endif
This ifdef can be removed, because you have no chance to disable
DYNAMIC_FTRACE_WITH_REGS after this commit.

Huacai
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>  #endif /* __ASSEMBLY__ */
>  #endif /* CONFIG_FUNCTION_TRACER */
> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
> index 3fe791b6783e..ec3d951be50c 100644
> --- a/arch/loongarch/kernel/ftrace_dyn.c
> +++ b/arch/loongarch/kernel/ftrace_dyn.c
> @@ -99,6 +99,23 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>         return ftrace_modify_code(pc, old, new, true);
>  }
>
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> +                       unsigned long addr)
> +{
> +       unsigned long pc;
> +       long offset;
> +       u32 old, new;
> +
> +       pc = rec->ip + LOONGARCH_INSN_SIZE;
> +
> +       old = larch_insn_gen_bl(pc, old_addr);
> +       new = larch_insn_gen_bl(pc, addr);
> +
> +       return ftrace_modify_code(pc, old, new, true);
> +}
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +
>  void arch_ftrace_update_code(int command)
>  {
>         command |= FTRACE_MAY_SLEEP;
> diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
> index 0c12cc108e6f..02835186b463 100644
> --- a/arch/loongarch/kernel/mcount_dyn.S
> +++ b/arch/loongarch/kernel/mcount_dyn.S
> @@ -27,7 +27,7 @@
>   * follows the LoongArch psABI well.
>   */
>
> -       .macro  ftrace_regs_entry
> +       .macro  ftrace_regs_entry allregs=0
>         PTR_ADDI sp, sp, -PT_SIZE
>         /* Save trace function ra at PT_ERA */
>         PTR_S   ra, sp, PT_ERA
> @@ -43,16 +43,48 @@
>         PTR_S   a7, sp, PT_R11
>         PTR_S   fp, sp, PT_R22
>
> +       .if \allregs
> +       PTR_S   t0, sp, PT_R12
> +       PTR_S   t1, sp, PT_R13
> +       PTR_S   t2, sp, PT_R14
> +       PTR_S   t3, sp, PT_R15
> +       PTR_S   t4, sp, PT_R16
> +       PTR_S   t5, sp, PT_R17
> +       PTR_S   t6, sp, PT_R18
> +       PTR_S   t7, sp, PT_R19
> +       PTR_S   t8, sp, PT_R20
> +       PTR_S   s0, sp, PT_R23
> +       PTR_S   s1, sp, PT_R24
> +       PTR_S   s2, sp, PT_R25
> +       PTR_S   s3, sp, PT_R26
> +       PTR_S   s4, sp, PT_R27
> +       PTR_S   s5, sp, PT_R28
> +       PTR_S   s6, sp, PT_R29
> +       PTR_S   s7, sp, PT_R30
> +       PTR_S   s8, sp, PT_R31
> +       PTR_S   tp, sp, PT_R2
> +       /* Clear it for later use as a flag sometimes. */
> +       PTR_S   zero, sp, PT_R0
> +       PTR_S   $r21, sp, PT_R21
> +       .endif
> +
>         PTR_ADDI t8, sp, PT_SIZE
>         PTR_S   t8, sp, PT_R3
>
>         .endm
>
>  SYM_CODE_START(ftrace_caller)
> -       ftrace_regs_entry
> +       ftrace_regs_entry allregs=0
>         b       ftrace_common
>  SYM_CODE_END(ftrace_caller)
>
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +SYM_CODE_START(ftrace_regs_caller)
> +       ftrace_regs_entry allregs=1
> +       b       ftrace_common
> +SYM_CODE_END(ftrace_regs_caller)
> +#endif
> +
>  SYM_CODE_START(ftrace_common)
>         PTR_ADDI        a0, ra, -8      /* arg0: ip */
>         move            a1, t0          /* arg1: parent_ip */
> --
> 2.36.0
>
>
