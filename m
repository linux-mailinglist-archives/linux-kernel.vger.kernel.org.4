Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EFB60BAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiJXUn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiJXUm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:42:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A03C8D1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:51:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id jb18so3659482wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uwj1DPzl1odsJlApuZOPGYBkSNPIOpgVa3JvpwwYAMw=;
        b=UjbOaV+r/c734tGQK4hx2shR9ybClfpKrs4Dr8qfMJnBYnoycYTzZYETW8xofElXXy
         ycM3hPwOXs92nckDftUxqEB+cdKH/OaF4wsme8oW9th9XxTRM5GoVKZ9b85+CSCKiFZc
         nELDTp+jumoNsBZk5+aoEbPRLYeNSP6In2Kf7O2UKE+YldENAGYLCh00c4LVLeLa9UAj
         x+rkDngUhAeP3kcfnvKXUFDHmIduCdIiHwA/7DKZyTjAjcPWfrzyQyRC+vTppY2KNAIc
         4OQIRQsWN0ota+QRouWGxOVeb+3wlFV8AlbzxTNsophwsXxPkNtcnKCDSpa15JkNnksF
         nPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwj1DPzl1odsJlApuZOPGYBkSNPIOpgVa3JvpwwYAMw=;
        b=NA/c6szVxZrHD5PpKmEuA9hMHwi6OXM3/702YxJ4Kj2YscN6+Q1I/7vr9ObDfK7ZL6
         nyOkCvEL8WDqIDhcbPhe1U6unGwY7yHEK4REHtNh/9/LcgKdaZl6ajLnl0LfnkMb9JfE
         42qFktaCGtnj3T+nAjMZP2wDZfj7p4MB+kEL/DFQqi4Co+RB2y+WS+22xlurHCJUhL14
         +PUQYpAi3eahePHWn7d4bzkTRcDi8WAHXL76So8Ju221OnxP92Sry2WcM3OerFPxOjUL
         HMhVM8DHOtz7ruz8RzCA2aWuuIEnjkSKY3qQo1L22BeTutvZngXzzxwjN0UQnN34osku
         uYcg==
X-Gm-Message-State: ACrzQf0Fjj0mdKaBjgricqvN1gRGbcbfSaao6RUkWN4Ysc8jpfA2K1F7
        rbq8eYK/kpwQgvtewh0RbP9OAEXrSco5iabyKiBj4fMeHMU=
X-Google-Smtp-Source: AMsMyM7U1YfFNa49/chsFH/FKd8m9CIfG2Lhpd1Dl+MJtDv93pw79KseAnjpzubx3aogD8sq+8NCFFHA5HRpzBVLv8E=
X-Received: by 2002:a05:600c:88a:b0:3c5:c9e3:15cc with SMTP id
 l10-20020a05600c088a00b003c5c9e315ccmr23430090wmp.67.1666635121309; Mon, 24
 Oct 2022 11:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com> <Y1bQlxxABicj4k3+@kernel.org>
 <CAP-5=fWPdmHPXc9D2LP6TVmhuNf93gZCnogWXCVGytkhuqi2uQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWPdmHPXc9D2LP6TVmhuNf93gZCnogWXCVGytkhuqi2uQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 24 Oct 2022 11:11:49 -0700
Message-ID: <CAP-5=fVGicObnifnUzDXjbkGOVtmNaLKcfqpGeTwnFw2zsOuDQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Update to C11, fix signal undefined behavior
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URI_DOTEDU,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:59 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Oct 24, 2022 at 10:51 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Mon, Oct 24, 2022 at 10:35:15AM -0700, Ian Rogers escreveu:
> > > The use of C11 is mainstream in the kernel [1]. There was some
> > > confusion on volatile and signal handlers in [2]. Switch to using
> > > stdatomic.h (requires C11) and sig_atomic_t as per [3]. Thanks to Leo
> > > Yan <leo.yan@linaro.org> for the suggestions.
> > >
> > > [1] https://lore.kernel.org/lkml/CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com/
> > > [2] https://lore.kernel.org/lkml/20221024011024.462518-1-irogers@google.com/
> > > [3] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers
> >
> > I think I'll apply this to perf/core, i.e. for 6.3, ok?
>
> Sounds good to me. 6.3 or 6.2? I suspect there is more cleanup like
> this and to the iterators (from C11) that can be done.
>
> Thanks,
> Ian

So I noticed a few changes missing #include-ing stdatomic.h and
sig_atomic_t is actually in signal.h. I'm not sure we need the C11
change then, but it seems like the right thing to do anyway. I'll do a
v2 to drop the unneeded (currently) include of stdatomic.h.

Thanks,
Ian

> > - Arnaldo
> >
> > >
> > > Ian Rogers (8):
> > >   perf build: Update to C standard to gnu11
> > >   perf record: Use sig_atomic_t for signal handlers
> > >   perf daemon: Use sig_atomic_t to avoid UB
> > >   perf ftrace: Use sig_atomic_t to avoid UB
> > >   perf session: Change type to avoid UB
> > >   perf stat: Use sig_atomic_t to avoid UB
> > >   perf top: Use sig_atomic_t to avoid UB
> > >   perf trace: Use sig_atomic_t to avoid UB
> > >
> > >  tools/perf/Makefile.config  | 2 +-
> > >  tools/perf/builtin-daemon.c | 3 ++-
> > >  tools/perf/builtin-ftrace.c | 4 ++--
> > >  tools/perf/builtin-record.c | 9 +++++----
> > >  tools/perf/builtin-stat.c   | 9 +++++----
> > >  tools/perf/builtin-top.c    | 4 ++--
> > >  tools/perf/builtin-trace.c  | 4 ++--
> > >  tools/perf/util/session.c   | 3 ++-
> > >  8 files changed, 21 insertions(+), 17 deletions(-)
> > >
> > > --
> > > 2.38.0.135.g90850a2211-goog
> >
> > --
> >
> > - Arnaldo
