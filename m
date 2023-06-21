Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A56C7379DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFUDqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFUDqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:46:35 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8A0183;
        Tue, 20 Jun 2023 20:46:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qm8Yv60lRz4f3lXd;
        Wed, 21 Jun 2023 11:46:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLOQcpJka1G1MA--.26307S3;
        Wed, 21 Jun 2023 11:46:25 +0800 (CST)
Subject: Re: [PATCH v3] md: fix duplicate filename for rdev
To:     Yu Kuai <yukuai1@huaweicloud.com>, Song Liu <song@kernel.org>
Cc:     pmenzel@molgen.mpg.de, akpm@linux-foundation.org, neilb@suse.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230523012727.3042247-1-yukuai1@huaweicloud.com>
 <CAPhsuW5AERnf5D4804ksgZEB2ZP7gVAG8f5Fghwnn0FKseBG+g@mail.gmail.com>
 <d8b3f930-0d58-81a8-449c-b39cd5f41983@huaweicloud.com>
 <CAPhsuW4E7P_Xp3EQ0PaO_kZNX6SQyf30FAwbM9cYFBZiVtJfaw@mail.gmail.com>
 <85c760bb-cb44-ed27-2ad3-f0ee2923226e@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <fb5f25f0-15c2-5f91-e954-a80f883cd661@huaweicloud.com>
Date:   Wed, 21 Jun 2023 11:46:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <85c760bb-cb44-ed27-2ad3-f0ee2923226e@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLOQcpJka1G1MA--.26307S3
X-Coremail-Antispam: 1UD129KBjvAXoW3KrW8Kr47tw45Zr1UJrWxtFb_yoW8JFW5to
        W0g3sxAF1rJr15Gw18C34UJw15Jw1fGr1DJrWFkr17Wr10yry5t398tryUK3y3Jw1rKF15
        Jw1UJr15ZF98tw1Dn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYk7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_
        WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
        IYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/06/21 10:25, Yu Kuai 写道:
> Hi,
> 
> 在 2023/06/21 5:38, Song Liu 写道:
>> On Tue, May 23, 2023 at 6:33 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> Hi,
>>>
>>> 在 2023/05/24 2:05, Song Liu 写道:
>>>> On Mon, May 22, 2023 at 6:30 PM Yu Kuai <yukuai1@huaweicloud.com> 
>>>> wrote:
>>>>>
>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>
>>>>> Commit 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a 
>>>>> device
>>>>> from an md array via sysfs") delays the deletion of rdev, however, 
>>>>> this
>>>>> introduces a window that rdev can be added again while the deletion is
>>>>> not done yet, and sysfs will complain about duplicate filename.
>>>>>
>>>>> Follow up patches try to fix this problem by flushing workqueue, 
>>>>> however,
>>>>> flush_rdev_wq() is just dead code, the progress in
>>>>> md_kick_rdev_from_array():
>>>>>
>>>>> 1) list_del_rcu(&rdev->same_set);
>>>>> 2) synchronize_rcu();
>>>>> 3) queue_work(md_rdev_misc_wq, &rdev->del_work);
>>>>>
>>>>> So in flush_rdev_wq(), if rdev is found in the list, work_pending() 
>>>>> can
>>>>> never pass, in the meantime, if work is queued, then rdev can never be
>>>>> found in the list.
>>>>>
>>>>> flush_rdev_wq() can be replaced by flush_workqueue() directly, 
>>>>> however,
>>>>> this approach is not good:
>>>>> - the workqueue is global, this synchronization for all raid disks is
>>>>>     not necessary.
>>>>> - flush_workqueue can't be called under 'reconfig_mutex', there is 
>>>>> still
>>>>>     a small window between flush_workqueue() and mddev_lock() that 
>>>>> other
>>>>>     contexts can queue new work, hence the problem is not solved 
>>>>> completely.
>>>>>
>>>>> sysfs already has apis to support delete itself through writer, and
>>>>> these apis, specifically sysfs_break/unbreak_active_protection(), 
>>>>> is used
>>>>> to support deleting rdev synchronously. Therefore, the above commit 
>>>>> can be
>>>>> reverted, and sysfs duplicate filename can be avoided.
>>>>>
>>>>> A new mdadm regression test is proposed as well([1]).
>>>>>
>>>>> [1] 
>>>>> https://lore.kernel.org/linux-raid/20230428062845.1975462-1-yukuai1@huaweicloud.com/ 
>>>>>
>>>>> Fixes: 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a 
>>>>> device from an md array via sysfs")
>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Thanks for the fix! I made the following changes and applied it
>>>> to md-next:
>>>>
>>>> 1. remove md_rdev->del_work, which is not used any more;
>>>> 2. change list_empty_safe to list_empty protected by the mutex, as
>>>>      list_empty_safe doesn't seem safe here.
>>
>> Hmm.. it appears that I missed a circular locking dependency with mdadm
>> test 21raid5cache (delete_mutex and open_mutex).
>>
>> Please take a look at this.
>>
> 
> Thanks, I think following patch can fix this, but run this test keep
> failing in my VM. Song, can you pass this test?

I just figure out a better sulution, please ignore this patch. I'll send
a fix soon.

Thanks,
Kuai
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 1be64ab76f5c..62b7d2d0e873 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -766,17 +766,29 @@ static void md_free_rdev(struct mddev *mddev)
>   {
>          struct md_rdev *rdev;
>          struct md_rdev *tmp;
> +       LIST_HEAD(delete);
> 
> -       mutex_lock(&mddev->delete_mutex);
> -       if (list_empty(&mddev->deleting))
> -               goto out;
> +retry:
> +       if (list_empty_careful(&mddev->deleting))
> +               return;
> +
> +       if (!mutex_trylock(&mddev->delete_mutex))
> +               goto retry;
> 
> -       list_for_each_entry_safe(rdev, tmp, &mddev->deleting, same_set) {
> +       /*
> +        * Clear 'mddev->deleting' first, because export_rdev can trigger
> +        * mddev_unlock(), and grab 'delete_mutex' again will cause 
> deadlock.
> +        * make sure md_free_rdev() will exit directly untill all rdev is
> +        * deleted.
> +        */
> +       list_splice(&delete, &mddev->deleting);
> +
> +       list_for_each_entry_safe(rdev, tmp, &delete, same_set) {
>                  list_del_init(&rdev->same_set);
>                  kobject_del(&rdev->kobj);
>                  export_rdev(rdev, mddev);
>          }
> -out:
> +
>          mutex_unlock(&mddev->delete_mutex);
>   }
> 
> 
> 
>> Thanks,
>> Song
>>
>> [  239.802277] ======================================================
>> [  239.803650] WARNING: possible circular locking dependency detected
>> [  239.804929] 6.4.0-rc2+ #772 Not tainted
>> [  239.805569] ------------------------------------------------------
>> [  239.806568] kworker/20:1/222 is trying to acquire lock:
>> [  239.807406] ffff88815335b3f0 (&mddev->delete_mutex){+.+.}-{3:3},
>> at: mddev_unlock+0xe0/0x2d0
>> [  239.808653]
>>                 but task is already holding lock:
>> [  239.809481] ffffc9000246fe00
>> ((work_completion)(&log->disable_writeback_work)){+.+.}-{0:0}, at:
>> process_one_work+0x462/0xa50
>> [  239.811049]
>>                 which lock already depends on the new lock.
>>
>> [  239.812187]
>>                 the existing dependency chain (in reverse order) is:
>> [  239.813230]
>>                 -> #3
>> ((work_completion)(&log->disable_writeback_work)){+.+.}-{0:0}:
>> [  239.814468]        __flush_work+0xdb/0x690
>> [  239.815068]        r5l_exit_log+0x59/0xc0
>> [  239.815649]        free_conf+0x34/0x320
>> [  239.816243]        raid5_free+0x11/0x40
>> [  239.816788]        __md_stop+0x9f/0x140
>> [  239.817336]        do_md_stop+0x2af/0xaf0
>> [  239.817901]        md_ioctl+0xb34/0x1e30
>> [  239.818469]        blkdev_ioctl+0x2bf/0x3d0
>> [  239.819079]        __x64_sys_ioctl+0xbe/0x100
>> [  239.819701]        do_syscall_64+0x3a/0x90
>> [  239.820294]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
>> [  239.821076]
>>                 -> #2 (&mddev->open_mutex){+.+.}-{3:3}:
>> [  239.821971]        __mutex_lock+0x11d/0x13f0
>> [  239.822592]        md_open+0xad/0x180
>> [  239.822937] kobject: 'md0' (ffff88811c8e5498): kobject_uevent_env
>> [  239.823113]        blkdev_get_whole+0x50/0x120
>> [  239.824216] kobject: 'md0' (ffff88811c8e5498): fill_kobj_path: path
>> = '/devices/virtual/block/md0'
>> [  239.824725]        blkdev_get_by_dev+0x309/0x4f0
>> [  239.826747]        blkdev_open+0x8a/0x110
>> [  239.827319]        do_dentry_open+0x2a5/0x7b0
>> [  239.827939]        path_openat+0xcee/0x1070
>> [  239.828545]        do_filp_open+0x148/0x1d0
>> [  239.829137]        do_sys_openat2+0x2ec/0x470
>> [  239.829791]        do_sys_open+0x8a/0xd0
>> [  239.830352]        do_syscall_64+0x3a/0x90
>> [  239.830935]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
>> [  239.831728]
>>                 -> #1 (&disk->open_mutex){+.+.}-{3:3}:
>> [  239.832615]        __mutex_lock+0x11d/0x13f0
>> [  239.833231]        blkdev_put+0x65/0x350
>> [  239.833785]        export_rdev.isra.63+0x72/0xe0
>> [  239.834456]        mddev_unlock+0x1b1/0x2d0
>> [  239.835043]        md_ioctl+0x96c/0x1e30
>> [  239.835616]        blkdev_ioctl+0x2bf/0x3d0
>> [  239.836213]        __x64_sys_ioctl+0xbe/0x100
>> [  239.836828]        do_syscall_64+0x3a/0x90
>> [  239.837414]        entry_SYSCALL_64_after_hwframe+0x72/0xdc
>> [  239.838225]
>>                 -> #0 (&mddev->delete_mutex){+.+.}-{3:3}:
>> [  239.839145]        __lock_acquire+0x1e42/0x34b0
>> [  239.839797]        lock_acquire+0x161/0x3d0
>> [  239.840395]        __mutex_lock+0x11d/0x13f0
>> [  239.840999]        mddev_unlock+0xe0/0x2d0
>> [  239.841582]        r5c_disable_writeback_async+0x261/0x270
>> [  239.842354]        process_one_work+0x55f/0xa50
>> [  239.842996]        worker_thread+0x69/0x660
>> [  239.843595]        kthread+0x1a1/0x1e0
>> [  239.844131]        ret_from_fork+0x2c/0x50
>> [  239.844712]
>>                 other info that might help us debug this:
>>
>> [  239.845813] Chain exists of:
>>                   &mddev->delete_mutex --> &mddev->open_mutex -->
>> (work_completion)(&log->disable_writeback_work)
>>
>> [  239.847776]  Possible unsafe locking scenario:
>>
>> [  239.848623]        CPU0                    CPU1
>> [  239.849262]        ----                    ----
>> [  239.849927]   lock((work_completion)(&log->disable_writeback_work));
>> [  239.850831]                                lock(&mddev->open_mutex);
>> [  239.851719]
>> lock((work_completion)(&log->disable_writeback_work));
>> [  239.852945]   lock(&mddev->delete_mutex);
>> [  239.853517]
>>                  *** DEADLOCK ***
>>
>> [  239.854345] 2 locks held by kworker/20:1/222:
>> [  239.854960]  #0: ffff8881000b2748
>> ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x462/0xa50
>> [  239.856287]  #1: ffffc9000246fe00
>> ((work_completion)(&log->disable_writeback_work)){+.+.}-{0:0}, at:
>> process_one_work+0x462/0xa50
>> [  239.857939]
>>                 stack backtrace:
>> [  239.858567] CPU: 20 PID: 222 Comm: kworker/20:1 Not tainted 
>> 6.4.0-rc2+ #772
>> [  239.859533] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>> [  239.861135] Workqueue: events r5c_disable_writeback_async
>> [  239.861903] Call Trace:
>> [  239.862281]  <TASK>
>> [  239.862606]  dump_stack_lvl+0x46/0x80
>> [  239.863144]  check_noncircular+0x1ff/0x240
>> [  239.863737]  ? __pfx_check_noncircular+0x10/0x10
>> [  239.864401]  ? mark_lock.part.45+0x11a/0x1350
>> [  239.865019]  ? add_chain_block+0x23b/0x310
>> [  239.865624]  __lock_acquire+0x1e42/0x34b0
>> [  239.866202]  ? select_task_rq_fair+0x2b0/0x1e50
>> [  239.866845]  ? __pfx___lock_acquire+0x10/0x10
>> [  239.867473]  ? ttwu_queue_wakelist+0x1cc/0x1f0
>> [  239.868107]  ? __smp_call_single_queue+0x137/0x2a0
>> [  239.868816]  ? __default_send_IPI_dest_field+0x2b/0xa0
>> [  239.869548]  ? __lock_acquire+0xa5d/0x34b0
>> [  239.870131]  lock_acquire+0x161/0x3d0
>> [  239.870660]  ? mddev_unlock+0xe0/0x2d0
>> [  239.871216]  ? __pfx_lock_acquire+0x10/0x10
>> [  239.871808]  ? lock_is_held_type+0xd8/0x130
>> [  239.872405]  __mutex_lock+0x11d/0x13f0
>> [  239.872936]  ? mddev_unlock+0xe0/0x2d0
>> [  239.873474]  ? mddev_unlock+0xe0/0x2d0
>> [  239.874006]  ? __mutex_unlock_slowpath+0x12c/0x410
>> [  239.874695]  ? __pfx___mutex_lock+0x10/0x10
>> [  239.875297]  ? __pfx_rcu_read_lock_held+0x10/0x10
>> [  239.875986]  ? mddev_unlock+0xe0/0x2d0
>> [  239.876530]  mddev_unlock+0xe0/0x2d0
>> [  239.877044]  r5c_disable_writeback_async+0x261/0x270
>> [  239.877753]  ? __pfx_r5c_disable_writeback_async+0x10/0x10
>> [  239.878531]  ? __switch_to+0x2d8/0x770
>> [  239.879066]  ? __pfx_autoremove_wake_function+0x10/0x10
>> [  239.879813]  process_one_work+0x55f/0xa50
>> [  239.880398]  ? __pfx_process_one_work+0x10/0x10
>> [  239.881073]  ? _raw_spin_lock_irq+0x5c/0x90
>> [  239.881675]  worker_thread+0x69/0x660
>> [  239.882206]  ? __kthread_parkme+0xe4/0x100
>> [  239.882786]  ? __pfx_worker_thread+0x10/0x10
>> [  239.883395]  kthread+0x1a1/0x1e0
>> [  239.883863]  ? __pfx_kthread+0x10/0x10
>> [  239.884406]  ret_from_fork+0x2c/0x50
>> [  239.884925]  </TASK>
>> .
>>
> 
> .
> 

