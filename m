Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DE56F395E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 22:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEAUtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 16:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjEAUs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 16:48:57 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C701FE9
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 13:48:56 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-330ec047d3bso5025ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682974136; x=1685566136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dD98wQZtTWak3XiUyDuuyre7EygxZ++ouRht1+2mVzk=;
        b=UKrzsTrm+fYx0CNk6WTw+KBaGYA3pL78Mzo4yVhkOiHuQ9yhc+dKhPFpQ+Xep14Hfn
         qOkECSdU6XycIUcQZ6khGgQm6eT6tGGjQxZgbci4ihvS6DXJWWiwykwSlFMFaWvqqEqQ
         TpkjG0CCL73Dq4aET1tQt+F7J9ZfPblG6f69ZVQVpjFvqtAPcfBH5fKQBnJhkEwH3pqo
         Zv+1e/BQ3x6krUCWMq0HUo6foMSKTKOf4vVGboVY1txBaIxOgdIli5/TrBk46NmXB1Gj
         AZ9h6Rxj9yxz6hyxcViX+XdqB40VvXNWYcLHLXZpcTVjBsxdzqFzL7P3JaujaQoN96HU
         fmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682974136; x=1685566136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dD98wQZtTWak3XiUyDuuyre7EygxZ++ouRht1+2mVzk=;
        b=CFGrpbTvA8jcn83QgQMxPegWd+0xAOOEXVc+1ixwZUdOqexbnR4r6cQ8HLN9Itcuzc
         KQHvPsUwdyX+YChD/ga9jOAIMfoxW/HXxTuEQTnuujaejsT4FSZh7vzxkzfzZ9AMPmHz
         zTZvqY6kbmEtt2XzQNuPWFY9Gnrw/MV+NbIM8gwyqYNXGIUtzS1P1f03BmgtbibdqW8u
         4b4vvi0klXn6WTsUhlL2AbryeJmz+1QAlADkHP9ClnhIFvQLzA6eJQnIi+BE8p3J6BzZ
         50pouvlxKacWXyOy8Ytt6xm2vBH+K5Ukt6/45NlE453/Ok0F/Zg8VlNkPyG34NvcrRfV
         8H8Q==
X-Gm-Message-State: AC+VfDxeUrwoHvW3si8zfXKnI96yt0n1YpeFcncydOQbh9egEKhFmwwD
        /8oeWHwFC+PvnwE+Z2vK3t6NRHAJVAv249Y6ug96iA==
X-Google-Smtp-Source: ACHHUZ5b7BtcrtBBPd5d9kxB/rZT5jV7VOn4rcCnvLzRBw4MG+l5INncdSy7LX1aupau5pe9nQGeBtD6M+I/PvSdkvQ=
X-Received: by 2002:a05:6e02:1caf:b0:325:cd88:841d with SMTP id
 x15-20020a056e021caf00b00325cd88841dmr64937ill.16.1682974135594; Mon, 01 May
 2023 13:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com> <20230429053506.1962559-4-irogers@google.com>
 <d6784858-2a5f-7920-f1ac-d7ec9ed89605@linux.intel.com> <CAP-5=fUtgEvgburjhE6HpazDh9dtn=DiSOwHaVnoE3N7sBynEw@mail.gmail.com>
 <a7020f11-3915-58e9-9d9e-792672ecbd61@linux.intel.com>
In-Reply-To: <a7020f11-3915-58e9-9d9e-792672ecbd61@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 1 May 2023 13:48:44 -0700
Message-ID: <CAP-5=fV326=0PLb+SZF3nFwQhXpdtMtk6KV+zZNEcs1erW9i1Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/46] perf stat: Introduce skippable evsels
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 1, 2023 at 1:25=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2023-05-01 11:29 a.m., Ian Rogers wrote:
> > The events are displayed twice as there are 2 groups of events. This
> > is changed by:
> > https://lore.kernel.org/lkml/20230429053506.1962559-5-irogers@google.co=
m/
> > where the events are no longer grouped.
>
> The trick seems don't work on a hybrid machine. I still got the
> duplicate Topdown events on e-core.

For hybrid the rest of the patch series is necessary, ie the patches
beyond what's for 6.4, which I take from the output (ie not a crash)
you are looking at. As multiple groups are in play then it looks like
the atom events are on >1 PMU which can happen as the x86 code special
cases events with topdown in their name. Some fixes in the series for
this are:
https://lore.kernel.org/lkml/20230429053506.1962559-6-irogers@google.com/
https://lore.kernel.org/lkml/20230429053506.1962559-40-irogers@google.com/
and related:
https://lore.kernel.org/lkml/20230429053506.1962559-19-irogers@google.com/
and so fixing this requires some detective work.

I don't think it should be a requirement for the series that all
hybrid bugs are fixed - especially given the complaints against the
length of the series as-is.

Thanks,
Ian

>          38,841.16 msec cpu-clock                        #   32.009 CPUs
> utilized
>                256      context-switches                 #    6.591 /sec
>                 33      cpu-migrations                   #    0.850 /sec
>                 84      page-faults                      #    2.163 /sec
>         21,910,584      cpu_core/cycles/                 #  564.107 K/sec
>        248,153,249      cpu_atom/cycles/                 #    6.389
> M/sec                       (53.85%)
>         27,463,908      cpu_core/instructions/           #  707.083 K/sec
>        118,661,014      cpu_atom/instructions/           #    3.055
> M/sec                       (63.06%)
>          4,652,941      cpu_core/branches/               #  119.794 K/sec
>         20,173,082      cpu_atom/branches/               #  519.374
> K/sec                       (63.18%)
>             72,727      cpu_core/branch-misses/          #    1.872 K/sec
>          1,143,187      cpu_atom/branch-misses/          #   29.432
> K/sec                       (63.51%)
>        125,630,586      cpu_core/TOPDOWN.SLOTS/          #      nan %
> tma_backend_bound
>                                                   #      nan %  tma_retir=
ing
>                                                   #      0.0 %
> tma_bad_speculation
>                                                   #      nan %
> tma_frontend_bound
>         30,254,701      cpu_core/topdown-retiring/
>        149,075,726      cpu_atom/TOPDOWN_RETIRING.ALL/   #    3.838 M/sec
>                                                   #     14.8 %
> tma_bad_speculation      (63.82%)
>    <not supported>      cpu_core/topdown-bad-spec/
>        523,614,383      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #   13.481 M/sec
>                                                   #     42.0 %
> tma_frontend_bound       (64.15%)
>        385,502,477      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #    9.925 M/sec
>                                                   #     30.9 %
> tma_backend_bound
>                                                   #     30.9 %
> tma_backend_bound_aux    (64.39%)
>        249,534,488      cpu_atom/CPU_CLK_UNHALTED.CORE/  #    6.424 M/sec
>                                                   #     12.2 %
> tma_retiring             (64.18%)
>        151,729,465      cpu_atom/TOPDOWN_RETIRING.ALL/   #    3.906
> M/sec                       (54.67%)
>        530,621,769      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #   13.661
> M/sec                       (54.30%)
>    <not supported>      cpu_core/topdown-fe-bound/
>        383,694,745      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #    9.879
> M/sec                       (53.96%)
>    <not supported>      cpu_core/topdown-be-bound/
>            105,850      cpu_core/INT_MISC.UOP_DROPPING/  #    2.725 K/sec
>
>        1.213449538 seconds time elapsed
>
> Thanks,
> Kan
