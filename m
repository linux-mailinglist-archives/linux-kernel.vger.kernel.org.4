Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2B15EEA5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiI1X5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiI1X5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:57:01 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4576F10CA77;
        Wed, 28 Sep 2022 16:57:00 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id g130so17127219oia.13;
        Wed, 28 Sep 2022 16:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wxNo9Ar/nAhgz2AY6JA0MRSLyIxQQE+MuOYjBJ1g/00=;
        b=rP7EtSZWunRewSPAoPedulg8nuj6JTgfZon7bD2qtkqicQLz/okQA86EF5k6hMp+Lq
         685wQLi4OSPpEzdQPTBiE+iO1/lE9IutXUYSZ3WmkmIPG4IJgg6/apuRFPsrOz4Aq0Xu
         rATg0Vkcb66Mho7YWECwBLiH2T2Z9/P6aZMluPVUr9VQFwQ7M7Vl9hKZFDZkBoNmLUV3
         AQ0eDZ09cu5G+977iPxtzbHhq9nIdkUfPmnDwZlnQK9JRNBEfhEopK7dPcy9ID2snjkn
         6TXqfI65ejnFknNSmNhvu+95UdpmF1qETKhwYNB4mMwgVbQ8KIJkm93v4NWgFwnZqRSJ
         eGgw==
X-Gm-Message-State: ACrzQf3Ptt9gf1czxUilPVEWZL1AtXmqWs6+ZhcFZ5pMHFrFB+Eu+RWW
        bGPGzCUn6OpU2qVYJnKMyRZCW8Hv3f2EIUPHYJk=
X-Google-Smtp-Source: AMsMyM6yA9geESzIV1/PQdBrGPl8yIHEiWcyTIwutu/SAkn0gPpYL0dwR2SGEMAFppzcGQrmCATx6Y0ooNyGmQC8VUc=
X-Received: by 2002:a05:6808:181e:b0:350:e92a:9ab1 with SMTP id
 bh30-20020a056808181e00b00350e92a9ab1mr251357oib.209.1664409419478; Wed, 28
 Sep 2022 16:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220926200757.1161448-1-namhyung@kernel.org> <20220926200757.1161448-4-namhyung@kernel.org>
 <288ee488-c50f-252d-b886-1bef89b5e883@arm.com>
In-Reply-To: <288ee488-c50f-252d-b886-1bef89b5e883@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 28 Sep 2022 16:56:48 -0700
Message-ID: <CAM9d7chvH8fxOCXL3XUfez-7wsB7jjYyUDBUO10jqcWe+GcSFA@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf stat: Rename saved_value->cpu_map_idx
To:     James Clark <james.clark@arm.com>
Cc:     Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Sep 28, 2022 at 3:50 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 26/09/2022 21:07, Namhyung Kim wrote:
> > The cpu_map_idx fields is just to differentiate values from other
> > entries.  It doesn't need to be strictly cpu map index.  Actually we can
> > pass thread map index or aggr map index.  So rename the fields first.
> >
> > No functional change intended.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/stat-shadow.c | 308 +++++++++++++++++-----------------
> >  1 file changed, 154 insertions(+), 154 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > index 9e1eddeff21b..99d05262055c 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -33,7 +33,7 @@ struct saved_value {
> >       struct evsel *evsel;
> >       enum stat_type type;
> >       int ctx;
> > -     int cpu_map_idx;
> > +     int map_idx;
>
> Do the same variables in stat.c and stat.h also need to be updated? The
> previous change to do this exact thing (5b1af93dbc7e) changed more than
> just these ones.

Thanks for your review!  I'll change the header too.

Note that callers of perf_stat__update_shadow_stats() are free
to use cpu_map_idx as they want.  The previous change fixed
confusion between cpu number and map index.  Actually either
is fine for us as long as it's used consistently.  But we use the
cpu map index for most cases.

Thanks,
Namhyung
