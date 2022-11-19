Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441FA6311A6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 00:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKSXB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 18:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKSXBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 18:01:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A770912AFD
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 15:01:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso10218105wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 15:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BNpFPLPiDI5ooyd0feHp/EZ7Ej+27FmVQUDtDTXnGJc=;
        b=NYTdnadkJQNEPF4FlUFgxVHpblUrBkFAu5cjsRBsoZf0HXjUsjqyJLFjyS2619zLGU
         vcsvDAmV9jCpgd5UoRgGpSFK7F/oN3Hg5dm3C/6RqXAFtHH/McxWZlyVIVq6MmpWgX4N
         m1x0+bBp+9nhUQrH+8cdVo3djigHrKOQboQihewrx+vBxwQNk7R++984dweN8G8txWNT
         hvoZZtu7EK61aAr2zWtqzFpJnp8qfC7h6TkoReJWsA8tOck7ssNOOf3GdKBmlTxlH9+W
         rBf5QmtMInlh95eUbxkMi6al6C7LseJW7OjGiP8fMeupGgFrNVRf54Iht2nbqQSjiWkw
         mM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNpFPLPiDI5ooyd0feHp/EZ7Ej+27FmVQUDtDTXnGJc=;
        b=v2nkEVOvN91las3e63bfkrKFf1KV49gVcyrVxC2u+pNNDRaKy+1HWLf7u+kfi/2W+y
         xzkBtudXUMw++ZX2HVq8Os3LffPQj6M1vInTU5fqv+VUo5L5x8DUabh3YJqW0dUyVY7R
         mIz/gNW8lem2szkX/ssZZScqNNuV1aTFQULmvXx9qqogEvkyW52b685wU+CammP2lq2S
         cQqHk8auTQa951ecbn0eYZNsylLUgi+a2k1BWldKUMhfnzXoWvRYH+OIvpl9QerkcDFA
         KWoK5Jx0Jw/MwqqrfnCy4NCX8c7HedpUCiBAeF3165y7J9Z3IWUrmura0/qRo4xwlRT6
         Q+qQ==
X-Gm-Message-State: ANoB5pkUXXU9p27BTEGDU47CPeJkzERNCa2A4x72nAgDvU1GiNYVzOkl
        td30D8odvHfkfnPgdU9Kpa3wwAufVqTXa+o+8YEjyGg8D8rL8A==
X-Google-Smtp-Source: AA0mqf6Bq7dsGtdpRYUsz5E024l1YYu33AxCFPvMgGaAsFoivyFG65tm5tWAy8v+HsLs/JIb/s0ePOeyhObduui7920=
X-Received: by 2002:a05:600c:4fc4:b0:3c6:c109:2d9 with SMTP id
 o4-20020a05600c4fc400b003c6c10902d9mr8656158wmq.149.1668898878064; Sat, 19
 Nov 2022 15:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20221117220339.341290-1-irogers@google.com> <CAKwvOdnc28gwv619=efnp2XYBFgv6fkSa8Z4t6M4XygPR+uC8A@mail.gmail.com>
In-Reply-To: <CAKwvOdnc28gwv619=efnp2XYBFgv6fkSa8Z4t6M4XygPR+uC8A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 19 Nov 2022 15:01:05 -0800
Message-ID: <CAP-5=fWQYzwEfzK0jW3FGAZwv4H7x3gXsDi1Dhiaj81odfKahw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] objtool build improvements
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 9:47 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Nov 17, 2022 at 2:03 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Install libsubcmd and then get headers from there, this avoids
> > inadvertent dependencies on things in tools/lib. Fix V=1
> > support. Clean up how HOSTCC is used to override CC to avoid CFLAGS
> > being set for say gcc, and then CC being overridden to clang. Support
> > HOSTCFLAGS as a make option.
>
> Hi Ian,
> Thanks for the patch set! I'm particularly interested in fixing the
> plumbing of HOSTCFLAGS into objtool properly.
>
> Does this patch series depend on recent work you were doing to perf
> and libsubcmd? When I apply it to mainline (84368d882b96) or
> linux-next (20221118), I observe build failures with it.
>
> ```
> /bin/sh: line 1: cd:
> /android0/kernel-all/tools/objtool/libsubcmd/tools/objtool/: No such
> file or directory
> ../../scripts/Makefile.include:17: *** output directory
> "/android0/kernel-all/tools/objtool/libsubcmd/tools/objtool/" does not
> exist.  Stop.
> make[3]: *** [Makefile:82:
> /android0/kernel-all/tools/objtool/libsubcmd/libsubcmd.a] Error 2
> make[3]: *** Waiting for unfinished jobs....
> builtin-check.c:6:10: fatal error: 'subcmd/parse-options.h' file not found
> #include <subcmd/parse-options.h>
>          ^~~~~~~~~~~~~~~~~~~~~~~~
> ```
> Which I also observe when just doing a regular kernel build and not
> just tools/objtool/.
>
> I tried to apply other recent series first, like
> https://lore.kernel.org/lkml/20221109184914.1357295-1-irogers@google.com/
> https://lore.kernel.org/linux-perf-users/20221116072211.2837834-2-irogers@google.com/
> but wasn't quite able to get the result to build.
>
> My plan to validate HOSTCFLAGS is:
> $ make LLVM=1 -j128 mrproper defconfig tools/objtool HOSTCFLAGS=-Os
> V=1 1> before.txt
> $ <apply patch series>
> $ make LLVM=1 -j128 mrproper defconfig tools/objtool HOSTCFLAGS=-Os
> V=1 1> after.txt
> $ meld before.txt after.txt

Thanks Nick! I think:
https://lore.kernel.org/lkml/20221109184914.1357295-3-irogers@google.com/
is necessary and already in Arnaldo's tree:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf%2Fcore
However, with that the output directory in libsubcmd is calculated
incorrectly and results in the error you see. I'll work on a v2 patch
set.

Thanks,
Ian

> >
> > Ian Rogers (3):
> >   objtool: Install libsubcmd in build
> >   objtool: Properly support make V=1
> >   objtool: Alter how HOSTCC is forced
> >
> >  tools/objtool/Build    |  2 --
> >  tools/objtool/Makefile | 68 +++++++++++++++++++++++++++++-------------
> >  2 files changed, 48 insertions(+), 22 deletions(-)
> >
> > --
> > 2.38.1.584.g0f3c55d4c2-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
