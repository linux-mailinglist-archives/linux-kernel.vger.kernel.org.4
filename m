Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980EF70D037
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjEWBL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjEWBLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:11:18 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED1D8E;
        Mon, 22 May 2023 18:11:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QQGV73GQLz4f3l7v;
        Tue, 23 May 2023 09:11:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLOsEmxkkTwLKA--.12243S3;
        Tue, 23 May 2023 09:11:10 +0800 (CST)
Subject: Re: [PATCH v2] md: fix duplicate filename for rdev
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     neilb@suse.de, akpm@linux-foundation.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230522133225.2983667-1-yukuai1@huaweicloud.com>
 <CAPhsuW7DEZFbzGOThwvZaTgdJdOhYZy2QHRUPUPr=_yYN=wCbQ@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1d45f5fd-c00d-3f12-d8e7-d24f986609d9@huaweicloud.com>
Date:   Tue, 23 May 2023 09:11:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7DEZFbzGOThwvZaTgdJdOhYZy2QHRUPUPr=_yYN=wCbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLOsEmxkkTwLKA--.12243S3
X-Coremail-Antispam: 1UD129KBjvJXoWfGw4DurWxKF43WF13Zw4DXFb_yoWDXw1Upr
        Wfta15GrWUJrW7Ww42qwsruasIqw1DKrsrKryfu3WSywn8CrnrG3WFgry5uFyrCrZ5ur18
        Za1UWFsxua4FqrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/23 3:02, Song Liu 写道:
> On Mon, May 22, 2023 at 6:35 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> commit 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device
>> from an md array via sysfs") delay the deleting of rdev, however, this
>> introduce a window that rdev can be added again while the deleting is
>> not done yet, and sysfs will complain about duplicate filename.
>>
>> Follow up patches try to fix this problem by flush workqueue, however,
>> flush_rdev_wq() is just dead code, the progress in
>> md_kick_rdev_from_array():
>>
>> 1) list_del_rcu(&rdev->same_set);
>> 2) synchronize_rcu();
>> 3) queue_work(md_rdev_misc_wq, &rdev->del_work);
>>
>> So in flush_rdev_wq(), if rdev is found in the list, work_pending() can
>> never pass, in the meantime, if work is queued, then rdev can never be
>> found in the list.
>>
>> flush_rdev_wq() can be replaced by flush_workqueue() directly, however,
>> this approach is not good:
>> - the workqueue is global, this synchronization for all raid disks is
>>    not necessary.
>> - flush_workqueue can't be called under 'reconfig_mutex', there is still
>>    a small window between flush_workqueue() and mddev_lock() that other
>>    context can queue new work, hence the problem is not solved completely.
>>
>> sysfs already have apis to support delete itself through writer, and
>> these apis, specifically sysfs_break/unbreak_active_protection(), is used
>> to support deleting rdev synchronously. Therefore, the above commit can be
>> reverted, and sysfs duplicate filename can be avoided.
>>
>> A new mdadm regression test is proposed as well.
>>
>> Link: https://lore.kernel.org/linux-raid/20230428062845.1975462-1-yukuai1@huaweicloud.com/
>> Fixes: 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device from an md array via sysfs")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> We got build time warning with this patch:
> 
> drivers/md/md.c:90:33: warning: ‘md_rdev_misc_wq’ defined but not used
> [-Wunused-variable]
>   static struct workqueue_struct *md_rdev_misc_wq;

Will fix this in the next version,

Thanks,
Kuai
>                                   ^~~~~~~~~~~~~~~
> 
> Thanks,
> Song
> 
>> ---
>> Changes in v2:
>>   - rebase from the latest md-next branch
>>
>>   drivers/md/md.c | 84 +++++++++++++++++++++++++------------------------
>>   drivers/md/md.h |  8 +++++
>>   2 files changed, 51 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 7455bc9d8498..cafb457d614c 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -92,6 +92,7 @@ static struct workqueue_struct *md_rdev_misc_wq;
>>   static int remove_and_add_spares(struct mddev *mddev,
>>                                   struct md_rdev *this);
>>   static void mddev_detach(struct mddev *mddev);
>> +static void export_rdev(struct md_rdev *rdev);
>>
>>   /*
>>    * Default number of read corrections we'll attempt on an rdev
>> @@ -643,9 +644,11 @@ void mddev_init(struct mddev *mddev)
>>   {
>>          mutex_init(&mddev->open_mutex);
>>          mutex_init(&mddev->reconfig_mutex);
>> +       mutex_init(&mddev->delete_mutex);
>>          mutex_init(&mddev->bitmap_info.mutex);
>>          INIT_LIST_HEAD(&mddev->disks);
>>          INIT_LIST_HEAD(&mddev->all_mddevs);
>> +       INIT_LIST_HEAD(&mddev->deleting);
>>          timer_setup(&mddev->safemode_timer, md_safemode_timeout, 0);
>>          atomic_set(&mddev->active, 1);
>>          atomic_set(&mddev->openers, 0);
>> @@ -747,6 +750,23 @@ static void mddev_free(struct mddev *mddev)
>>
>>   static const struct attribute_group md_redundancy_group;
>>
>> +static void md_free_rdev(struct mddev *mddev)
>> +{
>> +       struct md_rdev *rdev;
>> +       struct md_rdev *tmp;
>> +
>> +       if (list_empty_careful(&mddev->deleting))
>> +               return;
>> +
>> +       mutex_lock(&mddev->delete_mutex);
>> +       list_for_each_entry_safe(rdev, tmp, &mddev->deleting, same_set) {
>> +               list_del_init(&rdev->same_set);
>> +               kobject_del(&rdev->kobj);
>> +               export_rdev(rdev);
>> +       }
>> +       mutex_unlock(&mddev->delete_mutex);
>> +}
>> +
>>   void mddev_unlock(struct mddev *mddev)
>>   {
>>          if (mddev->to_remove) {
>> @@ -788,6 +808,8 @@ void mddev_unlock(struct mddev *mddev)
>>          } else
>>                  mutex_unlock(&mddev->reconfig_mutex);
>>
>> +       md_free_rdev(mddev);
>> +
>>          /* As we've dropped the mutex we need a spinlock to
>>           * make sure the thread doesn't disappear
>>           */
>> @@ -2428,13 +2450,6 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
>>          return err;
>>   }
>>
>> -static void rdev_delayed_delete(struct work_struct *ws)
>> -{
>> -       struct md_rdev *rdev = container_of(ws, struct md_rdev, del_work);
>> -       kobject_del(&rdev->kobj);
>> -       kobject_put(&rdev->kobj);
>> -}
>> -
>>   void md_autodetect_dev(dev_t dev);
>>
>>   static void export_rdev(struct md_rdev *rdev)
>> @@ -2452,6 +2467,8 @@ static void export_rdev(struct md_rdev *rdev)
>>
>>   static void md_kick_rdev_from_array(struct md_rdev *rdev)
>>   {
>> +       struct mddev *mddev = rdev->mddev;
>> +
>>          bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
>>          list_del_rcu(&rdev->same_set);
>>          pr_debug("md: unbind<%pg>\n", rdev->bdev);
>> @@ -2465,15 +2482,17 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
>>          rdev->sysfs_unack_badblocks = NULL;
>>          rdev->sysfs_badblocks = NULL;
>>          rdev->badblocks.count = 0;
>> -       /* We need to delay this, otherwise we can deadlock when
>> -        * writing to 'remove' to "dev/state".  We also need
>> -        * to delay it due to rcu usage.
>> -        */
>> +
>>          synchronize_rcu();
>> -       INIT_WORK(&rdev->del_work, rdev_delayed_delete);
>> -       kobject_get(&rdev->kobj);
>> -       queue_work(md_rdev_misc_wq, &rdev->del_work);
>> -       export_rdev(rdev);
>> +
>> +       /*
>> +        * kobject_del() will wait for all in progress writers to be done, where
>> +        * reconfig_mutex is held, hence it can't be called under
>> +        * reconfig_mutex and it's delayed to mddev_unlock().
>> +        */
>> +       mutex_lock(&mddev->delete_mutex);
>> +       list_add(&rdev->same_set, &mddev->deleting);
>> +       mutex_unlock(&mddev->delete_mutex);
>>   }
>>
>>   static void export_array(struct mddev *mddev)
>> @@ -3541,6 +3560,7 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
>>   {
>>          struct rdev_sysfs_entry *entry = container_of(attr, struct rdev_sysfs_entry, attr);
>>          struct md_rdev *rdev = container_of(kobj, struct md_rdev, kobj);
>> +       struct kernfs_node *kn = NULL;
>>          ssize_t rv;
>>          struct mddev *mddev = rdev->mddev;
>>
>> @@ -3548,6 +3568,10 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
>>                  return -EIO;
>>          if (!capable(CAP_SYS_ADMIN))
>>                  return -EACCES;
>> +
>> +       if (entry->store == state_store && cmd_match(page, "remove"))
>> +               kn = sysfs_break_active_protection(kobj, attr);
>> +
>>          rv = mddev ? mddev_lock(mddev) : -ENODEV;
>>          if (!rv) {
>>                  if (rdev->mddev == NULL)
>> @@ -3556,6 +3580,10 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
>>                          rv = entry->store(rdev, page, length);
>>                  mddev_unlock(mddev);
>>          }
>> +
>> +       if (kn)
>> +               sysfs_unbreak_active_protection(kn);
>> +
>>          return rv;
>>   }
>>
>> @@ -4479,20 +4507,6 @@ null_show(struct mddev *mddev, char *page)
>>          return -EINVAL;
>>   }
>>
>> -/* need to ensure rdev_delayed_delete() has completed */
>> -static void flush_rdev_wq(struct mddev *mddev)
>> -{
>> -       struct md_rdev *rdev;
>> -
>> -       rcu_read_lock();
>> -       rdev_for_each_rcu(rdev, mddev)
>> -               if (work_pending(&rdev->del_work)) {
>> -                       flush_workqueue(md_rdev_misc_wq);
>> -                       break;
>> -               }
>> -       rcu_read_unlock();
>> -}
>> -
>>   static ssize_t
>>   new_dev_store(struct mddev *mddev, const char *buf, size_t len)
>>   {
>> @@ -4520,7 +4534,6 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
>>              minor != MINOR(dev))
>>                  return -EOVERFLOW;
>>
>> -       flush_rdev_wq(mddev);
>>          err = mddev_lock(mddev);
>>          if (err)
>>                  return err;
>> @@ -5590,7 +5603,6 @@ struct mddev *md_alloc(dev_t dev, char *name)
>>           * removed (mddev_delayed_delete).
>>           */
>>          flush_workqueue(md_misc_wq);
>> -       flush_workqueue(md_rdev_misc_wq);
>>
>>          mutex_lock(&disks_mutex);
>>          mddev = mddev_alloc(dev);
>> @@ -7553,9 +7565,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
>>
>>          }
>>
>> -       if (cmd == ADD_NEW_DISK || cmd == HOT_ADD_DISK)
>> -               flush_rdev_wq(mddev);
>> -
>>          if (cmd == HOT_REMOVE_DISK)
>>                  /* need to ensure recovery thread has run */
>>                  wait_event_interruptible_timeout(mddev->sb_wait,
>> @@ -9618,10 +9627,6 @@ static int __init md_init(void)
>>          if (!md_misc_wq)
>>                  goto err_misc_wq;
>>
>> -       md_rdev_misc_wq = alloc_workqueue("md_rdev_misc", 0, 0);
>> -       if (!md_rdev_misc_wq)
>> -               goto err_rdev_misc_wq;
>> -
>>          ret = __register_blkdev(MD_MAJOR, "md", md_probe);
>>          if (ret < 0)
>>                  goto err_md;
>> @@ -9640,8 +9645,6 @@ static int __init md_init(void)
>>   err_mdp:
>>          unregister_blkdev(MD_MAJOR, "md");
>>   err_md:
>> -       destroy_workqueue(md_rdev_misc_wq);
>> -err_rdev_misc_wq:
>>          destroy_workqueue(md_misc_wq);
>>   err_misc_wq:
>>          destroy_workqueue(md_wq);
>> @@ -9937,7 +9940,6 @@ static __exit void md_exit(void)
>>          }
>>          spin_unlock(&all_mddevs_lock);
>>
>> -       destroy_workqueue(md_rdev_misc_wq);
>>          destroy_workqueue(md_misc_wq);
>>          destroy_workqueue(md_wq);
>>   }
>> diff --git a/drivers/md/md.h b/drivers/md/md.h
>> index 1eec65cf783c..4d191db831da 100644
>> --- a/drivers/md/md.h
>> +++ b/drivers/md/md.h
>> @@ -531,6 +531,14 @@ struct mddev {
>>          unsigned int                    good_device_nr; /* good device num within cluster raid */
>>          unsigned int                    noio_flag; /* for memalloc scope API */
>>
>> +       /*
>> +        * Temporarily store rdev that will be finally removed when
>> +        * reconfig_mutex is unlocked.
>> +        */
>> +       struct list_head                deleting;
>> +       /* Protect the deleting list */
>> +       struct mutex                    delete_mutex;
>> +
>>          bool    has_superblocks:1;
>>          bool    fail_last_dev:1;
>>          bool    serialize_policy:1;
>> --
>> 2.39.2
>>
> .
> 

