Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9796444C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiLFNkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLFNkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:40:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EAEBC8B;
        Tue,  6 Dec 2022 05:40:12 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6C1iDg004047;
        Tue, 6 Dec 2022 13:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IYznzK0fY8OdZ3vNQhExOCrpli5pqYxywHUDILWaH8A=;
 b=qeQ0LI+gugwi0XQc+ssjaUsv/O8W1ZWY4kZOqiVRCMTaSRvvjY+rUlAktfZFdKlBkOem
 kf15dhJ+mc0c3cwSLxajkGrAxzMBtdcp4FISZ332w8N5o3mFFxsdJZeM4gnx1SnW9Y9V
 uyyWEcMF12uNRn+4sYdhacNuhdX8q8JlQ9VQSh164fFT4fOCx6OevlmAi9qFRHKQh3Ke
 AH44P3ZGcYLdhFn3MY7YKwcVwNEKAm6EnYzAe1mENQGe/sP69km7+lzll59jeWzcN9zQ
 QRSbvvUpVtqczwB/arFAcuynJ2qAjuJHjuUqO/13Ng0LILIvbJ3EaBudLIFbV+HKP9Tq Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m9wybmy8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 13:39:51 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B6CmHt8003666;
        Tue, 6 Dec 2022 13:39:50 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m9wybmy7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 13:39:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B696OZt008403;
        Tue, 6 Dec 2022 13:39:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3m9m5y1fby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 13:39:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com ([9.149.105.160])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B6DdjuP41877956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Dec 2022 13:39:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 753B0A405C;
        Tue,  6 Dec 2022 13:39:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45AA0A405B;
        Tue,  6 Dec 2022 13:39:42 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.125.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  6 Dec 2022 13:39:42 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH 18/20] perf stat: Display event stats using aggr counts
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAM9d7chxwxx+CuekO+6F8PcUveFTKhDL-aZdCfVwttfyyu-ecg@mail.gmail.com>
Date:   Tue, 6 Dec 2022 19:09:40 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Message-Id: <D148EA88-0609-471A-B7DB-39D4539814CA@linux.vnet.ibm.com>
References: <20221018020227.85905-1-namhyung@kernel.org>
 <20221018020227.85905-19-namhyung@kernel.org>
 <153310C5-413D-4079-9970-EDCEE2DF3340@linux.vnet.ibm.com>
 <CAM9d7chxwxx+CuekO+6F8PcUveFTKhDL-aZdCfVwttfyyu-ecg@mail.gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2t0UmTzuxEQzew2rEUoGFbJXIyZJjwIk
X-Proofpoint-ORIG-GUID: 3tUVkfKY8J_SilD-2w0CMX6z8fUyEh9Y
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_08,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212060110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 06-Dec-2022, at 12:30 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Hello,
>=20
> On Mon, Dec 5, 2022 at 2:52 AM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
>>=20
>>=20
>>=20
>>> On 18-Oct-2022, at 7:32 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>>>=20
>>> Now aggr counts are ready for use.  Convert the display routines to use
>>> the aggr counts and update the shadow stat with them.  It doesn't need
>>> to aggregate counts or collect aliases anymore during the display.  Get
>>> rid of now unused struct perf_aggr_thread_value.
>>>=20
>>> Note that there's a difference in the display order among the aggr mode.
>>> For per-core/die/socket/node aggregation, it shows relevant events in
>>> the same unit together, whereas global/thread/no aggregation it shows
>>> the same events for different units together.  So it still uses separate
>>> codes to display them due to the ordering.
>>>=20
>>> One more thing to note is that it breaks per-core event display for now.
>>> The next patch will fix it to have identical output as of now.
>>>=20
>>> Acked-by: Ian Rogers <irogers@google.com>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>> tools/perf/util/stat-display.c | 421 ++++-----------------------------
>>> tools/perf/util/stat.c         |   5 -
>>> tools/perf/util/stat.h         |   9 -
>>> 3 files changed, 49 insertions(+), 386 deletions(-)
>>>=20
>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
>>> index 4113aa86772f..bfae2784609c 100644
>>> --- a/tools/perf/util/stat-display.c
>>> +++ b/tools/perf/util/stat-display.c
>>> @@ -442,31 +442,6 @@ static void print_metric_header(struct perf_stat_c=
onfig *config,
>>>              fprintf(os->fh, "%*s ", config->metric_only_len, unit);
>>> }
>>>=20
>>> -static int first_shadow_map_idx(struct perf_stat_config *config,
>>> -                             struct evsel *evsel, const struct aggr_cp=
u_id *id)
>>> -{
>>> -     struct perf_cpu_map *cpus =3D evsel__cpus(evsel);
>>> -     struct perf_cpu cpu;
>>> -     int idx;
>>> -
>>> -     if (config->aggr_mode =3D=3D AGGR_NONE)
>>> -             return perf_cpu_map__idx(cpus, id->cpu);
>>> -
>>> -     if (config->aggr_mode =3D=3D AGGR_THREAD)
>>> -             return id->thread_idx;
>>> -
>>> -     if (!config->aggr_get_id)
>>> -             return 0;
>>> -
>>> -     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
>>> -             struct aggr_cpu_id cpu_id =3D config->aggr_get_id(config,=
 cpu);
>>> -
>>> -             if (aggr_cpu_id__equal(&cpu_id, id))
>>> -                     return idx;
>>> -     }
>>> -     return 0;
>>> -}
>>> -
>>> static void abs_printout(struct perf_stat_config *config,
>>>                       struct aggr_cpu_id id, int nr, struct evsel *evse=
l, double avg)
>>> {
>>> @@ -537,7 +512,7 @@ static bool is_mixed_hw_group(struct evsel *counter)
>>> static void printout(struct perf_stat_config *config, struct aggr_cpu_i=
d id, int nr,
>>>                   struct evsel *counter, double uval,
>>>                   char *prefix, u64 run, u64 ena, double noise,
>>> -                  struct runtime_stat *st)
>>> +                  struct runtime_stat *st, int map_idx)
>>> {
>>>      struct perf_stat_output_ctx out;
>>>      struct outstate os =3D {
>>> @@ -648,8 +623,7 @@ static void printout(struct perf_stat_config *confi=
g, struct aggr_cpu_id id, int
>>>              print_running(config, run, ena);
>>>      }
>>>=20
>>> -     perf_stat__print_shadow_stats(config, counter, uval,
>>> -                             first_shadow_map_idx(config, counter, &id=
),
>>> +     perf_stat__print_shadow_stats(config, counter, uval, map_idx,
>>>                              &out, &config->metric_events, st);
>>>      if (!config->csv_output && !config->metric_only && !config->json_o=
utput) {
>>>              print_noise(config, counter, noise);
>>> @@ -657,34 +631,6 @@ static void printout(struct perf_stat_config *conf=
ig, struct aggr_cpu_id id, int
>>>      }
>>> }
>>>=20
>>> -static void aggr_update_shadow(struct perf_stat_config *config,
>>> -                            struct evlist *evlist)
>>> -{
>>> -     int idx, s;
>>> -     struct perf_cpu cpu;
>>> -     struct aggr_cpu_id s2, id;
>>> -     u64 val;
>>> -     struct evsel *counter;
>>> -     struct perf_cpu_map *cpus;
>>> -
>>> -     for (s =3D 0; s < config->aggr_map->nr; s++) {
>>> -             id =3D config->aggr_map->map[s];
>>> -             evlist__for_each_entry(evlist, counter) {
>>> -                     cpus =3D evsel__cpus(counter);
>>> -                     val =3D 0;
>>> -                     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
>>> -                             s2 =3D config->aggr_get_id(config, cpu);
>>> -                             if (!aggr_cpu_id__equal(&s2, &id))
>>> -                                     continue;
>>> -                             val +=3D perf_counts(counter->counts, idx=
, 0)->val;
>>> -                     }
>>> -                     perf_stat__update_shadow_stats(counter, val,
>>> -                                     first_shadow_map_idx(config, coun=
ter, &id),
>>> -                                     &rt_stat);
>>> -             }
>>> -     }
>>> -}
>>> -
>>> static void uniquify_event_name(struct evsel *counter)
>>> {
>>>      char *new_name;
>>> @@ -721,137 +667,51 @@ static void uniquify_event_name(struct evsel *co=
unter)
>>>      counter->uniquified_name =3D true;
>>> }
>>>=20
>>> -static void collect_all_aliases(struct perf_stat_config *config, struc=
t evsel *counter,
>>> -                         void (*cb)(struct perf_stat_config *config, s=
truct evsel *counter, void *data,
>>> -                                    bool first),
>>> -                         void *data)
>>> +static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_conf=
ig *config)
>>> {
>>> -     struct evlist *evlist =3D counter->evlist;
>>> -     struct evsel *alias;
>>> -
>>> -     alias =3D list_prepare_entry(counter, &(evlist->core.entries), co=
re.node);
>>> -     list_for_each_entry_continue (alias, &evlist->core.entries, core.=
node) {
>>> -             /* Merge events with the same name, etc. but on different=
 PMUs. */
>>> -             if (!strcmp(evsel__name(alias), evsel__name(counter)) &&
>>> -                     alias->scale =3D=3D counter->scale &&
>>> -                     alias->cgrp =3D=3D counter->cgrp &&
>>> -                     !strcmp(alias->unit, counter->unit) &&
>>> -                     evsel__is_clock(alias) =3D=3D evsel__is_clock(cou=
nter) &&
>>> -                     strcmp(alias->pmu_name, counter->pmu_name)) {
>>> -                     alias->merged_stat =3D true;
>>> -                     cb(config, alias, data, false);
>>> -             }
>>> -     }
>>> +     return evsel__is_hybrid(evsel) && !config->hybrid_merge;
>>> }
>>>=20
>>> -static bool hybrid_merge(struct evsel *counter, struct perf_stat_confi=
g *config,
>>> -                      bool check)
>>> +static void uniquify_counter(struct perf_stat_config *config, struct e=
vsel *counter)
>>> {
>>> -     if (evsel__is_hybrid(counter)) {
>>> -             if (check)
>>> -                     return config->hybrid_merge;
>>> -             else
>>> -                     return !config->hybrid_merge;
>>> -     }
>>> -
>>> -     return false;
>>> -}
>>> -
>>> -static bool collect_data(struct perf_stat_config *config, struct evsel=
 *counter,
>>> -                         void (*cb)(struct perf_stat_config *config, s=
truct evsel *counter, void *data,
>>> -                                    bool first),
>>> -                         void *data)
>>> -{
>>> -     if (counter->merged_stat)
>>> -             return false;
>>> -     cb(config, counter, data, true);
>>> -     if (config->no_merge || hybrid_merge(counter, config, false))
>>> +     if (config->no_merge || hybrid_uniquify(counter, config))
>>>              uniquify_event_name(counter);
>>> -     else if (counter->auto_merge_stats || hybrid_merge(counter, confi=
g, true))
>>> -             collect_all_aliases(config, counter, cb, data);
>>> -     return true;
>>> -}
>>> -
>>> -struct aggr_data {
>>> -     u64 ena, run, val;
>>> -     struct aggr_cpu_id id;
>>> -     int nr;
>>> -     int cpu_map_idx;
>>> -};
>>> -
>>> -static void aggr_cb(struct perf_stat_config *config,
>>> -                 struct evsel *counter, void *data, bool first)
>>> -{
>>> -     struct aggr_data *ad =3D data;
>>> -     int idx;
>>> -     struct perf_cpu cpu;
>>> -     struct perf_cpu_map *cpus;
>>> -     struct aggr_cpu_id s2;
>>> -
>>> -     cpus =3D evsel__cpus(counter);
>>> -     perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
>>> -             struct perf_counts_values *counts;
>>> -
>>> -             s2 =3D config->aggr_get_id(config, cpu);
>>> -             if (!aggr_cpu_id__equal(&s2, &ad->id))
>>> -                     continue;
>>> -             if (first)
>>> -                     ad->nr++;
>>> -             counts =3D perf_counts(counter->counts, idx, 0);
>>> -             /*
>>> -              * When any result is bad, make them all to give
>>> -              * consistent output in interval mode.
>>> -              */
>>> -             if (counts->ena =3D=3D 0 || counts->run =3D=3D 0 ||
>>> -                 counter->counts->scaled =3D=3D -1) {
>>> -                     ad->ena =3D 0;
>>> -                     ad->run =3D 0;
>>> -                     break;
>>> -             }
>>> -             ad->val +=3D counts->val;
>>> -             ad->ena +=3D counts->ena;
>>> -             ad->run +=3D counts->run;
>>> -     }
>>> }
>>>=20
>>> static void print_counter_aggrdata(struct perf_stat_config *config,
>>>                                 struct evsel *counter, int s,
>>>                                 char *prefix, bool metric_only,
>>> -                                bool *first, struct perf_cpu cpu)
>>> +                                bool *first)
>>> {
>>> -     struct aggr_data ad;
>>>      FILE *output =3D config->output;
>>>      u64 ena, run, val;
>>> -     int nr;
>>> -     struct aggr_cpu_id id;
>>>      double uval;
>>> +     struct perf_stat_evsel *ps =3D counter->stats;
>>> +     struct perf_stat_aggr *aggr =3D &ps->aggr[s];
>>> +     struct aggr_cpu_id id =3D config->aggr_map->map[s];
>>> +     double avg =3D aggr->counts.val;
>>>=20
>>> -     ad.id =3D id =3D config->aggr_map->map[s];
>>> -     ad.val =3D ad.ena =3D ad.run =3D 0;
>>> -     ad.nr =3D 0;
>>> -     if (!collect_data(config, counter, aggr_cb, &ad))
>>> +     if (counter->supported && aggr->nr =3D=3D 0)
>>>              return;
>>=20
>> Hi Namhyung,
>>=20
>> Observed one issue with this change in tmp.perf/core branch of git://git=
.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
>> Patch link: https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.g=
it/commit/?h=3Dtmp.perf/core&id=3D91f85f98da7ab8c32105f42dd03884c01ec4498f
>>=20
>> If we have multiple events in a group and if all events in that group ca=
n't go in at once, the group will fail to schedule.
>> The perf stat result used to have status of all events in group.
>>=20
>> Example result from powerpc:
>>        # perf stat -e '{r1001e,r401e0,r4c010}' <workload>
>>        Performance counter stats for 'workload=E2=80=99:
>>=20
>>             <not counted>      r1001e
>>             <not counted>      r401e0
>>           <not supported>      r4c010
>>=20
>> But after this change, it shows only the event which broke the constrain=
t.
>>=20
>>        # ./perf stat -e '{r1001e,r401e0,r4c010}' <workload>
>>        Performance counter stats for 'workload=E2=80=99:
>>        <not supported>      r4c010
>>=20
>> The new condition added by the patch is:
>>=20
>>        if (counter->supported && aggr->nr =3D=3D 0)
>>                        return;
>>=20
>>=20
>> The first two events r1001e and r401e0 are good to go in this group, hen=
ce
>> counter->supported  is true where as aggr->nr is zero since this group is
>> not scheduled. Since counter->supported is false for third event which
>> broke the group constraint, the condition won't return and hence only pr=
ints
>> this event in output.
>>=20
>> Namhyung, is there any scenario because of which this condition was adde=
d ?
>> If not I would go ahead and sent a fix patch to remove this check.
>=20
> I remember it's for AGGR_THREAD and merged (uncore) aliases and hybrid
> events.  In system-wide per-thread mode, many of them would get 0 results
> and we'd like to skip them.  And now I see that we have evsel->merged_stat
> check already.
>=20
> Maybe we could just add the aggr_mode check there.

Thanks for the response Namhyung.
I will share my response in patch "[PATCH] perf stat: Update event skip con=
dition=E2=80=9D

Thanks
Athira
>=20
> Thanks,
> Namhyung

