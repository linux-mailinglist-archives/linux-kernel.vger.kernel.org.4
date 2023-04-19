Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1648C6E8554
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjDSWzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjDSWzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:55:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57D810CC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:55:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so304620a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681944926; x=1684536926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyRogtapyL62quUkMifj1N5o1jIvaCx3OU7N+mYKl3c=;
        b=zgcn7uqlwZemZB6SRHJezEWcMPMC3EU1G58C2QGqG9BuNwlOCDGvpSs4UdCshRFIbK
         5F+Y0VAhoU2mZIbPuC//+3aPNp5sRPBp/quSOqrmpoOEKur6bZtjnCqK6PMziDddhhmm
         D6dd4ZswFbQ+Nf9/yxwZAH/QFzelqHUTCO7jigMpOLulWY/LIL4KcNISo0eZtb9zcW+g
         BvlbOR2aFCZGcYbO3oIkTEsw7nsAR4+bmoOUQbw9IQxVBedT9fic88gcff6uaq+cXLst
         W71g4RCu64P6p9F0kIT5bRF7VU5Q0TPcorr6dRfRx0KIS/bFL5D4+m5kUYG0RLtaEzIx
         W8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681944926; x=1684536926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyRogtapyL62quUkMifj1N5o1jIvaCx3OU7N+mYKl3c=;
        b=dPtpeJ7LrltHUrOvj7GVDfeHue6Or53bPp7o3JR7VVFhBUNWr1rF2OZhOFhaar4LZi
         Ltzm1ZxRXlX9UAXaJQp8Z9aYvFdD3s3kUBhbsp9pgD6qCVIHcoho9Qph2kD17KEQ/Pfc
         lwbBfDBlSl6fLeP5gkqPjEyi/bmfMR2fw6bPt7v/vfb2vrkBFbPhAkuQeQsJgkTdY3vs
         oECtLOWnjHp7tzKxTzGZQXLazev4zN8R9MpQdVmAGLGZU/1/mZftNbFxwDzg/S6XUjQH
         Mnljrj7YeRh+9pPQSfYSQGXSJIj0bhomjXDzAQ6lFR0tEqt8v/mM9BZWzbv0G1BxzrjF
         X9Mg==
X-Gm-Message-State: AAQBX9cqWjTkpu5OPFk/EhF+7bnWlUa8YfzyUwAo15YqV/5+Y7MEoUt6
        RLYbqxHvsm8bXvzDH8gIB+N++lLxX7Hs5FpQ2dmUjQ==
X-Google-Smtp-Source: AKy350YSbrzcG4PFWvVmTuSuqfhWPWoEs4SefcDCHV6R08LRBmgpJKk5rcAWgiQOqffn/5qe0kjZCJ7Lgmsfhs/AGvU=
X-Received: by 2002:a17:90a:fb50:b0:246:a599:1ccd with SMTP id
 iq16-20020a17090afb5000b00246a5991ccdmr4167783pjb.16.1681944926241; Wed, 19
 Apr 2023 15:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230414005309.GA2198310@google.com> <CAKwvOd=yQS+0oDC46Hc5D_V0JET8=xbQmAJrpBdg7c4i2EyqHg@mail.gmail.com>
 <20230418203611.GA3640630@google.com> <CAKwvOdnxCJo-FoPfcNw=SBum6yRXOY7_meT8T6gsjV3c3FFm5A@mail.gmail.com>
 <20230418210321.GA3648938@google.com>
In-Reply-To: <20230418210321.GA3648938@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Apr 2023 15:55:13 -0700
Message-ID: <CAKwvOdm-3HABzj6BfdnDsrDO1D19cSJ4z5kMeDwEk1pPGxwYhg@mail.gmail.com>
Subject: Re: clangd cannot handle tree_nocb.h
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, nathan@kernel.org, trix@redhat.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 2:03=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hi Nick,
>
> On Tue, Apr 18, 2023 at 01:46:40PM -0700, Nick Desaulniers wrote:
> > On Tue, Apr 18, 2023 at 1:36=E2=80=AFPM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > On Fri, Apr 14, 2023 at 03:47:51PM -0700, Nick Desaulniers wrote:
> > > > On Thu, Apr 13, 2023 at 5:53=E2=80=AFPM Joel Fernandes <joel@joelfe=
rnandes.org> wrote:
> > > > >
> > > > > Hello!
> > > > >
> > > > > I have been trying to get clangd working properly with tree_nocb.=
h. clangd
> > > > > trips quite badly when trying to build tree_nocb.h to generate AS=
Ts.
> > > >
> > > > Hi Joel,
> > > > Thanks for the report.  What are you using clangd for? I'll bet
> > > > something interesting.
> > >
> > > Thanks for the response and sorry for the late reply. I am at the OSP=
M
> > > conference. I use vim and vscode with clangd. In vim, YCM uses it to
> > > highlight compiler errors live while editing, I am pretty happy with =
it so
> > > far and has been a huge time saver. Enough that now I want to use it =
for
> > > everything...
> >
> > Cool! I use vim, can you share more info about your set up for this?
> > I'll have to try it.
>
> This is how I installed YCM:
>
> # Install YouCompleteMe for vim
> # cd ~/.vim/bundle
> # git clone https://github.com/Valloric/YouCompleteMe.git
> # cd YouCompleteMe/
> # git submodule update --init --recursive
> # python3 install.py --clang-completer

Thanks, I needed to add this
set runtimepath+=3D~/.vim/bundle/YouCompleteMe/
to my ~/.vimrc as well. Via
https://stackoverflow.com/q/60797142
so not sure I fully installed YCM since I didn't see `runtimepath` in
https://github.com/ycm-core/YouCompleteMe, but it's working now for me! Coo=
l!

>
> Then install and run bear in the kernel sources to generate
> compile_compands.json:
> bear -- make -j99 CC=3Dclang
>
> However, there's also the script:
> scripts/clang-tools/gen_compile_commands.py
>
> This generates the .json from an existing build. Thank God because we can
> probably make this generate better .json files which may make clangd bett=
er.

So we have a compile_commands.json make target. All I did was:

$ make LLVM=3D1 -j128 compile_commands.json

it invokes that python script you found which parses the *.o.cmd files
produced from a build.  Unfortunately, that requires a completed
build, and IIRC I think `make clean` deletes compile_commands.json.  I
think we might only want to do that for mrproper...

>
> You don't need YCM to reproduce the issue though if you just use vscode w=
ith
> the clangd plugin.
>
> > > I first came across clangd when developing Chrome userspace code whic=
h is C++
> > > :). In Chrome, ninja builds can be made to output compile_commands.js=
on.
> > > However, now I noticed the support in the kernel and was like, wow I =
need to
> > > try it. Further, YCM seems to work much better with it than without :=
)
> > >
> > > > I've never used it myself, so I don't know where to even begin with
> > > > how to reproduce the issue.
> > >
> > > Ah ok. :). When I ran get_maintainer on the script, your name popped =
up and
> > > someone also suggested that you're the goto person for clang on the k=
ernel
> > > (which I kind of already knew ;)
> >
> > You've cc'ed the right set of folks.  We might not have the expertise
> > related to clangd specifically, but we can point you in the right
> > direction.
>
> Sure, thanks! And thanks for CC'ing the right folks.
>
> > > > It might be worth filing a bug upstream at
> > > > https://github.com/llvm/llvm-project/issues
> > > > or internally under the component
> > > > Language Platforms > C++ > Clang > Tools > Clangd
> > > > with detailed steps to reproduce (and what the observed error actua=
lly
> > > > is). Feel free to cc me, though I don't know the first thing about
> > > > clangd.
> > >
> > > Ok I will consider doing this if needed. One thing I do observe is la=
ck of
> > > good support for header files and it is a known clangd issue [1].
> > >
> > > However, the fixes I was proposing can purely be done in the kernel i=
tself
> > > since all it'd require is generating compile_compands.json with the -=
D<macro>
> > > and editing files to keep clangd happy. I guess one question is, how =
welcome
> > > would such changes to header files be since they're for tooling and i=
sn't
> > > code that will be compiled outside of clangd.
> >
> > Specifically your patch sites some log print that doesn't look
> > indicative of a failure:
> > https://github.com/llvm/llvm-project/blob/53430bfd5c9d0074dd6de06dccea3=
66e1d40bce4/clang-tools-extra/clangd/TUScheduler.cpp#L903-L906
> > so something else is going on here. Just trying to make sure we root ca=
use this.
> >
>
> Right, so clangd's log does not show failure, the failure is when it disp=
lays
> in the code editor that your code has compiler errors when in fact it doe=
s
> not.
>
> So if you open up tree_nocb.h in vscode, for example, you'll see squiggle=
s
> saying 'undefined reference to rcu_data', etc. That makes clangd stop wor=
king
> at the error. Sorry to not make the failure mode clear earlier.

In vim, the very first line is highlighted with:
Too many errors emitted, stopping now [fatal_too_many_errors]
I guess that disables nice checking that's done in .c files?
--=20
Thanks,
~Nick Desaulniers
