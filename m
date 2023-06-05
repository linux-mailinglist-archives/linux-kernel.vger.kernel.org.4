Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D681F722AF5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjFEPZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjFEPZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:25:41 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAF7F2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:25:36 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230605152531euoutp0264913d484b9833db8d3b2c0db065de0c~lzLlSKXKw2035520355euoutp027
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:25:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230605152531euoutp0264913d484b9833db8d3b2c0db065de0c~lzLlSKXKw2035520355euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685978731;
        bh=JLdQSs5ydSiYwwf0V6JSfMEX7LpM/2u51VDj0NoTgww=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=HFzX2n9rJUWP62B5EvCIgVuxyj56zlTRCOHY81R1Xi0ZTVf/hckPbP6LUqoDO+745
         Ker8YaRTMA1NjuPrqRjq4WLPQEgg0ZE+afxhB/qR1KBBiyd8uqv3A03NFHxlH64xnX
         wjCK0ZYDFGlqoiWYQEox6cGWyWFpVCerhraDQfCc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230605152531eucas1p26e20654f186d63aecf0b068d82fc7971~lzLlM5BBx1928319283eucas1p2a;
        Mon,  5 Jun 2023 15:25:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DD.19.42423.B6EFD746; Mon,  5
        Jun 2023 16:25:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230605152531eucas1p2a10401ec2180696cc9a5f2e94a67adca~lzLk3XxbB0458304583eucas1p2A;
        Mon,  5 Jun 2023 15:25:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230605152531eusmtrp19e5aeba2b908ed211286d6a07a861777~lzLk2z8pS2505125051eusmtrp1Y;
        Mon,  5 Jun 2023 15:25:31 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-5a-647dfe6b12c0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.EF.14344.B6EFD746; Mon,  5
        Jun 2023 16:25:31 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230605152530eusmtip108b92cde714c9c6495c32c0c926d0bba~lzLkbZytj0820208202eusmtip1X;
        Mon,  5 Jun 2023 15:25:30 +0000 (GMT)
Message-ID: <3051ad44-0ac3-e77b-3178-fac7cac3b3f2@samsung.com>
Date:   Mon, 5 Jun 2023 17:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOd3sf7UpBodmqFtc3jWHzeL8mVXs
        Fsd7DzBZ/Fp+lNHix4bHrA6sHptXaHlsWtXJ5vF5k1wAcxSXTUpqTmZZapG+XQJXxuP5ZQUv
        ciuWXD3E1sA4Oa6LkZNDQsBE4tPBR+xdjFwcQgIrGCUON6xjg3C+MEo8W7CLFcL5zChxfOof
        dpiWG8/nMUEkljNKrNvxCKrqI6PE1ourWLoYOTh4BewkZh9hAWlgEVCRWPdvHTOIzSsgKHFy
        5hOwuKhAqsTuawdYQWxhAS+J2Vfa2UBsZgFxiVtP5jOB2CICzhL77zRDxRMklm6/BFbPJmAo
        0fW2CyzOKeAq0T13DSNEjbxE89bZzCD3SAjs4JB4N+sbE8TVLhJfF51lgbCFJV4d3wL1jYzE
        6ck9LBAN7YwSC37fZ4JwJjBKNDy/xQhRZS1x59wvNpDPmAU0Jdbv0ocIO0qcnt/PBBKWEOCT
        uPFWEOIIPolJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUvMExiVZiEFyywk789C8s4shL0LGFlW
        MYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCaW0/+Of9rBOPfVR71DjEwcjIcYJTiYlUR4
        d3lVpwjxpiRWVqUW5ccXleakFh9ilOZgURLn1bY9mSwkkJ5YkpqdmlqQWgSTZeLglGpg4j0V
        dtFG7fvKj+cX7IzctqXwrZf8QfEdj6fH90rfSpou7proIKrBJdGxOyd2Uku1rPrX5ay+TZFH
        8+u8IuoSvjiciWqP3PtVbhvbI83PJU9N2uI+9HueN8mNUzym/Hnate0P2T6paV+pYZXcaLt1
        3faVS9OF9yszniqXbdjSMKX2h2lUkMbONdey/Rkk5gdWz9w5afEq9kv9KtYnd577535TPmqX
        jMH+xwrb7dcG6997HjnlSemjeyeOnxA+vjVoSvCprQxC1dobFpSKHuk++v5BcJFJ497NLGJb
        zAJPhfg7HdGwm59r6Byiukzjeu7Dzy12Px9sYkqe38eu+O3M6VjRDct3FE/Vn3xqwqOD6Uos
        xRmJhlrMRcWJAHOHWn+bAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7rZ/2pTDM5cFbC4vGsOm8X5M6vY
        LY73HmCy+LX8KKPFjw2PWR1YPTav0PLYtKqTzePzJrkA5ig9m6L80pJUhYz84hJbpWhDCyM9
        Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jMfzywpe5FYsuXqIrYFxclwXIyeHhICJ
        xI3n85i6GLk4hASWMkos7JrGCJGQkTg5rYEVwhaW+HOtiw2i6D2jxMzZO4ASHBy8AnYSs4+w
        gNSwCKhIrPu3jhnE5hUQlDg58wlYXFQgVeLukn42EFtYwEti9pV2MJtZQFzi1pP5TCC2iICz
        xP47zVDxBIltxyeCjRcScJHoeasOEmYTMJToetsFVsIp4CrRPXcNI0S5mUTX1i4oW16ieets
        5gmMQrOQXDELybZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzCKth37uWUH
        48pXH/UOMTJxMB5ilOBgVhLh3eVVnSLEm5JYWZValB9fVJqTWnyI0RQYFBOZpUST84FxnFcS
        b2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwMRvt0k03YzxFA+/xbNp
        HzW62q431N/pfhrYVrZ65ZHsKxN/s3A3/D4gE3JY37N+mfdUWa9Q9d95v97o7NXKr5JuuJJ9
        L/rvgvPm7nKm73LsHA4pp5//HaNx08e8Yu2jZvW/zKJLhP8+yCwp4SzblOX9OzPKuvqQS1uK
        Yn1ytsMhrd/txu/ldlbVhHyXsLj0ZMoJr4mCeiECJhOjcxcdl5jCZxktY71v1tFoPX0mO5GS
        wBkHV8+wW8MQJDg3QTPnTUe2XG3ElRDhXW0RPfKPAjuKoxW03aUmHp7iWN/larvwnNJBra6X
        bwIEpotb/ufe0CxQFnNqfu3a9J5MhcO9t2T3HtqzIuI1t/IBhnlKLMUZiYZazEXFiQBVL771
        KwMAAA==
X-CMS-MailID: 20230605152531eucas1p2a10401ec2180696cc9a5f2e94a67adca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230605152531eucas1p2a10401ec2180696cc9a5f2e94a67adca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230605152531eucas1p2a10401ec2180696cc9a5f2e94a67adca
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
        <CGME20230605152531eucas1p2a10401ec2180696cc9a5f2e94a67adca@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.2023 14:04, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/core branch of tip:
>
> Commit-ID:     c7dfd6b9122d29d0e9a4587ab470c0564d7f92ab
> Gitweb:        https://git.kernel.org/tip/c7dfd6b9122d29d0e9a4587ab470c0564d7f92ab
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Tue, 30 May 2023 13:20:46 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Tue, 30 May 2023 22:46:27 +02:00
>
> sched/fair: Multi-LLC select_idle_sibling()
>
> Tejun reported that when he targets workqueues towards a specific LLC
> on his Zen2 machine with 3 cores / LLC and 4 LLCs in total, he gets
> significant idle time.
>
> This is, of course, because of how select_idle_sibling() will not
> consider anything outside of the local LLC, and since all these tasks
> are short running the periodic idle load balancer is ineffective.
>
> And while it is good to keep work cache local, it is better to not
> have significant idle time. Therefore, have select_idle_sibling() try
> other LLCs inside the same node when the local one comes up empty.
>
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This patch landed in today's linux next-20230605 as commit c5214e13ad60 
("sched/fair: Multi-LLC select_idle_sibling()"). Unfortunately it causes 
regression on my ARM 64bit Exynos5433-based TM2e test board during the 
CPU hotplug tests. From time to time I get the NULL pointer dereference. 
Reverting $subject on top of linux-next fixes the issue. Let me know if 
I can help somehow debugging this issue. Here is a complete log (I've 
intentionally kept all the stack dumps, although they don't look very 
relevant...):

# for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0 >$i/online; done
Unable to handle kernel NULL pointer dereference at virtual address 
0000000000000090

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc1+ #13640 Not tainted
------------------------------------------------------
cpuhp/6/43 is trying to acquire lock:
ffff80000ab65598 (console_owner){..-.}-{0:0}, at: 
console_flush_all+0x1ac/0x4fc

but task is already holding lock:
ffff00002836ed48 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x58/0x46c

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->pi_lock){-.-.}-{2:2}:
        _raw_spin_lock_irqsave+0x60/0x88
        try_to_wake_up+0x58/0x46c
        default_wake_function+0x14/0x20
        autoremove_wake_function+0x18/0x44
        __wake_up_common+0x94/0x170
        __wake_up_common_lock+0x7c/0xcc
        __wake_up+0x18/0x24
        tty_wakeup+0x34/0x70
        tty_port_default_wakeup+0x20/0x38
        tty_port_tty_wakeup+0x18/0x24
        uart_write_wakeup+0x18/0x28
        s3c24xx_serial_tx_chars+0x20c/0x218
        s3c64xx_serial_handle_irq+0x9c/0xe0
        __handle_irq_event_percpu+0xb0/0x2d4
        handle_irq_event+0x4c/0xb8
        handle_fasteoi_irq+0xa4/0x198
        generic_handle_domain_irq+0x2c/0x44
        gic_handle_irq+0x44/0xc4
        call_on_irq_stack+0x24/0x4c
        do_interrupt_handler+0x80/0x84
        el1_interrupt+0x34/0x64
        el1h_64_irq_handler+0x18/0x24
        el1h_64_irq+0x64/0x68
        default_idle_call+0x9c/0x150
        do_idle+0x230/0x294
        cpu_startup_entry+0x28/0x2c
        rest_init+0x100/0x190
        arch_post_acpi_subsys_init+0x0/0x8
        start_kernel+0x594/0x684
        __primary_switched+0xbc/0xc4

-> #2 (&tty->write_wait){-.-.}-{2:2}:
        _raw_spin_lock_irqsave+0x60/0x88
        __wake_up_common_lock+0x5c/0xcc
        __wake_up+0x18/0x24
        tty_wakeup+0x34/0x70
        tty_port_default_wakeup+0x20/0x38
        tty_port_tty_wakeup+0x18/0x24
        uart_write_wakeup+0x18/0x28
        s3c24xx_serial_tx_chars+0x20c/0x218
        s3c64xx_serial_handle_irq+0x9c/0xe0
        __handle_irq_event_percpu+0xb0/0x2d4
        handle_irq_event+0x4c/0xb8
        handle_fasteoi_irq+0xa4/0x198
        generic_handle_domain_irq+0x2c/0x44
        gic_handle_irq+0x44/0xc4
        call_on_irq_stack+0x24/0x4c
        do_interrupt_handler+0x80/0x84
        el1_interrupt+0x34/0x64
        el1h_64_irq_handler+0x18/0x24
        el1h_64_irq+0x64/0x68
        default_idle_call+0x9c/0x150
        do_idle+0x230/0x294
        cpu_startup_entry+0x28/0x2c
        rest_init+0x100/0x190
        arch_post_acpi_subsys_init+0x0/0x8
        start_kernel+0x594/0x684
        __primary_switched+0xbc/0xc4

-> #1 (&port_lock_key){-.-.}-{2:2}:
        _raw_spin_lock_irqsave+0x60/0x88
        s3c24xx_serial_console_write+0xfc/0x124
        console_flush_all+0x208/0x4fc
        console_unlock+0x5c/0x14c
        vprintk_emit+0x15c/0x3b0
        vprintk_default+0x38/0x44
        vprintk+0xc0/0xe4
        _printk+0x5c/0x84
        register_console+0x1f4/0x420
        uart_add_one_port+0x50c/0x53c
        s3c24xx_serial_probe+0x34c/0x72c
        platform_probe+0x68/0xd8
        really_probe+0x148/0x2b4
        __driver_probe_device+0x78/0x12c
        driver_probe_device+0xd8/0x160
        __driver_attach+0x9c/0x1ac
        bus_for_each_dev+0x74/0xd4
        driver_attach+0x24/0x30
        bus_add_driver+0xe4/0x1e8
        driver_register+0x60/0x128
        __platform_driver_register+0x28/0x34
        samsung_serial_init+0x30/0x8c
        do_one_initcall+0x74/0x2f0
        kernel_init_freeable+0x288/0x4d8
        kernel_init+0x24/0x1dc
        ret_from_fork+0x10/0x20

-> #0 (console_owner){..-.}-{0:0}:
        __lock_acquire+0x13d0/0x217c
        lock_acquire+0x1e8/0x310
        console_flush_all+0x1f4/0x4fc
        console_unlock+0x5c/0x14c
        vprintk_emit+0x15c/0x3b0
        vprintk_default+0x38/0x44
        vprintk+0xc0/0xe4
        _printk+0x5c/0x84
        die_kernel_fault+0x48/0x37c
        __do_kernel_fault+0xd8/0x19c
        do_page_fault+0xac/0x6d8
        do_translation_fault+0xac/0xb8
        do_mem_abort+0x44/0x94
        el1_abort+0x44/0x70
        el1h_64_sync_handler+0xd8/0xe4
        el1h_64_sync+0x64/0x68
        __bitmap_and+0x4c/0x78
        select_task_rq_fair+0x724/0x1a30
        try_to_wake_up+0x17c/0x46c
        wake_up_process+0x18/0x24
        complete+0x58/0x8c
        __kthread_parkme+0x74/0xc8
        kthread_parkme+0x20/0x44
        smpboot_thread_fn+0x118/0x2a0
        kthread+0x124/0x128
        ret_from_fork+0x10/0x20

other info that might help us debug this:

Chain exists of:
   console_owner --> &tty->write_wait --> &p->pi_lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&p->pi_lock);
                                lock(&tty->write_wait);
                                lock(&p->pi_lock);
   lock(console_owner);

  *** DEADLOCK ***

5 locks held by cpuhp/6/43:
  #0: ffff000023e68440 (&x->wait){....}-{2:2}, at: complete+0x24/0x8c
  #1: ffff00002836ed48 (&p->pi_lock){-.-.}-{2:2}, at: 
try_to_wake_up+0x58/0x46c
  #2: ffff80000abd6ac0 (rcu_read_lock){....}-{1:2}, at: 
select_task_rq_fair+0x114/0x1a30
  #3: ffff80000ab65390 (console_lock){+.+.}-{0:0}, at: 
vprintk_default+0x38/0x44
  #4: ffff80000ab65440 (console_srcu){....}-{0:0}, at: 
console_flush_all+0x7c/0x4fc

stack backtrace:
CPU: 6 PID: 43 Comm: cpuhp/6 Not tainted 6.4.0-rc1+ #13640
Hardware name: Samsung TM2E board (DT)
Call trace:
  dump_backtrace+0x98/0xf0
  show_stack+0x18/0x24
  dump_stack_lvl+0x60/0xac
  dump_stack+0x18/0x24
  print_circular_bug+0x26c/0x348
  check_noncircular+0x134/0x148
  __lock_acquire+0x13d0/0x217c
  lock_acquire+0x1e8/0x310
  console_flush_all+0x1f4/0x4fc
  console_unlock+0x5c/0x14c
  vprintk_emit+0x15c/0x3b0
  vprintk_default+0x38/0x44
  vprintk+0xc0/0xe4
  _printk+0x5c/0x84
  die_kernel_fault+0x48/0x37c
  __do_kernel_fault+0xd8/0x19c
  do_page_fault+0xac/0x6d8
  do_translation_fault+0xac/0xb8
  do_mem_abort+0x44/0x94
  el1_abort+0x44/0x70
  el1h_64_sync_handler+0xd8/0xe4
  el1h_64_sync+0x64/0x68
  __bitmap_and+0x4c/0x78
  select_task_rq_fair+0x724/0x1a30
  try_to_wake_up+0x17c/0x46c
  wake_up_process+0x18/0x24
  complete+0x58/0x8c
  __kthread_parkme+0x74/0xc8
  kthread_parkme+0x20/0x44
  smpboot_thread_fn+0x118/0x2a0
  kthread+0x124/0x128
  ret_from_fork+0x10/0x20
Mem abort info:
   ESR = 0x0000000096000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x06: level 2 translation fault
Data abort info:
   ISV = 0, ISS = 0x00000006
   CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000002783e000
[0000000000000090] pgd=080000002738f003, p4d=080000002738f003, 
pud=0800000027a24003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in: brcmfmac_wcc cpufreq_powersave cpufreq_conservative 
brcmfmac brcmutil cfg80211 crct10dif_ce hci_uart btqca btbcm bluetooth 
s5p_jpeg exynos_gsc s3fwrn5_i2c s3fwrn5 s5p_mfc nci v4l2_mem2mem 
ecdh_generic nfc ecc videobuf2_dma_contig videobuf2_memops 
videobuf2_v4l2 videodev rfkill panfrost videobuf2_common 
drm_shmem_helper gpu_sched mc ip_tables x_tables ipv6

CPU: 6 PID: 43 Comm: cpuhp/6 Not tainted 6.4.0-rc1+ #13640
Hardware name: Samsung TM2E board (DT)
pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __bitmap_and+0x4c/0x78
lr : select_idle_cpu+0x64/0x450
sp : ffff80000bd83b50
x29: ffff80000bd83b50 x28: ffff80000a152ad8 x27: ffff00002836e500
x26: ffff00002814f600 x25: ffff80000ab43e78 x24: 0000000000000000
x23: ffff80000ab3f000 x22: 0000000000000000 x21: ffff80000ab43e78
x20: 0000000000000000 x19: 0000000000000000 x18: ffff8000099ac098
x17: 0000000000000000 x16: 0000000000000067 x15: 0000000000000001
x14: 0000000000000000 x13: 00000000000000d8 x12: 0000000000000000
x11: 0000000000000001 x10: ffff80000b7c6e90 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000020 x4 : 00000000000000ff x3 : 00000000fffffff8
x2 : ffff00002836e7e0 x1 : 0000000000000090 x0 : ffff0000d5fc2ad8
Call trace:
  __bitmap_and+0x4c/0x78
  select_task_rq_fair+0x724/0x1a30
  try_to_wake_up+0x17c/0x46c
  wake_up_process+0x18/0x24
  complete+0x58/0x8c
  __kthread_parkme+0x74/0xc8
  kthread_parkme+0x20/0x44
  smpboot_thread_fn+0x118/0x2a0
  kthread+0x124/0x128
  ret_from_fork+0x10/0x20
Code: 2a0803e8 4b0303e3 92800004 9ac32484 (f8687823)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x8c0004,1c780800,0000421b
Memory Limit: none
---[ end Kernel panic - not syncing: Oops: Fatal exception ]---


> ---
>   kernel/sched/fair.c     | 38 ++++++++++++++++++++++++++++++++++++++
>   kernel/sched/features.h |  1 +
>   2 files changed, 39 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 48b6f0c..0172458 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7028,6 +7028,38 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>   }
>   
>   /*
> + * For the multiple-LLC per node case, make sure to try the other LLC's if the
> + * local LLC comes up empty.
> + */
> +static int
> +select_idle_node(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +	struct sched_domain *parent = sd->parent;
> +	struct sched_group *sg;
> +
> +	/* Make sure to not cross nodes. */
> +	if (!parent || parent->flags & SD_NUMA)
> +		return -1;
> +
> +	sg = parent->groups;
> +	do {
> +		int cpu = cpumask_first(sched_group_span(sg));
> +		struct sched_domain *sd_child;
> +
> +		sd_child = per_cpu(sd_llc, cpu);
> +		if (sd_child != sd) {
> +			int i = select_idle_cpu(p, sd_child, test_idle_cores(cpu), cpu);
> +			if ((unsigned)i < nr_cpumask_bits)
> +				return i;
> +		}
> +
> +		sg = sg->next;
> +	} while (sg != parent->groups);
> +
> +	return -1;
> +}
> +
> +/*
>    * Scan the asym_capacity domain for idle CPUs; pick the first idle one on which
>    * the task fits. If no CPU is big enough, but there are idle ones, try to
>    * maximize capacity.
> @@ -7199,6 +7231,12 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   	if ((unsigned)i < nr_cpumask_bits)
>   		return i;
>   
> +	if (sched_feat(SIS_NODE)) {
> +		i = select_idle_node(p, sd, target);
> +		if ((unsigned)i < nr_cpumask_bits)
> +			return i;
> +	}
> +
>   	return target;
>   }
>   
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c..9e390eb 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>    */
>   SCHED_FEAT(SIS_PROP, false)
>   SCHED_FEAT(SIS_UTIL, true)
> +SCHED_FEAT(SIS_NODE, true)
>   
>   /*
>    * Issue a WARN when we do multiple update_rq_clock() calls

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

