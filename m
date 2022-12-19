Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD346506CE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 04:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiLSDcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 22:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLSDcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 22:32:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B89767C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 19:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671420686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8zuzRcmMD1bZu+L5mMLpgj3wAzhMhwpXHmCOOlJMCI=;
        b=cUdXIgC1piGW2YowP4xMavEMjCEW3jJTLXlpb4g8O4LjCRVSLyEaIRmO5KJbEL+zd6JjH/
        2GperhbrmUPYxougNsYcsd0J+vaXUqc+puwNAwqhfZA0CyrEJjqNPJ+5KzBZrmFhLBfX5Q
        ha0Kq8WLeow1GLtIPlbpaFAwsuINGMI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-XCHx4iQMN2yPw_VGT_0lhw-1; Sun, 18 Dec 2022 22:31:24 -0500
X-MC-Unique: XCHx4iQMN2yPw_VGT_0lhw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2FD1101A52E;
        Mon, 19 Dec 2022 03:31:23 +0000 (UTC)
Received: from [10.22.8.125] (unknown [10.22.8.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8CD6492C14;
        Mon, 19 Dec 2022 03:31:23 +0000 (UTC)
Message-ID: <0c2d1f6f-c7e8-c6bb-4588-e2846d1d1447@redhat.com>
Date:   Sun, 18 Dec 2022 22:31:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [linus:master] [sched] 8f9ea86fdf:
 WARNING:at_kernel/rcu/update.c:#rcutorture_sched_setaffinity
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <202212181906.c1c31e8e-yujie.liu@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <202212181906.c1c31e8e-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/22 06:37, kernel test robot wrote:
> Please be noted that we reported
>    [tip:sched/core] [sched] 8f9ea86fdf: WARNING:at_kernel/rcu/update.c:#rcutorture_sched_setaffinity
> at
>    https://lore.kernel.org/all/202211072243.f6b8c13b-yujie.liu@intel.com/
> when this commit was on
>    https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> since it has been merged to mainline now and the issue still exists in
> our tests, so we report again FYI
>
>
> Greeting,
>
> FYI, we noticed WARNING:at_kernel/rcu/update.c:#rcutorture_sched_setaffinity due to commit (built with gcc-11):
>
> commit: 8f9ea86fdf99b81458cc21fc1c591fcd4a0fa1f4 ("sched: Always preserve the user requested cpumask")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linux-next/master 459c73db4069c27c1d4a0e20d055b837396364b8]
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
>
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> [  146.157862][  T487] ------------[ cut here ]------------
> [  146.158315][  T487] rcutorture_sched_setaffinity: sched_setaffinity() returned -22
> [ 146.158938][ T487] WARNING: CPU: 0 PID: 487 at kernel/rcu/update.c:495 rcutorture_sched_setaffinity (kernel/rcu/update.c:495 (discriminator 3))
> [  146.159676][  T487] Modules linked in: rcutorture torture aesni_intel input_leds autofs4 cmdlinepart
> [  146.160249][  T487] CPU: 0 PID: 487 Comm: rcu_torture_fak Tainted: G        W       T  6.1.0-rc2-00013-g8f9ea86fdf99 #1
> [ 146.161051][ T487] EIP: rcutorture_sched_setaffinity (kernel/rcu/update.c:495 (discriminator 3))
> [ 146.161517][ T487] Code: d2 c3 8d 74 26 00 90 80 3d 75 ee 28 c2 00 75 ee 50 68 68 7a 9c c1 68 98 f8 cc c1 89 45 fc c6 05 75 ee 28 c2 01 e8 04 d8 84 00 <0f> 0b 8b 45 fc 83 c4 0c c9 31 d2 c3 8d b4 26 00 00 00 00 66 90 55
> All code
> ========
>     0:	d2 c3                	rol    %cl,%bl
>     2:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>     6:	90                   	nop
>     7:	80 3d 75 ee 28 c2 00 	cmpb   $0x0,-0x3dd7118b(%rip)        # 0xffffffffc228ee83
>     e:	75 ee                	jne    0xfffffffffffffffe
>    10:	50                   	push   %rax
>    11:	68 68 7a 9c c1       	pushq  $0xffffffffc19c7a68
>    16:	68 98 f8 cc c1       	pushq  $0xffffffffc1ccf898
>    1b:	89 45 fc             	mov    %eax,-0x4(%rbp)
>    1e:	c6 05 75 ee 28 c2 01 	movb   $0x1,-0x3dd7118b(%rip)        # 0xffffffffc228ee9a
>    25:	e8 04 d8 84 00       	callq  0x84d82e
>    2a:*	0f 0b                	ud2    		<-- trapping instruction
>    2c:	8b 45 fc             	mov    -0x4(%rbp),%eax
>    2f:	83 c4 0c             	add    $0xc,%esp
>    32:	c9                   	leaveq
>    33:	31 d2                	xor    %edx,%edx
>    35:	c3                   	retq
>    36:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>    3d:	66 90                	xchg   %ax,%ax
>    3f:	55                   	push   %rbp
>
> Code starting with the faulting instruction
> ===========================================
>     0:	0f 0b                	ud2
>     2:	8b 45 fc             	mov    -0x4(%rbp),%eax
>     5:	83 c4 0c             	add    $0xc,%esp
>     8:	c9                   	leaveq
>     9:	31 d2                	xor    %edx,%edx
>     b:	c3                   	retq
>     c:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>    13:	66 90                	xchg   %ax,%ax
>    15:	55                   	push   %rbp
> [  146.162968][  T487] EAX: 00000000 EBX: 00000001 ECX: 00000000 EDX: 00000000
> [  146.163487][  T487] ESI: c38d3480 EDI: 00000002 EBP: edbcff54 ESP: edbcff44
> [  146.164076][  T487] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
> [  146.164654][  T487] CR0: 80050033 CR2: 08082ff0 CR3: 2e0f6000 CR4: 00040690
> [  146.165171][  T487] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  146.165645][  T487] DR6: fffe0ff0 DR7: 00000400
> [  146.165958][  T487] Call Trace:
> [ 146.166198][ T487] synchronize_rcu_trivial (kernel/rcu/rcutorture.c:798) rcutorture
> [ 146.166679][ T487] rcu_torture_fakewriter (kernel/rcu/rcutorture.c:1648) rcutorture
> [ 146.167155][ T487] kthread (kernel/kthread.c:376)
> [ 146.167456][ T487] ? rcu_read_unlock (kernel/rcu/rcutorture.c:1567) rcutorture
> [ 146.167908][ T487] ? kthread_complete_and_exit (kernel/kthread.c:331)
> [ 146.168340][ T487] ret_from_fork (arch/x86/entry/entry_32.S:770)
> [  146.168693][  T487] irq event stamp: 36141
> [ 146.169013][ T487] hardirqs last enabled at (36149): __up_console_sem (kernel/printk/printk.c:261 (discriminator 1))
> [ 146.169707][ T487] hardirqs last disabled at (36156): __up_console_sem (kernel/printk/printk.c:259 (discriminator 1))
> [ 146.170403][ T487] softirqs last enabled at (36050): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:415 kernel/softirq.c:600)
> [ 146.171012][ T487] softirqs last disabled at (36041): do_softirq_own_stack (arch/x86/kernel/irq_32.c:60 arch/x86/kernel/irq_32.c:150)
> [  146.171669][  T487] ---[ end trace 0000000000000000 ]---
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202212181906.c1c31e8e-yujie.liu@intel.com
>
>
> To reproduce:
>
>          # build kernel
> 	cd linux
> 	cp config-6.1.0-rc2-00013-g8f9ea86fdf99 .config
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
That warning is expected. The sched_setaffinity() syscall is changed in 
a way that an error condition that was previously ignored (i.e. 
sched_setaffinity() fails to set cpu affinity to at least one of the 
CPUs in the mask) will now return an error code. I don't consider that a 
breakage of user API.  Let me know if the assumption is incorrect.

Thanks,
Longman

