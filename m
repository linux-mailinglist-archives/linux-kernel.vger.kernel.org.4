Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3125EEB60
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiI2B6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiI2B6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:58:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D203122604
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 18:58:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so22374303wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 18:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=posI89+zac0UiwvW1mDf5OWiDQy0Yhxv/IzxtHly9yA=;
        b=hKmYgXZfI3hL4Jg9MuVFiNNSwaoKZ8j4cSjeKGniv2b8ke9kXx5aAXP2DxWCJvii/+
         Q93DCrnd/wh3Vdt1Y22T3F+DhPjVPKD4HbIlYHiKkcddMB6Se3GgCwF4ggWlJXR/661I
         qZP0jU8YmJz53p1zOrXYFD0JJSWKC0/4Qc2JnM79MLbvcd+C9087cNCEfhpdGKTIyNbi
         hhsa9GKSDk3daHw5Pb5VOV78FK88GbhhS/9bdZjte3dbb51H2KY5IKqI/AYaAY0XuJzt
         zVSuTg9os9bzUqAshxOwfQTF4VlZgA/h0OENCNRYQdwoPzRO1mmeyPfSSrgRySq2hdKC
         YMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=posI89+zac0UiwvW1mDf5OWiDQy0Yhxv/IzxtHly9yA=;
        b=sldwPStWFLwkbkR/Z2VhcuSAQJR16HIhIf3sEFO424vhsaRaychOIniO2zpn+cunnE
         TXb/Tffg0iLdqgsn8w5dFEEFIclSLysU55uEO1NYyZDHwoYuW9Q53hZLpPgkzhG6p4O5
         0+3SaJ08SG1v0KlYswaVtXF1+OcFSicBaR5me6Gig162ItbIq/gsZ7gbsHtEZdhkWjcE
         8xWmNXSi7yaapfrAIneNzQ31Bb1cXmRB3zHc7KYo/SjwOiMznxDoxzjBM1zH3gCCaTuT
         Fwu3zvfJ4Y/H0e14W5dy3CTN2eXGAvdxyrgHjjpUD3aQqwsJkJgowEzJuoqRd+F4MvuS
         BCpA==
X-Gm-Message-State: ACrzQf1ZTAgx/xYbJceRupzHOE6JgCwSsPyAL6nU1cjshhnabG8yEdfb
        3j3+8CstLTJmnSahvuJO7E2ikE8eSI0lvpKwzn9V0Q==
X-Google-Smtp-Source: AMsMyM43TSvqdPcJcgxgsxb3hfRE7WlT0poI9Ru7d1//tjKEU/9C69LlHOg7sVx/3Ydrm3Fq6Y8dWiKrSDTEP7lMqWg=
X-Received: by 2002:adf:dd8f:0:b0:22a:84ab:4be3 with SMTP id
 x15-20020adfdd8f000000b0022a84ab4be3mr426011wrl.40.1664416697616; Wed, 28 Sep
 2022 18:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220926200757.1161448-1-namhyung@kernel.org> <20220926200757.1161448-4-namhyung@kernel.org>
 <288ee488-c50f-252d-b886-1bef89b5e883@arm.com> <CAM9d7chvH8fxOCXL3XUfez-7wsB7jjYyUDBUO10jqcWe+GcSFA@mail.gmail.com>
In-Reply-To: <CAM9d7chvH8fxOCXL3XUfez-7wsB7jjYyUDBUO10jqcWe+GcSFA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 28 Sep 2022 18:58:05 -0700
Message-ID: <CAP-5=fW+a_hiwc08kwfsiOuLF+hStDyBGZkQQ-oQP-ChPLAF3w@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf stat: Rename saved_value->cpu_map_idx
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>, Ingo Molnar <mingo@kernel.org>,
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

On Wed, Sep 28, 2022 at 4:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Wed, Sep 28, 2022 at 3:50 AM James Clark <james.clark@arm.com> wrote:
> >
> >
> >
> > On 26/09/2022 21:07, Namhyung Kim wrote:
> > > The cpu_map_idx fields is just to differentiate values from other
> > > entries.  It doesn't need to be strictly cpu map index.  Actually we can
> > > pass thread map index or aggr map index.  So rename the fields first.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/stat-shadow.c | 308 +++++++++++++++++-----------------
> > >  1 file changed, 154 insertions(+), 154 deletions(-)
> > >
> > > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > > index 9e1eddeff21b..99d05262055c 100644
> > > --- a/tools/perf/util/stat-shadow.c
> > > +++ b/tools/perf/util/stat-shadow.c
> > > @@ -33,7 +33,7 @@ struct saved_value {
> > >       struct evsel *evsel;
> > >       enum stat_type type;
> > >       int ctx;
> > > -     int cpu_map_idx;
> > > +     int map_idx;
> >
> > Do the same variables in stat.c and stat.h also need to be updated? The
> > previous change to do this exact thing (5b1af93dbc7e) changed more than
> > just these ones.
>
> Thanks for your review!  I'll change the header too.
>
> Note that callers of perf_stat__update_shadow_stats() are free
> to use cpu_map_idx as they want.  The previous change fixed
> confusion between cpu number and map index.  Actually either
> is fine for us as long as it's used consistently.  But we use the
> cpu map index for most cases.
>
> Thanks,
> Namhyung

It is only fine to interchange CPU and CPU map index if the CPU map
contains all CPUs and not the any CPU entry. I wonder if we should
introduce a 'struct thread' to wrap the pid_t in thread maps to avoid
swapping threads and indices? Given pids are not generally in the same
range as indices (unlike CPU numbers which substantially broke
aggregation) it is much less likely this is broken. In any case it is
worth documenting map_idx to say what indices it is expected to hold.

Thanks,
Ian
