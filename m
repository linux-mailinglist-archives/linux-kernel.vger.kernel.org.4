Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48A26162BF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKBMeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKBMed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:34:33 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EDB201A3;
        Wed,  2 Nov 2022 05:34:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4N2R8r6QS4z6R4fs;
        Wed,  2 Nov 2022 20:31:56 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCnulzUY2Jjl3+YBA--.43763S3;
        Wed, 02 Nov 2022 20:34:29 +0800 (CST)
Subject: Re: WARNING in loop_add
To:     Wei Chen <harperchen1110@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <CAO4mrfc=oS37CJtvPt+dWm-24mkV-5XRTGNZDr5ZopAE7pY3WQ@mail.gmail.com>
 <YtQfePz3+zeRDfMg@kbusch-mbp>
 <CAO4mrfd6wo3nPig_ZL622FjL7qjEnMQZ7SCTVcv5DR9YTWYM5g@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <106e8559-6cc4-ec78-1ce1-0a22242e13ba@huaweicloud.com>
Date:   Wed, 2 Nov 2022 20:34:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAO4mrfd6wo3nPig_ZL622FjL7qjEnMQZ7SCTVcv5DR9YTWYM5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnulzUY2Jjl3+YBA--.43763S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw48Zr4xJryxGr4rJrykGrg_yoWrCrW3p3
        y3K34Iyr98ArWUZr47tFn7JryUGr4UWw4kZrZ7Ar10yF4xCwn8AF12kFn3ZFy7uFykAFn8
        JFWkJryYqr95JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/02 15:02, Wei Chen 写道:
> Dear Linux developers,
> 
> The bug persists in the upstream Linux v6.0.0 4fe89d07dcc2 and the
> latest commit Linux v5.19.76 4f5365f77018.
> 
> [   68.027515][    C0] ======================================================
> [   68.027977][    C0] WARNING: possible circular locking dependency detected
> [   68.028436][    C0] 6.0.0 #35 Not tainted
> [   68.028704][    C0] ------------------------------------------------------
> [   68.029145][    C0] a.out/6625 is trying to acquire lock:
> [   68.029530][    C0] ffff88801be0c0d0 (&q->queue_lock){..-.}-{2:2},
> at: throtl_pending_timer_fn+0xf6/0x1020
> [   68.030213][    C0]
> [   68.030213][    C0] but task is already holding lock:
> [   68.030688][    C0] ffffc90000007be0
> ((&sq->pending_timer)){+.-.}-{0:0}, at: call_timer_fn+0xbb/0x210
> [   68.031300][    C0]
> [   68.031300][    C0] which lock already depends on the new lock.
> [   68.031300][    C0]
> [   68.031976][    C0]
> [   68.031976][    C0] the existing dependency chain (in reverse order) is:
> [   68.032548][    C0]
> [   68.032548][    C0] -> #2 ((&sq->pending_timer)){+.-.}-{0:0}:
> [   68.033086][    C0]        lock_acquire+0x17f/0x430
> [   68.033418][    C0]        del_timer_sync+0x104/0x380
> [   68.033764][    C0]        throtl_pd_free+0x15/0x40
> [   68.034100][    C0]        blkcg_deactivate_policy+0x31c/0x530
> [   68.034496][    C0]        blk_throtl_exit+0x86/0x120
> [   68.034838][    C0]        blkcg_init_queue+0x25a/0x2d0
> [   68.035184][    C0]        __alloc_disk_node+0x2ce/0x590
> [   68.035537][    C0]        __blk_mq_alloc_disk+0x11b/0x1e0
> [   68.035907][    C0]        loop_add+0x340/0x9b0
> [   68.036225][    C0]        loop_control_ioctl+0x108/0x770
> [   68.036587][    C0]        __se_sys_ioctl+0xfb/0x170
> [   68.036927][    C0]        do_syscall_64+0x3d/0x90
> [   68.037252][    C0]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   68.037668][    C0]
> [   68.037668][    C0] -> #1 (&blkcg->lock){....}-{2:2}:
> [   68.038152][    C0]        lock_acquire+0x17f/0x430
> [   68.038497][    C0]        _raw_spin_lock+0x2a/0x40
> [   68.038827][    C0]        blkg_create+0x949/0x10a0
> [   68.039165][    C0]        blkcg_init_queue+0xb4/0x2d0
> [   68.039517][    C0]        __alloc_disk_node+0x2ce/0x590
> [   68.039868][    C0]        __blk_mq_alloc_disk+0x11b/0x1e0
> [   68.040232][    C0]        floppy_alloc_disk+0x54/0x350
> [   68.040585][    C0]        do_floppy_init+0x1b1/0x1d27
> [   68.040927][    C0]        async_run_entry_fn+0xa6/0x400
> [   68.041281][    C0]        process_one_work+0x83c/0x11a0
> [   68.041646][    C0]        worker_thread+0xa6c/0x1290
> [   68.041980][    C0]        kthread+0x266/0x300
> [   68.042274][    C0]        ret_from_fork+0x1f/0x30
> [   68.042592][    C0]
> [   68.042592][    C0] -> #0 (&q->queue_lock){..-.}-{2:2}:
> [   68.043074][    C0]        check_prevs_add+0x4f5/0x5d30
> [   68.043433][    C0]        __lock_acquire+0x4432/0x6080
> [   68.043783][    C0]        lock_acquire+0x17f/0x430
> [   68.044113][    C0]        _raw_spin_lock_irq+0xae/0xf0
> [   68.044465][    C0]        throtl_pending_timer_fn+0xf6/0x1020
> [   68.044867][    C0]        call_timer_fn+0xf5/0x210
> [   68.045189][    C0]        __run_timers+0x762/0x970
> [   68.045534][    C0]        run_timer_softirq+0x63/0xf0
> [   68.045890][    C0]        __do_softirq+0x372/0x783
> [   68.046223][    C0]        __irq_exit_rcu+0xcf/0x150
> [   68.046557][    C0]        irq_exit_rcu+0x5/0x20
> [   68.046868][    C0]        sysvec_apic_timer_interrupt+0x91/0xb0
> [   68.047281][    C0]        asm_sysvec_apic_timer_interrupt+0x16/0x20
> [   68.047704][    C0]        should_fail+0x169/0x4f0
> [   68.048022][    C0]        should_failslab+0x5/0x20
> [   68.048346][    C0]        kmem_cache_alloc_lru+0x75/0x2f0
> [   68.048718][    C0]        new_inode_pseudo+0x81/0x1d0
> [   68.049055][    C0]        new_inode+0x25/0x1d0
> [   68.049355][    C0]        __debugfs_create_file+0x146/0x550
> [   68.049723][    C0]        blk_mq_debugfs_register_hctx+0x21c/0x660
> [   68.050166][    C0]        blk_mq_debugfs_register+0x2e0/0x470
> [   68.050553][    C0]        blk_register_queue+0x24f/0x3c0
> [   68.050912][    C0]        device_add_disk+0x55a/0xc00
> [   68.051257][    C0]        loop_add+0x71a/0x9b0
> [   68.051566][    C0]        loop_control_ioctl+0x108/0x770
> [   68.051933][    C0]        __se_sys_ioctl+0xfb/0x170
> [   68.052266][    C0]        do_syscall_64+0x3d/0x90
> [   68.052591][    C0]        entry_SYSCALL_64_after_hwframe+0x63/0xcd

It seems to me this is false positive, lock dep is confused about lock
from different device. #0 #1 is from loop. while #2 is from floppy.

Thanks,
Kuai

