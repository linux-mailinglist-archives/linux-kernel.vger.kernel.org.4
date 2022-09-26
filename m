Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83805EB1EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiIZUQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiIZUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:16:42 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372269F0D6;
        Mon, 26 Sep 2022 13:16:41 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id i15so5027922qvp.5;
        Mon, 26 Sep 2022 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1Moyt/DbH/5iuPJVPo0l2zngLADkERtzxSHb4NVriH8=;
        b=HBpzIKbJYJ+oekfthYe9ri/AoeyGwsq1SMaCghcPawpU5GXiK9OGFo9vCGYe7wpmMO
         8hqU4Gn6qQVNVUb7tzambM46pngSPbV3qSl50fx70TjEstH2g0NHCbT2Zw5H/0DKXDCr
         1jw+8GCSZQrUIdslPbpk3DFQURycnqylkzFe0EnrZc+V/EPxxjFi/uyNCnMQbnUb/NIE
         FQ1Vy/QI8WmgtjLk0ftVrLQIKhEszGmHSr2D4Nfn3I58qjLvXlG6GqnrZiva99qILvue
         wEyQ0ziHPTSa7NuF615NDX6NymIQMS1EYj5nWoLyYrl24QqrdbcdlguOxNSSS73Q7v8a
         HLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1Moyt/DbH/5iuPJVPo0l2zngLADkERtzxSHb4NVriH8=;
        b=2XWAweqiI3COTaXBGB4A/yOFAg9qdwWvuv7QYnOUKoMd8DPSadUHiS1zRajmNljp9n
         j5rdtzzl6R0ml73pAgdcWvynjCQyDmSGcibvMj5yOZJACzwxh9a8WnoLqw2D16KKITsJ
         GF6x3FC5cfRtwRKrFwFwjJevvdFVFdMkl5BXy3wQzz9DqcqH6jfKQ6X/Gwz1Yx1ArcmL
         OcNPRynIONqfVpUdhIM9z0GgpLpN7mexOQGuhytzEhKUQrK8o8RAU1keU2tDOTEUl/Zx
         p9vrVIL25MLfXgreoiPAWl+N/tAXieWscAMsKInEJZLLI7zN7MIhJEgjw3x2DTdA8v0h
         yuZw==
X-Gm-Message-State: ACrzQf14beScdYalkezh054TwltoxliPB+q2hA7xUpi0J28DeI+UGhbw
        IbdshMxYB44ULgSVfK1zjqOoy8seoEg0UYKsM4g=
X-Google-Smtp-Source: AMsMyM6DhG4RasO1+FbqYOQ1CqhS3aV4iMooc3GPKm2Hvn7tZ5OppInt59qu+j3AxY1JJT9ta+O3XQ31vXsABDXUtDA=
X-Received: by 2002:a05:6214:d0e:b0:4ad:5e35:329a with SMTP id
 14-20020a0562140d0e00b004ad5e35329amr18560172qvh.28.1664223400300; Mon, 26
 Sep 2022 13:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com> <YzGdeYzoZ1uC1CO/@hirez.programming.kicks-ass.net>
In-Reply-To: <YzGdeYzoZ1uC1CO/@hirez.programming.kicks-ass.net>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 26 Sep 2022 13:16:04 -0700
Message-ID: <CAMe9rOrHe9XD2D+pZJrKo1DxkLMQggDOFXQJfTgEO+xp0dybdw@mail.gmail.com>
Subject: Re: [PATCH v5 00/22] KCFI support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 5:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 08, 2022 at 02:54:42PM -0700, Sami Tolvanen wrote:
> > KCFI is a forward-edge control-flow integrity scheme in the upcoming
> > Clang 16 release, which is more suitable for kernel use than the
> > existing CFI scheme used by CONFIG_CFI_CLANG. KCFI doesn't require
> > LTO, doesn't alter function references to point to a jump table, and
> > won't break function address equality.
> >
> > This series replaces the current arm64 CFI implementation with KCFI
> > and adds support for x86_64.
> >
> > KCFI requires assembly functions that are indirectly called from C
> > code to be annotated with type identifiers. As type information is
> > only available in C, the compiler emits expected type identifiers
> > into the symbol table, so they can be referenced from assembly
> > without having to hardcode type hashes. Patch 6 adds helper macros
> > for annotating functions, and patches 9 and 20 add annotations.
> >
> > In case of a type mismatch, KCFI always traps. To support error
> > handling, the compiler generates a .kcfi_traps section for x86_64,
> > which contains the locations of each trap, and for arm64, encodes
> > the necessary register information to the ESR. Patches 10 and 22 add
> > arch-specific error handlers.
> >
> > To test this series, you'll need a ToT Clang toolchain. The series
> > is also available pn GitHub:
> >
> >   https://github.com/samitolvanen/linux/commits/kcfi-v5
>
> As mentioned at plumbers, my only concern is somewhat excessive use of
> CFI_CLANG as oposed to something more compiler neutral. But I suppose
> that's something we can cleanup/fix when GCC grows support for this.
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> (as in I ran kCFI + call-depth-tracking + FineIBT on a bunch of
> hardware)
>
> HJL, can you look at adding kCFI support to GCC ?

Adding -fsanitize=kcfi to GCC is a big effort.  Please open a
GCC bug:

https://gcc.gnu.org/bugzilla/enter_bug.cgi?product=gcc

-- 
H.J.
