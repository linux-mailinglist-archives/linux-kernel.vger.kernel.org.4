Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBDA676879
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjAUT0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjAUT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:26:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F99E2B62A
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:26:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so5900469wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RKR3WX55mQV3dM7wXrJLlKYpDEa/0DH3Aj1H0cUaUk=;
        b=AAKUjJ89VRGkhcF6auUJGEC46r8JC9YU/bqwJEl3Ejru46vVudUFVCEXz/9ZdABGww
         A8If6cGsrACQI+O6EdoTYys925KBhfh8+GfNVoigfgzRr/OulAqTfeqqTm9VngiTToVS
         AoZfGnmMW3i9SqkcNrJni80X9g7H4nXC6HMue+bVAwQg9GgpsSKVPvr1din90v27XfGk
         Gy7Mv33y8pvErlhGtHh0MptnHfC29VsFHoYDyyiV/mmj+AOpQtBC4VnDbCdEFFKY3x/U
         wEZfW1H7druKJ5Owmu488/xRJt9G06FEW8ZtYbEKsJez8+2ks9vlAU2ybAWtHOCLKc6C
         6gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RKR3WX55mQV3dM7wXrJLlKYpDEa/0DH3Aj1H0cUaUk=;
        b=zcUvxYQZ/MIp6h4IH3gJV3ROEEHb8lBrnMsZ7bG+khNHCcPfx0npurcmLOC2oFrz12
         mBpp4iyIBT5vyTwOn++85/S1hqLBnPXqLkAtJuTKOA22rK/d36ex0pXTLuoi6To9Lqtn
         xDuXUqmw8WpHfdggqcEX8DWKAiL+VTDR8e20PH+EFadxaGeHKRHUCfiwwqEGsuuKKDaL
         23YlGxHJ8ylOYpB9q/tHAlB4QXP733mSZkjGr+Mr7kMU1UfwZFHVEflQ3E3Qcxt0LzP5
         7CAsbxkc00CSmY2MxAt2hVUIWiQ0nV0B4oOafMWtWrZBsAmiCQu9pwrsl11MiBS6K0mW
         9fPQ==
X-Gm-Message-State: AFqh2kql9XrE19lO+YtQ6S7oJrqgSJzqpGoJDV/o/ifYiRupELVDJnog
        FN0ta1OH7jYPYPw44tCP5qwSG5b2uA6tiL+rfX3bNw==
X-Google-Smtp-Source: AMrXdXuMf0/K1FE61SJkKIfUAfiojxmMk6JRSnUUq0qG+I34XDRYLFTc0deTq0A0mKbZPMLZX7m25Zf9gq7JNmsCssQ=
X-Received: by 2002:a05:600c:5405:b0:3d0:50c4:432c with SMTP id
 he5-20020a05600c540500b003d050c4432cmr1115038wmb.67.1674329159846; Sat, 21
 Jan 2023 11:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20230121184648.38487-1-didi.debian@cknow.org>
In-Reply-To: <20230121184648.38487-1-didi.debian@cknow.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 21 Jan 2023 11:25:46 -0800
Message-ID: <CAP-5=fX1-3ZnXk8G2fB0q9F3MjjA+zWWm1LbuYGc5nL5v3bXYg@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Various spelling fixes
To:     Diederik de Haas <didi.debian@cknow.org>,
        Edward <edward.baker@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 10:47 AM Diederik de Haas <didi.debian@cknow.org> w=
rote:
>
> Fix various spelling errors as reported by Debian's lintian tool.
>
> "amount of times" -> "number of times"
> Condtional -> Conditional
> Instrcution -> Instruction
> Interal -> Internal
> adderted -> asserted
> casued -> caused
> cummulative -> cumulative
> exlusive -> exclusive
> occurance -> occurrence
> occured -> occurred
> occurences -> occurrences
> ocurrence -> occurrence
> onthe -> on the
> preceeding -> preceding
> reponses -> responses
> satisifed -> satisfied
> successfuly -> successfully
> transfered -> transferred
> transfering -> transferring
> upto -> up to
>
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

Thanks Diederik,

The JSON files are generated from Intel information here:
https://github.com/intel/perfmon/
Fixing the spelling in the tree means that when we update the
incorrect spelling will be generated again. Intel are looking at the
matter, I've added Edward Baker to the e-mail. To make it clearer,
could you separate the JSON fixes from the tool fixes?

Could you also add the mistakes found by this list to:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scr=
ipts/spelling.txt
which will mean the checkpatch.pl tool will flag the mistakes should
regressions happen.

Beside those 2 suggestions, the corrections look great and thank you
for taking the time to do this.
Ian

> ---
>  tools/perf/Documentation/perf-bench.txt       |  2 +-
>  tools/perf/builtin-bench.c                    |  2 +-
>  tools/perf/builtin-script.c                   |  2 +-
>  .../arch/x86/alderlake/adl-metrics.json       |  4 +-
>  .../pmu-events/arch/x86/amdzen3/branch.json   |  2 +-
>  .../pmu-events/arch/x86/amdzen4/pipeline.json |  2 +-
>  .../arch/x86/broadwell/pipeline.json          |  2 +-
>  .../arch/x86/broadwellde/pipeline.json        |  2 +-
>  .../arch/x86/broadwellde/uncore-cache.json    | 48 ++++++------
>  .../arch/x86/broadwellde/uncore-power.json    |  2 +-
>  .../arch/x86/broadwellx/pipeline.json         |  2 +-
>  .../arch/x86/broadwellx/uncore-cache.json     | 24 +++---
>  .../x86/broadwellx/uncore-interconnect.json   | 16 ++--
>  .../arch/x86/broadwellx/uncore-power.json     |  2 +-
>  .../arch/x86/cascadelakex/uncore-other.json   |  4 +-
>  .../arch/x86/cascadelakex/uncore-power.json   |  2 +-
>  .../arch/x86/jaketown/pipeline.json           |  2 +-
>  .../arch/x86/jaketown/uncore-cache.json       | 22 +++---
>  .../x86/jaketown/uncore-interconnect.json     | 74 +++++++++----------
>  .../arch/x86/jaketown/uncore-other.json       | 20 ++---
>  .../arch/x86/jaketown/uncore-power.json       |  2 +-
>  .../arch/x86/knightslanding/cache.json        | 62 ++++++++--------
>  .../arch/x86/knightslanding/pipeline.json     |  8 +-
>  .../arch/x86/knightslanding/uncore-other.json |  4 +-
>  .../arch/x86/sandybridge/pipeline.json        |  2 +-
>  .../arch/x86/silvermont/frontend.json         |  2 +-
>  .../x86/westmereep-dp/virtual-memory.json     |  2 +-
>  tools/perf/util/evswitch.h                    |  4 +-
>  28 files changed, 161 insertions(+), 161 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documen=
tation/perf-bench.txt
> index a0529c7fa5ef..f04f0eaded98 100644
> --- a/tools/perf/Documentation/perf-bench.txt
> +++ b/tools/perf/Documentation/perf-bench.txt
> @@ -18,7 +18,7 @@ COMMON OPTIONS
>  --------------
>  -r::
>  --repeat=3D::
> -Specify amount of times to repeat the run (default 10).
> +Specify number of times to repeat the run (default 10).
>
>  -f::
>  --format=3D::
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index 334ab897aae3..bd4fd94a2ce0 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -150,7 +150,7 @@ unsigned int bench_repeat =3D 10; /* default number o=
f times to repeat the run */
>
>  static const struct option bench_options[] =3D {
>         OPT_STRING('f', "format", &bench_format_str, "default|simple", "S=
pecify the output formatting style"),
> -       OPT_UINTEGER('r', "repeat",  &bench_repeat,   "Specify amount of =
times to repeat the run"),
> +       OPT_UINTEGER('r', "repeat",  &bench_repeat,   "Specify number of =
times to repeat the run"),
>         OPT_END()
>  };
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 69394ac0a20d..8901acdd7f5b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1301,7 +1301,7 @@ static int perf_sample__fprintf_brstackinsn(struct =
perf_sample *sample,
>                 goto out;
>
>         /*
> -        * Print final block upto sample
> +        * Print final block up to sample
>          *
>          * Due to pipeline delays the LBRs might be missing a branch
>          * or two, which can result in very large or negative blocks
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> index 2eb3d7464d9f..39e8b5e9bc29 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> @@ -1830,13 +1830,13 @@
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurance rate)",
> +        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurrence rate)",
>          "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
>          "MetricName": "IpBranch",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instruction per (near) call (lower number m=
eans higher occurance rate)",
> +        "BriefDescription": "Instruction per (near) call (lower number m=
eans higher occurrence rate)",
>          "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
>          "MetricName": "IpCall",
>          "Unit": "cpu_atom"
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/branch.json b/tools/p=
erf/pmu-events/arch/x86/amdzen3/branch.json
> index 018a7fe94fb9..a3b53845ca19 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen3/branch.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen3/branch.json
> @@ -42,7 +42,7 @@
>    {
>      "EventName": "bp_l1_tlb_fetch_hit.if4k",
>      "EventCode": "0x94",
> -    "BriefDescription": "The number of instruction fetches that hit in t=
he L1 ITLB. L1 Instrcution TLB hit (4K or 16K page size).",
> +    "BriefDescription": "The number of instruction fetches that hit in t=
he L1 ITLB. L1 Instruction TLB hit (4K or 16K page size).",
>      "UMask": "0x01"
>    },
>    {
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json b/tools=
/perf/pmu-events/arch/x86/amdzen4/pipeline.json
> index 4ae8316c7507..b9d368005d4d 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
> @@ -1,7 +1,7 @@
>  [
>    {
>      "MetricName": "total_dispatch_slots",
> -    "BriefDescription": "Total dispatch slots (upto 6 instructions can b=
e dispatched in each cycle).",
> +    "BriefDescription": "Total dispatch slots (up to 6 instructions can =
be dispatched in each cycle).",
>      "MetricExpr": "6 * ls_not_halted_cyc"
>    },
>    {
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/broadwell/pipeline.json
> index 2f0fe6b35334..56e467ecbccf 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> @@ -500,7 +500,7 @@
>          "BriefDescription": "Stalls caused by changing prefix length of =
the instruction.",
>          "EventCode": "0x87",
>          "EventName": "ILD_STALL.LCP",
> -        "PublicDescription": "This event counts stalls occured due to ch=
anging prefix length (66, 67 or REX.W when they change the length of the de=
coded instruction). Occurrences counting is proportional to the number of p=
refixes in a 16B-line. This may result in the following penalties: three-cy=
cle penalty for each LCP in a 16-byte chunk.",
> +        "PublicDescription": "This event counts stalls occurred due to c=
hanging prefix length (66, 67 or REX.W when they change the length of the d=
ecoded instruction). Occurrences counting is proportional to the number of =
prefixes in a 16B-line. This may result in the following penalties: three-c=
ycle penalty for each LCP in a 16-byte chunk.",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> index 9e7d66b07f01..089dc5acee83 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> @@ -500,7 +500,7 @@
>          "BriefDescription": "Stalls caused by changing prefix length of =
the instruction.",
>          "EventCode": "0x87",
>          "EventName": "ILD_STALL.LCP",
> -        "PublicDescription": "This event counts stalls occured due to ch=
anging prefix length (66, 67 or REX.W when they change the length of the de=
coded instruction). Occurrences counting is proportional to the number of p=
refixes in a 16B-line. This may result in the following penalties: three-cy=
cle penalty for each LCP in a 16-byte chunk.",
> +        "PublicDescription": "This event counts stalls occurred due to c=
hanging prefix length (66, 67 or REX.W when they change the length of the d=
ecoded instruction). Occurrences counting is proportional to the number of =
prefixes in a 16B-line. This may result in the following penalties: three-c=
ycle penalty for each LCP in a 16-byte chunk.",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json=
 b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> index b8c9845308b2..906dd4fc4ecb 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> @@ -968,7 +968,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.ALL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions insert=
ed into the TOR.    This includes requests that reside in the TOR for a sho=
rt time, such as LLC Hits that do not need to snoop cores or requests that =
get rejected and have to be retried through one of the ingress queues.  The=
 TOR is more commonly a bottleneck in skews with smaller core counts, where=
 the ratio of RTIDs to TOR entries is larger.  Note that there are reserved=
 TOR entries for various request types, so it is possible that a given requ=
est type be blocked with an occupancy that is less than 20.  Also note that=
 generally requests will not be able to arbitrate into the TOR pipeline if =
there are no available TOR slots.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inser=
ted into the TOR.    This includes requests that reside in the TOR for a sh=
ort time, such as LLC Hits that do not need to snoop cores or requests that=
 get rejected and have to be retried through one of the ingress queues.  Th=
e TOR is more commonly a bottleneck in skews with smaller core counts, wher=
e the ratio of RTIDs to TOR entries is larger.  Note that there are reserve=
d TOR entries for various request types, so it is possible that a given req=
uest type be blocked with an occupancy that is less than 20.  Also note tha=
t generally requests will not be able to arbitrate into the TOR pipeline if=
 there are no available TOR slots.",
>          "UMask": "0x8",
>          "Unit": "CBO"
>      },
> @@ -977,7 +977,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.EVICTION",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions i=
nserted into the TOR.  Evictions can be quick, such as when the line is in =
the F, S, or E states and no core valid bits are set.  They can also be lon=
ger if either CV bits are set (so the cores need to be snooped) and/or if t=
here is a HitM (in which case it is necessary to write the request out to m=
emory).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions =
inserted into the TOR.  Evictions can be quick, such as when the line is in=
 the F, S, or E states and no core valid bits are set.  They can also be lo=
nger if either CV bits are set (so the cores need to be snooped) and/or if =
there is a HitM (in which case it is necessary to write the request out to =
memory).",
>          "UMask": "0x4",
>          "Unit": "CBO"
>      },
> @@ -986,7 +986,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.LOCAL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions insert=
ed into the TOR that are satisifed by locally HOMed memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inser=
ted into the TOR that are satisfied by locally HOMed memory.",
>          "UMask": "0x28",
>          "Unit": "CBO"
>      },
> @@ -995,7 +995,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satis=
ifed by an opcode,  inserted into the TOR that are satisifed by locally HOM=
ed memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, sati=
sfied by an opcode,  inserted into the TOR that are satisfied by locally HO=
Med memory.",
>          "UMask": "0x21",
>          "Unit": "CBO"
>      },
> @@ -1004,7 +1004,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inser=
ted into the TOR that are satisifed by locally HOMed memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inse=
rted into the TOR that are satisfied by locally HOMed memory.",
>          "UMask": "0x2a",
>          "Unit": "CBO"
>      },
> @@ -1013,7 +1013,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sati=
sifed by an opcode, inserted into the TOR that are satisifed by locally HOM=
ed memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sat=
isfied by an opcode, inserted into the TOR that are satisfied by locally HO=
Med memory.",
>          "UMask": "0x23",
>          "Unit": "CBO"
>      },
> @@ -1022,7 +1022,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inser=
ted into the TOR that match an opcode.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inse=
rted into the TOR that match an opcode.",
>          "UMask": "0x3",
>          "Unit": "CBO"
>      },
> @@ -1031,7 +1031,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inser=
ted into the TOR that are satisifed by remote caches or remote memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inse=
rted into the TOR that are satisfied by remote caches or remote memory.",
>          "UMask": "0x8a",
>          "Unit": "CBO"
>      },
> @@ -1040,7 +1040,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sati=
sifed by an opcode,  inserted into the TOR that are satisifed by remote cac=
hes or remote memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sat=
isfied by an opcode,  inserted into the TOR that are satisfied by remote ca=
ches or remote memory.",
>          "UMask": "0x83",
>          "Unit": "CBO"
>      },
> @@ -1049,7 +1049,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matche=
s an RTID destination) transactions inserted into the TOR.  The NID is prog=
rammed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it =
is possible to monitor misses to specific NIDs in the system.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (match=
es an RTID destination) transactions inserted into the TOR.  The NID is pro=
grammed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it=
 is possible to monitor misses to specific NIDs in the system.",
>          "UMask": "0x48",
>          "Unit": "CBO"
>      },
> @@ -1058,7 +1058,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tr=
ansactions inserted into the TOR.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction t=
ransactions inserted into the TOR.",
>          "UMask": "0x44",
>          "Unit": "CBO"
>      },
> @@ -1067,7 +1067,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss re=
quests that were inserted into the TOR.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss r=
equests that were inserted into the TOR.",
>          "UMask": "0x4a",
>          "Unit": "CBO"
>      },
> @@ -1076,7 +1076,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inser=
ted into the TOR that match a NID and an opcode.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inse=
rted into the TOR that match a NID and an opcode.",
>          "UMask": "0x43",
>          "Unit": "CBO"
>      },
> @@ -1085,7 +1085,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted i=
nto the TOR that match a NID and an opcode.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted =
into the TOR that match a NID and an opcode.",
>          "UMask": "0x41",
>          "Unit": "CBO"
>      },
> @@ -1094,7 +1094,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_WB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write trans=
actions inserted into the TOR.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write tran=
sactions inserted into the TOR.",
>          "UMask": "0x50",
>          "Unit": "CBO"
>      },
> @@ -1103,7 +1103,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted i=
nto the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted =
into the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
>          "UMask": "0x1",
>          "Unit": "CBO"
>      },
> @@ -1112,7 +1112,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.REMOTE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions insert=
ed into the TOR that are satisifed by remote caches or remote memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inser=
ted into the TOR that are satisfied by remote caches or remote memory.",
>          "UMask": "0x88",
>          "Unit": "CBO"
>      },
> @@ -1121,7 +1121,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satis=
ifed by an opcode,  inserted into the TOR that are satisifed by remote cach=
es or remote memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, sati=
sfied by an opcode,  inserted into the TOR that are satisfied by remote cac=
hes or remote memory.",
>          "UMask": "0x81",
>          "Unit": "CBO"
>      },
> @@ -1130,7 +1130,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.WB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions inse=
rted into the TOR.   This does not include RFO, but actual operations that =
contain data being sent from the core.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions ins=
erted into the TOR.   This does not include RFO, but actual operations that=
 contain data being sent from the core.",
>          "UMask": "0x10",
>          "Unit": "CBO"
>      },
> @@ -1166,7 +1166,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding  transactions, satisifed by an opcode,  in the TOR that are sat=
isifed by locally HOMed memory.",
> +        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding  transactions, satisfied by an opcode,  in the TOR that are sat=
isfied by locally HOMed memory.",
>          "UMask": "0x21",
>          "Unit": "CBO"
>      },
> @@ -1193,7 +1193,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss transactions, satisifed by an opcode, in the TOR that are =
satisifed by locally HOMed memory.",
> +        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss transactions, satisfied by an opcode, in the TOR that are =
satisfied by locally HOMed memory.",
>          "UMask": "0x23",
>          "Unit": "CBO"
>      },
> @@ -1220,7 +1220,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss transactions, satisifed by an opcode, in the TOR that are =
satisifed by remote caches or remote memory.",
> +        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss transactions, satisfied by an opcode, in the TOR that are =
satisfied by remote caches or remote memory.",
>          "UMask": "0x83",
>          "Unit": "CBO"
>      },
> @@ -1301,7 +1301,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding  transactions, satisifed by an opcode,  in the TOR that are sat=
isifed by remote caches or remote memory.",
> +        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding  transactions, satisfied by an opcode,  in the TOR that are sat=
isfied by remote caches or remote memory.",
>          "UMask": "0x81",
>          "Unit": "CBO"
>      },
> @@ -1388,7 +1388,7 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
>          "PerPkg": "1",
> -        "PublicDescription": "Number of allocations into the Cbo Egress.=
  The Egress is used to queue up requests destined for the ring.; Ring tran=
sactions from the Corebo destined for the BL ring.  This is commonly used f=
or transfering writeback data to the cache.",
> +        "PublicDescription": "Number of allocations into the Cbo Egress.=
  The Egress is used to queue up requests destined for the ring.; Ring tran=
sactions from the Corebo destined for the BL ring.  This is commonly used f=
or transferring writeback data to the cache.",
>          "UMask": "0x40",
>          "Unit": "CBO"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json=
 b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> index 124b3fe2e0e1..9d3431b30158 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> @@ -427,7 +427,7 @@
>          "EventCode": "0x9",
>          "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles that we are in=
 Interal PROCHOT mode.  This mode is triggered when a sensor on the die det=
ermines that we are too hot and must throttle to avoid damaging the chip.",
> +        "PublicDescription": "Counts the number of cycles that we are in=
 Internal PROCHOT mode.  This mode is triggered when a sensor on the die de=
termines that we are too hot and must throttle to avoid damaging the chip."=
,
>          "Unit": "PCU"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> index 75233316640b..b08516adf789 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> @@ -500,7 +500,7 @@
>          "BriefDescription": "Stalls caused by changing prefix length of =
the instruction.",
>          "EventCode": "0x87",
>          "EventName": "ILD_STALL.LCP",
> -        "PublicDescription": "This event counts stalls occured due to ch=
anging prefix length (66, 67 or REX.W when they change the length of the de=
coded instruction). Occurrences counting is proportional to the number of p=
refixes in a 16B-line. This may result in the following penalties: three-cy=
cle penalty for each LCP in a 16-byte chunk.",
> +        "PublicDescription": "This event counts stalls occurred due to c=
hanging prefix length (66, 67 or REX.W when they change the length of the d=
ecoded instruction). Occurrences counting is proportional to the number of =
prefixes in a 16B-line. This may result in the following penalties: three-c=
ycle penalty for each LCP in a 16-byte chunk.",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json =
b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
> index 38eaac5afd4b..d9d96aacba5b 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
> @@ -1175,7 +1175,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.LOCAL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inser=
ted into the TOR that are satisifed by locally HOMed memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inser=
ted into the TOR that are satisfied by locally HOMed memory.",
>          "UMask": "0x28",
>          "Unit": "CBO"
>      },
> @@ -1184,7 +1184,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, sati=
sifed by an opcode,  inserted into the TOR that are satisifed by locally HO=
Med memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, sati=
sfied by an opcode,  inserted into the TOR that are satisfied by locally HO=
Med memory.",
>          "UMask": "0x21",
>          "Unit": "CBO"
>      },
> @@ -1193,7 +1193,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inse=
rted into the TOR that are satisifed by locally HOMed memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inse=
rted into the TOR that are satisfied by locally HOMed memory.",
>          "UMask": "0x2a",
>          "Unit": "CBO"
>      },
> @@ -1202,7 +1202,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sat=
isifed by an opcode, inserted into the TOR that are satisifed by locally HO=
Med memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sat=
isfied by an opcode, inserted into the TOR that are satisfied by locally HO=
Med memory.",
>          "UMask": "0x23",
>          "Unit": "CBO"
>      },
> @@ -1220,7 +1220,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inse=
rted into the TOR that are satisifed by remote caches or remote memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inse=
rted into the TOR that are satisfied by remote caches or remote memory.",
>          "UMask": "0x8a",
>          "Unit": "CBO"
>      },
> @@ -1229,7 +1229,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sat=
isifed by an opcode,  inserted into the TOR that are satisifed by remote ca=
ches or remote memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sat=
isfied by an opcode,  inserted into the TOR that are satisfied by remote ca=
ches or remote memory.",
>          "UMask": "0x83",
>          "Unit": "CBO"
>      },
> @@ -1301,7 +1301,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.REMOTE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inser=
ted into the TOR that are satisifed by remote caches or remote memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inser=
ted into the TOR that are satisfied by remote caches or remote memory.",
>          "UMask": "0x88",
>          "Unit": "CBO"
>      },
> @@ -1310,7 +1310,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, sati=
sifed by an opcode,  inserted into the TOR that are satisifed by remote cac=
hes or remote memory.",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, sati=
sfied by an opcode,  inserted into the TOR that are satisfied by remote cac=
hes or remote memory.",
>          "UMask": "0x81",
>          "Unit": "CBO"
>      },
> @@ -1365,7 +1365,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding  transactions, satisifed by an opcode,  in the TOR that are sat=
isifed by locally HOMed memory.",
> +        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding  transactions, satisfied by an opcode,  in the TOR that are sat=
isfied by locally HOMed memory.",
>          "UMask": "0x21",
>          "Unit": "CBO"
>      },
> @@ -1392,7 +1392,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss transactions, satisifed by an opcode, in the TOR that are =
satisifed by locally HOMed memory.",
> +        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss transactions, satisfied by an opcode, in the TOR that are =
satisfied by locally HOMed memory.",
>          "UMask": "0x23",
>          "Unit": "CBO"
>      },
> @@ -1419,7 +1419,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss transactions, satisifed by an opcode, in the TOR that are =
satisifed by remote caches or remote memory.",
> +        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss transactions, satisfied by an opcode, in the TOR that are =
satisfied by remote caches or remote memory.",
>          "UMask": "0x83",
>          "Unit": "CBO"
>      },
> @@ -1500,7 +1500,7 @@
>          "EventCode": "0x36",
>          "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding  transactions, satisifed by an opcode,  in the TOR that are sat=
isifed by remote caches or remote memory.",
> +        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding  transactions, satisfied by an opcode,  in the TOR that are sat=
isfied by remote caches or remote memory.",
>          "UMask": "0x81",
>          "Unit": "CBO"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnec=
t.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
> index a5457c7ba58b..39218484278a 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
> @@ -38,7 +38,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.; The spawn failed because there were not enough Egres=
s credits.  Had there been enough credits, the spawn would have worked as t=
he RBT bit was set and the RBT tag matched.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.; The spawn failed because there were not enough Egre=
ss credits.  Had there been enough credits, the spawn would have worked as =
the RBT bit was set and the RBT tag matched.",
>          "UMask": "0x2",
>          "Unit": "QPI LL"
>      },
> @@ -47,7 +47,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_MISS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.; The spawn failed because the RBT tag did not match a=
nd there weren't enough Egress credits.   The valid bit was set.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.; The spawn failed because the RBT tag did not match =
and there weren't enough Egress credits.   The valid bit was set.",
>          "UMask": "0x20",
>          "Unit": "QPI LL"
>      },
> @@ -56,7 +56,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.; The spawn failed because there were not enough Egres=
s credits AND the RBT bit was not set, but the RBT tag matched.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.; The spawn failed because there were not enough Egre=
ss credits AND the RBT bit was not set, but the RBT tag matched.",
>          "UMask": "0x8",
>          "Unit": "QPI LL"
>      },
> @@ -65,7 +65,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT_MISS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.; The spawn failed because the RBT tag did not match, =
the valid bit was not set and there weren't enough Egress credits.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.; The spawn failed because the RBT tag did not match,=
 the valid bit was not set and there weren't enough Egress credits.",
>          "UMask": "0x80",
>          "Unit": "QPI LL"
>      },
> @@ -74,7 +74,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.FAILURE_MISS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.; The spawn failed because the RBT tag did not match a=
lthough the valid bit was set and there were enough Egress credits.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.; The spawn failed because the RBT tag did not match =
although the valid bit was set and there were enough Egress credits.",
>          "UMask": "0x10",
>          "Unit": "QPI LL"
>      },
> @@ -83,7 +83,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_HIT",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.; The spawn failed because the route-back table (RBT) =
specified that the transaction should not trigger a direct2core tranaction.=
  This is common for IO transactions.  There were enough Egress credits and=
 the RBT tag matched but the valid bit was not set.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.; The spawn failed because the route-back table (RBT)=
 specified that the transaction should not trigger a direct2core tranaction=
.  This is common for IO transactions.  There were enough Egress credits an=
d the RBT tag matched but the valid bit was not set.",
>          "UMask": "0x4",
>          "Unit": "QPI LL"
>      },
> @@ -92,7 +92,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_MISS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.; The spawn failed because the RBT tag did not match a=
nd the valid bit was not set although there were enough Egress credits.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.; The spawn failed because the RBT tag did not match =
and the valid bit was not set although there were enough Egress credits.",
>          "UMask": "0x40",
>          "Unit": "QPI LL"
>      },
> @@ -101,7 +101,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.SUCCESS_RBT_HIT",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.; The spawn was successful.  There were sufficient cre=
dits, the RBT valid bit was set and there was an RBT tag match.  The messag=
e was marked to spawn direct2core.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.; The spawn was successful.  There were sufficient cr=
edits, the RBT valid bit was set and there was an RBT tag match.  The messa=
ge was marked to spawn direct2core.",
>          "UMask": "0x1",
>          "Unit": "QPI LL"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json =
b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> index e682eedf644a..4922cfca329e 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> @@ -427,7 +427,7 @@
>          "EventCode": "0x9",
>          "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles that we are in=
 Interal PROCHOT mode.  This mode is triggered when a sensor on the die det=
ermines that we are too hot and must throttle to avoid damaging the chip.",
> +        "PublicDescription": "Counts the number of cycles that we are in=
 Internal PROCHOT mode.  This mode is triggered when a sensor on the die de=
termines that we are too hot and must throttle to avoid damaging the chip."=
,
>          "Unit": "PCU"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.jso=
n b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> index ef4767feb4e2..65db3e00c2e2 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
> @@ -44,7 +44,7 @@
>          "MetricName": "LLC_MISSES.PCIE_WRITE",
>          "PerPkg": "1",
>          "PortMask": "0x01",
> -        "PublicDescription": "Counts every write request of 4 bytes of d=
ata made by IIO Part0 to a unit onthe main die (generally memory). In the g=
eneral case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) t=
hat is plugged directly into one of the PCIe slots. Part0 could also refer =
to any device plugged into the first slot of a PCIe riser card or to a devi=
ce attached to the IIO unit which starts its use of the bus using lane 0 of=
 the 16 lanes supported by the bus.",
> +        "PublicDescription": "Counts every write request of 4 bytes of d=
ata made by IIO Part0 to a unit on the main die (generally memory). In the =
general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) =
that is plugged directly into one of the PCIe slots. Part0 could also refer=
 to any device plugged into the first slot of a PCIe riser card or to a dev=
ice attached to the IIO unit which starts its use of the bus using lane 0 o=
f the 16 lanes supported by the bus.",
>          "ScaleUnit": "4Bytes",
>          "UMask": "0x1",
>          "Unit": "IIO"
> @@ -11637,7 +11637,7 @@
>          "FCMask": "0x07",
>          "PerPkg": "1",
>          "PortMask": "0x01",
> -        "PublicDescription": "Counts every write request of 4 bytes of d=
ata made by IIO Part0 to a unit onthe main die (generally memory). In the g=
eneral case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) t=
hat is plugged directly into one of the PCIe slots. Part0 could also refer =
to any device plugged into the first slot of a PCIe riser card or to a devi=
ce attached to the IIO unit which starts its use of the bus using lane 0 of=
 the 16 lanes supported by the bus.",
> +        "PublicDescription": "Counts every write request of 4 bytes of d=
ata made by IIO Part0 to a unit on the main die (generally memory). In the =
general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) =
that is plugged directly into one of the PCIe slots. Part0 could also refer=
 to any device plugged into the first slot of a PCIe riser card or to a dev=
ice attached to the IIO unit which starts its use of the bus using lane 0 o=
f the 16 lanes supported by the bus.",
>          "UMask": "0x1",
>          "Unit": "IIO"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.jso=
n b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> index 6835e14cd42c..8e21dc3eff16 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> @@ -175,7 +175,7 @@
>          "EventCode": "0x9",
>          "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles that we are in=
 Interal PROCHOT mode.  This mode is triggered when a sensor on the die det=
ermines that we are too hot and must throttle to avoid damaging the chip.",
> +        "PublicDescription": "Counts the number of cycles that we are in=
 Internal PROCHOT mode.  This mode is triggered when a sensor on the die de=
termines that we are too hot and must throttle to avoid damaging the chip."=
,
>          "Unit": "PCU"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/jaketown/pipeline.json
> index 11d41ce8c922..85c04fe7632a 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> @@ -501,7 +501,7 @@
>          "BriefDescription": "Cases when loads get true Block-on-Store bl=
ocking code preventing store forwarding.",
>          "EventCode": "0x03",
>          "EventName": "LD_BLOCKS.STORE_FORWARD",
> -        "PublicDescription": "This event counts loads that followed a st=
ore to the same address, where the data could not be forwarded inside the p=
ipeline from the store to the load.  The most common reason why store forwa=
rding would be blocked is when a load's address range overlaps with a prece=
eding smaller uncompleted store.  See the table of not supported store forw=
ards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual=
.  The penalty for blocked store forwarding is that the load must wait for =
the store to complete before it can be issued.",
> +        "PublicDescription": "This event counts loads that followed a st=
ore to the same address, where the data could not be forwarded inside the p=
ipeline from the store to the load.  The most common reason why store forwa=
rding would be blocked is when a load's address range overlaps with a prece=
ding smaller uncompleted store.  See the table of not supported store forwa=
rds in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.=
  The penalty for blocked store forwarding is that the load must wait for t=
he store to complete before it can be issued.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x2"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
> index b9e68f9f33ea..47830ca5c682 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
> @@ -572,7 +572,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.EVICTION",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH'=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH=
' and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
>          "UMask": "0x4",
>          "Unit": "CBO"
>      },
> @@ -581,7 +581,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.MISS_ALL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH'=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH=
' and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
>          "UMask": "0xa",
>          "Unit": "CBO"
>      },
> @@ -590,7 +590,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH'=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH=
' and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
>          "UMask": "0x3",
>          "Unit": "CBO"
>      },
> @@ -599,7 +599,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH'=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH=
' and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
>          "UMask": "0x48",
>          "Unit": "CBO"
>      },
> @@ -608,7 +608,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH'=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH=
' and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
>          "UMask": "0x44",
>          "Unit": "CBO"
>      },
> @@ -617,7 +617,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH'=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH=
' and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
>          "UMask": "0x4a",
>          "Unit": "CBO"
>      },
> @@ -626,7 +626,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH'=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH=
' and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
>          "UMask": "0x43",
>          "Unit": "CBO"
>      },
> @@ -635,7 +635,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH'=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH=
' and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
>          "UMask": "0x41",
>          "Unit": "CBO"
>      },
> @@ -644,7 +644,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.NID_WB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH'=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH=
' and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
>          "UMask": "0x50",
>          "Unit": "CBO"
>      },
> @@ -653,7 +653,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.OPCODE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH'=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH=
' and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
>          "UMask": "0x1",
>          "Unit": "CBO"
>      },
> @@ -662,7 +662,7 @@
>          "EventCode": "0x35",
>          "EventName": "UNC_C_TOR_INSERTS.WB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH'=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
> +        "PublicDescription": "Counts the number of entries successfully =
inserted into the TOR that match  qualifications specified by the subevent.=
  There are a number of subevent 'filters' but only a subset of the subeven=
t combinations are valid.  Subevents that require an opcode or NID match re=
quire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for examp=
le, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH=
' and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
>          "UMask": "0x10",
>          "Unit": "CBO"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
> index 1c2cf94889a1..4a48bb22d556 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
> @@ -20,7 +20,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.",
>          "UMask": "0x2",
>          "Unit": "QPI LL"
>      },
> @@ -29,7 +29,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.",
>          "UMask": "0x8",
>          "Unit": "QPI LL"
>      },
> @@ -38,7 +38,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.",
>          "UMask": "0x4",
>          "Unit": "QPI LL"
>      },
> @@ -47,7 +47,7 @@
>          "EventCode": "0x13",
>          "EventName": "UNC_Q_DIRECT2CORE.SUCCESS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exlusive filters.  Fil=
ter [0] can be used to get successful spawns, while [1:3] provide the diffe=
rent failure cases.  Note that this does not count packets that are not can=
didates for Direct2Core.  The only candidates for Direct2Core are DRS packe=
ts destined for Cbos.",
> +        "PublicDescription": "Counts the number of DRS packets that we a=
ttempted to do direct2core on.  There are 4 mutually exclusive filters.  Fi=
lter [0] can be used to get successful spawns, while [1:3] provide the diff=
erent failure cases.  Note that this does not count packets that are not ca=
ndidates for Direct2Core.  The only candidates for Direct2Core are DRS pack=
ets destined for Cbos.",
>          "UMask": "0x1",
>          "Unit": "QPI LL"
>      },
> @@ -80,7 +80,7 @@
>          "EventCode": "0x9",
>          "EventName": "UNC_Q_RxL_BYPASSED",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times that an incomin=
g flit was able to bypass the flit buffer and pass directly across the BGF =
and into the Egress.  This is a latency optimization, and should generally =
be the common case.  If this value is less than the number of flits transfe=
red, it implies that there was queueing getting onto the ring, and thus the=
 transactions saw higher latency.",
> +        "PublicDescription": "Counts the number of times that an incomin=
g flit was able to bypass the flit buffer and pass directly across the BGF =
and into the Egress.  This is a latency optimization, and should generally =
be the common case.  If this value is less than the number of flits transfe=
rred, it implies that there was queueing getting onto the ring, and thus th=
e transactions saw higher latency.",
>          "Unit": "QPI LL"
>      },
>      {
> @@ -176,7 +176,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_Q_RxL_FLITS_G0.DATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each=
 'flit' is made up of 80 bits of information (in addition to some ECC data)=
.  In full-width (L0) mode, flits are made up of four 'fits', each of which=
 contains 20 bits of data (along with some additional ECC data).   In half-=
width (L0p) mode, the fits are only 10 bits, and therefore it takes twice a=
s many fits to transmit a flit.  When one talks about QPI 'speed' (for exam=
ple, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, th=
e system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One ca=
n calculate the bandwidth of the link by taking: flits*80b/time.  Note that=
 this is not the same as 'data' bandwidth.  For example, when we are transf=
ering a 64B cacheline across QPI, we will break it into 9 flits -- 1 with h=
eader information and 8 with 64 bits of actual 'data' and an additional 16 =
bits of other information.  To calculate 'data' bandwidth, one should there=
fore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each=
 'flit' is made up of 80 bits of information (in addition to some ECC data)=
.  In full-width (L0) mode, flits are made up of four 'fits', each of which=
 contains 20 bits of data (along with some additional ECC data).   In half-=
width (L0p) mode, the fits are only 10 bits, and therefore it takes twice a=
s many fits to transmit a flit.  When one talks about QPI 'speed' (for exam=
ple, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, th=
e system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One ca=
n calculate the bandwidth of the link by taking: flits*80b/time.  Note that=
 this is not the same as 'data' bandwidth.  For example, when we are transf=
erring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with =
header information and 8 with 64 bits of actual 'data' and an additional 16=
 bits of other information.  To calculate 'data' bandwidth, one should ther=
efore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
>          "UMask": "0x2",
>          "Unit": "QPI LL"
>      },
> @@ -185,7 +185,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_Q_RxL_FLITS_G0.IDLE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each=
 'flit' is made up of 80 bits of information (in addition to some ECC data)=
.  In full-width (L0) mode, flits are made up of four 'fits', each of which=
 contains 20 bits of data (along with some additional ECC data).   In half-=
width (L0p) mode, the fits are only 10 bits, and therefore it takes twice a=
s many fits to transmit a flit.  When one talks about QPI 'speed' (for exam=
ple, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, th=
e system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One ca=
n calculate the bandwidth of the link by taking: flits*80b/time.  Note that=
 this is not the same as 'data' bandwidth.  For example, when we are transf=
ering a 64B cacheline across QPI, we will break it into 9 flits -- 1 with h=
eader information and 8 with 64 bits of actual 'data' and an additional 16 =
bits of other information.  To calculate 'data' bandwidth, one should there=
fore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each=
 'flit' is made up of 80 bits of information (in addition to some ECC data)=
.  In full-width (L0) mode, flits are made up of four 'fits', each of which=
 contains 20 bits of data (along with some additional ECC data).   In half-=
width (L0p) mode, the fits are only 10 bits, and therefore it takes twice a=
s many fits to transmit a flit.  When one talks about QPI 'speed' (for exam=
ple, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, th=
e system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One ca=
n calculate the bandwidth of the link by taking: flits*80b/time.  Note that=
 this is not the same as 'data' bandwidth.  For example, when we are transf=
erring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with =
header information and 8 with 64 bits of actual 'data' and an additional 16=
 bits of other information.  To calculate 'data' bandwidth, one should ther=
efore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
>          "UMask": "0x1",
>          "Unit": "QPI LL"
>      },
> @@ -194,7 +194,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_Q_RxL_FLITS_G0.NON_DATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each=
 'flit' is made up of 80 bits of information (in addition to some ECC data)=
.  In full-width (L0) mode, flits are made up of four 'fits', each of which=
 contains 20 bits of data (along with some additional ECC data).   In half-=
width (L0p) mode, the fits are only 10 bits, and therefore it takes twice a=
s many fits to transmit a flit.  When one talks about QPI 'speed' (for exam=
ple, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, th=
e system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One ca=
n calculate the bandwidth of the link by taking: flits*80b/time.  Note that=
 this is not the same as 'data' bandwidth.  For example, when we are transf=
ering a 64B cacheline across QPI, we will break it into 9 flits -- 1 with h=
eader information and 8 with 64 bits of actual 'data' and an additional 16 =
bits of other information.  To calculate 'data' bandwidth, one should there=
fore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each=
 'flit' is made up of 80 bits of information (in addition to some ECC data)=
.  In full-width (L0) mode, flits are made up of four 'fits', each of which=
 contains 20 bits of data (along with some additional ECC data).   In half-=
width (L0p) mode, the fits are only 10 bits, and therefore it takes twice a=
s many fits to transmit a flit.  When one talks about QPI 'speed' (for exam=
ple, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, th=
e system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One ca=
n calculate the bandwidth of the link by taking: flits*80b/time.  Note that=
 this is not the same as 'data' bandwidth.  For example, when we are transf=
erring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with =
header information and 8 with 64 bits of actual 'data' and an additional 16=
 bits of other information.  To calculate 'data' bandwidth, one should ther=
efore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
>          "UMask": "0x4",
>          "Unit": "QPI LL"
>      },
> @@ -203,7 +203,7 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_Q_RxL_FLITS_G1.DRS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x18",
>          "Unit": "QPI LL"
>      },
> @@ -212,7 +212,7 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x8",
>          "Unit": "QPI LL"
>      },
> @@ -221,7 +221,7 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_Q_RxL_FLITS_G1.DRS_NONDATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x10",
>          "Unit": "QPI LL"
>      },
> @@ -230,7 +230,7 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x6",
>          "Unit": "QPI LL"
>      },
> @@ -239,7 +239,7 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_Q_RxL_FLITS_G1.HOM_NONREQ",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x4",
>          "Unit": "QPI LL"
>      },
> @@ -248,7 +248,7 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x2",
>          "Unit": "QPI LL"
>      },
> @@ -257,7 +257,7 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x1",
>          "Unit": "QPI LL"
>      },
> @@ -266,7 +266,7 @@
>          "EventCode": "0x3",
>          "EventName": "UNC_Q_RxL_FLITS_G2.NCB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0xc",
>          "Unit": "QPI LL"
>      },
> @@ -275,7 +275,7 @@
>          "EventCode": "0x3",
>          "EventName": "UNC_Q_RxL_FLITS_G2.NCB_DATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x4",
>          "Unit": "QPI LL"
>      },
> @@ -284,7 +284,7 @@
>          "EventCode": "0x3",
>          "EventName": "UNC_Q_RxL_FLITS_G2.NCB_NONDATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x8",
>          "Unit": "QPI LL"
>      },
> @@ -293,7 +293,7 @@
>          "EventCode": "0x3",
>          "EventName": "UNC_Q_RxL_FLITS_G2.NCS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x10",
>          "Unit": "QPI LL"
>      },
> @@ -302,7 +302,7 @@
>          "EventCode": "0x3",
>          "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AD",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x1",
>          "Unit": "QPI LL"
>      },
> @@ -311,7 +311,7 @@
>          "EventCode": "0x3",
>          "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AK",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual 'data' and an additional 16 bits of oth=
er information.  To calculate 'data' bandwidth, one should therefore do: da=
ta flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits received from t=
he QPI Link.  This is one of three 'groups' that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is =
made up of 80 bits of information (in addition to some ECC data).  In full-=
width (L0) mode, flits are made up of four 'fits', each of which contains 2=
0 bits of data (along with some additional ECC data).   In half-width (L0p)=
 mode, the fits are only 10 bits, and therefore it takes twice as many fits=
 to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT=
/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system wi=
ll transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate=
 the bandwidth of the link by taking: flits*80b/time.  Note that this is no=
t the same as 'data' bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual 'data' and an additional 16 bits of ot=
her information.  To calculate 'data' bandwidth, one should therefore do: d=
ata flits * 8B / time.",
>          "UMask": "0x2",
>          "Unit": "QPI LL"
>      },
> @@ -553,7 +553,7 @@
>          "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits"=
,
>          "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each 'flit' is made up of 80 bits of information (in addition to some ECC =
data).  In full-width (L0) mode, flits are made up of four 'fits', each of =
which contains 20 bits of data (along with some additional ECC data).   In =
half-width (L0p) mode, the fits are only 10 bits, and therefore it takes tw=
ice as many fits to transmit a flit.  When one talks about QPI 'speed' (for=
 example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L=
0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  O=
ne can calculate the bandwidth of the link by taking: flits*80b/time.  Note=
 that this is not the same as 'data' bandwidth.  For example, when we are t=
ransfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 w=
ith header information and 8 with 64 bits of actual 'data' and an additiona=
l 16 bits of other information.  To calculate 'data' bandwidth, one should =
therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p."=
,
> +        "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each 'flit' is made up of 80 bits of information (in addition to some ECC =
data).  In full-width (L0) mode, flits are made up of four 'fits', each of =
which contains 20 bits of data (along with some additional ECC data).   In =
half-width (L0p) mode, the fits are only 10 bits, and therefore it takes tw=
ice as many fits to transmit a flit.  When one talks about QPI 'speed' (for=
 example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L=
0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  O=
ne can calculate the bandwidth of the link by taking: flits*80b/time.  Note=
 that this is not the same as 'data' bandwidth.  For example, when we are t=
ransferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 =
with header information and 8 with 64 bits of actual 'data' and an addition=
al 16 bits of other information.  To calculate 'data' bandwidth, one should=
 therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.=
",
>          "UMask": "0x2",
>          "Unit": "QPI LL"
>      },
> @@ -561,7 +561,7 @@
>          "BriefDescription": "Flits Transferred - Group 0; Idle and Null =
Flits",
>          "EventName": "UNC_Q_TxL_FLITS_G0.IDLE",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each 'flit' is made up of 80 bits of information (in addition to some ECC =
data).  In full-width (L0) mode, flits are made up of four 'fits', each of =
which contains 20 bits of data (along with some additional ECC data).   In =
half-width (L0p) mode, the fits are only 10 bits, and therefore it takes tw=
ice as many fits to transmit a flit.  When one talks about QPI 'speed' (for=
 example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L=
0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  O=
ne can calculate the bandwidth of the link by taking: flits*80b/time.  Note=
 that this is not the same as 'data' bandwidth.  For example, when we are t=
ransfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 w=
ith header information and 8 with 64 bits of actual 'data' and an additiona=
l 16 bits of other information.  To calculate 'data' bandwidth, one should =
therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p."=
,
> +        "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each 'flit' is made up of 80 bits of information (in addition to some ECC =
data).  In full-width (L0) mode, flits are made up of four 'fits', each of =
which contains 20 bits of data (along with some additional ECC data).   In =
half-width (L0p) mode, the fits are only 10 bits, and therefore it takes tw=
ice as many fits to transmit a flit.  When one talks about QPI 'speed' (for=
 example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L=
0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  O=
ne can calculate the bandwidth of the link by taking: flits*80b/time.  Note=
 that this is not the same as 'data' bandwidth.  For example, when we are t=
ransferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 =
with header information and 8 with 64 bits of actual 'data' and an addition=
al 16 bits of other information.  To calculate 'data' bandwidth, one should=
 therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.=
",
>          "UMask": "0x1",
>          "Unit": "QPI LL"
>      },
> @@ -569,7 +569,7 @@
>          "BriefDescription": "Flits Transferred - Group 0; Non-Data proto=
col Tx Flits",
>          "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each 'flit' is made up of 80 bits of information (in addition to some ECC =
data).  In full-width (L0) mode, flits are made up of four 'fits', each of =
which contains 20 bits of data (along with some additional ECC data).   In =
half-width (L0p) mode, the fits are only 10 bits, and therefore it takes tw=
ice as many fits to transmit a flit.  When one talks about QPI 'speed' (for=
 example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L=
0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  O=
ne can calculate the bandwidth of the link by taking: flits*80b/time.  Note=
 that this is not the same as 'data' bandwidth.  For example, when we are t=
ransfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 w=
ith header information and 8 with 64 bits of actual 'data' and an additiona=
l 16 bits of other information.  To calculate 'data' bandwidth, one should =
therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p."=
,
> +        "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each 'flit' is made up of 80 bits of information (in addition to some ECC =
data).  In full-width (L0) mode, flits are made up of four 'fits', each of =
which contains 20 bits of data (along with some additional ECC data).   In =
half-width (L0p) mode, the fits are only 10 bits, and therefore it takes tw=
ice as many fits to transmit a flit.  When one talks about QPI 'speed' (for=
 example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L=
0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  O=
ne can calculate the bandwidth of the link by taking: flits*80b/time.  Note=
 that this is not the same as 'data' bandwidth.  For example, when we are t=
ransferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 =
with header information and 8 with 64 bits of actual 'data' and an addition=
al 16 bits of other information.  To calculate 'data' bandwidth, one should=
 therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.=
",
>          "UMask": "0x4",
>          "Unit": "QPI LL"
>      },
> @@ -577,7 +577,7 @@
>          "BriefDescription": "Flits Transferred - Group 1; DRS Flits (bot=
h Header and Data)",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x18",
>          "Unit": "QPI LL"
>      },
> @@ -585,7 +585,7 @@
>          "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits=
",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x8",
>          "Unit": "QPI LL"
>      },
> @@ -593,7 +593,7 @@
>          "BriefDescription": "Flits Transferred - Group 1; DRS Header Fli=
ts",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x10",
>          "Unit": "QPI LL"
>      },
> @@ -601,7 +601,7 @@
>          "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x6",
>          "Unit": "QPI LL"
>      },
> @@ -609,7 +609,7 @@
>          "BriefDescription": "Flits Transferred - Group 1; HOM Non-Reques=
t Flits",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x4",
>          "Unit": "QPI LL"
>      },
> @@ -617,7 +617,7 @@
>          "BriefDescription": "Flits Transferred - Group 1; HOM Request Fl=
its",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x2",
>          "Unit": "QPI LL"
>      },
> @@ -625,7 +625,7 @@
>          "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
>          "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x1",
>          "Unit": "QPI LL"
>      },
> @@ -634,7 +634,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_Q_TxL_FLITS_G2.NCB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0xc",
>          "Unit": "QPI LL"
>      },
> @@ -643,7 +643,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_Q_TxL_FLITS_G2.NCB_DATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x4",
>          "Unit": "QPI LL"
>      },
> @@ -652,7 +652,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_Q_TxL_FLITS_G2.NCB_NONDATA",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x8",
>          "Unit": "QPI LL"
>      },
> @@ -661,7 +661,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_Q_TxL_FLITS_G2.NCS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x10",
>          "Unit": "QPI LL"
>      },
> @@ -670,7 +670,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AD",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x1",
>          "Unit": "QPI LL"
>      },
> @@ -679,7 +679,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AK",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transfering a=
 64B cacheline across QPI, we will break it into 9 flits -- 1 with header i=
nformation and 8 with 64 bits of actual 'data' and an additional 16 bits of=
 other information.  To calculate 'data' bandwidth, one should therefore do=
: data flits * 8B / time.",
> +        "PublicDescription": "Counts the number of flits trasmitted acro=
ss the QPI Link.  This is one of three 'groups' that allow us to track flit=
s.  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit'=
 is made up of 80 bits of information (in addition to some ECC data).  In f=
ull-width (L0) mode, flits are made up of four 'fits', each of which contai=
ns 20 bits of data (along with some additional ECC data).   In half-width (=
L0p) mode, the fits are only 10 bits, and therefore it takes twice as many =
fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8.=
0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syste=
m will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as 'data' bandwidth.  For example, when we are transferring =
a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header =
information and 8 with 64 bits of actual 'data' and an additional 16 bits o=
f other information.  To calculate 'data' bandwidth, one should therefore d=
o: data flits * 8B / time.",
>          "UMask": "0x2",
>          "Unit": "QPI LL"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json b/=
tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
> index 51a9a4e81046..1e472ac82285 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
> @@ -630,7 +630,7 @@
>          "EventCode": "0x20",
>          "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.DRS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the NCS/NCB/DRS=
 credit is acquried in the QPI for sending messages on BL to the IIO.  Ther=
e is one credit for each of these three message classes (three credits tota=
l).  NCS is used for reads to PCIe space, NCB is used for transfering data =
without coherency, and DRS is used for transfering data with coherency (cac=
hable PCI transactions).  This event can only track one message class at a =
time.",
> +        "PublicDescription": "Counts the number of times the NCS/NCB/DRS=
 credit is acquried in the QPI for sending messages on BL to the IIO.  Ther=
e is one credit for each of these three message classes (three credits tota=
l).  NCS is used for reads to PCIe space, NCB is used for transferring data=
 without coherency, and DRS is used for transferring data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
>          "UMask": "0x8",
>          "Unit": "R3QPI"
>      },
> @@ -639,7 +639,7 @@
>          "EventCode": "0x20",
>          "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the NCS/NCB/DRS=
 credit is acquried in the QPI for sending messages on BL to the IIO.  Ther=
e is one credit for each of these three message classes (three credits tota=
l).  NCS is used for reads to PCIe space, NCB is used for transfering data =
without coherency, and DRS is used for transfering data with coherency (cac=
hable PCI transactions).  This event can only track one message class at a =
time.",
> +        "PublicDescription": "Counts the number of times the NCS/NCB/DRS=
 credit is acquried in the QPI for sending messages on BL to the IIO.  Ther=
e is one credit for each of these three message classes (three credits tota=
l).  NCS is used for reads to PCIe space, NCB is used for transferring data=
 without coherency, and DRS is used for transferring data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
>          "UMask": "0x10",
>          "Unit": "R3QPI"
>      },
> @@ -648,7 +648,7 @@
>          "EventCode": "0x20",
>          "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the NCS/NCB/DRS=
 credit is acquried in the QPI for sending messages on BL to the IIO.  Ther=
e is one credit for each of these three message classes (three credits tota=
l).  NCS is used for reads to PCIe space, NCB is used for transfering data =
without coherency, and DRS is used for transfering data with coherency (cac=
hable PCI transactions).  This event can only track one message class at a =
time.",
> +        "PublicDescription": "Counts the number of times the NCS/NCB/DRS=
 credit is acquried in the QPI for sending messages on BL to the IIO.  Ther=
e is one credit for each of these three message classes (three credits tota=
l).  NCS is used for reads to PCIe space, NCB is used for transferring data=
 without coherency, and DRS is used for transferring data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
>          "UMask": "0x20",
>          "Unit": "R3QPI"
>      },
> @@ -657,7 +657,7 @@
>          "EventCode": "0x21",
>          "EventName": "UNC_R3_IIO_CREDITS_REJECT.DRS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times that a request =
attempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages =
on BL to the IIO but was rejected because no credit was available.  There i=
s one credit for each of these three message classes (three credits total).=
  NCS is used for reads to PCIe space, NCB is used for transfering data wit=
hout coherency, and DRS is used for transfering data with coherency (cachab=
le PCI transactions).  This event can only track one message class at a tim=
e.",
> +        "PublicDescription": "Counts the number of times that a request =
attempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages =
on BL to the IIO but was rejected because no credit was available.  There i=
s one credit for each of these three message classes (three credits total).=
  NCS is used for reads to PCIe space, NCB is used for transferring data wi=
thout coherency, and DRS is used for transferring data with coherency (cach=
able PCI transactions).  This event can only track one message class at a t=
ime.",
>          "UMask": "0x8",
>          "Unit": "R3QPI"
>      },
> @@ -666,7 +666,7 @@
>          "EventCode": "0x21",
>          "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times that a request =
attempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages =
on BL to the IIO but was rejected because no credit was available.  There i=
s one credit for each of these three message classes (three credits total).=
  NCS is used for reads to PCIe space, NCB is used for transfering data wit=
hout coherency, and DRS is used for transfering data with coherency (cachab=
le PCI transactions).  This event can only track one message class at a tim=
e.",
> +        "PublicDescription": "Counts the number of times that a request =
attempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages =
on BL to the IIO but was rejected because no credit was available.  There i=
s one credit for each of these three message classes (three credits total).=
  NCS is used for reads to PCIe space, NCB is used for transferring data wi=
thout coherency, and DRS is used for transferring data with coherency (cach=
able PCI transactions).  This event can only track one message class at a t=
ime.",
>          "UMask": "0x10",
>          "Unit": "R3QPI"
>      },
> @@ -675,7 +675,7 @@
>          "EventCode": "0x21",
>          "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times that a request =
attempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages =
on BL to the IIO but was rejected because no credit was available.  There i=
s one credit for each of these three message classes (three credits total).=
  NCS is used for reads to PCIe space, NCB is used for transfering data wit=
hout coherency, and DRS is used for transfering data with coherency (cachab=
le PCI transactions).  This event can only track one message class at a tim=
e.",
> +        "PublicDescription": "Counts the number of times that a request =
attempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages =
on BL to the IIO but was rejected because no credit was available.  There i=
s one credit for each of these three message classes (three credits total).=
  NCS is used for reads to PCIe space, NCB is used for transferring data wi=
thout coherency, and DRS is used for transferring data with coherency (cach=
able PCI transactions).  This event can only track one message class at a t=
ime.",
>          "UMask": "0x20",
>          "Unit": "R3QPI"
>      },
> @@ -684,7 +684,7 @@
>          "EventCode": "0x22",
>          "EventName": "UNC_R3_IIO_CREDITS_USED.DRS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the NCS/N=
CB/DRS credit is in use in the QPI for sending messages on BL to the IIO.  =
There is one credit for each of these three message classes (three credits =
total).  NCS is used for reads to PCIe space, NCB is used for transfering d=
ata without coherency, and DRS is used for transfering data with coherency =
(cachable PCI transactions).  This event can only track one message class a=
t a time.",
> +        "PublicDescription": "Counts the number of cycles when the NCS/N=
CB/DRS credit is in use in the QPI for sending messages on BL to the IIO.  =
There is one credit for each of these three message classes (three credits =
total).  NCS is used for reads to PCIe space, NCB is used for transferring =
data without coherency, and DRS is used for transferring data with coherenc=
y (cachable PCI transactions).  This event can only track one message class=
 at a time.",
>          "UMask": "0x8",
>          "Unit": "R3QPI"
>      },
> @@ -693,7 +693,7 @@
>          "EventCode": "0x22",
>          "EventName": "UNC_R3_IIO_CREDITS_USED.NCB",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the NCS/N=
CB/DRS credit is in use in the QPI for sending messages on BL to the IIO.  =
There is one credit for each of these three message classes (three credits =
total).  NCS is used for reads to PCIe space, NCB is used for transfering d=
ata without coherency, and DRS is used for transfering data with coherency =
(cachable PCI transactions).  This event can only track one message class a=
t a time.",
> +        "PublicDescription": "Counts the number of cycles when the NCS/N=
CB/DRS credit is in use in the QPI for sending messages on BL to the IIO.  =
There is one credit for each of these three message classes (three credits =
total).  NCS is used for reads to PCIe space, NCB is used for transferring =
data without coherency, and DRS is used for transferring data with coherenc=
y (cachable PCI transactions).  This event can only track one message class=
 at a time.",
>          "UMask": "0x10",
>          "Unit": "R3QPI"
>      },
> @@ -702,7 +702,7 @@
>          "EventCode": "0x22",
>          "EventName": "UNC_R3_IIO_CREDITS_USED.NCS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the NCS/N=
CB/DRS credit is in use in the QPI for sending messages on BL to the IIO.  =
There is one credit for each of these three message classes (three credits =
total).  NCS is used for reads to PCIe space, NCB is used for transfering d=
ata without coherency, and DRS is used for transfering data with coherency =
(cachable PCI transactions).  This event can only track one message class a=
t a time.",
> +        "PublicDescription": "Counts the number of cycles when the NCS/N=
CB/DRS credit is in use in the QPI for sending messages on BL to the IIO.  =
There is one credit for each of these three message classes (three credits =
total).  NCS is used for reads to PCIe space, NCB is used for transferring =
data without coherency, and DRS is used for transferring data with coherenc=
y (cachable PCI transactions).  This event can only track one message class=
 at a time.",
>          "UMask": "0x20",
>          "Unit": "R3QPI"
>      },
> @@ -1107,7 +1107,7 @@
>          "EventCode": "0x33",
>          "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED",
>          "PerPkg": "1",
> -        "PublicDescription": "Number of QPI VNA Credit acquisitions.  Th=
is event can be used in conjunction with the VNA In-Use Accumulator to calc=
ulate the average lifetime of a credit holder.  VNA credits are used by all=
 message classes in order to communicate across QPI.  If a packet is unable=
 to acquire credits, it will then attempt to use credts from the VN0 pool. =
 Note that a single packet may require multiple flit buffers (i.e. when dat=
a is being transfered).  Therefore, this event will increment by the number=
 of credits acquired in each cycle.  Filtering based on message class is no=
t provided.  One can count the number of packets transfered in a given mess=
age class using an qfclk event.",
> +        "PublicDescription": "Number of QPI VNA Credit acquisitions.  Th=
is event can be used in conjunction with the VNA In-Use Accumulator to calc=
ulate the average lifetime of a credit holder.  VNA credits are used by all=
 message classes in order to communicate across QPI.  If a packet is unable=
 to acquire credits, it will then attempt to use credts from the VN0 pool. =
 Note that a single packet may require multiple flit buffers (i.e. when dat=
a is being transferred).  Therefore, this event will increment by the numbe=
r of credits acquired in each cycle.  Filtering based on message class is n=
ot provided.  One can count the number of packets transferred in a given me=
ssage class using an qfclk event.",
>          "Unit": "R3QPI"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> index 638aa8a35cdb..a00f53978c3e 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> @@ -266,7 +266,7 @@
>          "EventCode": "0x9",
>          "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles that we are in=
 Interal PROCHOT mode.  This mode is triggered when a sensor on the die det=
ermines that we are too hot and must throttle to avoid damaging the chip.",
> +        "PublicDescription": "Counts the number of cycles that we are in=
 Internal PROCHOT mode.  This mode is triggered when a sensor on the die de=
termines that we are too hot and must throttle to avoid damaging the chip."=
,
>          "Unit": "PCU"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/t=
ools/perf/pmu-events/arch/x86/knightslanding/cache.json
> index 01aea3d2832e..4568520e6d95 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
> @@ -6,7 +6,7 @@
>          "SampleAfterValue": "200003"
>      },
>      {
> -        "BriefDescription": "Counts the number of core cycles the fetch =
stalls because of an icache miss. This is a cummulative count of core cycle=
s the fetch stalled for all icache misses.",
> +        "BriefDescription": "Counts the number of core cycles the fetch =
stalls because of an icache miss. This is a cumulative count of core cycles=
 the fetch stalled for all icache misses.",
>          "EventCode": "0x86",
>          "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
>          "PublicDescription": "This event counts the number of core cycle=
s the fetch stalls because of an icache miss. This is a cumulative count of=
 cycles the NIP stalled for all icache misses.",
> @@ -108,7 +108,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Demand code reads and prefetch code =
read requests  that accounts for reponses from snoop request hit with data =
forwarded from it Far(not in the same quadrant as the request)-other tile L=
2 in E/F/M state. Valid only in SNC4 Cluster mode.",
> +        "BriefDescription": "Counts Demand code reads and prefetch code =
read requests  that accounts for responses from snoop request hit with data=
 forwarded from it Far(not in the same quadrant as the request)-other tile =
L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -135,7 +135,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Demand code reads and prefetch code =
read requests  that accounts for reponses from snoop request hit with data =
forwarded from its Near-other tile L2 in E/F/M state",
> +        "BriefDescription": "Counts Demand code reads and prefetch code =
read requests  that accounts for responses from snoop request hit with data=
 forwarded from its Near-other tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -216,7 +216,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Demand cacheable data and L1 prefetc=
h data read requests  that accounts for reponses from snoop request hit wit=
h data forwarded from it Far(not in the same quadrant as the request)-other=
 tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
> +        "BriefDescription": "Counts Demand cacheable data and L1 prefetc=
h data read requests  that accounts for responses from snoop request hit wi=
th data forwarded from it Far(not in the same quadrant as the request)-othe=
r tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -243,7 +243,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Demand cacheable data and L1 prefetc=
h data read requests  that accounts for reponses from snoop request hit wit=
h data forwarded from its Near-other tile L2 in E/F/M state",
> +        "BriefDescription": "Counts Demand cacheable data and L1 prefetc=
h data read requests  that accounts for responses from snoop request hit wi=
th data forwarded from its Near-other tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -324,7 +324,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts any Prefetch requests that accounts =
for reponses from snoop request hit with data forwarded from it Far(not in =
the same quadrant as the request)-other tile L2 in E/F/M state. Valid only =
in SNC4 Cluster mode.",
> +        "BriefDescription": "Counts any Prefetch requests that accounts =
for responses from snoop request hit with data forwarded from it Far(not in=
 the same quadrant as the request)-other tile L2 in E/F/M state. Valid only=
 in SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -351,7 +351,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts any Prefetch requests that accounts =
for reponses from snoop request hit with data forwarded from its Near-other=
 tile L2 in E/F/M state",
> +        "BriefDescription": "Counts any Prefetch requests that accounts =
for responses from snoop request hit with data forwarded from its Near-othe=
r tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -423,7 +423,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts any Read request  that accounts for =
reponses from snoop request hit with data forwarded from it Far(not in the =
same quadrant as the request)-other tile L2 in E/F/M state. Valid only in S=
NC4 Cluster mode.",
> +        "BriefDescription": "Counts any Read request  that accounts for =
responses from snoop request hit with data forwarded from it Far(not in the=
 same quadrant as the request)-other tile L2 in E/F/M state. Valid only in =
SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -450,7 +450,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts any Read request  that accounts for =
reponses from snoop request hit with data forwarded from its Near-other til=
e L2 in E/F/M state",
> +        "BriefDescription": "Counts any Read request  that accounts for =
responses from snoop request hit with data forwarded from its Near-other ti=
le L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -531,7 +531,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts any request that accounts for repons=
es from snoop request hit with data forwarded from it Far(not in the same q=
uadrant as the request)-other tile L2 in E/F/M state. Valid only in SNC4 Cl=
uster mode.",
> +        "BriefDescription": "Counts any request that accounts for respon=
ses from snoop request hit with data forwarded from it Far(not in the same =
quadrant as the request)-other tile L2 in E/F/M state. Valid only in SNC4 C=
luster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -558,7 +558,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts any request that accounts for repons=
es from snoop request hit with data forwarded from its Near-other tile L2 i=
n E/F/M state",
> +        "BriefDescription": "Counts any request that accounts for respon=
ses from snoop request hit with data forwarded from its Near-other tile L2 =
in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -639,7 +639,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Demand cacheable data write requests=
  that accounts for reponses from snoop request hit with data forwarded fro=
m it Far(not in the same quadrant as the request)-other tile L2 in E/F/M st=
ate. Valid only in SNC4 Cluster mode.",
> +        "BriefDescription": "Counts Demand cacheable data write requests=
  that accounts for responses from snoop request hit with data forwarded fr=
om it Far(not in the same quadrant as the request)-other tile L2 in E/F/M s=
tate. Valid only in SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -666,7 +666,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Demand cacheable data write requests=
  that accounts for reponses from snoop request hit with data forwarded fro=
m its Near-other tile L2 in E/F/M state",
> +        "BriefDescription": "Counts Demand cacheable data write requests=
  that accounts for responses from snoop request hit with data forwarded fr=
om its Near-other tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -747,7 +747,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Bus locks and split lock requests th=
at accounts for reponses from snoop request hit with data forwarded from it=
 Far(not in the same quadrant as the request)-other tile L2 in E/F/M state.=
 Valid only in SNC4 Cluster mode.",
> +        "BriefDescription": "Counts Bus locks and split lock requests th=
at accounts for responses from snoop request hit with data forwarded from i=
t Far(not in the same quadrant as the request)-other tile L2 in E/F/M state=
. Valid only in SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -774,7 +774,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Bus locks and split lock requests th=
at accounts for reponses from snoop request hit with data forwarded from it=
s Near-other tile L2 in E/F/M state",
> +        "BriefDescription": "Counts Bus locks and split lock requests th=
at accounts for responses from snoop request hit with data forwarded from i=
ts Near-other tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -855,7 +855,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts demand code reads and prefetch code =
reads that accounts for reponses from snoop request hit with data forwarded=
 from it Far(not in the same quadrant as the request)-other tile L2 in E/F/=
M state. Valid only in SNC4 Cluster mode.",
> +        "BriefDescription": "Counts demand code reads and prefetch code =
reads that accounts for responses from snoop request hit with data forwarde=
d from it Far(not in the same quadrant as the request)-other tile L2 in E/F=
/M state. Valid only in SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -882,7 +882,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts demand code reads and prefetch code =
reads that accounts for reponses from snoop request hit with data forwarded=
 from its Near-other tile L2 in E/F/M state",
> +        "BriefDescription": "Counts demand code reads and prefetch code =
reads that accounts for responses from snoop request hit with data forwarde=
d from its Near-other tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1053,7 +1053,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Demand cacheable data writes that ac=
counts for reponses from snoop request hit with data forwarded from it Far(=
not in the same quadrant as the request)-other tile L2 in E/F/M state. Vali=
d only in SNC4 Cluster mode.",
> +        "BriefDescription": "Counts Demand cacheable data writes that ac=
counts for responses from snoop request hit with data forwarded from it Far=
(not in the same quadrant as the request)-other tile L2 in E/F/M state. Val=
id only in SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1080,7 +1080,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Demand cacheable data writes that ac=
counts for reponses from snoop request hit with data forwarded from its Nea=
r-other tile L2 in E/F/M state",
> +        "BriefDescription": "Counts Demand cacheable data writes that ac=
counts for responses from snoop request hit with data forwarded from its Ne=
ar-other tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1170,7 +1170,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Partial reads (UC or WC and is valid=
 only for Outstanding response type).  that accounts for reponses from snoo=
p request hit with data forwarded from it Far(not in the same quadrant as t=
he request)-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode."=
,
> +        "BriefDescription": "Counts Partial reads (UC or WC and is valid=
 only for Outstanding response type).  that accounts for responses from sno=
op request hit with data forwarded from it Far(not in the same quadrant as =
the request)-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.=
",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1197,7 +1197,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Partial reads (UC or WC and is valid=
 only for Outstanding response type).  that accounts for reponses from snoo=
p request hit with data forwarded from its Near-other tile L2 in E/F/M stat=
e",
> +        "BriefDescription": "Counts Partial reads (UC or WC and is valid=
 only for Outstanding response type).  that accounts for responses from sno=
op request hit with data forwarded from its Near-other tile L2 in E/F/M sta=
te",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1287,7 +1287,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Partial writes (UC or WT or WP and s=
hould be programmed on PMC1) that accounts for reponses from snoop request =
hit with data forwarded from it Far(not in the same quadrant as the request=
)-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
> +        "BriefDescription": "Counts Partial writes (UC or WT or WP and s=
hould be programmed on PMC1) that accounts for responses from snoop request=
 hit with data forwarded from it Far(not in the same quadrant as the reques=
t)-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a7",
> @@ -1314,7 +1314,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Partial writes (UC or WT or WP and s=
hould be programmed on PMC1) that accounts for reponses from snoop request =
hit with data forwarded from its Near-other tile L2 in E/F/M state",
> +        "BriefDescription": "Counts Partial writes (UC or WT or WP and s=
hould be programmed on PMC1) that accounts for responses from snoop request=
 hit with data forwarded from its Near-other tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a7",
> @@ -1386,7 +1386,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts L1 data HW prefetches that accounts =
for reponses from snoop request hit with data forwarded from it Far(not in =
the same quadrant as the request)-other tile L2 in E/F/M state. Valid only =
in SNC4 Cluster mode.",
> +        "BriefDescription": "Counts L1 data HW prefetches that accounts =
for responses from snoop request hit with data forwarded from it Far(not in=
 the same quadrant as the request)-other tile L2 in E/F/M state. Valid only=
 in SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1413,7 +1413,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts L1 data HW prefetches that accounts =
for reponses from snoop request hit with data forwarded from its Near-other=
 tile L2 in E/F/M state",
> +        "BriefDescription": "Counts L1 data HW prefetches that accounts =
for responses from snoop request hit with data forwarded from its Near-othe=
r tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1494,7 +1494,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts L2 code HW prefetches that accounts =
for reponses from snoop request hit with data forwarded from it Far(not in =
the same quadrant as the request)-other tile L2 in E/F/M state. Valid only =
in SNC4 Cluster mode.",
> +        "BriefDescription": "Counts L2 code HW prefetches that accounts =
for responses from snoop request hit with data forwarded from it Far(not in=
 the same quadrant as the request)-other tile L2 in E/F/M state. Valid only=
 in SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1521,7 +1521,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts L2 code HW prefetches that accounts =
for reponses from snoop request hit with data forwarded from its Near-other=
 tile L2 in E/F/M state",
> +        "BriefDescription": "Counts L2 code HW prefetches that accounts =
for responses from snoop request hit with data forwarded from its Near-othe=
r tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1602,7 +1602,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts L2 data RFO prefetches (includes PRE=
FETCHW instruction) that accounts for reponses from snoop request hit with =
data forwarded from its Near-other tile L2 in E/F/M state",
> +        "BriefDescription": "Counts L2 data RFO prefetches (includes PRE=
FETCHW instruction) that accounts for responses from snoop request hit with=
 data forwarded from its Near-other tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1683,7 +1683,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Software Prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from it Far(not in th=
e same quadrant as the request)-other tile L2 in E/F/M state. Valid only in=
 SNC4 Cluster mode.",
> +        "BriefDescription": "Counts Software Prefetches that accounts fo=
r responses from snoop request hit with data forwarded from it Far(not in t=
he same quadrant as the request)-other tile L2 in E/F/M state. Valid only i=
n SNC4 Cluster mode.",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1710,7 +1710,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts Software Prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from its Near-other t=
ile L2 in E/F/M state",
> +        "BriefDescription": "Counts Software Prefetches that accounts fo=
r responses from snoop request hit with data forwarded from its Near-other =
tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -1818,7 +1818,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts UC code reads (valid only for Outsta=
nding response type)  that accounts for reponses from snoop request hit wit=
h data forwarded from its Near-other tile L2 in E/F/M state",
> +        "BriefDescription": "Counts UC code reads (valid only for Outsta=
nding response type)  that accounts for responses from snoop request hit wi=
th data forwarded from its Near-other tile L2 in E/F/M state",
>          "EventCode": "0xB7",
>          "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE",
>          "MSRIndex": "0x1a6,0x1a7",
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json =
b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> index 1b803fa38641..3dc532107ead 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> @@ -254,14 +254,14 @@
>          "UMask": "0x80"
>      },
>      {
> -        "BriefDescription": "Counts the number of occurences a retired l=
oad gets blocked because its address overlaps with a store whose data is no=
t ready",
> +        "BriefDescription": "Counts the number of occurrences a retired =
load gets blocked because its address overlaps with a store whose data is n=
ot ready",
>          "EventCode": "0x03",
>          "EventName": "RECYCLEQ.LD_BLOCK_STD_NOTREADY",
>          "SampleAfterValue": "200003",
>          "UMask": "0x2"
>      },
>      {
> -        "BriefDescription": "Counts the number of occurences a retired l=
oad gets blocked because its address partially overlaps with a store",
> +        "BriefDescription": "Counts the number of occurrences a retired =
load gets blocked because its address partially overlaps with a store",
>          "Data_LA": "1",
>          "EventCode": "0x03",
>          "EventName": "RECYCLEQ.LD_BLOCK_ST_FORWARD",
> @@ -270,7 +270,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts the number of occurences a retired l=
oad that is a cache line split. Each split should be counted only once.",
> +        "BriefDescription": "Counts the number of occurrences a retired =
load that is a cache line split. Each split should be counted only once.",
>          "Data_LA": "1",
>          "EventCode": "0x03",
>          "EventName": "RECYCLEQ.LD_SPLITS",
> @@ -293,7 +293,7 @@
>          "UMask": "0x20"
>      },
>      {
> -        "BriefDescription": "Counts the number of occurences a retired s=
tore that is a cache line split. Each split should be counted only once.",
> +        "BriefDescription": "Counts the number of occurrences a retired =
store that is a cache line split. Each split should be counted only once.",
>          "EventCode": "0x03",
>          "EventName": "RECYCLEQ.ST_SPLITS",
>          "PublicDescription": "This event counts the number of retired st=
ore that experienced a cache line boundary split(Precise Event). Note that =
each spilt should be counted only once.",
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.j=
son b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
> index 3abd9c3fdc48..369a4a4ede74 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
> @@ -1843,7 +1843,7 @@
>          "Unit": "CHA"
>      },
>      {
> -        "BriefDescription": "Counts cycles source throttling is adderted=
 - horizontal",
> +        "BriefDescription": "Counts cycles source throttling is asserted=
 - horizontal",
>          "EventCode": "0xA5",
>          "EventName": "UNC_H_FAST_ASSERTED.HORZ",
>          "PerPkg": "1",
> @@ -1851,7 +1851,7 @@
>          "Unit": "CHA"
>      },
>      {
> -        "BriefDescription": "Counts cycles source throttling is adderted=
 - vertical",
> +        "BriefDescription": "Counts cycles source throttling is asserted=
 - vertical",
>          "EventCode": "0xA5",https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git/tree/scripts/spelling.txt
>          "EventName": "UNC_H_FAST_ASSERTED.VERT",
>          "PerPkg": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> index 53ab5993e8b0..54454e5e262c 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> @@ -509,7 +509,7 @@
>          "BriefDescription": "Cases when loads get true Block-on-Store bl=
ocking code preventing store forwarding.",
>          "EventCode": "0x03",
>          "EventName": "LD_BLOCKS.STORE_FORWARD",
> -        "PublicDescription": "This event counts loads that followed a st=
ore to the same address, where the data could not be forwarded inside the p=
ipeline from the store to the load.  The most common reason why store forwa=
rding would be blocked is when a load's address range overlaps with a prece=
eding smaller uncompleted store.  See the table of not supported store forw=
ards in the Intel(R) 64 and IA-32 Architectures Optimization Reference Manu=
al.  The penalty for blocked store forwarding is that the load must wait fo=
r the store to complete before it can be issued.",
> +        "PublicDescription": "This event counts loads that followed a st=
ore to the same address, where the data could not be forwarded inside the p=
ipeline from the store to the load.  The most common reason why store forwa=
rding would be blocked is when a load's address range overlaps with a prece=
ding smaller uncompleted store.  See the table of not supported store forwa=
rds in the Intel(R) 64 and IA-32 Architectures Optimization Reference Manua=
l.  The penalty for blocked store forwarding is that the load must wait for=
 the store to complete before it can be issued.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x2"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json b/to=
ols/perf/pmu-events/arch/x86/silvermont/frontend.json
> index c35da10f7133..cd6ed3f59e26 100644
> --- a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
> @@ -11,7 +11,7 @@
>          "BriefDescription": "Counts the number of JCC baclears",
>          "EventCode": "0xE6",
>          "EventName": "BACLEARS.COND",
> -        "PublicDescription": "The BACLEARS event counts the number of ti=
mes the front end is resteered, mainly when the Branch Prediction Unit cann=
ot provide a correct prediction and this is corrected by the Branch Address=
 Calculator at the front end.  The BACLEARS.COND event counts the number of=
 JCC (Jump on Condtional Code) baclears.",
> +        "PublicDescription": "The BACLEARS event counts the number of ti=
mes the front end is resteered, mainly when the Branch Prediction Unit cann=
ot provide a correct prediction and this is corrected by the Branch Address=
 Calculator at the front end.  The BACLEARS.COND event counts the number of=
 JCC (Jump on Conditional Code) baclears.",
>          "SampleAfterValue": "200003",
>          "UMask": "0x10"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.=
json b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
> index ef635bff1522..f75084309041 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
> @@ -56,7 +56,7 @@
>          "UMask": "0x80"
>      },
>      {
> -        "BriefDescription": "DTLB misses casued by low part of address",
> +        "BriefDescription": "DTLB misses caused by low part of address",
>          "EventCode": "0x49",
>          "EventName": "DTLB_MISSES.PDE_MISS",
>          "SampleAfterValue": "200000",
> diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
> index fd30460b6218..8ffdbe526d98 100644
> --- a/tools/perf/util/evswitch.h
> +++ b/tools/perf/util/evswitch.h
> @@ -22,9 +22,9 @@ bool evswitch__discard(struct evswitch *evswitch, struc=
t evsel *evsel);
>
>  #define OPTS_EVSWITCH(evswitch)                                         =
                         \
>         OPT_STRING(0, "switch-on", &(evswitch)->on_name,                 =
                 \
> -                  "event", "Consider events after the ocurrence of this =
event"),         \
> +                  "event", "Consider events after the occurrence of this=
 event"),        \
>         OPT_STRING(0, "switch-off", &(evswitch)->off_name,               =
                 \
> -                  "event", "Stop considering events after the ocurrence =
of this event"), \
> +                  "event", "Stop considering events after the occurrence=
 of this event"), \
>         OPT_BOOLEAN(0, "show-on-off-events", &(evswitch)->show_on_off_eve=
nts,             \
>                     "Show the on/off switch events, used with --switch-on=
 and --switch-off")

>
> --
> 2.39.0
>
