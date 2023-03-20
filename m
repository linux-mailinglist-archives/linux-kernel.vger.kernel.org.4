Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B856C204F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjCTStW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCTSsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:48:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4472E37F0A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:41:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h8so13486983plf.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679337690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sebx0TlAgxAANslvKkDYNuoP3rxT8jA6wy3Ud58CnGE=;
        b=Q+XtM/4GZZl+47UGm6LV0ISK3CCTlqSZiMWauS4wYISNVA8jpv6Y6p3v3GmsvkilY7
         8SZOa/qbocKZAIa5eJbCcyi5nH1xPBF0ZNOlqEua8E1HbrqrXGv+T6sB1r84DH/7M5mf
         NWa88XZZdRq9KnWjSRRsVXYZM1wYm//kOxB4exBlxjV+yCSB3GUoRrroDT3OfpmZS2hc
         JSQddMLBksd4YWyc1EwnAfoP3VQEZKYUjmd+ay32ymwA27YRVByDZphYPrIUjv74pmfQ
         sjFFFsZa9ixp+xewlXQwF2WawYXBBm+kmU1GWbEeiNhpzg+IMmgwSKc2VdwS+E2sVVk/
         FJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sebx0TlAgxAANslvKkDYNuoP3rxT8jA6wy3Ud58CnGE=;
        b=JCIUwfY+ah3DCvrxQM2ZhSaYfsNwdeZ7vo31gck7Arb4xSOVJss73ily1yaQisfH5j
         ieWtT7c84nVdDn65EktB2d9Rm4y7cs92fZpNL5iOxWUKP9w/JCMkO2eqTuXHCihPoYI1
         0IKs0xKUf38g1ArPKLtJJvkCKIrDp/9Xa0xqUMzW620kkm9I+Z2OU5BkyPV3qZmDBsNh
         HrSGqve95A2bmssa8/WdEdCyxWHhY08Whp4r/LNJRDrfaVf30VOMw3XuF3rSKPdAlA2p
         YbSfSZ/s0bt/hyLKVyG55/nkghh6MICjv/1zCkZb1MOKTDM0+b8q56gQI3ceuZxDNdGs
         1uwg==
X-Gm-Message-State: AO0yUKUm5Xw7CD0jiA5HZCUZMa2dmTx2oQyXBuXWT6G6lwc4Oeq/0xVz
        m2tJ+GtNxNBvjVL71oXZI/wlmxNnlCUXSyC3MnryVg==
X-Google-Smtp-Source: AK7set/vhawYGH3DhT3/v6d5Ny4Jjt66TnVuAEbHphTcmhiCUIZFWQ7DMe0qgAMD0rlNa9YxBuWPuw6edly1Iv8yUR4=
X-Received: by 2002:a17:90a:6e45:b0:23c:fb7d:de70 with SMTP id
 s5-20020a17090a6e4500b0023cfb7dde70mr52766pjm.7.1679337689910; Mon, 20 Mar
 2023 11:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230308195933.806917-1-ndesaulniers@google.com> <CA+G9fYtTL+y-ZYeZXKHbVg9XiYVeHE-RaAjaRHTT+EfXO924cA@mail.gmail.com>
In-Reply-To: <CA+G9fYtTL+y-ZYeZXKHbVg9XiYVeHE-RaAjaRHTT+EfXO924cA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 20 Mar 2023 11:41:18 -0700
Message-ID: <CAKwvOdnM9WjxHY_uw_0nyhGTZDuQ+730NrX2sgw9cBLkrhF8oA@mail.gmail.com>
Subject: Re: [PATCH] selftests: sigaltstack: fix -Wuninitialized
To:     Shuah Khan <shuah@kernel.org>
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        Stas Sergeev <stsp@list.ru>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,
Did this get picked up? Just checking it doesn't fall through the cracks.
EOM

On Mon, Mar 13, 2023 at 2:50=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Thu, 9 Mar 2023 at 01:29, Nick Desaulniers <ndesaulniers@google.com> w=
rote:
> >
> > Building sigaltstack with clang via:
> > $ ARCH=3Dx86 make LLVM=3D1 -C tools/testing/selftests/sigaltstack/
> >
> > produces the following warning:
> >   warning: variable 'sp' is uninitialized when used here [-Wuninitializ=
ed]
> >   if (sp < (unsigned long)sstack ||
> >       ^~
> >
> > Clang expects these to be declared at global scope; we've fixed this in
> > the kernel proper by using the macro `current_stack_pointer`. This is
> > defined in different headers for different target architectures, so jus=
t
> > create a new header that defines the arch-specific register names for
> > the stack pointer register, and define it for more targets (at least th=
e
> > ones that support current_stack_pointer/ARCH_HAS_CURRENT_STACK_POINTER)=
.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Link: https://lore.kernel.org/lkml/CA+G9fYsi3OOu7yCsMutpzKDnBMAzJBCPimB=
p86LhGBa0eCnEpA@mail.gmail.com/
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Build and boot tested with clang-16 and tested sigaltstack
> on arm64, armv7, FVP, x86_64 and i386 [1] & [2].
> These tests were performed at Linaro test farm by Anders
> with the help of tuxplan / tuxmake and tuxrun.
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by:  Anders Roxell <anders.roxell@linaro.org>
>
>
> Build log:
> -------
> clang --target=3Daarch64-linux-gnu -fintegrated-as
> -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization-argument
> -Werror=3Doption-ignored -Werror=3Dunused-command-line-argument
> --target=3Daarch64-linux-gnu -fintegrated-as -Wall     sas.c  -o
> /home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/sigaltstack/sas
>
> Test log:
> ----------
>
> Linux version 6.3.0-rc1-next-20230310 (tuxmake@tuxmake) (Debian clang
> version 16.0.0 (++20230228093516+60692a66ced6-1~exp1~20230228093525.41),
> Debian LLD 16.0.0) #1 SMP PREEMPT @1678519789
> ...
>
> [   56.327569] kselftest: Running tests in sigaltstack
> TAP version 13
> 1..1
> # selftests: sigaltstack: sas
> # # [NOTE] the stack size is 26400
> # TAP version 13
> # 1..3
> # ok 1 Initial sigaltstack state was SS_DISABLE
> # # [RUN] signal USR1
> # ok 2 sigaltstack is disabled in sighandler
> # # [RUN] switched to user ctx
> # # [RUN] signal USR2
> # # [OK] Stack preserved
> # ok 3 sigaltstack is still SS_AUTODISARM after signal
> # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> ok 1 selftests: sigaltstack: sas
>
> Details of test log links provided [3].
>
> > ---
> > Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Cc: KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>
> > Cc: linux-api@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: lkft-triage@lists.linaro.org
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Stas Sergeev <stsp@list.ru>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Anders Roxell <anders.roxell@linaro.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: llvm@lists.linux.dev
> > ---
> >  .../sigaltstack/current_stack_pointer.h       | 23 +++++++++++++++++++
> >  tools/testing/selftests/sigaltstack/sas.c     |  7 +-----
> >  2 files changed, 24 insertions(+), 6 deletions(-)
> >  create mode 100644 tools/testing/selftests/sigaltstack/current_stack_p=
ointer.h
> >
> > diff --git a/tools/testing/selftests/sigaltstack/current_stack_pointer.=
h b/tools/testing/selftests/sigaltstack/current_stack_pointer.h
> > new file mode 100644
> > index 000000000000..ea9bdf3a90b1
> > --- /dev/null
> > +++ b/tools/testing/selftests/sigaltstack/current_stack_pointer.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#if __alpha__
> > +register unsigned long sp asm("$30");
> > +#elif __arm__ || __aarch64__ || __csky__ || __m68k__ || __mips__ || __=
riscv
> > +register unsigned long sp asm("sp");
> > +#elif __i386__
> > +register unsigned long sp asm("esp");
> > +#elif __loongarch64
> > +register unsigned long sp asm("$sp");
> > +#elif __ppc__
> > +register unsigned long sp asm("r1");
> > +#elif __s390x__
> > +register unsigned long sp asm("%15");
> > +#elif __sh__
> > +register unsigned long sp asm("r15");
> > +#elif __x86_64__
> > +register unsigned long sp asm("rsp");
> > +#elif __XTENSA__
> > +register unsigned long sp asm("a1");
> > +#else
> > +#error "implement current_stack_pointer equivalent"
> > +#endif
> > diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/=
selftests/sigaltstack/sas.c
> > index c53b070755b6..98d37cb744fb 100644
> > --- a/tools/testing/selftests/sigaltstack/sas.c
> > +++ b/tools/testing/selftests/sigaltstack/sas.c
> > @@ -20,6 +20,7 @@
> >  #include <sys/auxv.h>
> >
> >  #include "../kselftest.h"
> > +#include "current_stack_pointer.h"
> >
> >  #ifndef SS_AUTODISARM
> >  #define SS_AUTODISARM  (1U << 31)
> > @@ -46,12 +47,6 @@ void my_usr1(int sig, siginfo_t *si, void *u)
> >         stack_t stk;
> >         struct stk_data *p;
> >
> > -#if __s390x__
> > -       register unsigned long sp asm("%15");
> > -#else
> > -       register unsigned long sp asm("sp");
> > -#endif
> > -
> >         if (sp < (unsigned long)sstack ||
> >                         sp >=3D (unsigned long)sstack + stack_size) {
> >                 ksft_exit_fail_msg("SP is not on sigaltstack\n");
> > --
> > 2.40.0.rc0.216.gc4246ad0f0-goog
>
> log link:
> -----
> [1] https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/b=
uild/lore_kernel_org_linux-kselftest_20230308195933_806917-1-ndesaulniers_g=
oogle_com/?failures_only=3Dfalse#!?filter-tests=3Dkselftest-sigaltstack&det=
ails=3D#test-results
> [2] https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/b=
uild/lore_kernel_org_linux-kselftest_20230308195933_806917-1-ndesaulniers_g=
oogle_com/testrun/15468761/suite/kselftest-sigaltstack/test/sigaltstack_sas=
/log
> [3] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/anders/tests/2M=
rJ2e4bDCC4iZjIrnRqmnE7KfC
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org



--=20
Thanks,
~Nick Desaulniers
