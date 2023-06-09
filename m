Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED109729C19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjFIOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbjFIOAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:00:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776013586;
        Fri,  9 Jun 2023 07:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4CE86583E;
        Fri,  9 Jun 2023 14:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0080C433D2;
        Fri,  9 Jun 2023 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686319201;
        bh=7c8iZ2yP/v4AYl5cJEmJEM3+CrT+t567kSbCNVEG2oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRco8CZIE6PhnD83OXDfzGvZWWpbkWEQAlhL0DwE7OQSQXT+Yofr3T245q1Ra+dhh
         QYSpbA2wXqhoaofA0qGP8obPX/S2OxkCOPdQLEfB3TJDF50et/iRgFU+Gzb8OvMWV4
         atfgw6fjni8b3ece870+NeCB38JWLN+l01B7AXi22obve/vJxma6VxS8A9Y/01WuvZ
         LhtJZ+Dn+rQwYIWN4ZFIAYkrHsSSsq3BW/vILChegT6vL5+GHaa8fN33U7F4K63GDI
         Ib8gIMgM6OrgU2MV4RbhpZVXgXTq7pJVv95TZ7evbqHIGzrmUrgptbM5I6qM7cWZlf
         PRHLWv6Dqc24g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 40B4B40692; Fri,  9 Jun 2023 10:59:58 -0300 (-03)
Date:   Fri, 9 Jun 2023 10:59:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] perf list: Check if libpfm4 event is supported
Message-ID: <ZIMwXt3Sv7wRry83@kernel.org>
References: <20230608232400.3056312-1-namhyung@kernel.org>
 <20230608232400.3056312-2-namhyung@kernel.org>
 <CAP-5=fVmhdnRipBFZz++OzYB_8tMSQjPXQ1L9pJ1WZHTdErsBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVmhdnRipBFZz++OzYB_8tMSQjPXQ1L9pJ1WZHTdErsBQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 08, 2023 at 04:38:06PM -0700, Ian Rogers escreveu:
> On Thu, Jun 8, 2023 at 4:24 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Some of its event info cannot be used directly due to missing default
> > attributes.  Let's check if the event is supported before printing
> > like we do for hw and cache events.
> >
> > Cc: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers>@google.com>

Thanks, applied the series.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/pfm.c | 58 +++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 50 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> > index 076aecc22c16..4c1024c343dd 100644
> > --- a/tools/perf/util/pfm.c
> > +++ b/tools/perf/util/pfm.c
> > @@ -13,6 +13,8 @@
> >  #include "util/pmus.h"
> >  #include "util/pfm.h"
> >  #include "util/strbuf.h"
> > +#include "util/cpumap.h"
> > +#include "util/thread_map.h"
> >
> >  #include <string.h>
> >  #include <linux/kernel.h>
> > @@ -123,6 +125,36 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
> >         return -1;
> >  }
> >
> > +static bool is_libpfm_event_supported(const char *name, struct perf_cpu_map *cpus,
> > +                                     struct perf_thread_map *threads)
> > +{
> > +       struct perf_pmu *pmu;
> > +       struct evsel *evsel;
> > +       struct perf_event_attr attr = {};
> > +       bool result = true;
> > +       int ret;
> > +
> > +       ret = pfm_get_perf_event_encoding(name, PFM_PLM0|PFM_PLM3,
> > +                                         &attr, NULL, NULL);
> > +       if (ret != PFM_SUCCESS)
> > +               return false;
> > +
> > +       pmu = perf_pmus__find_by_type((unsigned int)attr.type);
> > +       evsel = parse_events__add_event(0, &attr, name, /*metric_id=*/NULL, pmu);
> > +       if (evsel == NULL)
> > +               return false;
> > +
> > +       evsel->is_libpfm_event = true;
> > +
> > +       if (evsel__open(evsel, cpus, threads) < 0)
> > +               result = false;
> > +
> > +       evsel__close(evsel);
> > +       evsel__delete(evsel);
> > +
> > +       return result;
> > +}
> > +
> >  static const char *srcs[PFM_ATTR_CTRL_MAX] = {
> >         [PFM_ATTR_CTRL_UNKNOWN] = "???",
> >         [PFM_ATTR_CTRL_PMU] = "PMU",
> > @@ -146,6 +178,8 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
> >  {
> >         int j, ret;
> >         char topic[80], name[80];
> > +       struct perf_cpu_map *cpus = perf_cpu_map__empty_new(1);
> > +       struct perf_thread_map *threads = thread_map__new_by_tid(0);
> >
> >         strbuf_setlen(buf, 0);
> >         snprintf(topic, sizeof(topic), "pfm %s", pinfo->name);
> > @@ -185,14 +219,15 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
> >                                     ainfo.name, ainfo.desc);
> >                 }
> >         }
> > -       print_cb->print_event(print_state,
> > -                       pinfo->name,
> > -                       topic,
> > -                       name, info->equiv,
> > -                       /*scale_unit=*/NULL,
> > -                       /*deprecated=*/NULL, "PFM event",
> > -                       info->desc, /*long_desc=*/NULL,
> > -                       /*encoding_desc=*/buf->buf);
> > +
> > +       if (is_libpfm_event_supported(name, cpus, threads)) {
> > +               print_cb->print_event(print_state, pinfo->name, topic,
> > +                                     name, info->equiv,
> > +                                     /*scale_unit=*/NULL,
> > +                                     /*deprecated=*/NULL, "PFM event",
> > +                                     info->desc, /*long_desc=*/NULL,
> > +                                     /*encoding_desc=*/buf->buf);
> > +       }
> >
> >         pfm_for_each_event_attr(j, info) {
> >                 pfm_event_attr_info_t ainfo;
> > @@ -215,6 +250,10 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
> >                         print_attr_flags(buf, &ainfo);
> >                         snprintf(name, sizeof(name), "%s::%s:%s",
> >                                  pinfo->name, info->name, ainfo.name);
> > +
> > +                       if (!is_libpfm_event_supported(name, cpus, threads))
> > +                               continue;
> > +
> >                         print_cb->print_event(print_state,
> >                                         pinfo->name,
> >                                         topic,
> > @@ -225,6 +264,9 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
> >                                         /*encoding_desc=*/buf->buf);
> >                 }
> >         }
> > +
> > +       perf_cpu_map__put(cpus);
> > +       perf_thread_map__put(threads);
> >  }
> >
> >  void print_libpfm_events(const struct print_callbacks *print_cb, void *print_state)
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >

-- 

- Arnaldo
