Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1C25B3642
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiIILYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIILYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:24:02 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD39B80B5D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:24:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id z23so1454267ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=bD4RkNBgrviSql9485S42o5agFaT1vY2awWxlBXbe4A=;
        b=b/99rJDlCrKBX0xhKkQANIGDBHRBkgqw3H/BNpxh9DTFcTZ79HWabG3RkPyzcmxWem
         Ql4HrMkLmAQZ757dRc9fP/zeqSnwpsrsyNAaSwopTMySLNoUbfZY4XZWsH3FREfCryll
         +RFkqhYrfvevHyuQQsbi/pN5/vDSELFPBcwB5ItlG4FKqcOi6bVneg1ggL6XkcwCQ+SL
         WhRBqx/ddc6b90azKwa9pvcmawr6OAobXKQtgoJggwW+gIm4tjD/e3+Qm9yjNEL6VQGR
         Z8rkUFaEQB2c1Awnxs2Mb5sX96utAWY2XBxviobv6Du+I1ZzDnLXLhof5847yGKT1+qr
         FUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bD4RkNBgrviSql9485S42o5agFaT1vY2awWxlBXbe4A=;
        b=zSgWfd4rMh9dQj/9OLcX0K1HScMzERoP1mjIboWz8Qv1xMyCpi3Z4ebN8/CqkcgpNl
         +z9gL3SMnLfWlMkMoTh/GVgu/YbOz0PcCHRfjwsAS5Z0vPYrErlh4GFYOV9MElZhNBDO
         EutDDADjRcJD1eyZ6NoMBk9+/WbWRnx4fuPc+UOp+BAD2/Iki+UdM85apFIIjdooo999
         BxznCasWUCYkhNK8G081YWDYDj8JKWiXlieIH3iHvsM8prnsJuXGowBlB1WIcjNEtLxz
         oucxg9nK5SI6T2gbVAwqZxsFdAoLYlafqxOmN4mJpoGt9CVL6E6RI7+glO4xPDqYcQhV
         g+5A==
X-Gm-Message-State: ACgBeo1HoEOvK3b6Za4zq4tYlssSBeuwZuMmSKZW3pQIoyQzfaGGEUE1
        tSrbfTUbgTlzZAp/4I5hhcSaGDOfqn/AhZCzdQt4CQ==
X-Google-Smtp-Source: AA6agR6jhXEVaC9gSV4rLJ2PN+A8AMuOe+Y7fgRBP5Cd2hrZgausF5jgjCgnO1nClSq+0aRSwamQfZoKqEOriHBsPNg=
X-Received: by 2002:a05:651c:884:b0:268:dc11:cc1a with SMTP id
 d4-20020a05651c088400b00268dc11cc1amr3582700ljq.466.1662722638959; Fri, 09
 Sep 2022 04:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220831172500.752195-1-ajones@ventanamicro.com>
 <20220831172500.752195-3-ajones@ventanamicro.com> <3006889.o7ts2hSHzF@diego>
In-Reply-To: <3006889.o7ts2hSHzF@diego>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 9 Sep 2022 16:53:47 +0530
Message-ID: <CAK9=C2VM8NB1+gf9w+QQ6pzoC0O68WFRZkt8xCphGVtPUWS4NQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] riscv: Introduce support for defining instructions
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 9:20 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 31. August 2022, 19:24:58 CEST schrieb Andrew Jones:
> > When compiling with toolchains that haven't yet been taught about
> > new instructions we need to encode them ourselves. Create a new file
> > where support for instruction definitions will evolve. We initiate
> > the file with a macro called INSN_R(), which implements the R-type
> > instruction encoding. INSN_R() will use the assembler's .insn
> > directive when available, which should give the assembler a chance
> > to do some validation. When .insn is not available we fall back to
> > manual encoding.
> >
> > Not only should using instruction encoding macros improve readability
> > and maintainability of code over the alternative of inserting
> > instructions directly (e.g. '.word 0xc0de'), but we should also gain
> > potential for more optimized code after compilation because the
> > compiler will have control over the input and output registers used.
> >
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > ---
> >  arch/riscv/Kconfig                |  3 ++
> >  arch/riscv/include/asm/insn-def.h | 86 +++++++++++++++++++++++++++++++
> >  2 files changed, 89 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/insn-def.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index ed66c31e4655..f8f3b316b838 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -227,6 +227,9 @@ config RISCV_DMA_NONCOHERENT
> >       select ARCH_HAS_SETUP_DMA_OPS
> >       select DMA_DIRECT_REMAP
> >
> > +config AS_HAS_INSN
> > +     def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(co=
mma) t0$(comma) zero)
> > +
> >  source "arch/riscv/Kconfig.socs"
> >  source "arch/riscv/Kconfig.erratas"
> >
> > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm=
/insn-def.h
> > new file mode 100644
> > index 000000000000..2dcd1d4781bf
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/insn-def.h
> > @@ -0,0 +1,86 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef __ASM_INSN_DEF_H
> > +#define __ASM_INSN_DEF_H
> > +
> > +#include <asm/asm.h>
> > +
> > +#define INSN_R_FUNC7_SHIFT           25
> > +#define INSN_R_RS2_SHIFT             20
> > +#define INSN_R_RS1_SHIFT             15
> > +#define INSN_R_FUNC3_SHIFT           12
> > +#define INSN_R_RD_SHIFT                       7
> > +#define INSN_R_OPCODE_SHIFT           0
> > +
> > +#ifdef __ASSEMBLY__
> > +
> > +#ifdef CONFIG_AS_HAS_INSN
> > +
> > +     .macro insn_r, opcode, func3, func7, rd, rs1, rs2
> > +     .insn   r \opcode, \func3, \func7, \rd, \rs1, \rs2
> > +     .endm
> > +
> > +#else
> > +
> > +#include <asm/gpr-num.h>
> > +
> > +     .macro insn_r, opcode, func3, func7, rd, rs1, rs2
> > +     .4byte  ((\opcode << INSN_R_OPCODE_SHIFT) |             \
> > +              (\func3 << INSN_R_FUNC3_SHIFT) |               \
> > +              (\func7 << INSN_R_FUNC7_SHIFT) |               \
> > +              (.L__gpr_num_\rd << INSN_R_RD_SHIFT) |         \
> > +              (.L__gpr_num_\rs1 << INSN_R_RS1_SHIFT) |       \
> > +              (.L__gpr_num_\rs2 << INSN_R_RS2_SHIFT))
> > +     .endm
> > +
> > +#endif
> > +
> > +#define INSN_R(...)  insn_r __VA_ARGS__
> > +
> > +#else /* ! __ASSEMBLY__ */
> > +
> > +#ifdef CONFIG_AS_HAS_INSN
> > +
> > +#define INSN_R(opcode, func3, func7, rd, rs1, rs2)   \
> > +     ".insn  r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs=
2 "\n"
> > +
> > +#else
> > +
> > +#include <linux/stringify.h>
> > +#include <asm/gpr-num.h>
> > +
> > +#define DEFINE_INSN_R                                                 =
       \
> > +     __DEFINE_ASM_GPR_NUMS                                           \
> > +"    .macro insn_r, opcode, func3, func7, rd, rs1, rs2\n"            \
> > +"    .4byte  ((\\opcode << " __stringify(INSN_R_OPCODE_SHIFT) ") |"  \
> > +"             (\\func3 << " __stringify(INSN_R_FUNC3_SHIFT) ") |"    \
> > +"             (\\func7 << " __stringify(INSN_R_FUNC7_SHIFT) ") |"    \
> > +"             (.L__gpr_num_\\rd << " __stringify(INSN_R_RD_SHIFT) ") |=
"    \
> > +"             (.L__gpr_num_\\rs1 << " __stringify(INSN_R_RS1_SHIFT) ")=
 |"  \
> > +"             (.L__gpr_num_\\rs2 << " __stringify(INSN_R_RS2_SHIFT) ")=
)\n" \
> > +"    .endm\n"
> > +
> > +#define UNDEFINE_INSN_R                                               =
       \
> > +"    .purgem insn_r\n"
> > +
> > +#define INSN_R(opcode, func3, func7, rd, rs1, rs2)                   \
> > +     DEFINE_INSN_R                                                   \
> > +     "insn_r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 =
"\n" \
> > +     UNDEFINE_INSN_R
> > +
> > +#endif
> > +
> > +#endif /* ! __ASSEMBLY__ */
> > +
> > +#define OPCODE(v)    __ASM_STR(v)
> > +#define FUNC3(v)     __ASM_STR(v)
> > +#define FUNC7(v)     __ASM_STR(v)
> > +#define RD(v)                __ASM_STR(v)
> > +#define RS1(v)               __ASM_STR(v)
> > +#define RS2(v)               __ASM_STR(v)
>
> you might want some sort of prefix here
>         RISCV_RS1(v) ?
>
> While trying to adapt this for the cmo stuff I ran into the issue
> of bpf complaining that "IMM" is already defined there.
>
> And names above are generic enough that these also
> might conflict with other stuff.

I have updated the KVM RISC-V queue to use the "RV_" prefix
in macro names.

Regards,
Anup

>
>
>
>
> > +#define __REG(v)     __ASM_STR(x ## v)
> > +#define __RD(v)              __REG(v)
> > +#define __RS1(v)     __REG(v)
> > +#define __RS2(v)     __REG(v)
> > +
> > +#endif /* __ASM_INSN_DEF_H */
> >
>
>
>
>
