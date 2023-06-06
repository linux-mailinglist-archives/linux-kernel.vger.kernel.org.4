Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0B724F15
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbjFFV46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjFFV4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:56:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135AD106;
        Tue,  6 Jun 2023 14:56:54 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1ba50e50bso48268861fa.1;
        Tue, 06 Jun 2023 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686088612; x=1688680612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDmchV2EZ5N2uZl8eHSou3jpN/HDIWm3VmuAYyYE1Jk=;
        b=V2V+yjiIMR5GmQDM4HUmiMDxFmbGKSCdVFVbh439lRphfgVAQHqFKgPMVRexPl2/sk
         ed3LH6ZACYDBDXk2fG5jGMuEaXAvo7VVclTIjbxA0Lb3D4qkdKJORZZVEcQXQcxWM4uD
         KS7hXcUbms3ubg90mmREn4Uvfwmkww01BsVZaJxzOEvLrbWZ99LlN3UCq7vf+OpWD6wp
         t8D3XBzRQL4HjjLy9GZOUrVxAY3Hiya7iYj/2olIPo53Oejm3nRPXFQJMpsrP0iDt4xi
         Avn917bPKJw5KMY0iuKAtH0Rlua0/Yqh+yS8HOtjqwFCrgsQk8N39XUUgaTNvw68Azpr
         38ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686088612; x=1688680612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDmchV2EZ5N2uZl8eHSou3jpN/HDIWm3VmuAYyYE1Jk=;
        b=Td27NoN9CGKPi1294sqUP+Zy51OVSWJRdvCkaHhLi2DRuxqCtEC8EzzRquZKddJPo/
         ebJejmnqRubIOx+iqNIIk+PJQrNJvr1EdM5sK9yn9jmzw0CNoVNd2Bvx4MvV3mo5fXlS
         anJbVYaAePAu0TZpEkEvhq9uidKnloOJ113ng54o57mmtrInuRRXe7PItHp2ibKP9XlI
         RCT8wR9z+0MUSDNtiNir+hRE+KFPnRWqQwlwuXJvBP6SvKTkWSlqgOGGSdjOPoOoQ3jp
         4yAbGOE6F7FxjJdXL8/goHZ/KrfYPkMHToZJUKKIjiYw4fVTYyZlqxYblY6aHT1kSyjc
         BVhg==
X-Gm-Message-State: AC+VfDw1rrtitVPVDGhn8a8udn0Lpg0CYhByWE25TgzplR26ULBxAZy6
        xDZu9jqqoYPZgHEUQkux8VSE+VtclsY8kzrlPbk=
X-Google-Smtp-Source: ACHHUZ4PSjRpDoukaJoqwLq3vngvXA9fOeau95bjEnoIcWdDnphPhmt1TMB7pHqySUHSuosEip5R7QTbFIljxPVUF+Q=
X-Received: by 2002:a2e:8097:0:b0:2b1:eba8:9cd9 with SMTP id
 i23-20020a2e8097000000b002b1eba89cd9mr1989799ljg.21.1686088611835; Tue, 06
 Jun 2023 14:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <202306070408.EFxuDoRs-lkp@intel.com> <20230606215212.r7if2gsynajugf6j@treble>
In-Reply-To: <20230606215212.r7if2gsynajugf6j@treble>
From:   Alex Gaynor <alex.gaynor@gmail.com>
Date:   Tue, 6 Jun 2023 17:56:40 -0400
Message-ID: <CAFRnB2VJYrjUFAMq1v+Yxmz57KWOBF6z+09A6kSzcdLpbNKs2g@mail.gmail.com>
Subject: Re: [tip:objtool/core 8/12] vmlinux.o: warning: objtool:
 rust_begin_unwind+0x5c: rust_helper_BUG() is missing a __noreturn annotation
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix to properly handle noreturn is present in bindgen > 0.61.0.
Per min-tool-version.sh, we currently only require bindgen 0.56.0 or
newer.

I'm not sure if there are obstacles to requiring a newer bindgen
version, at which point the loop {} would not be required.

Cheers,
Alex

On Tue, Jun 6, 2023 at 5:52=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Hi Miguel, Wedson,
>
> Objtool detected that rust_helper_BUG() doesn't return, and seems to be
> missing a __noreturn.  But it actually *does* have __noreturn.  The
> problem is actually that its rust callees don't seem to know that, i.e.
> they assume it returns.
>
> After a little digging I found this comment in rust panic():
>
>     unsafe { bindings::BUG() };
>     // Bindgen currently does not recognize `__noreturn` so `BUG` returns=
 `()`
>     // instead of `!`. See <https://github.com/rust-lang/rust-bindgen/iss=
ues/2094>.
>     loop {}
>
> So it seems to be an issue with bindgen, though that github issue has
> been resolved.  Any idea when this will show up in a toolchain?
>
> In the meantime we may have to get objtool to manually silence the
> warning, unless you have any better ideas.
>
> On Wed, Jun 07, 2023 at 04:57:42AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git obj=
tool/core
> > head:   ff9a6459bbec06df7da2545020d7383aba13b3fb
> > commit: fedb724c3db5490234ddde0103811c28c2fedae0 [8/12] objtool: Detect=
 missing __noreturn annotations
> > config: x86_64-randconfig-a012-20230606 (https://download.01.org/0day-c=
i/archive/20230607/202306070408.EFxuDoRs-lkp@intel.com/config)
> > compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.gi=
t 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> > reproduce (this is a W=3D1 build):
> >         mkdir -p ~/bin
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/c=
ommit/?id=3Dfedb724c3db5490234ddde0103811c28c2fedae0
> >         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/=
git/tip/tip.git
> >         git fetch --no-tags tip objtool/core
> >         git checkout fedb724c3db5490234ddde0103811c28c2fedae0
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang ~/bin/make.=
cross W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 olddefconfig
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang ~/bin/make.=
cross W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202306070408.EFxuDoRs-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> vmlinux.o: warning: objtool: rust_begin_unwind+0x5c: rust_helper_BUG=
() is missing a __noreturn annotation
> >
> >
> > objdump-func vmlinux.o rust_begin_unwind:
> > 0000 00000000000b9e69 <rust_begin_unwind>:
> > 0000    b9e69:        48 83 ec 48             sub    $0x48,%rsp
> > 0004    b9e6d:        48 89 e0                mov    %rsp,%rax
> > 0007    b9e70:        48 89 38                mov    %rdi,(%rax)
> > 000a    b9e73:        48 8d 4c 24 08          lea    0x8(%rsp),%rcx
> > 000f    b9e78:        48 89 01                mov    %rax,(%rcx)
> > 0012    b9e7b:        48 c7 41 08 00 00 00 00         movq   $0x0,0x8(%=
rcx)   b9e7f: R_X86_64_32S     _RNvXsR_NtCs3yuwAp0waWO_4core3fmtRNtNtNtB7_5=
panic10panic_info9PanicInfoNtB5_7Display3fmtCsfATHBUcknU9_6kernel
> > 001a    b9e83:        48 8d 54 24 18          lea    0x18(%rsp),%rdx
> > 001f    b9e88:        48 c7 02 00 00 00 00    movq   $0x0,(%rdx)      b=
9e8b: R_X86_64_32S     .rodata+0x137d8
> > 0026    b9e8f:        48 c7 42 08 02 00 00 00         movq   $0x2,0x8(%=
rdx)
> > 002e    b9e97:        48 c7 42 10 00 00 00 00         movq   $0x0,0x10(=
%rdx)
> > 0036    b9e9f:        48 89 4a 20             mov    %rcx,0x20(%rdx)
> > 003a    b9ea3:        48 c7 42 28 01 00 00 00         movq   $0x1,0x28(=
%rdx)
> > 0042    b9eab:        48 c7 c7 00 00 00 00    mov    $0x0,%rdi        b=
9eae: R_X86_64_32S     _RNvNtNtCsfATHBUcknU9_6kernel5print14format_strings5=
EMERG
> > 0049    b9eb2:        48 c7 c6 00 00 00 00    mov    $0x0,%rsi        b=
9eb5: R_X86_64_32S     .rodata+0x13568
> > 0050    b9eb9:        31 c0                   xor    %eax,%eax
> > 0052    b9ebb:        e8 00 00 00 00          call   b9ec0 <rust_begin_=
unwind+0x57>   b9ebc: R_X86_64_PLT32   _printk-0x4
> > 0057    b9ec0:        e8 00 00 00 00          call   b9ec5 <rust_begin_=
unwind+0x5c>   b9ec1: R_X86_64_PLT32   rust_helper_BUG-0x4
> > 005c    b9ec5:        eb fe                   jmp    b9ec5 <rust_begin_=
unwind+0x5c>
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
>
> --
> Josh



--=20
All that is necessary for evil to succeed is for good people to do nothing.
