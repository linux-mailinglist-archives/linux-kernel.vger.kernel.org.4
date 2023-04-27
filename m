Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCBA6F0D08
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbjD0UWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344210AbjD0UWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:22:45 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C039140C9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:22:42 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f0a2f8216fso823101cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682626962; x=1685218962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HAS9Sjys4o5xRDIJ3TABZcGs5bn9+R6GoOuNEpEwLY=;
        b=AH/1FXFOeVbaxFFZtyjllNI1DbtQC/7rWXv8gj8KH0O9GF5lGBoUIx1FhPJSncHo62
         t8C0YgX2ARLdHuk0R687ELRmg05Js5pPpRqoIGe8SC7JER7zqUPIA1aYhfzf9p+i7oum
         qg8m93g3y+ULdF//2DVtdqnUicM9bMeLfTtDiJyDR09IurNJL4MfFeVJYI7AbKrisEgL
         HBuFB3T4tdqtGnd49KaWkIIFADg1FYvFog3eAdJqzOryXasmoEO2df83uR67Xio9moJz
         dmAGfyA9Pm9/zkMgNoFlHYkh6tVrYZGohXCiZAyDaNzKyGMMnhWZx9U4sZRHlA5aNMZ4
         a+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682626962; x=1685218962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HAS9Sjys4o5xRDIJ3TABZcGs5bn9+R6GoOuNEpEwLY=;
        b=fNjB6uBOP+GoofOEyDOyzkfe7tn4Pf/DfWQ3yiSxwfLNDShPc3u4yLMZNDbYevFK+R
         LQt6hiKXmUlVuproXq36MYBynyfCAcrBv2RFCD6ljG4mJuq1Ab9B9lExK0NMgiZfbMuu
         zTE4vR5TdN/PKILKWReenZoio1/SVSPt0j70wdtqljQ0LwEFBVzjofGE42w1FQkzza8K
         uRcuiitwP/pDnzh/2tn9ywBVU8FPcSHMAg8k2JyKnYojVmX3j352V96wCP3cOuKbgGrD
         vbu52TfeRdZg/2LlndNx2tb2U1BTGKQKdv3auXHLOn12kcz3WjfOsoJFC3NnPGYd0onJ
         G5IA==
X-Gm-Message-State: AC+VfDwhmH8ySr0+7Elf4/MQutkAkgX/juUJBC8LvMoY5tTpqfnioAM0
        VNXTIhs9j0lEVKFAKQFdJr81lfAWWHF6aBcdGxXqwg==
X-Google-Smtp-Source: ACHHUZ4zmlgATV6JVNNNpiAzU90hM7QFjo7zQDKeorysR4kUAXVK/jRHSVNp/eIGK8BjvGi5yQt/ChVNIg0de9i+sb0=
X-Received: by 2002:a05:622a:1ba3:b0:3ef:330c:8f9e with SMTP id
 bp35-20020a05622a1ba300b003ef330c8f9emr95753qtb.10.1682626961661; Thu, 27 Apr
 2023 13:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com> <20230426070050.1315519-4-irogers@google.com>
 <23a15658-e3f7-59f2-24b3-cfafe87f4145@linux.intel.com>
In-Reply-To: <23a15658-e3f7-59f2-24b3-cfafe87f4145@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 13:22:29 -0700
Message-ID: <CAP-5=fWDdMdV46BT=1365x0XXyPXbTKXq5GwNYK8mMs4T0wGpQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/40] perf vendor events intel: Add icelake metric constraints
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 12:06=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-04-26 3:00 a.m., Ian Rogers wrote:
> > Previously these constraints were disabled as they contained topdown
> > events. Since:
> > https://lore.kernel.org/all/20230312021543.3060328-9-irogers@google.com=
/
> > the topdown events are correctly grouped even if no group exists.
> >
> > This change was created by PR:
> > https://github.com/intel/perfmon/pull/71
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../perf/pmu-events/arch/x86/icelake/icl-metrics.json | 11 +++++++++++
>
> Since it targets fixing the hybrid issues, could you please move the
> unrelated patch out of the series? A huge series is realy hard to be
> reviewed.

I have done. The independent patches are at the front while the
dependencies are in the later patches. This is covered in the cover
letter.

Thanks,
Ian

> Thanks,
> Kan
>
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/=
tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> > index f45ae3483df4..cb58317860ea 100644
> > --- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> > @@ -311,6 +311,7 @@
> >      },
> >      {
> >          "BriefDescription": "This metric represents overall arithmetic=
 floating-point (FP) operations fraction the CPU has executed (retired)",
> > +        "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
> >          "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operation=
s_group",
> >          "MetricName": "tma_fp_arith",
> > @@ -413,6 +414,7 @@
> >      },
> >      {
> >          "BriefDescription": "Branch Misprediction Cost: Fraction of TM=
A slots wasted per non-speculative branch misprediction (retired JEClear)",
> > +        "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "(tma_branch_mispredicts + tma_fetch_latency * t=
ma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_ica=
che_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) * tma_info_slots=
 / BR_MISP_RETIRED.ALL_BRANCHES",
> >          "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
> >          "MetricName": "tma_info_branch_misprediction_cost",
> > @@ -458,6 +460,7 @@
> >      },
> >      {
> >          "BriefDescription": "Probability of Core Bound bottleneck hidd=
en by SMT-profiling artifacts",
> > +        "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilizat=
ion if tma_core_bound < tma_ports_utilization else 1) if tma_info_smt_2t_ut=
ilization > 0.5 else 0)",
> >          "MetricGroup": "Cor;SMT",
> >          "MetricName": "tma_info_core_bound_likely",
> > @@ -510,6 +513,7 @@
> >      },
> >      {
> >          "BriefDescription": "Total pipeline cost of DSB (uop cache) mi=
sses - subset of the Instruction_Fetch_BW Bottleneck",
> > +        "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (=
tma_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misse=
s + tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb =
+ tma_lsd + tma_mite))",
> >          "MetricGroup": "DSBmiss;Fed;tma_issueFB",
> >          "MetricName": "tma_info_dsb_misses",
> > @@ -591,6 +595,7 @@
> >      },
> >      {
> >          "BriefDescription": "Total pipeline cost of instruction fetch =
bandwidth related bottlenecks",
> > +        "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "100 * (tma_frontend_bound - tma_fetch_latency *=
 tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + tma_i=
cache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_big=
_code",
> >          "MetricGroup": "Fed;FetchBW;Frontend",
> >          "MetricName": "tma_info_instruction_fetch_bw",
> > @@ -929,6 +934,7 @@
> >      },
> >      {
> >          "BriefDescription": "Total pipeline cost of Memory Address Tra=
nslation related bottlenecks (data-side TLBs)",
> > +        "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "100 * tma_memory_bound * (tma_l1_bound / max(tm=
a_memory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_store_bound) * (tma_dtlb_load / max(tma_l1_bound, tma_4k_aliasing + =
tma_dtlb_load + tma_fb_full + tma_lock_latency + tma_split_loads + tma_stor=
e_fwd_blk)) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bou=
nd + tma_l3_bound + tma_store_bound) * (tma_dtlb_store / (tma_dtlb_store + =
tma_false_sharing + tma_split_stores + tma_store_latency + tma_streaming_st=
ores)))",
> >          "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
> >          "MetricName": "tma_info_memory_data_tlbs",
> > @@ -937,6 +943,7 @@
> >      },
> >      {
> >          "BriefDescription": "Total pipeline cost of Memory Latency rel=
ated bottlenecks (external memory and off-core caches)",
> > +        "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "100 * tma_memory_bound * (tma_dram_bound / (tma=
_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)=
 * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_l3_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store=
_bound) * (tma_l3_hit_latency / (tma_contested_accesses + tma_data_sharing =
+ tma_l3_hit_latency + tma_sq_full)) + tma_l2_bound / (tma_dram_bound + tma=
_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound))",
> >          "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
> >          "MetricName": "tma_info_memory_latency",
> > @@ -945,6 +952,7 @@
> >      },
> >      {
> >          "BriefDescription": "Total pipeline cost of Branch Mispredicti=
on related bottlenecks",
> > +        "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "100 * (tma_branch_mispredicts + tma_fetch_laten=
cy * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches + t=
ma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
> >          "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
> >          "MetricName": "tma_info_mispredictions",
> > @@ -996,6 +1004,7 @@
> >      },
> >      {
> >          "BriefDescription": "Average number of Uops retired in cycles =
where at least one uop has retired.",
> > +        "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "tma_retiring * tma_info_slots / cpu@UOPS_RETIRE=
D.SLOTS\\,cmask\\=3D1@",
> >          "MetricGroup": "Pipeline;Ret",
> >          "MetricName": "tma_info_retire"
> > @@ -1196,6 +1205,7 @@
> >      },
> >      {
> >          "BriefDescription": "This metric represents fraction of slots =
where the CPU was retiring memory operations -- uops for memory load or sto=
re accesses.",
> > +        "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "tma_light_operations * MEM_INST_RETIRED.ANY / I=
NST_RETIRED.ANY",
> >          "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_oper=
ations_group",
> >          "MetricName": "tma_memory_operations",
> > @@ -1266,6 +1276,7 @@
> >      },
> >      {
> >          "BriefDescription": "This metric represents the remaining ligh=
t uops fraction the CPU has executed - remaining means not covered by other=
 sibling nodes",
> > +        "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + t=
ma_memory_operations + tma_branch_instructions + tma_nop_instructions))",
> >          "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_oper=
ations_group",
> >          "MetricName": "tma_other_light_ops",
