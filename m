Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38F628675
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbiKNREV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbiKNRET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:04:19 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E4F102A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:04:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l14so19429732wrw.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9BZzP+O3KttUVZ3az1d6Zg4mvx/2g+jA+mA3A7ZWxjY=;
        b=eOzn15WyYnzK3lSQWHDoJJPeV1Xdcz0mFxNETZMesvGNelPd2lh9SHBxwqib0YKu6T
         cn3oOX5ixzpApwWNti7qv6kK4lF9XvkePQ/ko1aZjBEBT8AWt7tCqmZPMtaeLPelSkQL
         rT0HV91jj+L6EzVsVZSXE61jFOM2AziXTZm7Whj1WP8fvTB64Iph6cJPmY71lZVMRbLo
         a4+7zxwIZGklOwq70Swjz8EkZlBu4gHGOaN8es0P4SHh0HLDphnzL+YCSihQ1/fgYDZ4
         tJc7RaFRhEGj4NGMEPDPE+xkqBXJfDsDwfVGVAJxzHRpn8t9W87oZXqn6kr+aQ/LKlMh
         Hctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BZzP+O3KttUVZ3az1d6Zg4mvx/2g+jA+mA3A7ZWxjY=;
        b=LHDZQrwJxBFF0UpK5HGJfL5VBeOaRVTNLWf9019TGoIRwgGUUmQpEvj3ldHXzzPjMD
         0b8PSglMFXqUDvkvBbVpI7OW0m58LhsIJ+qCsvGM1KonbnuYfhT8+BF/e0vgeXJmKQ5L
         zoCYjErNWtBw2BaWse++h0Ze31biVIFs9i9wc9mTMi9XCcOBEbQ+n6J5w68kv7BcRw7s
         7TJYEO9j9GP2PtKEM37c2qon30/PJZ4bllZn8aIPzV5DuAlLo/xw70aaxDZyjjKs1xP5
         Kvpp0RuUwod5xxE6XQFtkjbn/dfPbmBk/G1GqSjKXU+Y/G/5RTyhl/096Ij/26Wfeubi
         FP6Q==
X-Gm-Message-State: ANoB5plSCUZH1msFmy2gQ6KfyZOe98HuAJC+m4EJUofGiMn9sKFOAC4p
        FfIucD2t5SpHUkWSBbLDHP1Pi0YiFI+SsAH2M++Q7w==
X-Google-Smtp-Source: AA0mqf6muCLM8Opjl5FTCfgJsGOYH77ZYOJa2bIlutJHlnoMBqZW8QfUh8VNWhmMhh8uXvICRP0MO3hXCH7jUAVJiGk=
X-Received: by 2002:a5d:6e89:0:b0:228:dd1d:8a42 with SMTP id
 k9-20020a5d6e89000000b00228dd1d8a42mr8325825wrz.375.1668445456367; Mon, 14
 Nov 2022 09:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com> <20221114075127.2650315-2-irogers@google.com>
 <bbb73e4b-a73e-6ce5-db1f-e54d1bb19c2c@linux.intel.com> <CAP-5=fUTDtGDJ3ONW5iKaeszDRwezzZCJCW59yvXQ4tEYyHsdg@mail.gmail.com>
 <3464d5c2-0438-18ba-fbea-ab95ca5f22b4@linux.intel.com>
In-Reply-To: <3464d5c2-0438-18ba-fbea-ab95ca5f22b4@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Nov 2022 09:04:01 -0800
Message-ID: <CAP-5=fVn6Ks9aS71jHq4+YXG1zdQjnvYwkMaiXf+goMRmCjrbw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 7:26 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2022-11-14 9:09 a.m., Ian Rogers wrote:
> > On Mon, Nov 14, 2022 at 5:40 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 2022-11-14 2:51 a.m., Ian Rogers wrote:
> >>> Add documentation to struct perf_pmu and the associated structs of
> >>> perf_pmu_alias and perf_pmu_format.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/util/pmu.c |  14 ++++++
> >>>  tools/perf/util/pmu.h | 105 +++++++++++++++++++++++++++++++++++++++---
> >>>  2 files changed, 113 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> >>> index 6a86e6af0903..a8f9f47c6ed9 100644
> >>> --- a/tools/perf/util/pmu.c
> >>> +++ b/tools/perf/util/pmu.c
> >>> @@ -31,10 +31,24 @@
> >>>
> >>>  struct perf_pmu perf_pmu__fake;
> >>>
> >>> +/**
> >>> + * Values from a format file read from <sysfs>/devices/cpu/format/ held in
> >>> + * struct perf_pmu. For example, the contents of
> >>> + * <sysfs>/devices/cpu/format/event may be "config:0-7" and will be represented
> >>> + * here as name="event", value=PERF_PMU_FORMAT_VALUE_CONFIG and bits 0 to 7 will
> >>> + * be set.
> >>> + */
> >>>  struct perf_pmu_format {
> >>> +     /** The modifier/file name. */
> >>>       char *name;
> >>> +     /**
> >>> +      * Which config value the format relates to. Supported values are from
> >>> +      * PERF_PMU_FORMAT_VALUE_CONFIG to PERF_PMU_FORMAT_VALUE_CONFIG_END.
> >>> +      */
> >>>       int value;
> >>> +     /** Which config bits are set by this format value. */
> >>>       DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
> >>> +     /** Element on list within struct perf_pmu. */
> >>>       struct list_head list;
> >>>  };
> >>>
> >>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> >>> index 68e15c38ae71..29571c0f9d15 100644
> >>> --- a/tools/perf/util/pmu.h
> >>> +++ b/tools/perf/util/pmu.h
> >>> @@ -34,30 +34,91 @@ struct perf_pmu_caps {
> >>>  };
> >>>
> >>>  struct perf_pmu {
> >>> +     /** The name of the PMU such as "cpu". */
> >>>       char *name;
> >>> +     /**
> >>> +      * Optional alternate name for the PMU determined in architecture
> >>> +      * specific code.
> >>> +      */
> >>>       char *alias_name;
> >>> +     /**
> >>> +      * Optional PMU identifier read from
> >>> +      * <sysfs>/bus/event_source/devices/<name>/identifier.
> >>> +      */
> >>>       char *id;
> >>> +     /**
> >>> +      * Perf event attributed type value, read from
> >>> +      * <sysfs>/bus/event_source/devices/<name>/type.
> >>> +      */
> >>>       __u32 type;
> >>> +     /**
> >>> +      * Can the PMU name be selected as if it were an event?
> >>> +      */
> >>>       bool selectable;
> >>> +     /**
> >>> +      * Is the PMU not within the CPU core? Determined by the presence of
> >>> +      * <sysfs>/bus/event_source/devices/<name>/cpumask.
> >>> +      */
> >>>       bool is_uncore;
> >>> +     /** Is the PMU name either cpu_core or cpu_atom. */
> >>
> >> I don't think we want to limit the hybrid names only to cpu_core or
> >> cpu_atom. Maybe something as below?
> >> /* Is a hybrid CPU PMU, e.g., cpu_core, cpu_atom. */
> >
> > Currently the hybrid code only works for cpu_core or cpu_atom, a
> > limitation of its implementation.
>
> I don't think so. See perf_pmu__hybrid_mounted(). If a PMU is named as
> "cpu_", we treat it as a hybrid CPU PMU. The cpu_core or cpu_atom should
> only be hard coded to specially handle some model-specific cases, e.g.,
> mem-loads-aux event.

Ugh.. Why is a property about something being a CPU named in an Intel
specific term for big little? Why wasn't this generalized? Why are CPU
PMUs assumed to be prefixed cpu_* .. ? The comment is factually
correct, we can hold off deprecating it on the assumption that it'd be
renamed to something more appropriate like is_cpu.

Thanks,
Ian

> Thanks,
> Kan
>
> > As pointed out in a later patch,
> > this bool isn't being used when it could be and I think we can work to
> > remove it. It would be possible to remove all uses of this with
> > perf_pmu__is_hybrid. As such I think it may be useful to mark the
> > hybrid variables in struct perf_pmu as deprecated while we work to
> > replace their use with more generic just any PMU code.
> >
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Kan
> >>
> >>>       bool is_hybrid;
> >>> +     /**
> >>> +      * Are events auxiliary events? Determined in architecture specific
> >>> +      * code.
> >>> +      */
> >>>       bool auxtrace;
> >>> +     /**
> >>> +      * Number of levels of :ppp precision supported by the PMU, read from
> >>> +      * <sysfs>/bus/event_source/devices/<name>/caps/max_precise.
> >>> +      */
> >>>       int max_precise;
> >>> +     /**
> >>> +      * Optional default perf_event_attr determined in architecture specific
> >>> +      * code.
> >>> +      */
> >>>       struct perf_event_attr *default_config;
> >>> +     /**
> >>> +      * Empty or the contents of either of:
> >>> +      * <sysfs>/bus/event_source/devices/<name>/cpumask.
> >>> +      * <sysfs>/bus/event_source/devices/<cpu>/cpus.
> >>> +      */
> >>>       struct perf_cpu_map *cpus;
> >>> -     struct list_head format;  /* HEAD struct perf_pmu_format -> list */
> >>> -     struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
> >>> +     /**
> >>> +      * Holds the contents of files read from
> >>> +      * <sysfs>/bus/event_source/devices/<name>/format/. The contents specify
> >>> +      * which event parameter changes what config, config1 or config2 bits.
> >>> +      */
> >>> +     struct list_head format;
> >>> +     /**
> >>> +      * List of struct perf_pmu_alias. Each alias corresponds to an event
> >>> +      * read from <sysfs>/bus/event_source/devices/<name>/events/ or from
> >>> +      * json events in pmu-events.c.
> >>> +      */
> >>> +     struct list_head aliases;
> >>> +     /** Has the list caps been initialized? */
> >>>       bool caps_initialized;
> >>> +     /** The length of the list caps. */
> >>>       u32 nr_caps;
> >>> -     struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
> >>> -     struct list_head list;    /* ELEM */
> >>> +     /**
> >>> +      * Holds the contents of files read from
> >>> +      * <sysfs>/bus/event_source/devices/<name>/caps/. The contents are pairs
> >>> +      * of the filename with the value of its contents, for example,
> >>> +      * max_precise (see above) may have a value of 3.
> >>> +      */
> >>> +     struct list_head caps;
> >>> +     /** Element on pmus list in pmu.c. */
> >>> +     struct list_head list;
> >>> +     /** Element on perf_pmu__hybrid_pmus. */
> >>>       struct list_head hybrid_list;
> >>>
> >>> +     /** Features to inhibit when events on this PMU are opened. */
> >>>       struct {
> >>> +             /** Disables perf_event_attr exclude_guest and exclude_host. */
> >>>               bool exclude_guest;
> >>>       } missing_features;
> >>>  };
> >>>
> >>> +/** A special global PMU used for testing. */
> >>>  extern struct perf_pmu perf_pmu__fake;
> >>>
> >>>  struct perf_pmu_info {
> >>> @@ -71,21 +132,53 @@ struct perf_pmu_info {
> >>>
> >>>  #define UNIT_MAX_LEN 31 /* max length for event unit name */
> >>>
> >>> +/**
> >>> + * An event either read from sysfs or builtin in pmu-events.c, created by
> >>> + * parsing the pmu-events json files.
> >>> + */
> >>>  struct perf_pmu_alias {
> >>>       char *name;
> >>> +     /** Optional short description of the event. */
> >>>       char *desc;
> >>> +     /** Optional long description. */
> >>>       char *long_desc;
> >>> +     /**
> >>> +      * Optional topic such as cache or pipeline, particularly for json
> >>> +      * events.
> >>> +      */
> >>>       char *topic;
> >>> +     /** Comma separated parameter list. */
> >>>       char *str;
> >>> -     struct list_head terms; /* HEAD struct parse_events_term -> list */
> >>> -     struct list_head list;  /* ELEM */
> >>> +     /** Owned list of the original parsed parameters. */
> >>> +     struct list_head terms;
> >>> +     /** List element of struct perf_pmu aliases. */
> >>> +     struct list_head list;
> >>> +     /** Units for the event, such as bytes or cache lines. */
> >>>       char unit[UNIT_MAX_LEN+1];
> >>> +     /** Value to scale read counter values by. */
> >>>       double scale;
> >>> +     /**
> >>> +      * Does the file
> >>> +      * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.per-pkg or
> >>> +      * equivalent json value exist and have the value 1.
> >>> +      */
> >>>       bool per_pkg;
> >>> +     /**
> >>> +      * Does the file
> >>> +      * <sysfs>/bus/event_source/devices/<pmu_name>/events/<name>.snapshot
> >>> +      * exist and have the value 1.
> >>> +      */
> >>>       bool snapshot;
> >>> +     /** Is the event hidden and so not shown in perf list by default. */
> >>>       bool deprecated;
> >>> +     /**
> >>> +      * A metric expression associated with an event. Doing this makes little
> >>> +      * sense due to scale and unit applying to both.
> >>> +      */
> >>>       char *metric_expr;
> >>> +     /** A name for the metric. unit applying to both. */
> >>>       char *metric_name;
> >>> +     /** The name copied from struct perf_pmu. */
> >>>       char *pmu_name;
> >>>  };
> >>>
