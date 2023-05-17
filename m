Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA4706635
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjEQLKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjEQLKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:10:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2B01B6;
        Wed, 17 May 2023 04:10:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2533a03388dso500389a91.2;
        Wed, 17 May 2023 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684321804; x=1686913804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUhqy0/rRnwuf4GYogluOIbrQ9V7WcQDnN/TpA3bEJk=;
        b=jFqJdBszdhzfmBOsSOnEprDgUrAyOWWaq5X44klsRmMbORUDZiDWBaCJ5G9G+98iso
         YN9ADk0BIsHPN3NTcvHqiZJenK8y8teI++49bQJhG4Y7o6xPNuqTSTMEAKWv2jYN/QKV
         lOFPud4y9C2ZDAgqM+l24/Y3OR0hTA1kxl+Y9AKI0aBLS1jUcBwrfRzmznSHihjYIFRu
         kCpwm7ophgfXZvQ9f8VyX3FTtbkQy3E8zhVUEP7JLVfozEllykUBxQPZLmV4DpqVKZyk
         r8Ix0MeflnekzE9uyx+4iHwV/M+Kbq5TYemDZGg9nVwfSMUwiAuq59Y5WT8S8ABBaoVM
         V8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684321804; x=1686913804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUhqy0/rRnwuf4GYogluOIbrQ9V7WcQDnN/TpA3bEJk=;
        b=HIkqj7rrVAiWSd4JKEHs1lkhr3S2KGg6HbCpcAng9NtjBXsafrffr+5C38kp2+sw9t
         pThSnLmRQtumQ9qG5Y58Ff7dOo4rUSg6blc3yqBH5ZkH5Gpg0iFdmBxBdrz2KCCuKupM
         p5udqMcGzS0w4viEfIRC8CTZmOzyPX90Lfkp0Bjt5jorkyHXkop/LlTQGLKTaPU2yms1
         +7A+SEQp7Cz3SWVNeCUqMmMIwmT6NoxNxVANv2Na8o7TQKQ93ohtXH4K2BNxc3LArAGA
         oCYcvTb+D/V3wdUZScAuvRKg0J8mwGiSdDUc6j+xh/tOYkeoLgqaoCe13VNHlHGcKl6K
         7eSA==
X-Gm-Message-State: AC+VfDzS3IJBv71uiQFigLF0fs9VfN9jbSxl1dTK8bk9P9li62UgQs2I
        18ImHsP28zzty4nhYu0b2y5xLgbk5Va6DyvRanQ=
X-Google-Smtp-Source: ACHHUZ6Z+4EFXcm1pKxUKlQtFcvZSrHs0wVHFhJqF4KKwf7JTZOuJo/Cldx77wyrohuzEJAFLvp9rqaWMtLWsHMhtZ4=
X-Received: by 2002:a17:90b:1e0c:b0:24d:fba9:80e9 with SMTP id
 pg12-20020a17090b1e0c00b0024dfba980e9mr40273217pjb.23.1684321803702; Wed, 17
 May 2023 04:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230511093234.3123181-1-suagrfillet@gmail.com> <CAAYs2=jWwpFzjNqMmyefy6-JEVswfba5MkhaCJ0gvH0bK6zuug@mail.gmail.com>
In-Reply-To: <CAAYs2=jWwpFzjNqMmyefy6-JEVswfba5MkhaCJ0gvH0bK6zuug@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Wed, 17 May 2023 11:09:52 +0000
Message-ID: <CAAYs2=gS+fX0v8n3GhQrb82nRNMnYqrEL7MSrLh-CgOZRLu2jg@mail.gmail.com>
Subject: Re: [PATCH V10 0/4] riscv: Optimize function trace
To:     palmer@dabbelt.com
Cc:     mark.rutland@arm.com, bjorn@rivosinc.com, e.shatokhin@yadro.com,
        jszhang@kernel.org, guoren@kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, aou@eecs.berkeley.edu,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=BA=8C 09:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=9B=9B 09:32=E5=86=99=E9=81=93=EF=BC=9A
>
> >
> > Changes in v10:
> >
> > - add Acked-by from Bj=C3=B6rn T=C3=B6pel in patch 2 and patch 4
> > - replace `move` with `mv` in patch3
> > - prettify patch 2/4 with proper tabs
> >
> > You can directly try it with:
> >
> > https://github.com/sugarfillet/linux/tree/6.4-rc1-rv-ftrace-v10
> >
> >
> Hi, plamer:
> This series is ready for its acceptance, you can pick it up.
>
Apologize for the typo in your name, Palmer.

> > This series optimizes function trace. The first 3 independent
> > patches has been picked in the V7 version of this series, the
> > subsequent version continues the following 4 patches:
> >
> > select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [1] (patch 1)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In RISC-V, -fpatchable-function-entry option is used to support
> > dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
> > PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
> > don't have to be called to create the __mcount_loc section before
> > the vmlinux linking.
> >
> > Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> > Makefile not to run recordmcount.
> >
> > Make function graph use ftrace directly [2] (patch 2)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In RISC-V architecture, when we enable the ftrace_graph tracer on some
> > functions, the function tracings on other functions will suffer extra
> > graph tracing work. In essence, graph_ops isn't limited by its func_has=
h
> > due to the global ftrace_graph_[regs]_call label. That should be
> > corrected.
> >
> > What inspires me is the commit 0c0593b45c9b ("x86/ftrace: Make function
> > graph use ftrace directly") that uses graph_ops::func function to
> > install return_hooker and makes the function called against its
> > func_hash.
> >
> > Add WITH_DIRECT_CALLS support [3] (patch 3, 4)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
> > SAMPLE_FTRACE_DIRECT and SAMPLE_FTRACE_DIRECT_MULTI are also included
> > here as the samples for testing DIRECT_CALLS related interface.
> >
> > First, select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide
> > register_ftrace_direct[_multi] interfaces allowing user to register
> > the customed trampoline (direct_caller) as the mcount for one or
> > more target functions. And modify_ftrace_direct[_multi] are also
> > provided for modify direct_caller.
> >
> > At the same time, the samples in ./samples/ftrace/ can be built
> > as kerenl module for testing these interfaces with SAMPLE_FTRACE_DIRECT
> > and SAMPLE_FTRACE_DIRECT_MULTI selected.
> >
> > Second, to make the direct_caller and the other ftrace hooks
> > (eg. function/fgraph tracer, k[ret]probes) co-exist, a temporary
> > register
> > are nominated to store the address of direct_caller in
> > ftrace_regs_caller.
> > After the setting of the address direct_caller by direct_ops->func and
> > the RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> > by the `jr` inst.
> >
> > The series's old changes related these patches
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Changes in v9:
> > https://lore.kernel.org/linux-riscv/20230510101857.2953955-1-suagrfille=
t@gmail.com/
> >
> > 1. add Acked-by from Bj=C3=B6rn T=C3=B6pel in patch 1
> >
> > 2. rebase patch2/patch3 on Linux v6.4-rc1
> >
> >   - patch 2: to make the `SAVE_ABI_REGS` configurable, revert the
> >     modification of mcount-dyn.S from commit (45b32b946a97 "riscv:
> > entry: Consolidate general regs saving/restoring")
> >
> >   - patch 3: to pass the trace_selftest, add the implement of
> >     `ftrace_stub_direct_tramp` from commit (fee86a4ed536 "ftrace:
> > selftest: remove broken trace_direct_tramp") ; and fixup the context
> > conflict in Kconfig
> >
> > Changes in v8:
> > https://lore.kernel.org/linux-riscv/20230324033342.3177979-1-suagrfille=
t@gmail.com/
> >  - Fix incorrect address values in the 4nd patch
> >  - Rebased on v6.3-rc2
> >
> > Changes in v7:
> > https://lore.kernel.org/linux-riscv/20230112090603.1295340-1-guoren@ker=
nel.org/
> >  - Fixup RESTORE_ABI_REGS by remove PT_T0(sp) overwrite.
> >  - Add FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [1]
> >  - Fixup kconfig with HAVE_SAMPLE_FTRACE_DIRECT &
> >    HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> >
> > Changes in v6:
> > https://lore.kernel.org/linux-riscv/20230107133549.4192639-1-guoren@ker=
nel.org/
> >  - Replace 8 with MCOUNT_INSN_SIZE
> >  - Replace "REG_L a1, PT_RA(sp)" with "mv a1, ra"
> >  - Add Evgenii Shatokhin comment
> >
> > Changes in v5:
> > https://lore.kernel.org/linux-riscv/20221208091244.203407-1-guoren@kern=
el.org/
> >  - Sort Kconfig entries in alphabetical order.
> >
> > Changes in v4:
> > https://lore.kernel.org/linux-riscv/20221129033230.255947-1-guoren@kern=
el.org/
> >  - Include [3] for maintenance. [Song Shuai]
> >
> > Changes in V3:
> > https://lore.kernel.org/linux-riscv/20221123153950.2911981-1-guoren@ker=
nel.org/
> >  - Include [2] for maintenance. [Song Shuai]
> >
> > [1]: https://lore.kernel.org/linux-riscv/CAAYs2=3Dj3Eak9vU6xbAw0zPuoh00=
rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
> > [2]: https://lore.kernel.org/lkml/20221120084230.910152-1-suagrfillet@g=
mail.com/
> > [3]: https://lore.kernel.org/linux-riscv/20221123142025.1504030-1-suagr=
fillet@gmail.com/
> >
> > Song Shuai (4):
> >   riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> >   riscv: ftrace: Add ftrace_graph_func
> >   riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
> >   samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
> >
> >  arch/riscv/Kconfig                          |   4 +
> >  arch/riscv/include/asm/ftrace.h             |  19 +-
> >  arch/riscv/kernel/ftrace.c                  |  30 ++-
> >  arch/riscv/kernel/mcount-dyn.S              | 200 ++++++++++++++++----
> >  samples/ftrace/ftrace-direct-modify.c       |  34 ++++
> >  samples/ftrace/ftrace-direct-multi-modify.c |  40 ++++
> >  samples/ftrace/ftrace-direct-multi.c        |  24 +++
> >  samples/ftrace/ftrace-direct-too.c          |  27 +++
> >  samples/ftrace/ftrace-direct.c              |  23 +++
> >  9 files changed, 345 insertions(+), 56 deletions(-)
> >
> > --
> > 2.20.1
> >
>
>
> --
> Thanks,
> Song



--=20
Thanks,
Song
