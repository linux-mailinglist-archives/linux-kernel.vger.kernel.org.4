Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB83963CE8E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiK3FJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiK3FJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:09:40 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C818E5F841
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:09:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so555977wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tPffMUgX7a2GGEJ6Zz6hmdUXSHjUKgfftpO0zAvAwl4=;
        b=e0dYAhATh8eR0kaNT42SL61VfBCa+e4Jxr4k20NDR5vvzntXjojFn5Uo+oQSxoPc8n
         Rugu9mg0MqpvtHhenas/nmXN6Si1N18Rc2GdMkuFvzZLwD/W2PIbzx+qpA82UE4R4ckX
         Eu9m6jUZ1QOH11lhJ/IbMrxZI4qV19aOG7kZGTqCmLZrUQ8yAZUPLFlhHknH45L4FJZk
         we8xrarbV0SlwaixcebROZroxPVsa3UnRGaY6ugHQudkek9pRyCYoLo+FY0MY7o4Usb2
         eWZ9yMYOKoL08Not7Qic1En7vkGxpXN35k5xyCdJWzSA/ahp8ZYl/zJO2dCgI49qN8/m
         6dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPffMUgX7a2GGEJ6Zz6hmdUXSHjUKgfftpO0zAvAwl4=;
        b=h4DWBAOJh2Xf2PlELNmqWbR46DfmmfN8Kd/5xlha7D00fywZrBxunBIN7O+T6iWTmS
         8q2NN44NYOuMLOxGmxP3DhpYTqUVEYUI9ahdaZry0JFzpt9NU5zHrhoVGqXdtEQAB0co
         Z9AdQaSt+dBDnWmIfBaNx3SbFsHXfmtxXDfNHO/vQiMh13KRj42BfZbXgNeP88JaxytO
         oW+aBjZYr7saYmIdYTt2NJiPhjL61B4N/JDvA/v0LxCFtJ4mmVI1pjA6VJ9a7eHYiDev
         pnv2TmBVtuK7Ogwgj4/TTbx+Cxmu/GFJCRmRvXpCEYhp0Y2rm4KCatzsLkWxy47S0KpX
         esdg==
X-Gm-Message-State: ANoB5pmC4FmzHrJeEjTH1dYW0Z2Vk9v8Z+17wXyoLz0RdOdSgoeu3Anp
        W7PrxuJi7YUI5ZOF5s2/6cUE9fFxO6hHPmhCKhXFNg==
X-Google-Smtp-Source: AA0mqf7j4BkmWqskA6RHkQXR8CzBmviK5CfY/WdeUzHGx4BjBz3eCSJ91QGvc+purwr7iJG67k/mP8cu0sAS9E+MGFU=
X-Received: by 2002:a05:600c:4fc4:b0:3c6:c109:2d9 with SMTP id
 o4-20020a05600c4fc400b003c6c10902d9mr34001828wmq.149.1669784977174; Tue, 29
 Nov 2022 21:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-6-namhyung@kernel.org>
 <CAP-5=fWZ27QW+XvZx0bzEMmUbyKpmmmZudB9u=SyxiLcH3CCqw@mail.gmail.com>
In-Reply-To: <CAP-5=fWZ27QW+XvZx0bzEMmUbyKpmmmZudB9u=SyxiLcH3CCqw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 29 Nov 2022 21:09:25 -0800
Message-ID: <CAP-5=fXsWfOmavOAmxsUcX+g3cve2r20JmseDF7Bn1jO6tPX-Q@mail.gmail.com>
Subject: Re: [PATCH 05/15] perf stat: Remove prefix argument in print_metric_headers()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
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

On Wed, Nov 23, 2022 at 3:23 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It always passes a whitespace to the function, thus we can just add it to the
> > function body.  Furthermore, it's only used in the normal output mode.
> >
> > Well, actually CSV used it but it doesn't need to since we don't care about the
> > indentation or alignment in the CSV output.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian

I suspect this may be responsible for a metric segv that I'm now
seeing in Arnaldo's tree:

$ gdb --args perf stat -M Backend true
...
Performance counter stats for 'true':

        4,712,355      TOPDOWN.SLOTS                    #     17.3 %
tma_core_bound

Program received signal SIGSEGV, Segmentation fault.
__strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
77      ../sysdeps/x86_64/multiarch/strlen-evex.S: No such file or directory.
(gdb) bt
#0  __strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
#1  0x00007ffff74749a5 in __GI__IO_fputs (str=0x0, fp=0x7ffff75f5680
<_IO_2_1_stderr_>)
   at ./libio/iofputs.c:33
#2  0x0000555555779f28 in do_new_line_std (config=0x555555e077c0
<stat_config>, os=0x7fffffffbf10)
   at util/stat-display.c:356
#3  0x000055555577a081 in print_metric_std (config=0x555555e077c0
<stat_config>,
   ctx=0x7fffffffbf10, color=0x0, fmt=0x5555558b77b5 "%8.1f",
   unit=0x7fffffffbb10 "%  tma_memory_bound", val=13.165355724442199)
at util/stat-display.c:380
#4  0x00005555557768b6 in generic_metric (config=0x555555e077c0 <stat_config>,
   metric_expr=0x55555593d5b7 "((CYCLE_ACTIVITY.STALLS_MEM_ANY +
EXE_ACTIVITY.BOUND_ON_STORES) / (C
YCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring
* EXE_ACTIVITY.2_PORTS_UTIL)
+ EXE_ACTIVITY.BOUND_ON_STORES))"..., metric_events=0x555555f334e0,
metric_refs=0x555555ec81d0,
   name=0x555555f32e80 "TOPDOWN.SLOTS", metric_name=0x555555f26c80
"tma_memory_bound",
   metric_unit=0x55555593d5b1 "100%", runtime=0, map_idx=0,
out=0x7fffffffbd90,
   st=0x555555e9e620 <rt_stat>) at util/stat-shadow.c:934
#5  0x0000555555778cac in perf_stat__print_shadow_stats
(config=0x555555e077c0 <stat_config>,
   evsel=0x555555f289d0, avg=4712355, map_idx=0, out=0x7fffffffbd90,
   metric_events=0x555555e078e8 <stat_config+296>, st=0x555555e9e620 <rt_stat>)
   at util/stat-shadow.c:1329
#6  0x000055555577b6a0 in printout (config=0x555555e077c0
<stat_config>, os=0x7fffffffbf10,
   uval=4712355, run=325322, ena=325322, noise=4712355, map_idx=0) at
util/stat-display.c:741
#7  0x000055555577bc74 in print_counter_aggrdata
(config=0x555555e077c0 <stat_config>,
   counter=0x555555f289d0, s=0, os=0x7fffffffbf10) at util/stat-display.c:838
#8  0x000055555577c1d8 in print_counter (config=0x555555e077c0 <stat_config>,
   counter=0x555555f289d0, os=0x7fffffffbf10) at util/stat-display.c:957
#9  0x000055555577dba0 in evlist__print_counters (evlist=0x555555ec3610,
   config=0x555555e077c0 <stat_config>, _target=0x555555e01c80
<target>, ts=0x0, argc=1,
   argv=0x7fffffffe450) at util/stat-display.c:1413
#10 0x00005555555fc821 in print_counters (ts=0x0, argc=1, argv=0x7fffffffe450)
   at builtin-stat.c:1040
#11 0x000055555560091a in cmd_stat (argc=1, argv=0x7fffffffe450) at
builtin-stat.c:2665
#12 0x00005555556b1eea in run_builtin (p=0x555555e11f70
<commands+336>, argc=4,
   argv=0x7fffffffe450) at perf.c:322
#13 0x00005555556b2181 in handle_internal_command (argc=4,
argv=0x7fffffffe450) at perf.c:376
#14 0x00005555556b22d7 in run_argv (argcp=0x7fffffffe27c,
argv=0x7fffffffe270) at perf.c:420
#15 0x00005555556b26ef in main (argc=4, argv=0x7fffffffe450) at perf.c:550
(gdb)

Thanks,
Ian

> > ---
> >  tools/perf/util/stat-display.c | 26 ++++++++++----------------
> >  1 file changed, 10 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 744b7a40f59a..deed6ccf072f 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -996,10 +996,9 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
> >  }
> >
> >  static void print_metric_headers_std(struct perf_stat_config *config,
> > -                                    const char *prefix, bool no_indent)
> > +                                    bool no_indent)
> >  {
> > -       if (prefix)
> > -               fprintf(config->output, "%s", prefix);
> > +       fputc(' ', config->output);
> >
> >         if (!no_indent) {
> >                 int len = aggr_header_lens[config->aggr_mode];
> > @@ -1012,11 +1011,8 @@ static void print_metric_headers_std(struct perf_stat_config *config,
> >  }
> >
> >  static void print_metric_headers_csv(struct perf_stat_config *config,
> > -                                    const char *prefix,
> >                                      bool no_indent __maybe_unused)
> >  {
> > -       if (prefix)
> > -               fprintf(config->output, "%s", prefix);
> >         if (config->interval)
> >                 fputs("time,", config->output);
> >         if (!config->iostat_run)
> > @@ -1024,7 +1020,6 @@ static void print_metric_headers_csv(struct perf_stat_config *config,
> >  }
> >
> >  static void print_metric_headers_json(struct perf_stat_config *config,
> > -                                     const char *prefix __maybe_unused,
> >                                       bool no_indent __maybe_unused)
> >  {
> >         if (config->interval)
> > @@ -1032,8 +1027,7 @@ static void print_metric_headers_json(struct perf_stat_config *config,
> >  }
> >
> >  static void print_metric_headers(struct perf_stat_config *config,
> > -                                struct evlist *evlist,
> > -                                const char *prefix, bool no_indent)
> > +                                struct evlist *evlist, bool no_indent)
> >  {
> >         struct evsel *counter;
> >         struct outstate os = {
> > @@ -1047,11 +1041,11 @@ static void print_metric_headers(struct perf_stat_config *config,
> >         };
> >
> >         if (config->json_output)
> > -               print_metric_headers_json(config, prefix, no_indent);
> > +               print_metric_headers_json(config, no_indent);
> >         else if (config->csv_output)
> > -               print_metric_headers_csv(config, prefix, no_indent);
> > +               print_metric_headers_csv(config, no_indent);
> >         else
> > -               print_metric_headers_std(config, prefix, no_indent);
> > +               print_metric_headers_std(config, no_indent);
> >
> >         if (config->iostat_run)
> >                 iostat_print_header_prefix(config);
> > @@ -1132,7 +1126,7 @@ static void print_header_interval_std(struct perf_stat_config *config,
> >         }
> >
> >         if (config->metric_only)
> > -               print_metric_headers(config, evlist, " ", true);
> > +               print_metric_headers(config, evlist, true);
> >         else
> >                 fprintf(output, " %*s %*s events\n",
> >                         COUNTS_LEN, "counts", config->unit_width, "unit");
> > @@ -1168,7 +1162,7 @@ static void print_header_std(struct perf_stat_config *config,
> >         fprintf(output, ":\n\n");
> >
> >         if (config->metric_only)
> > -               print_metric_headers(config, evlist, " ", false);
> > +               print_metric_headers(config, evlist, false);
> >  }
> >
> >  static void print_header_csv(struct perf_stat_config *config,
> > @@ -1178,7 +1172,7 @@ static void print_header_csv(struct perf_stat_config *config,
> >                              const char **argv __maybe_unused)
> >  {
> >         if (config->metric_only)
> > -               print_metric_headers(config, evlist, " ", true);
> > +               print_metric_headers(config, evlist, true);
> >  }
> >  static void print_header_json(struct perf_stat_config *config,
> >                               struct target *_target __maybe_unused,
> > @@ -1187,7 +1181,7 @@ static void print_header_json(struct perf_stat_config *config,
> >                               const char **argv __maybe_unused)
> >  {
> >         if (config->metric_only)
> > -               print_metric_headers(config, evlist, " ", true);
> > +               print_metric_headers(config, evlist, true);
> >  }
> >
> >  static void print_header(struct perf_stat_config *config,
> > --
> > 2.38.1.584.g0f3c55d4c2-goog
> >
