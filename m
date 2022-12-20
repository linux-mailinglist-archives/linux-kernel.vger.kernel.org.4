Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77B86525F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiLTSEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiLTSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:04:33 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DD318689
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:04:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so13011280pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0139OQLccAI5ZadwQnPToEDtT48qSvBixJSD2HH6AK8=;
        b=Bv8ZKcAOlIrSP1l7akzVR8H5PK379qy5asK/4+iNDQG+UJlZJk+4897K9X6Ur+shgt
         VL9worMryuxQhphhZlO3FOuIX1l/od9W6gG70pHyeklxu5aAlL7vaG3H87s03SGAeVhP
         arX7zflbaQSS0HsiX/6tgFOaicsacg8ccI1UB52XAcLgae4WRrc2S/dMpx4wUSPzVa14
         +tf2RWyp/8fZM0h3lq9Ve7oCToY24BQs1R/LmakCncRx0u1m5qkEJgLawqK9uWir/jk+
         YR6CzT0wC62qwdjB6EL/TIL5adDSUVmY4wycxMvU+Wpu/ECdwYFCy9Tbypu2ZBp2YIP5
         lLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0139OQLccAI5ZadwQnPToEDtT48qSvBixJSD2HH6AK8=;
        b=mw1cc45m4ZPMo+5D8nk+aL7vzT/biig8PXLTuPv/QsacuRny+kiio9R3qqvbRCzh6N
         KPxaBISuDZJHaCqEH2YkxGHsHrWl+oWaqMt1f19t9N/LfXqcoKTlNS5GoNITsb+/D5vg
         lBmdTEwIR+ehGOW09vUUAphsVUSOuYQn08NGIzXM6iE4DPpI65yi/rgaIxPCFJ89uQgg
         Ts2Q+aiOU/tC6APrMh16/HbvPXKMCWEqW684biygoRG3wq5bPUHT75ZJjl+p5CCTBxyp
         rWTH1i1F85mANhuHFnNZXisQB0vcjm3EsghLAW0CwQw6yos8/HcTZjzc+OhvZZpDk0vI
         sJMg==
X-Gm-Message-State: AFqh2krpV2sVvtzRPPELR5ZZ3DOLnDvcQUFymFEJ6nBIdkV+WzHMBbwx
        jNuwcx/90BNo80Ggys7RaUwqdclOooeFDXYF66I=
X-Google-Smtp-Source: AMrXdXvIJ7Q9IK6mzPBBJaGAfD2dsWewIA9tKfNVtBE5l/N8+F2RKESedNe4n23monARrubC5wE2GshBPQYeATUT0vw=
X-Received: by 2002:a17:902:ccc5:b0:191:2b33:7010 with SMTP id
 z5-20020a170902ccc500b001912b337010mr256143ple.119.1671559469800; Tue, 20 Dec
 2022 10:04:29 -0800 (PST)
MIME-Version: 1.0
References: <202212151657.5d11a672-yujie.liu@intel.com>
In-Reply-To: <202212151657.5d11a672-yujie.liu@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 20 Dec 2022 10:04:18 -0800
Message-ID: <CAHbLzkpVr62M4dWCb9J+eMErDvxx0hiTF6DD6bp2qEivzZYXCg@mail.gmail.com>
Subject: Re: [linus:master] [mm] 0ba09b1733: will-it-scale.per_thread_ops
 -21.1% regression in mmap1 benchmark
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        Nathan Chancellor <nathan@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 3:30 AM kernel test robot <yujie.liu@intel.com> wro=
te:
>
> Greetings,
>
> Please note that we reported a regression in will-it-scale malloc1
> benchmark on below commit
>   f35b5d7d676e ("mm: align larger anonymous mappings on THP boundaries")
> at
>   https://lore.kernel.org/all/202210181535.7144dd15-yujie.liu@intel.com/
> and Nathan reported a kbuild slowdown under clang toolchain at
>   https://lore.kernel.org/all/Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X/
> That commit was finally reverted.
>
> When we tested the revert commit, the score in malloc1 benchmark
> recovered, but we observed another regression in mmap1 benchmark.
>
> "Yin, Fengwei" helped to check and got below clues:
>
> 1. The regression is related with the VMA merge with prev/next
>    VMA when doing mmap.
>
> 2. Before the patch reverted, almost all the VMA for 128M mapping
>    can't be merged with prev/next VMA. So always create new VMA.
>    With the patch reverted, most VMA for 128 mapping can be merged.
>
>    It looks like VMA merging introduce more latency comparing to
>    creating new VMA.
>
> 3. If force to create new VMA with patch reverted, the result of
>    mmap1_thread is restored.
>
> 4. The thp_get_unmapped_area() adds a padding to request mapping
>    length. The padding is 2M in general. I believe this padding
>    break VMA merging behavior.
>
> 5. No idea about why the difference of the two path (VMA merging
>    vs New VMA) is not shown in perf data

IIRC thp_get_unmapped_area() has been behaving like that for years.
The other change between the problematic commit and the revert commit,
which might have an impact to VMA merging, is maple tree. Did you try to
bisect further?

BTW, is this similar to
https://lore.kernel.org/linux-mm/20221219180857.u6opzhqqbbfxdj3h@revolver/T=
/#t
?

>
> Please check below report for details.
>
>
> FYI, we noticed a -21.1% regression of will-it-scale.per_thread_ops due t=
o commit:
>
> commit: 0ba09b1733878afe838fe35c310715fda3d46428 ("Revert "mm: align larg=
er anonymous mappings on THP boundaries"")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: will-it-scale
> on test machine: 104 threads 2 sockets (Skylake) with 192G memory
> with following parameters:
>
>         nr_task: 50%
>         mode: thread
>         test: mmap1
>         cpufreq_governor: performance
>
> test-description: Will It Scale takes a testcase and runs it from 1 throu=
gh to n parallel copies to see if the testcase will scale. It builds both a=
 process and threads based test in order to see any differences between the=
 two.
> test-url: https://github.com/antonblanchard/will-it-scale
>
> In addition to that, the commit also has significant impact on the follow=
ing tests:
>
> +------------------+-----------------------------------------------------=
-------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops 1943.6%=
 improvement                               |
> | test machine     | 128 threads 4 sockets Intel(R) Xeon(R) Gold 6338 CPU=
 @ 2.00GHz (Ice Lake) with 256G memory     |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                             |
> |                  | mode=3Dprocess                                      =
                                             |
> |                  | nr_task=3D50%                                       =
                                             |
> |                  | test=3Dmalloc1                                      =
                                             |
> +------------------+-----------------------------------------------------=
-------------------------------------------+
> | testcase: change | unixbench: unixbench.score 2.6% improvement         =
                                           |
> | test machine     | 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ =
3.40GHz (Coffee Lake) with 32G memory      |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                             |
> |                  | nr_task=3D30%                                       =
                                             |
> |                  | runtime=3D300s                                      =
                                             |
> |                  | test=3Dshell8                                       =
                                             |
> +------------------+-----------------------------------------------------=
-------------------------------------------+
> | testcase: change | phoronix-test-suite: phoronix-test-suite.build-eigen=
.0.seconds 9.1% regression                 |
> | test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU =
@ 2.10GHz (Cascade Lake) with 512G memory  |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                             |
> |                  | test=3Dbuild-eigen-1.1.0                            =
                                             |
> +------------------+-----------------------------------------------------=
-------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops 2882.9%=
 improvement                               |
> | test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU=
 @ 2.10GHz (Cascade Lake) with 128G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                             |
> |                  | mode=3Dprocess                                      =
                                             |
> |                  | nr_task=3D100%                                      =
                                             |
> |                  | test=3Dmalloc1                                      =
                                             |
> +------------------+-----------------------------------------------------=
-------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops 12.7% i=
mprovement                                 |
> | test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU=
 @ 2.10GHz (Cascade Lake) with 128G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                             |
> |                  | mode=3Dprocess                                      =
                                             |
> |                  | nr_task=3D50%                                       =
                                             |
> |                  | test=3Dmmap1                                        =
                                             |
> +------------------+-----------------------------------------------------=
-------------------------------------------+
> | testcase: change | stress-ng: stress-ng.pthread.ops_per_sec 600.6% impr=
ovement                                    |
> | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358=
 CPU @ 2.60GHz (Ice Lake) with 128G memory |
> | test parameters  | class=3Dscheduler                                   =
                                             |
> |                  | cpufreq_governor=3Dperformance                      =
                                             |
> |                  | nr_threads=3D100%                                   =
                                             |
> |                  | sc_pid_max=3D4194304                                =
                                             |
> |                  | test=3Dpthread                                      =
                                             |
> |                  | testtime=3D60s                                      =
                                             |
> +------------------+-----------------------------------------------------=
-------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops 601.0% =
improvement                                |
> | test machine     | 104 threads 2 sockets (Skylake) with 192G memory    =
                                           |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                             |
> |                  | mode=3Dprocess                                      =
                                             |
> |                  | nr_task=3D50%                                       =
                                             |
> |                  | test=3Dmalloc1                                      =
                                             |
> +------------------+-----------------------------------------------------=
-------------------------------------------+
>
>
> Details are as below:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/tes=
tcase:
>   gcc-11/performance/x86_64-rhel-8.3/thread/50%/debian-11.1-x86_64-202205=
10.cgz/lkp-skl-fpga01/mmap1/will-it-scale
>
> commit:
>   23393c6461 ("char: tpm: Protect tpm_pm_suspend with locks")
>   0ba09b1733 ("Revert "mm: align larger anonymous mappings on THP boundar=
ies"")
>
> 23393c6461422df5 0ba09b1733878afe838fe35c310
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>     140227           -21.1%     110582 =C4=85  3%  will-it-scale.52.threa=
ds
>      49.74            +0.1%      49.78        will-it-scale.52.threads_id=
le
>       2696           -21.1%       2126 =C4=85  3%  will-it-scale.per_thre=
ad_ops
>     301.30            -0.0%     301.26        will-it-scale.time.elapsed_=
time
>     301.30            -0.0%     301.26        will-it-scale.time.elapsed_=
time.max
>       3.67 =C4=85 71%     -22.7%       2.83 =C4=85 47%  will-it-scale.tim=
e.involuntary_context_switches
>       0.67 =C4=85165%     -75.0%       0.17 =C4=85223%  will-it-scale.tim=
e.major_page_faults
>       9772            -0.7%       9702        will-it-scale.time.maximum_=
resident_set_size
>       7274            -0.3%       7254        will-it-scale.time.minor_pa=
ge_faults
>       4096            +0.0%       4096        will-it-scale.time.page_siz=
e
>       0.04 =C4=85 16%      -4.0%       0.04        will-it-scale.time.sys=
tem_time
>       0.06 =C4=85 24%     -11.8%       0.05 =C4=85 16%  will-it-scale.tim=
e.user_time
>     102.83            +1.9%     104.83 =C4=85  2%  will-it-scale.time.vol=
untary_context_switches
>     140227           -21.1%     110582 =C4=85  3%  will-it-scale.workload
>  1.582e+10            +0.1%  1.584e+10        cpuidle..time
>   33034032            -0.0%   33021393        cpuidle..usage
>      10.00            +0.0%      10.00        dmesg.bootstage:last
>     172.34            +0.1%     172.58        dmesg.timestamp:last
>      10.00            +0.0%      10.00        kmsg.bootstage:last
>     172.34            +0.1%     172.58        kmsg.timestamp:last
>     362.22            +0.0%     362.25        uptime.boot
>      21363            +0.1%      21389        uptime.idle
>      55.94            +0.2%      56.06        boot-time.boot
>      38.10            +0.2%      38.19        boot-time.dhcp
>       5283            +0.2%       5295        boot-time.idle
>       1.11            -0.1%       1.11        boot-time.smp_boot
>      50.14            +0.0       50.16        mpstat.cpu.all.idle%
>       0.03 =C4=85223%      -0.0        0.00 =C4=85223%  mpstat.cpu.all.io=
wait%
>       1.02            +0.0        1.03        mpstat.cpu.all.irq%
>       0.03 =C4=85  4%      -0.0        0.02        mpstat.cpu.all.soft%
>      48.59            +0.0       48.61        mpstat.cpu.all.sys%
>       0.20 =C4=85  2%      -0.0        0.17 =C4=85  4%  mpstat.cpu.all.us=
r%
>       0.00          -100.0%       0.00        numa-numastat.node0.interle=
ave_hit
>     328352 =C4=85 15%      -7.2%     304842 =C4=85 20%  numa-numastat.nod=
e0.local_node
>     374230 =C4=85  6%      -4.2%     358578 =C4=85  7%  numa-numastat.nod=
e0.numa_hit
>      45881 =C4=85 75%     +17.1%      53735 =C4=85 69%  numa-numastat.nod=
e0.other_node
>       0.00          -100.0%       0.00        numa-numastat.node1.interle=
ave_hit
>     381812 =C4=85 13%      +5.9%     404461 =C4=85 14%  numa-numastat.nod=
e1.local_node
>     430007 =C4=85  5%      +3.4%     444810 =C4=85  5%  numa-numastat.nod=
e1.numa_hit
>      48195 =C4=85 71%     -16.3%      40348 =C4=85 92%  numa-numastat.nod=
e1.other_node
>     301.30            -0.0%     301.26        time.elapsed_time
>     301.30            -0.0%     301.26        time.elapsed_time.max
>       3.67 =C4=85 71%     -22.7%       2.83 =C4=85 47%  time.involuntary_=
context_switches
>       0.67 =C4=85165%     -75.0%       0.17 =C4=85223%  time.major_page_f=
aults
>       9772            -0.7%       9702        time.maximum_resident_set_s=
ize
>       7274            -0.3%       7254        time.minor_page_faults
>       4096            +0.0%       4096        time.page_size
>       0.04 =C4=85 16%      -4.0%       0.04        time.system_time
>       0.06 =C4=85 24%     -11.8%       0.05 =C4=85 16%  time.user_time
>     102.83            +1.9%     104.83 =C4=85  2%  time.voluntary_context=
_switches
>      50.00            +0.0%      50.00        vmstat.cpu.id
>      49.00            +0.0%      49.00        vmstat.cpu.sy
>       0.00          -100.0%       0.00        vmstat.cpu.us
>       0.00          -100.0%       0.00        vmstat.cpu.wa
>      12.50 =C4=85100%     -66.7%       4.17 =C4=85223%  vmstat.io.bi
>       3.33 =C4=85141%     -55.0%       1.50 =C4=85223%  vmstat.io.bo
>       6.00 =C4=85 47%     -16.7%       5.00 =C4=85 44%  vmstat.memory.buf=
f
>    4150651            -0.1%    4148516        vmstat.memory.cache
>  1.912e+08            +0.1%  1.913e+08        vmstat.memory.free
>       0.00          -100.0%       0.00        vmstat.procs.b
>      50.50            -0.3%      50.33        vmstat.procs.r
>       8274 =C4=85  2%      +1.2%       8371 =C4=85  4%  vmstat.system.cs
>     211078            -0.1%     210826        vmstat.system.in
>       1399            +0.0%       1399        turbostat.Avg_MHz
>      50.12            +0.0       50.13        turbostat.Busy%
>       2799            -0.0%       2798        turbostat.Bzy_MHz
>     208677 =C4=85 13%   +1112.3%    2529776 =C4=85194%  turbostat.C1
>       0.03 =C4=85 89%      +0.3        0.36 =C4=85203%  turbostat.C1%
>   27078371 =C4=85 15%     -22.0%   21125809 =C4=85 51%  turbostat.C1E
>      37.41 =C4=85 33%      -9.4       28.04 =C4=85 62%  turbostat.C1E%
>    5088326 =C4=85 84%     +63.1%    8298766 =C4=85 77%  turbostat.C6
>      12.59 =C4=85 99%      +9.1       21.69 =C4=85 78%  turbostat.C6%
>      49.79            -0.1%      49.75        turbostat.CPU%c1
>       0.08 =C4=85 71%     +37.3%       0.12 =C4=85 78%  turbostat.CPU%c6
>      43.67            -0.4%      43.50        turbostat.CoreTmp
>       0.03            +0.0%       0.03        turbostat.IPC
>   64483530            -0.2%   64338768        turbostat.IRQ
>     647657 =C4=85  2%     +63.2%    1057048 =C4=85 98%  turbostat.POLL
>       0.01            +0.0        0.05 =C4=85178%  turbostat.POLL%
>       0.01 =C4=85223%    +200.0%       0.04 =C4=85147%  turbostat.Pkg%pc2
>       0.01 =C4=85223%    +140.0%       0.02 =C4=85165%  turbostat.Pkg%pc6
>      44.17            +0.4%      44.33        turbostat.PkgTmp
>     284.98            +0.1%     285.28        turbostat.PkgWatt
>      26.78            +0.4%      26.89        turbostat.RAMWatt
>       2095            +0.0%       2095        turbostat.TSC_MHz
>      49585 =C4=85  7%      +1.1%      50139 =C4=85  7%  meminfo.Active
>      49182 =C4=85  7%      +1.4%      49889 =C4=85  7%  meminfo.Active(an=
on)
>     402.33 =C4=85 99%     -37.9%     250.00 =C4=85123%  meminfo.Active(fi=
le)
>     290429           -33.7%     192619        meminfo.AnonHugePages
>     419654           -25.9%     311054        meminfo.AnonPages
>       6.00 =C4=85 47%     -16.7%       5.00 =C4=85 44%  meminfo.Buffers
>    4026046            -0.1%    4023990        meminfo.Cached
>   98360160            +0.0%   98360160        meminfo.CommitLimit
>    4319751            +0.4%    4337801        meminfo.Committed_AS
>  1.877e+08            -0.1%  1.875e+08        meminfo.DirectMap1G
>   14383445 =C4=85 12%      +0.7%   14491306 =C4=85  4%  meminfo.DirectMap=
2M
>    1042426 =C4=85  9%      +6.4%    1109328 =C4=85  7%  meminfo.DirectMap=
4k
>       4.00 =C4=85141%     -50.0%       2.00 =C4=85223%  meminfo.Dirty
>       2048            +0.0%       2048        meminfo.Hugepagesize
>     434675           -26.3%     320518        meminfo.Inactive
>     431330           -26.0%     319346        meminfo.Inactive(anon)
>       3344 =C4=85 95%     -65.0%       1171 =C4=85186%  meminfo.Inactive(=
file)
>     124528            -0.1%     124460        meminfo.KReclaimable
>      18433            +0.7%      18559        meminfo.KernelStack
>      40185 =C4=85  2%      -0.9%      39837        meminfo.Mapped
>  1.903e+08            +0.1%  1.904e+08        meminfo.MemAvailable
>  1.912e+08            +0.1%  1.913e+08        meminfo.MemFree
>  1.967e+08            +0.0%  1.967e+08        meminfo.MemTotal
>    5569412            -1.8%    5466754        meminfo.Memused
>       4763            -5.7%       4489        meminfo.PageTables
>      51956            +0.0%      51956        meminfo.Percpu
>     124528            -0.1%     124460        meminfo.SReclaimable
>     197128            +0.1%     197293        meminfo.SUnreclaim
>      57535 =C4=85  7%      +0.8%      57986 =C4=85  6%  meminfo.Shmem
>     321657            +0.0%     321754        meminfo.Slab
>    3964769            -0.0%    3964586        meminfo.Unevictable
>  3.436e+10            +0.0%  3.436e+10        meminfo.VmallocTotal
>     280612            +0.1%     280841        meminfo.VmallocUsed
>    6194619            -2.0%    6071944        meminfo.max_used_kB
>       2626 =C4=85 28%      -7.7%       2423 =C4=85 11%  numa-meminfo.node=
0.Active
>       2361 =C4=85 20%      -5.3%       2236 =C4=85 10%  numa-meminfo.node=
0.Active(anon)
>     264.67 =C4=85117%     -29.5%     186.67 =C4=85152%  numa-meminfo.node=
0.Active(file)
>     135041 =C4=85 20%     -22.4%     104774 =C4=85 42%  numa-meminfo.node=
0.AnonHugePages
>     197759 =C4=85 18%     -20.4%     157470 =C4=85 35%  numa-meminfo.node=
0.AnonPages
>     235746 =C4=85 19%     -11.8%     207988 =C4=85 29%  numa-meminfo.node=
0.AnonPages.max
>       2.00 =C4=85223%      +0.0%       2.00 =C4=85223%  numa-meminfo.node=
0.Dirty
>    1386137 =C4=85123%     +89.5%    2626100 =C4=85 67%  numa-meminfo.node=
0.FilePages
>     202317 =C4=85 19%     -21.0%     159846 =C4=85 36%  numa-meminfo.node=
0.Inactive
>     200223 =C4=85 19%     -20.7%     158765 =C4=85 35%  numa-meminfo.node=
0.Inactive(anon)
>       2093 =C4=85129%     -48.4%       1080 =C4=85200%  numa-meminfo.node=
0.Inactive(file)
>      46369 =C4=85 57%     +43.5%      66525 =C4=85 41%  numa-meminfo.node=
0.KReclaimable
>       9395 =C4=85  4%      +4.6%       9822 =C4=85  5%  numa-meminfo.node=
0.KernelStack
>      14343 =C4=85101%     +65.1%      23681 =C4=85 58%  numa-meminfo.node=
0.Mapped
>   95532160            -1.3%   94306066        numa-meminfo.node0.MemFree
>   97681544            +0.0%   97681544        numa-meminfo.node0.MemTotal
>    2149382 =C4=85 82%     +57.0%    3375476 =C4=85 53%  numa-meminfo.node=
0.MemUsed
>       2356 =C4=85 21%      -9.9%       2122 =C4=85  9%  numa-meminfo.node=
0.PageTables
>      46369 =C4=85 57%     +43.5%      66525 =C4=85 41%  numa-meminfo.node=
0.SReclaimable
>     109141 =C4=85  6%      +1.5%     110817 =C4=85  7%  numa-meminfo.node=
0.SUnreclaim
>       4514 =C4=85 34%     -22.4%       3505 =C4=85 30%  numa-meminfo.node=
0.Shmem
>     155511 =C4=85 18%     +14.0%     177344 =C4=85 14%  numa-meminfo.node=
0.Slab
>    1379264 =C4=85124%     +90.1%    2621327 =C4=85 67%  numa-meminfo.node=
0.Unevictable
>      46974 =C4=85  8%      +1.5%      47665 =C4=85  7%  numa-meminfo.node=
1.Active
>      46837 =C4=85  8%      +1.6%      47601 =C4=85  7%  numa-meminfo.node=
1.Active(anon)
>     137.33 =C4=85219%     -54.0%      63.17 =C4=85 85%  numa-meminfo.node=
1.Active(file)
>     155559 =C4=85 18%     -43.5%      87865 =C4=85 52%  numa-meminfo.node=
1.AnonHugePages
>     222077 =C4=85 16%     -30.8%     153725 =C4=85 36%  numa-meminfo.node=
1.AnonPages
>     304080 =C4=85 17%     -27.5%     220544 =C4=85 28%  numa-meminfo.node=
1.AnonPages.max
>       2.00 =C4=85223%    -100.0%       0.00        numa-meminfo.node1.Dir=
ty
>    2639873 =C4=85 65%     -47.0%    1397913 =C4=85126%  numa-meminfo.node=
1.FilePages
>     232481 =C4=85 17%     -30.8%     160887 =C4=85 34%  numa-meminfo.node=
1.Inactive
>     231228 =C4=85 16%     -30.5%     160796 =C4=85 34%  numa-meminfo.node=
1.Inactive(anon)
>       1252 =C4=85213%     -92.8%      90.33 =C4=85 96%  numa-meminfo.node=
1.Inactive(file)
>      78155 =C4=85 34%     -25.9%      57927 =C4=85 47%  numa-meminfo.node=
1.KReclaimable
>       9041 =C4=85  4%      -3.3%       8740 =C4=85  5%  numa-meminfo.node=
1.KernelStack
>      25795 =C4=85 55%     -37.5%      16118 =C4=85 85%  numa-meminfo.node=
1.Mapped
>   95619356            +1.4%   96947357        numa-meminfo.node1.MemFree
>   99038776            +0.0%   99038776        numa-meminfo.node1.MemTotal
>    3419418 =C4=85 52%     -38.8%    2091417 =C4=85 85%  numa-meminfo.node=
1.MemUsed
>       2405 =C4=85 21%      -1.5%       2369 =C4=85  7%  numa-meminfo.node=
1.PageTables
>      78155 =C4=85 34%     -25.9%      57927 =C4=85 47%  numa-meminfo.node=
1.SReclaimable
>      87984 =C4=85  7%      -1.7%      86475 =C4=85  9%  numa-meminfo.node=
1.SUnreclaim
>      52978 =C4=85  9%      +2.9%      54500 =C4=85  8%  numa-meminfo.node=
1.Shmem
>     166140 =C4=85 16%     -13.1%     144403 =C4=85 17%  numa-meminfo.node=
1.Slab
>    2585504 =C4=85 66%     -48.0%    1343258 =C4=85131%  numa-meminfo.node=
1.Unevictable
>     486.17 =C4=85  9%      +6.8%     519.17 =C4=85  7%  proc-vmstat.direc=
t_map_level2_splits
>       8.00 =C4=85 22%      +2.1%       8.17 =C4=85  8%  proc-vmstat.direc=
t_map_level3_splits
>      12303 =C4=85  7%      +1.3%      12461 =C4=85  7%  proc-vmstat.nr_ac=
tive_anon
>     100.50 =C4=85 99%     -37.8%      62.50 =C4=85123%  proc-vmstat.nr_ac=
tive_file
>     104906           -25.9%      77785        proc-vmstat.nr_anon_pages
>     141.00           -33.6%      93.67        proc-vmstat.nr_anon_transpa=
rent_hugepages
>     264.00 =C4=85141%     -54.3%     120.67 =C4=85223%  proc-vmstat.nr_di=
rtied
>       1.00 =C4=85141%     -50.0%       0.50 =C4=85223%  proc-vmstat.nr_di=
rty
>    4750146            +0.1%    4752612        proc-vmstat.nr_dirty_backgr=
ound_threshold
>    9511907            +0.1%    9516846        proc-vmstat.nr_dirty_thresh=
old
>    1006517            -0.1%    1005995        proc-vmstat.nr_file_pages
>   47787985            +0.1%   47813269        proc-vmstat.nr_free_pages
>     107821           -25.9%      79869        proc-vmstat.nr_inactive_ano=
n
>     836.17 =C4=85 95%     -65.1%     292.17 =C4=85186%  proc-vmstat.nr_in=
active_file
>      18434            +0.7%      18563        proc-vmstat.nr_kernel_stack
>      10033 =C4=85  2%      -1.1%       9924        proc-vmstat.nr_mapped
>       1190            -5.7%       1122        proc-vmstat.nr_page_table_p=
ages
>      14387 =C4=85  7%      +0.7%      14493 =C4=85  6%  proc-vmstat.nr_sh=
mem
>      31131            -0.1%      31114        proc-vmstat.nr_slab_reclaim=
able
>      49281            +0.1%      49323        proc-vmstat.nr_slab_unrecla=
imable
>     991192            -0.0%     991146        proc-vmstat.nr_unevictable
>     264.00 =C4=85141%     -54.3%     120.67 =C4=85223%  proc-vmstat.nr_wr=
itten
>      12303 =C4=85  7%      +1.3%      12461 =C4=85  7%  proc-vmstat.nr_zo=
ne_active_anon
>     100.50 =C4=85 99%     -37.8%      62.50 =C4=85123%  proc-vmstat.nr_zo=
ne_active_file
>     107821           -25.9%      79869        proc-vmstat.nr_zone_inactiv=
e_anon
>     836.17 =C4=85 95%     -65.1%     292.17 =C4=85186%  proc-vmstat.nr_zo=
ne_inactive_file
>     991192            -0.0%     991146        proc-vmstat.nr_zone_unevict=
able
>       1.00 =C4=85141%     -50.0%       0.50 =C4=85223%  proc-vmstat.nr_zo=
ne_write_pending
>      17990 =C4=85 21%     -17.6%      14820 =C4=85 46%  proc-vmstat.numa_=
hint_faults
>       7847 =C4=85 37%     -41.5%       4588 =C4=85 26%  proc-vmstat.numa_=
hint_faults_local
>     806662            +0.3%     809070        proc-vmstat.numa_hit
>     488.50 =C4=85 13%     -73.4%     130.17 =C4=85 22%  proc-vmstat.numa_=
huge_pte_updates
>       0.00          -100.0%       0.00        proc-vmstat.numa_interleave
>     712588            -0.2%     711419        proc-vmstat.numa_local
>      94077            +0.0%      94084        proc-vmstat.numa_other
>      18894 =C4=85 67%      -3.1%      18303 =C4=85 41%  proc-vmstat.numa_=
pages_migrated
>     337482 =C4=85 10%     -59.0%     138314 =C4=85 10%  proc-vmstat.numa_=
pte_updates
>      61815            -1.6%      60823        proc-vmstat.pgactivate
>       0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
>     933601            -3.8%     898485        proc-vmstat.pgalloc_normal
>     899579            -0.5%     895253        proc-vmstat.pgfault
>     896972            -3.9%     861819        proc-vmstat.pgfree
>      18894 =C4=85 67%      -3.1%      18303 =C4=85 41%  proc-vmstat.pgmig=
rate_success
>       3845 =C4=85100%     -66.8%       1277 =C4=85223%  proc-vmstat.pgpgi=
n
>       1064 =C4=85141%     -54.3%     486.67 =C4=85223%  proc-vmstat.pgpgo=
ut
>      40396            -0.6%      40172        proc-vmstat.pgreuse
>     105.50            -9.2%      95.83 =C4=85  5%  proc-vmstat.thp_collap=
se_alloc
>      57.00           -87.4%       7.17 =C4=85  5%  proc-vmstat.thp_deferr=
ed_split_page
>      74.83           -72.4%      20.67 =C4=85  4%  proc-vmstat.thp_fault_=
alloc
>      19.50 =C4=85105%     -15.4%      16.50 =C4=85 71%  proc-vmstat.thp_m=
igration_success
>      57.00           -87.4%       7.17 =C4=85  5%  proc-vmstat.thp_split_=
pmd
>       0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_a=
lloc
>      17.00            +0.0%      17.00        proc-vmstat.unevictable_pgs=
_culled
>     589.83 =C4=85 21%      -5.2%     559.00 =C4=85 10%  numa-vmstat.node0=
.nr_active_anon
>      66.00 =C4=85117%     -29.3%      46.67 =C4=85152%  numa-vmstat.node0=
.nr_active_file
>      49406 =C4=85 18%     -20.3%      39355 =C4=85 35%  numa-vmstat.node0=
.nr_anon_pages
>      65.17 =C4=85 21%     -22.0%      50.83 =C4=85 42%  numa-vmstat.node0=
.nr_anon_transparent_hugepages
>     132.00 =C4=85223%      -8.6%     120.67 =C4=85223%  numa-vmstat.node0=
.nr_dirtied
>       0.50 =C4=85223%      +0.0%       0.50 =C4=85223%  numa-vmstat.node0=
.nr_dirty
>     346534 =C4=85123%     +89.5%     656525 =C4=85 67%  numa-vmstat.node0=
.nr_file_pages
>   23883055            -1.3%   23576561        numa-vmstat.node0.nr_free_p=
ages
>      50051 =C4=85 19%     -20.7%      39679 =C4=85 35%  numa-vmstat.node0=
.nr_inactive_anon
>     522.67 =C4=85129%     -48.4%     269.67 =C4=85200%  numa-vmstat.node0=
.nr_inactive_file
>       0.00          -100.0%       0.00        numa-vmstat.node0.nr_isolat=
ed_anon
>       9392 =C4=85  4%      +4.6%       9823 =C4=85  5%  numa-vmstat.node0=
.nr_kernel_stack
>       3594 =C4=85101%     +64.8%       5922 =C4=85 58%  numa-vmstat.node0=
.nr_mapped
>     587.83 =C4=85 21%      -9.8%     530.00 =C4=85  9%  numa-vmstat.node0=
.nr_page_table_pages
>       1129 =C4=85 34%     -22.4%     876.67 =C4=85 30%  numa-vmstat.node0=
.nr_shmem
>      11591 =C4=85 57%     +43.5%      16631 =C4=85 41%  numa-vmstat.node0=
.nr_slab_reclaimable
>      27285 =C4=85  6%      +1.5%      27704 =C4=85  7%  numa-vmstat.node0=
.nr_slab_unreclaimable
>     344815 =C4=85124%     +90.1%     655331 =C4=85 67%  numa-vmstat.node0=
.nr_unevictable
>     132.00 =C4=85223%      -8.6%     120.67 =C4=85223%  numa-vmstat.node0=
.nr_written
>     589.83 =C4=85 21%      -5.2%     559.00 =C4=85 10%  numa-vmstat.node0=
.nr_zone_active_anon
>      66.00 =C4=85117%     -29.3%      46.67 =C4=85152%  numa-vmstat.node0=
.nr_zone_active_file
>      50051 =C4=85 19%     -20.7%      39679 =C4=85 35%  numa-vmstat.node0=
.nr_zone_inactive_anon
>     522.67 =C4=85129%     -48.4%     269.67 =C4=85200%  numa-vmstat.node0=
.nr_zone_inactive_file
>     344815 =C4=85124%     +90.1%     655331 =C4=85 67%  numa-vmstat.node0=
.nr_zone_unevictable
>       0.50 =C4=85223%      +0.0%       0.50 =C4=85223%  numa-vmstat.node0=
.nr_zone_write_pending
>     374134 =C4=85  6%      -4.1%     358690 =C4=85  7%  numa-vmstat.node0=
.numa_hit
>       0.00          -100.0%       0.00        numa-vmstat.node0.numa_inte=
rleave
>     328256 =C4=85 15%      -7.1%     304955 =C4=85 20%  numa-vmstat.node0=
.numa_local
>      45881 =C4=85 75%     +17.1%      53735 =C4=85 69%  numa-vmstat.node0=
.numa_other
>      11706 =C4=85  8%      +1.7%      11901 =C4=85  7%  numa-vmstat.node1=
.nr_active_anon
>      34.17 =C4=85219%     -54.1%      15.67 =C4=85 84%  numa-vmstat.node1=
.nr_active_file
>      55500 =C4=85 16%     -30.8%      38424 =C4=85 36%  numa-vmstat.node1=
.nr_anon_pages
>      75.50 =C4=85 18%     -43.7%      42.50 =C4=85 53%  numa-vmstat.node1=
.nr_anon_transparent_hugepages
>     132.00 =C4=85223%    -100.0%       0.00        numa-vmstat.node1.nr_d=
irtied
>       0.50 =C4=85223%    -100.0%       0.00        numa-vmstat.node1.nr_d=
irty
>     659985 =C4=85 65%     -47.0%     349484 =C4=85126%  numa-vmstat.node1=
.nr_file_pages
>   23904828            +1.4%   24236871        numa-vmstat.node1.nr_free_p=
ages
>      57826 =C4=85 16%     -30.5%      40197 =C4=85 34%  numa-vmstat.node1=
.nr_inactive_anon
>     313.00 =C4=85213%     -92.9%      22.33 =C4=85 96%  numa-vmstat.node1=
.nr_inactive_file
>       9043 =C4=85  4%      -3.3%       8740 =C4=85  5%  numa-vmstat.node1=
.nr_kernel_stack
>       6467 =C4=85 55%     -37.6%       4038 =C4=85 85%  numa-vmstat.node1=
.nr_mapped
>     601.50 =C4=85 21%      -1.6%     591.83 =C4=85  7%  numa-vmstat.node1=
.nr_page_table_pages
>      13261 =C4=85  9%      +2.8%      13630 =C4=85  8%  numa-vmstat.node1=
.nr_shmem
>      19538 =C4=85 34%     -25.9%      14481 =C4=85 47%  numa-vmstat.node1=
.nr_slab_reclaimable
>      21995 =C4=85  7%      -1.7%      21618 =C4=85  9%  numa-vmstat.node1=
.nr_slab_unreclaimable
>     646375 =C4=85 66%     -48.0%     335813 =C4=85131%  numa-vmstat.node1=
.nr_unevictable
>     132.00 =C4=85223%    -100.0%       0.00        numa-vmstat.node1.nr_w=
ritten
>      11706 =C4=85  8%      +1.7%      11901 =C4=85  7%  numa-vmstat.node1=
.nr_zone_active_anon
>      34.17 =C4=85219%     -54.1%      15.67 =C4=85 84%  numa-vmstat.node1=
.nr_zone_active_file
>      57826 =C4=85 16%     -30.5%      40197 =C4=85 34%  numa-vmstat.node1=
.nr_zone_inactive_anon
>     313.00 =C4=85213%     -92.9%      22.33 =C4=85 96%  numa-vmstat.node1=
.nr_zone_inactive_file
>     646375 =C4=85 66%     -48.0%     335813 =C4=85131%  numa-vmstat.node1=
.nr_zone_unevictable
>       0.50 =C4=85223%    -100.0%       0.00        numa-vmstat.node1.nr_z=
one_write_pending
>     429997 =C4=85  5%      +3.5%     444962 =C4=85  5%  numa-vmstat.node1=
.numa_hit
>       0.00          -100.0%       0.00        numa-vmstat.node1.numa_inte=
rleave
>     381801 =C4=85 13%      +6.0%     404613 =C4=85 14%  numa-vmstat.node1=
.numa_local
>      48195 =C4=85 71%     -16.3%      40348 =C4=85 92%  numa-vmstat.node1=
.numa_other
>       2.47 =C4=85  2%      -2.0%       2.42 =C4=85  5%  perf-stat.i.MPKI
>  3.282e+09            +0.7%  3.305e+09        perf-stat.i.branch-instruct=
ions
>       0.41            -0.1        0.33        perf-stat.i.branch-miss-rat=
e%
>   13547319           -16.6%   11300609        perf-stat.i.branch-misses
>      42.88            +0.7       43.53        perf-stat.i.cache-miss-rate=
%
>   17114713 =C4=85  3%      +1.4%   17346470 =C4=85  5%  perf-stat.i.cache=
-misses
>   40081707 =C4=85  2%      -0.0%   40073189 =C4=85  5%  perf-stat.i.cache=
-references
>       8192 =C4=85  2%      +1.4%       8311 =C4=85  4%  perf-stat.i.conte=
xt-switches
>       8.84            -0.8%       8.77        perf-stat.i.cpi
>     104007            +0.0%     104008        perf-stat.i.cpu-clock
>  1.446e+11            +0.1%  1.447e+11        perf-stat.i.cpu-cycles
>     140.10            -1.0%     138.76        perf-stat.i.cpu-migrations
>       8487 =C4=85  3%      -0.9%       8412 =C4=85  6%  perf-stat.i.cycle=
s-between-cache-misses
>       0.01 =C4=85  6%      -0.0        0.01        perf-stat.i.dTLB-load-=
miss-rate%
>     434358 =C4=85  3%     -16.9%     360889        perf-stat.i.dTLB-load-=
misses
>  4.316e+09            +1.3%  4.373e+09        perf-stat.i.dTLB-loads
>       0.00 =C4=85 15%      -0.0        0.00 =C4=85  9%  perf-stat.i.dTLB-=
store-miss-rate%
>      10408 =C4=85 11%      -2.6%      10135 =C4=85  8%  perf-stat.i.dTLB-=
store-misses
>  4.302e+08            +5.5%  4.539e+08        perf-stat.i.dTLB-stores
>      16.21 =C4=85  2%      -2.5       13.73 =C4=85 18%  perf-stat.i.iTLB-=
load-miss-rate%
>     394805 =C4=85  5%     -26.0%     292089 =C4=85  8%  perf-stat.i.iTLB-=
load-misses
>    2041963 =C4=85  3%      -8.3%    1872405 =C4=85 12%  perf-stat.i.iTLB-=
loads
>  1.638e+10            +1.0%  1.654e+10        perf-stat.i.instructions
>      41729 =C4=85  6%     +37.4%      57323 =C4=85  8%  perf-stat.i.instr=
uctions-per-iTLB-miss
>       0.11            +0.8%       0.11        perf-stat.i.ipc
>       0.01 =C4=85 55%      -1.5%       0.01 =C4=85 85%  perf-stat.i.major=
-faults
>       1.39            +0.1%       1.39        perf-stat.i.metric.GHz
>     468.46 =C4=85  2%      -1.5%     461.59 =C4=85  4%  perf-stat.i.metri=
c.K/sec
>      77.18            +1.3%      78.18        perf-stat.i.metric.M/sec
>       2473            -0.0%       2472        perf-stat.i.minor-faults
>      89.67            -0.5       89.18        perf-stat.i.node-load-miss-=
rate%
>    5070484           -10.3%    4547670        perf-stat.i.node-load-misse=
s
>     585336 =C4=85  2%      -5.5%     553260 =C4=85  8%  perf-stat.i.node-=
loads
>      98.73            +0.2       98.91        perf-stat.i.node-store-miss=
-rate%
>     935187            +2.2%     955923 =C4=85  3%  perf-stat.i.node-store=
-misses
>      13301 =C4=85  8%     -12.6%      11631 =C4=85  5%  perf-stat.i.node-=
stores
>       2473            -0.0%       2472        perf-stat.i.page-faults
>     104007            +0.0%     104008        perf-stat.i.task-clock
>       2.45 =C4=85  2%      -1.0%       2.42 =C4=85  5%  perf-stat.overall=
.MPKI
>       0.41            -0.1        0.34        perf-stat.overall.branch-mi=
ss-rate%
>      42.68            +0.6       43.26        perf-stat.overall.cache-mis=
s-rate%
>       8.83            -0.9%       8.75        perf-stat.overall.cpi
>       8459 =C4=85  3%      -1.0%       8372 =C4=85  6%  perf-stat.overall=
.cycles-between-cache-misses
>       0.01 =C4=85  3%      -0.0        0.01        perf-stat.overall.dTLB=
-load-miss-rate%
>       0.00 =C4=85 11%      -0.0        0.00 =C4=85  8%  perf-stat.overall=
.dTLB-store-miss-rate%
>      16.19 =C4=85  2%      -2.5       13.73 =C4=85 18%  perf-stat.overall=
.iTLB-load-miss-rate%
>      41644 =C4=85  6%     +37.0%      57047 =C4=85  8%  perf-stat.overall=
.instructions-per-iTLB-miss
>       0.11            +0.9%       0.11        perf-stat.overall.ipc
>      89.65            -0.5       89.15        perf-stat.overall.node-load=
-miss-rate%
>      98.59            +0.2       98.78        perf-stat.overall.node-stor=
e-miss-rate%
>   35314961           +28.0%   45213422 =C4=85  3%  perf-stat.overall.path=
-length
>  3.272e+09            +0.7%  3.295e+09        perf-stat.ps.branch-instruc=
tions
>   13563215           -16.5%   11329031        perf-stat.ps.branch-misses
>   17059170 =C4=85  3%      +1.3%   17288798 =C4=85  5%  perf-stat.ps.cach=
e-misses
>   39960738 =C4=85  2%      -0.0%   39951411 =C4=85  5%  perf-stat.ps.cach=
e-references
>       8205 =C4=85  2%      +1.4%       8320 =C4=85  4%  perf-stat.ps.cont=
ext-switches
>     103658            -0.0%     103657        perf-stat.ps.cpu-clock
>  1.441e+11            +0.1%  1.442e+11        perf-stat.ps.cpu-cycles
>     140.16            -1.0%     138.77        perf-stat.ps.cpu-migrations
>     433133 =C4=85  3%     -16.9%     359910        perf-stat.ps.dTLB-load=
-misses
>  4.302e+09            +1.3%  4.359e+09        perf-stat.ps.dTLB-loads
>      10392 =C4=85 11%      -2.6%      10120 =C4=85  8%  perf-stat.ps.dTLB=
-store-misses
>   4.29e+08            +5.5%  4.527e+08        perf-stat.ps.dTLB-stores
>     393499 =C4=85  5%     -26.0%     291118 =C4=85  8%  perf-stat.ps.iTLB=
-load-misses
>    2035052 =C4=85  3%      -8.3%    1866106 =C4=85 12%  perf-stat.ps.iTLB=
-loads
>  1.633e+10            +1.0%  1.649e+10        perf-stat.ps.instructions
>       0.01 =C4=85 55%      +0.1%       0.01 =C4=85 85%  perf-stat.ps.majo=
r-faults
>       2466            +0.0%       2466        perf-stat.ps.minor-faults
>    5053378           -10.3%    4532205        perf-stat.ps.node-load-miss=
es
>     583428 =C4=85  2%      -5.5%     551516 =C4=85  8%  perf-stat.ps.node=
-loads
>     932227            +2.2%     952780 =C4=85  3%  perf-stat.ps.node-stor=
e-misses
>      13342 =C4=85  8%     -12.1%      11729 =C4=85  6%  perf-stat.ps.node=
-stores
>       2466            +0.0%       2466        perf-stat.ps.page-faults
>     103658            -0.0%     103657        perf-stat.ps.task-clock
>  4.952e+12            +0.9%  4.994e+12        perf-stat.total.instruction=
s
>      10.88 =C4=85223%    -100.0%       0.00        sched_debug.cfs_rq:/.M=
IN_vruntime.avg
>       1132 =C4=85223%    -100.0%       0.00        sched_debug.cfs_rq:/.M=
IN_vruntime.max
>       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vr=
untime.min
>     110.47 =C4=85223%    -100.0%       0.00        sched_debug.cfs_rq:/.M=
IN_vruntime.stddev
>       0.53 =C4=85  4%      +7.4%       0.57 =C4=85  4%  sched_debug.cfs_r=
q:/.h_nr_running.avg
>       1.03 =C4=85  7%      -3.2%       1.00        sched_debug.cfs_rq:/.h=
_nr_running.max
>       0.45 =C4=85  2%      -1.9%       0.44 =C4=85  3%  sched_debug.cfs_r=
q:/.h_nr_running.stddev
>      11896 =C4=85 12%      -0.1%      11883 =C4=85 13%  sched_debug.cfs_r=
q:/.load.avg
>     123097 =C4=85123%     -80.1%      24487 =C4=85 18%  sched_debug.cfs_r=
q:/.load.max
>      19029 =C4=85 74%     -49.9%       9525 =C4=85 13%  sched_debug.cfs_r=
q:/.load.stddev
>      22.63 =C4=85 23%      +1.4%      22.93 =C4=85 16%  sched_debug.cfs_r=
q:/.load_avg.avg
>     530.85 =C4=85 73%     -13.1%     461.19 =C4=85 43%  sched_debug.cfs_r=
q:/.load_avg.max
>      73.53 =C4=85 46%      -7.1%      68.30 =C4=85 33%  sched_debug.cfs_r=
q:/.load_avg.stddev
>      10.88 =C4=85223%    -100.0%       0.00        sched_debug.cfs_rq:/.m=
ax_vruntime.avg
>       1132 =C4=85223%    -100.0%       0.00        sched_debug.cfs_rq:/.m=
ax_vruntime.max
>       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vr=
untime.min
>     110.47 =C4=85223%    -100.0%       0.00        sched_debug.cfs_rq:/.m=
ax_vruntime.stddev
>    3883756 =C4=85 13%     +12.7%    4377466 =C4=85  4%  sched_debug.cfs_r=
q:/.min_vruntime.avg
>    6993455 =C4=85 10%      +6.5%    7445221 =C4=85  2%  sched_debug.cfs_r=
q:/.min_vruntime.max
>     219925 =C4=85 60%     +43.7%     315970 =C4=85 71%  sched_debug.cfs_r=
q:/.min_vruntime.min
>    2240239 =C4=85 11%     +14.0%    2554847 =C4=85 14%  sched_debug.cfs_r=
q:/.min_vruntime.stddev
>       0.53 =C4=85  5%      +7.5%       0.57 =C4=85  4%  sched_debug.cfs_r=
q:/.nr_running.avg
>       1.03 =C4=85  7%      -3.2%       1.00        sched_debug.cfs_rq:/.n=
r_running.max
>       0.45 =C4=85  2%      -1.9%       0.44 =C4=85  3%  sched_debug.cfs_r=
q:/.nr_running.stddev
>       6.96 =C4=85 55%     +26.9%       8.83 =C4=85 45%  sched_debug.cfs_r=
q:/.removed.load_avg.avg
>     305.28 =C4=85 32%     +39.3%     425.39 =C4=85 44%  sched_debug.cfs_r=
q:/.removed.load_avg.max
>      42.94 =C4=85 36%     +34.4%      57.70 =C4=85 42%  sched_debug.cfs_r=
q:/.removed.load_avg.stddev
>       2.96 =C4=85 58%     +39.1%       4.12 =C4=85 48%  sched_debug.cfs_r=
q:/.removed.runnable_avg.avg
>     150.06 =C4=85 34%     +44.0%     216.03 =C4=85 45%  sched_debug.cfs_r=
q:/.removed.runnable_avg.max
>      19.33 =C4=85 42%     +42.6%      27.56 =C4=85 45%  sched_debug.cfs_r=
q:/.removed.runnable_avg.stddev
>       2.96 =C4=85 58%     +39.1%       4.12 =C4=85 48%  sched_debug.cfs_r=
q:/.removed.util_avg.avg
>     150.06 =C4=85 34%     +44.0%     216.03 =C4=85 45%  sched_debug.cfs_r=
q:/.removed.util_avg.max
>      19.33 =C4=85 42%     +42.6%      27.56 =C4=85 45%  sched_debug.cfs_r=
q:/.removed.util_avg.stddev
>     540.76 =C4=85  6%      +7.5%     581.25 =C4=85  5%  sched_debug.cfs_r=
q:/.runnable_avg.avg
>       1060 =C4=85  2%      +2.5%       1087 =C4=85  3%  sched_debug.cfs_r=
q:/.runnable_avg.max
>     442.07 =C4=85  4%      -0.1%     441.69 =C4=85  5%  sched_debug.cfs_r=
q:/.runnable_avg.stddev
>    3123464 =C4=85 14%     +10.0%    3436745 =C4=85  3%  sched_debug.cfs_r=
q:/.spread0.avg
>    6233151 =C4=85 10%      +4.4%    6504505 =C4=85  3%  sched_debug.cfs_r=
q:/.spread0.max
>    -540338           +15.6%    -624739        sched_debug.cfs_rq:/.spread=
0.min
>    2240217 =C4=85 11%     +14.0%    2554844 =C4=85 14%  sched_debug.cfs_r=
q:/.spread0.stddev
>     540.71 =C4=85  6%      +7.5%     581.22 =C4=85  5%  sched_debug.cfs_r=
q:/.util_avg.avg
>       1060 =C4=85  2%      +2.5%       1086 =C4=85  3%  sched_debug.cfs_r=
q:/.util_avg.max
>     442.07 =C4=85  4%      -0.1%     441.67 =C4=85  5%  sched_debug.cfs_r=
q:/.util_avg.stddev
>     454.69 =C4=85  6%      +7.0%     486.47 =C4=85  8%  sched_debug.cfs_r=
q:/.util_est_enqueued.avg
>       1024            -0.0%       1023        sched_debug.cfs_rq:/.util_e=
st_enqueued.max
>     396.02 =C4=85  2%      -0.1%     395.79        sched_debug.cfs_rq:/.u=
til_est_enqueued.stddev
>     642171 =C4=85  4%     +16.6%     748912 =C4=85  2%  sched_debug.cpu.a=
vg_idle.avg
>    1051166            -1.2%    1038098        sched_debug.cpu.avg_idle.ma=
x
>       2402 =C4=85  5%     +28.5%       3088 =C4=85  9%  sched_debug.cpu.a=
vg_idle.min
>     384501 =C4=85  3%     -12.3%     337306 =C4=85  5%  sched_debug.cpu.a=
vg_idle.stddev
>     198632 =C4=85  7%      +5.1%     208788        sched_debug.cpu.clock.=
avg
>     198638 =C4=85  7%      +5.1%     208794        sched_debug.cpu.clock.=
max
>     198626 =C4=85  7%      +5.1%     208783        sched_debug.cpu.clock.=
min
>       3.25            +2.3%       3.32 =C4=85  5%  sched_debug.cpu.clock.=
stddev
>     196832 =C4=85  7%      +5.1%     206882        sched_debug.cpu.clock_=
task.avg
>     197235 =C4=85  7%      +5.1%     207282        sched_debug.cpu.clock_=
task.max
>     181004 =C4=85  7%      +5.7%     191329        sched_debug.cpu.clock_=
task.min
>       1575 =C4=85  3%      -1.8%       1546        sched_debug.cpu.clock_=
task.stddev
>       2411 =C4=85  4%      +2.8%       2478        sched_debug.cpu.curr->=
pid.avg
>       8665 =C4=85  4%      +3.1%       8935        sched_debug.cpu.curr->=
pid.max
>       2522 =C4=85  2%      +1.0%       2548        sched_debug.cpu.curr->=
pid.stddev
>     501318            -0.0%     501249        sched_debug.cpu.max_idle_ba=
lance_cost.avg
>     528365            +0.5%     531236 =C4=85  2%  sched_debug.cpu.max_id=
le_balance_cost.max
>     500000            +0.0%     500000        sched_debug.cpu.max_idle_ba=
lance_cost.min
>       5157 =C4=85 19%      -4.2%       4941 =C4=85 23%  sched_debug.cpu.m=
ax_idle_balance_cost.stddev
>       4294            +0.0%       4294        sched_debug.cpu.next_balanc=
e.avg
>       4294            +0.0%       4294        sched_debug.cpu.next_balanc=
e.max
>       4294            +0.0%       4294        sched_debug.cpu.next_balanc=
e.min
>       0.00 =C4=85 41%     -40.0%       0.00 =C4=85 13%  sched_debug.cpu.n=
ext_balance.stddev
>       0.44 =C4=85  4%      +2.4%       0.45        sched_debug.cpu.nr_run=
ning.avg
>       1.00            +0.0%       1.00        sched_debug.cpu.nr_running.=
max
>       0.47            +0.5%       0.47        sched_debug.cpu.nr_running.=
stddev
>      14345 =C4=85  8%      +6.7%      15305 =C4=85  4%  sched_debug.cpu.n=
r_switches.avg
>      30800 =C4=85  8%     +34.5%      41437 =C4=85 10%  sched_debug.cpu.n=
r_switches.max
>       4563 =C4=85 28%      +5.7%       4822 =C4=85 25%  sched_debug.cpu.n=
r_switches.min
>       5491 =C4=85  8%     +26.4%       6941 =C4=85 10%  sched_debug.cpu.n=
r_switches.stddev
>  2.111e+09 =C4=85  7%      +1.5%  2.142e+09 =C4=85  6%  sched_debug.cpu.n=
r_uninterruptible.avg
>  4.295e+09            +0.0%  4.295e+09        sched_debug.cpu.nr_uninterr=
uptible.max
>   2.14e+09            +0.1%  2.143e+09        sched_debug.cpu.nr_uninterr=
uptible.stddev
>     198627 =C4=85  7%      +5.1%     208783        sched_debug.cpu_clk
>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->b=
w.avg
>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->b=
w.max
>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->b=
w.min
>  4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
>     198022 =C4=85  7%      +5.1%     208178        sched_debug.ktime
>     950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runti=
me.avg
>     950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runti=
me.max
>     950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runti=
me.min
>     199377 =C4=85  7%      +5.1%     209531        sched_debug.sched_clk
>       1.00            +0.0%       1.00        sched_debug.sched_clock_sta=
ble()
>   58611259            +0.0%   58611259        sched_debug.sysctl_sched.sy=
sctl_sched_features
>       0.75            +0.0%       0.75        sched_debug.sysctl_sched.sy=
sctl_sched_idle_min_granularity
>      24.00            +0.0%      24.00        sched_debug.sysctl_sched.sy=
sctl_sched_latency
>       3.00            +0.0%       3.00        sched_debug.sysctl_sched.sy=
sctl_sched_min_granularity
>       1.00            +0.0%       1.00        sched_debug.sysctl_sched.sy=
sctl_sched_tunable_scaling
>       4.00            +0.0%       4.00        sched_debug.sysctl_sched.sy=
sctl_sched_wakeup_granularity
>      20.90 =C4=85 47%      -6.4       14.49 =C4=85100%  perf-profile.call=
trace.cycles-pp.mwait_idle_with_hints.intel_idle.cpuidle_enter_state.cpuidl=
e_enter.cpuidle_idle_call
>      20.90 =C4=85 47%      -6.4       14.49 =C4=85100%  perf-profile.call=
trace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_c=
all.do_idle
>       0.48 =C4=85 44%      -0.5        0.00        perf-profile.calltrace=
.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.__mmap
>      29.41 =C4=85 19%      -0.2       29.23 =C4=85 18%  perf-profile.call=
trace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle=
.cpu_startup_entry
>      35.02 =C4=85  8%      -0.2       34.86 =C4=85  7%  perf-profile.call=
trace.cycles-pp.__mmap
>      34.95 =C4=85  8%      -0.1       34.81 =C4=85  7%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
>      34.92 =C4=85  8%      -0.1       34.79 =C4=85  7%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
>      34.87 =C4=85  8%      -0.1       34.74 =C4=85  7%  perf-profile.call=
trace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.=
__mmap
>       0.41 =C4=85 74%      -0.1        0.30 =C4=85156%  perf-profile.call=
trace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kerne=
l.secondary_startup_64_no_verify
>       0.41 =C4=85 74%      -0.1        0.30 =C4=85156%  perf-profile.call=
trace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.sta=
rt_kernel
>       0.41 =C4=85 74%      -0.1        0.30 =C4=85156%  perf-profile.call=
trace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_=
call_rest_init
>       0.41 =C4=85 74%      -0.1        0.30 =C4=85156%  perf-profile.call=
trace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.r=
est_init
>       0.41 =C4=85 74%      -0.1        0.30 =C4=85156%  perf-profile.call=
trace.cycles-pp.start_kernel.secondary_startup_64_no_verify
>       0.41 =C4=85 74%      -0.1        0.30 =C4=85156%  perf-profile.call=
trace.cycles-pp.arch_call_rest_init.start_kernel.secondary_startup_64_no_ve=
rify
>       0.41 =C4=85 74%      -0.1        0.30 =C4=85156%  perf-profile.call=
trace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.secondary_startu=
p_64_no_verify
>      29.59 =C4=85 19%      -0.1       29.50 =C4=85 17%  perf-profile.call=
trace.cycles-pp.secondary_startup_64_no_verify
>      29.03 =C4=85 19%      -0.1       28.95 =C4=85 17%  perf-profile.call=
trace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_v=
erify
>      29.03 =C4=85 19%      -0.1       28.95 =C4=85 17%  perf-profile.call=
trace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup=
_64_no_verify
>      29.03 =C4=85 19%      -0.1       28.95 =C4=85 17%  perf-profile.call=
trace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>      29.00 =C4=85 19%      -0.1       28.93 =C4=85 17%  perf-profile.call=
trace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary=
.secondary_startup_64_no_verify
>      29.00 =C4=85 19%      -0.1       28.93 =C4=85 17%  perf-profile.call=
trace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.s=
tart_secondary
>      33.56 =C4=85  8%      -0.0       33.53 =C4=85  7%  perf-profile.call=
trace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.do=
wn_write_killable.vm_mmap_pgoff
>      34.26 =C4=85  8%      -0.0       34.24 =C4=85  7%  perf-profile.call=
trace.cycles-pp.down_write_killable.vm_mmap_pgoff.do_syscall_64.entry_SYSCA=
LL_64_after_hwframe.__mmap
>      34.23 =C4=85  8%      -0.0       34.21 =C4=85  7%  perf-profile.call=
trace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff=
.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      34.19 =C4=85  8%      -0.0       34.18 =C4=85  7%  perf-profile.call=
trace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_=
killable.vm_mmap_pgoff.do_syscall_64
>       0.44 =C4=85 44%      +0.0        0.48 =C4=85 44%  perf-profile.call=
trace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_=
slowpath.down_write_killable.__vm_munmap
>       0.45 =C4=85 44%      +0.0        0.48 =C4=85 44%  perf-profile.call=
trace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_=
slowpath.down_write_killable.vm_mmap_pgoff
>      33.62 =C4=85  8%      +0.1       33.71 =C4=85  7%  perf-profile.call=
trace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.do=
wn_write_killable.__vm_munmap
>      34.32 =C4=85  8%      +0.1       34.42 =C4=85  7%  perf-profile.call=
trace.cycles-pp.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall=
_64.entry_SYSCALL_64_after_hwframe
>      34.29 =C4=85  8%      +0.1       34.39 =C4=85  7%  perf-profile.call=
trace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.__vm_munmap._=
_x64_sys_munmap.do_syscall_64
>      34.25 =C4=85  8%      +0.1       34.36 =C4=85  7%  perf-profile.call=
trace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_=
killable.__vm_munmap.__x64_sys_munmap
>      35.11 =C4=85  8%      +0.2       35.31 =C4=85  7%  perf-profile.call=
trace.cycles-pp.__munmap
>      35.04 =C4=85  8%      +0.2       35.25 =C4=85  7%  perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
>      35.02 =C4=85  8%      +0.2       35.24 =C4=85  7%  perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
>       0.00            +0.2        0.22 =C4=85223%  perf-profile.calltrace=
.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_ca=
ll.do_idle
>      34.97 =C4=85  8%      +0.2       35.20 =C4=85  7%  perf-profile.call=
trace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64=
_after_hwframe.__munmap
>      34.97 =C4=85  8%      +0.2       35.20 =C4=85  7%  perf-profile.call=
trace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.__munmap
>       0.47 =C4=85 44%      +0.2        0.70 =C4=85  7%  perf-profile.call=
trace.cycles-pp.do_mas_align_munmap.__vm_munmap.__x64_sys_munmap.do_syscall=
_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.4        0.44 =C4=85223%  perf-profile.calltrace=
.cycles-pp.asm_sysvec_apic_timer_interrupt.mwait_idle_with_hints.intel_idle=
_irq.cpuidle_enter_state.cpuidle_enter
>       8.27 =C4=85 91%      +6.2       14.46 =C4=85 77%  perf-profile.call=
trace.cycles-pp.mwait_idle_with_hints.intel_idle_ibrs.cpuidle_enter_state.c=
puidle_enter.cpuidle_idle_call
>       8.27 =C4=85 91%      +6.2       14.46 =C4=85 77%  perf-profile.call=
trace.cycles-pp.intel_idle_ibrs.cpuidle_enter_state.cpuidle_enter.cpuidle_i=
dle_call.do_idle
>      21.09 =C4=85 47%      -6.5       14.62 =C4=85 99%  perf-profile.chil=
dren.cycles-pp.intel_idle
>      35.02 =C4=85  8%      -0.2       34.86 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__mmap
>       0.14 =C4=85  9%      -0.1        0.00        perf-profile.children.=
cycles-pp.thp_get_unmapped_area
>      34.87 =C4=85  8%      -0.1       34.74 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.vm_mmap_pgoff
>       0.55 =C4=85  9%      -0.1        0.46 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.do_mmap
>      29.59 =C4=85 19%      -0.1       29.50 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.secondary_startup_64_no_verify
>      29.59 =C4=85 19%      -0.1       29.50 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.cpu_startup_entry
>      29.59 =C4=85 19%      -0.1       29.50 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.do_idle
>      29.03 =C4=85 19%      -0.1       28.95 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.start_secondary
>      29.56 =C4=85 19%      -0.1       29.49 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.cpuidle_idle_call
>      29.56 =C4=85 19%      -0.1       29.48 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.cpuidle_enter
>      29.56 =C4=85 19%      -0.1       29.48 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.cpuidle_enter_state
>      29.52 =C4=85 19%      -0.1       29.45 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.mwait_idle_with_hints
>       0.38 =C4=85  9%      -0.1        0.32 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.mmap_region
>       0.05 =C4=85  7%      -0.1        0.00        perf-profile.children.=
cycles-pp.unmap_vmas
>       0.11 =C4=85  8%      -0.1        0.06 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.unmap_region
>       0.16 =C4=85 10%      -0.0        0.13 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.get_unmapped_area
>       0.07 =C4=85  7%      -0.0        0.03 =C4=85 70%  perf-profile.chil=
dren.cycles-pp.mas_find
>       0.05 =C4=85 44%      -0.0        0.02 =C4=85141%  perf-profile.chil=
dren.cycles-pp.mas_wr_node_store
>       0.10 =C4=85 10%      -0.0        0.07 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.mas_spanning_rebalance
>       0.14 =C4=85  9%      -0.0        0.11 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.arch_get_unmapped_area_topdown
>       0.06 =C4=85 11%      -0.0        0.04 =C4=85 72%  perf-profile.chil=
dren.cycles-pp.__schedule
>       0.14 =C4=85 10%      -0.0        0.11 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.vm_unmapped_area
>       0.07 =C4=85 10%      -0.0        0.04 =C4=85 45%  perf-profile.chil=
dren.cycles-pp.do_mas_munmap
>       0.02 =C4=85 99%      -0.0        0.00        perf-profile.children.=
cycles-pp.mas_next_entry
>       0.04 =C4=85 44%      -0.0        0.02 =C4=85141%  perf-profile.chil=
dren.cycles-pp.schedule
>       0.06 =C4=85  9%      -0.0        0.04 =C4=85 71%  perf-profile.chil=
dren.cycles-pp.mas_wr_modify
>       0.10 =C4=85  8%      -0.0        0.08 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.mas_rev_awalk
>       0.10 =C4=85 12%      -0.0        0.08 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.mas_wr_spanning_store
>       0.06 =C4=85  7%      -0.0        0.04 =C4=85 45%  perf-profile.chil=
dren.cycles-pp.mas_walk
>       0.09 =C4=85 11%      -0.0        0.08 =C4=85 16%  perf-profile.chil=
dren.cycles-pp.syscall_exit_to_user_mode
>       0.02 =C4=85141%      -0.0        0.00        perf-profile.children.=
cycles-pp.perf_event_mmap
>       0.02 =C4=85141%      -0.0        0.00        perf-profile.children.=
cycles-pp.unmap_page_range
>       0.11 =C4=85 26%      -0.0        0.10 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.__get_user_nocheck_8
>       0.35 =C4=85 19%      -0.0        0.34 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.perf_tp_event
>       0.11 =C4=85 26%      -0.0        0.10 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.perf_callchain_user
>       0.34 =C4=85 19%      -0.0        0.33 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.__perf_event_overflow
>       0.34 =C4=85 19%      -0.0        0.33 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.perf_event_output_forward
>       0.31 =C4=85 19%      -0.0        0.30 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.perf_prepare_sample
>       0.30 =C4=85 19%      -0.0        0.29 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.perf_callchain
>       0.30 =C4=85 19%      -0.0        0.29 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.get_perf_callchain
>       0.12 =C4=85  9%      -0.0        0.11 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.mas_empty_area_rev
>       0.08 =C4=85  7%      -0.0        0.07 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.syscall_return_via_sysret
>       0.01 =C4=85223%      -0.0        0.00        perf-profile.children.=
cycles-pp.mas_wr_bnode
>       0.01 =C4=85223%      -0.0        0.00        perf-profile.children.=
cycles-pp.perf_event_mmap_event
>       0.01 =C4=85223%      -0.0        0.00        perf-profile.children.=
cycles-pp.__entry_text_start
>       0.33 =C4=85 10%      -0.0        0.32 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.mas_store_prealloc
>       0.32 =C4=85 20%      -0.0        0.32 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.update_curr
>       0.32 =C4=85 19%      -0.0        0.31 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.perf_trace_sched_stat_runtime
>       0.56 =C4=85 22%      -0.0        0.56 =C4=85 58%  perf-profile.chil=
dren.cycles-pp.start_kernel
>       0.56 =C4=85 22%      -0.0        0.56 =C4=85 58%  perf-profile.chil=
dren.cycles-pp.arch_call_rest_init
>       0.56 =C4=85 22%      -0.0        0.56 =C4=85 58%  perf-profile.chil=
dren.cycles-pp.rest_init
>       0.07 =C4=85 45%      -0.0        0.07 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.native_irq_return_iret
>       0.01 =C4=85223%      +0.0        0.01 =C4=85223%  perf-profile.chil=
dren.cycles-pp.ktime_get_update_offsets_now
>       0.06 =C4=85 45%      +0.0        0.06 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.asm_exc_page_fault
>       0.18 =C4=85 16%      +0.0        0.18 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.perf_callchain_kernel
>       0.12 =C4=85 16%      +0.0        0.12 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.unwind_next_frame
>       0.36 =C4=85 18%      +0.0        0.37 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.task_tick_fair
>       0.58 =C4=85 14%      +0.0        0.58 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.hrtimer_interrupt
>       0.49 =C4=85 14%      +0.0        0.50 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.__hrtimer_run_queues
>       0.05 =C4=85 46%      +0.0        0.05 =C4=85 45%  perf-profile.chil=
dren.cycles-pp.__unwind_start
>       0.45 =C4=85 14%      +0.0        0.46 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.tick_sched_handle
>       0.46 =C4=85 14%      +0.0        0.46 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.tick_sched_timer
>       0.45 =C4=85 15%      +0.0        0.45 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.update_process_times
>       0.06 =C4=85 11%      +0.0        0.07 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.kmem_cache_free_bulk
>       0.58 =C4=85 14%      +0.0        0.58 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.__sysvec_apic_timer_interrupt
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.children.=
cycles-pp.record__mmap_read_evlist
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.children.=
cycles-pp.perf_mmap__push
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.children.=
cycles-pp.record__pushfn
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.children.=
cycles-pp.ksys_write
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.children.=
cycles-pp.vfs_write
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.children.=
cycles-pp.__libc_write
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.children.=
cycles-pp.generic_file_write_iter
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.children.=
cycles-pp.__generic_file_write_iter
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.children.=
cycles-pp.generic_perform_write
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.children.=
cycles-pp.build_id__mark_dso_hit
>       0.39 =C4=85 17%      +0.0        0.40 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.scheduler_tick
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.children.=
cycles-pp.clockevents_program_event
>       0.05 =C4=85 45%      +0.0        0.06 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.mas_wr_store_entry
>       0.60 =C4=85 14%      +0.0        0.61 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.sysvec_apic_timer_interrupt
>       0.08 =C4=85  8%      +0.0        0.10 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.mas_destroy
>       0.08 =C4=85  9%      +0.0        0.09 =C4=85 21%  perf-profile.chil=
dren.cycles-pp.perf_session__deliver_event
>       0.08 =C4=85 12%      +0.0        0.09 =C4=85 33%  perf-profile.chil=
dren.cycles-pp.ordered_events__queue
>       0.08 =C4=85 11%      +0.0        0.10 =C4=85 22%  perf-profile.chil=
dren.cycles-pp.__ordered_events__flush
>       0.08 =C4=85  9%      +0.0        0.10 =C4=85 22%  perf-profile.chil=
dren.cycles-pp.perf_session__process_user_event
>       0.06 =C4=85 13%      +0.0        0.08 =C4=85 14%  perf-profile.chil=
dren.cycles-pp.kmem_cache_alloc
>       0.07 =C4=85  9%      +0.0        0.09 =C4=85 33%  perf-profile.chil=
dren.cycles-pp.queue_event
>       0.08 =C4=85  8%      +0.0        0.10 =C4=85 31%  perf-profile.chil=
dren.cycles-pp.process_simple
>       0.00            +0.0        0.03 =C4=85100%  perf-profile.children.=
cycles-pp.evlist__parse_sample
>       0.06 =C4=85  6%      +0.0        0.08 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.memset_erms
>       0.22 =C4=85  7%      +0.0        0.26 =C4=85 23%  perf-profile.chil=
dren.cycles-pp.__libc_start_main
>       0.22 =C4=85  7%      +0.0        0.26 =C4=85 23%  perf-profile.chil=
dren.cycles-pp.main
>       0.22 =C4=85  7%      +0.0        0.26 =C4=85 23%  perf-profile.chil=
dren.cycles-pp.run_builtin
>       0.21 =C4=85  9%      +0.0        0.25 =C4=85 23%  perf-profile.chil=
dren.cycles-pp.cmd_record
>       0.21 =C4=85  9%      +0.0        0.25 =C4=85 23%  perf-profile.chil=
dren.cycles-pp.__cmd_record
>       0.20 =C4=85  9%      +0.0        0.24 =C4=85 24%  perf-profile.chil=
dren.cycles-pp.cmd_sched
>       0.17 =C4=85 11%      +0.0        0.21 =C4=85 25%  perf-profile.chil=
dren.cycles-pp.reader__read_event
>       0.17 =C4=85 11%      +0.0        0.21 =C4=85 26%  perf-profile.chil=
dren.cycles-pp.record__finish_output
>       0.17 =C4=85 11%      +0.0        0.21 =C4=85 26%  perf-profile.chil=
dren.cycles-pp.perf_session__process_events
>       0.00            +0.0        0.04 =C4=85 45%  perf-profile.children.=
cycles-pp.kmem_cache_free
>       0.17 =C4=85  7%      +0.1        0.22 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.mas_alloc_nodes
>       0.11 =C4=85  9%      +0.1        0.17 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.kmem_cache_alloc_bulk
>       0.00            +0.1        0.06 =C4=85 13%  perf-profile.children.=
cycles-pp.vm_area_dup
>       0.16 =C4=85  8%      +0.1        0.22 =C4=85  6%  perf-profile.chil=
dren.cycles-pp.mas_preallocate
>      67.20 =C4=85  8%      +0.1       67.28 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.osq_lock
>      68.59 =C4=85  8%      +0.1       68.66 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.down_write_killable
>       1.04 =C4=85  8%      +0.1        1.12 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.rwsem_spin_on_owner
>      70.08 =C4=85  8%      +0.1       70.15 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.entry_SYSCALL_64_after_hwframe
>      68.52 =C4=85  8%      +0.1       68.60 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.rwsem_down_write_slowpath
>      70.03 =C4=85  8%      +0.1       70.11 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.do_syscall_64
>      68.46 =C4=85  8%      +0.1       68.55 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.rwsem_optimistic_spin
>       0.55 =C4=85  8%      +0.2        0.71 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.do_mas_align_munmap
>      35.12 =C4=85  8%      +0.2       35.31 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__munmap
>       0.00            +0.2        0.22 =C4=85  7%  perf-profile.children.=
cycles-pp.vma_expand
>       0.00            +0.2        0.22 =C4=85223%  perf-profile.children.=
cycles-pp.intel_idle_irq
>      34.98 =C4=85  8%      +0.2       35.20 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__x64_sys_munmap
>      34.97 =C4=85  8%      +0.2       35.20 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__vm_munmap
>       0.64 =C4=85 13%      +0.2        0.88 =C4=85 55%  perf-profile.chil=
dren.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.00            +0.3        0.30 =C4=85  7%  perf-profile.children.=
cycles-pp.__vma_adjust
>       0.00            +0.4        0.36 =C4=85  6%  perf-profile.children.=
cycles-pp.__split_vma
>       8.42 =C4=85 91%      +6.2       14.60 =C4=85 77%  perf-profile.chil=
dren.cycles-pp.intel_idle_ibrs
>      29.52 =C4=85 19%      -0.1       29.45 =C4=85 17%  perf-profile.self=
.cycles-pp.mwait_idle_with_hints
>       0.18 =C4=85  9%      -0.1        0.12 =C4=85 10%  perf-profile.self=
.cycles-pp.rwsem_optimistic_spin
>       0.04 =C4=85 45%      -0.0        0.00        perf-profile.self.cycl=
es-pp.entry_SYSCALL_64_after_hwframe
>       0.04 =C4=85 44%      -0.0        0.00        perf-profile.self.cycl=
es-pp.mmap_region
>       0.10 =C4=85  5%      -0.0        0.08 =C4=85  9%  perf-profile.self=
.cycles-pp.mas_rev_awalk
>       0.06 =C4=85  7%      -0.0        0.04 =C4=85 45%  perf-profile.self=
.cycles-pp.mas_walk
>       0.06 =C4=85 11%      -0.0        0.04 =C4=85 45%  perf-profile.self=
.cycles-pp.do_mas_align_munmap
>       0.08 =C4=85  8%      -0.0        0.07 =C4=85 14%  perf-profile.self=
.cycles-pp.syscall_exit_to_user_mode
>       0.08 =C4=85  7%      -0.0        0.07 =C4=85  8%  perf-profile.self=
.cycles-pp.syscall_return_via_sysret
>       0.06 =C4=85 13%      -0.0        0.05 =C4=85  7%  perf-profile.self=
.cycles-pp.down_write_killable
>       0.07 =C4=85 45%      -0.0        0.07 =C4=85 11%  perf-profile.self=
.cycles-pp.native_irq_return_iret
>       0.05 =C4=85 45%      -0.0        0.05 =C4=85 47%  perf-profile.self=
.cycles-pp.unwind_next_frame
>       0.00            +0.0        0.01 =C4=85223%  perf-profile.self.cycl=
es-pp.ktime_get_update_offsets_now
>       0.05 =C4=85 45%      +0.0        0.06 =C4=85 11%  perf-profile.self=
.cycles-pp.kmem_cache_free_bulk
>       0.00            +0.0        0.02 =C4=85141%  perf-profile.self.cycl=
es-pp.kmem_cache_free
>       0.07 =C4=85  8%      +0.0        0.09 =C4=85 33%  perf-profile.self=
.cycles-pp.queue_event
>       0.06 =C4=85  8%      +0.0        0.08 =C4=85  8%  perf-profile.self=
.cycles-pp.memset_erms
>       0.04 =C4=85 45%      +0.0        0.08 =C4=85  6%  perf-profile.self=
.cycles-pp.kmem_cache_alloc_bulk
>      66.61 =C4=85  8%      +0.1       66.68 =C4=85  7%  perf-profile.self=
.cycles-pp.osq_lock
>       1.02 =C4=85  8%      +0.1        1.10 =C4=85  7%  perf-profile.self=
.cycles-pp.rwsem_spin_on_owner
>
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202212151657.5d11a672-yujie.liu@in=
tel.com
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
