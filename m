Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BAB69E5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjBUR0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjBUR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:26:34 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AC62A6FF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:26:24 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 130so285151pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677000384;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWfbWCbQOd21ayOdEdCyo+dq6wAQ9+XOhCJUTtQf6eg=;
        b=kyQKNLnUUPA89Bx2QcnD495bCdWqNuZ+6Spj1vK3/ta839KaYGPrzm/haSoGKXjVks
         09wUvBbnLHC8TbvDqNgx9mL2C+GpVuYKyz4b6XWJxbkfo76lFtPA7pPE62rNF/Wa8JGW
         cKCR4BwcIMV+KYh/45PIbBjdiWvBA4jnkeI1H2HK54WauKjfHNoICDOI0W6wNKaU4nYX
         QIHyVveEDu8qj4FBZckRHCeiugoL9a6U8OWBfxbrC0Lq6TyysUD/or9Q6Ro5FmMlGrOn
         8qDAvz/+i8/ldJmfwMItn6uJZr95G5Uw3wJDBNGzU0gud8I8LLlBsbo/4ijzaA/oogeq
         FuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677000384;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWfbWCbQOd21ayOdEdCyo+dq6wAQ9+XOhCJUTtQf6eg=;
        b=RUIjS4DqRCUhCD6woA1wuHe6PrkVqyFBaHptWxfPViMtShp6jWE9amAYSCWvNiCA3T
         OTbNWmXv5+fYilUodrMQiILI568PgkLUj/TceN/ipQznxq6xPnm3AKhdjWlSKXm1Wlzq
         H67cS5ammbBSdF9y5eG6lWdKwaq6GIEPbZYOmcFinHxjC1/Wu6CxgTYq7i8tddJ7Dz0+
         IxTPOIQG3U8i7Ukfpn1frBiwx3MfYdlYupWP4axy3Km833WxaPaCNPn6FrVfYK+Co8XD
         4VRFbuU+g8LrUjUj4PI7aX0k16exOYDLTPbSRlrSRYIbMCWqHgt5M5NrfD1/Um8F1bmW
         ewcA==
X-Gm-Message-State: AO0yUKUtxWuMyCKXGOz42IXgmwQELkFXjSSxkTX3ZxoZ+2kMjnoH2adN
        hCLs+qsr4MW23NfQzP7z6YoxSU02RbRtAsJSNHBq2g==
X-Google-Smtp-Source: AK7set/Ouu1jJ00KnBaBkbq8mV2QLpBhST2s/6dxEz++HM29eJUIF+MZg5iI5e2TFCXdAKPTwyDe/ae0GHbUP/pNvvk=
X-Received: by 2002:a62:d441:0:b0:5ac:44d6:c260 with SMTP id
 u1-20020a62d441000000b005ac44d6c260mr766716pfl.31.1677000383656; Tue, 21 Feb
 2023 09:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20230209193107.1432770-1-rkagan@amazon.de> <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
 <Y/T36NvaCxSfS8Z/@u40bc5e070a0153.ant.amazon.com>
In-Reply-To: <Y/T36NvaCxSfS8Z/@u40bc5e070a0153.ant.amazon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Feb 2023 18:26:11 +0100
Message-ID: <CAKfTPtCDxdVEmPQf=6g7n7Y+bkozXAJT1NG92wDc_quNaDiHMg@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
To:     Roman Kagan <rkagan@amazon.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ben Segall <bsegall@google.com>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 at 17:57, Roman Kagan <rkagan@amazon.de> wrote:
>
> On Tue, Feb 21, 2023 at 10:38:44AM +0100, Vincent Guittot wrote:
> > On Thu, 9 Feb 2023 at 20:31, Roman Kagan <rkagan@amazon.de> wrote:
> > >
> > > From: Zhang Qiao <zhangqiao22@huawei.com>
> > >
> > > When a scheduling entity is placed onto cfs_rq, its vruntime is pulle=
d
> > > to the base level (around cfs_rq->min_vruntime), so that the entity
> > > doesn't gain extra boost when placed backwards.
> > >
> > > However, if the entity being placed wasn't executed for a long time, =
its
> > > vruntime may get too far behind (e.g. while cfs_rq was executing a
> > > low-weight hog), which can inverse the vruntime comparison due to s64
> > > overflow.  This results in the entity being placed with its original
> > > vruntime way forwards, so that it will effectively never get to the c=
pu.
> > >
> > > To prevent that, ignore the vruntime of the entity being placed if it
> > > didn't execute for longer than the time that can lead to an overflow.
> > >
> > > Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> > > [rkagan: formatted, adjusted commit log, comments, cutoff value]
> > > Co-developed-by: Roman Kagan <rkagan@amazon.de>
> > > Signed-off-by: Roman Kagan <rkagan@amazon.de>
> >
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > > ---
> > > v2 -> v3:
> > > - make cutoff less arbitrary and update comments [Vincent]
> > >
> > > v1 -> v2:
> > > - add Zhang Qiao's s-o-b
> > > - fix constant promotion on 32bit
> > >
> > >  kernel/sched/fair.c | 21 +++++++++++++++++++--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
>
> Turns out Peter took v2 through his tree, and it has already landed in
> Linus' master.
>
> What scares me, though, is that I've got a message from the test robot
> that this commit drammatically affected hackbench results, see the quote
> below.  I expected the commit not to affect any benchmarks.
>
> Any idea what could have caused this change?

Hmm, It's most probably because se->exec_start is reset after a
migration and the condition becomes true for newly migrated task
whereas its vruntime should be after min_vruntime.

We have missed this condition

>
> Thanks,
> Roman.
>
>
> On Tue, Feb 21, 2023 at 03:34:16PM +0800, kernel test robot wrote:
> > FYI, we noticed a 125.5% improvement of hackbench.throughput due to com=
mit:
> >
> > commit: 829c1651e9c4a6f78398d3e67651cef9bb6b42cc ("sched/fair: sanitize=
 vruntime of entity being placed")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: hackbench
> > on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @=
 2.10GHz (Cascade Lake) with 128G memory
> > with following parameters:
> >
> >         nr_threads: 50%
> >         iterations: 8
> >         mode: process
> >         ipc: pipe
> >         cpufreq_governor: performance
> >
> > test-description: Hackbench is both a benchmark and a stress test for t=
he Linux kernel scheduler.
> > test-url: https://github.com/linux-test-project/ltp/blob/master/testcas=
es/kernel/sched/cfs-scheduler/hackbench.c
> >
> > In addition to that, the commit also has significant impact on the foll=
owing tests:
> >
> > +------------------+--------------------------------------------------+
> > | testcase: change | hackbench: hackbench.throughput -8.1% regression |
> > | test machine     | 104 threads 2 sockets (Skylake) with 192G memory |
> > | test parameters  | cpufreq_governor=3Dperformance                    =
 |
> > |                  | ipc=3Dsocket                                      =
 |
> > |                  | iterations=3D4                                    =
 |
> > |                  | mode=3Dprocess                                    =
 |
> > |                  | nr_threads=3D100%                                 =
 |
> > +------------------+--------------------------------------------------+
> >
> > Details are as below:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs=
/tbox_group/testcase:
> >   gcc-11/performance/pipe/8/x86_64-rhel-8.3/process/50%/debian-11.1-x86=
_64-20220510.cgz/lkp-csl-2sp9/hackbench
> >
> > commit:
> >   a2e90611b9 ("sched/fair: Remove capacity inversion detection")
> >   829c1651e9 ("sched/fair: sanitize vruntime of entity being placed")
> >
> > a2e90611b9f425ad 829c1651e9c4a6f78398d3e6765
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >     308887 =C2=B1  5%    +125.5%     696539        hackbench.throughput
> >     259291 =C2=B1  2%    +127.3%     589293        hackbench.throughput=
_avg
> >     308887 =C2=B1  5%    +125.5%     696539        hackbench.throughput=
_best
> >     198770 =C2=B1  2%    +105.5%     408552 =C2=B1  4%  hackbench.throu=
ghput_worst
> >     319.60 =C2=B1  2%     -55.8%     141.24        hackbench.time.elaps=
ed_time
> >     319.60 =C2=B1  2%     -55.8%     141.24        hackbench.time.elaps=
ed_time.max
> >  1.298e+09 =C2=B1  8%     -87.6%  1.613e+08 =C2=B1  7%  hackbench.time.=
involuntary_context_switches
> >     477107           -12.5%     417660        hackbench.time.minor_page=
_faults
> >      24683 =C2=B1  2%     -57.2%      10562        hackbench.time.syste=
m_time
> >       2136 =C2=B1  3%     -45.0%       1174        hackbench.time.user_=
time
> >   3.21e+09 =C2=B1  4%     -83.0%  5.442e+08 =C2=B1  3%  hackbench.time.=
voluntary_context_switches
> >   5.28e+08 =C2=B1  4%      +8.4%  5.723e+08 =C2=B1  3%  cpuidle..time
> >     365.97 =C2=B1  2%     -48.9%     187.12        uptime.boot
> >    3322559 =C2=B1  3%     +34.3%    4463206 =C2=B1 15%  vmstat.memory.c=
ache
> >   14194257 =C2=B1  2%     -62.8%    5279904 =C2=B1  3%  vmstat.system.c=
s
> >    2120781 =C2=B1  3%     -72.8%     576421 =C2=B1  4%  vmstat.system.i=
n
> >       1.84 =C2=B1 12%      +2.6        4.48 =C2=B1  5%  mpstat.cpu.all.=
idle%
> >       2.49 =C2=B1  3%      -1.1        1.39 =C2=B1  4%  mpstat.cpu.all.=
irq%
> >       0.04 =C2=B1 12%      +0.0        0.05        mpstat.cpu.all.soft%
> >       7.36            +2.2        9.56        mpstat.cpu.all.usr%
> >      61555 =C2=B1  6%     -72.8%      16751 =C2=B1 16%  numa-meminfo.no=
de1.Active
> >      61515 =C2=B1  6%     -72.8%      16717 =C2=B1 16%  numa-meminfo.no=
de1.Active(anon)
> >     960182 =C2=B1102%    +225.6%    3125990 =C2=B1 42%  numa-meminfo.no=
de1.FilePages
> >    1754002 =C2=B1 53%    +137.9%    4173379 =C2=B1 34%  numa-meminfo.no=
de1.MemUsed
> >   35296824 =C2=B1  6%    +157.8%   91005048        numa-numastat.node0.=
local_node
> >   35310119 =C2=B1  6%    +157.9%   91058472        numa-numastat.node0.=
numa_hit
> >   35512423 =C2=B1  5%    +159.7%   92232951        numa-numastat.node1.=
local_node
> >   35577275 =C2=B1  4%    +159.4%   92273266        numa-numastat.node1.=
numa_hit
> >   35310253 =C2=B1  6%    +157.9%   91058211        numa-vmstat.node0.nu=
ma_hit
> >   35296958 =C2=B1  6%    +157.8%   91004787        numa-vmstat.node0.nu=
ma_local
> >      15337 =C2=B1  6%     -72.5%       4216 =C2=B1 17%  numa-vmstat.nod=
e1.nr_active_anon
> >     239988 =C2=B1102%    +225.7%     781607 =C2=B1 42%  numa-vmstat.nod=
e1.nr_file_pages
> >      15337 =C2=B1  6%     -72.5%       4216 =C2=B1 17%  numa-vmstat.nod=
e1.nr_zone_active_anon
> >   35577325 =C2=B1  4%    +159.4%   92273215        numa-vmstat.node1.nu=
ma_hit
> >   35512473 =C2=B1  5%    +159.7%   92232900        numa-vmstat.node1.nu=
ma_local
> >      64500 =C2=B1  8%     -61.8%      24643 =C2=B1 32%  meminfo.Active
> >      64422 =C2=B1  8%     -61.9%      24568 =C2=B1 32%  meminfo.Active(=
anon)
> >     140271 =C2=B1 14%     -38.0%      86979 =C2=B1 24%  meminfo.AnonHug=
ePages
> >     372672 =C2=B1  2%     +13.3%     422069        meminfo.AnonPages
> >    3205235 =C2=B1  3%     +35.1%    4329061 =C2=B1 15%  meminfo.Cached
> >    1548601 =C2=B1  7%     +77.4%    2747319 =C2=B1 24%  meminfo.Committ=
ed_AS
> >     783193 =C2=B1 14%    +154.9%    1996137 =C2=B1 33%  meminfo.Inactiv=
e
> >     783010 =C2=B1 14%    +154.9%    1995951 =C2=B1 33%  meminfo.Inactiv=
e(anon)
> >    4986534 =C2=B1  2%     +28.2%    6394741 =C2=B1 10%  meminfo.Memused
> >     475092 =C2=B1 22%    +236.5%    1598918 =C2=B1 41%  meminfo.Shmem
> >       2777            -2.1%       2719        turbostat.Bzy_MHz
> >   11143123 =C2=B1  6%     +72.0%   19162667        turbostat.C1
> >       0.24 =C2=B1  7%      +0.7        0.94 =C2=B1  3%  turbostat.C1%
> >     100440 =C2=B1 18%    +203.8%     305136 =C2=B1 15%  turbostat.C1E
> >       0.06 =C2=B1  9%      +0.1        0.18 =C2=B1 11%  turbostat.C1E%
> >       1.24 =C2=B1  3%      +1.6        2.81 =C2=B1  4%  turbostat.C6%
> >       1.38 =C2=B1  3%    +156.1%       3.55 =C2=B1  3%  turbostat.CPU%c=
1
> >       0.33 =C2=B1  5%     +76.5%       0.58 =C2=B1  7%  turbostat.CPU%c=
6
> >       0.16           +31.2%       0.21        turbostat.IPC
> >  6.866e+08 =C2=B1  5%     -87.8%   83575393 =C2=B1  5%  turbostat.IRQ
> >       0.33 =C2=B1 27%      +0.2        0.57        turbostat.POLL%
> >       0.12 =C2=B1 10%    +176.4%       0.33 =C2=B1 12%  turbostat.Pkg%p=
c2
> >       0.09 =C2=B1  7%    -100.0%       0.00        turbostat.Pkg%pc6
> >      61.33            +5.2%      64.50 =C2=B1  2%  turbostat.PkgTmp
> >      14.81            +2.0%      15.11        turbostat.RAMWatt
> >      16242 =C2=B1  8%     -62.0%       6179 =C2=B1 32%  proc-vmstat.nr_=
active_anon
> >      93150 =C2=B1  2%     +13.2%     105429        proc-vmstat.nr_anon_=
pages
> >     801219 =C2=B1  3%     +35.1%    1082320 =C2=B1 15%  proc-vmstat.nr_=
file_pages
> >     195506 =C2=B1 14%    +155.2%     498919 =C2=B1 33%  proc-vmstat.nr_=
inactive_anon
> >     118682 =C2=B1 22%    +236.9%     399783 =C2=B1 41%  proc-vmstat.nr_=
shmem
> >      16242 =C2=B1  8%     -62.0%       6179 =C2=B1 32%  proc-vmstat.nr_=
zone_active_anon
> >     195506 =C2=B1 14%    +155.2%     498919 =C2=B1 33%  proc-vmstat.nr_=
zone_inactive_anon
> >   70889233 =C2=B1  5%    +158.6%  1.833e+08        proc-vmstat.numa_hit
> >   70811086 =C2=B1  5%    +158.8%  1.832e+08        proc-vmstat.numa_loc=
al
> >      55885 =C2=B1 22%     -67.2%      18327 =C2=B1 38%  proc-vmstat.num=
a_pages_migrated
> >     422312 =C2=B1 10%     -95.4%      19371 =C2=B1  7%  proc-vmstat.pga=
ctivate
> >   71068460 =C2=B1  5%    +158.1%  1.834e+08        proc-vmstat.pgalloc_=
normal
> >    1554994           -19.6%    1250346 =C2=B1  4%  proc-vmstat.pgfault
> >   71011267 =C2=B1  5%    +155.9%  1.817e+08        proc-vmstat.pgfree
> >      55885 =C2=B1 22%     -67.2%      18327 =C2=B1 38%  proc-vmstat.pgm=
igrate_success
> >     111247 =C2=B1  2%     -35.0%      72355 =C2=B1  2%  proc-vmstat.pgr=
euse
> >    2506368 =C2=B1  2%     -53.1%    1176320        proc-vmstat.unevicta=
ble_pgs_scanned
> >      20.06 =C2=B1 10%     -22.4%      15.56 =C2=B1  8%  sched_debug.cfs=
_rq:/.h_nr_running.max
> >       0.81 =C2=B1 32%     -93.1%       0.06 =C2=B1223%  sched_debug.cfs=
_rq:/.h_nr_running.min
> >       1917 =C2=B1 34%    -100.0%       0.00        sched_debug.cfs_rq:/=
.load.min
> >      24.18 =C2=B1 10%     +39.0%      33.62 =C2=B1 11%  sched_debug.cfs=
_rq:/.load_avg.avg
> >     245.61 =C2=B1 25%     +66.3%     408.33 =C2=B1 22%  sched_debug.cfs=
_rq:/.load_avg.max
> >      47.52 =C2=B1 13%     +72.6%      82.03 =C2=B1  8%  sched_debug.cfs=
_rq:/.load_avg.stddev
> >   13431147           -64.9%    4717147        sched_debug.cfs_rq:/.min_=
vruntime.avg
> >   18161799 =C2=B1  7%     -67.4%    5925316 =C2=B1  6%  sched_debug.cfs=
_rq:/.min_vruntime.max
> >   12413026           -65.0%    4340952        sched_debug.cfs_rq:/.min_=
vruntime.min
> >     739748 =C2=B1 16%     -66.6%     247410 =C2=B1 17%  sched_debug.cfs=
_rq:/.min_vruntime.stddev
> >       0.85           -16.4%       0.71        sched_debug.cfs_rq:/.nr_r=
unning.avg
> >       0.61 =C2=B1 25%     -90.9%       0.06 =C2=B1223%  sched_debug.cfs=
_rq:/.nr_running.min
> >       0.10 =C2=B1 25%    +109.3%       0.22 =C2=B1  7%  sched_debug.cfs=
_rq:/.nr_running.stddev
> >     169.22          +101.7%     341.33        sched_debug.cfs_rq:/.remo=
ved.load_avg.max
> >      32.41 =C2=B1 24%    +100.2%      64.90 =C2=B1 16%  sched_debug.cfs=
_rq:/.removed.load_avg.stddev
> >      82.92 =C2=B1 10%    +108.1%     172.56        sched_debug.cfs_rq:/=
.removed.runnable_avg.max
> >      13.60 =C2=B1 28%    +114.0%      29.10 =C2=B1 20%  sched_debug.cfs=
_rq:/.removed.runnable_avg.stddev
> >      82.92 =C2=B1 10%    +108.1%     172.56        sched_debug.cfs_rq:/=
.removed.util_avg.max
> >      13.60 =C2=B1 28%    +114.0%      29.10 =C2=B1 20%  sched_debug.cfs=
_rq:/.removed.util_avg.stddev
> >       2156 =C2=B1 12%     -36.6%       1368 =C2=B1 27%  sched_debug.cfs=
_rq:/.runnable_avg.min
> >       2285 =C2=B1  7%     -19.8%       1833 =C2=B1  6%  sched_debug.cfs=
_rq:/.runnable_avg.stddev
> >   -2389921           -64.8%    -840940        sched_debug.cfs_rq:/.spre=
ad0.min
> >     739781 =C2=B1 16%     -66.5%     247837 =C2=B1 17%  sched_debug.cfs=
_rq:/.spread0.stddev
> >     843.88 =C2=B1  2%     -20.5%     670.53        sched_debug.cfs_rq:/=
.util_avg.avg
> >     433.64 =C2=B1  7%     -43.5%     244.83 =C2=B1 17%  sched_debug.cfs=
_rq:/.util_avg.min
> >     187.00 =C2=B1  6%     +40.6%     263.02 =C2=B1  4%  sched_debug.cfs=
_rq:/.util_avg.stddev
> >     394.15 =C2=B1 14%     -29.5%     278.06 =C2=B1  3%  sched_debug.cfs=
_rq:/.util_est_enqueued.avg
> >       1128 =C2=B1 12%     -17.6%     930.39 =C2=B1  5%  sched_debug.cfs=
_rq:/.util_est_enqueued.max
> >      38.36 =C2=B1 29%    -100.0%       0.00        sched_debug.cfs_rq:/=
.util_est_enqueued.min
> >       3596 =C2=B1 15%     -39.5%       2175 =C2=B1  7%  sched_debug.cpu=
.avg_idle.min
> >     160647 =C2=B1  9%     -25.9%     118978 =C2=B1  9%  sched_debug.cpu=
.avg_idle.stddev
> >     197365           -46.2%     106170        sched_debug.cpu.clock.avg
> >     197450           -46.2%     106208        sched_debug.cpu.clock.max
> >     197281           -46.2%     106128        sched_debug.cpu.clock.min
> >      49.96 =C2=B1 22%     -53.1%      23.44 =C2=B1 19%  sched_debug.cpu=
.clock.stddev
> >     193146           -45.7%     104898        sched_debug.cpu.clock_tas=
k.avg
> >     194592           -45.8%     105455        sched_debug.cpu.clock_tas=
k.max
> >     177878           -49.3%      90211        sched_debug.cpu.clock_tas=
k.min
> >       1794 =C2=B1  5%     -10.7%       1602 =C2=B1  2%  sched_debug.cpu=
.clock_task.stddev
> >      13154 =C2=B1  2%     -20.3%      10479        sched_debug.cpu.curr=
->pid.avg
> >      15059           -17.2%      12468        sched_debug.cpu.curr->pid=
.max
> >       7263 =C2=B1 33%    -100.0%       0.00        sched_debug.cpu.curr=
->pid.min
> >       9321 =C2=B1 36%     +98.2%      18478 =C2=B1 44%  sched_debug.cpu=
.max_idle_balance_cost.stddev
> >       0.00 =C2=B1 17%     -41.6%       0.00 =C2=B1 13%  sched_debug.cpu=
.next_balance.stddev
> >      20.00 =C2=B1 11%     -21.4%      15.72 =C2=B1  7%  sched_debug.cpu=
.nr_running.max
> >       0.86 =C2=B1 17%     -87.1%       0.11 =C2=B1141%  sched_debug.cpu=
.nr_running.min
> >   25069883           -83.7%    4084117 =C2=B1  4%  sched_debug.cpu.nr_s=
witches.avg
> >   26486718           -82.8%    4544009 =C2=B1  4%  sched_debug.cpu.nr_s=
witches.max
> >   23680077           -84.5%    3663816 =C2=B1  4%  sched_debug.cpu.nr_s=
witches.min
> >     589836 =C2=B1  3%     -68.7%     184621 =C2=B1 16%  sched_debug.cpu=
.nr_switches.stddev
> >     197278           -46.2%     106128        sched_debug.cpu_clk
> >     194327           -46.9%     103176        sched_debug.ktime
> >     197967           -46.0%     106821        sched_debug.sched_clk
> >      14.91           -37.6%       9.31        perf-stat.i.MPKI
> >  2.657e+10           +25.0%   3.32e+10        perf-stat.i.branch-instru=
ctions
> >       1.17            -0.4        0.78        perf-stat.i.branch-miss-r=
ate%
> >  3.069e+08           -20.1%  2.454e+08        perf-stat.i.branch-misses
> >       6.43 =C2=B1  8%      +2.2        8.59 =C2=B1  4%  perf-stat.i.cac=
he-miss-rate%
> >  1.952e+09           -24.3%  1.478e+09        perf-stat.i.cache-referen=
ces
> >   14344055 =C2=B1  2%     -58.6%    5932018 =C2=B1  3%  perf-stat.i.con=
text-switches
> >       1.83           -21.8%       1.43        perf-stat.i.cpi
> >  2.403e+11            -3.4%  2.322e+11        perf-stat.i.cpu-cycles
> >    1420139 =C2=B1  2%     -38.8%     869692 =C2=B1  5%  perf-stat.i.cpu=
-migrations
> >       2619 =C2=B1  7%     -15.5%       2212 =C2=B1  8%  perf-stat.i.cyc=
les-between-cache-misses
> >       0.24 =C2=B1 19%      -0.1        0.10 =C2=B1 17%  perf-stat.i.dTL=
B-load-miss-rate%
> >   90403286 =C2=B1 19%     -55.8%   39926283 =C2=B1 16%  perf-stat.i.dTL=
B-load-misses
> >  3.823e+10           +28.6%  4.918e+10        perf-stat.i.dTLB-loads
> >       0.01 =C2=B1 34%      -0.0        0.01 =C2=B1 33%  perf-stat.i.dTL=
B-store-miss-rate%
> >    2779663 =C2=B1 34%     -52.7%    1315899 =C2=B1 31%  perf-stat.i.dTL=
B-store-misses
> >   2.19e+10           +24.2%   2.72e+10        perf-stat.i.dTLB-stores
> >      47.99 =C2=B1  2%     +28.0       75.94        perf-stat.i.iTLB-loa=
d-miss-rate%
> >   89417955 =C2=B1  2%     +38.7%   1.24e+08 =C2=B1  4%  perf-stat.i.iTL=
B-load-misses
> >   97721514 =C2=B1  2%     -58.2%   40865783 =C2=B1  3%  perf-stat.i.iTL=
B-loads
> >  1.329e+11           +26.3%  1.678e+11        perf-stat.i.instructions
> >       1503            -7.7%       1388 =C2=B1  3%  perf-stat.i.instruct=
ions-per-iTLB-miss
> >       0.55           +30.2%       0.72        perf-stat.i.ipc
> >       1.64 =C2=B1 18%    +217.4%       5.20 =C2=B1 11%  perf-stat.i.maj=
or-faults
> >       2.73            -3.7%       2.63        perf-stat.i.metric.GHz
> >       1098 =C2=B1  2%      -7.1%       1020 =C2=B1  3%  perf-stat.i.met=
ric.K/sec
> >       1008           +24.4%       1254        perf-stat.i.metric.M/sec
> >       4334 =C2=B1  2%     +90.5%       8257 =C2=B1  7%  perf-stat.i.min=
or-faults
> >      90.94           -14.9       75.99        perf-stat.i.node-load-mis=
s-rate%
> >   41932510 =C2=B1  8%     -43.0%   23899176 =C2=B1 10%  perf-stat.i.nod=
e-load-misses
> >    3366677 =C2=B1  5%     +86.2%    6267816        perf-stat.i.node-loa=
ds
> >      81.77 =C2=B1  3%     -36.3       45.52 =C2=B1  3%  perf-stat.i.nod=
e-store-miss-rate%
> >   18498318 =C2=B1  7%     -31.8%   12613933 =C2=B1  7%  perf-stat.i.nod=
e-store-misses
> >    3023556 =C2=B1 10%    +508.7%   18405880 =C2=B1  2%  perf-stat.i.nod=
e-stores
> >       4336 =C2=B1  2%     +90.5%       8262 =C2=B1  7%  perf-stat.i.pag=
e-faults
> >      14.70           -41.2%       8.65        perf-stat.overall.MPKI
> >       1.16            -0.4        0.72        perf-stat.overall.branch-=
miss-rate%
> >       6.22 =C2=B1  7%      +2.4        8.59 =C2=B1  4%  perf-stat.overa=
ll.cache-miss-rate%
> >       1.81           -24.3%       1.37        perf-stat.overall.cpi
> >       0.24 =C2=B1 19%      -0.2        0.07 =C2=B1 15%  perf-stat.overa=
ll.dTLB-load-miss-rate%
> >       0.01 =C2=B1 34%      -0.0        0.00 =C2=B1 29%  perf-stat.overa=
ll.dTLB-store-miss-rate%
> >      47.78 =C2=B1  2%     +29.3       77.12        perf-stat.overall.iT=
LB-load-miss-rate%
> >       1486            -9.1%       1351 =C2=B1  4%  perf-stat.overall.in=
structions-per-iTLB-miss
> >       0.55           +32.0%       0.73        perf-stat.overall.ipc
> >      92.54           -15.4       77.16 =C2=B1  2%  perf-stat.overall.no=
de-load-miss-rate%
> >      85.82 =C2=B1  2%     -48.1       37.76 =C2=B1  5%  perf-stat.overa=
ll.node-store-miss-rate%
> >  2.648e+10           +25.2%  3.314e+10        perf-stat.ps.branch-instr=
uctions
> >   3.06e+08           -22.1%  2.383e+08        perf-stat.ps.branch-misse=
s
> >  1.947e+09           -25.5%  1.451e+09        perf-stat.ps.cache-refere=
nces
> >   14298713 =C2=B1  2%     -62.5%    5359285 =C2=B1  3%  perf-stat.ps.co=
ntext-switches
> >  2.396e+11            -4.0%  2.299e+11        perf-stat.ps.cpu-cycles
> >    1415512 =C2=B1  2%     -42.2%     817981 =C2=B1  4%  perf-stat.ps.cp=
u-migrations
> >   90073948 =C2=B1 19%     -60.4%   35711862 =C2=B1 15%  perf-stat.ps.dT=
LB-load-misses
> >  3.811e+10           +29.7%  4.944e+10        perf-stat.ps.dTLB-loads
> >    2767291 =C2=B1 34%     -56.3%    1210210 =C2=B1 29%  perf-stat.ps.dT=
LB-store-misses
> >  2.183e+10           +25.0%  2.729e+10        perf-stat.ps.dTLB-stores
> >   89118809 =C2=B1  2%     +39.6%  1.244e+08 =C2=B1  4%  perf-stat.ps.iT=
LB-load-misses
> >   97404381 =C2=B1  2%     -62.2%   36860047 =C2=B1  3%  perf-stat.ps.iT=
LB-loads
> >  1.324e+11           +26.7%  1.678e+11        perf-stat.ps.instructions
> >       1.62 =C2=B1 18%    +164.7%       4.29 =C2=B1  8%  perf-stat.ps.ma=
jor-faults
> >       4310 =C2=B1  2%     +75.1%       7549 =C2=B1  5%  perf-stat.ps.mi=
nor-faults
> >   41743097 =C2=B1  8%     -47.3%   21984450 =C2=B1  9%  perf-stat.ps.no=
de-load-misses
> >    3356259 =C2=B1  5%     +92.6%    6462631        perf-stat.ps.node-lo=
ads
> >   18414647 =C2=B1  7%     -35.7%   11833799 =C2=B1  6%  perf-stat.ps.no=
de-store-misses
> >    3019790 =C2=B1 10%    +545.0%   19478071        perf-stat.ps.node-st=
ores
> >       4312 =C2=B1  2%     +75.2%       7553 =C2=B1  5%  perf-stat.ps.pa=
ge-faults
> >  4.252e+13           -43.7%  2.395e+13        perf-stat.total.instructi=
ons
> >      29.92 =C2=B1  4%     -22.8        7.09 =C2=B1 29%  perf-profile.ca=
lltrace.cycles-pp.__wake_up_common_lock.pipe_write.vfs_write.ksys_write.do_=
syscall_64
> >      28.53 =C2=B1  5%     -21.6        6.92 =C2=B1 29%  perf-profile.ca=
lltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_write.vfs_wri=
te.ksys_write
> >      27.86 =C2=B1  5%     -21.1        6.77 =C2=B1 29%  perf-profile.ca=
lltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_commo=
n_lock.pipe_write.vfs_write
> >      27.55 =C2=B1  5%     -20.9        6.68 =C2=B1 29%  perf-profile.ca=
lltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.=
__wake_up_common_lock.pipe_write
> >      22.28 =C2=B1  4%     -17.0        5.31 =C2=B1 30%  perf-profile.ca=
lltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
> >      21.98 =C2=B1  4%     -16.7        5.24 =C2=B1 30%  perf-profile.ca=
lltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
> >      12.62 =C2=B1  4%      -9.6        3.00 =C2=B1 33%  perf-profile.ca=
lltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.=
__wake_up_common.__wake_up_common_lock
> >      34.09            -9.2       24.92 =C2=B1  3%  perf-profile.calltra=
ce.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe
> >      11.48 =C2=B1  5%      -8.8        2.69 =C2=B1 38%  perf-profile.ca=
lltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autorem=
ove_wake_function.__wake_up_common
> >       9.60 =C2=B1  7%      -7.2        2.40 =C2=B1 35%  perf-profile.ca=
lltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
> >      36.39            -6.2       30.20        perf-profile.calltrace.cy=
cles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__l=
ibc_read
> >      40.40            -6.1       34.28        perf-profile.calltrace.cy=
cles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
> >      40.95            -5.7       35.26        perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
> >      37.43            -5.4       32.07        perf-profile.calltrace.cy=
cles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
> >       6.30 =C2=B1 11%      -5.2        1.09 =C2=B1 36%  perf-profile.ca=
lltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe.__libc_write
> >       5.66 =C2=B1 12%      -5.1        0.58 =C2=B1 75%  perf-profile.ca=
lltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_=
exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       6.46 =C2=B1 10%      -5.1        1.40 =C2=B1 28%  perf-profile.ca=
lltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_=
after_hwframe.__libc_write
> >       5.53 =C2=B1 13%      -5.0        0.56 =C2=B1 75%  perf-profile.ca=
lltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare=
.syscall_exit_to_user_mode.do_syscall_64
> >       5.42 =C2=B1 13%      -4.9        0.56 =C2=B1 75%  perf-profile.ca=
lltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_m=
ode_prepare.syscall_exit_to_user_mode
> >       5.82 =C2=B1  9%      -4.7        1.10 =C2=B1 37%  perf-profile.ca=
lltrace.cycles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__=
wake_up_common.__wake_up_common_lock
> >       5.86 =C2=B1 16%      -4.6        1.31 =C2=B1 37%  perf-profile.ca=
lltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_=
wake_up.autoremove_wake_function
> >       5.26 =C2=B1  9%      -4.4        0.89 =C2=B1 57%  perf-profile.ca=
lltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wa=
ke_up.autoremove_wake_function.__wake_up_common
> >      45.18            -3.5       41.68        perf-profile.calltrace.cy=
cles-pp.__libc_read
> >      50.31            -3.2       47.12        perf-profile.calltrace.cy=
cles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
> >       4.00 =C2=B1 27%      -2.9        1.09 =C2=B1 40%  perf-profile.ca=
lltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.pipe=
_read
> >      50.75            -2.7       48.06        perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
> >      40.80            -2.6       38.20        perf-profile.calltrace.cy=
cles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe
> >       3.10 =C2=B1 15%      -2.5        0.62 =C2=B1103%  perf-profile.ca=
lltrace.cycles-pp.update_cfs_group.dequeue_task_fair.__schedule.schedule.pi=
pe_read
> >       2.94 =C2=B1 12%      -2.3        0.62 =C2=B1102%  perf-profile.ca=
lltrace.cycles-pp.update_cfs_group.enqueue_task_fair.ttwu_do_activate.try_t=
o_wake_up.autoremove_wake_function
> >       2.38 =C2=B1  9%      -2.0        0.38 =C2=B1102%  perf-profile.ca=
lltrace.cycles-pp._raw_spin_lock.__schedule.schedule.pipe_read.vfs_read
> >       2.24 =C2=B1  7%      -1.8        0.40 =C2=B1 71%  perf-profile.ca=
lltrace.cycles-pp.prepare_to_wait_event.pipe_read.vfs_read.ksys_read.do_sys=
call_64
> >       2.08 =C2=B1  6%      -1.8        0.29 =C2=B1100%  perf-profile.ca=
lltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.pipe_read.vfs_rea=
d
> >       2.10 =C2=B1 10%      -1.8        0.32 =C2=B1104%  perf-profile.ca=
lltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__schedul=
e.schedule.pipe_read
> >       2.76 =C2=B1  7%      -1.5        1.24 =C2=B1 17%  perf-profile.ca=
lltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__=
wake_up_common.__wake_up_common_lock
> >       2.27 =C2=B1  5%      -1.4        0.88 =C2=B1 11%  perf-profile.ca=
lltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe.__libc_read
> >       2.43 =C2=B1  7%      -1.3        1.16 =C2=B1 17%  perf-profile.ca=
lltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autorem=
ove_wake_function.__wake_up_common
> >       2.46 =C2=B1  5%      -1.3        1.20 =C2=B1  7%  perf-profile.ca=
lltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_=
after_hwframe.__libc_read
> >       1.54 =C2=B1  5%      -1.2        0.32 =C2=B1101%  perf-profile.ca=
lltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.ttwu_do_=
activate.try_to_wake_up
> >       0.97 =C2=B1  9%      -0.3        0.66 =C2=B1 19%  perf-profile.ca=
lltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.tr=
y_to_wake_up.autoremove_wake_function
> >       0.86 =C2=B1  6%      +0.2        1.02        perf-profile.calltra=
ce.cycles-pp.__might_fault._copy_from_iter.copy_page_from_iter.pipe_write.v=
fs_write
> >       0.64 =C2=B1  9%      +0.5        1.16 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.mutex_unlock.pipe_read.vfs_read.ksys_read.do_syscall_64
> >       0.47 =C2=B1 45%      +0.5        0.99 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.__fget_light.__fdget_pos.ksys_read.do_syscall_64.entry_SY=
SCALL_64_after_hwframe
> >       0.60 =C2=B1  8%      +0.5        1.13 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe.__libc_read
> >       0.00            +0.5        0.54 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.current_time.file_update_time.pipe_write.vfs_write.ksys_write
> >       0.00            +0.6        0.56 =C2=B1  4%  perf-profile.calltra=
ce.cycles-pp.__might_resched.__might_fault._copy_from_iter.copy_page_from_i=
ter.pipe_write
> >       0.00            +0.6        0.56 =C2=B1  7%  perf-profile.calltra=
ce.cycles-pp.__might_resched.__might_fault._copy_to_iter.copy_page_to_iter.=
pipe_read
> >       0.00            +0.6        0.58 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.__might_resched.mutex_lock.pipe_write.vfs_write.ksys_write
> >       0.00            +0.6        0.62 =C2=B1  3%  perf-profile.calltra=
ce.cycles-pp.__might_resched.mutex_lock.pipe_read.vfs_read.ksys_read
> >       0.00            +0.7        0.65 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.prepar=
e_to_wait_event.pipe_write.vfs_write
> >       0.00            +0.7        0.65 =C2=B1  7%  perf-profile.calltra=
ce.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.=
do_idle
> >       0.57 =C2=B1  5%      +0.7        1.24 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
> >       0.00            +0.7        0.72 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait_event.pipe_write.vfs_wr=
ite.ksys_write
> >       0.00            +0.8        0.75 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.mutex_spin_on_owner.__mutex_lock.pipe_write.vfs_write.ksys_wri=
te
> >       0.74 =C2=B1  9%      +0.8        1.48 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.file_update_time.pipe_write.vfs_write.ksys_write.do_sysca=
ll_64
> >       0.63 =C2=B1  5%      +0.8        1.40 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_aft=
er_hwframe.__libc_write
> >       0.00            +0.8        0.78 =C2=B1 19%  perf-profile.calltra=
ce.cycles-pp.reader__read_event.perf_session__process_events.record__finish=
_output.__cmd_record
> >       0.00            +0.8        0.78 =C2=B1 19%  perf-profile.calltra=
ce.cycles-pp.record__finish_output.__cmd_record
> >       0.00            +0.8        0.78 =C2=B1 19%  perf-profile.calltra=
ce.cycles-pp.perf_session__process_events.record__finish_output.__cmd_recor=
d
> >       0.00            +0.8        0.80 =C2=B1 15%  perf-profile.calltra=
ce.cycles-pp.__cmd_record
> >       0.00            +0.8        0.82 =C2=B1 11%  perf-profile.calltra=
ce.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_=
call.do_idle
> >       0.00            +0.9        0.85 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.prepare_to_wait_event.pipe_write.vfs_write.ksys_write.do_sysca=
ll_64
> >       0.00            +0.9        0.86 =C2=B1  4%  perf-profile.calltra=
ce.cycles-pp.current_time.atime_needs_update.touch_atime.pipe_read.vfs_read
> >       0.00            +0.9        0.87 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.syscall_return_via_sysret.__libc_write
> >       0.00            +0.9        0.88 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.syscall_return_via_sysret.__libc_read
> >       0.26 =C2=B1100%      +1.0        1.22 =C2=B1 10%  perf-profile.ca=
lltrace.cycles-pp.__schedule.schedule.pipe_write.vfs_write.ksys_write
> >       0.00            +1.0        0.96 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.__might_fault._copy_to_iter.copy_page_to_iter.pipe_read.vfs_re=
ad
> >       0.27 =C2=B1100%      +1.0        1.23 =C2=B1 10%  perf-profile.ca=
lltrace.cycles-pp.schedule.pipe_write.vfs_write.ksys_write.do_syscall_64
> >       0.00            +1.0        0.97 =C2=B1  7%  perf-profile.calltra=
ce.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__f=
olio_put.pipe_read
> >       0.87 =C2=B1  8%      +1.1        1.98 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_rea=
d.ksys_read.do_syscall_64
> >       0.73 =C2=B1  6%      +1.1        1.85 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_wri=
te.ksys_write.do_syscall_64
> >       0.00            +1.2        1.15 =C2=B1  7%  perf-profile.calltra=
ce.cycles-pp.uncharge_batch.__mem_cgroup_uncharge.__folio_put.pipe_read.vfs=
_read
> >       0.00            +1.2        1.23 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.__mem_cgroup_uncharge.__folio_put.pipe_read.vfs_read.ksys_read
> >       0.00            +1.2        1.24 =C2=B1  7%  perf-profile.calltra=
ce.cycles-pp.__folio_put.pipe_read.vfs_read.ksys_read.do_syscall_64
> >       0.48 =C2=B1 45%      +1.3        1.74 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.atime_needs_update.touch_atime.pipe_read.vfs_read.ksys_re=
ad
> >       0.60 =C2=B1  7%      +1.3        1.87 =C2=B1  8%  perf-profile.ca=
lltrace.cycles-pp.__wake_up_common_lock.pipe_read.vfs_read.ksys_read.do_sys=
call_64
> >       1.23 =C2=B1  7%      +1.3        2.51 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.mutex_lock.pipe_read.vfs_read.ksys_read.do_syscall_64
> >      43.42            +1.3       44.75        perf-profile.calltrace.cy=
cles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_writ=
e
> >       0.83 =C2=B1  7%      +1.3        2.17 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_=
64.entry_SYSCALL_64_after_hwframe
> >       0.98 =C2=B1  7%      +1.4        2.36 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64=
.entry_SYSCALL_64_after_hwframe
> >       0.27 =C2=B1100%      +1.4        1.70 =C2=B1  9%  perf-profile.ca=
lltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_read.vfs_read=
.ksys_read
> >       0.79 =C2=B1  8%      +1.4        2.23 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.touch_atime.pipe_read.vfs_read.ksys_read.do_syscall_64
> >       0.18 =C2=B1141%      +1.5        1.63 =C2=B1  9%  perf-profile.ca=
lltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.=
__wake_up_common_lock.pipe_read
> >       0.18 =C2=B1141%      +1.5        1.67 =C2=B1  9%  perf-profile.ca=
lltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_commo=
n_lock.pipe_read.vfs_read
> >       0.00            +1.6        1.57 =C2=B1 10%  perf-profile.calltra=
ce.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cp=
u_startup_entry
> >       0.00            +1.6        1.57 =C2=B1 10%  perf-profile.calltra=
ce.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.star=
t_secondary
> >       1.05 =C2=B1  8%      +1.7        2.73 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter.cop=
y_page_from_iter.pipe_write
> >       1.84 =C2=B1  9%      +1.7        3.56 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.copy=
_page_to_iter.pipe_read
> >       1.41 =C2=B1  9%      +1.8        3.17 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.copyin._copy_from_iter.copy_page_from_iter.pipe_write.vfs=
_write
> >       0.00            +1.8        1.79 =C2=B1  9%  perf-profile.calltra=
ce.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.se=
condary_startup_64_no_verify
> >       1.99 =C2=B1  9%      +2.0        3.95 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.copyout._copy_to_iter.copy_page_to_iter.pipe_read.vfs_rea=
d
> >       2.40 =C2=B1  7%      +2.4        4.82 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.=
ksys_write
> >       0.00            +2.5        2.50 =C2=B1  7%  perf-profile.calltra=
ce.cycles-pp.__mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
> >       2.89 =C2=B1  8%      +2.6        5.47 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_sy=
scall_64
> >       1.04 =C2=B1 30%      +2.8        3.86 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.__entry_text_start.__libc_write
> >       0.00            +2.9        2.90 =C2=B1 11%  perf-profile.calltra=
ce.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64=
_no_verify
> >       0.00            +2.9        2.91 =C2=B1 11%  perf-profile.calltra=
ce.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_veri=
fy
> >       0.00            +2.9        2.91 =C2=B1 11%  perf-profile.calltra=
ce.cycles-pp.start_secondary.secondary_startup_64_no_verify
> >       0.85 =C2=B1 27%      +2.9        3.80 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.__entry_text_start.__libc_read
> >       0.00            +3.0        2.96 =C2=B1 11%  perf-profile.calltra=
ce.cycles-pp.secondary_startup_64_no_verify
> >       2.60 =C2=B1  9%      +3.1        5.74 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp._copy_to_iter.copy_page_to_iter.pipe_read.vfs_read.ksys_r=
ead
> >       2.93 =C2=B1  9%      +3.7        6.66 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.copy_page_to_iter.pipe_read.vfs_read.ksys_read.do_syscall=
_64
> >       1.60 =C2=B1 12%      +4.6        6.18 =C2=B1  7%  perf-profile.ca=
lltrace.cycles-pp.mutex_unlock.pipe_write.vfs_write.ksys_write.do_syscall_6=
4
> >       2.60 =C2=B1 10%      +4.6        7.24 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.mutex_lock.pipe_write.vfs_write.ksys_write.do_syscall_64
> >      28.75 =C2=B1  5%     -21.6        7.19 =C2=B1 28%  perf-profile.ch=
ildren.cycles-pp.schedule
> >      30.52 =C2=B1  4%     -21.6        8.97 =C2=B1 22%  perf-profile.ch=
ildren.cycles-pp.__wake_up_common_lock
> >      28.53 =C2=B1  6%     -21.0        7.56 =C2=B1 26%  perf-profile.ch=
ildren.cycles-pp.__schedule
> >      29.04 =C2=B1  5%     -20.4        8.63 =C2=B1 23%  perf-profile.ch=
ildren.cycles-pp.__wake_up_common
> >      28.37 =C2=B1  5%     -19.9        8.44 =C2=B1 23%  perf-profile.ch=
ildren.cycles-pp.autoremove_wake_function
> >      28.08 =C2=B1  5%     -19.7        8.33 =C2=B1 23%  perf-profile.ch=
ildren.cycles-pp.try_to_wake_up
> >      13.90 =C2=B1  2%     -10.2        3.75 =C2=B1 28%  perf-profile.ch=
ildren.cycles-pp.ttwu_do_activate
> >      12.66 =C2=B1  3%      -9.2        3.47 =C2=B1 29%  perf-profile.ch=
ildren.cycles-pp.enqueue_task_fair
> >      34.20            -9.2       25.05 =C2=B1  3%  perf-profile.childre=
n.cycles-pp.pipe_read
> >      90.86            -9.1       81.73        perf-profile.children.cyc=
les-pp.do_syscall_64
> >      91.80            -8.3       83.49        perf-profile.children.cyc=
les-pp.entry_SYSCALL_64_after_hwframe
> >      10.28 =C2=B1  7%      -7.8        2.53 =C2=B1 27%  perf-profile.ch=
ildren.cycles-pp._raw_spin_lock
> >       9.85 =C2=B1  7%      -6.9        2.92 =C2=B1 29%  perf-profile.ch=
ildren.cycles-pp.dequeue_task_fair
> >       8.69 =C2=B1  7%      -6.6        2.05 =C2=B1 24%  perf-profile.ch=
ildren.cycles-pp.exit_to_user_mode_prepare
> >       8.99 =C2=B1  6%      -6.2        2.81 =C2=B1 16%  perf-profile.ch=
ildren.cycles-pp.syscall_exit_to_user_mode
> >      36.46            -6.1       30.34        perf-profile.children.cyc=
les-pp.vfs_read
> >       8.38 =C2=B1  8%      -5.8        2.60 =C2=B1 23%  perf-profile.ch=
ildren.cycles-pp.native_queued_spin_lock_slowpath
> >       6.10 =C2=B1 11%      -5.4        0.66 =C2=B1 61%  perf-profile.ch=
ildren.cycles-pp.exit_to_user_mode_loop
> >      37.45            -5.3       32.13        perf-profile.children.cyc=
les-pp.ksys_read
> >       6.50 =C2=B1 35%      -4.9        1.62 =C2=B1 61%  perf-profile.ch=
ildren.cycles-pp.update_curr
> >       6.56 =C2=B1 15%      -4.6        1.95 =C2=B1 57%  perf-profile.ch=
ildren.cycles-pp.update_cfs_group
> >       6.38 =C2=B1 14%      -4.5        1.91 =C2=B1 28%  perf-profile.ch=
ildren.cycles-pp.enqueue_entity
> >       5.74 =C2=B1  5%      -3.8        1.92 =C2=B1 25%  perf-profile.ch=
ildren.cycles-pp.update_load_avg
> >      45.56            -3.8       41.75        perf-profile.children.cyc=
les-pp.__libc_read
> >       3.99 =C2=B1  4%      -3.1        0.92 =C2=B1 24%  perf-profile.ch=
ildren.cycles-pp.pick_next_task_fair
> >       4.12 =C2=B1 27%      -2.7        1.39 =C2=B1 34%  perf-profile.ch=
ildren.cycles-pp.dequeue_entity
> >      40.88            -2.5       38.37        perf-profile.children.cyc=
les-pp.pipe_write
> >       3.11 =C2=B1  4%      -2.4        0.75 =C2=B1 22%  perf-profile.ch=
ildren.cycles-pp.switch_mm_irqs_off
> >       2.06 =C2=B1 33%      -1.8        0.27 =C2=B1 27%  perf-profile.ch=
ildren.cycles-pp.asm_sysvec_call_function_single
> >       2.38 =C2=B1 41%      -1.8        0.60 =C2=B1 72%  perf-profile.ch=
ildren.cycles-pp.perf_trace_sched_wakeup_template
> >       2.29 =C2=B1  5%      -1.7        0.60 =C2=B1 25%  perf-profile.ch=
ildren.cycles-pp.switch_fpu_return
> >       2.30 =C2=B1  6%      -1.6        0.68 =C2=B1 18%  perf-profile.ch=
ildren.cycles-pp.prepare_task_switch
> >       1.82 =C2=B1 33%      -1.6        0.22 =C2=B1 31%  perf-profile.ch=
ildren.cycles-pp.sysvec_call_function_single
> >       1.77 =C2=B1 33%      -1.6        0.20 =C2=B1 32%  perf-profile.ch=
ildren.cycles-pp.__sysvec_call_function_single
> >       1.96 =C2=B1  5%      -1.5        0.50 =C2=B1 20%  perf-profile.ch=
ildren.cycles-pp.reweight_entity
> >       2.80 =C2=B1  7%      -1.2        1.60 =C2=B1 12%  perf-profile.ch=
ildren.cycles-pp.select_task_rq
> >       1.61 =C2=B1  6%      -1.2        0.42 =C2=B1 25%  perf-profile.ch=
ildren.cycles-pp.restore_fpregs_from_fpstate
> >       1.34 =C2=B1  9%      -1.2        0.16 =C2=B1 28%  perf-profile.ch=
ildren.cycles-pp._raw_spin_unlock_irqrestore
> >       1.62 =C2=B1  4%      -1.2        0.45 =C2=B1 22%  perf-profile.ch=
ildren.cycles-pp.set_next_entity
> >       1.55 =C2=B1  8%      -1.1        0.43 =C2=B1 12%  perf-profile.ch=
ildren.cycles-pp.update_rq_clock
> >       1.49 =C2=B1  8%      -1.1        0.41 =C2=B1 14%  perf-profile.ch=
ildren.cycles-pp.__update_load_avg_cfs_rq
> >       1.30 =C2=B1 20%      -1.0        0.26 =C2=B1 18%  perf-profile.ch=
ildren.cycles-pp.finish_task_switch
> >       1.44 =C2=B1  5%      -1.0        0.42 =C2=B1 19%  perf-profile.ch=
ildren.cycles-pp.__switch_to_asm
> >       2.47 =C2=B1  7%      -1.0        1.50 =C2=B1 12%  perf-profile.ch=
ildren.cycles-pp.select_task_rq_fair
> >       2.33 =C2=B1  7%      -0.9        1.40 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.prepare_to_wait_event
> >       1.24 =C2=B1  7%      -0.9        0.35 =C2=B1 14%  perf-profile.ch=
ildren.cycles-pp.__update_load_avg_se
> >       1.41 =C2=B1 32%      -0.9        0.56 =C2=B1 24%  perf-profile.ch=
ildren.cycles-pp.sched_ttwu_pending
> >       2.29 =C2=B1  8%      -0.8        1.45 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp._raw_spin_lock_irqsave
> >       1.04 =C2=B1  7%      -0.8        0.24 =C2=B1 22%  perf-profile.ch=
ildren.cycles-pp.check_preempt_curr
> >       1.01 =C2=B1  3%      -0.7        0.30 =C2=B1 20%  perf-profile.ch=
ildren.cycles-pp.__switch_to
> >       0.92 =C2=B1  7%      -0.7        0.26 =C2=B1 12%  perf-profile.ch=
ildren.cycles-pp.update_min_vruntime
> >       0.71 =C2=B1  2%      -0.6        0.08 =C2=B1 75%  perf-profile.ch=
ildren.cycles-pp.put_prev_entity
> >       0.76 =C2=B1  6%      -0.6        0.14 =C2=B1 32%  perf-profile.ch=
ildren.cycles-pp.check_preempt_wakeup
> >       0.81 =C2=B1 66%      -0.6        0.22 =C2=B1 34%  perf-profile.ch=
ildren.cycles-pp.set_task_cpu
> >       0.82 =C2=B1 17%      -0.6        0.23 =C2=B1 10%  perf-profile.ch=
ildren.cycles-pp.cpuacct_charge
> >       1.08 =C2=B1 15%      -0.6        0.51 =C2=B1 10%  perf-profile.ch=
ildren.cycles-pp.wake_affine
> >       0.56 =C2=B1 15%      -0.5        0.03 =C2=B1100%  perf-profile.ch=
ildren.cycles-pp.asm_sysvec_reschedule_ipi
> >       0.66 =C2=B1  3%      -0.5        0.15 =C2=B1 28%  perf-profile.ch=
ildren.cycles-pp.os_xsave
> >       0.52 =C2=B1 44%      -0.5        0.06 =C2=B1151%  perf-profile.ch=
ildren.cycles-pp.native_irq_return_iret
> >       0.55 =C2=B1  5%      -0.4        0.15 =C2=B1 21%  perf-profile.ch=
ildren.cycles-pp.__calc_delta
> >       0.56 =C2=B1 10%      -0.4        0.17 =C2=B1 26%  perf-profile.ch=
ildren.cycles-pp.___perf_sw_event
> >       0.70 =C2=B1 15%      -0.4        0.32 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.task_h_load
> >       0.40 =C2=B1  4%      -0.3        0.06 =C2=B1 49%  perf-profile.ch=
ildren.cycles-pp.pick_next_entity
> >       0.57 =C2=B1  6%      -0.3        0.26 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.__list_del_entry_valid
> >       0.39 =C2=B1  8%      -0.3        0.08 =C2=B1 24%  perf-profile.ch=
ildren.cycles-pp.set_next_buddy
> >       0.64 =C2=B1  6%      -0.3        0.36 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp._raw_spin_lock_irq
> >       0.53 =C2=B1 20%      -0.3        0.25 =C2=B1  8%  perf-profile.ch=
ildren.cycles-pp.ttwu_queue_wakelist
> >       0.36 =C2=B1  8%      -0.3        0.08 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.rb_insert_color
> >       0.41 =C2=B1  6%      -0.3        0.14 =C2=B1 17%  perf-profile.ch=
ildren.cycles-pp.sched_clock_cpu
> >       0.36 =C2=B1 33%      -0.3        0.10 =C2=B1 17%  perf-profile.ch=
ildren.cycles-pp.__flush_smp_call_function_queue
> >       0.37 =C2=B1  4%      -0.2        0.13 =C2=B1 16%  perf-profile.ch=
ildren.cycles-pp.native_sched_clock
> >       0.28 =C2=B1  5%      -0.2        0.07 =C2=B1 18%  perf-profile.ch=
ildren.cycles-pp.rb_erase
> >       0.32 =C2=B1  7%      -0.2        0.12 =C2=B1 10%  perf-profile.ch=
ildren.cycles-pp.__list_add_valid
> >       0.23 =C2=B1  6%      -0.2        0.03 =C2=B1103%  perf-profile.ch=
ildren.cycles-pp.resched_curr
> >       0.27 =C2=B1  5%      -0.2        0.08 =C2=B1 20%  perf-profile.ch=
ildren.cycles-pp.__wrgsbase_inactive
> >       0.26 =C2=B1  6%      -0.2        0.08 =C2=B1 17%  perf-profile.ch=
ildren.cycles-pp.finish_wait
> >       0.26 =C2=B1  4%      -0.2        0.08 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.rcu_note_context_switch
> >       0.33 =C2=B1 21%      -0.2        0.15 =C2=B1 32%  perf-profile.ch=
ildren.cycles-pp.migrate_task_rq_fair
> >       0.22 =C2=B1  9%      -0.2        0.07 =C2=B1 22%  perf-profile.ch=
ildren.cycles-pp.perf_trace_buf_update
> >       0.17 =C2=B1  8%      -0.1        0.03 =C2=B1100%  perf-profile.ch=
ildren.cycles-pp.rb_next
> >       0.15 =C2=B1 32%      -0.1        0.03 =C2=B1100%  perf-profile.ch=
ildren.cycles-pp.llist_reverse_order
> >       0.34 =C2=B1  7%      -0.1        0.26 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.anon_pipe_buf_release
> >       0.14 =C2=B1  6%      -0.1        0.07 =C2=B1 17%  perf-profile.ch=
ildren.cycles-pp.read@plt
> >       0.10 =C2=B1 17%      -0.1        0.04 =C2=B1 75%  perf-profile.ch=
ildren.cycles-pp.remove_entity_load_avg
> >       0.07 =C2=B1 10%      -0.0        0.02 =C2=B1 99%  perf-profile.ch=
ildren.cycles-pp.generic_update_time
> >       0.11 =C2=B1  6%      -0.0        0.07 =C2=B1  8%  perf-profile.ch=
ildren.cycles-pp.__mark_inode_dirty
> >       0.00            +0.1        0.06 =C2=B1  9%  perf-profile.childre=
n.cycles-pp.load_balance
> >       0.00            +0.1        0.06 =C2=B1 11%  perf-profile.childre=
n.cycles-pp._raw_spin_trylock
> >       0.00            +0.1        0.06 =C2=B1  7%  perf-profile.childre=
n.cycles-pp.uncharge_folio
> >       0.00            +0.1        0.06 =C2=B1  7%  perf-profile.childre=
n.cycles-pp.__do_softirq
> >       0.00            +0.1        0.07 =C2=B1 10%  perf-profile.childre=
n.cycles-pp.tick_nohz_get_sleep_length
> >       0.00            +0.1        0.08 =C2=B1 14%  perf-profile.childre=
n.cycles-pp.__get_obj_cgroup_from_memcg
> >       0.15 =C2=B1 23%      +0.1        0.23 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.task_tick_fair
> >       0.19 =C2=B1 17%      +0.1        0.28 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.scheduler_tick
> >       0.00            +0.1        0.10 =C2=B1 21%  perf-profile.childre=
n.cycles-pp.select_idle_core
> >       0.00            +0.1        0.10 =C2=B1  9%  perf-profile.childre=
n.cycles-pp.osq_unlock
> >       0.23 =C2=B1 12%      +0.1        0.34 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.update_process_times
> >       0.37 =C2=B1 13%      +0.1        0.48 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.hrtimer_interrupt
> >       0.24 =C2=B1 12%      +0.1        0.35 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.tick_sched_handle
> >       0.31 =C2=B1 14%      +0.1        0.43 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.__hrtimer_run_queues
> >       0.37 =C2=B1 12%      +0.1        0.49 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.__sysvec_apic_timer_interrupt
> >       0.00            +0.1        0.12 =C2=B1 10%  perf-profile.childre=
n.cycles-pp.__mod_memcg_state
> >       0.26 =C2=B1 10%      +0.1        0.38 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.tick_sched_timer
> >       0.00            +0.1        0.13 =C2=B1  7%  perf-profile.childre=
n.cycles-pp.free_unref_page
> >       0.00            +0.1        0.14 =C2=B1  8%  perf-profile.childre=
n.cycles-pp.rmqueue
> >       0.15 =C2=B1  8%      +0.2        0.30 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.rcu_all_qs
> >       0.16 =C2=B1  6%      +0.2        0.31 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_write
> >       0.00            +0.2        0.16 =C2=B1 10%  perf-profile.childre=
n.cycles-pp.propagate_protected_usage
> >       0.00            +0.2        0.16 =C2=B1 10%  perf-profile.childre=
n.cycles-pp.menu_select
> >       0.00            +0.2        0.16 =C2=B1  9%  perf-profile.childre=
n.cycles-pp.memcg_account_kmem
> >       0.42 =C2=B1 12%      +0.2        0.57 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.sysvec_apic_timer_interrupt
> >       0.15 =C2=B1 11%      +0.2        0.31 =C2=B1  8%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_read
> >       0.00            +0.2        0.17 =C2=B1  8%  perf-profile.childre=
n.cycles-pp.get_page_from_freelist
> >       0.44 =C2=B1 11%      +0.2        0.62 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.asm_sysvec_apic_timer_interrupt
> >       0.10 =C2=B1 31%      +0.2        0.28 =C2=B1 24%  perf-profile.ch=
ildren.cycles-pp.mnt_user_ns
> >       0.16 =C2=B1  4%      +0.2        0.35 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.kill_fasync
> >       0.20 =C2=B1 10%      +0.2        0.40 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.syscall_exit_to_user_mode_prepare
> >       0.09 =C2=B1  7%      +0.2        0.29 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.page_copy_sane
> >       0.08 =C2=B1  8%      +0.2        0.31 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.rw_verify_area
> >       0.12 =C2=B1 11%      +0.2        0.36 =C2=B1  8%  perf-profile.ch=
ildren.cycles-pp.ktime_get_coarse_real_ts64
> >       0.28 =C2=B1 12%      +0.2        0.52 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.inode_needs_update_time
> >       0.00            +0.3        0.27 =C2=B1  7%  perf-profile.childre=
n.cycles-pp.__memcg_kmem_charge_page
> >       0.43 =C2=B1  6%      +0.3        0.73 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.__cond_resched
> >       0.21 =C2=B1 29%      +0.3        0.54 =C2=B1 15%  perf-profile.ch=
ildren.cycles-pp.select_idle_cpu
> >       0.10 =C2=B1 10%      +0.3        0.43 =C2=B1 17%  perf-profile.ch=
ildren.cycles-pp.fsnotify_perm
> >       0.23 =C2=B1 11%      +0.3        0.56 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.syscall_enter_from_user_mode
> >       0.06 =C2=B1 75%      +0.4        0.47 =C2=B1 27%  perf-profile.ch=
ildren.cycles-pp.queue_event
> >       0.21 =C2=B1  9%      +0.4        0.62 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.entry_SYSCALL_64_safe_stack
> >       0.06 =C2=B1 75%      +0.4        0.48 =C2=B1 26%  perf-profile.ch=
ildren.cycles-pp.ordered_events__queue
> >       0.06 =C2=B1 73%      +0.4        0.50 =C2=B1 24%  perf-profile.ch=
ildren.cycles-pp.process_simple
> >       0.01 =C2=B1223%      +0.4        0.44 =C2=B1  9%  perf-profile.ch=
ildren.cycles-pp.schedule_idle
> >       0.05 =C2=B1  8%      +0.5        0.52 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.__alloc_pages
> >       0.45 =C2=B1  7%      +0.5        0.94 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.__get_task_ioprio
> >       0.89 =C2=B1  8%      +0.5        1.41 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.__might_sleep
> >       0.01 =C2=B1223%      +0.5        0.54 =C2=B1 21%  perf-profile.ch=
ildren.cycles-pp.flush_smp_call_function_queue
> >       0.05 =C2=B1 46%      +0.5        0.60 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.osq_lock
> >       0.34 =C2=B1  8%      +0.6        0.90 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.aa_file_perm
> >       0.01 =C2=B1223%      +0.7        0.67 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.poll_idle
> >       0.14 =C2=B1 17%      +0.7        0.82 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.mutex_spin_on_owner
> >       0.12 =C2=B1 12%      +0.7        0.82 =C2=B1 15%  perf-profile.ch=
ildren.cycles-pp.__cmd_record
> >       0.07 =C2=B1 72%      +0.7        0.78 =C2=B1 19%  perf-profile.ch=
ildren.cycles-pp.reader__read_event
> >       0.07 =C2=B1 72%      +0.7        0.78 =C2=B1 19%  perf-profile.ch=
ildren.cycles-pp.record__finish_output
> >       0.07 =C2=B1 72%      +0.7        0.78 =C2=B1 19%  perf-profile.ch=
ildren.cycles-pp.perf_session__process_events
> >       0.76 =C2=B1  8%      +0.8        1.52 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.file_update_time
> >       0.08 =C2=B1 61%      +0.8        0.85 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.intel_idle_irq
> >       1.23 =C2=B1  8%      +0.9        2.11 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.__might_fault
> >       0.02 =C2=B1141%      +1.0        0.97 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.page_counter_uncharge
> >       0.51 =C2=B1  9%      +1.0        1.48 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.current_time
> >       0.05 =C2=B1 46%      +1.1        1.15 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.uncharge_batch
> >       1.12 =C2=B1  6%      +1.1        2.23 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.__fget_light
> >       0.06 =C2=B1 14%      +1.2        1.23 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.__mem_cgroup_uncharge
> >       0.06 =C2=B1 14%      +1.2        1.24 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.__folio_put
> >       0.64 =C2=B1  7%      +1.2        1.83 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.syscall_return_via_sysret
> >       1.19 =C2=B1  8%      +1.2        2.42 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.__might_resched
> >       0.59 =C2=B1  9%      +1.3        1.84 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.atime_needs_update
> >      43.47            +1.4       44.83        perf-profile.children.cyc=
les-pp.ksys_write
> >       1.28 =C2=B1  6%      +1.4        2.68 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.__fdget_pos
> >       0.80 =C2=B1  8%      +1.5        2.28 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.touch_atime
> >       0.11 =C2=B1 49%      +1.5        1.59 =C2=B1  9%  perf-profile.ch=
ildren.cycles-pp.cpuidle_enter_state
> >       0.11 =C2=B1 49%      +1.5        1.60 =C2=B1  9%  perf-profile.ch=
ildren.cycles-pp.cpuidle_enter
> >       0.12 =C2=B1 51%      +1.7        1.81 =C2=B1  9%  perf-profile.ch=
ildren.cycles-pp.cpuidle_idle_call
> >       1.44 =C2=B1  8%      +1.8        3.22 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.copyin
> >       2.00 =C2=B1  9%      +2.0        4.03 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.copyout
> >       1.02 =C2=B1  8%      +2.0        3.07 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       1.63 =C2=B1  7%      +2.3        3.90 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.apparmor_file_permission
> >       2.64 =C2=B1  8%      +2.3        4.98 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp._copy_from_iter
> >       0.40 =C2=B1 14%      +2.5        2.92 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.__mutex_lock
> >       2.91 =C2=B1  8%      +2.6        5.54 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.copy_page_from_iter
> >       0.17 =C2=B1 62%      +2.7        2.91 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.start_secondary
> >       1.83 =C2=B1  7%      +2.8        4.59 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.security_file_permission
> >       0.17 =C2=B1 60%      +2.8        2.94 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.do_idle
> >       0.17 =C2=B1 60%      +2.8        2.96 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.secondary_startup_64_no_verify
> >       0.17 =C2=B1 60%      +2.8        2.96 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.cpu_startup_entry
> >       2.62 =C2=B1  9%      +3.2        5.84 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp._copy_to_iter
> >       1.55 =C2=B1  8%      +3.2        4.79 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.__entry_text_start
> >       3.09 =C2=B1  8%      +3.7        6.77 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.copy_user_enhanced_fast_string
> >       2.95 =C2=B1  9%      +3.8        6.73 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.copy_page_to_iter
> >       2.28 =C2=B1 11%      +5.1        7.40 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.mutex_unlock
> >       3.92 =C2=B1  9%      +6.0        9.94 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.mutex_lock
> >       8.37 =C2=B1  9%      -5.8        2.60 =C2=B1 23%  perf-profile.se=
lf.cycles-pp.native_queued_spin_lock_slowpath
> >       6.54 =C2=B1 15%      -4.6        1.95 =C2=B1 57%  perf-profile.se=
lf.cycles-pp.update_cfs_group
> >       3.08 =C2=B1  4%      -2.3        0.74 =C2=B1 22%  perf-profile.se=
lf.cycles-pp.switch_mm_irqs_off
> >       2.96 =C2=B1  4%      -1.8        1.13 =C2=B1 33%  perf-profile.se=
lf.cycles-pp.update_load_avg
> >       2.22 =C2=B1  8%      -1.5        0.74 =C2=B1 12%  perf-profile.se=
lf.cycles-pp._raw_spin_lock_irqsave
> >       1.96 =C2=B1  9%      -1.5        0.48 =C2=B1 15%  perf-profile.se=
lf.cycles-pp.update_curr
> >       1.94 =C2=B1  5%      -1.3        0.64 =C2=B1 16%  perf-profile.se=
lf.cycles-pp._raw_spin_lock
> >       1.78 =C2=B1  5%      -1.3        0.50 =C2=B1 18%  perf-profile.se=
lf.cycles-pp.__schedule
> >       1.59 =C2=B1  7%      -1.2        0.40 =C2=B1 12%  perf-profile.se=
lf.cycles-pp.enqueue_entity
> >       1.61 =C2=B1  6%      -1.2        0.42 =C2=B1 25%  perf-profile.se=
lf.cycles-pp.restore_fpregs_from_fpstate
> >       1.44 =C2=B1  8%      -1.0        0.39 =C2=B1 14%  perf-profile.se=
lf.cycles-pp.__update_load_avg_cfs_rq
> >       1.42 =C2=B1  5%      -1.0        0.41 =C2=B1 19%  perf-profile.se=
lf.cycles-pp.__switch_to_asm
> >       1.18 =C2=B1  7%      -0.9        0.33 =C2=B1 14%  perf-profile.se=
lf.cycles-pp.__update_load_avg_se
> >       1.14 =C2=B1 10%      -0.8        0.31 =C2=B1  9%  perf-profile.se=
lf.cycles-pp.update_rq_clock
> >       0.90 =C2=B1  7%      -0.7        0.19 =C2=B1 21%  perf-profile.se=
lf.cycles-pp.pick_next_task_fair
> >       1.04 =C2=B1  7%      -0.7        0.33 =C2=B1 13%  perf-profile.se=
lf.cycles-pp.prepare_task_switch
> >       0.98 =C2=B1  4%      -0.7        0.29 =C2=B1 20%  perf-profile.se=
lf.cycles-pp.__switch_to
> >       0.88 =C2=B1  6%      -0.7        0.20 =C2=B1 17%  perf-profile.se=
lf.cycles-pp.enqueue_task_fair
> >       1.01 =C2=B1  6%      -0.7        0.35 =C2=B1 10%  perf-profile.se=
lf.cycles-pp.prepare_to_wait_event
> >       0.90 =C2=B1  8%      -0.6        0.25 =C2=B1 12%  perf-profile.se=
lf.cycles-pp.update_min_vruntime
> >       0.79 =C2=B1 17%      -0.6        0.22 =C2=B1  9%  perf-profile.se=
lf.cycles-pp.cpuacct_charge
> >       1.10 =C2=B1  5%      -0.6        0.54 =C2=B1  9%  perf-profile.se=
lf.cycles-pp.try_to_wake_up
> >       0.66 =C2=B1  3%      -0.5        0.15 =C2=B1 27%  perf-profile.se=
lf.cycles-pp.os_xsave
> >       0.71 =C2=B1  6%      -0.5        0.22 =C2=B1 18%  perf-profile.se=
lf.cycles-pp.reweight_entity
> >       0.68 =C2=B1  9%      -0.5        0.19 =C2=B1 10%  perf-profile.se=
lf.cycles-pp.perf_trace_sched_wakeup_template
> >       0.67 =C2=B1  9%      -0.5        0.18 =C2=B1 11%  perf-profile.se=
lf.cycles-pp.__wake_up_common
> >       0.65 =C2=B1  6%      -0.5        0.17 =C2=B1 23%  perf-profile.se=
lf.cycles-pp.switch_fpu_return
> >       0.60 =C2=B1 11%      -0.5        0.14 =C2=B1 28%  perf-profile.se=
lf.cycles-pp.perf_tp_event
> >       0.52 =C2=B1 44%      -0.5        0.06 =C2=B1151%  perf-profile.se=
lf.cycles-pp.native_irq_return_iret
> >       0.52 =C2=B1  7%      -0.4        0.08 =C2=B1 25%  perf-profile.se=
lf.cycles-pp._raw_spin_unlock_irqrestore
> >       0.55 =C2=B1  4%      -0.4        0.15 =C2=B1 22%  perf-profile.se=
lf.cycles-pp.__calc_delta
> >       0.61 =C2=B1  5%      -0.4        0.21 =C2=B1 12%  perf-profile.se=
lf.cycles-pp.dequeue_task_fair
> >       0.69 =C2=B1 14%      -0.4        0.32 =C2=B1 11%  perf-profile.se=
lf.cycles-pp.task_h_load
> >       0.49 =C2=B1 11%      -0.3        0.15 =C2=B1 29%  perf-profile.se=
lf.cycles-pp.___perf_sw_event
> >       0.37 =C2=B1  4%      -0.3        0.05 =C2=B1 73%  perf-profile.se=
lf.cycles-pp.pick_next_entity
> >       0.50 =C2=B1  3%      -0.3        0.19 =C2=B1 15%  perf-profile.se=
lf.cycles-pp.select_idle_sibling
> >       0.38 =C2=B1  9%      -0.3        0.08 =C2=B1 24%  perf-profile.se=
lf.cycles-pp.set_next_buddy
> >       0.32 =C2=B1  4%      -0.3        0.03 =C2=B1100%  perf-profile.se=
lf.cycles-pp.put_prev_entity
> >       0.64 =C2=B1  6%      -0.3        0.35 =C2=B1  7%  perf-profile.se=
lf.cycles-pp._raw_spin_lock_irq
> >       0.52 =C2=B1  5%      -0.3        0.25 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.__list_del_entry_valid
> >       0.34 =C2=B1  5%      -0.3        0.07 =C2=B1 29%  perf-profile.se=
lf.cycles-pp.schedule
> >       0.35 =C2=B1  9%      -0.3        0.08 =C2=B1 10%  perf-profile.se=
lf.cycles-pp.rb_insert_color
> >       0.40 =C2=B1  5%      -0.3        0.14 =C2=B1 16%  perf-profile.se=
lf.cycles-pp.select_task_rq_fair
> >       0.33 =C2=B1  6%      -0.3        0.08 =C2=B1 16%  perf-profile.se=
lf.cycles-pp.check_preempt_wakeup
> >       0.33 =C2=B1  8%      -0.2        0.10 =C2=B1 16%  perf-profile.se=
lf.cycles-pp.select_task_rq
> >       0.36 =C2=B1  3%      -0.2        0.13 =C2=B1 16%  perf-profile.se=
lf.cycles-pp.native_sched_clock
> >       0.32 =C2=B1  7%      -0.2        0.10 =C2=B1 14%  perf-profile.se=
lf.cycles-pp.finish_task_switch
> >       0.32 =C2=B1  4%      -0.2        0.11 =C2=B1 13%  perf-profile.se=
lf.cycles-pp.dequeue_entity
> >       0.32 =C2=B1  8%      -0.2        0.12 =C2=B1 10%  perf-profile.se=
lf.cycles-pp.__list_add_valid
> >       0.23 =C2=B1  5%      -0.2        0.03 =C2=B1103%  perf-profile.se=
lf.cycles-pp.resched_curr
> >       0.27 =C2=B1  6%      -0.2        0.07 =C2=B1 21%  perf-profile.se=
lf.cycles-pp.rb_erase
> >       0.27 =C2=B1  5%      -0.2        0.08 =C2=B1 20%  perf-profile.se=
lf.cycles-pp.__wrgsbase_inactive
> >       0.28 =C2=B1 13%      -0.2        0.09 =C2=B1 12%  perf-profile.se=
lf.cycles-pp.check_preempt_curr
> >       0.30 =C2=B1 13%      -0.2        0.12 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.ttwu_queue_wakelist
> >       0.24 =C2=B1  5%      -0.2        0.06 =C2=B1 19%  perf-profile.se=
lf.cycles-pp.set_next_entity
> >       0.21 =C2=B1 34%      -0.2        0.04 =C2=B1 71%  perf-profile.se=
lf.cycles-pp.__flush_smp_call_function_queue
> >       0.25 =C2=B1  5%      -0.2        0.08 =C2=B1 16%  perf-profile.se=
lf.cycles-pp.rcu_note_context_switch
> >       0.19 =C2=B1 26%      -0.1        0.04 =C2=B1 73%  perf-profile.se=
lf.cycles-pp.perf_trace_sched_stat_runtime
> >       0.20 =C2=B1  8%      -0.1        0.06 =C2=B1 13%  perf-profile.se=
lf.cycles-pp.ttwu_do_activate
> >       0.17 =C2=B1  8%      -0.1        0.03 =C2=B1100%  perf-profile.se=
lf.cycles-pp.rb_next
> >       0.22 =C2=B1 23%      -0.1        0.09 =C2=B1 31%  perf-profile.se=
lf.cycles-pp.migrate_task_rq_fair
> >       0.15 =C2=B1 32%      -0.1        0.03 =C2=B1100%  perf-profile.se=
lf.cycles-pp.llist_reverse_order
> >       0.16 =C2=B1  8%      -0.1        0.06 =C2=B1 14%  perf-profile.se=
lf.cycles-pp.wake_affine
> >       0.10 =C2=B1 31%      -0.1        0.03 =C2=B1100%  perf-profile.se=
lf.cycles-pp.sched_ttwu_pending
> >       0.14 =C2=B1  5%      -0.1        0.07 =C2=B1 20%  perf-profile.se=
lf.cycles-pp.read@plt
> >       0.32 =C2=B1  8%      -0.1        0.26 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.anon_pipe_buf_release
> >       0.10 =C2=B1  6%      -0.1        0.04 =C2=B1 45%  perf-profile.se=
lf.cycles-pp.__wake_up_common_lock
> >       0.10 =C2=B1  9%      -0.0        0.07 =C2=B1  8%  perf-profile.se=
lf.cycles-pp.__mark_inode_dirty
> >       0.00            +0.1        0.06 =C2=B1 11%  perf-profile.self.cy=
cles-pp.free_unref_page
> >       0.00            +0.1        0.06 =C2=B1  6%  perf-profile.self.cy=
cles-pp.__alloc_pages
> >       0.00            +0.1        0.06 =C2=B1 11%  perf-profile.self.cy=
cles-pp._raw_spin_trylock
> >       0.00            +0.1        0.06 =C2=B1  7%  perf-profile.self.cy=
cles-pp.uncharge_folio
> >       0.00            +0.1        0.06 =C2=B1 11%  perf-profile.self.cy=
cles-pp.uncharge_batch
> >       0.00            +0.1        0.07 =C2=B1 10%  perf-profile.self.cy=
cles-pp.menu_select
> >       0.00            +0.1        0.08 =C2=B1 14%  perf-profile.self.cy=
cles-pp.__get_obj_cgroup_from_memcg
> >       0.00            +0.1        0.08 =C2=B1  7%  perf-profile.self.cy=
cles-pp.__memcg_kmem_charge_page
> >       0.00            +0.1        0.10 =C2=B1 10%  perf-profile.self.cy=
cles-pp.osq_unlock
> >       0.07 =C2=B1  5%      +0.1        0.17 =C2=B1  8%  perf-profile.se=
lf.cycles-pp.copyin
> >       0.00            +0.1        0.11 =C2=B1 11%  perf-profile.self.cy=
cles-pp.__mod_memcg_state
> >       0.13 =C2=B1  8%      +0.1        0.24 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.rcu_all_qs
> >       0.14 =C2=B1  5%      +0.1        0.28 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.__x64_sys_write
> >       0.07 =C2=B1 10%      +0.1        0.21 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.page_copy_sane
> >       0.13 =C2=B1 12%      +0.1        0.28 =C2=B1  9%  perf-profile.se=
lf.cycles-pp.__x64_sys_read
> >       0.00            +0.2        0.15 =C2=B1 10%  perf-profile.self.cy=
cles-pp.propagate_protected_usage
> >       0.18 =C2=B1  9%      +0.2        0.33 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.syscall_exit_to_user_mode_prepare
> >       0.07 =C2=B1  8%      +0.2        0.23 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.rw_verify_area
> >       0.08 =C2=B1 34%      +0.2        0.24 =C2=B1 27%  perf-profile.se=
lf.cycles-pp.mnt_user_ns
> >       0.13 =C2=B1  5%      +0.2        0.31 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.kill_fasync
> >       0.21 =C2=B1  8%      +0.2        0.39 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.__might_fault
> >       0.06 =C2=B1 13%      +0.2        0.26 =C2=B1  9%  perf-profile.se=
lf.cycles-pp.copyout
> >       0.10 =C2=B1 11%      +0.2        0.31 =C2=B1  8%  perf-profile.se=
lf.cycles-pp.ktime_get_coarse_real_ts64
> >       0.26 =C2=B1 13%      +0.2        0.49 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.inode_needs_update_time
> >       0.23 =C2=B1  8%      +0.2        0.47 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.copy_page_from_iter
> >       0.14 =C2=B1  7%      +0.2        0.38 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.file_update_time
> >       0.36 =C2=B1  7%      +0.3        0.62 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.ksys_read
> >       0.54 =C2=B1 13%      +0.3        0.80 =C2=B1  4%  perf-profile.se=
lf.cycles-pp._copy_from_iter
> >       0.15 =C2=B1  5%      +0.3        0.41 =C2=B1  8%  perf-profile.se=
lf.cycles-pp.touch_atime
> >       0.14 =C2=B1  5%      +0.3        0.40 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.__cond_resched
> >       0.18 =C2=B1  5%      +0.3        0.47 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.syscall_exit_to_user_mode
> >       0.16 =C2=B1  8%      +0.3        0.46 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.syscall_enter_from_user_mode
> >       0.16 =C2=B1  9%      +0.3        0.47 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.__fdget_pos
> >       1.79 =C2=B1  8%      +0.3        2.12 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.pipe_read
> >       0.10 =C2=B1  8%      +0.3        0.43 =C2=B1 17%  perf-profile.se=
lf.cycles-pp.fsnotify_perm
> >       0.20 =C2=B1  4%      +0.4        0.55 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.ksys_write
> >       0.05 =C2=B1 76%      +0.4        0.46 =C2=B1 27%  perf-profile.se=
lf.cycles-pp.queue_event
> >       0.32 =C2=B1  6%      +0.4        0.73 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.exit_to_user_mode_prepare
> >       0.21 =C2=B1  9%      +0.4        0.62 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.entry_SYSCALL_64_safe_stack
> >       0.79 =C2=B1  8%      +0.4        1.22 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.__might_sleep
> >       0.44 =C2=B1  5%      +0.4        0.88 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.do_syscall_64
> >       0.26 =C2=B1  8%      +0.4        0.70 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.atime_needs_update
> >       0.42 =C2=B1  7%      +0.5        0.88 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.__get_task_ioprio
> >       0.28 =C2=B1 12%      +0.5        0.75 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.copy_page_to_iter
> >       0.19 =C2=B1  6%      +0.5        0.68 =C2=B1 10%  perf-profile.se=
lf.cycles-pp.security_file_permission
> >       0.31 =C2=B1  8%      +0.5        0.83 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.aa_file_perm
> >       0.05 =C2=B1 46%      +0.5        0.59 =C2=B1  8%  perf-profile.se=
lf.cycles-pp.osq_lock
> >       0.30 =C2=B1  7%      +0.5        0.85 =C2=B1  6%  perf-profile.se=
lf.cycles-pp._copy_to_iter
> >       0.00            +0.6        0.59 =C2=B1  6%  perf-profile.self.cy=
cles-pp.poll_idle
> >       0.13 =C2=B1 20%      +0.7        0.81 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.mutex_spin_on_owner
> >       0.38 =C2=B1  9%      +0.7        1.12 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.current_time
> >       0.08 =C2=B1 59%      +0.8        0.82 =C2=B1 11%  perf-profile.se=
lf.cycles-pp.intel_idle_irq
> >       0.92 =C2=B1  6%      +0.8        1.72 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.entry_SYSCALL_64_after_hwframe
> >       0.01 =C2=B1223%      +0.8        0.82 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.page_counter_uncharge
> >       0.86 =C2=B1  7%      +1.1        1.91 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.vfs_read
> >       1.07 =C2=B1  6%      +1.1        2.14 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.__fget_light
> >       0.67 =C2=B1  7%      +1.1        1.74 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.vfs_write
> >       0.15 =C2=B1 12%      +1.1        1.28 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.__mutex_lock
> >       1.09 =C2=B1  6%      +1.1        2.22 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.__libc_read
> >       0.62 =C2=B1  6%      +1.2        1.79 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.syscall_return_via_sysret
> >       1.16 =C2=B1  8%      +1.2        2.38 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.__might_resched
> >       0.91 =C2=B1  7%      +1.3        2.20 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.__libc_write
> >       0.59 =C2=B1  8%      +1.3        1.93 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.__entry_text_start
> >       1.27 =C2=B1  7%      +1.7        3.00 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.apparmor_file_permission
> >       0.99 =C2=B1  8%      +2.0        2.98 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       1.74 =C2=B1  8%      +3.4        5.15 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.pipe_write
> >       2.98 =C2=B1  8%      +3.7        6.64 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.copy_user_enhanced_fast_string
> >       2.62 =C2=B1 10%      +4.8        7.38 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.mutex_lock
> >       2.20 =C2=B1 10%      +5.1        7.30 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.mutex_unlock
> >
> >
> > ***********************************************************************=
****************************
> > lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs=
/tbox_group/testcase:
> >   gcc-11/performance/socket/4/x86_64-rhel-8.3/process/100%/debian-11.1-=
x86_64-20220510.cgz/lkp-skl-fpga01/hackbench
> >
> > commit:
> >   a2e90611b9 ("sched/fair: Remove capacity inversion detection")
> >   829c1651e9 ("sched/fair: sanitize vruntime of entity being placed")
> >
> > a2e90611b9f425ad 829c1651e9c4a6f78398d3e6765
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >     177139            -8.1%     162815        hackbench.throughput
> >     174484           -18.8%     141618 =C2=B1  2%  hackbench.throughput=
_avg
> >     177139            -8.1%     162815        hackbench.throughput_best
> >     168530           -37.3%     105615 =C2=B1  3%  hackbench.throughput=
_worst
> >     281.38           +23.1%     346.39 =C2=B1  2%  hackbench.time.elaps=
ed_time
> >     281.38           +23.1%     346.39 =C2=B1  2%  hackbench.time.elaps=
ed_time.max
> >  1.053e+08 =C2=B1  2%    +688.4%  8.302e+08 =C2=B1  9%  hackbench.time.=
involuntary_context_switches
> >      21992           +27.8%      28116 =C2=B1  2%  hackbench.time.syste=
m_time
> >       6652            +8.2%       7196        hackbench.time.user_time
> >  3.482e+08          +289.2%  1.355e+09 =C2=B1  9%  hackbench.time.volun=
tary_context_switches
> >    2110813 =C2=B1  5%     +21.6%    2565791 =C2=B1  3%  cpuidle..usage
> >     333.95           +19.5%     399.05        uptime.boot
> >       0.03            -0.0        0.03        mpstat.cpu.all.soft%
> >      22.68            -2.9       19.77        mpstat.cpu.all.usr%
> >     561083 =C2=B1 10%     +45.5%     816171 =C2=B1 12%  numa-numastat.n=
ode0.local_node
> >     614314 =C2=B1  9%     +36.9%     841173 =C2=B1 12%  numa-numastat.n=
ode0.numa_hit
> >    1393279 =C2=B1  7%     -16.8%    1158997 =C2=B1  2%  numa-numastat.n=
ode1.local_node
> >    1443679 =C2=B1  5%     -14.9%    1229074 =C2=B1  3%  numa-numastat.n=
ode1.numa_hit
> >    4129900 =C2=B1  8%     -23.0%    3181115        vmstat.memory.cache
> >       1731           +30.8%       2265        vmstat.procs.r
> >    1598044          +290.3%    6237840 =C2=B1  7%  vmstat.system.cs
> >     320762           +60.5%     514672 =C2=B1  8%  vmstat.system.in
> >     962111 =C2=B1  6%     +46.0%    1404646 =C2=B1  7%  turbostat.C1
> >     233987 =C2=B1  5%     +51.2%     353892        turbostat.C1E
> >   91515563           +97.3%  1.806e+08 =C2=B1 10%  turbostat.IRQ
> >     448466 =C2=B1 14%     -34.2%     294934 =C2=B1  5%  turbostat.POLL
> >      34.60            -7.3%      32.07        turbostat.RAMWatt
> >     514028 =C2=B1  2%     -14.0%     442125 =C2=B1  2%  meminfo.AnonPag=
es
> >    4006312 =C2=B1  8%     -23.9%    3047078        meminfo.Cached
> >    3321064 =C2=B1 10%     -32.7%    2236362 =C2=B1  2%  meminfo.Committ=
ed_AS
> >    1714752 =C2=B1 21%     -60.3%     680479 =C2=B1  8%  meminfo.Inactiv=
e
> >    1714585 =C2=B1 21%     -60.3%     680305 =C2=B1  8%  meminfo.Inactiv=
e(anon)
> >     757124 =C2=B1 18%     -67.2%     248485 =C2=B1 27%  meminfo.Mapped
> >    6476123 =C2=B1  6%     -19.4%    5220738        meminfo.Memused
> >    1275724 =C2=B1 26%     -75.2%     316896 =C2=B1 15%  meminfo.Shmem
> >    6806047 =C2=B1  3%     -13.3%    5901974        meminfo.max_used_kB
> >     161311 =C2=B1 23%     +31.7%     212494 =C2=B1  5%  numa-meminfo.no=
de0.AnonPages
> >     165693 =C2=B1 22%     +30.5%     216264 =C2=B1  5%  numa-meminfo.no=
de0.Inactive
> >     165563 =C2=B1 22%     +30.6%     216232 =C2=B1  5%  numa-meminfo.no=
de0.Inactive(anon)
> >     140638 =C2=B1 19%     -36.7%      89034 =C2=B1 11%  numa-meminfo.no=
de0.Mapped
> >     352173 =C2=B1 14%     -35.3%     227805 =C2=B1  8%  numa-meminfo.no=
de1.AnonPages
> >     501396 =C2=B1 11%     -22.6%     388042 =C2=B1  5%  numa-meminfo.no=
de1.AnonPages.max
> >    1702242 =C2=B1 43%     -77.8%     378325 =C2=B1 22%  numa-meminfo.no=
de1.FilePages
> >    1540803 =C2=B1 25%     -70.4%     455592 =C2=B1 13%  numa-meminfo.no=
de1.Inactive
> >    1540767 =C2=B1 25%     -70.4%     455451 =C2=B1 13%  numa-meminfo.no=
de1.Inactive(anon)
> >     612123 =C2=B1 18%     -74.9%     153752 =C2=B1 37%  numa-meminfo.no=
de1.Mapped
> >    3085231 =C2=B1 24%     -53.9%    1420940 =C2=B1 14%  numa-meminfo.no=
de1.MemUsed
> >     254052 =C2=B1  4%     -19.1%     205632 =C2=B1 21%  numa-meminfo.no=
de1.SUnreclaim
> >    1259640 =C2=B1 27%     -75.9%     303123 =C2=B1 15%  numa-meminfo.no=
de1.Shmem
> >     304597 =C2=B1  7%     -20.2%     242920 =C2=B1 17%  numa-meminfo.no=
de1.Slab
> >      40345 =C2=B1 23%     +31.5%      53054 =C2=B1  5%  numa-vmstat.nod=
e0.nr_anon_pages
> >      41412 =C2=B1 22%     +30.4%      53988 =C2=B1  5%  numa-vmstat.nod=
e0.nr_inactive_anon
> >      35261 =C2=B1 19%     -36.9%      22256 =C2=B1 12%  numa-vmstat.nod=
e0.nr_mapped
> >      41412 =C2=B1 22%     +30.4%      53988 =C2=B1  5%  numa-vmstat.nod=
e0.nr_zone_inactive_anon
> >     614185 =C2=B1  9%     +36.9%     841065 =C2=B1 12%  numa-vmstat.nod=
e0.numa_hit
> >     560955 =C2=B1 11%     +45.5%     816063 =C2=B1 12%  numa-vmstat.nod=
e0.numa_local
> >      88129 =C2=B1 14%     -35.2%      57097 =C2=B1  8%  numa-vmstat.nod=
e1.nr_anon_pages
> >     426425 =C2=B1 43%     -77.9%      94199 =C2=B1 22%  numa-vmstat.nod=
e1.nr_file_pages
> >     386166 =C2=B1 25%     -70.5%     113880 =C2=B1 13%  numa-vmstat.nod=
e1.nr_inactive_anon
> >     153658 =C2=B1 18%     -75.3%      38021 =C2=B1 37%  numa-vmstat.nod=
e1.nr_mapped
> >     315775 =C2=B1 27%     -76.1%      75399 =C2=B1 16%  numa-vmstat.nod=
e1.nr_shmem
> >      63411 =C2=B1  4%     -18.6%      51593 =C2=B1 21%  numa-vmstat.nod=
e1.nr_slab_unreclaimable
> >     386166 =C2=B1 25%     -70.5%     113880 =C2=B1 13%  numa-vmstat.nod=
e1.nr_zone_inactive_anon
> >    1443470 =C2=B1  5%     -14.9%    1228740 =C2=B1  3%  numa-vmstat.nod=
e1.numa_hit
> >    1393069 =C2=B1  7%     -16.8%    1158664 =C2=B1  2%  numa-vmstat.nod=
e1.numa_local
> >     128457 =C2=B1  2%     -14.0%     110530 =C2=B1  3%  proc-vmstat.nr_=
anon_pages
> >     999461 =C2=B1  8%     -23.8%     761774        proc-vmstat.nr_file_=
pages
> >     426485 =C2=B1 21%     -60.1%     170237 =C2=B1  9%  proc-vmstat.nr_=
inactive_anon
> >      82464            -2.6%      80281        proc-vmstat.nr_kernel_sta=
ck
> >     187777 =C2=B1 18%     -66.9%      62076 =C2=B1 28%  proc-vmstat.nr_=
mapped
> >     316813 =C2=B1 27%     -75.0%      79228 =C2=B1 16%  proc-vmstat.nr_=
shmem
> >      31469            -2.0%      30840        proc-vmstat.nr_slab_recla=
imable
> >     117889            -8.4%     108036        proc-vmstat.nr_slab_unrec=
laimable
> >     426485 =C2=B1 21%     -60.1%     170237 =C2=B1  9%  proc-vmstat.nr_=
zone_inactive_anon
> >     187187 =C2=B1 12%     -43.5%     105680 =C2=B1  9%  proc-vmstat.num=
a_hint_faults
> >     128363 =C2=B1 15%     -61.5%      49371 =C2=B1 19%  proc-vmstat.num=
a_hint_faults_local
> >      47314 =C2=B1 22%     +39.2%      65863 =C2=B1 13%  proc-vmstat.num=
a_pages_migrated
> >     457026 =C2=B1  9%     -18.1%     374188 =C2=B1 13%  proc-vmstat.num=
a_pte_updates
> >    2586600 =C2=B1  3%     +27.7%    3302787 =C2=B1  8%  proc-vmstat.pga=
lloc_normal
> >    1589970            -6.2%    1491838        proc-vmstat.pgfault
> >    2347186 =C2=B1 10%     +37.7%    3232369 =C2=B1  8%  proc-vmstat.pgf=
ree
> >      47314 =C2=B1 22%     +39.2%      65863 =C2=B1 13%  proc-vmstat.pgm=
igrate_success
> >     112713            +7.0%     120630 =C2=B1  3%  proc-vmstat.pgreuse
> >    2189056           +22.2%    2674944 =C2=B1  2%  proc-vmstat.unevicta=
ble_pgs_scanned
> >      14.08 =C2=B1  2%     +29.3%      18.20 =C2=B1  5%  sched_debug.cfs=
_rq:/.h_nr_running.avg
> >       0.80 =C2=B1 14%    +179.2%       2.23 =C2=B1 24%  sched_debug.cfs=
_rq:/.h_nr_running.min
> >     245.23 =C2=B1 12%     -19.7%     196.97 =C2=B1  6%  sched_debug.cfs=
_rq:/.load_avg.max
> >       2.27 =C2=B1 16%     +75.0%       3.97 =C2=B1  4%  sched_debug.cfs=
_rq:/.load_avg.min
> >      45.77 =C2=B1 16%     -17.8%      37.60 =C2=B1  6%  sched_debug.cfs=
_rq:/.load_avg.stddev
> >   11842707           +39.9%   16567992        sched_debug.cfs_rq:/.min_=
vruntime.avg
> >   13773080 =C2=B1  3%    +113.9%   29460281 =C2=B1  7%  sched_debug.cfs=
_rq:/.min_vruntime.max
> >   11423218           +30.3%   14885830        sched_debug.cfs_rq:/.min_=
vruntime.min
> >     301190 =C2=B1 12%    +439.9%    1626088 =C2=B1 10%  sched_debug.cfs=
_rq:/.min_vruntime.stddev
> >     203.83           -16.3%     170.67        sched_debug.cfs_rq:/.remo=
ved.load_avg.max
> >      14330 =C2=B1  3%     +30.9%      18756 =C2=B1  5%  sched_debug.cfs=
_rq:/.runnable_avg.avg
> >      25115 =C2=B1  4%     +15.5%      28999 =C2=B1  6%  sched_debug.cfs=
_rq:/.runnable_avg.max
> >       3811 =C2=B1 11%     +68.0%       6404 =C2=B1 21%  sched_debug.cfs=
_rq:/.runnable_avg.min
> >       3818 =C2=B1  6%     +15.3%       4404 =C2=B1  7%  sched_debug.cfs=
_rq:/.runnable_avg.stddev
> >    -849635          +410.6%   -4338612        sched_debug.cfs_rq:/.spre=
ad0.avg
> >    1092373 =C2=B1 54%    +691.1%    8641673 =C2=B1 21%  sched_debug.cfs=
_rq:/.spread0.max
> >   -1263082          +378.1%   -6038905        sched_debug.cfs_rq:/.spre=
ad0.min
> >     300764 =C2=B1 12%    +441.8%    1629507 =C2=B1  9%  sched_debug.cfs=
_rq:/.spread0.stddev
> >       1591 =C2=B1  4%     -11.1%       1413 =C2=B1  3%  sched_debug.cfs=
_rq:/.util_avg.max
> >     288.90 =C2=B1 11%     +64.5%     475.23 =C2=B1 13%  sched_debug.cfs=
_rq:/.util_avg.min
> >     240.33 =C2=B1  2%     -32.1%     163.09 =C2=B1  3%  sched_debug.cfs=
_rq:/.util_avg.stddev
> >     494.27 =C2=B1  3%     +41.6%     699.85 =C2=B1  3%  sched_debug.cfs=
_rq:/.util_est_enqueued.avg
> >      11.23 =C2=B1 54%    +634.1%      82.47 =C2=B1 22%  sched_debug.cfs=
_rq:/.util_est_enqueued.min
> >     174576           +20.7%     210681        sched_debug.cpu.clock.avg
> >     174926           +21.2%     211944        sched_debug.cpu.clock.max
> >     174164           +20.3%     209436        sched_debug.cpu.clock.min
> >     230.84 =C2=B1 33%    +226.1%     752.67 =C2=B1 20%  sched_debug.cpu=
.clock.stddev
> >     172836           +20.6%     208504        sched_debug.cpu.clock_tas=
k.avg
> >     173552           +21.0%     210079        sched_debug.cpu.clock_tas=
k.max
> >     156807           +22.3%     191789        sched_debug.cpu.clock_tas=
k.min
> >       1634           +17.1%       1914 =C2=B1  5%  sched_debug.cpu.cloc=
k_task.stddev
> >       0.00 =C2=B1 32%    +220.1%       0.00 =C2=B1 20%  sched_debug.cpu=
.next_balance.stddev
> >      14.12 =C2=B1  2%     +28.7%      18.18 =C2=B1  5%  sched_debug.cpu=
.nr_running.avg
> >       0.73 =C2=B1 25%    +213.6%       2.30 =C2=B1 24%  sched_debug.cpu=
.nr_running.min
> >    1810086          +461.3%   10159215 =C2=B1 10%  sched_debug.cpu.nr_s=
witches.avg
> >    2315994 =C2=B1  3%    +515.6%   14258195 =C2=B1  9%  sched_debug.cpu=
.nr_switches.max
> >    1529863          +380.3%    7348324 =C2=B1  9%  sched_debug.cpu.nr_s=
witches.min
> >     167487 =C2=B1 18%    +770.8%    1458519 =C2=B1 21%  sched_debug.cpu=
.nr_switches.stddev
> >     174149           +20.2%     209410        sched_debug.cpu_clk
> >     170980           +20.6%     206240        sched_debug.ktime
> >     174896           +20.2%     210153        sched_debug.sched_clk
> >       7.35           +24.9%       9.18 =C2=B1  4%  perf-stat.i.MPKI
> >  1.918e+10           +14.4%  2.194e+10        perf-stat.i.branch-instru=
ctions
> >       2.16            -0.1        2.09        perf-stat.i.branch-miss-r=
ate%
> >  4.133e+08            +6.6%  4.405e+08        perf-stat.i.branch-misses
> >      23.08            -9.2       13.86 =C2=B1  7%  perf-stat.i.cache-mi=
ss-rate%
> >  1.714e+08           -37.2%  1.076e+08 =C2=B1  3%  perf-stat.i.cache-mi=
sses
> >  7.497e+08           +33.7%  1.002e+09 =C2=B1  5%  perf-stat.i.cache-re=
ferences
> >    1636365          +382.4%    7893858 =C2=B1  5%  perf-stat.i.context-=
switches
> >       2.74            -6.8%       2.56        perf-stat.i.cpi
> >     131725          +288.0%     511159 =C2=B1 10%  perf-stat.i.cpu-migr=
ations
> >       1672          +160.8%       4361 =C2=B1  4%  perf-stat.i.cycles-b=
etween-cache-misses
> >       0.49            +0.6        1.11 =C2=B1  5%  perf-stat.i.dTLB-loa=
d-miss-rate%
> >  1.417e+08          +158.7%  3.665e+08 =C2=B1  5%  perf-stat.i.dTLB-loa=
d-misses
> >  2.908e+10            +9.1%  3.172e+10        perf-stat.i.dTLB-loads
> >       0.12 =C2=B1  4%      +0.1        0.20 =C2=B1  4%  perf-stat.i.dTL=
B-store-miss-rate%
> >   20805655 =C2=B1  4%     +90.9%   39716345 =C2=B1  4%  perf-stat.i.dTL=
B-store-misses
> >  1.755e+10            +8.6%  1.907e+10        perf-stat.i.dTLB-stores
> >      29.04            +3.6       32.62 =C2=B1  2%  perf-stat.i.iTLB-loa=
d-miss-rate%
> >   56676082           +60.4%   90917582 =C2=B1  3%  perf-stat.i.iTLB-loa=
d-misses
> >  1.381e+08           +30.6%  1.804e+08        perf-stat.i.iTLB-loads
> >   1.03e+11           +10.5%  1.139e+11        perf-stat.i.instructions
> >       1840           -21.1%       1451 =C2=B1  4%  perf-stat.i.instruct=
ions-per-iTLB-miss
> >       0.37           +10.9%       0.41        perf-stat.i.ipc
> >       1084            -4.5%       1035 =C2=B1  2%  perf-stat.i.metric.K=
/sec
> >     640.69           +10.3%     706.44        perf-stat.i.metric.M/sec
> >       5249            -9.3%       4762 =C2=B1  3%  perf-stat.i.minor-fa=
ults
> >      23.57           +18.7       42.30 =C2=B1  8%  perf-stat.i.node-loa=
d-miss-rate%
> >   40174555           -45.0%   22109431 =C2=B1 10%  perf-stat.i.node-loa=
ds
> >       8.84 =C2=B1  2%     +24.5       33.30 =C2=B1 10%  perf-stat.i.nod=
e-store-miss-rate%
> >    2912322           +60.3%    4667137 =C2=B1 16%  perf-stat.i.node-sto=
re-misses
> >   34046752           -50.6%   16826621 =C2=B1  9%  perf-stat.i.node-sto=
res
> >       5278            -9.2%       4791 =C2=B1  3%  perf-stat.i.page-fau=
lts
> >       7.24           +12.1%       8.12 =C2=B1  4%  perf-stat.overall.MP=
KI
> >       2.15            -0.1        2.05        perf-stat.overall.branch-=
miss-rate%
> >      22.92            -9.5       13.41 =C2=B1  7%  perf-stat.overall.ca=
che-miss-rate%
> >       2.73            -6.3%       2.56        perf-stat.overall.cpi
> >       1644           +43.4%       2358 =C2=B1  3%  perf-stat.overall.cy=
cles-between-cache-misses
> >       0.48            +0.5        0.99 =C2=B1  4%  perf-stat.overall.dT=
LB-load-miss-rate%
> >       0.12 =C2=B1  4%      +0.1        0.19 =C2=B1  4%  perf-stat.overa=
ll.dTLB-store-miss-rate%
> >      29.06            +2.9       32.01 =C2=B1  2%  perf-stat.overall.iT=
LB-load-miss-rate%
> >       1826           -26.6%       1340 =C2=B1  4%  perf-stat.overall.in=
structions-per-iTLB-miss
> >       0.37            +6.8%       0.39        perf-stat.overall.ipc
> >      22.74            +6.8       29.53 =C2=B1 13%  perf-stat.overall.no=
de-load-miss-rate%
> >       7.63            +8.4       16.02 =C2=B1 20%  perf-stat.overall.no=
de-store-miss-rate%
> >  1.915e+10            +9.0%  2.088e+10        perf-stat.ps.branch-instr=
uctions
> >  4.119e+08            +3.9%  4.282e+08        perf-stat.ps.branch-misse=
s
> >  1.707e+08           -30.5%  1.186e+08 =C2=B1  3%  perf-stat.ps.cache-m=
isses
> >  7.446e+08           +19.2%  8.874e+08 =C2=B1  4%  perf-stat.ps.cache-r=
eferences
> >    1611874          +289.1%    6271376 =C2=B1  7%  perf-stat.ps.context=
-switches
> >     127362          +189.0%     368041 =C2=B1 11%  perf-stat.ps.cpu-mig=
rations
> >  1.407e+08          +116.2%  3.042e+08 =C2=B1  5%  perf-stat.ps.dTLB-lo=
ad-misses
> >  2.901e+10            +5.4%  3.057e+10        perf-stat.ps.dTLB-loads
> >   20667480 =C2=B1  4%     +66.8%   34473793 =C2=B1  4%  perf-stat.ps.dT=
LB-store-misses
> >  1.751e+10            +5.1%   1.84e+10        perf-stat.ps.dTLB-stores
> >   56310692           +45.0%   81644183 =C2=B1  4%  perf-stat.ps.iTLB-lo=
ad-misses
> >  1.375e+08           +26.1%  1.733e+08        perf-stat.ps.iTLB-loads
> >  1.028e+11            +6.3%  1.093e+11        perf-stat.ps.instructions
> >       4929           -24.5%       3723 =C2=B1  2%  perf-stat.ps.minor-f=
aults
> >   40134633           -32.9%   26946247 =C2=B1  9%  perf-stat.ps.node-lo=
ads
> >    2805073           +39.5%    3914304 =C2=B1 16%  perf-stat.ps.node-st=
ore-misses
> >   33938259           -38.9%   20726382 =C2=B1  8%  perf-stat.ps.node-st=
ores
> >       4952           -24.5%       3741 =C2=B1  2%  perf-stat.ps.page-fa=
ults
> >  2.911e+13           +30.9%  3.809e+13 =C2=B1  2%  perf-stat.total.inst=
ructions
> >      15.30 =C2=B1  4%      -8.6        6.66 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_sendmsg.soc=
k_write_iter.vfs_write
> >      13.84 =C2=B1  6%      -7.9        5.98 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sen=
dmsg.sock_sendmsg.sock_write_iter
> >      13.61 =C2=B1  6%      -7.8        5.84 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.uni=
x_stream_sendmsg.sock_sendmsg
> >       9.00 =C2=B1  2%      -5.5        3.48 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.=
sock_read_iter.vfs_read
> >       6.44 =C2=B1  4%      -4.3        2.14 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.skb_release_data.consume_skb.unix_stream_read_generic.uni=
x_stream_recvmsg.sock_read_iter
> >       5.83 =C2=B1  8%      -3.4        2.44 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.kmem_cache_alloc_node.__alloc_skb.alloc_skb_with_frags.so=
ck_alloc_send_pskb.unix_stream_sendmsg
> >       5.81 =C2=B1  6%      -3.3        2.48 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags.sock_all=
oc_send_pskb.unix_stream_sendmsg
> >       5.50 =C2=B1  7%      -3.2        2.32 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.__kmalloc_node_track_caller.kmalloc_reserve.__alloc_skb.a=
lloc_skb_with_frags.sock_alloc_send_pskb
> >       5.07 =C2=B1  8%      -3.0        2.04 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc_node_track_caller.kmall=
oc_reserve.__alloc_skb.alloc_skb_with_frags
> >       6.22 =C2=B1  2%      -2.9        3.33 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stre=
am_recvmsg.sock_read_iter.vfs_read
> >       6.17 =C2=B1  2%      -2.9        3.30 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream=
_read_generic.unix_stream_recvmsg.sock_read_iter
> >       6.11 =C2=B1  2%      -2.9        3.24 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_re=
ad_actor.unix_stream_read_generic.unix_stream_recvmsg
> >      50.99            -2.6       48.39        perf-profile.calltrace.cy=
cles-pp.__libc_read
> >       5.66 =C2=B1  3%      -2.3        3.35 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.syscall_return_via_sysret.__libc_read
> >       5.52 =C2=B1  3%      -2.3        3.27 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.syscall_return_via_sysret.__libc_write
> >       3.14 =C2=B1  2%      -1.7        1.42 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.=
unix_stream_read_actor.unix_stream_read_generic
> >       2.73 =C2=B1  2%      -1.6        1.15 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagr=
am_iter.unix_stream_read_actor
> >       2.59 =C2=B1  2%      -1.5        1.07 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__sk=
b_datagram_iter.skb_copy_datagram_iter
> >       2.72 =C2=B1  3%      -1.4        1.34 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.kmem_cache_free.unix_stream_read_generic.unix_stream_recv=
msg.sock_read_iter.vfs_read
> >      41.50            -1.2       40.27        perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64_after_hwframe.__libc_read
> >       2.26 =C2=B1  4%      -1.1        1.12        perf-profile.calltra=
ce.cycles-pp.skb_release_head_state.consume_skb.unix_stream_read_generic.un=
ix_stream_recvmsg.sock_read_iter
> >       2.76 =C2=B1  3%      -1.1        1.63 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_it=
er.skb_copy_datagram_iter.unix_stream_read_actor
> >       2.84 =C2=B1  3%      -1.1        1.71 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram=
_iter.unix_stream_read_actor.unix_stream_read_generic
> >       2.20 =C2=B1  4%      -1.1        1.08        perf-profile.calltra=
ce.cycles-pp.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stre=
am_read_generic.unix_stream_recvmsg
> >       2.98 =C2=B1  2%      -1.1        1.90 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_send=
msg.sock_write_iter.vfs_write
> >       1.99 =C2=B1  4%      -1.1        0.92 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.consu=
me_skb.unix_stream_read_generic
> >       2.10 =C2=B1  3%      -1.0        1.08 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter=
.__skb_datagram_iter.skb_copy_datagram_iter
> >       2.08 =C2=B1  4%      -0.8        1.24 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.__entry_text_start.__libc_write
> >       2.16 =C2=B1  3%      -0.7        1.47        perf-profile.calltra=
ce.cycles-pp.__entry_text_start.__libc_read
> >       2.20 =C2=B1  2%      -0.7        1.52 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.__kmem_cache_free.skb_release_data.consume_skb.unix_strea=
m_read_generic.unix_stream_recvmsg
> >       1.46 =C2=B1  3%      -0.6        0.87 =C2=B1  8%  perf-profile.ca=
lltrace.cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_s=
endmsg.sock_sendmsg.sock_write_iter
> >       4.82 =C2=B1  2%      -0.6        4.24        perf-profile.calltra=
ce.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after=
_hwframe.__libc_read
> >       1.31 =C2=B1  2%      -0.4        0.90 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.__check_object_size.skb_copy_datagram_from_iter.unix_stre=
am_sendmsg.sock_sendmsg.sock_write_iter
> >       0.96 =C2=B1  3%      -0.4        0.57 =C2=B1 10%  perf-profile.ca=
lltrace.cycles-pp.copyin._copy_from_iter.skb_copy_datagram_from_iter.unix_s=
tream_sendmsg.sock_sendmsg
> >       1.14 =C2=B1  3%      -0.4        0.76 =C2=B1  5%  perf-profile.ca=
lltrace.cycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc_node.__alloc_=
skb.alloc_skb_with_frags.sock_alloc_send_pskb
> >       0.99 =C2=B1  3%      -0.3        0.65 =C2=B1  8%  perf-profile.ca=
lltrace.cycles-pp.memcg_slab_post_alloc_hook.__kmem_cache_alloc_node.__kmal=
loc_node_track_caller.kmalloc_reserve.__alloc_skb
> >       1.30 =C2=B1  4%      -0.3        0.99 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.sock_recvmsg.sock_read_iter.vfs_read.ksys_read.do_syscall=
_64
> >       0.98 =C2=B1  2%      -0.3        0.69 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_=
64.entry_SYSCALL_64_after_hwframe
> >       0.67            -0.2        0.42 =C2=B1 50%  perf-profile.calltra=
ce.cycles-pp.check_heap_object.__check_object_size.skb_copy_datagram_from_i=
ter.unix_stream_sendmsg.sock_sendmsg
> >       0.56 =C2=B1  4%      -0.2        0.32 =C2=B1 81%  perf-profile.ca=
lltrace.cycles-pp.__fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe.__libc_read
> >       0.86 =C2=B1  2%      -0.2        0.63 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_wri=
te.ksys_write.do_syscall_64
> >       1.15 =C2=B1  4%      -0.2        0.93 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.security_socket_recvmsg.sock_recvmsg.sock_read_iter.vfs_r=
ead.ksys_read
> >       0.90            -0.2        0.69 =C2=B1  3%  perf-profile.calltra=
ce.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc_node.__alloc_skb.=
alloc_skb_with_frags.sock_alloc_send_pskb
> >       1.23 =C2=B1  3%      -0.2        1.07 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.security_socket_sendmsg.sock_sendmsg.sock_write_iter.vfs_=
write.ksys_write
> >       1.05 =C2=B1  2%      -0.2        0.88 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64=
.entry_SYSCALL_64_after_hwframe
> >       0.84 =C2=B1  4%      -0.2        0.68 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read=
_iter.vfs_read
> >       0.88            -0.1        0.78 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.apparmor_file_permission.security_file_permission.vfs_read.ksy=
s_read.do_syscall_64
> >       0.94 =C2=B1  3%      -0.1        0.88 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.aa_sk_perm.security_socket_sendmsg.sock_sendmsg.sock_writ=
e_iter.vfs_write
> >       0.62 =C2=B1  2%      +0.3        0.90 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.mutex_lock.unix_stream_read_generic.unix_stream_recvmsg.s=
ock_read_iter.vfs_read
> >       0.00            +0.6        0.58 =C2=B1  3%  perf-profile.calltra=
ce.cycles-pp._raw_spin_lock_irqsave.prepare_to_wait.unix_stream_data_wait.u=
nix_stream_read_generic.unix_stream_recvmsg
> >       0.00            +0.6        0.61 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.update_load_avg.enqueue_task_fair.ttwu_do_activate.try_to_wake=
_up.autoremove_wake_function
> >       0.00            +0.6        0.62 =C2=B1  4%  perf-profile.calltra=
ce.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.exit_t=
o_user_mode_loop
> >       0.00            +0.7        0.67 =C2=B1 11%  perf-profile.calltra=
ce.cycles-pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.sc=
hedule
> >       0.00            +0.7        0.67 =C2=B1  7%  perf-profile.calltra=
ce.cycles-pp.__switch_to_asm.__libc_write
> >       0.00            +0.8        0.76 =C2=B1  4%  perf-profile.calltra=
ce.cycles-pp.reweight_entity.dequeue_task_fair.__schedule.schedule.schedule=
_timeout
> >       0.00            +0.8        0.77 =C2=B1  4%  perf-profile.calltra=
ce.cycles-pp.___perf_sw_event.prepare_task_switch.__schedule.schedule.sched=
ule_timeout
> >       0.00            +0.8        0.77 =C2=B1  8%  perf-profile.calltra=
ce.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.exit_t=
o_user_mode_loop
> >       0.00            +0.8        0.81 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.prepare_task_switch.__schedule.schedule.exit_to_user_mode_loop=
.exit_to_user_mode_prepare
> >       0.00            +0.8        0.81 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.check_preempt_wakeup.check_preempt_curr.ttwu_do_activate.try_t=
o_wake_up.autoremove_wake_function
> >       0.00            +0.8        0.82 =C2=B1  2%  perf-profile.calltra=
ce.cycles-pp.__switch_to_asm.__libc_read
> >       0.00            +0.8        0.82 =C2=B1  3%  perf-profile.calltra=
ce.cycles-pp.reweight_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake=
_up.autoremove_wake_function
> >       0.00            +0.9        0.86 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.perf_trace_sched_wakeup_template.try_to_wake_up.autoremove_wak=
e_function.__wake_up_common.__wake_up_common_lock
> >       0.00            +0.9        0.87 =C2=B1  8%  perf-profile.calltra=
ce.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.ttwu_do_activ=
ate.try_to_wake_up
> >      29.66            +0.9       30.58        perf-profile.calltrace.cy=
cles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe._=
_libc_write
> >       0.00            +1.0        0.95 =C2=B1  3%  perf-profile.calltra=
ce.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.schedu=
le_timeout
> >       0.00            +1.0        0.98 =C2=B1  4%  perf-profile.calltra=
ce.cycles-pp.check_preempt_curr.ttwu_do_activate.try_to_wake_up.autoremove_=
wake_function.__wake_up_common
> >       0.00            +1.0        0.99 =C2=B1  3%  perf-profile.calltra=
ce.cycles-pp.update_curr.enqueue_entity.enqueue_task_fair.ttwu_do_activate.=
try_to_wake_up
> >       0.00            +1.0        1.05 =C2=B1  4%  perf-profile.calltra=
ce.cycles-pp.prepare_to_wait.unix_stream_data_wait.unix_stream_read_generic=
.unix_stream_recvmsg.sock_read_iter
> >       0.00            +1.1        1.07 =C2=B1 12%  perf-profile.calltra=
ce.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_=
wake_up.autoremove_wake_function
> >      27.81 =C2=B1  2%      +1.2       28.98        perf-profile.calltra=
ce.cycles-pp.unix_stream_recvmsg.sock_read_iter.vfs_read.ksys_read.do_sysca=
ll_64
> >      27.36 =C2=B1  2%      +1.2       28.59        perf-profile.calltra=
ce.cycles-pp.unix_stream_read_generic.unix_stream_recvmsg.sock_read_iter.vf=
s_read.ksys_read
> >       0.00            +1.5        1.46 =C2=B1  2%  perf-profile.calltra=
ce.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up=
.autoremove_wake_function.__wake_up_common
> >       0.00            +1.6        1.55 =C2=B1  4%  perf-profile.calltra=
ce.cycles-pp.prepare_task_switch.__schedule.schedule.schedule_timeout.unix_=
stream_data_wait
> >       0.00            +1.6        1.60 =C2=B1  4%  perf-profile.calltra=
ce.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall=
_64.entry_SYSCALL_64_after_hwframe.__libc_read
> >      27.58            +1.6       29.19        perf-profile.calltrace.cy=
cles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64=
_after_hwframe
> >       0.00            +1.6        1.63 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedu=
le
> >       0.00            +1.6        1.65 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.exit_to_user_mod=
e_prepare.syscall_exit_to_user_mode.do_syscall_64
> >       0.00            +1.7        1.66 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.switch_mm_irqs_off.__schedule.schedule.exit_to_user_mode_loop.=
exit_to_user_mode_prepare
> >       0.00            +1.8        1.80        perf-profile.calltrace.cy=
cles-pp._raw_spin_lock.try_to_wake_up.autoremove_wake_function.__wake_up_co=
mmon.__wake_up_common_lock
> >       0.00            +1.8        1.84 =C2=B1  2%  perf-profile.calltra=
ce.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.unix_=
stream_data_wait
> >       0.00            +2.0        1.97 =C2=B1  2%  perf-profile.calltra=
ce.cycles-pp.switch_mm_irqs_off.__schedule.schedule.schedule_timeout.unix_s=
tream_data_wait
> >      26.63 =C2=B1  2%      +2.0       28.61        perf-profile.calltra=
ce.cycles-pp.sock_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_6=
4
> >       0.00            +2.0        2.01 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop=
.exit_to_user_mode_prepare
> >       0.00            +2.1        2.09 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_w=
ake_function.__wake_up_common
> >       0.00            +2.1        2.11 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.switch_fpu_return.exit_to_user_mode_prepare.syscall_exit_to_us=
er_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >      25.21 =C2=B1  2%      +2.2       27.43        perf-profile.calltra=
ce.cycles-pp.unix_stream_sendmsg.sock_sendmsg.sock_write_iter.vfs_write.ksy=
s_write
> >       0.00            +2.4        2.43 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_=
up_common.__wake_up_common_lock
> >      48.00            +2.7       50.69        perf-profile.calltrace.cy=
cles-pp.__libc_write
> >       0.00            +2.9        2.87 =C2=B1  5%  perf-profile.calltra=
ce.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_=
timeout
> >       0.09 =C2=B1223%      +3.4        3.47 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_=
wake_up.autoremove_wake_function
> >      39.07            +4.8       43.84        perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
> >       0.66 =C2=B1 18%      +5.0        5.62 =C2=B1  4%  perf-profile.ca=
lltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.un=
ix_stream_data_wait
> >       4.73            +5.1        9.88 =C2=B1  3%  perf-profile.calltra=
ce.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after=
_hwframe.__libc_write
> >       0.66 =C2=B1 20%      +5.3        5.98 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autorem=
ove_wake_function.__wake_up_common
> >      35.96            +5.7       41.68        perf-profile.calltrace.cy=
cles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
> >       0.00            +6.0        6.02 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_p=
repare.syscall_exit_to_user_mode
> >       0.00            +6.2        6.18 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.sysc=
all_exit_to_user_mode.do_syscall_64
> >       0.00            +6.4        6.36 =C2=B1  6%  perf-profile.calltra=
ce.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_=
to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.78 =C2=B1 19%      +6.4        7.15 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.=
__wake_up_common.__wake_up_common_lock
> >       0.18 =C2=B1141%      +7.0        7.18 =C2=B1  6%  perf-profile.ca=
lltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_sy=
scall_64.entry_SYSCALL_64_after_hwframe.__libc_write
> >       1.89 =C2=B1 15%     +12.1       13.96 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_data_wai=
t.unix_stream_read_generic
> >       1.92 =C2=B1 15%     +12.3       14.23 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.schedule.schedule_timeout.unix_stream_data_wait.unix_stre=
am_read_generic.unix_stream_recvmsg
> >       1.66 =C2=B1 19%     +12.4       14.06 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.=
__wake_up_common_lock.sock_def_readable
> >       1.96 =C2=B1 15%     +12.5       14.48 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.schedule_timeout.unix_stream_data_wait.unix_stream_read_g=
eneric.unix_stream_recvmsg.sock_read_iter
> >       1.69 =C2=B1 19%     +12.7       14.38 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_commo=
n_lock.sock_def_readable.unix_stream_sendmsg
> >       1.75 =C2=B1 19%     +13.0       14.75 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.=
unix_stream_sendmsg.sock_sendmsg
> >       2.53 =C2=B1 10%     +13.4       15.90 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_sendmsg.sock_w=
rite_iter.vfs_write
> >       1.96 =C2=B1 16%     +13.5       15.42 =C2=B1  2%  perf-profile.ca=
lltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.unix_stream_sendm=
sg.sock_sendmsg.sock_write_iter
> >       2.28 =C2=B1 15%     +14.6       16.86 =C2=B1  3%  perf-profile.ca=
lltrace.cycles-pp.unix_stream_data_wait.unix_stream_read_generic.unix_strea=
m_recvmsg.sock_read_iter.vfs_read
> >      15.31 =C2=B1  4%      -8.6        6.67 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.sock_alloc_send_pskb
> >      13.85 =C2=B1  6%      -7.9        5.98 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.alloc_skb_with_frags
> >      13.70 =C2=B1  6%      -7.8        5.89 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.__alloc_skb
> >       9.01 =C2=B1  2%      -5.5        3.48 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.consume_skb
> >       6.86 =C2=B1 26%      -4.7        2.15 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp._raw_spin_lock_irqsave
> >      11.27 =C2=B1  3%      -4.6        6.67 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.syscall_return_via_sysret
> >       6.46 =C2=B1  4%      -4.3        2.15 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.skb_release_data
> >       4.18 =C2=B1 25%      -4.0        0.15 =C2=B1 69%  perf-profile.ch=
ildren.cycles-pp.___slab_alloc
> >       5.76 =C2=B1 32%      -3.9        1.91 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.native_queued_spin_lock_slowpath
> >       5.98 =C2=B1  8%      -3.5        2.52 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.kmem_cache_alloc_node
> >       5.84 =C2=B1  6%      -3.3        2.50 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.kmalloc_reserve
> >       3.33 =C2=B1 30%      -3.3        0.05 =C2=B1 88%  perf-profile.ch=
ildren.cycles-pp.get_partial_node
> >       5.63 =C2=B1  7%      -3.3        2.37 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.__kmalloc_node_track_caller
> >       5.20 =C2=B1  7%      -3.1        2.12 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.__kmem_cache_alloc_node
> >       6.23 =C2=B1  2%      -2.9        3.33 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.unix_stream_read_actor
> >       6.18 =C2=B1  2%      -2.9        3.31 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.skb_copy_datagram_iter
> >       6.11 =C2=B1  2%      -2.9        3.25 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.__skb_datagram_iter
> >      51.39            -2.5       48.85        perf-profile.children.cyc=
les-pp.__libc_read
> >       3.14 =C2=B1  3%      -2.5        0.61 =C2=B1 13%  perf-profile.ch=
ildren.cycles-pp.__slab_free
> >       5.34 =C2=B1  3%      -2.1        3.23 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.__entry_text_start
> >       3.57 =C2=B1  2%      -1.9        1.66 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.copy_user_enhanced_fast_string
> >       3.16 =C2=B1  2%      -1.7        1.43 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp._copy_to_iter
> >       2.74 =C2=B1  2%      -1.6        1.16 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.copyout
> >       4.16 =C2=B1  2%      -1.5        2.62 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.__check_object_size
> >       2.73 =C2=B1  3%      -1.4        1.35 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.kmem_cache_free
> >       2.82 =C2=B1  2%      -1.2        1.63 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.check_heap_object
> >       2.27 =C2=B1  4%      -1.1        1.13 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.skb_release_head_state
> >       2.85 =C2=B1  3%      -1.1        1.72 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.simple_copy_to_iter
> >       2.22 =C2=B1  4%      -1.1        1.10        perf-profile.childre=
n.cycles-pp.unix_destruct_scm
> >       3.00 =C2=B1  2%      -1.1        1.91 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.skb_copy_datagram_from_iter
> >       2.00 =C2=B1  4%      -1.1        0.92 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.sock_wfree
> >       2.16 =C2=B1  3%      -0.7        1.43 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.memcg_slab_post_alloc_hook
> >       1.45 =C2=B1  3%      -0.7        0.73 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.entry_SYSCALL_64_safe_stack
> >       2.21 =C2=B1  2%      -0.7        1.52 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.__kmem_cache_free
> >       1.49 =C2=B1  3%      -0.6        0.89 =C2=B1  8%  perf-profile.ch=
ildren.cycles-pp._copy_from_iter
> >       1.40 =C2=B1  3%      -0.6        0.85 =C2=B1 13%  perf-profile.ch=
ildren.cycles-pp.mod_objcg_state
> >       0.74            -0.5        0.24 =C2=B1 16%  perf-profile.childre=
n.cycles-pp.__build_skb_around
> >       1.48            -0.5        1.01 =C2=B1  2%  perf-profile.childre=
n.cycles-pp.get_obj_cgroup_from_current
> >       2.05 =C2=B1  2%      -0.5        1.59 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.security_file_permission
> >       0.98 =C2=B1  2%      -0.4        0.59 =C2=B1 10%  perf-profile.ch=
ildren.cycles-pp.copyin
> >       1.08 =C2=B1  3%      -0.4        0.72 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.__might_resched
> >       1.75            -0.3        1.42 =C2=B1  4%  perf-profile.childre=
n.cycles-pp.apparmor_file_permission
> >       1.32 =C2=B1  4%      -0.3        1.00 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.sock_recvmsg
> >       0.54 =C2=B1  4%      -0.3        0.25 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.skb_unlink
> >       0.54 =C2=B1  6%      -0.3        0.26 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.unix_write_space
> >       0.66 =C2=B1  3%      -0.3        0.39 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.obj_cgroup_charge
> >       0.68 =C2=B1  2%      -0.3        0.41 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       0.86 =C2=B1  4%      -0.3        0.59 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.__check_heap_object
> >       0.75 =C2=B1  9%      -0.3        0.48 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.skb_set_owner_w
> >       1.84 =C2=B1  3%      -0.3        1.58 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.aa_sk_perm
> >       0.68 =C2=B1 11%      -0.2        0.44 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.skb_queue_tail
> >       1.22 =C2=B1  4%      -0.2        0.99 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.__fdget_pos
> >       0.70 =C2=B1  2%      -0.2        0.48 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.__get_obj_cgroup_from_memcg
> >       1.16 =C2=B1  4%      -0.2        0.93 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.security_socket_recvmsg
> >       0.48 =C2=B1  3%      -0.2        0.29 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.__might_fault
> >       0.24 =C2=B1  7%      -0.2        0.05 =C2=B1 56%  perf-profile.ch=
ildren.cycles-pp.fsnotify_perm
> >       1.12 =C2=B1  4%      -0.2        0.93 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.__fget_light
> >       1.24 =C2=B1  3%      -0.2        1.07 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.security_socket_sendmsg
> >       0.61 =C2=B1  3%      -0.2        0.45 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.__might_sleep
> >       0.33 =C2=B1  5%      -0.2        0.17 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.refill_obj_stock
> >       0.40 =C2=B1  2%      -0.1        0.25 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.kmalloc_slab
> >       0.57 =C2=B1  2%      -0.1        0.45        perf-profile.childre=
n.cycles-pp.asm_sysvec_apic_timer_interrupt
> >       0.54 =C2=B1  3%      -0.1        0.42 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.wait_for_unix_gc
> >       0.42 =C2=B1  2%      -0.1        0.30 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.is_vmalloc_addr
> >       1.00 =C2=B1  2%      -0.1        0.87 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.__virt_addr_valid
> >       0.52 =C2=B1  2%      -0.1        0.41        perf-profile.childre=
n.cycles-pp.sysvec_apic_timer_interrupt
> >       0.33 =C2=B1  3%      -0.1        0.21 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.tick_sched_handle
> >       0.36 =C2=B1  2%      -0.1        0.25 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.tick_sched_timer
> >       0.47 =C2=B1  2%      -0.1        0.36 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.hrtimer_interrupt
> >       0.48 =C2=B1  2%      -0.1        0.36 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.__sysvec_apic_timer_interrupt
> >       0.32 =C2=B1  3%      -0.1        0.21 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.update_process_times
> >       0.42 =C2=B1  3%      -0.1        0.31 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.__hrtimer_run_queues
> >       0.26 =C2=B1  6%      -0.1        0.16 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.kmalloc_size_roundup
> >       0.20 =C2=B1  4%      -0.1        0.10 =C2=B1  9%  perf-profile.ch=
ildren.cycles-pp.task_tick_fair
> >       0.24 =C2=B1  3%      -0.1        0.15 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.scheduler_tick
> >       0.30 =C2=B1  5%      -0.1        0.21 =C2=B1  8%  perf-profile.ch=
ildren.cycles-pp.obj_cgroup_uncharge_pages
> >       0.20 =C2=B1  2%      -0.1        0.11 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.should_failslab
> >       0.51 =C2=B1  2%      -0.1        0.43 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.syscall_enter_from_user_mode
> >       0.15 =C2=B1  8%      -0.1        0.07 =C2=B1 13%  perf-profile.ch=
ildren.cycles-pp.syscall_exit_to_user_mode_prepare
> >       0.19 =C2=B1  4%      -0.1        0.12 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.apparmor_socket_sendmsg
> >       0.20 =C2=B1  4%      -0.1        0.13 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.aa_file_perm
> >       0.18 =C2=B1  5%      -0.1        0.12 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.apparmor_socket_recvmsg
> >       0.14 =C2=B1 13%      -0.1        0.08 =C2=B1 55%  perf-profile.ch=
ildren.cycles-pp.__mod_memcg_lruvec_state
> >       0.24 =C2=B1  4%      -0.1        0.18 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.rcu_all_qs
> >       0.18 =C2=B1 10%      -0.1        0.12 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.memcg_account_kmem
> >       0.37 =C2=B1  3%      -0.1        0.31 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.security_socket_getpeersec_dgram
> >       0.08            -0.0        0.06 =C2=B1  8%  perf-profile.childre=
n.cycles-pp.put_pid
> >       0.18 =C2=B1  3%      -0.0        0.16 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.apparmor_socket_getpeersec_dgram
> >       0.21 =C2=B1  3%      +0.0        0.23 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.__get_task_ioprio
> >       0.00            +0.1        0.05        perf-profile.children.cyc=
les-pp.perf_exclude_event
> >       0.00            +0.1        0.06 =C2=B1  7%  perf-profile.childre=
n.cycles-pp.invalidate_user_asid
> >       0.00            +0.1        0.07 =C2=B1  6%  perf-profile.childre=
n.cycles-pp.__bitmap_and
> >       0.05            +0.1        0.13 =C2=B1  8%  perf-profile.childre=
n.cycles-pp.irqentry_exit_to_user_mode
> >       0.00            +0.1        0.08 =C2=B1  7%  perf-profile.childre=
n.cycles-pp.schedule_debug
> >       0.00            +0.1        0.08 =C2=B1 13%  perf-profile.childre=
n.cycles-pp.read@plt
> >       0.00            +0.1        0.08 =C2=B1  5%  perf-profile.childre=
n.cycles-pp.sysvec_reschedule_ipi
> >       0.00            +0.1        0.10 =C2=B1  4%  perf-profile.childre=
n.cycles-pp.tracing_gen_ctx_irq_test
> >       0.00            +0.1        0.10 =C2=B1  4%  perf-profile.childre=
n.cycles-pp.place_entity
> >       0.00            +0.1        0.12 =C2=B1 10%  perf-profile.childre=
n.cycles-pp.native_irq_return_iret
> >       0.07 =C2=B1 14%      +0.1        0.19 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.__list_add_valid
> >       0.00            +0.1        0.13 =C2=B1  6%  perf-profile.childre=
n.cycles-pp.perf_trace_buf_alloc
> >       0.00            +0.1        0.13 =C2=B1 34%  perf-profile.childre=
n.cycles-pp._find_next_and_bit
> >       0.00            +0.1        0.14 =C2=B1  5%  perf-profile.childre=
n.cycles-pp.switch_ldt
> >       0.00            +0.1        0.15 =C2=B1  5%  perf-profile.childre=
n.cycles-pp.check_cfs_rq_runtime
> >       0.00            +0.1        0.15 =C2=B1 30%  perf-profile.childre=
n.cycles-pp.migrate_task_rq_fair
> >       0.00            +0.2        0.15 =C2=B1  5%  perf-profile.childre=
n.cycles-pp.__rdgsbase_inactive
> >       0.00            +0.2        0.16 =C2=B1  3%  perf-profile.childre=
n.cycles-pp.save_fpregs_to_fpstate
> >       0.00            +0.2        0.16 =C2=B1  6%  perf-profile.childre=
n.cycles-pp.ttwu_queue_wakelist
> >       0.00            +0.2        0.17        perf-profile.children.cyc=
les-pp.perf_trace_buf_update
> >       0.00            +0.2        0.18 =C2=B1  2%  perf-profile.childre=
n.cycles-pp.rb_insert_color
> >       0.00            +0.2        0.18 =C2=B1  4%  perf-profile.childre=
n.cycles-pp.rb_next
> >       0.00            +0.2        0.18 =C2=B1 21%  perf-profile.childre=
n.cycles-pp.__cgroup_account_cputime
> >       0.01 =C2=B1223%      +0.2        0.21 =C2=B1 28%  perf-profile.ch=
ildren.cycles-pp.perf_trace_sched_switch
> >       0.00            +0.2        0.20 =C2=B1  3%  perf-profile.childre=
n.cycles-pp.select_idle_cpu
> >       0.00            +0.2        0.20 =C2=B1  3%  perf-profile.childre=
n.cycles-pp.rcu_note_context_switch
> >       0.00            +0.2        0.21 =C2=B1 26%  perf-profile.childre=
n.cycles-pp.set_task_cpu
> >       0.00            +0.2        0.22 =C2=B1  8%  perf-profile.childre=
n.cycles-pp.resched_curr
> >       0.08 =C2=B1  5%      +0.2        0.31 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.task_h_load
> >       0.00            +0.2        0.24 =C2=B1  3%  perf-profile.childre=
n.cycles-pp.finish_wait
> >       0.04 =C2=B1 44%      +0.3        0.29 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.rb_erase
> >       0.19 =C2=B1  6%      +0.3        0.46        perf-profile.childre=
n.cycles-pp._raw_spin_unlock_irqrestore
> >       0.20 =C2=B1  6%      +0.3        0.47 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.__list_del_entry_valid
> >       0.00            +0.3        0.28 =C2=B1  3%  perf-profile.childre=
n.cycles-pp.__wrgsbase_inactive
> >       0.02 =C2=B1141%      +0.3        0.30 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.native_sched_clock
> >       0.06 =C2=B1 13%      +0.3        0.34 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.sched_clock_cpu
> >       0.64 =C2=B1  2%      +0.3        0.93        perf-profile.childre=
n.cycles-pp.mutex_lock
> >       0.00            +0.3        0.30 =C2=B1  5%  perf-profile.childre=
n.cycles-pp.cr4_update_irqsoff
> >       0.00            +0.3        0.30 =C2=B1  4%  perf-profile.childre=
n.cycles-pp.clear_buddies
> >       0.07 =C2=B1 55%      +0.3        0.37 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.perf_trace_sched_stat_runtime
> >       0.10 =C2=B1 66%      +0.3        0.42 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.perf_tp_event
> >       0.02 =C2=B1142%      +0.3        0.36 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.cpuacct_charge
> >       0.12 =C2=B1  9%      +0.4        0.47 =C2=B1 11%  perf-profile.ch=
ildren.cycles-pp.wake_affine
> >       0.00            +0.4        0.36 =C2=B1 13%  perf-profile.childre=
n.cycles-pp.available_idle_cpu
> >       0.05 =C2=B1 48%      +0.4        0.42 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.finish_task_switch
> >       0.12 =C2=B1  4%      +0.4        0.49 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.asm_sysvec_reschedule_ipi
> >       0.07 =C2=B1 17%      +0.4        0.48        perf-profile.childre=
n.cycles-pp.__calc_delta
> >       0.03 =C2=B1100%      +0.5        0.49 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.pick_next_entity
> >       0.00            +0.5        0.48 =C2=B1  8%  perf-profile.childre=
n.cycles-pp.set_next_buddy
> >       0.08 =C2=B1 14%      +0.6        0.66 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.update_min_vruntime
> >       0.07 =C2=B1 17%      +0.6        0.68 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.os_xsave
> >       0.29 =C2=B1  7%      +0.7        0.99 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.update_cfs_group
> >       0.17 =C2=B1 17%      +0.7        0.87 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.perf_trace_sched_wakeup_template
> >       0.14 =C2=B1  7%      +0.7        0.87 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.__update_load_avg_se
> >       0.14 =C2=B1 16%      +0.8        0.90 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.update_rq_clock
> >       0.08 =C2=B1 17%      +0.8        0.84 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.check_preempt_wakeup
> >       0.12 =C2=B1 14%      +0.8        0.95 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.__update_load_avg_cfs_rq
> >       0.22 =C2=B1  5%      +0.8        1.07 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.prepare_to_wait
> >       0.10 =C2=B1 18%      +0.9        0.98 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.check_preempt_curr
> >      29.72            +0.9       30.61        perf-profile.children.cyc=
les-pp.vfs_write
> >       0.14 =C2=B1 11%      +0.9        1.03 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.__switch_to
> >       0.07 =C2=B1 20%      +0.9        0.99 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.put_prev_entity
> >       0.12 =C2=B1 16%      +1.0        1.13 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.___perf_sw_event
> >       0.07 =C2=B1 17%      +1.0        1.10 =C2=B1 13%  perf-profile.ch=
ildren.cycles-pp.select_idle_sibling
> >      27.82 =C2=B1  2%      +1.2       28.99        perf-profile.childre=
n.cycles-pp.unix_stream_recvmsg
> >      27.41 =C2=B1  2%      +1.2       28.63        perf-profile.childre=
n.cycles-pp.unix_stream_read_generic
> >       0.20 =C2=B1 15%      +1.4        1.59 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.reweight_entity
> >       0.21 =C2=B1 13%      +1.4        1.60 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.__switch_to_asm
> >       0.23 =C2=B1 10%      +1.4        1.65 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.restore_fpregs_from_fpstate
> >       0.20 =C2=B1 13%      +1.5        1.69 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.set_next_entity
> >      27.59            +1.6       29.19        perf-profile.children.cyc=
les-pp.sock_write_iter
> >       0.28 =C2=B1 10%      +1.8        2.12 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.switch_fpu_return
> >       0.26 =C2=B1 11%      +1.8        2.10 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.select_task_rq_fair
> >      26.66 =C2=B1  2%      +2.0       28.63        perf-profile.childre=
n.cycles-pp.sock_sendmsg
> >       0.31 =C2=B1 12%      +2.1        2.44 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.select_task_rq
> >       0.30 =C2=B1 14%      +2.2        2.46 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.prepare_task_switch
> >      25.27 =C2=B1  2%      +2.2       27.47        perf-profile.childre=
n.cycles-pp.unix_stream_sendmsg
> >       2.10            +2.3        4.38 =C2=B1  2%  perf-profile.childre=
n.cycles-pp._raw_spin_lock
> >       0.40 =C2=B1 14%      +2.5        2.92 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.dequeue_entity
> >      48.40            +2.6       51.02        perf-profile.children.cyc=
les-pp.__libc_write
> >       0.46 =C2=B1 15%      +3.1        3.51 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.enqueue_entity
> >       0.49 =C2=B1 10%      +3.2        3.64 =C2=B1  7%  perf-profile.ch=
ildren.cycles-pp.update_load_avg
> >       0.53 =C2=B1 20%      +3.4        3.91 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.update_curr
> >      80.81            +3.4       84.24        perf-profile.children.cyc=
les-pp.entry_SYSCALL_64_after_hwframe
> >       0.50 =C2=B1 12%      +3.5        4.00 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.switch_mm_irqs_off
> >       0.55 =C2=B1  9%      +3.8        4.38 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.pick_next_task_fair
> >       9.60            +4.6       14.15 =C2=B1  2%  perf-profile.childre=
n.cycles-pp.syscall_exit_to_user_mode
> >       0.78 =C2=B1 13%      +4.9        5.65 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.dequeue_task_fair
> >       0.78 =C2=B1 15%      +5.2        5.99 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.enqueue_task_fair
> >      74.30            +5.6       79.86        perf-profile.children.cyc=
les-pp.do_syscall_64
> >       0.90 =C2=B1 15%      +6.3        7.16 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.ttwu_do_activate
> >       0.33 =C2=B1 31%      +6.3        6.61 =C2=B1  6%  perf-profile.ch=
ildren.cycles-pp.exit_to_user_mode_loop
> >       0.82 =C2=B1 15%      +8.1        8.92 =C2=B1  5%  perf-profile.ch=
ildren.cycles-pp.exit_to_user_mode_prepare
> >       1.90 =C2=B1 16%     +12.2       14.10 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.try_to_wake_up
> >       2.36 =C2=B1 11%     +12.2       14.60 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.schedule_timeout
> >       1.95 =C2=B1 15%     +12.5       14.41 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.autoremove_wake_function
> >       2.01 =C2=B1 15%     +12.8       14.76 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.__wake_up_common
> >       2.23 =C2=B1 13%     +13.2       15.45 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.__wake_up_common_lock
> >       2.53 =C2=B1 10%     +13.4       15.90 =C2=B1  2%  perf-profile.ch=
ildren.cycles-pp.sock_def_readable
> >       2.29 =C2=B1 15%     +14.6       16.93 =C2=B1  3%  perf-profile.ch=
ildren.cycles-pp.unix_stream_data_wait
> >       2.61 =C2=B1 13%     +18.0       20.65 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.schedule
> >       2.66 =C2=B1 13%     +18.1       20.77 =C2=B1  4%  perf-profile.ch=
ildren.cycles-pp.__schedule
> >      11.25 =C2=B1  3%      -4.6        6.67 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.syscall_return_via_sysret
> >       5.76 =C2=B1 32%      -3.9        1.90 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.native_queued_spin_lock_slowpath
> >       8.69 =C2=B1  3%      -3.4        5.27 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.syscall_exit_to_user_mode
> >       3.11 =C2=B1  3%      -2.5        0.60 =C2=B1 13%  perf-profile.se=
lf.cycles-pp.__slab_free
> >       6.65 =C2=B1  2%      -2.2        4.47 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.entry_SYSCALL_64_after_hwframe
> >       4.78 =C2=B1  3%      -1.9        2.88 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.__entry_text_start
> >       3.52 =C2=B1  2%      -1.9        1.64 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.copy_user_enhanced_fast_string
> >       2.06 =C2=B1  3%      -1.1        0.96 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.kmem_cache_free
> >       1.42 =C2=B1  3%      -1.0        0.46 =C2=B1 10%  perf-profile.se=
lf.cycles-pp.check_heap_object
> >       1.43 =C2=B1  4%      -0.8        0.64        perf-profile.self.cy=
cles-pp.sock_wfree
> >       0.99 =C2=B1  3%      -0.8        0.21 =C2=B1 12%  perf-profile.se=
lf.cycles-pp.skb_release_data
> >       0.84 =C2=B1  8%      -0.7        0.10 =C2=B1 64%  perf-profile.se=
lf.cycles-pp.___slab_alloc
> >       1.97 =C2=B1  2%      -0.6        1.32        perf-profile.self.cy=
cles-pp.unix_stream_read_generic
> >       1.60 =C2=B1  3%      -0.5        1.11 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.memcg_slab_post_alloc_hook
> >       1.24 =C2=B1  2%      -0.5        0.75 =C2=B1 11%  perf-profile.se=
lf.cycles-pp.mod_objcg_state
> >       0.71            -0.5        0.23 =C2=B1 15%  perf-profile.self.cy=
cles-pp.__build_skb_around
> >       0.95 =C2=B1  3%      -0.5        0.50 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.__alloc_skb
> >       0.97 =C2=B1  4%      -0.4        0.55 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.kmem_cache_alloc_node
> >       0.99 =C2=B1  3%      -0.4        0.59 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.vfs_write
> >       1.38 =C2=B1  2%      -0.4        0.99        perf-profile.self.cy=
cles-pp.__kmem_cache_free
> >       0.86 =C2=B1  2%      -0.4        0.50 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.__kmem_cache_alloc_node
> >       0.92 =C2=B1  4%      -0.4        0.56 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.sock_write_iter
> >       1.06 =C2=B1  3%      -0.4        0.70 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.__might_resched
> >       0.73 =C2=B1  4%      -0.3        0.44 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.__cond_resched
> >       0.85 =C2=B1  3%      -0.3        0.59 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.__check_heap_object
> >       1.46 =C2=B1  7%      -0.3        1.20 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.unix_stream_sendmsg
> >       0.73 =C2=B1  9%      -0.3        0.47 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.skb_set_owner_w
> >       1.54            -0.3        1.28 =C2=B1  4%  perf-profile.self.cy=
cles-pp.apparmor_file_permission
> >       0.74 =C2=B1  3%      -0.2        0.50 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.get_obj_cgroup_from_current
> >       1.15 =C2=B1  3%      -0.2        0.91 =C2=B1  8%  perf-profile.se=
lf.cycles-pp.aa_sk_perm
> >       0.60            -0.2        0.36 =C2=B1  4%  perf-profile.self.cy=
cles-pp.entry_SYSRETQ_unsafe_stack
> >       0.65 =C2=B1  4%      -0.2        0.45 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.__get_obj_cgroup_from_memcg
> >       0.24 =C2=B1  6%      -0.2        0.05 =C2=B1 56%  perf-profile.se=
lf.cycles-pp.fsnotify_perm
> >       0.76 =C2=B1  3%      -0.2        0.58 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.sock_read_iter
> >       1.10 =C2=B1  4%      -0.2        0.92 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.__fget_light
> >       0.42 =C2=B1  3%      -0.2        0.25 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.obj_cgroup_charge
> >       0.32 =C2=B1  4%      -0.2        0.17 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.refill_obj_stock
> >       0.29            -0.2        0.14 =C2=B1  8%  perf-profile.self.cy=
cles-pp.__kmalloc_node_track_caller
> >       0.54 =C2=B1  3%      -0.1        0.40 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.__might_sleep
> >       0.30 =C2=B1  7%      -0.1        0.16 =C2=B1 22%  perf-profile.se=
lf.cycles-pp.security_file_permission
> >       0.34 =C2=B1  3%      -0.1        0.21 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.entry_SYSCALL_64_safe_stack
> >       0.41 =C2=B1  3%      -0.1        0.29 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.is_vmalloc_addr
> >       0.27 =C2=B1  3%      -0.1        0.16 =C2=B1  6%  perf-profile.se=
lf.cycles-pp._copy_from_iter
> >       0.24 =C2=B1  3%      -0.1        0.12 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.ksys_write
> >       0.95 =C2=B1  2%      -0.1        0.84 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.__virt_addr_valid
> >       0.56 =C2=B1 11%      -0.1        0.46 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.sock_def_readable
> >       0.16 =C2=B1  7%      -0.1        0.06 =C2=B1 18%  perf-profile.se=
lf.cycles-pp.sock_recvmsg
> >       0.22 =C2=B1  5%      -0.1        0.14 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.ksys_read
> >       0.27 =C2=B1  4%      -0.1        0.19 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.kmalloc_slab
> >       0.28 =C2=B1  2%      -0.1        0.20 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.consume_skb
> >       0.35 =C2=B1  2%      -0.1        0.28 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.__check_object_size
> >       0.13 =C2=B1  8%      -0.1        0.06 =C2=B1 18%  perf-profile.se=
lf.cycles-pp.syscall_exit_to_user_mode_prepare
> >       0.20 =C2=B1  5%      -0.1        0.12 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.kmalloc_reserve
> >       0.26 =C2=B1  5%      -0.1        0.19 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.sock_alloc_send_pskb
> >       0.42 =C2=B1  2%      -0.1        0.35 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.syscall_enter_from_user_mode
> >       0.19 =C2=B1  5%      -0.1        0.12 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.aa_file_perm
> >       0.16 =C2=B1  4%      -0.1        0.10 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.skb_copy_datagram_from_iter
> >       0.18 =C2=B1  4%      -0.1        0.12 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.apparmor_socket_sendmsg
> >       0.18 =C2=B1  5%      -0.1        0.12 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.apparmor_socket_recvmsg
> >       0.15 =C2=B1  5%      -0.1        0.10 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.alloc_skb_with_frags
> >       0.64 =C2=B1  3%      -0.1        0.59        perf-profile.self.cy=
cles-pp.__libc_write
> >       0.20 =C2=B1  4%      -0.1        0.15 =C2=B1  3%  perf-profile.se=
lf.cycles-pp._copy_to_iter
> >       0.15 =C2=B1  5%      -0.1        0.10 =C2=B1 11%  perf-profile.se=
lf.cycles-pp.sock_sendmsg
> >       0.08 =C2=B1  4%      -0.1        0.03 =C2=B1 81%  perf-profile.se=
lf.cycles-pp.copyout
> >       0.11 =C2=B1  6%      -0.0        0.06 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.__fdget_pos
> >       0.12 =C2=B1  5%      -0.0        0.07 =C2=B1 10%  perf-profile.se=
lf.cycles-pp.kmalloc_size_roundup
> >       0.34 =C2=B1  3%      -0.0        0.29        perf-profile.self.cy=
cles-pp.do_syscall_64
> >       0.20 =C2=B1  4%      -0.0        0.15 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.rcu_all_qs
> >       0.41 =C2=B1  3%      -0.0        0.37 =C2=B1  8%  perf-profile.se=
lf.cycles-pp.unix_stream_recvmsg
> >       0.22 =C2=B1  2%      -0.0        0.17 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.unix_destruct_scm
> >       0.09 =C2=B1  4%      -0.0        0.05        perf-profile.self.cy=
cles-pp.should_failslab
> >       0.10 =C2=B1 15%      -0.0        0.06 =C2=B1 50%  perf-profile.se=
lf.cycles-pp.__mod_memcg_lruvec_state
> >       0.11 =C2=B1  4%      -0.0        0.07        perf-profile.self.cy=
cles-pp.__might_fault
> >       0.16 =C2=B1  2%      -0.0        0.13 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.obj_cgroup_uncharge_pages
> >       0.18 =C2=B1  4%      -0.0        0.16 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.security_socket_getpeersec_dgram
> >       0.28 =C2=B1  2%      -0.0        0.25 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.unix_write_space
> >       0.17 =C2=B1  2%      -0.0        0.15 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.apparmor_socket_getpeersec_dgram
> >       0.08 =C2=B1  6%      -0.0        0.05 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.security_socket_sendmsg
> >       0.12 =C2=B1  4%      -0.0        0.10 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.__skb_datagram_iter
> >       0.24 =C2=B1  2%      -0.0        0.22        perf-profile.self.cy=
cles-pp.mutex_unlock
> >       0.08 =C2=B1  5%      +0.0        0.10 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.scm_recv
> >       0.17 =C2=B1  2%      +0.0        0.19 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.__x64_sys_read
> >       0.19 =C2=B1  3%      +0.0        0.22 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.__get_task_ioprio
> >       0.00            +0.1        0.06        perf-profile.self.cycles-=
pp.finish_wait
> >       0.00            +0.1        0.06 =C2=B1  7%  perf-profile.self.cy=
cles-pp.cr4_update_irqsoff
> >       0.00            +0.1        0.06 =C2=B1  7%  perf-profile.self.cy=
cles-pp.invalidate_user_asid
> >       0.00            +0.1        0.07 =C2=B1 12%  perf-profile.self.cy=
cles-pp.wake_affine
> >       0.00            +0.1        0.07 =C2=B1  7%  perf-profile.self.cy=
cles-pp.check_cfs_rq_runtime
> >       0.00            +0.1        0.07 =C2=B1  5%  perf-profile.self.cy=
cles-pp.perf_trace_buf_update
> >       0.00            +0.1        0.07 =C2=B1  9%  perf-profile.self.cy=
cles-pp.asm_sysvec_reschedule_ipi
> >       0.00            +0.1        0.07 =C2=B1 10%  perf-profile.self.cy=
cles-pp.__bitmap_and
> >       0.00            +0.1        0.08 =C2=B1 10%  perf-profile.self.cy=
cles-pp.schedule_debug
> >       0.00            +0.1        0.08 =C2=B1 13%  perf-profile.self.cy=
cles-pp.read@plt
> >       0.00            +0.1        0.08 =C2=B1 12%  perf-profile.self.cy=
cles-pp.perf_trace_buf_alloc
> >       0.00            +0.1        0.09 =C2=B1 35%  perf-profile.self.cy=
cles-pp.migrate_task_rq_fair
> >       0.00            +0.1        0.09 =C2=B1  5%  perf-profile.self.cy=
cles-pp.place_entity
> >       0.00            +0.1        0.10 =C2=B1  4%  perf-profile.self.cy=
cles-pp.tracing_gen_ctx_irq_test
> >       0.00            +0.1        0.10        perf-profile.self.cycles-=
pp.__wake_up_common_lock
> >       0.07 =C2=B1 17%      +0.1        0.18 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.__list_add_valid
> >       0.00            +0.1        0.11 =C2=B1  8%  perf-profile.self.cy=
cles-pp.native_irq_return_iret
> >       0.00            +0.1        0.12 =C2=B1  6%  perf-profile.self.cy=
cles-pp.select_idle_cpu
> >       0.00            +0.1        0.12 =C2=B1 34%  perf-profile.self.cy=
cles-pp._find_next_and_bit
> >       0.00            +0.1        0.13 =C2=B1 25%  perf-profile.self.cy=
cles-pp.__cgroup_account_cputime
> >       0.00            +0.1        0.13 =C2=B1  7%  perf-profile.self.cy=
cles-pp.switch_ldt
> >       0.00            +0.1        0.14 =C2=B1  5%  perf-profile.self.cy=
cles-pp.check_preempt_curr
> >       0.00            +0.1        0.15 =C2=B1  2%  perf-profile.self.cy=
cles-pp.save_fpregs_to_fpstate
> >       0.00            +0.1        0.15 =C2=B1  5%  perf-profile.self.cy=
cles-pp.__rdgsbase_inactive
> >       0.14 =C2=B1  3%      +0.2        0.29        perf-profile.self.cy=
cles-pp._raw_spin_unlock_irqrestore
> >       0.00            +0.2        0.15 =C2=B1  7%  perf-profile.self.cy=
cles-pp.ttwu_queue_wakelist
> >       0.00            +0.2        0.17 =C2=B1  4%  perf-profile.self.cy=
cles-pp.rb_insert_color
> >       0.00            +0.2        0.17 =C2=B1  5%  perf-profile.self.cy=
cles-pp.rb_next
> >       0.00            +0.2        0.18 =C2=B1  2%  perf-profile.self.cy=
cles-pp.autoremove_wake_function
> >       0.01 =C2=B1223%      +0.2        0.19 =C2=B1  6%  perf-profile.se=
lf.cycles-pp.ttwu_do_activate
> >       0.00            +0.2        0.20 =C2=B1  2%  perf-profile.self.cy=
cles-pp.rcu_note_context_switch
> >       0.00            +0.2        0.20 =C2=B1  7%  perf-profile.self.cy=
cles-pp.exit_to_user_mode_loop
> >       0.27            +0.2        0.47 =C2=B1  3%  perf-profile.self.cy=
cles-pp.mutex_lock
> >       0.00            +0.2        0.20 =C2=B1 28%  perf-profile.self.cy=
cles-pp.perf_trace_sched_switch
> >       0.00            +0.2        0.21 =C2=B1  9%  perf-profile.self.cy=
cles-pp.resched_curr
> >       0.04 =C2=B1 45%      +0.2        0.26 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.perf_tp_event
> >       0.06 =C2=B1  7%      +0.2        0.28 =C2=B1  8%  perf-profile.se=
lf.cycles-pp.perf_trace_sched_wakeup_template
> >       0.19 =C2=B1  7%      +0.2        0.41 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.__list_del_entry_valid
> >       0.08 =C2=B1  5%      +0.2        0.31 =C2=B1 11%  perf-profile.se=
lf.cycles-pp.task_h_load
> >       0.00            +0.2        0.23 =C2=B1  5%  perf-profile.self.cy=
cles-pp.finish_task_switch
> >       0.03 =C2=B1 70%      +0.2        0.27 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.rb_erase
> >       0.02 =C2=B1142%      +0.3        0.29 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.native_sched_clock
> >       0.00            +0.3        0.28 =C2=B1  3%  perf-profile.self.cy=
cles-pp.__wrgsbase_inactive
> >       0.00            +0.3        0.28 =C2=B1  6%  perf-profile.self.cy=
cles-pp.clear_buddies
> >       0.07 =C2=B1 10%      +0.3        0.35 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.schedule_timeout
> >       0.03 =C2=B1 70%      +0.3        0.33 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.select_task_rq
> >       0.06 =C2=B1 13%      +0.3        0.36 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.__wake_up_common
> >       0.06 =C2=B1 13%      +0.3        0.36 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.dequeue_entity
> >       0.06 =C2=B1 18%      +0.3        0.37 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.perf_trace_sched_stat_runtime
> >       0.01 =C2=B1223%      +0.3        0.33 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.schedule
> >       0.02 =C2=B1142%      +0.3        0.35 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.cpuacct_charge
> >       0.01 =C2=B1223%      +0.3        0.35        perf-profile.self.cy=
cles-pp.set_next_entity
> >       0.00            +0.4        0.35 =C2=B1 13%  perf-profile.self.cy=
cles-pp.available_idle_cpu
> >       0.08 =C2=B1 10%      +0.4        0.44 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.prepare_to_wait
> >       0.63 =C2=B1  3%      +0.4        1.00 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.vfs_read
> >       0.02 =C2=B1142%      +0.4        0.40 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.check_preempt_wakeup
> >       0.02 =C2=B1141%      +0.4        0.42 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.pick_next_entity
> >       0.07 =C2=B1 17%      +0.4        0.48        perf-profile.self.cy=
cles-pp.__calc_delta
> >       0.06 =C2=B1 14%      +0.4        0.47 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.unix_stream_data_wait
> >       0.04 =C2=B1 45%      +0.4        0.45 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.switch_fpu_return
> >       0.00            +0.5        0.46 =C2=B1  7%  perf-profile.self.cy=
cles-pp.set_next_buddy
> >       0.07 =C2=B1 17%      +0.5        0.53 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.select_task_rq_fair
> >       0.08 =C2=B1 16%      +0.5        0.55 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.try_to_wake_up
> >       0.08 =C2=B1 19%      +0.5        0.56 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.update_rq_clock
> >       0.02 =C2=B1141%      +0.5        0.50 =C2=B1 10%  perf-profile.se=
lf.cycles-pp.select_idle_sibling
> >       0.77 =C2=B1  2%      +0.5        1.25 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.__libc_read
> >       0.09 =C2=B1 19%      +0.5        0.59 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.reweight_entity
> >       0.08 =C2=B1 14%      +0.5        0.59 =C2=B1  2%  perf-profile.se=
lf.cycles-pp.dequeue_task_fair
> >       0.08 =C2=B1 13%      +0.6        0.64 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.update_min_vruntime
> >       0.02 =C2=B1141%      +0.6        0.58 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.put_prev_entity
> >       0.06 =C2=B1 11%      +0.6        0.64 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.enqueue_task_fair
> >       0.07 =C2=B1 18%      +0.6        0.68 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.os_xsave
> >       1.39 =C2=B1  2%      +0.7        2.06 =C2=B1  3%  perf-profile.se=
lf.cycles-pp._raw_spin_lock_irqsave
> >       0.28 =C2=B1  8%      +0.7        0.97 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.update_cfs_group
> >       0.14 =C2=B1  8%      +0.7        0.83 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.__update_load_avg_se
> >       1.76 =C2=B1  3%      +0.7        2.47 =C2=B1  3%  perf-profile.se=
lf.cycles-pp._raw_spin_lock
> >       0.12 =C2=B1 12%      +0.7        0.85 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.prepare_task_switch
> >       0.12 =C2=B1 12%      +0.8        0.91 =C2=B1  3%  perf-profile.se=
lf.cycles-pp.__update_load_avg_cfs_rq
> >       0.13 =C2=B1 12%      +0.8        0.93 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.pick_next_task_fair
> >       0.13 =C2=B1 12%      +0.9        0.98 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.__switch_to
> >       0.11 =C2=B1 18%      +0.9        1.06 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.___perf_sw_event
> >       0.16 =C2=B1 11%      +1.2        1.34 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.enqueue_entity
> >       0.20 =C2=B1 12%      +1.4        1.58 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.__switch_to_asm
> >       0.23 =C2=B1 10%      +1.4        1.65 =C2=B1  5%  perf-profile.se=
lf.cycles-pp.restore_fpregs_from_fpstate
> >       0.25 =C2=B1 12%      +1.5        1.77 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.__schedule
> >       0.22 =C2=B1 10%      +1.6        1.78 =C2=B1 10%  perf-profile.se=
lf.cycles-pp.update_load_avg
> >       0.23 =C2=B1 16%      +1.7        1.91 =C2=B1  7%  perf-profile.se=
lf.cycles-pp.update_curr
> >       0.48 =C2=B1 11%      +3.4        3.86 =C2=B1  4%  perf-profile.se=
lf.cycles-pp.switch_mm_irqs_off
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         sudo bin/lkp install job.yaml           # job file is attached =
in this email
> >         bin/lkp split-job --compatible job.yaml # generate the yaml fil=
e for lkp run
> >         sudo bin/lkp run generated-yaml-file
> >
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
