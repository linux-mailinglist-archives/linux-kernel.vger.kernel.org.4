Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF475F842D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJHIAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiJHIAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:00:21 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0A303FE;
        Sat,  8 Oct 2022 01:00:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MkyGK6N7SzKHnb;
        Sat,  8 Oct 2022 15:58:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgC3Lo4KLkFjsJnSBw--.62079S3;
        Sat, 08 Oct 2022 16:00:11 +0800 (CST)
Subject: Re: [blk] 8c5035dfbb: fio.read_iops -10.6% regression
To:     kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <202210081045.77ddf59b-yujie.liu@intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d5279fc2-38b3-6d20-4404-604d5c7277e2@huaweicloud.com>
Date:   Sat, 8 Oct 2022 16:00:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <202210081045.77ddf59b-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Lo4KLkFjsJnSBw--.62079S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFy8Xw4rZrW5GFyrZF1DJrb_yoWxCr18pa
        na9FyxJrZ8G34ruw10vr1UuFW7Gr95Jay7Xry8WF4Iga4F9rn0qFZxKF93KF98u34jkw1x
        ZFWUJry5XF1jyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/10/08 10:50, kernel test robot 写道:
> Greeting,
> 
> FYI, we noticed a -10.6% regression of fio.read_iops due to commit:

I don't know how this is working but I'm *sure* this commit won't affect
performance. Please take a look at the commit, only wbt initialization
is touched, which is done while creating the device:

device_add_disk
  blk_register_queue
   wbt_enable_default
    wbt_init

And io path is the same with or without this commit.

By the way, wbt should only work for write.

Thanks,
Kuai
> 
> commit: 8c5035dfbb9475b67c82b3fdb7351236525bf52b ("blk-wbt: call rq_qos_add() after wb_normal is initialized")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: fio-basic
> on test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 192G memory
> with following parameters:
> 
> 	runtime: 300s
> 	nr_task: 8t
> 	disk: 1SSD
> 	fs: btrfs
> 	rw: randread
> 	bs: 2M
> 	ioengine: sync
> 	test_size: 256g
> 	cpufreq_governor: performance
> 
> test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
> test-url: https://github.com/axboe/fio
> 
> 
> Details are as below:
> 
> =========================================================================================
> bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase:
>    2M/gcc-11/performance/1SSD/btrfs/sync/x86_64-rhel-8.3/8t/debian-11.1-x86_64-20220510.cgz/300s/randread/lkp-csl-2ap4/256g/fio-basic
> 
> commit:
>    f7de4886fe ("rnbd-srv: remove struct rnbd_dev")
>    8c5035dfbb ("blk-wbt: call rq_qos_add() after wb_normal is initialized")
> 
> f7de4886fe8f008a 8c5035dfbb9475b67c82b3fdb73
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>        0.03 ±106%      +0.2        0.22 ± 80%  fio.latency_20ms%
>        0.02 ± 33%      -0.0        0.01 ± 12%  fio.latency_4ms%
>        2508           -10.6%       2243        fio.read_bw_MBps
>     6717440           +17.6%    7897088        fio.read_clat_90%_us
>     6892202           +19.0%    8202922        fio.read_clat_95%_us
>     7602176 ±  4%     +18.4%    9000277 ±  3%  fio.read_clat_99%_us
>     6374238           +11.8%    7127450        fio.read_clat_mean_us
>      363825 ± 10%     +74.9%     636378 ±  5%  fio.read_clat_stddev
>        1254           -10.6%       1121        fio.read_iops
>      104.97           +11.8%     117.32        fio.time.elapsed_time
>      104.97           +11.8%     117.32        fio.time.elapsed_time.max
>       13731            +5.6%      14498 ±  4%  fio.time.maximum_resident_set_size
>      116.00            -8.2%     106.50        fio.time.percent_of_cpu_this_job_got
>   1.998e+10           +11.4%  2.226e+10        cpuidle..time
>        3.27 ±  3%      +4.6%       3.42        iostat.cpu.iowait
>        4.49 ± 68%      -2.1        2.38 ±152%  perf-profile.children.cycles-pp.number
>        4.49 ± 68%      -2.5        1.98 ±175%  perf-profile.self.cycles-pp.number
>      557763            +5.4%     587781        proc-vmstat.pgfault
>       25488            +3.1%      26274        proc-vmstat.pgreuse
>     2459048           -10.1%    2209482        vmstat.io.bi
>      184649 ±  5%     -10.4%     165526 ±  7%  vmstat.system.cs
>      111733 ± 30%     +61.8%     180770 ± 21%  numa-meminfo.node0.AnonPages
>      113221 ± 30%     +60.2%     181416 ± 21%  numa-meminfo.node0.Inactive(anon)
>       11301 ± 24%    +164.5%      29888 ±117%  numa-meminfo.node2.Active(file)
>      104911 ± 39%     -80.5%      20456 ±100%  numa-meminfo.node3.AnonHugePages
>      131666 ± 27%     -67.9%      42297 ± 82%  numa-meminfo.node3.AnonPages
>      132698 ± 26%     -67.5%      43158 ± 81%  numa-meminfo.node3.Inactive(anon)
>       27934 ± 30%     +61.8%      45196 ± 21%  numa-vmstat.node0.nr_anon_pages
>       28306 ± 30%     +60.2%      45358 ± 21%  numa-vmstat.node0.nr_inactive_anon
>       28305 ± 30%     +60.2%      45357 ± 21%  numa-vmstat.node0.nr_zone_inactive_anon
>        6291 ± 24%     +68.0%      10567 ± 26%  numa-vmstat.node2.workingset_nodes
>       32925 ± 27%     -67.9%      10571 ± 82%  numa-vmstat.node3.nr_anon_pages
>       33182 ± 26%     -67.5%      10786 ± 81%  numa-vmstat.node3.nr_inactive_anon
>       33182 ± 26%     -67.5%      10786 ± 81%  numa-vmstat.node3.nr_zone_inactive_anon
>      161.78 ±  4%     -28.2%     116.10 ± 30%  sched_debug.cfs_rq:/.runnable_avg.avg
>      161.46 ±  4%     -28.2%     115.85 ± 30%  sched_debug.cfs_rq:/.util_avg.avg
>      426382           +11.0%     473345 ±  6%  sched_debug.cpu.clock.avg
>      426394           +11.0%     473357 ±  6%  sched_debug.cpu.clock.max
>      426370           +11.0%     473331 ±  6%  sched_debug.cpu.clock.min
>      426139           +10.9%     472586 ±  6%  sched_debug.cpu.clock_task.avg
>      426368           +11.0%     473130 ±  6%  sched_debug.cpu.clock_task.max
>      416196           +11.1%     462228 ±  6%  sched_debug.cpu.clock_task.min
>        1156 ±  7%     -10.8%       1031 ±  6%  sched_debug.cpu.curr->pid.stddev
>      426372           +11.0%     473334 ±  6%  sched_debug.cpu_clk
>      425355           +11.0%     472318 ±  6%  sched_debug.ktime
>      426826           +11.0%     473787 ±  6%  sched_debug.sched_clk
>   1.263e+09            -7.9%  1.164e+09 ±  3%  perf-stat.i.branch-instructions
>      190886 ±  5%     -10.8%     170290 ±  7%  perf-stat.i.context-switches
>   1.979e+09            -8.8%  1.804e+09 ±  2%  perf-stat.i.dTLB-loads
>   8.998e+08            -8.2%  8.257e+08 ±  2%  perf-stat.i.dTLB-stores
>   6.455e+09            -8.0%  5.938e+09 ±  3%  perf-stat.i.instructions
>       21.78            -8.4%      19.95        perf-stat.i.metric.M/sec
>     7045315 ±  4%     -14.0%    6057863 ±  6%  perf-stat.i.node-load-misses
>     2658563 ±  7%     -21.9%    2077647 ± 12%  perf-stat.i.node-loads
>      414822 ±  4%     -12.9%     361455 ±  3%  perf-stat.i.node-store-misses
>   1.251e+09            -7.8%  1.154e+09 ±  3%  perf-stat.ps.branch-instructions
>      189082 ±  5%     -10.7%     168849 ±  7%  perf-stat.ps.context-switches
>    1.96e+09            -8.8%  1.789e+09 ±  2%  perf-stat.ps.dTLB-loads
>   8.912e+08            -8.1%  8.187e+08 ±  2%  perf-stat.ps.dTLB-stores
>   6.393e+09            -7.9%  5.888e+09 ±  3%  perf-stat.ps.instructions
>     6978485 ±  4%     -13.9%    6006510 ±  6%  perf-stat.ps.node-load-misses
>     2633627 ±  7%     -21.8%    2060033 ± 12%  perf-stat.ps.node-loads
>      410822 ±  4%     -12.8%     358289 ±  3%  perf-stat.ps.node-store-misses
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/r/202210081045.77ddf59b-yujie.liu@intel.com
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 

