Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCAB6F4B2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjEBURH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEBURE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:17:04 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2F21FE3
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:16:50 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3311833ba3dso153055ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683058610; x=1685650610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rld5ybTKQ6TnPbSfs5BNPMPd6l7llksJVQ7eLenv4TY=;
        b=hcUfAjSFSEHsDi5Xg7PaULZGb74SHlouCuI7bp5i8RylqblFX+wGW3P697iZfG42kR
         jPyF+9wT6l28WsF3+oiqXxX6vJqBt1XJKpqj4pguoZamuJ5rXESZco+UL0Y4vBNWwlu7
         jFIPH3/Fqo+dmFIN4aOvn1E4JsjZBmAdX8gpcaYHea4F339SSnJ3WmjLtdV/rJZdP6En
         HKnvCMP7B1Qdd8Dg0CEsrEV/MHWLWlAw8mG9YpsRK+FSVVGT0g8mMgDu21/kKQGe4nHO
         ZL2DKN3v2kqOtS/h0A2huEr4QZWRpTiXmIL0Z8jsbOUFO0mIY7bGkIqWh/JUF4UsbXAg
         9d0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058610; x=1685650610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rld5ybTKQ6TnPbSfs5BNPMPd6l7llksJVQ7eLenv4TY=;
        b=T7T6jxoFBDhb+ByQQG1zUZuiRn/i1xKFy2ZuiMjijDE4xJsIIy8rfJWzgV18xV/qsz
         3HjLEREyF94eFdQH6zdf2rdGtRuUoVG5WTJ0M3WasW3urlESfwNyzVe4lNpKwAdW0tDW
         AmY5uRp1WbBYGimcNaTHFr/8xw644vR9oo7Du3AwHCyaKLZJDMK4EU4JHme0tX1mUXCp
         dRAe2YcWorUsU3pzkhxpWFR/tCB9fbHb3c4MSzWRGOK18gcb9CDIN/nHkBh6dmQXClgr
         el9k8Fkvl6ngc9QXBtPrBUL1wOZXVrCbP/hJWeNeiHuzWNTKTOPbyjplESSJ0tI6AY1o
         rHwA==
X-Gm-Message-State: AC+VfDzSzNASrlblxQuvesX58k3QoA1pdVxdjuD9T+eD8wpvkpDd1IxK
        7HpUtFY2xbt3RpOSaMIrMqi2aj02WkFIVseiKcYjbQ==
X-Google-Smtp-Source: ACHHUZ5TeqJNjsrq9npV6a4cuF9kIkKkKG7+MLjwQOL/lHh4sbdYaXRcgHLsZuOMMAaRKkiGkXdF7muyXn0BWvYj+UI=
X-Received: by 2002:a05:6e02:1c0e:b0:32f:7703:63bb with SMTP id
 l14-20020a056e021c0e00b0032f770363bbmr46519ilh.19.1683058609755; Tue, 02 May
 2023 13:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com> <20230429053506.1962559-33-irogers@google.com>
 <a5153c87-044a-655d-acb4-aff9c33ab686@amd.com>
In-Reply-To: <a5153c87-044a-655d-acb4-aff9c33ab686@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 May 2023 13:16:38 -0700
Message-ID: <CAP-5=fVBB2b8WdUhcsPph=W5YzgdXcj13qcOxEGh5+h918whFQ@mail.gmail.com>
Subject: Re: [PATCH v3 32/46] perf stat: Make cputype filter generic
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 3:52=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> On 29-Apr-23 11:04 AM, Ian Rogers wrote:
> > Rather than limit the --cputype argument for "perf list" and "perf
> > stat" to hybrid PMUs of just cpu_atom and cpu_core, allow any PMU.
>
> I've couple of doubts:
>
> 1. Can you please explain intention to do this esp for perf list. Since, =
IIUC,
>    `perf list --unit` option provide the same functionality.
>
> 2. Since we are already specifying pmu name for non-standerd/arch-specifi=
c
>    events like `pmu/attributes/`, I'm not sure where `perf stat --cputype=
=3Dpmu`
>    is useful. Can you please explain perf stat usability aspect for non-h=
ybrid
>    pmus.
>
> 3. What am I missing here:
>
>    $ sudo ./perf stat --cputype=3Damd_df -e amd_l3/event=3D0x4,umask=3D0x=
ff/ -C 0 -- sleep 1
>     Performance counter stats for 'CPU(s) 0':
>
>            108,267      amd_l3/event=3D0x4,umask=3D0xff/
>
>        1.061290167 seconds time elapsed
>
> 3. Also, IMHO, using --cputype option to specify _pmu name_ is bit odd.
>
> >
> > Note, that if cpu_atom isn't mounted but a filter of cpu_atom is
> > requested, then this will now fail. As such a filter would never
> > succeed, no events can come from that unmounted PMU, then this
> > behavior could never have been useful and failing is clearer.
>
> I'm hitting a segfault if I use non-existing pmu:
>
> $ sudo ./perf list --cputype=3Drandom
> WARNING: cputype is not supported!
> Segmentation fault
>
>
> > @@ -443,8 +443,8 @@ int cmd_list(int argc, const char **argv)
> >                           "Print information on the perf event names an=
d expressions used internally by events."),
> >               OPT_BOOLEAN(0, "deprecated", &default_ps.deprecated,
> >                           "Print deprecated events."),
> > -             OPT_STRING(0, "cputype", &hybrid_name, "hybrid cpu type",
> > -                        "Limit PMU or metric printing to the given hyb=
rid PMU (e.g. core or atom)."),
> > +             OPT_STRING(0, "cputype", &cputype, "cpu type",
> > +                        "Limit PMU or metric printing to the given PMU=
 (e.g. cpu, core or atom)."),
>
> man perf-list does not describe --cputype. I think we should add it as pa=
rt
> of this patch?
>
> Similarly, man perf-stat also needs to be updated.

Ok, these changes are just keeping existing functionality. I don't
disagree with making these changes but I think we can follow up with
them. Or probably just deprecate the option.

> > +const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
> > +{
> > +     struct perf_pmu *pmu =3D NULL;
> > +
> > +     while ((pmu =3D perf_pmu__scan(pmu)) !=3D NULL) {
> > +             if (!strcmp(pmu->name, str))
> > +                     return pmu;
> > +             /* Ignore "uncore_" prefix. */
> > +             if (!strncmp(pmu->name, "uncore_", 7)) {
> > +                     if (!strcmp(pmu->name + 7, str))
> > +                             return pmu;
>
> Any specific reason to ignore "uncore_"? IMHO, ignoring prefix of some
> pmus and not of others is bit confusing for naive user.

It is trying to be consistent with the event parser:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/parse-events.y#n326
where uncore is consumed. Fun fact, as numbers are consumed after a
PMU name and the underscore is optional, i915 as a PMU can be matched
in parsing with a PMU name of just "i".

Thanks,
Ian
