Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74479622030
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiKHXO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKHXO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:14:56 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CBC193D7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:14:51 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id d3so5123117uan.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 15:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JYCuoIUGPE42ilDgGQytWyIslRZ6M8LJ2EAILalAs0o=;
        b=To94lOqRjXZBN9kxBxfUKjfkICaQJCt722ripndWA1UY9X+AfSgYPwQWq9LOlL2O+h
         3jyMOX2C9XRbqiI3mDa+ZNuRpWvUc4pDogFxLpy03rL3osnomGoZ5iWgo4voJBP8s9cj
         WQOALsjljhqPfVnw5DXn6SlIa17W0NWNuWswFWvGI5LoobrBCcmih+ba6FwrgOTfQyMj
         +GHf56vE6hPSz6X4/+jQ/7zYzBsMXK/pqWcVhJmgZOLYSWLd+tXpp5+a9mRi9m75Lvzs
         Tm9uNZPa23PvJUdfhCscZjuVWX9kPMQx9HROz6gPJ/CEQS+aot/pWg3yQWwvqrYW5pmI
         p7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYCuoIUGPE42ilDgGQytWyIslRZ6M8LJ2EAILalAs0o=;
        b=myGwGJqzGDxlV5g0J28CtN9fG6hX7E5cshj36tLNX2YeYpPa/dypD+sNwreX65gXvO
         lKGAkHFuqrTHAQeW07FA30j4FBUrULk3KEhOXBhmB2I7tyJg+ZFS70zeALomPagLAwZg
         ViM6YdsG2ywMCgNNnkeStcZX8DQbxFbTQO9TeK3jewTN/md8mDS22lJ9bIdamkJQhxkD
         nRfyaMqBjMhNfGEpYaA7Vki3azFqDl2Z4qVGFYb6nsFgXOwvzHPnSgxueypqttbjbdVa
         +P4FYRN3fxfB3hhQ4h1/UfLMKmpfEEQokLrfcf4UzeNfmhPbcUJUrwZQqv2buzn1h2Uc
         krvg==
X-Gm-Message-State: ACrzQf2yRC4V/bb2h/Wc0Q+/NHuKmIq3qd9WSDA8mgYt9oEX0Ogmjb3x
        pTz7vc+pk39qLVdhGhIeC63YJ1nHdS67ukQkwkfWHg==
X-Google-Smtp-Source: AMsMyM4w6MA55Zlevm3yMSNfNR488eK8ZwVcC6yOcOTIdorfxOZ0OYKwVQ9Khel5Eul5oJ8dDOvDX/NrktnnFcGHqNg=
X-Received: by 2002:ab0:390f:0:b0:3af:3c62:bea2 with SMTP id
 b15-20020ab0390f000000b003af3c62bea2mr18747871uaw.21.1667949290602; Tue, 08
 Nov 2022 15:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-3-namhyung@kernel.org>
In-Reply-To: <20221107213314.3239159-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 8 Nov 2022 15:14:39 -0800
Message-ID: <CAP-5=fW+vsMEVCoGbouMbH0GQ875KsMKwJ9NKhCecYd7PFESWA@mail.gmail.com>
Subject: Re: [PATCH 2/9] perf stat: Increase metric length to align outputs
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
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

On Mon, Nov 7, 2022 at 1:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> When perf stat is called with very detailed events, the output doesn't
> align well like below:
>
>   $ sudo perf stat -a -ddd sleep 1
>
>    Performance counter stats for 'system wide':
>
>           8,020.23 msec cpu-clock                        #    7.997 CPUs utilized
>              3,970      context-switches                 #  494.998 /sec
>                169      cpu-migrations                   #   21.072 /sec
>                586      page-faults                      #   73.065 /sec
>        649,568,060      cycles                           #    0.081 GHz                      (30.42%)
>        304,044,345      instructions                     #    0.47  insn per cycle           (38.40%)
>         60,313,022      branches                         #    7.520 M/sec                    (38.89%)
>          2,766,919      branch-misses                    #    4.59% of all branches          (39.26%)
>         74,422,951      L1-dcache-loads                  #    9.279 M/sec                    (39.39%)
>          8,025,568      L1-dcache-load-misses            #   10.78% of all L1-dcache accesses  (39.22%)
>          3,314,995      LLC-loads                        #  413.329 K/sec                    (30.83%)
>          1,225,619      LLC-load-misses                  #   36.97% of all LL-cache accesses  (30.45%)
>    <not supported>      L1-icache-loads
>         20,420,493      L1-icache-load-misses            #    0.00% of all L1-icache accesses  (30.29%)
>         58,017,947      dTLB-loads                       #    7.234 M/sec                    (30.37%)
>            704,677      dTLB-load-misses                 #    1.21% of all dTLB cache accesses  (30.27%)
>            234,225      iTLB-loads                       #   29.204 K/sec                    (30.29%)
>            417,166      iTLB-load-misses                 #  178.10% of all iTLB cache accesses  (30.32%)
>    <not supported>      L1-dcache-prefetches
>    <not supported>      L1-dcache-prefetch-misses
>
>        1.002947355 seconds time elapsed
>
> Increase the METRIC_LEN by 3 so that it can align properly.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index ea41e6308c50..17d656566cd9 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -218,7 +218,7 @@ struct outstate {
>         struct evsel *evsel;
>  };
>
> -#define METRIC_LEN  35
> +#define METRIC_LEN  38
>
>  static void new_line_std(struct perf_stat_config *config __maybe_unused,
>                          void *ctx)
> --
> 2.38.1.431.g37b22c650d-goog
>
