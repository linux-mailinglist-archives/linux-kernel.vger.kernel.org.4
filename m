Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFE474FEFD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGLGFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGLGFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:05:36 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24AB0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:05:34 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-403b622101bso125941cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689141934; x=1691733934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyLeCb+4QsM02BWy0BPE1CVBn7Ooftnyy1p5ySh/I/4=;
        b=Ev1HmpgXVTBgAiyhphybA8sI8dalHz3OmxXw33a0PCQqHOzd5p6MtWXo1K5ldIZdpw
         v3y5bL5lnSTheG27eOuWOt4ncxVqQ37zBxIwnQvwuGXTT4ZIYoiNcHr5vSWtlHY+3k46
         8h9v+7NVGiDae0Ins5msDftVsigZwsst5uvOr9z1VCfRxNg5RPWGgNZyoBZiuVg1z4dI
         JaYaUbfTa3Oq/1vCJdTlkcOfIyWVtxc4ELjAujFYrDdNGlGAKTM8Uhho0UEX8qsT78Xh
         iZPVYMWV80tn12lrh2iV9oBQ8/VYHmGiq46H7AJct/ki8uTwJE0xpqTVAwZbD0pOF2ad
         +THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689141934; x=1691733934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyLeCb+4QsM02BWy0BPE1CVBn7Ooftnyy1p5ySh/I/4=;
        b=g1ic4dL9gYH+3YFRdAcMznGqXRZ+CavpaQbD9swQk21tsK68GeTMoJ4z4QrgV8c+7c
         nSgUtXlfUt4MN2i2VkdbEzfZynZavUmnbpny2TRsd1A9uhtjsyE1kDWYL8QwGU7yCyoQ
         HPyW5Kpn3hU0BKi9xFVq4XI2WkThvbwIlfX8rK2mn6uX6kI4+vY2m4PgWXJ5KZ9HSpB3
         UyFzdvTHPrE/wHFavt3I+FEhp2RWnoSDXGdXUxKdSKn7ujHAG3PUTvRs/HUHSJXmu5x7
         ZO5NcsCOogxhnM/6C27Gcwv83iIzNShmbjW5ubxZSM2lWUo1YkoUMS5Gp8n/ffvV7INM
         5SYA==
X-Gm-Message-State: ABy/qLagD9LlrJeONu3nZMVs3/wDixT3E7nqR7RsEim6sL0aGhjiGiFX
        XR1sn4zAm+MnX3x7XmeXRo969e7YLb7r/9BdFT/Usg==
X-Google-Smtp-Source: APBJJlEuK+J5x5jJ6LWJS9P5JpvLKII3XEaYsPC+2PPfBNgcIOlv0nSlStXVuI9FbfKB8JR4GAHeMfUvqcvXVwfUfts=
X-Received: by 2002:a05:622a:1452:b0:3ed:86f6:6eab with SMTP id
 v18-20020a05622a145200b003ed86f66eabmr147634qtx.14.1689141933980; Tue, 11 Jul
 2023 23:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com> <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com> <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com>
In-Reply-To: <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 11 Jul 2023 23:05:22 -0700
Message-ID: <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 8:15=E2=80=AFAM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> On 30/06/2023 21:16, Ian Rogers wrote:
> > On Fri, Jun 30, 2023 at 12:00=E2=80=AFPM Ian Rogers<irogers@google.com>=
  wrote:
> >> On Wed, Jun 28, 2023 at 3:30=E2=80=AFAM John Garry<john.g.garry@oracle=
.com>  wrote:
> >>> Add a function to get the events table associated with a metric table=
 for
> >>> struct pmu_sys_events.
> >>>
> >>> We could also use something like:
> >>> struct pmu_sys_events *sys =3D container_of(metrics, struct pmu_sys_e=
vents,
> >>>                                                  metric_table);
> >>>
> >>> to lookup struct pmu_sys_events, but that relies on the user always p=
assing
> >>> a sys events metric struct pointer, so this way is safer, but slower.
>
> Hi Ian,
>
> >> If an event is specific to a particular PMU, shouldn't the metric name
> >> the PMU with the event?
>
> I am working on the basis - which I think is quite sane in case of sys
> events - that event names are unique to a PMU type.
>
> > For example:
> >>
> >> MetricName: "IPC",
> >> MetricExpr: "instructions / cycles",
> >>
> >> Here instructions and cycles can wildcard match on BIG.little/hybrid
> >> systems and so we get an IPC metric for each PMU - although, I suspect
> >> this isn't currently quite working. We can also, and currently, do:
> >>
> >> MetricName: "IPC",
> >> MetricExpr: "cpu_atom@instructions@ / cpu_atom@cycles@",
> >> ...
> >> MetricName: "IPC",
> >> MetricExpr: "cpu_core@instructions@ / cpu_core@cycles@",
>
> I did not know that it was possible to state that an event is for a
> specific PMU type in this fashion - is this feature new? Does it work
> only for known terms, like cycles and instructions?

It has been in metrics a long time (I didn't choose that @ was the /
replacement :-) ). It should work for all events.

> >> The @ is used to avoid parsing confusion with / meaning divide. The
> >> PMUs for the events are explicitly listed here. We could say the PMU
> >> is implied but then it gets complex for uncore events, for metrics
> >> that mix core and uncore events.
>
> So this works ok for IPC and CPU PMUs as we want the same event for many
> PMU types and naturally it would have the same name.
>
> I am still not sure that sys event metrics need to specify a PMU.

There was a similar thought for hybrid metrics. The PMU could be
implied from the PMU of the metric. I think there can be confusion
from an implied PMU, for example the cycles event without a PMU will
open two events on a hybrid CPU. If we imply the PMU then it can mean
just 1 PMU, but if the PMU doesn't have the event presumably it means
the multiple PMU behavior.

In parse-events there is existing logic to wildcard events but to
ignore those that don't match a given PMU. This is used to support the
--cputype option in builtin-stat.c, there is a similar option for
builtin-list.c. We can use this so that events in a metric only match
the PMU of the metric. Currently there are core metrics but whose
events are all uncore like:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=3Dperf-tools=
-next#n1802

So we'd need to move these metrics to be on the appropriate uncore
PMU. Supporting >1 PMU in a metric wouldn't work though as it would
appear the event was missing. Having the metric specify the PMU avoids
these problems, but is verbose.

Thanks,
Ian

> > So looking at the later patches, they are making it so the PMU doesn't
> > need to be specified,
>
> Right, as we assume that we use uniquely named events. Having non-unique
> event names seems to create problems.
>
> > so I think it is the same issue as here. My
> > thought was that the PMU would always be required for metrics like
> > memory bandwidth per million instructions, ie >1 PMU.
>
> We treat these sys PMUs as standalone, and it makes no sense (currently)
> to have a metric which contains events for multiple PMU types as we
> don't know if the system is created with those PMUs, and, if it is, what
> topology etc.
>
> > I know this
> > makes the metrics longer, I've tried to avoid writing json metrics and
> > have used Python to write them in my own work:
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel=
/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/metric.py?h=3Dperf=
-tools-next*n411__;Iw!!ACWV5N9M2RV99hQ!PE_9BEFVCr25fA9OHzfEDuT-MncA5pnPf5C3=
eTqYnXGKG9Q2OItrEIiEYz1T366HjAayQmYtZ6N6WxPJBCI$
>
> Thanks
> John
>
