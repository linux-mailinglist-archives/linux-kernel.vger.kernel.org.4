Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FD474FC7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGLBFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjGLBFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:05:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AE5170E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:04:53 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40371070eb7so84821cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689123892; x=1691715892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/059FfCH0EmoBEDbU/cU2PZjQH7sjhtwTjXzIB0Gwg=;
        b=Ju93j28ZMGUftBoTIu5zQLJ4zRxv4BsLGvXlobLTg0CZ+uRq7VnC3lGq43yl2YcGIX
         bAwWF2yry5Rn4ZARXcjZWsjYbzjqT1VvOs1KAInoIKR5/W8njc2hs6IYEFWv2E52KxbO
         eV9Rkac6wwk1+2sveepKULt0ZiHTWmKeZBmzSUM75gv5f6cN+NhCrwB06rowTPXnqi7X
         4aFF68Hjrdou7MeRsGGMDrzZAJhog9tbd/1MT6V+KrPZAMPS3eg8g4Re6XnDqU/wiSpG
         3i11B73HI6rRJ9sjJCj4KHZ08ejEniCD5IoZYML3prNlqu3TiQYfP9nNKqc+XRPaH2gG
         FiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689123892; x=1691715892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/059FfCH0EmoBEDbU/cU2PZjQH7sjhtwTjXzIB0Gwg=;
        b=ZyRp7bz8Z3Lx4XByxlV4QnTEwQMkq42RJkaEqq985NG5S4oR3Ga4xXHcKFLrWAdZnZ
         R5LQjIdE903HS814sYJ7EWX5v9pDC9nMYJ5D+Kq20icuDKBDLQlZ5IilW3PVblsJ1Q5R
         +ccTdwmRLB9ImGZ1bV7dzS+bx/vJ44i6FewH8hZEWyToJyWIYtMauqRUrQ/wPQY3ZkIk
         jQv7F7i3XCloHFNcW/l1vFbi83/XVH6jSkK6pZcEersJWtf9V/J0zZMMJ/uwdyAWXObM
         edQ6U6ACRfWnFnadiyryt88Y4PfAbk7RsfPs6WtVTDQoP+0uK81+Z7EsBkoHFe6zlXyZ
         Dgxg==
X-Gm-Message-State: ABy/qLZBs4Tz/UTIUDNfVApS9yZTynH6cdmTMT5dp7blp7l+Y2YvX88P
        HHi6Qw2Bl3HZa9SzS/Li2xLqoX2qGEoKttbP6u8n3g==
X-Google-Smtp-Source: APBJJlE/YOXzIw5ayL8ROL2GBytmEAmtkdUqAGjQS3D1gjLTFrqT8KA33lUFnFM71RpAit9CT8Id6IuXVirVzqkV5Jc=
X-Received: by 2002:ac8:5a8b:0:b0:3f8:5b2:aef2 with SMTP id
 c11-20020ac85a8b000000b003f805b2aef2mr115279qtc.26.1689123890967; Tue, 11 Jul
 2023 18:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230711100218.1651995-1-james.clark@arm.com> <20230711100218.1651995-5-james.clark@arm.com>
In-Reply-To: <20230711100218.1651995-5-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 11 Jul 2023 18:04:38 -0700
Message-ID: <CAP-5=fVPriUQZN+OzDOVnMMe0y9QzRHuaBMgrCcSvbE+3ME=Lg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] perf vendor events arm64: Update N2-r0p3 and V2
 metrics and events using Arm telemetry repo
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        john.g.garry@oracle.com, namhyung@kernel.org, acme@kernel.org,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 3:03=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> The new metrics contain a fix for N2 r0p3 where CPU_CYCLES should not be
> subtracted from stalls for topdown metrics anymore. The current metrics
> assume that the fix should be applied anywhere where slots !=3D 5, but
> this is only the case for V2 and not N2 r0p3.
>
> Split the metrics into a new version for N2-r0p3 and V2 which still
> share the same metrics. Apart from some slight naming and grouping
> differences the new metrics are functionally the same as the existing
> ones. Any missing metrics were manually appended to the end of the auto
> generated file.
>
> For the events, the new data includes descriptions that may have product
> specific details and new groupings that will be consistent with other
> products.
>
> After generating the metrics from the telemetry repo [1], the following
> manual steps were performed:
>
>  * Change the hard coded slots in neoverse-n2r0p3-v2 to #slots so that
>    it will work on both N2 and V2.
>
>  * Append some metrics from the old N2/V2 data that aren't present in
>    the telemetry data. These will possibly be added to the
>    telemetry-solution repo at a later time:
>
>     l3d_cache_mpki, l3d_cache_miss_rate, branch_pki, ipc_rate, spec_ipc,
>     retired_rate, wasted_rate, load_spec_rate, store_spec_rate,
>     advanced_simd_spec_rate, float_point_spec_rate,
>     branch_immed_spec_rate, branch_return_spec_rate,
>     branch_indirect_spec_rate
>
> [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/=
main/data/pmu/cpu/neoverse/neoverse-n2.json
>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  .../arm64/arm/neoverse-n2r0p3-v2/bus.json     |  18 +
>  .../arm/neoverse-n2r0p3-v2/exception.json     |  62 ++++
>  .../arm/neoverse-n2r0p3-v2/fp_operation.json  |  22 ++
>  .../arm64/arm/neoverse-n2r0p3-v2/general.json |  10 +
>  .../arm/neoverse-n2r0p3-v2/l1d_cache.json     |  54 +++
>  .../arm/neoverse-n2r0p3-v2/l1i_cache.json     |  14 +
>  .../arm/neoverse-n2r0p3-v2/l2_cache.json      |  50 +++
>  .../arm/neoverse-n2r0p3-v2/l3_cache.json      |  22 ++
>  .../arm/neoverse-n2r0p3-v2/ll_cache.json      |  10 +
>  .../arm64/arm/neoverse-n2r0p3-v2/memory.json  |  46 +++
>  .../arm64/arm/neoverse-n2r0p3-v2/metrics.json | 331 ++++++++++++++++++
>  .../arm64/arm/neoverse-n2r0p3-v2/retired.json |  30 ++
>  .../arm64/arm/neoverse-n2r0p3-v2/spe.json     |  18 +
>  .../neoverse-n2r0p3-v2/spec_operation.json    | 110 ++++++
>  .../arm64/arm/neoverse-n2r0p3-v2/stall.json   |  30 ++
>  .../arm64/arm/neoverse-n2r0p3-v2/sve.json     |  50 +++
>  .../arm64/arm/neoverse-n2r0p3-v2/tlb.json     |  66 ++++
>  .../arm64/arm/neoverse-n2r0p3-v2/trace.json   |  38 ++
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   3 +-
>  19 files changed, 983 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/fp_operation.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/general.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/l1d_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/l1i_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/l2_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/l3_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/ll_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/retired.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/spe.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/spec_operation.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/stall.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/sve.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/tlb.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-=
v2/trace.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/bus.=
json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/bus.json
> new file mode 100644
> index 000000000000..2e11a8c4a484
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/bus.json
> @@ -0,0 +1,18 @@
> +[
> +    {
> +        "ArchStdEvent": "BUS_ACCESS",
> +        "PublicDescription": "Counts memory transactions issued by the C=
PU to the external bus, including snoop requests and snoop responses. Each =
beat of data is counted individually."

It might be nice to add "beat" to the glossary:
https://perf.wiki.kernel.org/index.php/Glossary

> +    },
> +    {
> +        "ArchStdEvent": "BUS_CYCLES",
> +        "PublicDescription": "Counts bus cycles in the CPU. Bus cycles r=
epresent a clock cycle in which a transaction could be sent or received on =
the interface from the CPU to the external bus. Since that interface is dri=
ven at the same clock speed as the CPU, this event is a duplicate of CPU_CY=
CLES."
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_RD",
> +        "PublicDescription": "Counts memory read transactions seen on th=
e external bus. Each beat of data is counted individually."
> +    },
> +    {
> +        "ArchStdEvent": "BUS_ACCESS_WR",
> +        "PublicDescription": "Counts memory write transactions seen on t=
he external bus. Each beat of data is counted individually."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/exce=
ption.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/except=
ion.json
> new file mode 100644
> index 000000000000..4404b8e91690
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/exception.j=
son
> @@ -0,0 +1,62 @@
> +[
> +    {
> +        "ArchStdEvent": "EXC_TAKEN",
> +        "PublicDescription": "Counts any taken architecturally visible e=
xceptions such as IRQ, FIQ, SError, and other synchronous exceptions. Excep=
tions are counted whether or not they are taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_RETURN",
> +        "PublicDescription": "Counts any architecturally executed except=
ion return instructions. Eg: AArch64: ERET"
> +    },
> +    {
> +        "ArchStdEvent": "EXC_UNDEF",
> +        "PublicDescription": "Counts the number of synchronous exception=
s which are taken locally that are due to attempting to execute an instruct=
ion that is UNDEFINED. Attempting to execute instruction bit patterns that =
have not been allocated. Attempting to execute instructions when they are d=
isabled. Attempting to execute instructions at an inappropriate Exception l=
evel. Attempting to execute an instruction when the value of PSTATE.IL is 1=
."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_SVC",
> +        "PublicDescription": "Counts SVC exceptions taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_PABORT",
> +        "PublicDescription": "Counts synchronous exceptions that are tak=
en locally and caused by Instruction Aborts."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_DABORT",
> +        "PublicDescription": "Counts exceptions that are taken locally a=
nd are caused by data aborts or SErrors. Conditions that could cause those =
exceptions are attempting to read or write memory where the MMU generates a=
 fault, attempting to read or write memory with a misaligned address, inter=
rupts from the nSEI inputs and internally generated SErrors."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_IRQ",
> +        "PublicDescription": "Counts IRQ exceptions including the virtua=
l IRQs that are taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_FIQ",
> +        "PublicDescription": "Counts FIQ exceptions including the virtua=
l FIQs that are taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_SMC",
> +        "PublicDescription": "Counts SMC exceptions take to EL3."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_HVC",
> +        "PublicDescription": "Counts HVC exceptions taken to EL2."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_PABORT",
> +        "PublicDescription": "Counts exceptions which are traps not take=
n locally and are caused by Instruction Aborts. For example, attempting to =
execute an instruction with a misaligned PC."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_DABORT",
> +        "PublicDescription": "Counts exceptions which are traps not take=
n locally and are caused by Data Aborts or SError interrupts. Conditions th=
at could cause those exceptions are:\n\n1. Attempting to read or write memo=
ry where the MMU generates a fault,\n2. Attempting to read or write memory =
with a misaligned address,\n3. Interrupts from the SEI input.\n4. internall=
y generated SErrors."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_OTHER",
> +        "PublicDescription": "Counts the number of synchronous trap exce=
ptions which are not taken locally and are not SVC, SMC, HVC, data aborts, =
Instruction Aborts, or interrupts."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_IRQ",
> +        "PublicDescription": "Counts IRQ exceptions including the virtua=
l IRQs that are not taken locally."
> +    },
> +    {
> +        "ArchStdEvent": "EXC_TRAP_FIQ",
> +        "PublicDescription": "Counts FIQs which are not taken locally bu=
t taken from EL0, EL1,\n or EL2 to EL3 (which would be the normal behavior =
for FIQs when not executing\n in EL3)."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/fp_o=
peration.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/fp_=
operation.json
> new file mode 100644
> index 000000000000..cec3435ac766
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/fp_operatio=
n.json
> @@ -0,0 +1,22 @@
> +[
> +    {
> +        "ArchStdEvent": "FP_HP_SPEC",
> +        "PublicDescription": "Counts speculatively executed half precisi=
on floating point operations."
> +    },
> +    {
> +        "ArchStdEvent": "FP_SP_SPEC",
> +        "PublicDescription": "Counts speculatively executed single preci=
sion floating point operations."
> +    },
> +    {
> +        "ArchStdEvent": "FP_DP_SPEC",
> +        "PublicDescription": "Counts speculatively executed double preci=
sion floating point operations."
> +    },
> +    {
> +        "ArchStdEvent": "FP_SCALE_OPS_SPEC",
> +        "PublicDescription": "Counts speculatively executed scalable sin=
gle precision floating point operations."
> +    },
> +    {
> +        "ArchStdEvent": "FP_FIXED_OPS_SPEC",
> +        "PublicDescription": "Counts speculatively executed non-scalable=
 single precision floating point operations."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/gene=
ral.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/general.=
json
> new file mode 100644
> index 000000000000..428810f855b8
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/general.jso=
n
> @@ -0,0 +1,10 @@
> +[
> +    {
> +        "ArchStdEvent": "CPU_CYCLES",
> +        "PublicDescription": "Counts CPU clock cycles (not timer cycles)=
. The clock measured by this event is defined as the physical clock driving=
 the CPU logic."
> +    },
> +    {
> +        "ArchStdEvent": "CNT_CYCLES",
> +        "PublicDescription": "Counts constant frequency cycles"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1d_=
cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1d_ca=
che.json
> new file mode 100644
> index 000000000000..ed83e1c5affe
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1d_cache.j=
son
> @@ -0,0 +1,54 @@
> +[
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL",
> +        "PublicDescription": "Counts level 1 data cache refills caused b=
y speculatively executed load or store operations that missed in the level =
1 data cache. This event only counts one event per cache line. This event d=
oes not count cache line allocations from preload instructions or from hard=
ware cache prefetching."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE",
> +        "PublicDescription": "Counts level 1 data cache accesses from an=
y load/store operations. Atomic operations that resolve in the CPUs caches =
(near atomic operations) counts as both a write access and read access. Eac=
h access to a cache line is counted including the multiple accesses caused =
by single instructions such as LDM or STM. Each access to other level 1 dat=
a or unified memory structures, for example refill buffers, write buffers, =
and write-back buffers, are also counted."

nit: "counts as both" should be "count as both"

> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB",
> +        "PublicDescription": "Counts write-backs of dirty data from the =
L1 data cache to the L2 cache. This occurs when either a dirty cache line i=
s evicted from L1 data cache and allocated in the L2 cache or dirty data is=
 written to the L2 and possibly to the next level of cache. This event coun=
ts both victim cache line evictions and cache write-backs from snoops or ca=
che maintenance operations. The following cache operations are not counted:=
\n\n1. Invalidations which do not result in data being transferred out of t=
he L1 (such as evictions of clean data),\n2. Full line writes which write t=
o L2 without writing L1, such as write streaming mode."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_LMISS_RD",
> +        "PublicDescription": "Counts cache line refills into the level 1=
 data cache from any memory read operations, that incurred additional laten=
cy."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_RD",
> +        "PublicDescription": "Counts level 1 data cache accesses from an=
y load operation. Atomic load operations that resolve in the CPUs caches co=
unts as both a write access and read access."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WR",
> +        "PublicDescription": "Counts level 1 data cache accesses generat=
ed by store operations. This event also counts accesses caused by a DC ZVA =
(data cache zero, specified by virtual address) instruction. Near atomic op=
erations that resolve in the CPUs caches count as a write access and read a=
ccess."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
> +        "PublicDescription": "Counts level 1 data cache refills caused b=
y speculatively executed load instructions where the memory read operation =
misses in the level 1 data cache. This event only counts one event per cach=
e line."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
> +        "PublicDescription": "Counts level 1 data cache refills caused b=
y speculatively executed store instructions where the memory write operatio=
n misses in the level 1 data cache. This event only counts one event per ca=
che line."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
> +        "PublicDescription": "Counts level 1 data cache refills where th=
e cache line data came from caches inside the immediate cluster of the core=
."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
> +        "PublicDescription": "Counts level 1 data cache refills for whic=
h the cache line data came from outside the immediate cluster of the core, =
like an SLC in the system interconnect or DRAM."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
> +        "PublicDescription": "Counts dirty cache line evictions from the=
 level 1 data cache caused by a new cache line allocation. This event does =
not count evictions caused by cache maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
> +        "PublicDescription": "Counts write-backs from the level 1 data c=
ache that are a result of a coherency operation made by another CPU. Event =
count includes cache maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_CACHE_INVAL",
> +        "PublicDescription": "Counts each explicit invalidation of a cac=
he line in the level 1 data cache caused by:\n\n- Cache Maintenance Operati=
ons (CMO) that operate by a virtual address.\n- Broadcast cache coherency o=
perations from another CPU in the system.\n\nThis event does not count for =
the following conditions:\n\n1. A cache refill invalidates a cache line.\n2=
. A CMO which is executed on that CPU and invalidates a cache line specifie=
d by set/way.\n\nNote that CMOs that operate by set/way cannot be broadcast=
 from one CPU to another."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1i_=
cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1i_ca=
che.json
> new file mode 100644
> index 000000000000..633f1030359d
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l1i_cache.j=
son
> @@ -0,0 +1,14 @@
> +[
> +    {
> +        "ArchStdEvent": "L1I_CACHE_REFILL",
> +        "PublicDescription": "Counts cache line refills in the level 1 i=
nstruction cache caused by a missed instruction fetch. Instruction fetches =
may include accessing multiple instructions, but the single cache line allo=
cation is counted once."
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE",
> +        "PublicDescription": "Counts instruction fetches which access th=
e level 1 instruction cache. Instruction cache accesses caused by cache mai=
ntenance operations are not counted."
> +    },
> +    {
> +        "ArchStdEvent": "L1I_CACHE_LMISS",
> +        "PublicDescription": "Counts cache line refills into the level 1=
 instruction cache, that incurred additional latency."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l2_c=
ache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l2_cach=
e.json
> new file mode 100644
> index 000000000000..0e31d0daf88b
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l2_cache.js=
on
> @@ -0,0 +1,50 @@
> +[
> +    {
> +        "ArchStdEvent": "L2D_CACHE",
> +        "PublicDescription": "Counts level 2 cache accesses. level 2 cac=
he is a unified cache for data and instruction accesses. Accesses are for m=
isses in the first level caches or translation resolutions due to accesses.=
 This event also counts write back of dirty data from level 1 data cache to=
 the L2 cache."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL",
> +        "PublicDescription": "Counts cache line refills into the level 2=
 cache. level 2 cache is a unified cache for data and instruction accesses.=
 Accesses are for misses in the level 1 caches or translation resolutions d=
ue to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB",
> +        "PublicDescription": "Counts write-backs of data from the L2 cac=
he to outside the CPU. This includes snoops to the L2 (from other CPUs) whi=
ch return data even if the snoops cause an invalidation. L2 cache line inva=
lidations which do not write data outside the CPU and snoops which return d=
ata from an L1 cache are not counted. Data would not be written outside the=
 cache when invalidating a clean cache line."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_ALLOCATE",
> +        "PublicDescription": "TBD"
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_RD",
> +        "PublicDescription": "Counts level 2 cache accesses due to memor=
y read operations. level 2 cache is a unified cache for data and instructio=
n accesses, accesses are for misses in the level 1 caches or translation re=
solutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WR",
> +        "PublicDescription": "Counts level 2 cache accesses due to memor=
y write operations. level 2 cache is a unified cache for data and instructi=
on accesses, accesses are for misses in the level 1 caches or translation r=
esolutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
> +        "PublicDescription": "Counts refills for memory accesses due to =
memory read operation counted by L2D_CACHE_RD. level 2 cache is a unified c=
ache for data and instruction accesses, accesses are for misses in the leve=
l 1 caches or translation resolutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
> +        "PublicDescription": "Counts refills for memory accesses due to =
memory write operation counted by L2D_CACHE_WR. level 2 cache is a unified =
cache for data and instruction accesses, accesses are for misses in the lev=
el 1 caches or translation resolutions due to accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
> +        "PublicDescription": "Counts evictions from the level 2 cache be=
cause of a line being allocated into the L2 cache."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
> +        "PublicDescription": "Counts write-backs from the level 2 cache =
that are a result of either:\n\n1. Cache maintenance operations,\n\n2. Snoo=
p responses or,\n\n3. Direct cache transfers to another CPU due to a forwar=
ding snoop request."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_INVAL",
> +        "PublicDescription": "Counts each explicit invalidation of a cac=
he line in the level 2 cache by cache maintenance operations that operate b=
y a virtual address, or by external coherency operations. This event does n=
ot count if either:\n\n1. A cache refill invalidates a cache line or,\n2. A=
 Cache Maintenance Operation (CMO), which invalidates a cache line specifie=
d by set/way, is executed on that CPU.\n\nCMOs that operate by set/way cann=
ot be broadcast from one CPU to another."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_CACHE_LMISS_RD",
> +        "PublicDescription": "Counts cache line refills into the level 2=
 unified cache from any memory read operations that incurred additional lat=
ency."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l3_c=
ache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l3_cach=
e.json
> new file mode 100644
> index 000000000000..45bfba532df7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/l3_cache.js=
on
> @@ -0,0 +1,22 @@
> +[
> +    {
> +        "ArchStdEvent": "L3D_CACHE_ALLOCATE",
> +        "PublicDescription": "Counts level 3 cache line allocates that d=
o not fetch data from outside the level 3 data or unified cache. For exampl=
e, allocates due to streaming stores."
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE_REFILL",
> +        "PublicDescription": "Counts level 3 accesses that receive data =
from outside the L3 cache."
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE",
> +        "PublicDescription": "Counts level 3 cache accesses. level 3 cac=
he is a unified cache for data and instruction accesses. Accesses are for m=
isses in the lower level caches or translation resolutions due to accesses.=
"
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE_RD",
> +        "PublicDescription": "TBD"
> +    },
> +    {
> +        "ArchStdEvent": "L3D_CACHE_LMISS_RD",
> +        "PublicDescription": "Counts any cache line refill into the leve=
l 3 cache from memory read operations that incurred additional latency."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/ll_c=
ache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/ll_cach=
e.json
> new file mode 100644
> index 000000000000..bb712d57d58a
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/ll_cache.js=
on
> @@ -0,0 +1,10 @@
> +[
> +    {
> +        "ArchStdEvent": "LL_CACHE_RD",
> +        "PublicDescription": "Counts read transactions that were returne=
d from outside the core cluster. This event counts when the system register=
 CPUECTLR.EXTLLC bit is set. This event counts read transactions returned f=
rom outside the core if those transactions are either hit in the system lev=
el cache or missed in the SLC and are returned from any other external sour=
ces."
> +    },
> +    {
> +        "ArchStdEvent": "LL_CACHE_MISS_RD",
> +        "PublicDescription": "Counts read transactions that were returne=
d from outside the core cluster but missed in the system level cache. This =
event counts when the system register CPUECTLR.EXTLLC bit is set. This even=
t counts read transactions returned from outside the core if those transact=
ions are missed in the System level Cache. The data source of the transacti=
on is indicated by a field in the CHI transaction returning to the CPU. Thi=
s event does not count reads caused by cache maintenance operations."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/memo=
ry.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/memory.js=
on
> new file mode 100644
> index 000000000000..106a97f8b2e7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/memory.json
> @@ -0,0 +1,46 @@
> +[
> +    {
> +        "ArchStdEvent": "MEM_ACCESS",
> +        "PublicDescription": "Counts memory accesses issued by the CPU l=
oad store unit, where those accesses are issued due to load or store operat=
ions. This event counts memory accesses no matter whether the data is recei=
ved from any level of cache hierarchy or external memory. If memory accesse=
s are broken up into smaller transactions than what were specified in the l=
oad or store instructions, then the event counts those smaller memory trans=
actions."
> +    },
> +    {
> +        "ArchStdEvent": "MEMORY_ERROR",
> +        "PublicDescription": "Counts any detected correctable or uncorre=
ctable physical memory errors (ECC or parity) in protected CPUs RAMs. On th=
e core, this event counts errors in the caches (including data and tag rams=
). Any detected memory error (from either a speculative and abandoned acces=
s, or an architecturally executed access) is counted. Note that errors are =
only detected when the actual protected memory is accessed by an operation.=
"
> +    },
> +    {
> +        "ArchStdEvent": "REMOTE_ACCESS",
> +        "PublicDescription": "Counts accesses to another chip, which is =
implemented as a different CMN mesh in the system. If the CHI bus response =
back to the core indicates that the data source is from another chip (mesh)=
, then the counter is updated. If no data is returned, even if the system s=
noops another chip/mesh, then the counter is not updated."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_RD",
> +        "PublicDescription": "Counts memory accesses issued by the CPU d=
ue to load operations. The event counts any memory load access, no matter w=
hether the data is received from any level of cache hierarchy or external m=
emory. The event also counts atomic load operations. If memory accesses are=
 broken up by the load/store unit into smaller transactions that are issued=
 by the bus interface, then the event counts those smaller transactions."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_WR",
> +        "PublicDescription": "Counts memory accesses issued by the CPU d=
ue to store operations. The event counts any memory store access, no matter=
 whether the data is located in any level of cache or external memory. The =
event also counts atomic load and store operations. If memory accesses are =
broken up by the load/store unit into smaller transactions that are issued =
by the bus interface, then the event counts those smaller transactions."
> +    },
> +    {
> +        "ArchStdEvent": "LDST_ALIGN_LAT",
> +        "PublicDescription": "Counts the number of memory read and write=
 accesses in a cycle that incurred additional latency, due to the alignment=
 of the address and the size of data being accessed, which results in store=
 crossing a single cache line."
> +    },
> +    {
> +        "ArchStdEvent": "LD_ALIGN_LAT",
> +        "PublicDescription": "Counts the number of memory read accesses =
in a cycle that incurred additional latency, due to the alignment of the ad=
dress and size of data being accessed, which results in load crossing a sin=
gle cache line."
> +    },
> +    {
> +        "ArchStdEvent": "ST_ALIGN_LAT",
> +        "PublicDescription": "Counts the number of memory write access i=
n a cycle that incurred additional latency, due to the alignment of the add=
ress and size of data being accessed incurred additional latency."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_CHECKED",
> +        "PublicDescription": "Counts the number of memory read and write=
 accesses in a cycle that are tag checked by the Memory Tagging Extension (=
MTE)."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_CHECKED_RD",
> +        "PublicDescription": "Counts the number of memory read accesses =
in a cycle that are tag checked by the Memory Tagging Extension (MTE)."
> +    },
> +    {
> +        "ArchStdEvent": "MEM_ACCESS_CHECKED_WR",
> +        "PublicDescription": "Counts the number of memory write accesses=
 in a cycle that is tag checked by the Memory Tagging Extension (MTE)."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metr=
ics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.=
json
> new file mode 100644
> index 000000000000..b01cc2120175
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.jso=
n
> @@ -0,0 +1,331 @@
> +[
> +    {
> +        "ArchStdEvent": "backend_bound",
> +        "MetricExpr": "(100 * ((STALL_SLOT_BACKEND / (CPU_CYCLES * #slot=
s)) - ((BR_MIS_PRED * 3) / CPU_CYCLES)))"
> +    },
> +    {
> +        "MetricName": "backend_stalled_cycles",
> +        "MetricExpr": "((STALL_BACKEND / CPU_CYCLES) * 100)",
> +        "BriefDescription": "This metric is the percentage of cycles tha=
t were stalled due to resource constraints in the backend unit of the proce=
ssor.",

nit: here and below saying "This metric" is somewhat redundant.

> +        "MetricGroup": "Cycle_Accounting",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "ArchStdEvent": "bad_speculation",
> +        "MetricExpr": "(100 * (((1 - (OP_RETIRED / OP_SPEC)) * (1 - (STA=
LL_SLOT / (CPU_CYCLES * #slots)))) + ((BR_MIS_PRED * 4) / CPU_CYCLES)))"
> +    },
> +    {
> +        "MetricName": "branch_misprediction_ratio",
> +        "MetricExpr": "(BR_MIS_PRED_RETIRED / BR_RETIRED)",
> +        "BriefDescription": "This metric measures the ratio of branches =
mispredicted to the total number of branches architecturally executed. This=
 gives an indication of the effectiveness of the branch prediction unit.",
> +        "MetricGroup": "Miss_Ratio;Branch_Effectiveness",
> +        "ScaleUnit": "1per branch"
> +    },
> +    {
> +        "MetricName": "branch_mpki",
> +        "MetricExpr": "((BR_MIS_PRED_RETIRED / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of branch m=
ispredictions per thousand instructions executed.",
> +        "MetricGroup": "MPKI;Branch_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "branch_percentage",
> +        "MetricExpr": "(((BR_IMMED_SPEC + BR_INDIRECT_SPEC) / INST_SPEC)=
 * 100)",
> +        "BriefDescription": "This metric measures branch operations as a=
 percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "crypto_percentage",
> +        "MetricExpr": "((CRYPTO_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures crypto operations as a=
 percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "dtlb_mpki",
> +        "MetricExpr": "((DTLB_WALK / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of data TLB=
 Walks per thousand instructions executed.",
> +        "MetricGroup": "MPKI;DTLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "dtlb_walk_ratio",
> +        "MetricExpr": "(DTLB_WALK / L1D_TLB)",
> +        "BriefDescription": "This metric measures the ratio of data TLB =
Walks to the total number of data TLB accesses. This gives an indication of=
 the effectiveness of the data TLB accesses.",
> +        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
> +        "ScaleUnit": "1per TLB access"
> +    },
> +    {
> +        "ArchStdEvent": "frontend_bound",
> +        "MetricExpr": "(100 * ((STALL_SLOT_FRONTEND / (CPU_CYCLES * #slo=
ts)) - (BR_MIS_PRED / CPU_CYCLES)))"
> +    },
> +    {
> +        "MetricName": "frontend_stalled_cycles",
> +        "MetricExpr": "((STALL_FRONTEND / CPU_CYCLES) * 100)",
> +        "BriefDescription": "This metric is the percentage of cycles tha=
t were stalled due to resource constraints in the frontend unit of the proc=
essor.",
> +        "MetricGroup": "Cycle_Accounting",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "MetricName": "integer_dp_percentage",
> +        "MetricExpr": "((DP_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures scalar integer operati=
ons as a percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "ipc",
> +        "MetricExpr": "(INST_RETIRED / CPU_CYCLES)",
> +        "BriefDescription": "This metric measures the number of instruct=
ions retired per cycle.",
> +        "MetricGroup": "General",
> +        "ScaleUnit": "1per cycle"
> +    },
> +    {
> +        "MetricName": "itlb_mpki",
> +        "MetricExpr": "((ITLB_WALK / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of instruct=
ion TLB Walks per thousand instructions executed.",
> +        "MetricGroup": "MPKI;ITLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "itlb_walk_ratio",
> +        "MetricExpr": "(ITLB_WALK / L1I_TLB)",
> +        "BriefDescription": "This metric measures the ratio of instructi=
on TLB Walks to the total number of instruction TLB accesses. This gives an=
 indication of the effectiveness of the instruction TLB accesses.",
> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
> +        "ScaleUnit": "1per TLB access"
> +    },
> +    {
> +        "MetricName": "l1d_cache_miss_ratio",
> +        "MetricExpr": "(L1D_CACHE_REFILL / L1D_CACHE)",
> +        "BriefDescription": "This metric measures the ratio of level 1 d=
ata cache accesses missed to the total number of level 1 data cache accesse=
s. This gives an indication of the effectiveness of the level 1 data cache.=
",
> +        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
> +    },
> +    {
> +        "MetricName": "l1d_cache_mpki",
> +        "MetricExpr": "((L1D_CACHE_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 1 =
data cache accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;L1D_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l1d_tlb_miss_ratio",
> +        "MetricExpr": "(L1D_TLB_REFILL / L1D_TLB)",
> +        "BriefDescription": "This metric measures the ratio of level 1 d=
ata TLB accesses missed to the total number of level 1 data TLB accesses. T=
his gives an indication of the effectiveness of the level 1 data TLB.",
> +        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
> +        "ScaleUnit": "1per TLB access"
> +    },
> +    {
> +        "MetricName": "l1d_tlb_mpki",
> +        "MetricExpr": "((L1D_TLB_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 1 =
instruction TLB accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;DTLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l1i_cache_miss_ratio",
> +        "MetricExpr": "(L1I_CACHE_REFILL / L1I_CACHE)",
> +        "BriefDescription": "This metric measures the ratio of level 1 i=
nstruction cache accesses missed to the total number of level 1 instruction=
 cache accesses. This gives an indication of the effectiveness of the level=
 1 instruction cache.",
> +        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
> +    },
> +    {
> +        "MetricName": "l1i_cache_mpki",
> +        "MetricExpr": "((L1I_CACHE_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 1 =
instruction cache accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;L1I_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l1i_tlb_miss_ratio",
> +        "MetricExpr": "(L1I_TLB_REFILL / L1I_TLB)",
> +        "BriefDescription": "This metric measures the ratio of level 1 i=
nstruction TLB accesses missed to the total number of level 1 instruction T=
LB accesses. This gives an indication of the effectiveness of the level 1 i=
nstruction TLB.",
> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
> +        "ScaleUnit": "1per TLB access"
> +    },
> +    {
> +        "MetricName": "l1i_tlb_mpki",
> +        "MetricExpr": "((L1I_TLB_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 1 =
instruction TLB accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;ITLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l2_cache_miss_ratio",
> +        "MetricExpr": "(L2D_CACHE_REFILL / L2D_CACHE)",
> +        "BriefDescription": "This metric measures the ratio of level 2 c=
ache accesses missed to the total number of level 2 cache accesses. This gi=
ves an indication of the effectiveness of the level 2 cache, which is a uni=
fied cache that stores both data and instruction. Note that cache accesses =
in this cache are either data memory access or instruction fetch as this is=
 a unified cache.",
> +        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
> +    },
> +    {
> +        "MetricName": "l2_cache_mpki",
> +        "MetricExpr": "((L2D_CACHE_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 2 =
unified cache accesses missed per thousand instructions executed. Note that=
 cache accesses in this cache are either data memory access or instruction =
fetch as this is a unified cache.",
> +        "MetricGroup": "MPKI;L2_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "l2_tlb_miss_ratio",
> +        "MetricExpr": "(L2D_TLB_REFILL / L2D_TLB)",
> +        "BriefDescription": "This metric measures the ratio of level 2 u=
nified TLB accesses missed to the total number of level 2 unified TLB acces=
ses. This gives an indication of the effectiveness of the level 2 TLB.",
> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness;DTLB_Effectiveness=
",
> +        "ScaleUnit": "1per TLB access"
> +    },
> +    {
> +        "MetricName": "l2_tlb_mpki",
> +        "MetricExpr": "((L2D_TLB_REFILL / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of level 2 =
unified TLB accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;ITLB_Effectiveness;DTLB_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "ll_cache_read_hit_ratio",
> +        "MetricExpr": "((LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD)"=
,
> +        "BriefDescription": "This metric measures the ratio of last leve=
l cache read accesses hit in the cache to the total number of last level ca=
che accesses. This gives an indication of the effectiveness of the last lev=
el cache for read traffic. Note that cache accesses in this cache are eithe=
r data memory access or instruction fetch as this is a system level cache."=
,
> +        "MetricGroup": "LL_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
> +    },
> +    {
> +        "MetricName": "ll_cache_read_miss_ratio",
> +        "MetricExpr": "(LL_CACHE_MISS_RD / LL_CACHE_RD)",
> +        "BriefDescription": "This metric measures the ratio of last leve=
l cache read accesses missed to the total number of last level cache access=
es. This gives an indication of the effectiveness of the last level cache f=
or read traffic. Note that cache accesses in this cache are either data mem=
ory access or instruction fetch as this is a system level cache.",
> +        "MetricGroup": "Miss_Ratio;LL_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
> +    },
> +    {
> +        "MetricName": "ll_cache_read_mpki",
> +        "MetricExpr": "((LL_CACHE_MISS_RD / INST_RETIRED) * 1000)",
> +        "BriefDescription": "This metric measures the number of last lev=
el cache read accesses missed per thousand instructions executed.",
> +        "MetricGroup": "MPKI;LL_Cache_Effectiveness",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricName": "load_percentage",
> +        "MetricExpr": "((LD_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures load operations as a p=
ercentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "ArchStdEvent": "retiring"
> +    },
> +    {
> +        "MetricName": "scalar_fp_percentage",
> +        "MetricExpr": "((VFP_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures scalar floating point =
operations as a percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "simd_percentage",
> +        "MetricExpr": "((ASE_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures advanced SIMD operatio=
ns as a percentage of total operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricName": "store_percentage",
> +        "MetricExpr": "((ST_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures store operations as a =
percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
> +    },
> +    {
> +        "MetricExpr": "L3D_CACHE_REFILL / INST_RETIRED * 1000",
> +        "BriefDescription": "The rate of L3 D-Cache misses per kilo inst=
ructions",
> +        "MetricGroup": "MPKI;L3_Cache_Effectiveness",
> +        "MetricName": "l3d_cache_mpki",
> +        "ScaleUnit": "1MPKI"
> +    },
> +    {
> +        "MetricExpr": "L3D_CACHE_REFILL / L3D_CACHE",
> +        "BriefDescription": "The rate of L3 D-Cache misses to the overal=
l L3 D-Cache",
> +        "MetricGroup": "Miss_Ratio;L3_Cache_Effectiveness",
> +        "MetricName": "l3d_cache_miss_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "BR_RETIRED / INST_RETIRED * 1000",
> +        "BriefDescription": "The rate of branches retired per kilo instr=
uctions",
> +        "MetricGroup": "MPKI;Branch_Effectiveness",
> +        "MetricName": "branch_pki",
> +        "ScaleUnit": "1PKI"
> +    },
> +    {
> +        "MetricExpr": "ipc / #slots",
> +        "BriefDescription": "IPC percentage of peak. The peak of IPC is =
the number of slots.",
> +        "MetricGroup": "General",
> +        "MetricName": "ipc_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "INST_SPEC / CPU_CYCLES",
> +        "BriefDescription": "Speculatively executed Instructions Per Cyc=
le (IPC)",
> +        "MetricGroup": "General",
> +        "MetricName": "spec_ipc"
> +    },
> +    {
> +        "MetricExpr": "OP_RETIRED / OP_SPEC",
> +        "BriefDescription": "Of all the micro-operations issued, what pe=
rcentage are retired(committed)",
> +        "MetricGroup": "General",
> +        "MetricName": "retired_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
> +        "BriefDescription": "Of all the micro-operations issued, what pe=
rcentage are not retired(committed)",
> +        "MetricGroup": "General",
> +        "MetricName": "wasted_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "LD_SPEC / INST_SPEC",
> +        "BriefDescription": "The rate of load instructions speculatively=
 executed to overall instructions speclatively executed",

nit: here and below "speclatively" should be "speculatively"

Thanks,
Ian

> +        "MetricGroup": "Operation_Mix",
> +        "MetricName": "load_spec_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "ST_SPEC / INST_SPEC",
> +        "BriefDescription": "The rate of store instructions speculativel=
y executed to overall instructions speclatively executed",
> +        "MetricGroup": "Operation_Mix",
> +        "MetricName": "store_spec_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "ASE_SPEC / INST_SPEC",
> +        "BriefDescription": "The rate of advanced SIMD instructions spec=
ulatively executed to overall instructions speclatively executed",
> +        "MetricGroup": "Operation_Mix",
> +        "MetricName": "advanced_simd_spec_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "VFP_SPEC / INST_SPEC",
> +        "BriefDescription": "The rate of floating point instructions spe=
culatively executed to overall instructions speclatively executed",
> +        "MetricGroup": "Operation_Mix",
> +        "MetricName": "float_point_spec_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "BR_IMMED_SPEC / INST_SPEC",
> +        "BriefDescription": "The rate of branch immediate instructions s=
peculatively executed to overall instructions speclatively executed",
> +        "MetricGroup": "Operation_Mix",
> +        "MetricName": "branch_immed_spec_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "BR_RETURN_SPEC / INST_SPEC",
> +        "BriefDescription": "The rate of procedure return instructions s=
peculatively executed to overall instructions speclatively executed",
> +        "MetricGroup": "Operation_Mix",
> +        "MetricName": "branch_return_spec_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "BR_INDIRECT_SPEC / INST_SPEC",
> +        "BriefDescription": "The rate of indirect branch instructions sp=
eculatively executed to overall instructions speclatively executed",
> +        "MetricGroup": "Operation_Mix",
> +        "MetricName": "branch_indirect_spec_rate",
> +        "ScaleUnit": "100%"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/reti=
red.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/retired.=
json
> new file mode 100644
> index 000000000000..f297b049b62f
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/retired.jso=
n
> @@ -0,0 +1,30 @@
> +[
> +    {
> +        "ArchStdEvent": "SW_INCR",
> +        "PublicDescription": "Counts software writes to the PMSWINC_EL0 =
(software PMU increment) register. The PMSWINC_EL0 register is a manually u=
pdated counter for use by application software.\n\nThis event could be used=
 to measure any user program event, such as accesses to a particular data s=
tructure (by writing to the PMSWINC_EL0 register each time the data structu=
re is accessed).\n\nTo use the PMSWINC_EL0 register and event, developers m=
ust insert instructions that write to the PMSWINC_EL0 register into the sou=
rce code.\n\nSince the SW_INCR event records writes to the PMSWINC_EL0 regi=
ster, there is no need to do a read/increment/write sequence to the PMSWINC=
_EL0 register."
> +    },
> +    {
> +        "ArchStdEvent": "INST_RETIRED",
> +        "PublicDescription": "Counts instructions that have been archite=
cturally executed."
> +    },
> +    {
> +        "ArchStdEvent": "CID_WRITE_RETIRED",
> +        "PublicDescription": "Counts architecturally executed writes to =
the CONTEXTIDR register, which usually contain the kernel PID and can be ou=
tput with hardware trace."
> +    },
> +    {
> +        "ArchStdEvent": "TTBR_WRITE_RETIRED",
> +        "PublicDescription": "Counts architectural writes to TTBR0/1_EL1=
. If virtualization host extensions are enabled (by setting the HCR_EL2.E2H=
 bit to 1), then accesses to TTBR0/1_EL1 that are redirected to TTBR0/1_EL2=
, or accesses to TTBR0/1_EL12, are counted. TTBRn registers are typically u=
pdated when the kernel is swapping user-space threads or applications."
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETIRED",
> +        "PublicDescription": "Counts architecturally executed branches, =
whether the branch is taken or not. Instructions that explicitly write to t=
he PC are also counted."
> +    },
> +    {
> +        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
> +        "PublicDescription": "Counts branches counted by BR_RETIRED whic=
h were mispredicted and caused a pipeline flush."
> +    },
> +    {
> +        "ArchStdEvent": "OP_RETIRED",
> +        "PublicDescription": "Counts micro-operations that are architect=
urally executed. This is a count of number of micro-operations retired from=
 the commit queue in a single cycle."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spe.=
json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spe.json
> new file mode 100644
> index 000000000000..5de8b0f3a440
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spe.json
> @@ -0,0 +1,18 @@
> +[
> +    {
> +        "ArchStdEvent": "SAMPLE_POP",
> +        "PublicDescription": "Counts statistical profiling sample popula=
tion, the count of all operations that could be sampled but may or may not =
be chosen for sampling."
> +    },
> +    {
> +        "ArchStdEvent": "SAMPLE_FEED",
> +        "PublicDescription": "Counts statistical profiling samples taken=
 for sampling."
> +    },
> +    {
> +        "ArchStdEvent": "SAMPLE_FILTRATE",
> +        "PublicDescription": "Counts statistical profiling samples taken=
 which are not removed by filtering."
> +    },
> +    {
> +        "ArchStdEvent": "SAMPLE_COLLISION",
> +        "PublicDescription": "Counts statistical profiling samples that =
have collided with a previous sample and so therefore not taken."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spec=
_operation.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/s=
pec_operation.json
> new file mode 100644
> index 000000000000..1af961f8a6c8
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/spec_operat=
ion.json
> @@ -0,0 +1,110 @@
> +[
> +    {
> +        "ArchStdEvent": "BR_MIS_PRED",
> +        "PublicDescription": "Counts branches which are speculatively ex=
ecuted and mispredicted."
> +    },
> +    {
> +        "ArchStdEvent": "BR_PRED",
> +        "PublicDescription": "Counts branches speculatively executed and=
 were predicted right."
> +    },
> +    {
> +        "ArchStdEvent": "INST_SPEC",
> +        "PublicDescription": "Counts operations that have been speculati=
vely executed."
> +    },
> +    {
> +        "ArchStdEvent": "OP_SPEC",
> +        "PublicDescription": "Counts micro-operations speculatively exec=
uted. This is the count of the number of micro-operations dispatched in a c=
ycle."
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_LD_SPEC",
> +        "PublicDescription": "Counts unaligned memory read operations is=
sued by the CPU. This event counts unaligned accesses (as defined by the ac=
tual instruction), even if they are subsequently issued as multiple aligned=
 accesses. The event does not count preload operations (PLD, PLI)."
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_ST_SPEC",
> +        "PublicDescription": "Counts unaligned memory write operations i=
ssued by the CPU. This event counts unaligned accesses (as defined by the a=
ctual instruction), even if they are subsequently issued as multiple aligne=
d accesses."
> +    },
> +    {
> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
> +        "PublicDescription": "Counts unaligned memory operations issued =
by the CPU. This event counts unaligned accesses (as defined by the actual =
instruction), even if they are subsequently issued as multiple aligned acce=
sses."
> +    },
> +    {
> +        "ArchStdEvent": "LDREX_SPEC",
> +        "PublicDescription": "Counts Load-Exclusive operations that have=
 been speculatively executed. Eg: LDREX, LDX"
> +    },
> +    {
> +        "ArchStdEvent": "STREX_PASS_SPEC",
> +        "PublicDescription": "Counts store-exclusive operations that hav=
e been speculatively executed and have successfully completed the store ope=
ration."
> +    },
> +    {
> +        "ArchStdEvent": "STREX_FAIL_SPEC",
> +        "PublicDescription": "Counts store-exclusive operations that hav=
e been speculatively executed and have not successfully completed the store=
 operation."
> +    },
> +    {
> +        "ArchStdEvent": "STREX_SPEC",
> +        "PublicDescription": "Counts store-exclusive operations that hav=
e been speculatively executed."
> +    },
> +    {
> +        "ArchStdEvent": "LD_SPEC",
> +        "PublicDescription": "Counts speculatively executed load operati=
ons including Single Instruction Multiple Data (SIMD) load operations."
> +    },
> +    {
> +        "ArchStdEvent": "ST_SPEC",
> +        "PublicDescription": "Counts speculatively executed store operat=
ions including Single Instruction Multiple Data (SIMD) store operations."
> +    },
> +    {
> +        "ArchStdEvent": "DP_SPEC",
> +        "PublicDescription": "Counts speculatively executed logical or a=
rithmetic instructions such as MOV/MVN operations."
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D operations excluding load, store and move micro-operations that move data=
 to or from SIMD (vector) registers."
> +    },
> +    {
> +        "ArchStdEvent": "VFP_SPEC",
> +        "PublicDescription": "Counts speculatively executed floating poi=
nt operations. This event does not count operations that move data to or fr=
om floating point (vector) registers."
> +    },
> +    {
> +        "ArchStdEvent": "PC_WRITE_SPEC",
> +        "PublicDescription": "Counts speculatively executed operations w=
hich cause software changes of the PC. Those operations include all taken b=
ranch operations."
> +    },
> +    {
> +        "ArchStdEvent": "CRYPTO_SPEC",
> +        "PublicDescription": "Counts speculatively executed cryptographi=
c operations except for PMULL and VMULL operations."
> +    },
> +    {
> +        "ArchStdEvent": "BR_IMMED_SPEC",
> +        "PublicDescription": "Counts immediate branch operations which a=
re speculatively executed."
> +    },
> +    {
> +        "ArchStdEvent": "BR_RETURN_SPEC",
> +        "PublicDescription": "Counts procedure return operations (RET) w=
hich are speculatively executed."
> +    },
> +    {
> +        "ArchStdEvent": "BR_INDIRECT_SPEC",
> +        "PublicDescription": "Counts indirect branch operations includin=
g procedure returns, which are speculatively executed. This includes operat=
ions that force a software change of the PC, other than exception-generatin=
g operations.  Eg: BR Xn, RET"
> +    },
> +    {
> +        "ArchStdEvent": "ISB_SPEC",
> +        "PublicDescription": "Counts ISB operations that are executed."
> +    },
> +    {
> +        "ArchStdEvent": "DSB_SPEC",
> +        "PublicDescription": "Counts DSB operations that are speculative=
ly issued to Load/Store unit in the CPU."
> +    },
> +    {
> +        "ArchStdEvent": "DMB_SPEC",
> +        "PublicDescription": "Counts DMB operations that are speculative=
ly issued to the Load/Store unit in the CPU. This event does not count impl=
ied barriers from load acquire/store release operations."
> +    },
> +    {
> +        "ArchStdEvent": "RC_LD_SPEC",
> +        "PublicDescription": "Counts any load acquire operations that ar=
e speculatively executed. Eg: LDAR, LDARH, LDARB"
> +    },
> +    {
> +        "ArchStdEvent": "RC_ST_SPEC",
> +        "PublicDescription": "Counts any store release operations that a=
re speculatively executed. Eg: STLR, STLRH, STLRB'"
> +    },
> +    {
> +        "ArchStdEvent": "ASE_INST_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D operations."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/stal=
l.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/stall.json
> new file mode 100644
> index 000000000000..bbbebc805034
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/stall.json
> @@ -0,0 +1,30 @@
> +[
> +    {
> +        "ArchStdEvent": "STALL_FRONTEND",
> +        "PublicDescription": "Counts cycles when frontend could not send=
 any micro-operations to the rename stage because of frontend resource stal=
ls caused by fetch memory latency or branch prediction flow stalls. All the=
 frontend slots were empty during the cycle when this event counts."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND",
> +        "PublicDescription": "Counts cycles whenever the rename unit is =
unable to send any micro-operations to the backend of the pipeline because =
of backend resource constraints. Backend resource constraints can include i=
ssue stage fullness, execution stage fullness, or other internal pipeline r=
esource fullness. All the backend slots were empty during the cycle when th=
is event counts."
> +    },
> +    {
> +        "ArchStdEvent": "STALL",
> +        "PublicDescription": "Counts cycles when no operations are sent =
to the rename unit from the frontend or from the rename unit to the backend=
 for any reason (either frontend or backend stall)."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_SLOT_BACKEND",
> +        "PublicDescription": "Counts slots per cycle in which no operati=
ons are sent from the rename unit to the backend due to backend resource co=
nstraints."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_SLOT_FRONTEND",
> +        "PublicDescription": "Counts slots per cycle in which no operati=
ons are sent to the rename unit from the frontend due to frontend resource =
constraints."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_SLOT",
> +        "PublicDescription": "Counts slots per cycle in which no operati=
ons are sent to the rename unit from the frontend or from the rename unit t=
o the backend for any reason (either frontend or backend stall)."
> +    },
> +    {
> +        "ArchStdEvent": "STALL_BACKEND_MEM",
> +        "PublicDescription": "Counts cycles when the backend is stalled =
because there is a pending demand load request in progress in the last leve=
l core cache."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/sve.=
json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/sve.json
> new file mode 100644
> index 000000000000..51dab48cb2ba
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/sve.json
> @@ -0,0 +1,50 @@
> +[
> +    {
> +        "ArchStdEvent": "SVE_INST_SPEC",
> +        "PublicDescription": "Counts speculatively executed operations t=
hat are SVE operations."
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRED_SPEC",
> +        "PublicDescription": "Counts speculatively executed predicated S=
VE operations."
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRED_EMPTY_SPEC",
> +        "PublicDescription": "Counts speculatively executed predicated S=
VE operations with no active predicate elements."
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRED_FULL_SPEC",
> +        "PublicDescription": "Counts speculatively executed predicated S=
VE operations with all predicate elements active."
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRED_PARTIAL_SPEC",
> +        "PublicDescription": "Counts speculatively executed predicated S=
VE operations with at least one but not all active predicate elements."
> +    },
> +    {
> +        "ArchStdEvent": "SVE_PRED_NOT_FULL_SPEC",
> +        "PublicDescription": "Counts speculatively executed predicated S=
VE operations with at least one non active predicate elements."
> +    },
> +    {
> +        "ArchStdEvent": "SVE_LDFF_SPEC",
> +        "PublicDescription": "Counts speculatively executed SVE first fa=
ult or non-fault load operations."
> +    },
> +    {
> +        "ArchStdEvent": "SVE_LDFF_FAULT_SPEC",
> +        "PublicDescription": "Counts speculatively executed SVE first fa=
ult or non-fault load operations that clear at least one bit in the FFR."
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT8_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D or SVE integer operations with the largest data type an 8-bit integer."
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT16_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D or SVE integer operations with the largest data type a 16-bit integer."
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT32_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D or SVE integer operations with the largest data type a 32-bit integer."
> +    },
> +    {
> +        "ArchStdEvent": "ASE_SVE_INT64_SPEC",
> +        "PublicDescription": "Counts speculatively executed Advanced SIM=
D or SVE integer operations with the largest data type a 64-bit integer."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/tlb.=
json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/tlb.json
> new file mode 100644
> index 000000000000..b550af1831f5
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/tlb.json
> @@ -0,0 +1,66 @@
> +[
> +    {
> +        "ArchStdEvent": "L1I_TLB_REFILL",
> +        "PublicDescription": "Counts level 1 instruction TLB refills fro=
m any Instruction fetch. If there are multiple misses in the TLB that are r=
esolved by the refill, then this event only counts once. This event will no=
t count if the translation table walk results in a fault (such as a transla=
tion or access fault), since there is no new translation created for the TL=
B."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL",
> +        "PublicDescription": "Counts level 1 data TLB accesses that resu=
lted in TLB refills. If there are multiple misses in the TLB that are resol=
ved by the refill, then this event only counts once. This event counts for =
refills caused by preload instructions or hardware prefetch accesses. This =
event counts regardless of whether the miss hits in L2 or results in a tran=
slation table walk. This event will not count if the translation table walk=
 results in a fault (such as a translation or access fault), since there is=
 no new translation created for the TLB. This event will not count on an ac=
cess from an AT(address translation) instruction."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB",
> +        "PublicDescription": "Counts level 1 data TLB accesses caused by=
 any memory load or store operation. Note that load or store instructions c=
an be broken up into multiple memory operations. This event does not count =
TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L1I_TLB",
> +        "PublicDescription": "Counts level 1 instruction TLB accesses, w=
hether the access hits or misses in the TLB. This event counts both demand =
accesses and prefetch or preload generated accesses."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_REFILL",
> +        "PublicDescription": "Counts level 2 TLB refills caused by memor=
y operations from both data and instruction fetch, except for those caused =
by TLB maintenance operations and hardware prefetches."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB",
> +        "PublicDescription": "Counts level 2 TLB accesses except those c=
aused by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "DTLB_WALK",
> +        "PublicDescription": "Counts data memory translation table walks=
 caused by a miss in the L2 TLB driven by a memory access. Note that partia=
l translations that also cause a table walk are counted. This event does no=
t count table walks caused by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "ITLB_WALK",
> +        "PublicDescription": "Counts instruction memory translation tabl=
e walks caused by a miss in the L2 TLB driven by a memory access. Partial t=
ranslations that also cause a table walk are counted. This event does not c=
ount table walks caused by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL_RD",
> +        "PublicDescription": "Counts level 1 data TLB refills caused by =
memory read operations. If there are multiple misses in the TLB that are re=
solved by the refill, then this event only counts once. This event counts f=
or refills caused by preload instructions or hardware prefetch accesses. Th=
is event counts regardless of whether the miss hits in L2 or results in a t=
ranslation table walk. This event will not count if the translation table w=
alk results in a fault (such as a translation or access fault), since there=
 is no new translation created for the TLB. This event will not count on an=
 access from an Address Translation (AT) instruction."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_REFILL_WR",
> +        "PublicDescription": "Counts level 1 data TLB refills caused by =
data side memory write operations. If there are multiple misses in the TLB =
that are resolved by the refill, then this event only counts once. This eve=
nt counts for refills caused by preload instructions or hardware prefetch a=
ccesses. This event counts regardless of whether the miss hits in L2 or res=
ults in a translation table walk. This event will not count if the table wa=
lk results in a fault (such as a translation or access fault), since there =
is no new translation created for the TLB. This event will not count with a=
n access from an Address Translation (AT) instruction."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_RD",
> +        "PublicDescription": "Counts level 1 data TLB accesses caused by=
 memory read operations. This event counts whether the access hits or misse=
s in the TLB. This event does not count TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L1D_TLB_WR",
> +        "PublicDescription": "Counts any L1 data side TLB accesses cause=
d by memory write operations. This event counts whether the access hits or =
misses in the TLB. This event does not count TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_REFILL_RD",
> +        "PublicDescription": "Counts level 2 TLB refills caused by memor=
y read operations from both data and instruction fetch except for those cau=
sed by TLB maintenance operations or hardware prefetches."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_REFILL_WR",
> +        "PublicDescription": "Counts level 2 TLB refills caused by memor=
y write operations from both data and instruction fetch except for those ca=
used by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_RD",
> +        "PublicDescription": "Counts level 2 TLB accesses caused by memo=
ry read operations from both data and instruction fetch except for those ca=
used by TLB maintenance operations."
> +    },
> +    {
> +        "ArchStdEvent": "L2D_TLB_WR",
> +        "PublicDescription": "Counts level 2 TLB accesses caused by memo=
ry write operations from both data and instruction fetch except for those c=
aused by TLB maintenance operations."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/trac=
e.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/trace.json
> new file mode 100644
> index 000000000000..98f6fabfebc7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/trace.json
> @@ -0,0 +1,38 @@
> +[
> +    {
> +        "ArchStdEvent": "TRB_WRAP",
> +        "PublicDescription": "This event is generated each time the curr=
ent write pointer is wrapped to the base pointer."
> +    },
> +    {
> +        "ArchStdEvent": "TRCEXTOUT0",
> +        "PublicDescription": "This event is generated each time an event=
 is signaled by ETE external event 0."
> +    },
> +    {
> +        "ArchStdEvent": "TRCEXTOUT1",
> +        "PublicDescription": "This event is generated each time an event=
 is signaled by ETE external event 1."
> +    },
> +    {
> +        "ArchStdEvent": "TRCEXTOUT2",
> +        "PublicDescription": "This event is generated each time an event=
 is signaled by ETE external event 2."
> +    },
> +    {
> +        "ArchStdEvent": "TRCEXTOUT3",
> +        "PublicDescription": "This event is generated each time an event=
 is signaled by ETE external event 3."
> +    },
> +    {
> +        "ArchStdEvent": "CTI_TRIGOUT4",
> +        "PublicDescription": "This event is generated each time an event=
 is signaled on CTI output trigger 4."
> +    },
> +    {
> +        "ArchStdEvent": "CTI_TRIGOUT5",
> +        "PublicDescription": "This event is generated each time an event=
 is signaled on CTI output trigger 5."
> +    },
> +    {
> +        "ArchStdEvent": "CTI_TRIGOUT6",
> +        "PublicDescription": "This event is generated each time an event=
 is signaled on CTI output trigger 6."
> +    },
> +    {
> +        "ArchStdEvent": "CTI_TRIGOUT7",
> +        "PublicDescription": "This event is generated each time an event=
 is signaled on CTI output trigger 7."
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pm=
u-events/arch/arm64/mapfile.csv
> index 3a90fe650863..b1259deb8800 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -45,7 +45,8 @@
>  0x00000000410fd470,v1,arm/cortex-a710,core
>  0x00000000410fd480,v1,arm/cortex-x2,core
>  0x00000000410fd490,v1,arm/neoverse-n2-v2,core
> -0x00000000410fd4f0,v1,arm/neoverse-n2-v2,core
> +0x00000000410fd493,v1,arm/neoverse-n2r0p3-v2,core
> +0x00000000410fd4f0,v1,arm/neoverse-n2r0p3-v2,core
>  0x00000000420f5160,v1,cavium/thunderx2,core
>  0x00000000430f0af0,v1,cavium/thunderx2,core
>  0x00000000460f0010,v1,fujitsu/a64fx,core
> --
> 2.34.1
>
