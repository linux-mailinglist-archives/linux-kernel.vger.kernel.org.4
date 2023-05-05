Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4416F894A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjEETGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjEETGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:06:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92179ED9
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:06:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aae90f5ebcso625565ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683313601; x=1685905601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/pJFPF6XDQ2lM0mX2EEDsBVu2i8kXIUDFE5knvpspY=;
        b=WDRbXcJjx3hmzwNQnY1YucpNmSqW22C7wbZapKWHkAVi0+1W9aRoOUOaiAZcy2TY2f
         WEoQPHvUgbeWt47I3LcSn35vzGAx94JZfTGcOtUakPkEZ+6Ia7JwTo50Hg7i9PONj1U/
         TlTS3MRfDzzBgvWBwQgcRgB+s/ZSD164i7aci7hL9wH9XO+r5vblWLbmKHjgXzHPZj/k
         cbucdU0kQzD4nfmYhsU1oW+thEuVxiNkjVggTUZEpmKaZ5dOJe+9oLzXwVXTLCRWIbRt
         jj1w6YoVRScIfu51NuzCnP5PsqOvhuWu2ly5Am5R1TNqKKt1nrWzaXnEB3QnKIg/grWu
         gPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683313601; x=1685905601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/pJFPF6XDQ2lM0mX2EEDsBVu2i8kXIUDFE5knvpspY=;
        b=R65VjY+3kdbtdPReJOVk93psHKCKZPHJxYKyoDzdFGl8RDW3BTr/Qd3MxW01+AdiwM
         df3XXY8bt8CbCwse9XsnsC0Knf+B6WfwDnP22lq+OWp75H7YDgLiXfOdncUbiXq7Qdu/
         dBBewPlamYmCuOLa6KLg7DA0+kmS6QQxUgbQPayU/96CRyfEy/FCy30eO6+jhy56E4Lx
         KE+pS1dwvZCdSYAEBu4gdZ1ztc9D9Z5YhEAskQDgtSrifHpT3EPM4baJLXOENTTBLdOs
         sWukNuITE6fYeuqw8jHDDzPGJlaDX3Pn6z5fpSWFfUEdSSwedqje4fUGXQBULIXZbIej
         UbKQ==
X-Gm-Message-State: AC+VfDwGftxU8jg6pBT8/wmYE1Pm6pqnYIMTiHU91VZ/nmLLbowoLiLz
        3AmnBJhrnAhlXzWbCT+wkfKCDwbtL4v+SaF4ZbPh4Q==
X-Google-Smtp-Source: ACHHUZ6Gm4a1l0IBB74DNpxBl+mkjinCwczPciXZj1XpQLD0ljcS3eVgQV/VDAUs5XQkWlavJssNoUxeJjDl1SP+9BQ=
X-Received: by 2002:a17:902:d2c3:b0:1aa:e90c:d437 with SMTP id
 n3-20020a170902d2c300b001aae90cd437mr22203plc.8.1683313600977; Fri, 05 May
 2023 12:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <7cee0c83225ffd8cf8fd0065bea9348f6db3b12a.1682673543.git.houwenlong.hwl@antgroup.com>
 <CAKwvOd=zgjWdg2+_bg3QByh_2hve8yoKzCfEBZ5md+k8ytkqcQ@mail.gmail.com>
 <20230505061420.GB103506@k08j02272.eu95sqa> <CAKwvOdkWt8FpqegyaGRNdF067dwwFEGze-nqR+yF=TA1FnTozg@mail.gmail.com>
In-Reply-To: <CAKwvOdkWt8FpqegyaGRNdF067dwwFEGze-nqR+yF=TA1FnTozg@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Fri, 5 May 2023 12:06:29 -0700
Message-ID: <CAFP8O3JEa95NRKKJZSGNphqAGEm-VEGdTg9zgLZtuE-7U_zi8A@mail.gmail.com>
Subject: Re: [PATCH RFC 16/43] x86-64: Use per-cpu stack canary if supported
 by compiler
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        x86@kernel.org, Nathan Chancellor <nathan@kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 11:02=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, May 4, 2023 at 11:14=E2=80=AFPM Hou Wenlong <houwenlong.hwl@antgr=
oup.com> wrote:
> >
> > On Tue, May 02, 2023 at 01:27:53AM +0800, Nick Desaulniers wrote:
> > > On Fri, Apr 28, 2023 at 2:52=E2=80=AFAM Hou Wenlong <houwenlong.hwl@a=
ntgroup.com> wrote:
> > > >
> > > > +config CC_HAS_CUSTOMIZED_STACKPROTECTOR
> > > > +       bool
> > > > +       # Although clang supports -mstack-protector-guard-reg optio=
n, it
> > > > +       # would generate GOT reference for __stack_chk_guard even w=
ith
> > > > +       # -fno-PIE flag.
> > > > +       default y if (!CC_IS_CLANG && $(cc-option,-mstack-protector=
-guard-reg=3Dgs))
> > >
> > > Hi Hou,
> > > I've filed this bug against LLVM and will work with LLVM folks at
> > > Intel to resolve:
> > > https://github.com/llvm/llvm-project/issues/62481
> > > Can you please review that report and let me know here or there if I
> > > missed anything? Would you also mind including a link to that in the
> > > comments in the next version of this patch?
> > >
> > Hi Nick,
> >
> > Thanks for your help, I'll include the link in the next version.
> > Actually, I had post an issue on github too when I test the patch on
> > LLVM. But no replies. :(.
>
> Ah, sorry about that.  The issue tracker is pretty high volume and
> stuff gets missed.  With many users comes many bug reports.  We could
> be better about triage though.  If it's specific to the Linux kernel,
> https://github.com/ClangBuiltLinux/linux/issues is a better issue
> tracker to use; we can move bug reports upstream to
> https://github.com/llvm/llvm-project/issues/ when necessary. It's
> linked off of clangbuiltlinux.github.io if you lose it.
>
> > https://github.com/llvm/llvm-project/issues/60116
> >
> > There is another problem I met for this patch, some unexpected code
> > are generated:
> >
> > do_one_initcall: (init/main.o)
> > ......
> > movq    __stack_chk_guard(%rip), %rax
> > movq    %rax,0x2b0(%rsp)
> >
> > The complier generates wrong instruction, no GOT reference and gs
> > register. I only see it in init/main.c file. I have tried to move the
> > function into another file and compiled it with same cflags. It could
> > generate right instruction for the function in another file.
>
> The wrong instruction or the wrong operand?  This is loading the
> canary into the stack slot in the fn prolog.  Perhaps the expected
> cflag is not getting set (or being removed) from init/main.c? You
> should be able to do:
>
> $ make LLVM=3D1 init/main.o V=3D1
>
> to see how clang was invoked to see if the expected flag was there, or no=
t.
>
> >
> > The LLVM chain toolsare built by myself:
> > clang version 15.0.7 (https://github.com/llvm/llvm-project.git
> > 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
>
> Perhaps worth rebuilding with top of tree, which is clang 17.
>
> >
> > > Less relevant issues I filed looking at some related codegen:
> > > https://github.com/llvm/llvm-project/issues/62482
> > > https://github.com/llvm/llvm-project/issues/62480
> > >
> > > And we should probably look into:
> > > https://github.com/llvm/llvm-project/issues/22476
> > >
> > >
> >
> > Except for per-cpu stack canary patch, there is another issue I post on
> > github: https://github.com/llvm/llvm-project/issues/60096
>
> Thanks, I'll bring that up with Intel, too.
>
> >
> > The related patch is:
> > https://lore.kernel.org/lkml/175116f75c38c15d8d73a03301eab805fea13a0a.1=
682673543.git.houwenlong.hwl@antgroup.com/
> >
> > I couldn't find the related documentation about that, hope you can help
> > me too.
> >
> > One more problem that I didn't post is:
> > https://lore.kernel.org/lkml/8d6bbaf66b90cf1a8fd2c5da98f5e094b9ffcb27.1=
682673543.git.houwenlong.hwl@antgroup.com/
>
> Mind filing another bug for this in llvm's issue tracker? We can
> discuss there if LLD needs to be doing something different.
>
> Thanks for uncovering these and helping us get them fixed up!
> --
> Thanks,
> ~Nick Desaulniers

In my opinion, Clang's behavior is working as intended. The Linux
kernel should support R_X86_64_REX_GOTPCRELX, and the solution is
straightforward: treat R_X86_64_REX_GOTPCRELX the same way as
R_X86_64_PC32 (-shared -Bsymbolic), assuming that every symbol is
defined, which means that every symbol is non-preemptible.

Clang's `-fno-pic` option chooses `R_X86_64_REX_GOTPCRELX` which is
correct, although it differs from GCC's `-fno-pic` option.

The compiler doesn't know whether `__stack_chk_guard` will be provided
by the main executable (`libc.a`) or a shared object (`libc.so`,
available on some ports of glibc but not x86, on musl this is
available for all ports).
(Also see `__stack_chk_guard` on
https://maskray.me/blog/2022-12-18-control-flow-integrity)

If an `R_X86_64_32` relocation is used and `__stack_chk_guard` is
defined by a shared object, copy relocation.
We will need an ELF hack called [copy
relocation](https://maskray.me/blog/2021-01-09-copy-relocations-canonical-p=
lt-entries-and-protected).

The instruction movq __stack_chk_guard@GOTPCREL(%rip), %rbx produces
an R_X86_64_REX_GOTPCRELX relocation.
If `__stack_chk_guard` is non-preemptible, linkers can [optimize the
access to be direct](https://maskray.me/blog/2021-08-29-all-about-global-of=
fset-table#got-optimization).

Although we could technically use the
`-fno-direct-access-external-data` option to switch between
`R_X86_64_REX_GOTPCRELX` and `R_X86_64_32`, I think there is no
justification to complicate the compiler.



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
