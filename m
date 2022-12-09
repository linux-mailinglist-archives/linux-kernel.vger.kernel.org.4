Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FAB64886E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiLIS1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiLIS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:27:44 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A071D309
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 10:27:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso9016251pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 10:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4gIgOD4wswhYFoONZnkGpnT9Fb5RY+TP6tHyxkVws9g=;
        b=podaF/exWcGGx/OfgyRwWibmT7w7cgfPONQ55bPT/RukR4RdJ3oLP8BtPHAXlpMuQU
         4EbLe4xubbmd2Isk6+pbqxHqaYooBCQmy3G2+XjrTZ4cCWFec+A6ahs1VJeHOCtwG0/W
         UNcc0lyRrt5nHmnVoNT/7aOY9N3EHNvB+VvEDeBWRIOsygmYMxLxHyMSDEVjor9AThmT
         cngODjR923ruf8mw74f9S0mUawB8A3dviNLvYnZCLFLjuas0T9E/WcRA2CbPQD0+ck6z
         e7PushbybebKiDq4+pyEPMNfuCs3e6RvpqZuGjwEONRtjQiXdsaFV+glvQu5IsVsbCUj
         0Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gIgOD4wswhYFoONZnkGpnT9Fb5RY+TP6tHyxkVws9g=;
        b=i3mgGWmS5IiuPyuiNpQDcoMZHmeO8mT0McQjITveFVkybyNSLxcQGbsHHcauAYmM1X
         cmezeG2HVA7Vhw/PZ8aCYe1IiH8aI/n6nTQ1Mb7qjT722t/zUnKHrn4j3GmlWdn3f5GM
         LkjmP2dAYbCBMrc7r8aBoqCob52Z6P1iBh8cjXqhrO+RF9/d59xyd9h1O1YrST/+I9Pp
         kbHSqOG/3S6jgKh8AJ+7GkG3RnkSq1ZXVCk6bVbt67keeNAHmG0AZhGBCXU0PueSwxjT
         BLcEP8QaV9u0ewYqbKT1NGtJsVHdHURRYz2faGv8E2LZFT0ZJYeOme42wEpGOdphhffa
         7lQw==
X-Gm-Message-State: ANoB5plGuqefV8yw3Ye5PJd1Nm/bfqsTluFQSLXAeVoJ2pS6786o6jV3
        5RbvoH8HTMYr9paqc3m6kwcB405fqRUu28VTrdwiZRyjiYAoq0Mx
X-Google-Smtp-Source: AA0mqf7/s6f8fvn45C5p0KJifVNXCAkl232CBj3A49DUBuPorsuAcOiLgacl7cmyAqtHsysvaq6vWLYEbQzmwebPLxY=
X-Received: by 2002:a17:90b:2743:b0:20d:4173:faf9 with SMTP id
 qi3-20020a17090b274300b0020d4173faf9mr108648571pjb.147.1670610461644; Fri, 09
 Dec 2022 10:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20221122001125.765003-1-irogers@google.com> <CAKwvOd=fEc=f++NFJpb+QOynC8vRrRp3wFT1KpQNwVcG9WWdrQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=fEc=f++NFJpb+QOynC8vRrRp3wFT1KpQNwVcG9WWdrQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Dec 2022 10:27:30 -0800
Message-ID: <CAKwvOdnXH_wSCXNJ=ozdJWEOj9E6EvL60bqz1Cw-DU0ojV7VsA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] objtool build improvements
To:     Ian Rogers <irogers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>,
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

On Fri, Dec 9, 2022 at 10:17 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Nov 21, 2022 at 4:11 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Install libsubcmd and then get headers from there, this avoids
> > inadvertent dependencies on things in tools/lib. Fix V=1
> > support. Clean up how HOSTCC is used to override CC to avoid CFLAGS
> > being set for say gcc, and then CC being overridden to clang. Support
> > HOSTCFLAGS as a make option.
>
> Ian, I'm terribly sorry about the delay in reviewing this; usually my
> turnaround time is much lower on code review...
>
> Anyways, the patchset LGTM; thanks for the work that went into this.
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Sorry, I just spotted a potential issue in patch 4/4.  You may retain
my above tags for the first three patches if you send a v3.

>
> >
> > v2. Include required "tools lib subcmd: Add install target" that is
> >     already in Arnaldo's tree:
> > https://lore.kernel.org/lkml/20221109184914.1357295-3-irogers@google.com/
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=630ae80ea1dd253609cb50cff87f3248f901aca3
> >     When building libsubcmd.a from objtool's Makefile, clear the
> >     subdir to avoid it being appended onto OUTPUT and breaking the
> >     build.
> >
> > Ian Rogers (4):
> >   tools lib subcmd: Add install target
> >   objtool: Install libsubcmd in build
> >   objtool: Properly support make V=1
> >   objtool: Alter how HOSTCC is forced
> >
> >  tools/lib/subcmd/Makefile | 49 ++++++++++++++++++++++++++++
> >  tools/objtool/Build       |  2 --
> >  tools/objtool/Makefile    | 68 +++++++++++++++++++++++++++------------
> >  3 files changed, 97 insertions(+), 22 deletions(-)
> >
> > --
> > 2.38.1.584.g0f3c55d4c2-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
