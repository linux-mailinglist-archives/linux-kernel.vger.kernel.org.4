Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2586262820A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbiKNOJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbiKNOJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:09:34 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE6326553
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:09:33 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p16so7556717wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AQFsSA0lX/+5IkyPJ9u1kCFoht9PKz06jc946dKDKOM=;
        b=rH2qmF911lXpP+uWU63LT9JCtwsCRYaPTCjKagYLyAp4ScX/uOLl6p3voGd/09bnCy
         3rblUPanqe46NIBPamfMWf2ozgsT1v21ETD70XklI9z2RCLjYPed2NoZ6sJd/qRSZoj7
         P8dSQCIs/9OFnuv71gnO9tbvbAiqHJd3z6bCcWuKSBPDcilxWZ+eyPDsCn76if4+fhfI
         B1H1C4OfUL6mdu66FwGPzrbKBTfOlfnTSVlDmSjQ3QCe1pRO9Uj/ofNVJ3EglAQ6hbED
         f6cgfh/NaMgXkI58YoDUalKAu7xbZTuP5lxLzboLb3jFKD428KRG2eB7pmu5cMuHp3cE
         x3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQFsSA0lX/+5IkyPJ9u1kCFoht9PKz06jc946dKDKOM=;
        b=nKkW9reRgb3xurbqk9aEooXbQgQYPIifKBBt3ldGV8HWxAwOLdvuxbkO+Eav3Rqskm
         rzmWyl19pCgAVlDueNcgnulvO5XGisLaGUXFzYRl499NSdY2b8iztYnTQF1fNO2lQroS
         QrCuKN4iCrMG9lSPdQmWd+9hHWlcst2mxKSnSxzGMEPJHvY8/jTZ8PCTi/gGuzNShaD6
         Ee2Yh1Cc0Ch7qjz59x1EKCqmbHdgMat0zudUCoINo9x1tjqotr1bL5HfF4JgNyeItUOp
         qWR+4DGhJoekg/ozEg+zrApgszXwOmCWZo4gRCeNe4OSd8dPbL96k69hGMIm+J0acn8L
         n/fA==
X-Gm-Message-State: ANoB5plCWJNkWgtcEaOyF9lAb4pxO0HfitDwTg++3Z8B5rLkmHQ4VeT/
        QyGk8ll/P7NIlkJO4ScN5QOzf0KzkNvDu5hse+wf4A==
X-Google-Smtp-Source: AA0mqf7Fv4aiROw8x+aFA+clWKDAn17CGEDbgkRNjDTBtZagM0KPuH5PW6Ds2dxsexIP/NjLgNgjWdyDgAyeFVcfAzs=
X-Received: by 2002:a7b:c40b:0:b0:3c6:c109:2d9 with SMTP id
 k11-20020a7bc40b000000b003c6c10902d9mr8177329wmi.149.1668434971535; Mon, 14
 Nov 2022 06:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com> <20221114075127.2650315-2-irogers@google.com>
 <bbb73e4b-a73e-6ce5-db1f-e54d1bb19c2c@linux.intel.com>
In-Reply-To: <bbb73e4b-a73e-6ce5-db1f-e54d1bb19c2c@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Nov 2022 06:09:17 -0800
Message-ID: <CAP-5=fUTDtGDJ3ONW5iKaeszDRwezzZCJCW59yvXQ4tEYyHsdg@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] perf pmu: Add documentation
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Mon, Nov 14, 2022 at 5:40 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2022-11-14 2:51 a.m., Ian Rogers wrote:
> > Add documentation to struct perf_pmu and the associated structs of
> > perf_pmu_alias and perf_pmu_format.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c |  14 ++++++
> >  tools/perf/util/pmu.h | 105 +++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 113 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 6a86e6af0903..a8f9f47c6ed9 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -31,10 +31,24 @@
> >
> >  struct perf_pmu perf_pmu__fake;
> >
> > +/**
> > + * Values from a format file read from <sysfs>/devices/cpu/format/ held in
> > + * struct perf_pmu. For example, the contents of
> > + * <sysfs>/devices/cpu/format/event may be "config:0-7" and will be represented
> > + * here as name="event", value=PERF_PMU_FORMAT_VALUE_CONFIG and bits 0 to 7 will
> > + * be set.
> > + */
> >  struct perf_pmu_format {
> > +     /** The modifier/file name. */
> >       char *name;
> > +     /**
> > +      * Which config value the format relates to. Supported values are from
> > +      * PERF_PMU_FORMAT_VALUE_CONFIG to PERF_PMU_FORMAT_VALUE_CONFIG_END.
> > +      */
> >       int value;
> > +     /** Which config bits are set by this format value. */
> >       DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
> > +     /** Element on list within struct perf_pmu. */
> >       struct list_head list;
> >  };
> >
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index 68e15c38ae71..29571c0f9d15 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -34,30 +34,91 @@ struct perf_pmu_caps {
> >  };
> >
> >  struct perf_pmu {
> > +     /** The name of the PMU such as "cpu". */
> >       char *name;
> > +     /**
> > +      * Optional alternate name for the PMU determined in architecture
> > +      * specific code.
> > +      */
> >       char *alias_name;
> > +     /**
> > +      * Optional PMU identifier read from
> > +      * <sysfs>/bus/event_source/devices/<name>/identifier.
> > +      */
> >       char *id;
> > +     /**
> > +      * Perf event attributed type value, read from
> > +      * <sysfs>/bus/event_source/devices/<name>/type.
> > +      */
> >       __u32 type;
> > +     /**
> > +      * Can the PMU name be selected as if it were an event?
> > +      */
> >       bool selectable;
> > +     /**
> > +      * Is the PMU not within the CPU core? Determined by the presence of
> > +      * <sysfs>/bus/event_source/devices/<name>/cpumask.
> > +      */
> >       bool is_uncore;
> > +     /** Is the PMU name either cpu_core or cpu_atom. */
>
> I don't think we want to limit the hybrid names only to cpu_core or
> cpu_atom. Maybe something as below?
> /* Is a hybrid CPU PMU, e.g., cpu_core, cpu_atom. */

Currently the hybrid code only works for cpu_core or cpu_atom, a
limitation of its implementation. As pointed out in a later patch,
this bool isn't being used when it could be and I think we can work to
remove it. It would be possible to remove all uses of this with
perf_pmu__is_hybrid. As such I think it may be useful to mark the
hybrid variables in struct perf_pmu as deprecated while we work to
replace their use with more generic just any PMU code.

Thanks,
Ian

> Thanks,
> Kan
>
> >       bool is_hybrid;
> > +     /**
> > +      * Are events auxiliary events? Determined in architecture specific
> > +      * code.
> > +      */
> >       bool auxtrace;
> > +     /**
> > +      * Number of levels of :ppp precision supported by the PMU, read from
> > +      * <sysfs>/bus/event_source/devices/<name>/caps/max_precise.
> > +      */
> >       int max_precise;
> > +     /**
> > +      * Optional default perf_event_attr determined in architecture specific
> > +      * code.
> > +      */
> >       struct perf_event_attr *default_config;
> > +     /**
> > +      * Empty or the contents of either of:
> > +      * <sysfs>/bus/event_source/devices/<name>/cpumask.
> > +      * <sysfs>/bus/event_source/devices/<cpu>/cpus.
> > +      */
> >       struct perf_cpu_map *cpus;
> > -     struct list_head format;  /* HEAD struct perf_pmu_format -> list */
> > -     struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
> > +     /**
> > +      * Holds the contents of files read from
> > +      * <sysfs>/bus/event_source/devices/<name>/format/. The contents specify
> > +      * which event parameter changes what config, config1 or config2 bits.
> > +      */
> > +     struct list_head format;
> > +     /**
> > +      * List of struct perf_pmu_alias. Each alias corresponds to an event
> > +      * read from <sysfs>/bus/event_source/devices/<name>/events/ or from
> > +      * json events in pmu-events.c.
> > +      */
> > +     struct list_head aliases;
> > +     /** Has the list caps been initialized? */
> >       bool caps_initialized;
> > +     /** The length of the list caps. */
> >       u32 nr_caps;
> > -     struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
> > -     struct list_head list;    /* ELEM */
> > +     /**
> > +      * Holds the contents of files read from
> > +      * <sysfs>/bus/event_source/devices/<name>/caps/. The contents are pairs
> > +      * of the filename with the value of its contents, for example,
> > +      * max_precise (see above) may have a value of 3.
> > +      */
> > +     struct list_head caps;
> > +     /** Element on pmus list in pmu.c. */
> > +     struct list_head list;
> > +     /** Element on perf_pmu__hybrid_pmus. */
> >       struct list_head hybrid_list;
> >
> > +     /** Features to inhibit when events on this PMU are opened. */
> >       struct {
> > +             /** Disables perf_event_attr exclude_guest and exclude_host. */
> >               bool exclude_guest;
> >       } missing_features;
> >  };
> >
> > +/** A special global PMU used for testing. */
> >  extern struct perf_pmu perf_pmu__fake;
> >
> >  struct perf_pmu_info {
> > @@ -71,21 +132,53 @@ struct perf_pmu_info {
> >
> >  #define UNIT_MAX_LEN 31 /* max length for event unit name */
> >
> > +/**
> > + * An event either read from sysfs or builtin in pmu-events.c, created by
> > + * parsing the pmu-events json files.
> > + */
> >  struct perf_pmu_alias {
> >       char *name;
> > +     /** Optional short description of the event. */
> >       char *desc;
> > +     /** Optional long description. */
> >       char *long_desc;
> > +     /**
> > +      * Optional topic such as cache or pipeline, particularly for json
> > +      * events.
> > +      */
> >       char *topic;
> > +     /** Comma separated parameter list. */
> >       char *str;
> > -     struct list_head terms; /* HEAD struct parse_events_term -> list */
> > -     struct list_head list;  /* ELEM */
> > +     /** Owned list of the original parsed parameters. */
> > +     struct list_head terms;
> > +     /** List element of struct perf_pmu aliases. */
> > +     struct list_head list;
> > +     /** Units for the event, such as bytes or cache lines. */
> >       char unit[UNIT_MAX_LEN+1];
> > +     /** Value to scale read counter values by. */
> >       double scale;
> > +     /**
> > +      * Does the file
> > +      * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.per-pkg or
> > +      * equivalent json value exist and have the value 1.
> > +      */
> >       bool per_pkg;
> > +     /**
> > +      * Does the file
> > +      * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.snapshot
> > +      * exist and have the value 1.
> > +      */
> >       bool snapshot;
> > +     /** Is the event hidden and so not shown in perf list by default. */
> >       bool deprecated;
> > +     /**
> > +      * A metric expression associated with an event. Doing this makes little
> > +      * sense due to scale and unit applying to both.
> > +      */
> >       char *metric_expr;
> > +     /** A name for the metric. unit applying to both. */
> >       char *metric_name;
> > +     /** The name copied from struct perf_pmu. */
> >       char *pmu_name;
> >  };
> >
