Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE3374036E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjF0Sdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjF0SdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:33:12 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFCD359D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:32:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40079620a83so44311cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687890749; x=1690482749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7K0Na1ueMpAAs3MzlJF92Yho3FRcETqD8qwawTqqFc=;
        b=e/pfOs22GIokVkqI5J7akSwBH2svdYxY0/QUERIXfSKF0jer7YNKJe3qoat3/Doj8/
         TEs2uHi1AG79uoJLHbRiniLUvA8KKA0cXmgA5L5uQzC5EBzbVbzQl1Z9uY5ZW/MkRO7e
         +DyACIFndYmHDRYNSDxOPiWj/Kgdc2O7lSNM871xivxiYZaf16+9udNm7nCAusHtPbMY
         5iW8AhATTqwmv88VgSm0IR3gVRvOipsD0ZfzazENuMMwyTP2KTafwez0wTHloU2RgEPf
         Uqqhz92bfq5jPXxjjfKryMoE+CWMxfY3cBfb+96QWQ4ojsqxJOosnENe1akjB4axgG5j
         /sgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890749; x=1690482749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7K0Na1ueMpAAs3MzlJF92Yho3FRcETqD8qwawTqqFc=;
        b=XR4JOgqlrFT2LHb+9TupfC7EFTrr6jCOiY5QQ+XoiFDnLl8RGIc9VEPD2PCPjc2CtZ
         aLf0OmoPsNAQg+S+A5+KCEqCMX2MTQ1LQ1whnOUpxMNzDumyROltzrmXmO0UgOwOa5nv
         W6GtC1fCcWvhlvsZGag5yqjBM4bkbDvcM0hltP++c+9lKgnk1PLPjBVyy41l71Y1K3nn
         cGYIDQ6WXs48rauCcnEkB0VBGpzQLkZz3FThUW9ADAmnn/UTuzVRXhoOKMmJJ0g12jLT
         L3NxCbPZd7d35Ag+BwyObhz5Hej/Ho92Om19Y25m/VoZKgp0D0G6NEA7GS1WKCnBSxXM
         /Nrg==
X-Gm-Message-State: AC+VfDws4HNuHOBhUQaXYACUJBrPGudeoIElyAcwcjusbvX1SMJDe4oJ
        U1hwOW6TiD+xYBBWc0Q39+J7bLdtFABdXJznajDhjw==
X-Google-Smtp-Source: ACHHUZ4c4KGXAte2Kf1JXrwjTmss/dsbjj7iiE1YmyPHwb5dqqOs3xpx/apLktvU8pCYy5sDex41OjZRTe6uHyncS4U=
X-Received: by 2002:a05:622a:3c7:b0:3f6:97b4:1a4a with SMTP id
 k7-20020a05622a03c700b003f697b41a4amr14542qtx.20.1687890749520; Tue, 27 Jun
 2023 11:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230614151625.2077-1-yangjihong1@huawei.com> <CAP-5=fUf0+7HwZ+AHUR0nRD5QnfPn9_CPMEdJZP_5goPfrPB+Q@mail.gmail.com>
 <CAP-5=fVOXjjcusjv858SOGrnNgE2w2sb7zS=0sZUpdFfR1T_GA@mail.gmail.com>
 <668a6159-b7a8-ed25-d8fa-5584a4c04d37@huawei.com> <CAP-5=fX6nWRboZ2dWc1h_y0pe5TAgs0QC0qwCeaLcALfJ+5YEA@mail.gmail.com>
 <cc3a669d-570b-2f0d-ce0f-0f4bee417eb2@huawei.com>
In-Reply-To: <cc3a669d-570b-2f0d-ce0f-0f4bee417eb2@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 27 Jun 2023 11:32:17 -0700
Message-ID: <CAP-5=fU-F6sCP+Bf-RssRxtvZs79OcjONbphExiGq390cBcZvw@mail.gmail.com>
Subject: Re: [PATCH] perf top & record: Fix segfault when default cycles event
 is not supported
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 4:46=E2=80=AFAM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Hello,
>
> On 2023/6/15 10:04, Ian Rogers wrote:
> > On Wed, Jun 14, 2023 at 6:55=E2=80=AFPM Yang Jihong <yangjihong1@huawei=
.com> wrote:
> >>
> >> Hello,
> >>
> >> On 2023/6/15 6:03, Ian Rogers wrote:
> >>> On Wed, Jun 14, 2023 at 9:18=E2=80=AFAM Ian Rogers <irogers@google.co=
m> wrote:
> >>>>
> >>>> On Wed, Jun 14, 2023 at 8:18=E2=80=AFAM Yang Jihong <yangjihong1@hua=
wei.com> wrote:
> >>>>>
> >>>>> The perf-record and perf-top call parse_event() to add a cycles eve=
nt to
> >>>>> an empty evlist. For the system that does not support hardware cycl=
es
> >>>>> event, such as QEMU, the evlist is empty due to the following code =
process:
> >>>>>
> >>>>>     parse_event(evlist, "cycles:P" or ""cycles:Pu")
> >>>>>       parse_events(evlist, "cycles:P")
> >>>>>         __parse_events
> >>>>>           ...
> >>>>>           ret =3D parse_events__scanner(str, &parse_state);
> >>>>>           // ret =3D 0
> >>>>>           ...
> >>>>>           ret2 =3D parse_events__sort_events_and_fix_groups()
> >>>>>           if (ret2 < 0)
> >>>>>             return ret;
> >>>>>           // The cycles event is not supported, here ret2 =3D -EINV=
AL,
> >>>>>           // Here return 0.
> >>>>>           ...
> >>>>>           evlist__splice_list_tail(evlist)
> >>>>>           // The code here does not execute to, so the evlist is st=
ill empty.
> >>>>>
> >>>>> A null pointer occurs when the content in the evlist is accessed la=
ter.
> >>>>>
> >>>>> Before:
> >>>>>
> >>>>>     # perf list hw
> >>>>>
> >>>>>     List of pre-defined events (to be used in -e or -M):
> >>>>>
> >>>>>     # perf record true
> >>>>>     libperf: Miscounted nr_mmaps 0 vs 1
> >>>>>     WARNING: No sample_id_all support, falling back to unordered pr=
ocessing
> >>>>>     perf: Segmentation fault
> >>>>>     Obtained 1 stack frames.
> >>>>>     [0xc5beff]
> >>>>>     Segmentation fault
> >>>>>
> >>>>> Solution:
> >>>>>     If cycles event is not supported, try to fall back to cpu-clock=
 event.
> >>>>>
> >>>>> After:
> >>>>>     # perf record true
> >>>>>     [ perf record: Woken up 1 times to write data ]
> >>>>>     [ perf record: Captured and wrote 0.006 MB perf.data ]
> >>>>>     #
> >>>>>
> >>>>> Fixes: 7b100989b4f6 ("perf evlist: Remove __evlist__add_default")
> >>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> >>>>
> >>>> Thanks, useful addition. The cpu-clock fall back wasn't present befo=
re
> >>>> 7b100989b4f6 so is the fixes tag correct?
> >>>
> >>> Hmm... it should be coming from evsel__fallback:
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/t=
ools/perf/util/evsel.c?h=3Dtmp.perf-tools-next#n2840
> >>> so we shouldn't duplicate that logic. The question is why we're not
> >>> doing the fallback.
> >>>
> >>
> >> Yes, it's a bit of the same logic as evsel__fallback, or we can call
> >> evlist__add_default() as before, simply create an evsel of hardware
> >> cycles and add it directly to evlist.
> >>
> >> Please confirm whether this solution is feasible. If it is feasible, I
> >> will send a v2 version.
> >
> > The previous evlist__add_default logic didn't handle wildcard PMUs for
> > cycles, hence wanting to reuse the parse events logic. The error is
> > that the logic now isn't doing the fallback properly. I think an
> > evlist__add_cycles which uses evsel__fallback makes sense matching the
> > previous logic. I'd be happy if you took a look. I'll write a patch so
> > that the perf_pmus list of core PMUs is never empty.
> >
>
> The gdb calltrace for core dump is as follows:
>
> (gdb) bt
> #0  0x00000000005ffaa2 in __perf_cpu_map__nr (cpus=3D0x0) at cpumap.c:283
> #1  0x00000000005ffd17 in perf_cpu_map__max (map=3D0x0) at cpumap.c:371
> #2  0x0000000000565644 in cpu_map_data__alloc
> (syn_data=3Dsyn_data@entry=3D0x7ffc843bff30,
> header_size=3Dheader_size@entry=3D8) at util/synthetic-events.c:1273
> #3  0x0000000000568712 in cpu_map_event__new (map=3D<optimized out>) at
> util/synthetic-events.c:1321
> #4  perf_event__synthesize_cpu_map (tool=3Dtool@entry=3D0xc37580 <record>=
,
> map=3D<optimized out>, process=3Dprocess@entry=3D0x413a80
> <process_synthesized_event>, machine=3Dmachine@entry=3D0x0) at
> util/synthetic-events.c:1341
> #5  0x000000000041426e in record__synthesize (tail=3Dtail@entry=3Dfalse,
> rec=3D0xc37580 <record>) at builtin-record.c:2050
> #6  0x0000000000415a0b in __cmd_record (argc=3D<optimized out>,
> argv=3D<optimized out>, rec=3D0xc37580 <record>) at builtin-record.c:2512
> #7  0x0000000000418f22 in cmd_record (argc=3D<optimized out>,
> argv=3D<optimized out>) at builtin-record.c:4260
> #8  0x00000000004babdd in run_builtin (p=3Dp@entry=3D0xc3a0e8
> <commands+264>, argc=3Dargc@entry=3D2, argv=3Dargv@entry=3D0x7ffc843c5b30=
) at
> perf.c:323
> #9  0x0000000000401632 in handle_internal_command (argv=3D0x7ffc843c5b30,
> argc=3D2) at perf.c:377
> #10 run_argv (argcp=3D<synthetic pointer>, argv=3D<synthetic pointer>) at
> perf.c:421
> #11 main (argc=3D2, argv=3D0x7ffc843c5b30) at perf.c:537
>
> The direct cause of the problem is that rec->evlist->core.all_cpus is
> empty, resulting in null pointer access.
>
> The code process is as follows:
>
> cmd_record
>    parse_event(rec->evlist)
>    // Hardware cycle events should not be supported here, so rec->evlist
> is empty
>    ...
>
>    evlist__create_maps(rec->evlist)
>      perf_evlist__set_maps(&rec->evlist->core)
>           perf_evlist__propagate_maps(&rec->evlist->core)
>             perf_evlist__for_each_evsel(&rec->evlist->core, evsel)
>                 // because rec->evlist is empty, don't get into that
> __perf_evlist__propagate_maps(), so rec->evlist->core.all_cpus is NULL.
>                   __perf_evlist__propagate_maps
>                     rec->evlist->core.all_cpus =3D perf_cpu_map__merge(ev=
list->all_cpus,
> evsel->cpus);
>    ...
>
>    __cmd_record
>      record__synthesize
>        perf_event__synthesize_cpu_map(rec->evlist->core.all_cpus)
>          cpu_map_event__new(rec->evlist->core.all_cpus)
>                   cpu_map_data__alloc(rec->evlist->core.all_cpus)
>                     perf_cpu_map__max(rec->evlist->core.all_cpus)
>                           __perf_cpu_map__nr
>                           // Here null pointer access!
>         ...
>
>         record__open
>        evsel__fallback
>           // Here fallback is just starting
>

Sorry, I don't follow this. I sent out a patch for the no core PMU
case - please take a look:
https://lore.kernel.org/lkml/20230627182834.117565-1-irogers@google.com/
I haven't got a reproduction for failing to open cycles and it's not
clear to me why evsel__fallback isn't being used to fallback to clock.
Were you able to look at this?

Thanks,
Ian

> Thanks,
> Yang
