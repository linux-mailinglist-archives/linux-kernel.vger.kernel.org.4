Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D956453CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLGGGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiLGGGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:06:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265C153EE5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 22:06:00 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so326490wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 22:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAEjpYydb4CkMK5QAthrsvB3rW6Y/7vqzmE8NBs4mic=;
        b=iW+IVMkyBW0FSpCUQl40tCb4lzY7Gjhz0MEPr2BSYJf6YiLMnXPtH3sqVONM364O42
         9AzbzGBT5NdRlRSLuxvxKC4cMP7EuFXcp64GkXMoU8woKvUGIX50jc2TDV564KsZb5+R
         D3AvR61Bk5JVmpd+NpQnixr/YUSGtsGQ6Ji7u6XkzBazAsytslI9APt0J0Uav4Ch2yF2
         GoGWzfJCUBuZFuVo1c/TZetHWLvr7qhrexRwARm29PowFZxAgsbKwNvdNQN+Hr+Yl49+
         /qbQ7Tuy2PR5o9ZHN5cM6Ao+n+zvFNiZ0+4W17U4hK3TojQNUV7s4dyV37psm1j5Y824
         kJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAEjpYydb4CkMK5QAthrsvB3rW6Y/7vqzmE8NBs4mic=;
        b=QXTb/MUjnBWW+2rNYWuXi8w/iq9b812p5uPgqXwNEt699eePeUeWD0dpj9whXDYHFt
         7TV8VV4B1JUJLNz5aoK9DQtrShFJv5Sqc+xxyNS+qESEIolnG97/FyOMRWMYfaL98GZc
         h4pbEJJ11ej4Qv63Yodn+WyO3ywonfmHljBMdZjkov/t6I45ImS/3hiy16NLMJbCzok0
         Qyy/gSD3THChN066jccdqXFZXYeClT1+aCBZRkX9ZbLcuvZ3BAE7bER8LNQnUmQIRMER
         2fNH74XuL7fRupPk9kQHEb7xpax9NHzwIYzbQvJhHb+LXrJsXKG/Or1aTNF3wCZZHuV9
         mrmQ==
X-Gm-Message-State: ANoB5pmdKfCGwEt0kH0GM4D0ONh5c8P6dqpwq+4KlWOd6h2bO4Z3Fl+a
        16n3XaNxSVkmlmw8cjTt3eEvUAnfsid6K2Hh3MEBBg==
X-Google-Smtp-Source: AA0mqf7H+Y3WWOZgdPzxT2covH+w7dO6z9JwJ1vk+wcaBjB4F8gUe77Dh2IAzkzaSJ0P2B/EDakCFstu2yOMCJQv9Q8=
X-Received: by 2002:a05:600c:4920:b0:3cf:8b23:549c with SMTP id
 f32-20020a05600c492000b003cf8b23549cmr55908405wmp.174.1670393158370; Tue, 06
 Dec 2022 22:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20221207053007.336806-1-sandipan.das@amd.com> <20221207053007.336806-5-sandipan.das@amd.com>
In-Reply-To: <20221207053007.336806-5-sandipan.das@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 6 Dec 2022 22:05:45 -0800
Message-ID: <CAP-5=fUS37Xqi1x2ZDj48saFu-g5dCvwqg8Vm0DF1V0vuq4tXw@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf vendor events amd: Add Zen 4 metrics
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        jhladky@redhat.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Dec 6, 2022 at 9:32 PM Sandipan Das <sandipan.das@amd.com> wrote:
>
> Add metrics taken from Section 2.1.15.2 "Performance Measurement" in
> the Processor Programming Reference (PPR) for AMD Family 19h Model 11h
> Revision B1 processors.
>
> The recommended metrics are sourced from Table 27 "Guidance for Common
> Performance Statistics with Complex Event Selects".
>
> The pipeline utilization metrics are sourced from Table 28 "Guidance
> for Pipeline Utilization Analysis Statistics". These are new to Zen 4
> processors and useful for finding performance bottlenecks by analyzing
> activity at different stages of the pipeline. Metric groups have been
> added for Level 1 and Level 2 analysis.
>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  .../pmu-events/arch/x86/amdzen4/pipeline.json |  98 +++++
>  .../arch/x86/amdzen4/recommended.json         | 334 ++++++++++++++++++
>  2 files changed, 432 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/recommended.js=
on
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json b/tools=
/perf/pmu-events/arch/x86/amdzen4/pipeline.json
> new file mode 100644
> index 000000000000..23d1f35d0903
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
> @@ -0,0 +1,98 @@
> +[
> +  {
> +    "MetricName": "total_dispatch_slots",
> +    "BriefDescription": "Total dispatch slots (upto 6 instructions can b=
e dispatched in each cycle).",
> +    "MetricExpr": "6 * ls_not_halted_cyc"
> +  },
> +  {
> +    "MetricName": "frontend_bound",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because the frontend did not supply enough instructions/ops.",
> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend,=
 total_dispatch_slots)",
> +    "MetricGroup": "pipeline_utilization_level1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "bad_speculation",
> +    "BriefDescription": "Fraction of dispatched ops that did not retire.=
",
> +    "MetricExpr": "d_ratio(de_src_op_disp.all - ex_ret_ops, total_dispat=
ch_slots)",
> +    "MetricGroup": "pipeline_utilization_level1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "backend_bound",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because of backend stalls.",
> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.backend_stalls, total=
_dispatch_slots)",
> +    "MetricGroup": "pipeline_utilization_level1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "smt_contention",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because the other thread was selected.",
> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.smt_contention, total=
_dispatch_slots)",
> +    "MetricGroup": "pipeline_utilization_level1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "retiring",
> +    "BriefDescription": "Fraction of dispatch slots used by ops that ret=
ired.",
> +    "MetricExpr": "d_ratio(ex_ret_ops, total_dispatch_slots)",
> +    "MetricGroup": "pipeline_utilization_level1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "frontend_bound_latency",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because of a latency bottleneck in the frontend (such as instruction cache=
 or TLB misses).",
> +    "MetricExpr": "d_ratio((6 * cpu@de_no_dispatch_per_slot.no_ops_from_=
frontend\\,cmask\\=3D0x6@), total_dispatch_slots)",
> +    "MetricGroup": "pipeline_utilization_level2;frontend_bound_level2",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "frontend_bound_bandwidth",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because of a bandwidth bottleneck in the frontend (such as decode or op ca=
che fetch bandwidth).",
> +    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend =
- (6 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=3D0x6@), =
total_dispatch_slots)",
> +    "MetricGroup": "pipeline_utilization_level2;frontend_bound_level2",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "bad_speculation_mispredicts",
> +    "BriefDescription": "Fraction of dispatched ops that were flushed du=
e to branch mispredicts.",
> +    "MetricExpr": "d_ratio(bad_speculation * ex_ret_brn_misp, ex_ret_brn=
_misp + resyncs_or_nc_redirects)",
> +    "MetricGroup": "pipeline_utilization_level2;bad_speculation_level2",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "bad_speculation_pipeline_restarts",
> +    "BriefDescription": "Fraction of dispatched ops that were flushed du=
e to pipeline restarts (resyncs).",
> +    "MetricExpr": "d_ratio(bad_speculation * resyncs_or_nc_redirects, ex=
_ret_brn_misp + resyncs_or_nc_redirects)",
> +    "MetricGroup": "pipeline_utilization_level2;bad_speculation_level2",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "backend_bound_memory",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because of stalls due to the memory subsystem.",
> +    "MetricExpr": "backend_bound * d_ratio(ex_no_retire.load_not_complet=
e, ex_no_retire.not_complete)",
> +    "MetricGroup": "pipeline_utilization_level2;backend_bound_level2",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "backend_bound_cpu",
> +    "BriefDescription": "Fraction of dispatch slots that remained unused=
 because of stalls not related to the memory subsystem.",
> +    "MetricExpr": "backend_bound * (1 - d_ratio(ex_no_retire.load_not_co=
mplete, ex_no_retire.not_complete))",
> +    "MetricGroup": "pipeline_utilization_level2;backend_bound_level2",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "retiring_fastpath",
> +    "BriefDescription": "Fraction of dispatch slots used by fastpath ops=
 that retired.",
> +    "MetricExpr": "retiring * (1 - d_ratio(ex_ret_ucode_ops, ex_ret_ops)=
)",
> +    "MetricGroup": "pipeline_utilization_level2;retiring_level2",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "retiring_microcode",
> +    "BriefDescription": "Fraction of dispatch slots used by microcode op=
s that retired.",
> +    "MetricExpr": "retiring * d_ratio(ex_ret_ucode_ops, ex_ret_ops)",
> +    "MetricGroup": "pipeline_utilization_level2;retiring_level2",
> +    "ScaleUnit": "100%"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json b/to=
ols/perf/pmu-events/arch/x86/amdzen4/recommended.json
> new file mode 100644
> index 000000000000..2e3c9d8942b9
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
> @@ -0,0 +1,334 @@
> +[
> +  {
> +    "MetricName": "branch_misprediction_ratio",
> +    "BriefDescription": "Execution-time branch misprediction ratio (non-=
speculative).",
> +    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
> +    "MetricGroup": "branch_prediction",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "EventName": "all_data_cache_accesses",
> +    "EventCode": "0x29",
> +    "BriefDescription": "All data cache accesses.",
> +    "UMask": "0x07"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_accesses",
> +    "BriefDescription": "All L2 cache accesses.",
> +    "MetricExpr": "l2_request_g1.all_no_prefetch + l2_pf_hit_l2.all + l2=
_pf_miss_l2_hit_l3.all + l2_pf_miss_l2_l3.all",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "l2_cache_accesses_from_l1_ic_misses",
> +    "BriefDescription": "L2 cache accesses from L1 instruction cache mis=
ses (including prefetch).",
> +    "MetricExpr": "l2_request_g1.cacheable_ic_read",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "l2_cache_accesses_from_l1_dc_misses",
> +    "BriefDescription": "L2 cache accesses from L1 data cache misses (in=
cluding prefetch).",
> +    "MetricExpr": "l2_request_g1.all_dc",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "l2_cache_accesses_from_l2_hwpf",
> +    "BriefDescription": "L2 cache accesses from L2 cache hardware prefet=
cher.",
> +    "MetricExpr": "l2_pf_hit_l2.all + l2_pf_miss_l2_hit_l3.all + l2_pf_m=
iss_l2_l3.all",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_misses",
> +    "BriefDescription": "All L2 cache misses.",
> +    "MetricExpr": "l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hi=
t_l3.all + l2_pf_miss_l2_l3.all",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "l2_cache_misses_from_l1_ic_miss",
> +    "BriefDescription": "L2 cache misses from L1 instruction cache misse=
s.",
> +    "MetricExpr": "l2_cache_req_stat.ic_fill_miss",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "l2_cache_misses_from_l1_dc_miss",
> +    "BriefDescription": "L2 cache misses from L1 data cache misses.",
> +    "MetricExpr": "l2_cache_req_stat.ls_rd_blk_c",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "l2_cache_misses_from_l2_hwpf",
> +    "BriefDescription": "L2 cache misses from L2 cache hardware prefetch=
er.",
> +    "MetricExpr": "l2_pf_miss_l2_hit_l3.all + l2_pf_miss_l2_l3.all",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_hits",
> +    "BriefDescription": "All L2 cache hits.",
> +    "MetricExpr": "l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2.all"=
,
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "l2_cache_hits_from_l1_ic_miss",
> +    "BriefDescription": "L2 cache hits from L1 instruction cache misses.=
",
> +    "MetricExpr": "l2_cache_req_stat.ic_hit_in_l2",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "l2_cache_hits_from_l1_dc_miss",
> +    "BriefDescription": "L2 cache hits from L1 data cache misses.",
> +    "MetricExpr": "l2_cache_req_stat.dc_hit_in_l2",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "l2_cache_hits_from_l2_hwpf",
> +    "BriefDescription": "L2 cache hits from L2 cache hardware prefetcher=
.",
> +    "MetricExpr": "l2_pf_hit_l2.all",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "l3_cache_accesses",
> +    "BriefDescription": "L3 cache accesses.",
> +    "MetricExpr": "l3_lookup_state.all_coherent_accesses_to_l3",
> +    "MetricGroup": "l3_cache"
> +  },
> +  {
> +    "MetricName": "l3_misses",
> +    "BriefDescription": "L3 misses (including cacheline state change req=
uests).",
> +    "MetricExpr": "l3_lookup_state.l3_miss",
> +    "MetricGroup": "l3_cache"
> +  },
> +  {
> +    "MetricName": "l3_read_miss_latency",
> +    "BriefDescription": "Average L3 read miss latency (in core clocks)."=
,
> +    "MetricExpr": "(l3_xi_sampled_latency.all * 10) / l3_xi_sampled_late=
ncy_requests.all",
> +    "MetricGroup": "l3_cache",
> +    "ScaleUnit": "1core clocks"
> +  },
> +  {
> +    "MetricName": "op_cache_fetch_miss_ratio",
> +    "BriefDescription": "Op cache miss ratio for all fetches.",
> +    "MetricExpr": "d_ratio(op_cache_hit_miss.op_cache_miss, op_cache_hit=
_miss.all_op_cache_accesses)",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "ic_fetch_miss_ratio",
> +    "BriefDescription": "Instruction cache miss ratio for all fetches. A=
n instruction cache miss will not be counted by this metric if it is an OC =
hit.",
> +    "MetricExpr": "d_ratio(ic_tag_hit_miss.instruction_cache_miss, ic_ta=
g_hit_miss.all_instruction_cache_accesses)",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "l1_data_cache_fills_from_memory",
> +    "BriefDescription": "L1 data cache fills from DRAM or MMIO in any NU=
MA node.",
> +    "MetricExpr": "ls_any_fills_from_sys.dram_io_all",
> +    "MetricGroup": "l1_dcache"
> +  },
> +  {
> +    "MetricName": "l1_data_cache_fills_from_remote_node",
> +    "BriefDescription": "L1 data cache fills from a different NUMA node.=
",
> +    "MetricExpr": "ls_any_fills_from_sys.far_all",
> +    "MetricGroup": "l1_dcache"
> +  },
> +  {
> +    "MetricName": "l1_data_cache_fills_from_same_ccx",
> +    "BriefDescription": "L1 data cache fills from within the same CCX.",
> +    "MetricExpr": "ls_any_fills_from_sys.local_all",
> +    "MetricGroup": "l1_dcache"
> +  },
> +  {
> +    "MetricName": "l1_data_cache_fills_from_different_ccx",
> +    "BriefDescription": "L1 data cache fills from another CCX cache in a=
ny NUMA node.",
> +    "MetricExpr": "ls_any_fills_from_sys.remote_cache",
> +    "MetricGroup": "l1_dcache"
> +  },
> +  {
> +    "MetricName": "all_l1_data_cache_fills",
> +    "BriefDescription": "All L1 data cache fills.",
> +    "MetricExpr": "ls_any_fills_from_sys.all",
> +    "MetricGroup": "l1_dcache"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_local_l2",
> +    "BriefDescription": "L1 demand data cache fills from local L2 cache.=
",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.local_l2",
> +    "MetricGroup": "l1_dcache"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_same_ccx",
> +    "BriefDescription": "L1 demand data cache fills from within the same=
 CCX.",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.local_ccx",
> +    "MetricGroup": "l1_dcache"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_near_cache",
> +    "BriefDescription": "L1 demand data cache fills from another CCX cac=
he in the same NUMA node.",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.near_cache",
> +    "MetricGroup": "l1_dcache"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_near_memory",
> +    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in=
 the same NUMA node.",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_near",
> +    "MetricGroup": "l1_dcache"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_far_cache",
> +    "BriefDescription": "L1 demand data cache fills from another CCX cac=
he in a different NUMA node.",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.far_cache",
> +    "MetricGroup": "l1_dcache"
> +  },
> +  {
> +    "MetricName": "l1_demand_data_cache_fills_from_far_memory",
> +    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in=
 a different NUMA node.",
> +    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_far",
> +    "MetricGroup": "l1_dcache"
> +  },
> +  {
> +    "MetricName": "l1_itlb_misses",
> +    "BriefDescription": "L1 instruction TLB misses.",
> +    "MetricExpr": "bp_l1_tlb_miss_l2_tlb_hit + bp_l1_tlb_miss_l2_tlb_mis=
s.all",
> +    "MetricGroup": "tlb"
> +  },
> +  {
> +    "MetricName": "l2_itlb_misses",
> +    "BriefDescription": "L2 instruction TLB misses and instruction page =
walks.",
> +    "MetricExpr": "bp_l1_tlb_miss_l2_tlb_miss.all",
> +    "MetricGroup": "tlb"
> +  },
> +  {
> +    "MetricName": "l1_dtlb_misses",
> +    "BriefDescription": "L1 data TLB misses.",
> +    "MetricExpr": "ls_l1_d_tlb_miss.all",
> +    "MetricGroup": "tlb"
> +  },
> +  {
> +    "MetricName": "l2_dtlb_misses",
> +    "BriefDescription": "L2 data TLB misses and data page walks.",
> +    "MetricExpr": "ls_l1_d_tlb_miss.all_l2_miss",
> +    "MetricGroup": "tlb"
> +  },
> +  {
> +    "MetricName": "all_tlbs_flushed",
> +    "BriefDescription": "All TLBs flushed.",
> +    "MetricExpr": "ls_tlb_flush.all",
> +    "MetricGroup": "tlb"
> +  },
> +  {
> +    "MetricName": "macro_ops_dispatched",
> +    "BriefDescription": "Macro-ops dispatched.",
> +    "MetricExpr": "de_src_op_disp.all",
> +    "MetricGroup": "decoder"
> +  },
> +  {
> +    "MetricName": "sse_avx_stalls",
> +    "BriefDescription": "Mixed SSE/AVX stalls.",
> +    "MetricExpr": "fp_disp_faults.sse_avx_all"
> +  },
> +  {
> +    "MetricName": "macro_ops_retired",
> +    "BriefDescription": "Macro-ops retired.",
> +    "MetricExpr": "ex_ret_ops"
> +  },
> +  {
> +    "MetricName": "dram_read_data_bytes_for_local_processor",

nit: Is "bytes" redundant in the name here? It may even be confusing
given the units.

> +    "BriefDescription": "DRAM read data bytes for local processor.",
> +    "MetricExpr": "local_processor_read_data_beats_cs0 + local_processor=
_read_data_beats_cs1 + local_processor_read_data_beats_cs2 + local_processo=
r_read_data_beats_cs3 + local_processor_read_data_beats_cs4 + local_process=
or_read_data_beats_cs5 + local_processor_read_data_beats_cs6 + local_proces=
sor_read_data_beats_cs7 + local_processor_read_data_beats_cs8 + local_proce=
ssor_read_data_beats_cs9 + local_processor_read_data_beats_cs10 + local_pro=
cessor_read_data_beats_cs11",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "dram_write_data_bytes_for_local_processor",
> +    "BriefDescription": "DRAM write data bytes for local processor.",
> +    "MetricExpr": "local_processor_write_data_beats_cs0 + local_processo=
r_write_data_beats_cs1 + local_processor_write_data_beats_cs2 + local_proce=
ssor_write_data_beats_cs3 + local_processor_write_data_beats_cs4 + local_pr=
ocessor_write_data_beats_cs5 + local_processor_write_data_beats_cs6 + local=
_processor_write_data_beats_cs7 + local_processor_write_data_beats_cs8 + lo=
cal_processor_write_data_beats_cs9 + local_processor_write_data_beats_cs10 =
+ local_processor_write_data_beats_cs11",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "dram_read_data_bytes_for_remote_processor",
> +    "BriefDescription": "DRAM read data bytes for remote processor.",
> +    "MetricExpr": "remote_processor_read_data_beats_cs0 + remote_process=
or_read_data_beats_cs1 + remote_processor_read_data_beats_cs2 + remote_proc=
essor_read_data_beats_cs3 + remote_processor_read_data_beats_cs4 + remote_p=
rocessor_read_data_beats_cs5 + remote_processor_read_data_beats_cs6 + remot=
e_processor_read_data_beats_cs7 + remote_processor_read_data_beats_cs8 + re=
mote_processor_read_data_beats_cs9 + remote_processor_read_data_beats_cs10 =
+ remote_processor_read_data_beats_cs11",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "dram_write_data_bytes_for_remote_processor",
> +    "BriefDescription": "DRAM write data bytes for remote processor.",
> +    "MetricExpr": "remote_processor_write_data_beats_cs0 + remote_proces=
sor_write_data_beats_cs1 + remote_processor_write_data_beats_cs2 + remote_p=
rocessor_write_data_beats_cs3 + remote_processor_write_data_beats_cs4 + rem=
ote_processor_write_data_beats_cs5 + remote_processor_write_data_beats_cs6 =
+ remote_processor_write_data_beats_cs7 + remote_processor_write_data_beats=
_cs8 + remote_processor_write_data_beats_cs9 + remote_processor_write_data_=
beats_cs10 + remote_processor_write_data_beats_cs11",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "local_socket_upstream_dma_read_data_bytes",
> +    "BriefDescription": "Local socket upstream DMA read data bytes.",
> +    "MetricExpr": "local_socket_upstream_read_beats_iom0 + local_socket_=
upstream_read_beats_iom1 + local_socket_upstream_read_beats_iom2 + local_so=
cket_upstream_read_beats_iom3",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "local_socket_upstream_dma_write_data_bytes",
> +    "BriefDescription": "Local socket upstream DMA write data bytes.",
> +    "MetricExpr": "local_socket_upstream_write_beats_iom0 + local_socket=
_upstream_write_beats_iom1 + local_socket_upstream_write_beats_iom2 + local=
_socket_upstream_write_beats_iom3",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "remote_socket_upstream_dma_read_data_bytes",
> +    "BriefDescription": "Remote socket upstream DMA read data bytes.",
> +    "MetricExpr": "remote_socket_upstream_read_beats_iom0 + remote_socke=
t_upstream_read_beats_iom1 + remote_socket_upstream_read_beats_iom2 + remot=
e_socket_upstream_read_beats_iom3",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "remote_socket_upstream_dma_write_data_bytes",
> +    "BriefDescription": "Remote socket upstream DMA write data bytes.",
> +    "MetricExpr": "remote_socket_upstream_write_beats_iom0 + remote_sock=
et_upstream_write_beats_iom1 + remote_socket_upstream_write_beats_iom2 + re=
mote_socket_upstream_write_beats_iom3",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "local_socket_inbound_data_bytes_to_cpu",
> +    "BriefDescription": "Local socket inbound data bytes to the CPU (e.g=
. read data).",
> +    "MetricExpr": "local_socket_inf0_inbound_data_beats_ccm0 + local_soc=
ket_inf1_inbound_data_beats_ccm0 + local_socket_inf0_inbound_data_beats_ccm=
1 + local_socket_inf1_inbound_data_beats_ccm1 + local_socket_inf0_inbound_d=
ata_beats_ccm2 + local_socket_inf1_inbound_data_beats_ccm2 + local_socket_i=
nf0_inbound_data_beats_ccm3 + local_socket_inf1_inbound_data_beats_ccm3 + l=
ocal_socket_inf0_inbound_data_beats_ccm4 + local_socket_inf1_inbound_data_b=
eats_ccm4 + local_socket_inf0_inbound_data_beats_ccm5 + local_socket_inf1_i=
nbound_data_beats_ccm5 + local_socket_inf0_inbound_data_beats_ccm6 + local_=
socket_inf1_inbound_data_beats_ccm6 + local_socket_inf0_inbound_data_beats_=
ccm7 + local_socket_inf1_inbound_data_beats_ccm7",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "3.0517578125e-5MiB"
> +  },
> +  {
> +    "MetricName": "local_socket_outbound_data_bytes_from_cpu",
> +    "BriefDescription": "Local socket outbound data bytes from the CPU (=
e.g. write data).",
> +    "MetricExpr": "local_socket_inf0_outbound_data_beats_ccm0 + local_so=
cket_inf1_outbound_data_beats_ccm0 + local_socket_inf0_outbound_data_beats_=
ccm1 + local_socket_inf1_outbound_data_beats_ccm1 + local_socket_inf0_outbo=
und_data_beats_ccm2 + local_socket_inf1_outbound_data_beats_ccm2 + local_so=
cket_inf0_outbound_data_beats_ccm3 + local_socket_inf1_outbound_data_beats_=
ccm3 + local_socket_inf0_outbound_data_beats_ccm4 + local_socket_inf1_outbo=
und_data_beats_ccm4 + local_socket_inf0_outbound_data_beats_ccm5 + local_so=
cket_inf1_outbound_data_beats_ccm5 + local_socket_inf0_outbound_data_beats_=
ccm6 + local_socket_inf1_outbound_data_beats_ccm6 + local_socket_inf0_outbo=
und_data_beats_ccm7 + local_socket_inf1_outbound_data_beats_ccm7",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "remote_socket_inbound_data_bytes_to_cpu",
> +    "BriefDescription": "Remote socket inbound data bytes to the CPU (e.=
g. read data).",
> +    "MetricExpr": "remote_socket_inf0_inbound_data_beats_ccm0 + remote_s=
ocket_inf1_inbound_data_beats_ccm0 + remote_socket_inf0_inbound_data_beats_=
ccm1 + remote_socket_inf1_inbound_data_beats_ccm1 + remote_socket_inf0_inbo=
und_data_beats_ccm2 + remote_socket_inf1_inbound_data_beats_ccm2 + remote_s=
ocket_inf0_inbound_data_beats_ccm3 + remote_socket_inf1_inbound_data_beats_=
ccm3 + remote_socket_inf0_inbound_data_beats_ccm4 + remote_socket_inf1_inbo=
und_data_beats_ccm4 + remote_socket_inf0_inbound_data_beats_ccm5 + remote_s=
ocket_inf1_inbound_data_beats_ccm5 + remote_socket_inf0_inbound_data_beats_=
ccm6 + remote_socket_inf1_inbound_data_beats_ccm6 + remote_socket_inf0_inbo=
und_data_beats_ccm7 + remote_socket_inf1_inbound_data_beats_ccm7",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "3.0517578125e-5MiB"
> +  },
> +  {
> +    "MetricName": "remote_socket_outbound_data_bytes_from_cpu",
> +    "BriefDescription": "Remote socket outbound data bytes from the CPU =
(e.g. write data).",
> +    "MetricExpr": "remote_socket_inf0_outbound_data_beats_ccm0 + remote_=
socket_inf1_outbound_data_beats_ccm0 + remote_socket_inf0_outbound_data_bea=
ts_ccm1 + remote_socket_inf1_outbound_data_beats_ccm1 + remote_socket_inf0_=
outbound_data_beats_ccm2 + remote_socket_inf1_outbound_data_beats_ccm2 + re=
mote_socket_inf0_outbound_data_beats_ccm3 + remote_socket_inf1_outbound_dat=
a_beats_ccm3 + remote_socket_inf0_outbound_data_beats_ccm4 + remote_socket_=
inf1_outbound_data_beats_ccm4 + remote_socket_inf0_outbound_data_beats_ccm5=
 + remote_socket_inf1_outbound_data_beats_ccm5 + remote_socket_inf0_outboun=
d_data_beats_ccm6 + remote_socket_inf1_outbound_data_beats_ccm6 + remote_so=
cket_inf0_outbound_data_beats_ccm7 + remote_socket_inf1_outbound_data_beats=
_ccm7",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "local_socket_outbound_data_bytes_from_all_links",
> +    "BriefDescription": "Outbound data bytes from all links (local socke=
t).",
> +    "MetricExpr": "local_socket_outbound_data_beats_link0 + local_socket=
_outbound_data_beats_link1 + local_socket_outbound_data_beats_link2 + local=
_socket_outbound_data_beats_link3 + local_socket_outbound_data_beats_link4 =
+ local_socket_outbound_data_beats_link5 + local_socket_outbound_data_beats=
_link6 + local_socket_outbound_data_beats_link7",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.103515625e-5MiB"
> +  }
> +]
> --
> 2.34.1
>
