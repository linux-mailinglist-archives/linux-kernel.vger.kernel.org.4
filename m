Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D2749510
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjGFFrI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 01:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFFrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:47:07 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF169110;
        Wed,  5 Jul 2023 22:47:05 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so3206941fa.2;
        Wed, 05 Jul 2023 22:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688622424; x=1691214424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAe3DO8JeNcAT9Td7jWMVHE4ZoYfI8wkTCrsNfJQcfM=;
        b=GhbHCYupYOMrEEjirznOd3DEYa4brv8qj80Cgb1WV7248yKunpWaIm/3jWIZAl6GPq
         NtrsEsM/curZy5sM1+KEE3PNGmXSW/YhJIw2HpOsnOmBLZcAAiAZqEiE46Mg2ooW2hMR
         hQoPPPRNrqK6xsEHNjWQFK8pS0oAcATIlTJa+C8nBuUj/YBy/QM4IguSpiANqgHuoOU1
         3HU03eghv0j3GkBSnT0x0Jl3u6Ujh9Ku0tL6I5/7ToqhJuFslL+0hYHzgtGxnxSRYdYO
         /mxRYZft5y3HUVmFr2X+5jrWl3hUU8UZv97+gsoLb/KItaW40f9b+1Tqfd3tEHEMVrQx
         E0dg==
X-Gm-Message-State: ABy/qLbmxYBqq5v4kFMwr41auvGD2QhhVaDTG7q+OJ5LVCjwebB6Q3mk
        HF0mKBVEgkb7HVtkcYICi4WrbGDWnGOMQeG3/sw=
X-Google-Smtp-Source: APBJJlH2A9JGeuMpPfUkDUalNHw1IcFAuO9slDxvx16xMY1cOpb26f+l1AdXlrCse2GEHfv8LIx2GQzNNvM9EhVUGFE=
X-Received: by 2002:a05:6512:60f:b0:4f9:5196:5ed0 with SMTP id
 b15-20020a056512060f00b004f951965ed0mr878972lfe.7.1688622423686; Wed, 05 Jul
 2023 22:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688585597.git.anupnewsmail@gmail.com> <d56fd5874314728e79c084e9d6ce805a24d61707.1688585597.git.anupnewsmail@gmail.com>
In-Reply-To: <d56fd5874314728e79c084e9d6ce805a24d61707.1688585597.git.anupnewsmail@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Jul 2023 22:46:51 -0700
Message-ID: <CAM9d7chnbr6LpLdv0AEaxu9kCL=tGB9PgdDgzatAawaKoPDimw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] scripts: python: create threads with schemas
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 12:47 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
>
> The markers structure defines the schema and data for
> thread markers, including fields such as 'name',
> 'startTime', 'endTime', 'phase', 'category', and 'data'.
>
> The samples structure defines the schema and data for thread
> samples, including fields such as 'stack', 'time', and
> 'responsiveness'.
>
> The frameTable structure defines the schema and data for frame
> information, including fields such as 'location', 'relevantForJS',
> 'innerWindowID', 'implementation', 'optimizations', 'line',
> 'column', 'category', and 'subcategory'.
>
> The purpose of this function is to create a new thread structure
> These structures provide a framework for storing and organizing
> information related to thread markers, samples, frame details,
> and stack information.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../scripts/python/firefox-gecko-converter.py | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> index 95b061a97cbc..e56864e78dc1 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -24,6 +24,47 @@ start_time = None
>  def process_event(param_dict):
>         global start_time
>         global thread_map
> +       def _createtread(name, pid, tid):
> +               markers = {
> +                       'schema': {
> +                               'name': 0,
> +                               'startTime': 1,
> +                               'endTime': 2,
> +                               'phase': 3,
> +                               'category': 4,
> +                               'data': 5,
> +                       },
> +                       'data': [],
> +               }
> +               samples = {
> +                       'schema': {
> +                               'stack': 0,
> +                               'time': 1,
> +                               'responsiveness': 2,
> +                               },
> +                       'data': [],
> +               }
> +               frameTable = {
> +                       'schema': {
> +                               'location': 0,
> +                               'relevantForJS': 1,
> +                               'innerWindowID': 2,
> +                               'implementation': 3,
> +                               'optimizations': 4,
> +                               'line': 5,
> +                               'column': 6,
> +                               'category': 7,
> +                               'subcategory': 8,
> +                       },
> +                       'data': [],
> +               }
> +               stackTable = {
> +                       'schema': {
> +                               'prefix': 0,
> +                               'frame': 1,
> +                       },
> +                       'data': [],
> +               }

It seems this function doesn't return anything.
Can we have a complete definition?  Otherwise it's hard to
know how these tables are used.

Thanks,
Namhyung


>
>         def _addThreadSample(pid, tid, threadName, time_stamp, stack):
>                 thread = thread_map.get(tid)
> --
> 2.34.1
>
