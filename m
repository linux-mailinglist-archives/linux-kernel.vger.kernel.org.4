Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BF66823CF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjAaFYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjAaFX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:23:56 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2E82D44
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 21:23:55 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z10-20020a655a4a000000b004de9d84987bso5987166pgs.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 21:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxzXiYNEG3psU/UijmhvC35Bdkcw3jTJQ4HQ/yZCV/s=;
        b=jsSIKEs9A35yLh7J4xlSyP7PNII9O8YK5EWEA9VEUEfjPQxLpsoAqLIhFwdSU8od9O
         si7SllGKNiJR0J8u5BKPinI9qIFVgh/U8VrJCyRES7mrmjV9L2g8fpV6oY2SZ0UvJ/S8
         Zs1UCIVpOjEQNLzYuyldbVekh1Vwp8agM2GCbhnE20eAFwDPUUZnsR7LZJ1Yc+AFIMUV
         gMfsEmuD76WUWUfS8mjqPR6xM/MYn2Kypa/lBuN+D8BcMmQdDyvfKODJXsxrB5KsFKiZ
         gQSBdyVPCDJoA5akaPZDl7idb/GUvSgAtMpDUMKy8iqSov934Kt/qMQUpLlRvjuoO1UX
         briQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FxzXiYNEG3psU/UijmhvC35Bdkcw3jTJQ4HQ/yZCV/s=;
        b=2lqeI+uhnIFyJbs94kNSQTZuHg5IXwl1ZRuMSJ7QpCfaqBHYNBPRM4jEZ9OHQmMp5G
         GSW8afTp49C9BHkAp2d8ZSmILPUQHQIpHnwg+6pmTvC2en/yu9UQFHpQuxNcvYZnBwUb
         ibR20M6NR+Qnd0l9OBmZZc25O6bI3EZn374JYfEkUeckbcyCszhD8/CaJjoR11A0cU70
         rR7CZvdyclS5VOdyLU/Oz4cv5CuydICoZJpCVKl61zsLozGmZhzRZiexi7zlMZfiCpVc
         uyAd8R41/r7Wj/Tm66o+9lRZCWXPeBdCTkTwTeGBZ+Y88Ciao6O4EWg8IkprYaNasa1q
         0vJQ==
X-Gm-Message-State: AO0yUKVxg+QUQzLeX6dRZPz8YS2wnsw8IzaqfwRdhJh04qFWb0wHr8AN
        ZfxJ/hj+6waMtlAEYgCC6zbSHU2Q9HXEVA==
X-Google-Smtp-Source: AK7set9wihvUb4BrOcfW+AxAOfjo+EU9au58sIsQAaENrkC7AI7pjxswJ7VpvsLyUyBufvKQEx6cV0kS7GAt9g==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:f28f:b0:22c:5369:8a36 with SMTP
 id fs15-20020a17090af28f00b0022c53698a36mr250506pjb.0.1675142634866; Mon, 30
 Jan 2023 21:23:54 -0800 (PST)
Date:   Tue, 31 Jan 2023 05:23:52 +0000
In-Reply-To: <Y9dETROtv9Bld9TI@casper.infradead.org>
Mime-Version: 1.0
References: <202301301057.e55dad5b-oliver.sang@intel.com> <Y9dETROtv9Bld9TI@casper.infradead.org>
Message-ID: <20230131052352.5qnqegzwmt7akk7t@google.com>
Subject: Re: [linus:master] [mm]  f1a7941243:  unixbench.score -19.2% regression
From:   Shakeel Butt <shakeelb@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 04:15:09AM +0000, Matthew Wilcox wrote:
> On Mon, Jan 30, 2023 at 10:32:56AM +0800, kernel test robot wrote:
> > FYI, we noticed a -19.2% regression of unixbench.score due to commit:
> >
> > commit: f1a7941243c102a44e8847e3b94ff4ff3ec56f25 ("mm: convert mm's rss=
 stats into percpu_counter")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: unixbench
> > on test machine: 128 threads 4 sockets Intel(R) Xeon(R) Gold 6338 CPU @=
 2.00GHz (Ice Lake) with 256G memory
> > with following parameters:
> >
> > 	runtime: 300s
> > 	nr_task: 30%
> > 	test: spawn
> > 	cpufreq_governor: performance
>
> ...
>
> > 9cd6ffa60256e931 f1a7941243c102a44e8847e3b94
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >      11110           -19.2%       8974        unixbench.score
> >    1090843           -12.2%     957314        unixbench.time.involuntar=
y_context_switches
> >    4243909 =C2=B1  6%     -32.4%    2867136 =C2=B1  5%  unixbench.time.=
major_page_faults
> >      10547           -12.6%       9216        unixbench.time.maximum_re=
sident_set_size
> >  9.913e+08           -19.6%  7.969e+08        unixbench.time.minor_page=
_faults
> >       5638           +19.1%       6714        unixbench.time.system_tim=
e
> >       5502           -20.7%       4363        unixbench.time.user_time
>
> So we're spending a lot more time in the kernel and correspondingly less
> time in userspace.
>
> >   67991885           -16.9%   56507507        unixbench.time.voluntary_=
context_switches
> >   46198768           -19.1%   37355723        unixbench.workload
> >  1.365e+08           -12.5%  1.195e+08 =C2=B1  7%  cpuidle..usage
> >    1220612 =C2=B1  4%     -38.0%     757009 =C2=B1 28%  meminfo.Active
> >    1220354 =C2=B1  4%     -38.0%     756754 =C2=B1 28%  meminfo.Active(=
anon)
> >       0.50 =C2=B1  2%      -0.1        0.45 =C2=B1  4%  mpstat.cpu.all.=
soft%
> >       1.73            -0.2        1.52 =C2=B1  2%  mpstat.cpu.all.usr%
> >     532266           -18.4%     434559        vmstat.system.cs
> >     495826           -12.2%     435455 =C2=B1  8%  vmstat.system.in
> >   1.36e+08           -13.2%   1.18e+08 =C2=B1  9%  turbostat.C1
> >      68.80            +0.8       69.60        turbostat.C1%
> >  1.663e+08           -12.1%  1.462e+08 =C2=B1  8%  turbostat.IRQ
> >      15.54 =C2=B1 20%     -49.0%       7.93 =C2=B1 24%  sched_debug.cfs=
_rq:/.runnable_avg.min
> >      13.26 =C2=B1 19%     -46.6%       7.08 =C2=B1 29%  sched_debug.cfs=
_rq:/.util_avg.min
> >      48.96 =C2=B1  8%     +51.5%      74.20 =C2=B1 13%  sched_debug.cfs=
_rq:/.util_est_enqueued.avg
> >     138.00 =C2=B1  5%     +28.9%     177.87 =C2=B1  7%  sched_debug.cfs=
_rq:/.util_est_enqueued.stddev
> >     228060 =C2=B1  3%     +13.3%     258413 =C2=B1  4%  sched_debug.cpu=
.avg_idle.stddev
> >     432533 =C2=B1  5%     -16.4%     361517 =C2=B1  4%  sched_debug.cpu=
.nr_switches.min
> >  2.665e+08           -18.9%  2.162e+08        numa-numastat.node0.local=
_node
> >  2.666e+08           -18.9%  2.163e+08        numa-numastat.node0.numa_=
hit
> >  2.746e+08           -20.9%  2.172e+08        numa-numastat.node1.local=
_node
> >  2.747e+08           -20.9%  2.172e+08        numa-numastat.node1.numa_=
hit
> >  2.602e+08           -17.4%  2.149e+08        numa-numastat.node2.local=
_node
> >  2.603e+08           -17.4%  2.149e+08        numa-numastat.node2.numa_=
hit
> >  2.423e+08           -15.0%   2.06e+08        numa-numastat.node3.local=
_node
> >  2.424e+08           -15.0%  2.061e+08        numa-numastat.node3.numa_=
hit
>
> So we're going off-node a lot more for ... something.
>
> >  2.666e+08           -18.9%  2.163e+08        numa-vmstat.node0.numa_hi=
t
> >  2.665e+08           -18.9%  2.162e+08        numa-vmstat.node0.numa_lo=
cal
> >  2.747e+08           -20.9%  2.172e+08        numa-vmstat.node1.numa_hi=
t
> >  2.746e+08           -20.9%  2.172e+08        numa-vmstat.node1.numa_lo=
cal
> >  2.603e+08           -17.4%  2.149e+08        numa-vmstat.node2.numa_hi=
t
> >  2.602e+08           -17.4%  2.149e+08        numa-vmstat.node2.numa_lo=
cal
> >  2.424e+08           -15.0%  2.061e+08        numa-vmstat.node3.numa_hi=
t
> >  2.423e+08           -15.0%   2.06e+08        numa-vmstat.node3.numa_lo=
cal
> >     304947 =C2=B1  4%     -38.0%     189144 =C2=B1 28%  proc-vmstat.nr_=
active_anon
>
> Umm.  Are we running vmstat a lot during this test?  The commit says:
>
>     At the
>     moment the readers are either procfs interface, oom_killer and memory
>     reclaim which I think are not performance critical and should be ok w=
ith
>     slow read.  However I think we can make that change in a separate pat=
ch.
>
> This would explain the increased cross-NUMA references (we're going to
> the other nodes to collect the stats), and the general slowdown.  But I
> don't think it reflects a real workload; it's reflecting that the
> monitoring of this workload that we're doing is now more accurate and
> more expensive.
>

Thanks Willy for taking a stab at this issue. The numa_hit stat is
updated on allocations, so I don't think stat collection would increase
these stats. I looked at workload "spawn" in UnixBench and it is a
simple fork ping pong i.e. process does fork and then waits for the
child while the child simply exits.

I ran perf and it seems like percpu counter allocation is the additional
cost with this patch. See the report below. However I made spawn a bit
more sophisticated by adding a mmap() of a GiB then the page table
copy became the significant cost and no difference without or with the
given patch.

I am now wondering if this fork ping pong really an important workload
that we should revert the patch or ignore for now but work on improving
the performance of __alloc_percpu_gfp code.


-   90.97%     0.06%  spawn    [kernel.kallsyms]  [k] entry_SYSCALL_64_afte=
r_hwframe
   - 90.91% entry_SYSCALL_64_after_hwframe
      - 90.86% do_syscall_64
         - 80.03% __x64_sys_clone
            - 79.98% kernel_clone
               - 75.97% copy_process
                  + 46.04% perf_event_init_task
                  - 21.50% copy_mm
                     - 10.05% mm_init
----------------------> - 8.92% __percpu_counter_init
                           - 8.67% __alloc_percpu_gfp
                              - 5.70% pcpu_alloc
                                   1.29% _find_next_bit
                                2.57% memset_erms
                        + 0.96% pgd_alloc
                     + 6.16% copy_page_range
                     + 1.72% anon_vma_fork
                     + 0.87% mas_store
                       0.72% kmem_cache_alloc
                  + 2.71% dup_task_struct
                  + 1.37% perf_event_fork
                    0.63% alloc_pid
                    0.51% copy_files
               + 3.71% wake_up_new_task
         + 7.40% __x64_sys_exit_group
         + 2.32% __x64_sys_wait4
         + 1.03% syscall_exit_to_user_mode
