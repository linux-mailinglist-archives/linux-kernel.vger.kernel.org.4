Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EF66A8EE8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCCBmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCCBmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:42:04 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D892F1689E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:41:44 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id 4so840545ilz.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 17:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677807695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa3IFNrapqdw55NbIdqz7TUk4no16Qpcm8BL00er4cg=;
        b=SYeugnBJMsCJtUISfQ/e4bAB0335/Ryv4aAmXz6iu1DZjCK2jigqAyYhWixA1YLA9Q
         0s3PYlYz/35NyMmCW6bi8GCGUQzuq4n9ftbSuAVCAKOrmWXDK/y5mDGeRLGFYsl3g9kW
         LDUWkzLQXwxmD+pqwKZmn5sjUSxcDtYXSlJHQZ+BORwT2UJuLLg7oqn9S3CKjUMnsxPT
         KehsqoOjyd6iWFa7wK0BVjOpSpAppoG2T2VKaMelyBqYnptbruNoFvbiv1CnRNN70SXP
         cQVD1A+8JLJMlhiK/BE/fY58+HI48LKOwUa7rAbGyg8VPdoXv6sN8T2jj2xKkd8cN9lH
         i/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677807695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oa3IFNrapqdw55NbIdqz7TUk4no16Qpcm8BL00er4cg=;
        b=NRGodxvluNBwvgS0S3MRHdBqtMg4tO0NG+dY+8uuqQkoCEvvqFZgYAIJeyEgSMWxEb
         Bs+Gwib3IU+ZiyXzLRq6WMftgWdciTuygU3Yg+ju5sXNNtQSh/GKiTiwj576wrBwGOWC
         54HnaVuYUJZ1Fr/9dHe90jMZys/THS1gVDSQTcLrVdjzZYTxKIVQ920VL4r+08+tPrek
         JMA3xg0X6yZyFoXW7FUzBSYZgo+OUi2JW7FMgMJdsjn9KLD8brLK2QKBpgHCpAA5v81x
         09TPTDHPMu439aDckLigcZRVfYUJSU3UcdmXJMTQV679Av5mAl6uTJmWRT2C/T4p7giL
         EJqg==
X-Gm-Message-State: AO0yUKUM7w4SJKy+roGrNFH46y727aMzYumWYU9zLms3Mk/FDOOsqS7c
        FcXjoNWItTN5rQqYlfpowig2UjWUUNU4idE+AaCw2A==
X-Google-Smtp-Source: AK7set/imoQzCMNa/Xb7V4tRoKPwmFA4RsLyU5ZPbfZnxnR1UmpdAYFO0ZIPCMAdCqOn0udUJKX2sGzSnsbS9di+4BY=
X-Received: by 2002:a05:6e02:1111:b0:315:5d89:fb2c with SMTP id
 u17-20020a056e02111100b003155d89fb2cmr2048905ilk.2.1677807695316; Thu, 02 Mar
 2023 17:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com> <20230302212531.1043318-7-irogers@google.com>
 <CAM9d7chd+fz6LCJWZHdFLmtRBYPyU-pxbtT8YzORhGGBjSCMzQ@mail.gmail.com>
In-Reply-To: <CAM9d7chd+fz6LCJWZHdFLmtRBYPyU-pxbtT8YzORhGGBjSCMzQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Mar 2023 17:41:24 -0800
Message-ID: <CAP-5=fWKPYTJ-Avjr=YJPU+qTDEEQmwTnQzkOLvUPo7WysVqfA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] perf evsel: Add function to compute pmu_name
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 2, 2023 at 4:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Mar 2, 2023 at 1:26 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The computed pmu_name respects software events and aux event groups,
> > such that the pmu_name is changed to be that of the aux event leader
> > or group leader for software events. This is done as a later change
> > will split events that are in different PMUs into different groups.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
> >  tools/perf/util/evsel.h |  1 +
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 2dc2c24252bb..9c6b486f8bd4 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -821,6 +821,30 @@ const char *evsel__name(struct evsel *evsel)
> >         return "unknown";
> >  }
> >
> > +const char *evsel__pmu_name(const struct evsel *evsel)
> > +{
> > +       const struct evsel *leader;
> > +
> > +       /* If the pmu_name is set use it. pmu_name isn't set for CPU an=
d software events. */
> > +       if (evsel->pmu_name)
> > +               return evsel->pmu_name;
>
> I'm wondering if we can just use evsel->pmu->name if it's set.

Agreed. I think that can be looked into in follow up work.

> > +       /*
> > +        * Software events may be in a group with other uncore PMU even=
ts. Use
> > +        * the pmu_name of the group leader to avoid breaking the softw=
are event
> > +        * out of the group.
> > +        *
> > +        * Aux event leaders, like intel_pt, expect a group with events=
 from
> > +        * other PMUs, so substitute the AUX event's PMU in this case.
> > +        */
>
> Looks like we need to rename this function as it doesn't simply return
> the pmu name in the above cases.  Maybe evsel__group_pmu_name() ?

Agreed, that is a better name. I'll add it in v3.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +       leader  =3D evsel__leader(evsel);
> > +       if ((evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE || evsel__=
is_aux_event(leader)) &&
> > +           leader->pmu_name) {
> > +               return leader->pmu_name;
> > +       }
> > +
> > +       return "cpu";
> > +}
> > +
> >  const char *evsel__metric_id(const struct evsel *evsel)
> >  {
> >         if (evsel->metric_id)
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 676c499323e9..72121194d3b1 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -280,6 +280,7 @@ int arch_evsel__hw_name(struct evsel *evsel, char *=
bf, size_t size);
> >
> >  int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char=
 *bf, size_t size);
> >  const char *evsel__name(struct evsel *evsel);
> > +const char *evsel__pmu_name(const struct evsel *evsel);
> >  const char *evsel__metric_id(const struct evsel *evsel);
> >
> >  static inline bool evsel__is_tool(const struct evsel *evsel)
> > --
> > 2.40.0.rc0.216.gc4246ad0f0-goog
> >
