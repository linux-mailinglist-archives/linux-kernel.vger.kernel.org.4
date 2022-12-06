Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028E2643C3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiLFEZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLFEZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:25:33 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2E81A22E;
        Mon,  5 Dec 2022 20:25:32 -0800 (PST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2B64PIig018332;
        Tue, 6 Dec 2022 13:25:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2B64PIig018332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1670300719;
        bh=lRhwG5d1oTcfBZkynjSenWdo4di6NnnnWPwMnzU2Xzw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XY6WTM2Cf5i8tFHGXSM2VOoF6nngwWkXMnUiUJ0+SS/iOFb/GVjHRprI+0hK4XjOJ
         mfiqYb8q5GHvKtaRaPaVW/9LS3HVcehR2hbqLHZjp9JkXpDSs9A7jfSw4c+jy/+zgD
         EFJ3wwMfNWNLWmkFofTfRgTMNCUps19mRjEGHURg0b1bItMT1bIkBMLsz1mzU+RKp4
         sQF3ZTnhWxKF56K+c5dDw9XO2SxKR1KGZjlVI8k1skOV2846YS8jDRmGxLKs0W3PDj
         QqDTsUUTXWW9/AQjPy0UX7BEfm1ifLdG9MWSqIjQ4AkRoH8hTuljQxMM7Xh3M9y6Kf
         1y/pn/BhybFGw==
X-Nifty-SrcIP: [209.85.167.182]
Received: by mail-oi1-f182.google.com with SMTP id v70so7226371oie.3;
        Mon, 05 Dec 2022 20:25:18 -0800 (PST)
X-Gm-Message-State: ANoB5pkxBl7R/CtjyAlBqjk40tZGAHjz7wimoPKKG78US/rRKYSKchwG
        uWc7GFQQ8YsQHcsrkThyRg8QhEx2v+ziYW1eg90=
X-Google-Smtp-Source: AA0mqf7R6bvx9C8DxH0OpzLBptbqxc8k8+7Z54KBrm/jOWiB+tWfc38sQV54qx9STVLGuBPN1Luxp84N+6JOWgAIOIQ=
X-Received: by 2002:aca:1c06:0:b0:354:28ae:23b3 with SMTP id
 c6-20020aca1c06000000b0035428ae23b3mr32579050oic.287.1670300717668; Mon, 05
 Dec 2022 20:25:17 -0800 (PST)
MIME-Version: 1.0
References: <20221027162839.410720-1-masahiroy@kernel.org> <202211161056.1B9611A@keescook>
 <CAK7LNATWbvpovH8qsGMX-5-31QiQ6pjKNnm+YEDEqr4io1hrSw@mail.gmail.com> <202211161406.EF075E28E9@keescook>
In-Reply-To: <202211161406.EF075E28E9@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 6 Dec 2022 13:24:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASBwfyt_2dbT1-MEcGwF8hQogJgjYnEE-e-twtL1WNYhg@mail.gmail.com>
Message-ID: <CAK7LNASBwfyt_2dbT1-MEcGwF8hQogJgjYnEE-e-twtL1WNYhg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: fix SIGPIPE error message for AR=gcc-ar and AR=llvm-ar
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kbuild@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 7:07 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Nov 17, 2022 at 05:37:31AM +0900, Masahiro Yamada wrote:
> > On Thu, Nov 17, 2022 at 4:01 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Oct 28, 2022 at 01:28:39AM +0900, Masahiro Yamada wrote:
> > > > Jiri Slaby reported that building the kernel with AR=gcc-ar shows:
> > > >   /usr/bin/ar terminated with signal 13 [Broken pipe]
> > > >
> > > > Nathan Chancellor reported the latest AR=llvm-ar shows
> > > >   error: write on a pipe with no reader
> > > >
> > > > The latter occurs since LLVM commit 51b557adc131 ("Add an error message
> > > > to the default SIGPIPE handler").
> > > >
> > > > The resulting vmlinux is correct, but it is better to silence it.
> > > >
> > > > 'head -n1' exits after reading the first line, so the pipe is closed.
> > > >
> > > > Use 'sed -n 1p' to eat the stream till the end.
> > >
> > > I think this is wrong because it needlessly consumes CPU time. SIGPIPE
> > > is _needed_ to stop a process after we found what we needed, but it's up
> > > to the caller (the shell here) to determine what to do about it.
> > >
> > > Similarly, that LLVM commit is wrong -- tools should _not_ catch their
> > > own SIGPIPEs. They should be caught by their callers.
> > >
> > > For example, see:
> > >
> > > $ seq 10000 | head -n1
> > > 1
> > >
> > > ^^^ no warnings from the shell (caller of "seq")
> > > And you can see it _is_ being killed by SIGPIPE:
> > >
> > > $ strace seq 1000 | head -n1
> > > ...
> > > write(1, "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14"..., 8192) = 8192
> > > 1
> > > write(1, "\n1861\n1862\n1863\n1864\n1865\n1866\n1"..., 4096) = -1 EPIPE (Broken pipe)
> > > --- SIGPIPE {si_signo=SIGPIPE, si_code=SI_USER, si_pid=3503448, si_uid=1000} ---
> > > +++ killed by SIGPIPE +++
> > >
> > > If we use "sed -n 1p" seq will continue to run, consuming needless time
> > > and CPU resources.
> > >
> > > So, I strongly think this is the wrong solution. SIGPIPE should be
> > > ignored for ar, and LLVM should _not_ catch its own SIGPIPE.
> > >
> > > -Kees
> >
> >
> > I thought of this - it is just wasting CPU time,
> > but I did not come up with a better idea on the kbuild side.
> >
> > I do not want to use 2>/dev/null because it may hide
> > non-SIGPIPE (i.e. real) errors.
>
> Yes, I've opened an upstream LLVM bug for this:
> https://github.com/llvm/llvm-project/issues/59037
>
> --
> Kees Cook



BTW, Python does something similar by default.
(noisy back-trace for SIGPIPE)





masahiro@zoe:/tmp$ cat test.py
#!/usr/bin/python3
for i in range(4000):
    print(i)

masahiro@zoe:/tmp$ ./test.py  |  head -n1
0
Traceback (most recent call last):
  File "/tmp/./test.py", line 3, in <module>
    print(i)
BrokenPipeError: [Errno 32] Broken pipe






This page
https://www.geeksforgeeks.org/broken-pipe-error-in-python/

suggests some workarounds.





Python scripts potentially have this issue.






$ ./scripts/diffconfig  .config.old  .config  | head -n1
-104_QUAD_8 m
Traceback (most recent call last):
  File "/home/masahiro/ref/linux/./scripts/diffconfig", line 132, in <module>
    main()
  File "/home/masahiro/ref/linux/./scripts/diffconfig", line 111, in main
    print_config("-", config, a[config], None)
  File "/home/masahiro/ref/linux/./scripts/diffconfig", line 62, in print_config
    print("-%s %s" % (config, value))
BrokenPipeError: [Errno 32] Broken pipe







What would you suggest for python scripts?






-- 
Best Regards
Masahiro Yamada
