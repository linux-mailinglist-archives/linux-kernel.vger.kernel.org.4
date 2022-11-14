Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FB462883A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiKNSVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbiKNSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:21:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4759221814
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:21:37 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a14so19834814wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3fM3xvJMAJZPiLtedRbSJTxYZ++wPBK4zKGdWqxdh5g=;
        b=snxPpEkxEmcPnaT/ZJtgeLLhQnKgtiAPw/hOzamIRbmoD16BuPOdlPoN7trs1trm+e
         fHygPn2DX58zVFLrj/eUPU66cE4I7LJp2+H5H/9/7iZ1jI8cnwSAc/oYyx8cti2XwAfN
         l9t2XuP+nBhpYJKqOBmCJP6EfYLDcXBxFCF7MJBttafLecCCvHcSEgdCLwAZnfIFLJms
         CZacYGUTBbXbpKHr/LqXHaZhbEPZSiHIG48u7bN7DGBY1NK+mtNAzzblrDjmmwb9yu0s
         JbjUFvZRsdO7CTjrZXcZYXfEnUxadbkktlmQNZ9jJpjv5DmJ3+75lO36tmBKOLmmPvys
         W4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fM3xvJMAJZPiLtedRbSJTxYZ++wPBK4zKGdWqxdh5g=;
        b=GU4tpUu8Abt+mMjdH0dfrQKtVyMNh/wJWbxQ5B1HglOOwR8Q5CAx9FZUzvCd3BDnNd
         NvEJXXYmoxK6WOtwynRqTSR532zPVJfykegxLzf3EyFhFU+5UNqY5tXuswE0eugzrDNZ
         jfzLe84j7QGZzgpvjgBl0Fj4BAp1prkyFkvh22pwZCC7qU5Vj6D2Iip3CMtbOEcjL+XD
         RCZNnfd9TBEyML0DZ3BCzhGDNg5dkfpbZ/8Z+gRFk8OnDMs7Cbbq71qxAulPI4vJJymI
         7ZzbLGJ55PHP8xFoQbTyrE00l2Z6YT1L3tBfeBbRshHh68xljyJmHoq0Mp9BC2tYs8VO
         y0NA==
X-Gm-Message-State: ANoB5plW16/R51ZfRn2M0lqb/n/tQOWLLToSRXqeKz1PlWBzYkPoc24o
        GxQhvw6+L1yqZzCGVonBS8l8yTifagVQH/OTeVG9zJyLaHiX7Q==
X-Google-Smtp-Source: AA0mqf4+qzWMSkeNTKJ6hLea3l6MnDkMx4pVEYeNxv0fvdpHk4uCO1xtEq2dBJLki53Ew9bBrtKqjNjSY5DeN/KCbyk=
X-Received: by 2002:adf:ea82:0:b0:236:62d6:f586 with SMTP id
 s2-20020adfea82000000b0023662d6f586mr8359122wrm.40.1668450095599; Mon, 14 Nov
 2022 10:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20221112032244.1077370-1-namhyung@kernel.org> <20221112032244.1077370-12-namhyung@kernel.org>
In-Reply-To: <20221112032244.1077370-12-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Nov 2022 10:21:22 -0800
Message-ID: <CAP-5=fV6bzkyxf=Uw3ugA_W=v-M=eLGueMXWQj20HzCfUAJ18Q@mail.gmail.com>
Subject: Re: [PATCH 11/11] perf stat: Add missing separator in the CSV header
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 7:23 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It should have a comma after 'cpus' for socket and die aggregation mode.
> The output of the following command shows the issue.
>
>   $ sudo perf stat -a --per-socket -x, --metric-only -I1 true
>
> Before:
>                   +--- here
>                   V
>    time,socket,cpusGhz,insn per cycle,branch-misses of all branches,
>        0.000908461,S0,8,0.950,1.65,1.21,
>
> After:
>    time,socket,cpus,GHz,insn per cycle,branch-misses of all branches,
>        0.000683094,S0,8,0.593,2.00,0.60,
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 96bb7a42fd41..a316807255cd 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -828,8 +828,8 @@ static int aggr_header_lens[] = {
>
>  static const char *aggr_header_csv[] = {
>         [AGGR_CORE]     =       "core,cpus,",
> -       [AGGR_DIE]      =       "die,cpus",
> -       [AGGR_SOCKET]   =       "socket,cpus",
> +       [AGGR_DIE]      =       "die,cpus,",
> +       [AGGR_SOCKET]   =       "socket,cpus,",
>         [AGGR_NONE]     =       "cpu,",
>         [AGGR_THREAD]   =       "comm-pid,",
>         [AGGR_NODE]     =       "node,",
> --
> 2.38.1.493.g58b659f92b-goog
>
