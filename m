Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB48659B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiL3SsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3SsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:48:16 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B286D1AA3D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:48:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d4so12534584wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eozXRH50ZlFtawl95NiG9GRbnu4peHEnmZnewSiUAg=;
        b=GS21ZFxkhbdYarcynXAaFNuzhoC4le0yIFJKcMKSPaJIhSkB5IcETG1TYRGYVUo86G
         5NkR3Fc99jJw75byZdoSep4Gyh3E31b/4dNHNJJQ4xHZEy+IC72ciciwIRpWgmeb9m3K
         NHyQwTLHxQSZYxgDQtUZXdaHOLGlbev7gxSCUvBdKqYoh8zPTZQXfs3C819GGuCZzstb
         vBHnPNajXVi9bLwY26gf+fMHZyI9SPqisPBYN7eDUaqVwxFyeA4tbgQ848FigorRdQoR
         Mg8R5FfEHptEXinUPcssYPv3BpmnR/WYKV0ewca5hOh/uET4WV0zUqTKPTjIpB0hZ8Tn
         +llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eozXRH50ZlFtawl95NiG9GRbnu4peHEnmZnewSiUAg=;
        b=3NqNepBKl1wAIG4x44gEjuV6wLRM6xgH4yU8Cxpzy1hPb56lo5oJ1oxN6nDQoCLqRD
         jgLae/gnNQKA2YmUU9rwb/MPS61OyoObLfJ8u7OXeehLFfcRqH1da3Qxamf7y+pCBdxm
         7AtS4bwuvy+ENCovt8wiFaS6gIo4lWD8RpIlh4AEwcxFgGGmc0xzmqd+GVBxqdnLnJIv
         xg5sbHiXe+iKukSHNaytSyzOwWzsOGSewJUIfFFVl7Hlzwij52LZSEZ3c9UQwA9o84ig
         Co/PRzzjVbtEn7r1o7QwUPQo6yNqhO6myxFPflsrb77lcwwyAgJRj+1DtrtlNA6TeQxL
         Ivsg==
X-Gm-Message-State: AFqh2kqFXJS1fCn8Wk3ns3ib0dC3VuTG2PubsREIDIq3agGWrOum8Fjk
        5zxirm1DI4gaXcpoSGzxi4O+tQwCWIT+fhN1DgmF0w==
X-Google-Smtp-Source: AMrXdXtU0hy2t8fUNz7miGC/kPGAvnKgVJMj6SmrdA0LslGUOXR/bNkxr6H3flAsI9kGPpqZiCYjsZjfNymrLvSd4nY=
X-Received: by 2002:adf:e944:0:b0:26d:f5d2:4ef9 with SMTP id
 m4-20020adfe944000000b0026df5d24ef9mr954221wrn.375.1672426091977; Fri, 30 Dec
 2022 10:48:11 -0800 (PST)
MIME-Version: 1.0
References: <1671799045-1108027-1-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1671799045-1108027-1-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Dec 2022 10:48:00 -0800
Message-ID: <CAP-5=fU+4eR6ngX1Rn9fL9eAau4f9FHXx3+C2UxwbfeB7Sk0cw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Add metrics for neoverse-n2
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
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

On Fri, Dec 23, 2022 at 4:39 AM Jing Zhang <renyu.zj@linux.alibaba.com> wro=
te:
>
> Changes since v3:
> - Add ipc_rate metric;
> - Drop the PublicDescription;
> - Describe PEutilization metrics in more detail;
> - Link: https://lore.kernel.org/all/1669310088-13482-1-git-send-email-ren=
yu.zj@linux.alibaba.com/
>
> Changes since v2:
> - Correct the furmula of Branch metrics;
> - Add more PE utilization metrics;
> - Add more TLB metrics;
> - Add =E2=80=9CScaleUnit=E2=80=9D for some metrics;
> - Add a newline at the end of the file;
> - Link: https://lore.kernel.org/all/1668411720-3581-1-git-send-email-reny=
u.zj@linux.alibaba.com/
>
> Changes since v1:
> - Corrected formula for topdown L1 due to wrong counts for stall_slot and
>   stall_slot_frontend;
> - Link: https://lore.kernel.org/all/1667214694-89839-1-git-send-email-ren=
yu.zj@linux.alibaba.com/
>
>
> This series add six metricgroups for neoverse-n2, among which, the formul=
a of
> topdown L1 is from ARM sbsa7.0 platform design document [0], D37-38.
>
> However, due to the wrong count of stall_slot and stall_slot_frontend on
> neoverse-n2, the real stall_slot and real stall_slot_frontend need to
> subtract cpu_cycles,  so correct the expression of topdown metrics.
> Reference from ARM neoverse-n2 errata notice [1], D117.
>
> Since neoverse-n2 does not yet support topdown L2, metricgroups such as C=
ache,
> TLB, Branch, InstructionsMix, and PEutilization are added to help further
> analysis of performance bottlenecks. Reference from ARM PMU guide [2][3].
>
> [0] https://documentation-service.arm.com/static/60250c7395978b529036da86=
?token=3D
> [1] https://documentation-service.arm.com/static/636a66a64e6cf12278ad89cb=
?token=3D
> [2] https://documentation-service.arm.com/static/628f8fa3dfaf015c2b76eae8=
?token=3D
> [3] https://documentation-service.arm.com/static/62cfe21e31ea212bb6627393=
?token=3D
>
>
> $./perf list
> ...
> Metric Groups:
>
> Branch:
>   branch_miss_pred_rate
>        [The rate of branches mis-predited to the overall branches]
>   branch_mpki
>        [The rate of branches mis-predicted per kilo instructions]
>   branch_pki
>        [The rate of branches retired per kilo instructions]
> Cache:
>   l1d_cache_miss_rate
>        [The rate of L1 D-Cache misses to the overall L1 D-Cache]
>   l1d_cache_mpki
>        [The rate of L1 D-Cache misses per kilo instructions]
> ...
>
>
> $sudo ./perf stat -M TLB false_sharing 2
>
>  Performance counter stats for 'false_sharing 2':
>
>             31,561      L2D_TLB                          #     18.8 %  l2=
_tlb_miss_rate      (43.23%)
>              5,944      L2D_TLB_REFILL                                   =
                    (43.23%)
>              2,248      L1I_TLB_REFILL                   #      0.1 %  l1=
i_tlb_miss_rate     (43.85%)
>          2,203,195      L1I_TLB                                          =
                    (43.85%)
>        328,647,380      L1D_TLB                          #      0.0 %  l1=
d_tlb_miss_rate     (44.32%)
>             26,347      L1D_TLB_REFILL                                   =
                    (44.32%)
>            747,319      L1I_TLB                          #      0.0 %  it=
lb_walk_rate        (43.74%)
>                310      ITLB_WALK                                        =
                    (43.74%)
>        839,420,454      INST_RETIRED                     #     0.00 itlb_=
mpki                (42.77%)
>                212      ITLB_WALK                                        =
                    (42.77%)
>                468      DTLB_WALK                        #      0.0 %  dt=
lb_walk_rate        (42.28%)
>        265,405,802      L1D_TLB                                          =
                    (42.28%)
>        790,874,367      INST_RETIRED                     #     0.00 dtlb_=
mpki                (42.33%)
>                 23      DTLB_WALK                                        =
                    (42.33%)
>
>        0.515904553 seconds time elapsed
>
>        1.410313000 seconds user
>        0.000000000 seconds sys
>
>
> $sudo ./perf stat -M TopDownL1 false_sharing 2
>
>  Performance counter stats for 'false_sharing 2':
>
>      4,310,905,590      cpu_cycles                       #      0.0 %  ba=
d_speculation
>                                                   #      4.0 %  retiring =
             (66.87%)
>     25,009,763,735      stall_slot                                       =
                    (66.87%)
>        855,659,327      op_spec                                          =
                    (66.87%)
>        854,335,288      op_retired                                       =
                    (66.87%)
>      4,330,308,058      cpu_cycles                       #     27.1 %  fr=
ontend_bound        (66.99%)
>     10,207,186,460      stall_slot_frontend                              =
                    (66.99%)
>      4,316,583,673      cpu_cycles                       #     69.4 %  ba=
ckend_bound         (66.65%)
>     14,979,136,808      stall_slot_backend                               =
                    (66.65%)
>
>        0.572056818 seconds time elapsed
>
>        1.572143000 seconds user
>        0.004010000 seconds sys
>
>
> Jing Zhang (6):
>   perf vendor events arm64: Add topdown L1 metrics for neoverse-n2
>   perf vendor events arm64: Add TLB metrics for neoverse-n2
>   perf vendor events arm64: Add cache metrics for neoverse-n2
>   perf vendor events arm64: Add branch metrics for neoverse-n2
>   perf vendor events arm64: Add PE utilization metrics for neoverse-n2
>   perf vendor events arm64: Add instruction mix metrics for neoverse-n2

Series:
Acked-by: Ian Rogers <irogers@google.com>

The only observation I had is that the "per kilo instruction" in the
names (ie ending pki) could be moved into the ScaleUnit. Which may
make the names and the output a little cleaner.

Thanks!
Ian

>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 277 +++++++++++++++=
++++++
>  1 file changed, 277 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metr=
ics.json
>
> --
> 1.8.3.1
>
