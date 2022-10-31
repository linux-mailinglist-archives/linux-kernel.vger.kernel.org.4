Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE4614202
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJaX4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJaX4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:56:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0992120A7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 16:56:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kt23so33294613ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 16:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SKzTP96UBPazCXiA6JP5vjdhd3B+l1W/QdglRdm2JxA=;
        b=fSs7mNWHZXqB5sJhn1hvUjWqwVXunj8X/LQVgtTeC+SeBAYfxpBjpufBUGpK81ZwPY
         S6StyZQUgELEhOECoRb61eSezwyF0+dzhpXUr5m1V+7BS52B7zwSTcXq59esJ6t2DA+V
         Rzsod0VR3FhdQ5BhTrHvwJmr++yyA05qaGL/D3bVP4ZaW6E/2lIjQjuMbHEcYOt4c11i
         cQHdEaYZ1UK6mefW6Dd6TAvw6Y3nxbI1YBx6pWGLQ1dPP8kbzRGl2ex46ka8WHXNq4Rd
         nekY51WTukjD7EQHU9bM0OmEzHd/oOOzSbajOANs+Q725Zyeh6cRxQSqCI32Gz1Pp708
         pUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKzTP96UBPazCXiA6JP5vjdhd3B+l1W/QdglRdm2JxA=;
        b=vTcc7PA7aVKU/umvF1dDfYDZ2vOD3wmC3PunKZ+srJ81sltRJRfB6xo4mZEO1pXY6K
         25LPfpKPr7KYYVJW+h/ef48/5mMRu7knL3eXBT47UaOA0epewYYXsaZk61Xihs4H4Npk
         KLtHYa7fXpR6ihTRMIlM/G5MUOmHaeXCkrTmXdzmRtJRjfgQqVEy+wgwNmAcUK2yeMvC
         EO5iTcLiZCW2lq4usMn/VI4ZeA0hVkOBOrPIJnFIdMqD8yYWhq1g0NFZNRzsWTc8dFae
         oCjfiiUmgiUuyzIKAY0FErpf3p2/2EVfvN3vBVWHt0mYI4seQO0sDHIN5kFcWFGYPcg8
         g/DA==
X-Gm-Message-State: ACrzQf1ZAKiu+RtKBdD3KeC1Jhklwt7ywaPLIlyt4Dmn6v0RW1GmDUC8
        evga7nC+5v1p17LCEb+OLUhQR419wpbmjcpPv39k
X-Google-Smtp-Source: AMsMyM6mNQd8hqFWZDJWT4QBGcRfKpMsSkye4uFRGkFdvaxJrwPwbDUdkmnMpf8bNlBjrxnyG5WJ9+770QW/05gHNQY=
X-Received: by 2002:a17:907:9717:b0:78d:9fb4:16dd with SMTP id
 jg23-20020a170907971700b0078d9fb416ddmr15801465ejc.720.1667260568290; Mon, 31
 Oct 2022 16:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <202106281231.E99B92BB13@keescook> <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
 <202106291311.20AB10D04@keescook> <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
 <CAGG=3QXrOnN3-3r-VGDpmikKRpaK_p5hM_qHGprDDMuFNKuifA@mail.gmail.com> <YN8NGLPQ4Cqanc48@hirez.programming.kicks-ass.net>
In-Reply-To: <YN8NGLPQ4Cqanc48@hirez.programming.kicks-ass.net>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 31 Oct 2022 16:55:51 -0700
Message-ID: <CAGG=3QWuavLtvNb1d9T=dk67DZf8YaWL=0XBxZw0b0XrY8k6Cw@mail.gmail.com>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
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

On Fri, Jul 2, 2021 at 5:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 02, 2021 at 05:46:46AM -0700, Bill Wendling wrote:
> > On Tue, Jun 29, 2021 at 2:04 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Tue, Jun 29, 2021 at 1:44 PM Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > And it causes the kernel to be bigger and run slower.
> > > >
> > > > Right -- that's expected. It's not designed to be the final kernel
> > > > someone uses. :)
> > >
> > > Well, from what I've seen, you actually want to run real loads in
> > > production environments for PGO to actually be anything but a bogus
> > > "performance benchmarks only" kind of thing.
> > >
> > The reason we use PGO in this way is because we _cannot_ release a
> > kernel into production that hasn't had PGO applied to it. The
> > performance of a non-PGO'ed kernel is a non-starter for rollout. We
> > try our best to replicate this environment for the benchmarks, which
> > is the only sane way to do this. I can't imagine that we're the only
> > ones who run up against this chicken-and-egg problem.
> >
> > For why we don't use sampling, PGO gives a better performance boost
> > from an instrumented kernel rather than a sampled profile. I'll work
> > on getting statistics to show this.
>
> I've asked this before; *what* is missing from LBR samples that's
> reponsible for the performance gap?

For one, it lacks information on function call frequencies, which help
inlining. It's also much more coarse-grained than a perf trace. And
while a section of code that doesn't show up in a trace sample may not
be executed much, changes to it may have cascading effects.

Ingo mentioned had some ideas on minimal software LBR PMU
functionality. Do you have a link to this discussion?

"The right technical solution to integrate the clang-pgo software
instrumetnation would be to implement a minimal software-LBR PMU
functionality on top of the clang-pgo engine, and use unified perf tooling
to process the branch tracing/profiling information.

"In the main PGO thread PeterZ made a couple of technical suggestions about
how this can be done using the existing hardware LBR interfaces of perf,
but we are flexible if the design is sane and are open to improvements."

-bw
