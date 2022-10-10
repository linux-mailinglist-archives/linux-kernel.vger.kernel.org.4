Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851705FA7D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJJWuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJJWuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:50:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EF61D307
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:50:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bp11so6230951wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk1I2zxO88TBfn6c0vDMSDAxjXBBsEeXRexvri3uhqo=;
        b=diQh01OOy1Dz8TSaqHaANm2wt7qfTvQgYtMN3lCFy5NtH9yLNh8On4CRs1U49oRWyB
         28Vy91mXlK8vhocQe+Pffu34J7vdUaTVGZDyVfv/oLjI7nqQAqIVcfTiswLT6gD2z9WE
         ACnl+Zsc4nNXRqD5ApXm6eCxl7wts2KGdy54XFwRjbwAsqNRvssdpfqaQxoYR3FEXoLX
         OX1rsVvrRx22KuBVB5nqHVl80dJQsh6B/5L0G6OJcKpT3KaoANAGR3uUhuQlZZgrpePL
         wv9IupnMCuLT8lI1O662ZFzfnetkJsbjjDpb8ZQgJ+owhChHqpjEVDDWe5o7w4t87NFN
         QxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rk1I2zxO88TBfn6c0vDMSDAxjXBBsEeXRexvri3uhqo=;
        b=zwPPoWRvPm8f1aCvLxzp1pLeir5QSKR/9Y00ogP9JdMuoLgSKegS+RkqmlrpPquHoa
         uhBI9EQ1fm0173YR1FMT9PJCVlpfGHmrBehA2D+lvsDafdxMwQ5fpYD3b5O5aA5x/onC
         lpMKWggr8XXCQyJgelo4a1Kbkvr37rLm8GmKBg+lNsBhEsmJRITjiuVXZ30b7J/bZbJX
         5tyydGXdglzo/0LIaY72ML5X3rLqtSsDzzOHD+X7aACf4Vb4tY6gABXqZclAp31K1eWv
         nIKUbes617Tqf6snnGxnivQFKoCDV2VSngEMZxGVxfPX634P33+mrxnjDv/vfl7ak/wz
         gozg==
X-Gm-Message-State: ACrzQf3J+/F5tJ2zkxqCjlL1jrbZ5ta/SQsdtlQIWaKiciuo0PhRe11i
        L8tAjUGnbPhRw8Yp/4l6a27MiAeOkIm/rKdBw5iNgQ==
X-Google-Smtp-Source: AMsMyM6ngB6WuyzQmuQBuKFAAeO7EyYwpH4VGRBR6CoDGWrmUhLg9dbscQSLhNcTN1zd71pJyRPMRCXlWnc2oBJnXFo=
X-Received: by 2002:adf:fd50:0:b0:22e:5503:9c4c with SMTP id
 h16-20020adffd50000000b0022e55039c4cmr13022419wrs.375.1665442199902; Mon, 10
 Oct 2022 15:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-6-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 15:49:47 -0700
Message-ID: <CAP-5=fUsDzHXfVvQ8fOj0avpX8UmWZP2m3jyhC61Mh4c4Z5F1Q@mail.gmail.com>
Subject: Re: [PATCH 05/19] perf stat: Add cpu aggr id for no aggregation mode
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Likewise, add an aggr_id for cpu for none aggregation mode.  This is not
> used actually yet but later code will use to unify the aggregation code.
>
> No functional change intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 48 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 144bb3a657f2..b00ef20aef5b 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1339,6 +1339,12 @@ static struct aggr_cpu_id perf_stat__get_global(struct perf_stat_config *config
>         return id;
>  }
>
> +static struct aggr_cpu_id perf_stat__get_cpu(struct perf_stat_config *config __maybe_unused,
> +                                            struct perf_cpu cpu)
> +{
> +       return aggr_cpu_id__cpu(cpu, /*data=*/NULL);
> +}
> +
>  static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
>                                               aggr_get_id_t get_id, struct perf_cpu cpu)
>  {
> @@ -1381,6 +1387,12 @@ static struct aggr_cpu_id perf_stat__get_global_cached(struct perf_stat_config *
>         return perf_stat__get_aggr(config, perf_stat__get_global, cpu);
>  }
>
> +static struct aggr_cpu_id perf_stat__get_cpu_cached(struct perf_stat_config *config,
> +                                                   struct perf_cpu cpu)
> +{
> +       return perf_stat__get_aggr(config, perf_stat__get_cpu, cpu);
> +}
> +

There's an existing issue with this code that it is under documented -
in particular, cached?

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  static bool term_percore_set(void)
>  {
>         struct evsel *counter;
> @@ -1407,8 +1419,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
>         case AGGR_NONE:
>                 if (term_percore_set())
>                         return aggr_cpu_id__core;
> -
> -               return NULL;
> +               return aggr_cpu_id__cpu;;
>         case AGGR_GLOBAL:
>                 return aggr_cpu_id__global;
>         case AGGR_THREAD:
> @@ -1431,10 +1442,9 @@ static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
>         case AGGR_NODE:
>                 return perf_stat__get_node_cached;
>         case AGGR_NONE:
> -               if (term_percore_set()) {
> +               if (term_percore_set())
>                         return perf_stat__get_core_cached;
> -               }
> -               return NULL;
> +               return perf_stat__get_cpu_cached;
>         case AGGR_GLOBAL:
>                 return perf_stat__get_global_cached;
>         case AGGR_THREAD:
> @@ -1544,6 +1554,26 @@ static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu cpu, vo
>         return id;
>  }
>
> +static struct aggr_cpu_id perf_env__get_cpu_aggr_by_cpu(struct perf_cpu cpu, void *data)
> +{
> +       struct perf_env *env = data;
> +       struct aggr_cpu_id id = aggr_cpu_id__empty();
> +
> +       if (cpu.cpu != -1) {
> +               /*
> +                * core_id is relative to socket and die,
> +                * we need a global id. So we set
> +                * socket, die id and core id
> +                */
> +               id.socket = env->cpu[cpu.cpu].socket_id;
> +               id.die = env->cpu[cpu.cpu].die_id;
> +               id.core = env->cpu[cpu.cpu].core_id;
> +               id.cpu = cpu;
> +       }
> +
> +       return id;
> +}
> +
>  static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(struct perf_cpu cpu, void *data)
>  {
>         struct aggr_cpu_id id = aggr_cpu_id__empty();
> @@ -1579,6 +1609,12 @@ static struct aggr_cpu_id perf_stat__get_core_file(struct perf_stat_config *conf
>         return perf_env__get_core_aggr_by_cpu(cpu, &perf_stat.session->header.env);
>  }
>
> +static struct aggr_cpu_id perf_stat__get_cpu_file(struct perf_stat_config *config __maybe_unused,
> +                                                 struct perf_cpu cpu)
> +{
> +       return perf_env__get_cpu_aggr_by_cpu(cpu, &perf_stat.session->header.env);
> +}
> +
>  static struct aggr_cpu_id perf_stat__get_node_file(struct perf_stat_config *config __maybe_unused,
>                                                    struct perf_cpu cpu)
>  {
> @@ -1605,6 +1641,7 @@ static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
>         case AGGR_GLOBAL:
>                 return perf_env__get_global_aggr_by_cpu;
>         case AGGR_NONE:
> +               return perf_env__get_cpu_aggr_by_cpu;
>         case AGGR_THREAD:
>         case AGGR_UNSET:
>         case AGGR_MAX:
> @@ -1627,6 +1664,7 @@ static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
>         case AGGR_GLOBAL:
>                 return perf_stat__get_global_file;
>         case AGGR_NONE:
> +               return perf_stat__get_cpu_file;
>         case AGGR_THREAD:
>         case AGGR_UNSET:
>         case AGGR_MAX:
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
