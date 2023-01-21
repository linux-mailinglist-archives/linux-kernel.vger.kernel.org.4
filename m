Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3156676815
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 19:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjAUSrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 13:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUSra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 13:47:30 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C082330B;
        Sat, 21 Jan 2023 10:47:24 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 41C3E40003;
        Sat, 21 Jan 2023 18:47:17 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH] tools/perf: Various spelling fixes
Date:   Sat, 21 Jan 2023 19:46:15 +0100
Message-Id: <20230121184648.38487-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix various spelling errors as reported by Debian's lintian tool.

"amount of times" -> "number of times"
Condtional -> Conditional
Instrcution -> Instruction
Interal -> Internal
adderted -> asserted
casued -> caused
cummulative -> cumulative
exlusive -> exclusive
occurance -> occurrence
occured -> occurred
occurences -> occurrences
ocurrence -> occurrence
onthe -> on the
preceeding -> preceding
reponses -> responses
satisifed -> satisfied
successfuly -> successfully
transfered -> transferred
transfering -> transferring
upto -> up to

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 tools/perf/Documentation/perf-bench.txt       |  2 +-
 tools/perf/builtin-bench.c                    |  2 +-
 tools/perf/builtin-script.c                   |  2 +-
 .../arch/x86/alderlake/adl-metrics.json       |  4 +-
 .../pmu-events/arch/x86/amdzen3/branch.json   |  2 +-
 .../pmu-events/arch/x86/amdzen4/pipeline.json |  2 +-
 .../arch/x86/broadwell/pipeline.json          |  2 +-
 .../arch/x86/broadwellde/pipeline.json        |  2 +-
 .../arch/x86/broadwellde/uncore-cache.json    | 48 ++++++------
 .../arch/x86/broadwellde/uncore-power.json    |  2 +-
 .../arch/x86/broadwellx/pipeline.json         |  2 +-
 .../arch/x86/broadwellx/uncore-cache.json     | 24 +++---
 .../x86/broadwellx/uncore-interconnect.json   | 16 ++--
 .../arch/x86/broadwellx/uncore-power.json     |  2 +-
 .../arch/x86/cascadelakex/uncore-other.json   |  4 +-
 .../arch/x86/cascadelakex/uncore-power.json   |  2 +-
 .../arch/x86/jaketown/pipeline.json           |  2 +-
 .../arch/x86/jaketown/uncore-cache.json       | 22 +++---
 .../x86/jaketown/uncore-interconnect.json     | 74 +++++++++----------
 .../arch/x86/jaketown/uncore-other.json       | 20 ++---
 .../arch/x86/jaketown/uncore-power.json       |  2 +-
 .../arch/x86/knightslanding/cache.json        | 62 ++++++++--------
 .../arch/x86/knightslanding/pipeline.json     |  8 +-
 .../arch/x86/knightslanding/uncore-other.json |  4 +-
 .../arch/x86/sandybridge/pipeline.json        |  2 +-
 .../arch/x86/silvermont/frontend.json         |  2 +-
 .../x86/westmereep-dp/virtual-memory.json     |  2 +-
 tools/perf/util/evswitch.h                    |  4 +-
 28 files changed, 161 insertions(+), 161 deletions(-)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documenta=
tion/perf-bench.txt
index a0529c7fa5ef..f04f0eaded98 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -18,7 +18,7 @@ COMMON OPTIONS
 --------------
 -r::
 --repeat=3D::
-Specify amount of times to repeat the run (default 10).
+Specify number of times to repeat the run (default 10).
=20
 -f::
 --format=3D::
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 334ab897aae3..bd4fd94a2ce0 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -150,7 +150,7 @@ unsigned int bench_repeat =3D 10; /* default number of =
times to repeat the run */
=20
 static const struct option bench_options[] =3D {
 	OPT_STRING('f', "format", &bench_format_str, "default|simple", "Specify t=
he output formatting style"),
-	OPT_UINTEGER('r', "repeat",  &bench_repeat,   "Specify amount of times to=
 repeat the run"),
+	OPT_UINTEGER('r', "repeat",  &bench_repeat,   "Specify number of times to=
 repeat the run"),
 	OPT_END()
 };
=20
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69394ac0a20d..8901acdd7f5b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1301,7 +1301,7 @@ static int perf_sample__fprintf_brstackinsn(struct pe=
rf_sample *sample,
 		goto out;
=20
 	/*
-	 * Print final block upto sample
+	 * Print final block up to sample
 	 *
 	 * Due to pipeline delays the LBRs might be missing a branch
 	 * or two, which can result in very large or negative blocks
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 2eb3d7464d9f..39e8b5e9bc29 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -1830,13 +1830,13 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricName": "IpBranch",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurance rate)",
+        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
         "MetricName": "IpCall",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/branch.json b/tools/per=
f/pmu-events/arch/x86/amdzen3/branch.json
index 018a7fe94fb9..a3b53845ca19 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen3/branch.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen3/branch.json
@@ -42,7 +42,7 @@
   {
     "EventName": "bp_l1_tlb_fetch_hit.if4k",
     "EventCode": "0x94",
-    "BriefDescription": "The number of instruction fetches that hit in the=
 L1 ITLB. L1 Instrcution TLB hit (4K or 16K page size).",
+    "BriefDescription": "The number of instruction fetches that hit in the=
 L1 ITLB. L1 Instruction TLB hit (4K or 16K page size).",
     "UMask": "0x01"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/amdzen4/pipeline.json
index 4ae8316c7507..b9d368005d4d 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
@@ -1,7 +1,7 @@
 [
   {
     "MetricName": "total_dispatch_slots",
-    "BriefDescription": "Total dispatch slots (upto 6 instructions can be =
dispatched in each cycle).",
+    "BriefDescription": "Total dispatch slots (up to 6 instructions can be=
 dispatched in each cycle).",
     "MetricExpr": "6 * ls_not_halted_cyc"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/tools=
/perf/pmu-events/arch/x86/broadwell/pipeline.json
index 2f0fe6b35334..56e467ecbccf 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
@@ -500,7 +500,7 @@
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "This event counts stalls occured due to chan=
ging prefix length (66, 67 or REX.W when they change the length of the deco=
ded instruction). Occurrences counting is proportional to the number of pre=
fixes in a 16B-line. This may result in the following penalties: three-cycl=
e penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occurred due to cha=
nging prefix length (66, 67 or REX.W when they change the length of the dec=
oded instruction). Occurrences counting is proportional to the number of pr=
efixes in a 16B-line. This may result in the following penalties: three-cyc=
le penalty for each LCP in a 16-byte chunk.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/broadwellde/pipeline.json
index 9e7d66b07f01..089dc5acee83 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
@@ -500,7 +500,7 @@
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "This event counts stalls occured due to chan=
ging prefix length (66, 67 or REX.W when they change the length of the deco=
ded instruction). Occurrences counting is proportional to the number of pre=
fixes in a 16B-line. This may result in the following penalties: three-cycl=
e penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occurred due to cha=
nging prefix length (66, 67 or REX.W when they change the length of the dec=
oded instruction). Occurrences counting is proportional to the number of pr=
efixes in a 16B-line. This may result in the following penalties: three-cyc=
le penalty for each LCP in a 16-byte chunk.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
index b8c9845308b2..906dd4fc4ecb 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
@@ -968,7 +968,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR.    This includes requests that reside in the TOR for a short=
 time, such as LLC Hits that do not need to snoop cores or requests that ge=
t rejected and have to be retried through one of the ingress queues.  The T=
OR is more commonly a bottleneck in skews with smaller core counts, where t=
he ratio of RTIDs to TOR entries is larger.  Note that there are reserved T=
OR entries for various request types, so it is possible that a given reques=
t type be blocked with an occupancy that is less than 20.  Also note that g=
enerally requests will not be able to arbitrate into the TOR pipeline if th=
ere are no available TOR slots.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR.    This includes requests that reside in the TOR for a shor=
t time, such as LLC Hits that do not need to snoop cores or requests that g=
et rejected and have to be retried through one of the ingress queues.  The =
TOR is more commonly a bottleneck in skews with smaller core counts, where =
the ratio of RTIDs to TOR entries is larger.  Note that there are reserved =
TOR entries for various request types, so it is possible that a given reque=
st type be blocked with an occupancy that is less than 20.  Also note that =
generally requests will not be able to arbitrate into the TOR pipeline if t=
here are no available TOR slots.",
         "UMask": "0x8",
         "Unit": "CBO"
     },
@@ -977,7 +977,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions ins=
erted into the TOR.  Evictions can be quick, such as when the line is in th=
e F, S, or E states and no core valid bits are set.  They can also be longe=
r if either CV bits are set (so the cores need to be snooped) and/or if the=
re is a HitM (in which case it is necessary to write the request out to mem=
ory).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions in=
serted into the TOR.  Evictions can be quick, such as when the line is in t=
he F, S, or E states and no core valid bits are set.  They can also be long=
er if either CV bits are set (so the cores need to be snooped) and/or if th=
ere is a HitM (in which case it is necessary to write the request out to me=
mory).",
         "UMask": "0x4",
         "Unit": "CBO"
     },
@@ -986,7 +986,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x28",
         "Unit": "CBO"
     },
@@ -995,7 +995,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by locally HOMed=
 memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
@@ -1004,7 +1004,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x2a",
         "Unit": "CBO"
     },
@@ -1013,7 +1013,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode, inserted into the TOR that are satisifed by locally HOMed=
 memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode, inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x23",
         "Unit": "CBO"
     },
@@ -1022,7 +1022,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match an opcode.",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -1031,7 +1031,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x8a",
         "Unit": "CBO"
     },
@@ -1040,7 +1040,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by remote cache=
s or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode,  inserted into the TOR that are satisfied by remote cach=
es or remote memory.",
         "UMask": "0x83",
         "Unit": "CBO"
     },
@@ -1049,7 +1049,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches =
an RTID destination) transactions inserted into the TOR.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it is=
 possible to monitor misses to specific NIDs in the system.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches=
 an RTID destination) transactions inserted into the TOR.  The NID is progr=
ammed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it i=
s possible to monitor misses to specific NIDs in the system.",
         "UMask": "0x48",
         "Unit": "CBO"
     },
@@ -1058,7 +1058,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tran=
sactions inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tra=
nsactions inserted into the TOR.",
         "UMask": "0x44",
         "Unit": "CBO"
     },
@@ -1067,7 +1067,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss requ=
ests that were inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss req=
uests that were inserted into the TOR.",
         "UMask": "0x4a",
         "Unit": "CBO"
     },
@@ -1076,7 +1076,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match a NID and an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that match a NID and an opcode.",
         "UMask": "0x43",
         "Unit": "CBO"
     },
@@ -1085,7 +1085,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match a NID and an opcode.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match a NID and an opcode.",
         "UMask": "0x41",
         "Unit": "CBO"
     },
@@ -1094,7 +1094,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transac=
tions inserted into the TOR.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transa=
ctions inserted into the TOR.",
         "UMask": "0x50",
         "Unit": "CBO"
     },
@@ -1103,7 +1103,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted in=
to the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -1112,7 +1112,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x88",
         "Unit": "CBO"
     },
@@ -1121,7 +1121,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by remote caches=
 or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by remote cache=
s or remote memory.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
@@ -1130,7 +1130,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions insert=
ed into the TOR.   This does not include RFO, but actual operations that co=
ntain data being sent from the core.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions inser=
ted into the TOR.   This does not include RFO, but actual operations that c=
ontain data being sent from the core.",
         "UMask": "0x10",
         "Unit": "CBO"
     },
@@ -1166,7 +1166,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by locally HOMed memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by locally HOMed memory.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
@@ -1193,7 +1193,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by locally HOMed memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by locally HOMed memory.",
         "UMask": "0x23",
         "Unit": "CBO"
     },
@@ -1220,7 +1220,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by remote caches or remote memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by remote caches or remote memory.",
         "UMask": "0x83",
         "Unit": "CBO"
     },
@@ -1301,7 +1301,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by remote caches or remote memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by remote caches or remote memory.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
@@ -1388,7 +1388,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
         "PerPkg": "1",
-        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transfering writeback data to the cache.",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transferring writeback data to the cache.",
         "UMask": "0x40",
         "Unit": "CBO"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
index 124b3fe2e0e1..9d3431b30158 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
@@ -427,7 +427,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that we are in I=
nteral PROCHOT mode.  This mode is triggered when a sensor on the die deter=
mines that we are too hot and must throttle to avoid damaging the chip.",
+        "PublicDescription": "Counts the number of cycles that we are in I=
nternal PROCHOT mode.  This mode is triggered when a sensor on the die dete=
rmines that we are too hot and must throttle to avoid damaging the chip.",
         "Unit": "PCU"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/broadwellx/pipeline.json
index 75233316640b..b08516adf789 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
@@ -500,7 +500,7 @@
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
         "EventCode": "0x87",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "This event counts stalls occured due to chan=
ging prefix length (66, 67 or REX.W when they change the length of the deco=
ded instruction). Occurrences counting is proportional to the number of pre=
fixes in a 16B-line. This may result in the following penalties: three-cycl=
e penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occurred due to cha=
nging prefix length (66, 67 or REX.W when they change the length of the dec=
oded instruction). Occurrences counting is proportional to the number of pr=
efixes in a 16B-line. This may result in the following penalties: three-cyc=
le penalty for each LCP in a 16-byte chunk.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
index 38eaac5afd4b..d9d96aacba5b 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
@@ -1175,7 +1175,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x28",
         "Unit": "CBO"
     },
@@ -1184,7 +1184,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by locally HOMe=
d memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
@@ -1193,7 +1193,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisifed by locally HOMed memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by locally HOMed memory.",
         "UMask": "0x2a",
         "Unit": "CBO"
     },
@@ -1202,7 +1202,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
ifed by an opcode, inserted into the TOR that are satisifed by locally HOMe=
d memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode, inserted into the TOR that are satisfied by locally HOMe=
d memory.",
         "UMask": "0x23",
         "Unit": "CBO"
     },
@@ -1220,7 +1220,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions insert=
ed into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x8a",
         "Unit": "CBO"
     },
@@ -1229,7 +1229,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
ifed by an opcode,  inserted into the TOR that are satisifed by remote cach=
es or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satis=
fied by an opcode,  inserted into the TOR that are satisfied by remote cach=
es or remote memory.",
         "UMask": "0x83",
         "Unit": "CBO"
     },
@@ -1301,7 +1301,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisifed by remote caches or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserte=
d into the TOR that are satisfied by remote caches or remote memory.",
         "UMask": "0x88",
         "Unit": "CBO"
     },
@@ -1310,7 +1310,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by remote cache=
s or remote memory.",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH an=
d set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisf=
ied by an opcode,  inserted into the TOR that are satisfied by remote cache=
s or remote memory.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
@@ -1365,7 +1365,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by locally HOMed memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by locally HOMed memory.",
         "UMask": "0x21",
         "Unit": "CBO"
     },
@@ -1392,7 +1392,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by locally HOMed memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by locally HOMed memory.",
         "UMask": "0x23",
         "Unit": "CBO"
     },
@@ -1419,7 +1419,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by remote caches or remote memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisfied by an opcode, in the TOR that are sa=
tisfied by remote caches or remote memory.",
         "UMask": "0x83",
         "Unit": "CBO"
     },
@@ -1500,7 +1500,7 @@
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by remote caches or remote memory.",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisfied by an opcode,  in the TOR that are satis=
fied by remote caches or remote memory.",
         "UMask": "0x81",
         "Unit": "CBO"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
index a5457c7ba58b..39218484278a 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
@@ -38,7 +38,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because there were not enough Egress =
credits.  Had there been enough credits, the spawn would have worked as the=
 RBT bit was set and the RBT tag matched.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits.  Had there been enough credits, the spawn would have worked as th=
e RBT bit was set and the RBT tag matched.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -47,7 +47,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match and=
 there weren't enough Egress credits.   The valid bit was set.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d there weren't enough Egress credits.   The valid bit was set.",
         "UMask": "0x20",
         "Unit": "QPI LL"
     },
@@ -56,7 +56,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because there were not enough Egress =
credits AND the RBT bit was not set, but the RBT tag matched.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because there were not enough Egress=
 credits AND the RBT bit was not set, but the RBT tag matched.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -65,7 +65,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match, th=
e valid bit was not set and there weren't enough Egress credits.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match, t=
he valid bit was not set and there weren't enough Egress credits.",
         "UMask": "0x80",
         "Unit": "QPI LL"
     },
@@ -74,7 +74,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match alt=
hough the valid bit was set and there were enough Egress credits.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match al=
though the valid bit was set and there were enough Egress credits.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -83,7 +83,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_HIT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the route-back table (RBT) sp=
ecified that the transaction should not trigger a direct2core tranaction.  =
This is common for IO transactions.  There were enough Egress credits and t=
he RBT tag matched but the valid bit was not set.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the route-back table (RBT) s=
pecified that the transaction should not trigger a direct2core tranaction. =
 This is common for IO transactions.  There were enough Egress credits and =
the RBT tag matched but the valid bit was not set.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -92,7 +92,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match and=
 the valid bit was not set although there were enough Egress credits.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn failed because the RBT tag did not match an=
d the valid bit was not set although there were enough Egress credits.",
         "UMask": "0x40",
         "Unit": "QPI LL"
     },
@@ -101,7 +101,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.SUCCESS_RBT_HIT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn was successful.  There were sufficient credi=
ts, the RBT valid bit was set and there was an RBT tag match.  The message =
was marked to spawn direct2core.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.; The spawn was successful.  There were sufficient cred=
its, the RBT valid bit was set and there was an RBT tag match.  The message=
 was marked to spawn direct2core.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
index e682eedf644a..4922cfca329e 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
@@ -427,7 +427,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that we are in I=
nteral PROCHOT mode.  This mode is triggered when a sensor on the die deter=
mines that we are too hot and must throttle to avoid damaging the chip.",
+        "PublicDescription": "Counts the number of cycles that we are in I=
nternal PROCHOT mode.  This mode is triggered when a sensor on the die dete=
rmines that we are too hot and must throttle to avoid damaging the chip.",
         "Unit": "PCU"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json =
b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
index ef4767feb4e2..65db3e00c2e2 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
@@ -44,7 +44,7 @@
         "MetricName": "LLC_MISSES.PCIE_WRITE",
         "PerPkg": "1",
         "PortMask": "0x01",
-        "PublicDescription": "Counts every write request of 4 bytes of dat=
a made by IIO Part0 to a unit onthe main die (generally memory). In the gen=
eral case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) tha=
t is plugged directly into one of the PCIe slots. Part0 could also refer to=
 any device plugged into the first slot of a PCIe riser card or to a device=
 attached to the IIO unit which starts its use of the bus using lane 0 of t=
he 16 lanes supported by the bus.",
+        "PublicDescription": "Counts every write request of 4 bytes of dat=
a made by IIO Part0 to a unit on the main die (generally memory). In the ge=
neral case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) th=
at is plugged directly into one of the PCIe slots. Part0 could also refer t=
o any device plugged into the first slot of a PCIe riser card or to a devic=
e attached to the IIO unit which starts its use of the bus using lane 0 of =
the 16 lanes supported by the bus.",
         "ScaleUnit": "4Bytes",
         "UMask": "0x1",
         "Unit": "IIO"
@@ -11637,7 +11637,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x01",
-        "PublicDescription": "Counts every write request of 4 bytes of dat=
a made by IIO Part0 to a unit onthe main die (generally memory). In the gen=
eral case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) tha=
t is plugged directly into one of the PCIe slots. Part0 could also refer to=
 any device plugged into the first slot of a PCIe riser card or to a device=
 attached to the IIO unit which starts its use of the bus using lane 0 of t=
he 16 lanes supported by the bus.",
+        "PublicDescription": "Counts every write request of 4 bytes of dat=
a made by IIO Part0 to a unit on the main die (generally memory). In the ge=
neral case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) th=
at is plugged directly into one of the PCIe slots. Part0 could also refer t=
o any device plugged into the first slot of a PCIe riser card or to a devic=
e attached to the IIO unit which starts its use of the bus using lane 0 of =
the 16 lanes supported by the bus.",
         "UMask": "0x1",
         "Unit": "IIO"
     },
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json =
b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
index 6835e14cd42c..8e21dc3eff16 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
@@ -175,7 +175,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that we are in I=
nteral PROCHOT mode.  This mode is triggered when a sensor on the die deter=
mines that we are too hot and must throttle to avoid damaging the chip.",
+        "PublicDescription": "Counts the number of cycles that we are in I=
nternal PROCHOT mode.  This mode is triggered when a sensor on the die dete=
rmines that we are too hot and must throttle to avoid damaging the chip.",
         "Unit": "PCU"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/=
perf/pmu-events/arch/x86/jaketown/pipeline.json
index 11d41ce8c922..85c04fe7632a 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
@@ -501,7 +501,7 @@
         "BriefDescription": "Cases when loads get true Block-on-Store bloc=
king code preventing store forwarding.",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PublicDescription": "This event counts loads that followed a stor=
e to the same address, where the data could not be forwarded inside the pip=
eline from the store to the load.  The most common reason why store forward=
ing would be blocked is when a load's address range overlaps with a preceed=
ing smaller uncompleted store.  See the table of not supported store forwar=
ds in the Intel? 64 and IA-32 Architectures Optimization Reference Manual. =
 The penalty for blocked store forwarding is that the load must wait for th=
e store to complete before it can be issued.",
+        "PublicDescription": "This event counts loads that followed a stor=
e to the same address, where the data could not be forwarded inside the pip=
eline from the store to the load.  The most common reason why store forward=
ing would be blocked is when a load's address range overlaps with a precedi=
ng smaller uncompleted store.  See the table of not supported store forward=
s in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  =
The penalty for blocked store forwarding is that the load must wait for the=
 store to complete before it can be issued.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
index b9e68f9f33ea..47830ca5c682 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
@@ -572,7 +572,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x4",
         "Unit": "CBO"
     },
@@ -581,7 +581,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0xa",
         "Unit": "CBO"
     },
@@ -590,7 +590,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x3",
         "Unit": "CBO"
     },
@@ -599,7 +599,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x48",
         "Unit": "CBO"
     },
@@ -608,7 +608,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x44",
         "Unit": "CBO"
     },
@@ -617,7 +617,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x4a",
         "Unit": "CBO"
     },
@@ -626,7 +626,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x43",
         "Unit": "CBO"
     },
@@ -635,7 +635,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x41",
         "Unit": "CBO"
     },
@@ -644,7 +644,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x50",
         "Unit": "CBO"
     },
@@ -653,7 +653,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x1",
         "Unit": "CBO"
     },
@@ -662,7 +662,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.WB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
+        "PublicDescription": "Counts the number of entries successfully in=
serted into the TOR that match  qualifications specified by the subevent.  =
There are a number of subevent 'filters' but only a subset of the subevent =
combinations are valid.  Subevents that require an opcode or NID match requ=
ire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example=
, one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' =
and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x10",
         "Unit": "CBO"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
index 1c2cf94889a1..4a48bb22d556 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
@@ -20,7 +20,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -29,7 +29,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -38,7 +38,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -47,7 +47,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_Q_DIRECT2CORE.SUCCESS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exclusive filters.  Filt=
er [0] can be used to get successful spawns, while [1:3] provide the differ=
ent failure cases.  Note that this does not count packets that are not cand=
idates for Direct2Core.  The only candidates for Direct2Core are DRS packet=
s destined for Cbos.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -80,7 +80,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_Q_RxL_BYPASSED",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transfere=
d, it implies that there was queueing getting onto the ring, and thus the t=
ransactions saw higher latency.",
+        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transferr=
ed, it implies that there was queueing getting onto the ring, and thus the =
transactions saw higher latency.",
         "Unit": "QPI LL"
     },
     {
@@ -176,7 +176,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ing a 64B cacheline across QPI, we will break it into 9 flits -- 1 with hea=
der information and 8 with 64 bits of actual 'data' and an additional 16 bi=
ts of other information.  To calculate 'data' bandwidth, one should therefo=
re do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with he=
ader information and 8 with 64 bits of actual 'data' and an additional 16 b=
its of other information.  To calculate 'data' bandwidth, one should theref=
ore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -185,7 +185,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.IDLE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ing a 64B cacheline across QPI, we will break it into 9 flits -- 1 with hea=
der information and 8 with 64 bits of actual 'data' and an additional 16 bi=
ts of other information.  To calculate 'data' bandwidth, one should therefo=
re do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with he=
ader information and 8 with 64 bits of actual 'data' and an additional 16 b=
its of other information.  To calculate 'data' bandwidth, one should theref=
ore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -194,7 +194,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_RxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ing a 64B cacheline across QPI, we will break it into 9 flits -- 1 with hea=
der information and 8 with 64 bits of actual 'data' and an additional 16 bi=
ts of other information.  To calculate 'data' bandwidth, one should therefo=
re do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each '=
flit' is made up of 80 bits of information (in addition to some ECC data). =
 In full-width (L0) mode, flits are made up of four 'fits', each of which c=
ontains 20 bits of data (along with some additional ECC data).   In half-wi=
dth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as =
many fits to transmit a flit.  When one talks about QPI 'speed' (for exampl=
e, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the =
system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can =
calculate the bandwidth of the link by taking: flits*80b/time.  Note that t=
his is not the same as 'data' bandwidth.  For example, when we are transfer=
ring a 64B cacheline across QPI, we will break it into 9 flits -- 1 with he=
ader information and 8 with 64 bits of actual 'data' and an additional 16 b=
its of other information.  To calculate 'data' bandwidth, one should theref=
ore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -203,7 +203,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x18",
         "Unit": "QPI LL"
     },
@@ -212,7 +212,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -221,7 +221,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.DRS_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -230,7 +230,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x6",
         "Unit": "QPI LL"
     },
@@ -239,7 +239,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM_NONREQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -248,7 +248,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -257,7 +257,7 @@
         "EventCode": "0x2",
         "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for SNP, HOM, and DRS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -266,7 +266,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0xc",
         "Unit": "QPI LL"
     },
@@ -275,7 +275,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -284,7 +284,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCB_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -293,7 +293,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -302,7 +302,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -311,7 +311,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transfering a 64B c=
acheline across QPI, we will break it into 9 flits -- 1 with header informa=
tion and 8 with 64 bits of actual 'data' and an additional 16 bits of other=
 information.  To calculate 'data' bandwidth, one should therefore do: data=
 flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three 'groups' that allow us to track flits.  It=
 includes filters for NDR, NCB, and NCS message classes.  Each 'flit' is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four 'fits', each of which contains 20 =
bits of data (along with some additional ECC data).   In half-width (L0p) m=
ode, the fits are only 10 bits, and therefore it takes twice as many fits t=
o transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 GT/s=
), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system will=
 transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calculate t=
he bandwidth of the link by taking: flits*80b/time.  Note that this is not =
the same as 'data' bandwidth.  For example, when we are transferring a 64B =
cacheline across QPI, we will break it into 9 flits -- 1 with header inform=
ation and 8 with 64 bits of actual 'data' and an additional 16 bits of othe=
r information.  To calculate 'data' bandwidth, one should therefore do: dat=
a flits * 8B / time.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -553,7 +553,7 @@
         "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
         "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 wi=
th header information and 8 with 64 bits of actual 'data' and an additional=
 16 bits of other information.  To calculate 'data' bandwidth, one should t=
herefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -561,7 +561,7 @@
         "BriefDescription": "Flits Transferred - Group 0; Idle and Null Fl=
its",
         "EventName": "UNC_Q_TxL_FLITS_G0.IDLE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 wi=
th header information and 8 with 64 bits of actual 'data' and an additional=
 16 bits of other information.  To calculate 'data' bandwidth, one should t=
herefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -569,7 +569,7 @@
         "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
         "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsfering a 64B cacheline across QPI, we will break it into 9 flits -- 1 wit=
h header information and 8 with 64 bits of actual 'data' and an additional =
16 bits of other information.  To calculate 'data' bandwidth, one should th=
erefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach 'flit' is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four 'fits', each of wh=
ich contains 20 bits of data (along with some additional ECC data).   In ha=
lf-width (L0p) mode, the fits are only 10 bits, and therefore it takes twic=
e as many fits to transmit a flit.  When one talks about QPI 'speed' (for e=
xample, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0,=
 the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One=
 can calculate the bandwidth of the link by taking: flits*80b/time.  Note t=
hat this is not the same as 'data' bandwidth.  For example, when we are tra=
nsferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 wi=
th header information and 8 with 64 bits of actual 'data' and an additional=
 16 bits of other information.  To calculate 'data' bandwidth, one should t=
herefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -577,7 +577,7 @@
         "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x18",
         "Unit": "QPI LL"
     },
@@ -585,7 +585,7 @@
         "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -593,7 +593,7 @@
         "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits=
",
         "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -601,7 +601,7 @@
         "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x6",
         "Unit": "QPI LL"
     },
@@ -609,7 +609,7 @@
         "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -617,7 +617,7 @@
         "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
         "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
@@ -625,7 +625,7 @@
         "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
         "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -634,7 +634,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0xc",
         "Unit": "QPI LL"
     },
@@ -643,7 +643,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_DATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x4",
         "Unit": "QPI LL"
     },
@@ -652,7 +652,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCB_NONDATA",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x8",
         "Unit": "QPI LL"
     },
@@ -661,7 +661,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x10",
         "Unit": "QPI LL"
     },
@@ -670,7 +670,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x1",
         "Unit": "QPI LL"
     },
@@ -679,7 +679,7 @@
         "EventCode": "0x1",
         "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AK",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transfering a 6=
4B cacheline across QPI, we will break it into 9 flits -- 1 with header inf=
ormation and 8 with 64 bits of actual 'data' and an additional 16 bits of o=
ther information.  To calculate 'data' bandwidth, one should therefore do: =
data flits * 8B / time.",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three 'groups' that allow us to track flits.=
  It includes filters for NDR, NCB, and NCS message classes.  Each 'flit' i=
s made up of 80 bits of information (in addition to some ECC data).  In ful=
l-width (L0) mode, flits are made up of four 'fits', each of which contains=
 20 bits of data (along with some additional ECC data).   In half-width (L0=
p) mode, the fits are only 10 bits, and therefore it takes twice as many fi=
ts to transmit a flit.  When one talks about QPI 'speed' (for example, 8.0 =
GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the system =
will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as 'data' bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual 'data' and an additional 16 bits of =
other information.  To calculate 'data' bandwidth, one should therefore do:=
 data flits * 8B / time.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-other.json
index 51a9a4e81046..1e472ac82285 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
@@ -630,7 +630,7 @@
         "EventCode": "0x20",
         "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transfering data wi=
thout coherency, and DRS is used for transfering data with coherency (cacha=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
hable PCI transactions).  This event can only track one message class at a =
time.",
         "UMask": "0x8",
         "Unit": "R3QPI"
     },
@@ -639,7 +639,7 @@
         "EventCode": "0x20",
         "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transfering data wi=
thout coherency, and DRS is used for transfering data with coherency (cacha=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
hable PCI transactions).  This event can only track one message class at a =
time.",
         "UMask": "0x10",
         "Unit": "R3QPI"
     },
@@ -648,7 +648,7 @@
         "EventCode": "0x20",
         "EventName": "UNC_R3_IIO_CREDITS_ACQUIRED.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transfering data wi=
thout coherency, and DRS is used for transfering data with coherency (cacha=
ble PCI transactions).  This event can only track one message class at a ti=
me.",
+        "PublicDescription": "Counts the number of times the NCS/NCB/DRS c=
redit is acquried in the QPI for sending messages on BL to the IIO.  There =
is one credit for each of these three message classes (three credits total)=
.  NCS is used for reads to PCIe space, NCB is used for transferring data w=
ithout coherency, and DRS is used for transferring data with coherency (cac=
hable PCI transactions).  This event can only track one message class at a =
time.",
         "UMask": "0x20",
         "Unit": "R3QPI"
     },
@@ -657,7 +657,7 @@
         "EventCode": "0x21",
         "EventName": "UNC_R3_IIO_CREDITS_REJECT.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transfering data witho=
ut coherency, and DRS is used for transfering data with coherency (cachable=
 PCI transactions).  This event can only track one message class at a time.=
",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachab=
le PCI transactions).  This event can only track one message class at a tim=
e.",
         "UMask": "0x8",
         "Unit": "R3QPI"
     },
@@ -666,7 +666,7 @@
         "EventCode": "0x21",
         "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transfering data witho=
ut coherency, and DRS is used for transfering data with coherency (cachable=
 PCI transactions).  This event can only track one message class at a time.=
",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachab=
le PCI transactions).  This event can only track one message class at a tim=
e.",
         "UMask": "0x10",
         "Unit": "R3QPI"
     },
@@ -675,7 +675,7 @@
         "EventCode": "0x21",
         "EventName": "UNC_R3_IIO_CREDITS_REJECT.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transfering data witho=
ut coherency, and DRS is used for transfering data with coherency (cachable=
 PCI transactions).  This event can only track one message class at a time.=
",
+        "PublicDescription": "Counts the number of times that a request at=
tempted to acquire an NCS/NCB/DRS credit in the QPI for sending messages on=
 BL to the IIO but was rejected because no credit was available.  There is =
one credit for each of these three message classes (three credits total).  =
NCS is used for reads to PCIe space, NCB is used for transferring data with=
out coherency, and DRS is used for transferring data with coherency (cachab=
le PCI transactions).  This event can only track one message class at a tim=
e.",
         "UMask": "0x20",
         "Unit": "R3QPI"
     },
@@ -684,7 +684,7 @@
         "EventCode": "0x22",
         "EventName": "UNC_R3_IIO_CREDITS_USED.DRS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transfering dat=
a without coherency, and DRS is used for transfering data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cachable PCI transactions).  This event can only track one message class a=
t a time.",
         "UMask": "0x8",
         "Unit": "R3QPI"
     },
@@ -693,7 +693,7 @@
         "EventCode": "0x22",
         "EventName": "UNC_R3_IIO_CREDITS_USED.NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transfering dat=
a without coherency, and DRS is used for transfering data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cachable PCI transactions).  This event can only track one message class a=
t a time.",
         "UMask": "0x10",
         "Unit": "R3QPI"
     },
@@ -702,7 +702,7 @@
         "EventCode": "0x22",
         "EventName": "UNC_R3_IIO_CREDITS_USED.NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transfering dat=
a without coherency, and DRS is used for transfering data with coherency (c=
achable PCI transactions).  This event can only track one message class at =
a time.",
+        "PublicDescription": "Counts the number of cycles when the NCS/NCB=
/DRS credit is in use in the QPI for sending messages on BL to the IIO.  Th=
ere is one credit for each of these three message classes (three credits to=
tal).  NCS is used for reads to PCIe space, NCB is used for transferring da=
ta without coherency, and DRS is used for transferring data with coherency =
(cachable PCI transactions).  This event can only track one message class a=
t a time.",
         "UMask": "0x20",
         "Unit": "R3QPI"
     },
@@ -1107,7 +1107,7 @@
         "EventCode": "0x33",
         "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED",
         "PerPkg": "1",
-        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transfered).  Therefore, this event will increment by the number o=
f credits acquired in each cycle.  Filtering based on message class is not =
provided.  One can count the number of packets transfered in a given messag=
e class using an qfclk event.",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transferred).  Therefore, this event will increment by the number =
of credits acquired in each cycle.  Filtering based on message class is not=
 provided.  One can count the number of packets transferred in a given mess=
age class using an qfclk event.",
         "Unit": "R3QPI"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index 638aa8a35cdb..a00f53978c3e 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -266,7 +266,7 @@
         "EventCode": "0x9",
         "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that we are in I=
nteral PROCHOT mode.  This mode is triggered when a sensor on the die deter=
mines that we are too hot and must throttle to avoid damaging the chip.",
+        "PublicDescription": "Counts the number of cycles that we are in I=
nternal PROCHOT mode.  This mode is triggered when a sensor on the die dete=
rmines that we are too hot and must throttle to avoid damaging the chip.",
         "Unit": "PCU"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/too=
ls/perf/pmu-events/arch/x86/knightslanding/cache.json
index 01aea3d2832e..4568520e6d95 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
@@ -6,7 +6,7 @@
         "SampleAfterValue": "200003"
     },
     {
-        "BriefDescription": "Counts the number of core cycles the fetch st=
alls because of an icache miss. This is a cummulative count of core cycles =
the fetch stalled for all icache misses.",
+        "BriefDescription": "Counts the number of core cycles the fetch st=
alls because of an icache miss. This is a cumulative count of core cycles t=
he fetch stalled for all icache misses.",
         "EventCode": "0x86",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
         "PublicDescription": "This event counts the number of core cycles =
the fetch stalls because of an icache miss. This is a cumulative count of c=
ycles the NIP stalled for all icache misses.",
@@ -108,7 +108,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for reponses from snoop request hit with data fo=
rwarded from it Far(not in the same quadrant as the request)-other tile L2 =
in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from snoop request hit with data f=
orwarded from it Far(not in the same quadrant as the request)-other tile L2=
 in E/F/M state. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -135,7 +135,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for reponses from snoop request hit with data fo=
rwarded from its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Demand code reads and prefetch code re=
ad requests  that accounts for responses from snoop request hit with data f=
orwarded from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -216,7 +216,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for reponses from snoop request hit with =
data forwarded from it Far(not in the same quadrant as the request)-other t=
ile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from snoop request hit with=
 data forwarded from it Far(not in the same quadrant as the request)-other =
tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -243,7 +243,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for reponses from snoop request hit with =
data forwarded from its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch =
data read requests  that accounts for responses from snoop request hit with=
 data forwarded from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -324,7 +324,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any Prefetch requests that accounts fo=
r reponses from snoop request hit with data forwarded from it Far(not in th=
e same quadrant as the request)-other tile L2 in E/F/M state. Valid only in=
 SNC4 Cluster mode.",
+        "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from snoop request hit with data forwarded from it Far(not in t=
he same quadrant as the request)-other tile L2 in E/F/M state. Valid only i=
n SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -351,7 +351,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any Prefetch requests that accounts fo=
r reponses from snoop request hit with data forwarded from its Near-other t=
ile L2 in E/F/M state",
+        "BriefDescription": "Counts any Prefetch requests that accounts fo=
r responses from snoop request hit with data forwarded from its Near-other =
tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -423,7 +423,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any Read request  that accounts for re=
ponses from snoop request hit with data forwarded from it Far(not in the sa=
me quadrant as the request)-other tile L2 in E/F/M state. Valid only in SNC=
4 Cluster mode.",
+        "BriefDescription": "Counts any Read request  that accounts for re=
sponses from snoop request hit with data forwarded from it Far(not in the s=
ame quadrant as the request)-other tile L2 in E/F/M state. Valid only in SN=
C4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -450,7 +450,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any Read request  that accounts for re=
ponses from snoop request hit with data forwarded from its Near-other tile =
L2 in E/F/M state",
+        "BriefDescription": "Counts any Read request  that accounts for re=
sponses from snoop request hit with data forwarded from its Near-other tile=
 L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -531,7 +531,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any request that accounts for reponses=
 from snoop request hit with data forwarded from it Far(not in the same qua=
drant as the request)-other tile L2 in E/F/M state. Valid only in SNC4 Clus=
ter mode.",
+        "BriefDescription": "Counts any request that accounts for response=
s from snoop request hit with data forwarded from it Far(not in the same qu=
adrant as the request)-other tile L2 in E/F/M state. Valid only in SNC4 Clu=
ster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -558,7 +558,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts any request that accounts for reponses=
 from snoop request hit with data forwarded from its Near-other tile L2 in =
E/F/M state",
+        "BriefDescription": "Counts any request that accounts for response=
s from snoop request hit with data forwarded from its Near-other tile L2 in=
 E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -639,7 +639,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for reponses from snoop request hit with data forwarded from =
it Far(not in the same quadrant as the request)-other tile L2 in E/F/M stat=
e. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from snoop request hit with data forwarded from=
 it Far(not in the same quadrant as the request)-other tile L2 in E/F/M sta=
te. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -666,7 +666,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for reponses from snoop request hit with data forwarded from =
its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Demand cacheable data write requests  =
that accounts for responses from snoop request hit with data forwarded from=
 its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -747,7 +747,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for reponses from snoop request hit with data forwarded from it F=
ar(not in the same quadrant as the request)-other tile L2 in E/F/M state. V=
alid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from snoop request hit with data forwarded from it =
Far(not in the same quadrant as the request)-other tile L2 in E/F/M state. =
Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -774,7 +774,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for reponses from snoop request hit with data forwarded from its =
Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Bus locks and split lock requests that=
 accounts for responses from snoop request hit with data forwarded from its=
 Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -855,7 +855,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for reponses from snoop request hit with data forwarded f=
rom it Far(not in the same quadrant as the request)-other tile L2 in E/F/M =
state. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from snoop request hit with data forwarded =
from it Far(not in the same quadrant as the request)-other tile L2 in E/F/M=
 state. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -882,7 +882,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for reponses from snoop request hit with data forwarded f=
rom its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts demand code reads and prefetch code re=
ads that accounts for responses from snoop request hit with data forwarded =
from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1053,7 +1053,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for reponses from snoop request hit with data forwarded from it Far(no=
t in the same quadrant as the request)-other tile L2 in E/F/M state. Valid =
only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from snoop request hit with data forwarded from it Far(n=
ot in the same quadrant as the request)-other tile L2 in E/F/M state. Valid=
 only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1080,7 +1080,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for reponses from snoop request hit with data forwarded from its Near-=
other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Demand cacheable data writes that acco=
unts for responses from snoop request hit with data forwarded from its Near=
-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1170,7 +1170,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for reponses from snoop =
request hit with data forwarded from it Far(not in the same quadrant as the=
 request)-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from snoop=
 request hit with data forwarded from it Far(not in the same quadrant as th=
e request)-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1197,7 +1197,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for reponses from snoop =
request hit with data forwarded from its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid o=
nly for Outstanding response type).  that accounts for responses from snoop=
 request hit with data forwarded from its Near-other tile L2 in E/F/M state=
",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1287,7 +1287,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for reponses from snoop request hi=
t with data forwarded from it Far(not in the same quadrant as the request)-=
other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from snoop request h=
it with data forwarded from it Far(not in the same quadrant as the request)=
-other tile L2 in E/F/M state. Valid only in SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a7",
@@ -1314,7 +1314,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for reponses from snoop request hi=
t with data forwarded from its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and sho=
uld be programmed on PMC1) that accounts for responses from snoop request h=
it with data forwarded from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a7",
@@ -1386,7 +1386,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from it Far(not in th=
e same quadrant as the request)-other tile L2 in E/F/M state. Valid only in=
 SNC4 Cluster mode.",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from it Far(not in t=
he same quadrant as the request)-other tile L2 in E/F/M state. Valid only i=
n SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1413,7 +1413,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from its Near-other t=
ile L2 in E/F/M state",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from its Near-other =
tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1494,7 +1494,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from it Far(not in th=
e same quadrant as the request)-other tile L2 in E/F/M state. Valid only in=
 SNC4 Cluster mode.",
+        "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from it Far(not in t=
he same quadrant as the request)-other tile L2 in E/F/M state. Valid only i=
n SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1521,7 +1521,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r reponses from snoop request hit with data forwarded from its Near-other t=
ile L2 in E/F/M state",
+        "BriefDescription": "Counts L2 code HW prefetches that accounts fo=
r responses from snoop request hit with data forwarded from its Near-other =
tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1602,7 +1602,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for reponses from snoop request hit with da=
ta forwarded from its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFE=
TCHW instruction) that accounts for responses from snoop request hit with d=
ata forwarded from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1683,7 +1683,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Software Prefetches that accounts for =
reponses from snoop request hit with data forwarded from it Far(not in the =
same quadrant as the request)-other tile L2 in E/F/M state. Valid only in S=
NC4 Cluster mode.",
+        "BriefDescription": "Counts Software Prefetches that accounts for =
responses from snoop request hit with data forwarded from it Far(not in the=
 same quadrant as the request)-other tile L2 in E/F/M state. Valid only in =
SNC4 Cluster mode.",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1710,7 +1710,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts Software Prefetches that accounts for =
reponses from snoop request hit with data forwarded from its Near-other til=
e L2 in E/F/M state",
+        "BriefDescription": "Counts Software Prefetches that accounts for =
responses from snoop request hit with data forwarded from its Near-other ti=
le L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1818,7 +1818,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for reponses from snoop request hit with =
data forwarded from its Near-other tile L2 in E/F/M state",
+        "BriefDescription": "Counts UC code reads (valid only for Outstand=
ing response type)  that accounts for responses from snoop request hit with=
 data forwarded from its Near-other tile L2 in E/F/M state",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json b/=
tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
index 1b803fa38641..3dc532107ead 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
@@ -254,14 +254,14 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "Counts the number of occurences a retired loa=
d gets blocked because its address overlaps with a store whose data is not =
ready",
+        "BriefDescription": "Counts the number of occurrences a retired lo=
ad gets blocked because its address overlaps with a store whose data is not=
 ready",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_BLOCK_STD_NOTREADY",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts the number of occurences a retired loa=
d gets blocked because its address partially overlaps with a store",
+        "BriefDescription": "Counts the number of occurrences a retired lo=
ad gets blocked because its address partially overlaps with a store",
         "Data_LA": "1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_BLOCK_ST_FORWARD",
@@ -270,7 +270,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts the number of occurences a retired loa=
d that is a cache line split. Each split should be counted only once.",
+        "BriefDescription": "Counts the number of occurrences a retired lo=
ad that is a cache line split. Each split should be counted only once.",
         "Data_LA": "1",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.LD_SPLITS",
@@ -293,7 +293,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Counts the number of occurences a retired sto=
re that is a cache line split. Each split should be counted only once.",
+        "BriefDescription": "Counts the number of occurrences a retired st=
ore that is a cache line split. Each split should be counted only once.",
         "EventCode": "0x03",
         "EventName": "RECYCLEQ.ST_SPLITS",
         "PublicDescription": "This event counts the number of retired stor=
e that experienced a cache line boundary split(Precise Event). Note that ea=
ch spilt should be counted only once.",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.jso=
n b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
index 3abd9c3fdc48..369a4a4ede74 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
@@ -1843,7 +1843,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts cycles source throttling is adderted -=
 horizontal",
+        "BriefDescription": "Counts cycles source throttling is asserted -=
 horizontal",
         "EventCode": "0xA5",
         "EventName": "UNC_H_FAST_ASSERTED.HORZ",
         "PerPkg": "1",
@@ -1851,7 +1851,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Counts cycles source throttling is adderted -=
 vertical",
+        "BriefDescription": "Counts cycles source throttling is asserted -=
 vertical",
         "EventCode": "0xA5",
         "EventName": "UNC_H_FAST_ASSERTED.VERT",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/sandybridge/pipeline.json
index 53ab5993e8b0..54454e5e262c 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
@@ -509,7 +509,7 @@
         "BriefDescription": "Cases when loads get true Block-on-Store bloc=
king code preventing store forwarding.",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PublicDescription": "This event counts loads that followed a stor=
e to the same address, where the data could not be forwarded inside the pip=
eline from the store to the load.  The most common reason why store forward=
ing would be blocked is when a load's address range overlaps with a preceed=
ing smaller uncompleted store.  See the table of not supported store forwar=
ds in the Intel(R) 64 and IA-32 Architectures Optimization Reference Manual=
.  The penalty for blocked store forwarding is that the load must wait for =
the store to complete before it can be issued.",
+        "PublicDescription": "This event counts loads that followed a stor=
e to the same address, where the data could not be forwarded inside the pip=
eline from the store to the load.  The most common reason why store forward=
ing would be blocked is when a load's address range overlaps with a precedi=
ng smaller uncompleted store.  See the table of not supported store forward=
s in the Intel(R) 64 and IA-32 Architectures Optimization Reference Manual.=
  The penalty for blocked store forwarding is that the load must wait for t=
he store to complete before it can be issued.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json b/tool=
s/perf/pmu-events/arch/x86/silvermont/frontend.json
index c35da10f7133..cd6ed3f59e26 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/frontend.json
@@ -11,7 +11,7 @@
         "BriefDescription": "Counts the number of JCC baclears",
         "EventCode": "0xE6",
         "EventName": "BACLEARS.COND",
-        "PublicDescription": "The BACLEARS event counts the number of time=
s the front end is resteered, mainly when the Branch Prediction Unit cannot=
 provide a correct prediction and this is corrected by the Branch Address C=
alculator at the front end.  The BACLEARS.COND event counts the number of J=
CC (Jump on Condtional Code) baclears.",
+        "PublicDescription": "The BACLEARS event counts the number of time=
s the front end is resteered, mainly when the Branch Prediction Unit cannot=
 provide a correct prediction and this is corrected by the Branch Address C=
alculator at the front end.  The BACLEARS.COND event counts the number of J=
CC (Jump on Conditional Code) baclears.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.js=
on b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
index ef635bff1522..f75084309041 100644
--- a/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
@@ -56,7 +56,7 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "DTLB misses casued by low part of address",
+        "BriefDescription": "DTLB misses caused by low part of address",
         "EventCode": "0x49",
         "EventName": "DTLB_MISSES.PDE_MISS",
         "SampleAfterValue": "200000",
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
index fd30460b6218..8ffdbe526d98 100644
--- a/tools/perf/util/evswitch.h
+++ b/tools/perf/util/evswitch.h
@@ -22,9 +22,9 @@ bool evswitch__discard(struct evswitch *evswitch, struct =
evsel *evsel);
=20
 #define OPTS_EVSWITCH(evswitch)								  \
 	OPT_STRING(0, "switch-on", &(evswitch)->on_name,				  \
-		   "event", "Consider events after the ocurrence of this event"),	  \
+		   "event", "Consider events after the occurrence of this event"),	  \
 	OPT_STRING(0, "switch-off", &(evswitch)->off_name,				  \
-		   "event", "Stop considering events after the ocurrence of this event")=
, \
+		   "event", "Stop considering events after the occurrence of this event"=
), \
 	OPT_BOOLEAN(0, "show-on-off-events", &(evswitch)->show_on_off_events,		  \
 		    "Show the on/off switch events, used with --switch-on and --switch-o=
ff")
=20
--=20
2.39.0

