Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1805601D93
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJQXbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJQXbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:31:33 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747906C76E;
        Mon, 17 Oct 2022 16:31:32 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id g10so13860683oif.10;
        Mon, 17 Oct 2022 16:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldK45A9U94Cav4RPnqVY/g2gV8Vr/3Z8GF4b6Jc84pI=;
        b=XTDsWgB2E1qBg+ySAcE7RPVeR5ewswQz2y0dgCyMw3hp+2Th7hq14sxMVjfM4TPFvs
         77VSZr/DiCay/3wv1V2HLAn66dcXK6kHM9VSxDgYCO6DRLV9I70M0rXrijBHF5cfteTx
         5t3UqEXHIaTD6o9QdmZ086j4LbER1xkqqm1Nd6oIOrBzu87DC2Od+z/FB51em6OvQErv
         0GvCZorxH/WX1gZK5BXqXOXZHJs7Kz4nhI9ghm+1xZcy0Ir8OIGzGLXrfZnUW633dMFv
         9l36HwtOrNTnbQ0mR+pKqVWpB4iITVM8s0gufdy3S7YgZZkxJXx7fJDj08DlH2OOJZRj
         V/sg==
X-Gm-Message-State: ACrzQf0XSUYluAe8UGcOkIYj7JDaASIEs18P4//xpP/PpToVVfyjzT2v
        2Vj5wZK3R9My85TnoDWQv8W9Zd5nObFhMoLlxEI=
X-Google-Smtp-Source: AMsMyM5EDSIxae0eTOA1HYPoSeCYgyFo8hfkxLYcxCEg3AGo9pNf/ny92DGLNURuArWm3W2q0pyHi25uMInGaJpp9vI=
X-Received: by 2002:a05:6808:181e:b0:350:e92a:9ab1 with SMTP id
 bh30-20020a056808181e00b00350e92a9ab1mr81551oib.209.1666049491627; Mon, 17
 Oct 2022 16:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221014061550.463644-1-namhyung@kernel.org> <20221014061550.463644-20-namhyung@kernel.org>
 <B51023CD-214D-4D85-8086-B7AA6B6701D8@linux.vnet.ibm.com>
In-Reply-To: <B51023CD-214D-4D85-8086-B7AA6B6701D8@linux.vnet.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 17 Oct 2022 16:31:20 -0700
Message-ID: <CAM9d7chfRg=bwHmjuuWJVHyRQctEwO3jzZNEX6sJeJBwAgGWUw@mail.gmail.com>
Subject: Re: [PATCH 19/19] perf stat: Remove unused perf_counts.aggr field
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
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

On Sun, Oct 16, 2022 at 6:33 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 14-Oct-2022, at 11:45 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The aggr field in the struct perf_counts is to keep the aggregated value
> > in the AGGR_GLOBAL for the old code.  But it's not used anymore.
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > tools/perf/util/counts.c |  1 -
> > tools/perf/util/counts.h |  1 -
> > tools/perf/util/stat.c   | 35 ++---------------------------------
> > 3 files changed, 2 insertions(+), 35 deletions(-)
> >
> > diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
> > index 7a447d918458..11cd85b278a6 100644
> > --- a/tools/perf/util/counts.c
> > +++ b/tools/perf/util/counts.c
> > @@ -48,7 +48,6 @@ void perf_counts__reset(struct perf_counts *counts)
> > {
> >       xyarray__reset(counts->loaded);
> >       xyarray__reset(counts->values);
> > -     memset(&counts->aggr, 0, sizeof(struct perf_counts_values));
> > }
> >
> > void evsel__reset_counts(struct evsel *evsel)
> > diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
> > index 5de275194f2b..42760242e0df 100644
> > --- a/tools/perf/util/counts.h
> > +++ b/tools/perf/util/counts.h
> > @@ -11,7 +11,6 @@ struct evsel;
> >
> > struct perf_counts {
> >       s8                        scaled;
> > -     struct perf_counts_values aggr;
> >       struct xyarray            *values;
> >       struct xyarray            *loaded;
> > };
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 14c45f4cfdd3..6ab9c58beca7 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -308,8 +308,6 @@ static void evsel__copy_prev_raw_counts(struct evsel *evsel)
> >                               *perf_counts(evsel->prev_raw_counts, idx, thread);
> >               }
> >       }
> > -
> > -     evsel->counts->aggr = evsel->prev_raw_counts->aggr;
> > }
> >
> > void evlist__copy_prev_raw_counts(struct evlist *evlist)
> > @@ -320,26 +318,6 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist)
> >               evsel__copy_prev_raw_counts(evsel);
> > }
> >
> > -void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
> > -{
> > -     struct evsel *evsel;
> > -
> > -     /*
> > -      * To collect the overall statistics for interval mode,
> > -      * we copy the counts from evsel->prev_raw_counts to
> > -      * evsel->counts. The perf_stat_process_counter creates
> > -      * aggr values from per cpu values, but the per cpu values
> > -      * are 0 for AGGR_GLOBAL. So we use a trick that saves the
> > -      * previous aggr value to the first member of perf_counts,
> > -      * then aggr calculation in process_counter_values can work
> > -      * correctly.
> > -      */
> > -     evlist__for_each_entry(evlist, evsel) {
> > -             *perf_counts(evsel->prev_raw_counts, 0, 0) =
> > -                     evsel->prev_raw_counts->aggr;
> > -     }
> > -}
> > -
> > static size_t pkg_id_hash(const void *__key, void *ctx __maybe_unused)
> > {
> >       uint64_t *key = (uint64_t *) __key;
> > @@ -423,7 +401,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
> >                      int cpu_map_idx, int thread,
> >                      struct perf_counts_values *count)
> > {
> > -     struct perf_counts_values *aggr = &evsel->counts->aggr;
> >       struct perf_stat_evsel *ps = evsel->stats;
> >       static struct perf_counts_values zero;
> >       bool skip = false;
> > @@ -493,12 +470,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
> >               }
> >       }
> >
> > -     if (config->aggr_mode == AGGR_GLOBAL) {
> > -             aggr->val += count->val;
> > -             aggr->ena += count->ena;
> > -             aggr->run += count->run;
> > -     }
> > -
> >       return 0;
> > }
> >
> > @@ -523,13 +494,10 @@ static int process_counter_maps(struct perf_stat_config *config,
> > int perf_stat_process_counter(struct perf_stat_config *config,
> >                             struct evsel *counter)
> > {
> > -     struct perf_counts_values *aggr = &counter->counts->aggr;
> >       struct perf_stat_evsel *ps = counter->stats;
> > -     u64 *count = counter->counts->aggr.values;
> > +     u64 *count;
> >       int ret;
> >
> > -     aggr->val = aggr->ena = aggr->run = 0;
> > -
> >       if (counter->per_pkg)
> >               evsel__zero_per_pkg(counter);
> >
> > @@ -540,6 +508,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
> >       if (config->aggr_mode != AGGR_GLOBAL)
> >               return 0;
> >
> > +     count = ps->aggr[0].counts.values;
>
> Hi Namhyung,
>
> We are using ps->aggr[0] here always. Can you please clarify on why first index is used here always.

Sure, the AGGR_GLOBAL should have a single entry map because
theaggr_cpu_id__global() always returns the same value.  So we
can use the index 0 safely.  I'll add a comment.

Thanks,
Namhyung
