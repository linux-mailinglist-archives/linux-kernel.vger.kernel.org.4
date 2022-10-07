Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CF75F7D28
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJGSKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJGSKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:10:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C168217E1C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665166157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0h4jVPacrZA/p0vD27ZEqqdAEz60ecuRHHba8ZAJIU=;
        b=A/7ApHVmG/D8u/ro60XS34YX1sy5k7lh6KwYcFFZConB7Mi48uE8UfO2LjqYoeEta/5zfB
        bjJTmXwNSLQN5lBSursTyY8hW4XNqzQRm1ibmpy6mwTPKMwfGa3csmT1ii+G1dHh5MFEBw
        52HqMyNfxUuNPUv5Q5QmhhXkUlZDVig=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-c6Bet8nTO5WWXUSRpTCKbg-1; Fri, 07 Oct 2022 14:09:14 -0400
X-MC-Unique: c6Bet8nTO5WWXUSRpTCKbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64C0D3C11A03;
        Fri,  7 Oct 2022 18:09:13 +0000 (UTC)
Received: from [10.22.18.97] (unknown [10.22.18.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2074240EFB3C;
        Fri,  7 Oct 2022 18:09:12 +0000 (UTC)
Message-ID: <ac89f8d8-d87f-9d56-dd5b-43e2c948db29@redhat.com>
Date:   Fri, 7 Oct 2022 14:09:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [sched] 3cf68f7aae:
 WARNING:at_kernel/rcu/update.c:#rcutorture_sched_setaffinity
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <202209260935.35aecc5a-yujie.liu@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <202209260935.35aecc5a-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/22 22:51, kernel test robot wrote:
> Hi Waiman,
>
> While this report is for v9 patch, we found that the issue also happens
> on v10 patch, so we send this report FYI. Thanks.
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: 3cf68f7aaecb7f1482f3183a5925641632658667 ("[PATCH v9 2/7] sched: Use user_cpus_ptr for saving user provided cpumask in sched_setaffinity()")
> url: https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/sched-Persistent-user-requested-affinity/20220917-023345
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 6879c2d3b96039ff1668b4328a4d0dd3ea952cff
> patch link: https://lore.kernel.org/lkml/20220916183217.1172225-3-longman@redhat.com
>
> in testcase: rcutorture
> version:
> with following parameters:
>
> 	runtime: 300s
> 	test: cpuhotplug
> 	torture_type: trivial
>
> test-description: rcutorture is rcutorture kernel module load/unload test.
> test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> dl_task_check_affinity
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> [   95.904059][  T543] ------------[ cut here ]------------
> [   95.904506][  T543] rcutorture_sched_setaffinity: sched_setaffinity() returned -22
> [   95.905105][  T543] WARNING: CPU: 0 PID: 543 at kernel/rcu/update.c:495 rcutorture_sched_setaffinity+0x45/0x50
> [   95.905843][  T543] Modules linked in: rcutorture torture
> [   95.906279][  T543] CPU: 0 PID: 543 Comm: rcu_torture_fak Tainted: G        W          6.0.0-rc5-00091-g3cf68f7aaecb #1
> [   95.907111][  T543] EIP: rcutorture_sched_setaffinity+0x45/0x50
> [   95.907640][  T543] Code: 94 d0 82 00 75 ee 89 44 24 08 b9 88 5e f9 81 b2 01 89 4c 24 04 c7 04 24 00 d9 5f 82 88 15 8a 94 d0 82 89 45 fc e8 db 4d dc 00 <0f> 0b 8b 45 fc 89 ec 5d c3 66 90 55 31 c0 80 3d dc 65 65 83 00 89
> [   95.909113][  T543] EAX: 0000003e EBX: 00000000 ECX: e756ff14 EDX: 00001794
> [   95.909666][  T543] ESI: ee381d00 EDI: 00000002 EBP: ed37ff44 ESP: ed37ff34
> [   95.910203][  T543] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010282
> [   95.910816][  T543] CR0: 80050033 CR2: 77d40bb0 CR3: 06a9a000 CR4: 000406b0
> [   95.911357][  T543] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   95.911895][  T543] DR6: fffe0ff0 DR7: 00000400
> [   95.912255][  T543] Call Trace:
> [   95.912529][  T543]  synchronize_rcu_trivial+0x57/0xf0 [rcutorture]
> [   95.913034][  T543]  rcu_torture_fakewriter+0x108/0x280 [rcutorture]
> [   95.913532][  T543]  kthread+0xcd/0xf0
> [   95.913839][  T543]  ? rcu_read_unlock+0x60/0x60 [rcutorture]
> [   95.914311][  T543]  ? kthread_complete_and_exit+0x20/0x20
> [   95.914734][  T543]  ret_from_fork+0x19/0x24
> [   95.915065][  T543] irq event stamp: 66091
> [   95.915386][  T543] hardirqs last  enabled at (66099): [<810d5f79>] __up_console_sem+0x69/0x80
> [   95.916046][  T543] hardirqs last disabled at (66106): [<810d5f5d>] __up_console_sem+0x4d/0x80
> [   95.916711][  T543] softirqs last  enabled at (66072): [<81f8e014>] __do_softirq+0x284/0x4a3
> [   95.917377][  T543] softirqs last disabled at (66063): [<8100b544>] do_softirq_own_stack+0x24/0x30
> [   95.918043][  T543] ---[ end trace 0000000000000000 ]---
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/r/202209260935.35aecc5a-yujie.liu@intel.com
>
>
> To reproduce:
>
>          # build kernel
> 	cd linux
> 	cp config-6.0.0-rc5-00091-g3cf68f7aaecb .config
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
>
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
The warning happens in the following code:

     490 long rcutorture_sched_setaffinity(pid_t pid, const struct 
cpumask *in_mask)
     491 {
     492         int ret;
     493
     494         ret = sched_setaffinity(pid, in_mask);
     495         WARN_ONCE(ret, "%s: sched_setaffinity() returned %d\n", 
__func__, ret);
     496         return ret;
     497 }

     792 static void synchronize_rcu_trivial(void)
     793 {
     794         int cpu;
     795
     796         for_each_online_cpu(cpu) {
     797 rcutorture_sched_setaffinity(current->pid, cpumask_of(cpu));
     798                 WARN_ON_ONCE(raw_smp_processor_id() != cpu);
     799         }
     800 }

The original sched_setaffinity() code hide the failure due to racing in 
cpuset's cpus_allowed change. So it won't fail even if the new cpu being 
set is different from the mask given by the caller. The patch changes 
the code that will return a failure code instead. In this particular 
failure, the calling synchronize_rcu_trivial() should have triggered its 
WARN_ON_ONCE() check. Since this warning has been triggered before, it 
won't show up a second time. As a result, you have two warnings instead 
of one.

-Longman


