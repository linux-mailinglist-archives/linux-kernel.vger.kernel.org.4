Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D87B746853
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 06:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGDEVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 00:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGDEVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:21:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084EDE6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 21:20:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b3ecb17721so8320025ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 21:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688444450; x=1691036450;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQygWmEkN5we1RDXz7pkswh4Aib1XAu/CfaGHRydgSY=;
        b=XeuQJZi5Fn6Y2V9hGSigVM6DlY0AfUTIFIISI4oYWBRMzWCz140HUa7CQjaNBi14bE
         cHtd8fLDIrCGQBIfQGMwnS/brInUQYbP7hBcfyGRIQ1PjMp/HYkTtUH566cUrbR/ECQ/
         xgdHBwtI/eZZjW8JzcYMKGfCZEk7y3wKjAqCcQ/GPr5gBl0a/ckeJOpen9Ef2juxuc3/
         wEqaGSNOBlDbpHGogDBoCGy9PU9WR6GNvGNEKT/s6Kr2TWWm2I0aMPMLKNDBQdCYrtki
         T6Etm7ZpcAKi7am901F1VomiYro58/OdqGB/tQsJF9HxpWuWHjmLtutUj9PpgNQY85My
         tCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688444450; x=1691036450;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQygWmEkN5we1RDXz7pkswh4Aib1XAu/CfaGHRydgSY=;
        b=OY67z5Ywg5y/uIfe+njU3KrqxvwfYgvyu7bv8IcRLZHTYqT06vMRp+11HMHwF788u+
         wnBXBKE3WAHiQhcu6pdRfDZltz8Ey1ibpreqT/Q5GVq/I9HVYkYffM7mOCWrEKglDg/f
         9p7W1d82Ivv1yGl8Tn/rhieF+0oez9GPN1W/SAYClE3vKigOPjf6vVs4xJyuCq3Gspjm
         4dBgGoKsR5iB+ZCwqDW2tlq8WjUdOHuTTdbdAGUD1wvn8PGiaTNX2SPCYola347VgEry
         h0U8JbGux8uFHcSzCIyOPB/3QknWo8+bgWXi0Owp5GQfRuavLjUtNpKn3cA5qSif4WfW
         Caeg==
X-Gm-Message-State: ABy/qLZq0Z55QdIyPhS0YDUk0Oo8lfebl97JuOlhq8xySCZ358lXWB9v
        7PYVfSQ2EjY/S6p1x5SA9Rc2hg==
X-Google-Smtp-Source: APBJJlGoap5rgOO/5AFt7nvyzJipf1m4SqVj/7RLWlsyusW9U2QREChVOt6WzCmgKb9akbjSddWJzw==
X-Received: by 2002:a17:903:94:b0:1ac:40f7:8b5a with SMTP id o20-20020a170903009400b001ac40f78b5amr12672869pld.3.1688444450336;
        Mon, 03 Jul 2023 21:20:50 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001b8918da8d1sm3233936plj.80.2023.07.03.21.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 21:20:49 -0700 (PDT)
Message-ID: <38b14080-4ce5-d300-8a0a-c630bca6806b@bytedance.com>
Date:   Tue, 4 Jul 2023 12:20:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 24/29] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     paulmck@kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        djwong@kernel.org, brauner@kernel.org, tytso@mit.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
 <20230622085335.77010-25-zhengqi.arch@bytedance.com>
 <cf0d9b12-6491-bf23-b464-9d01e5781203@suse.cz>
 <ZJU708VIyJ/3StAX@dread.disaster.area>
 <a21047bb-3b87-a50a-94a7-f3fa4847bc08@bytedance.com>
 <ZJYaYv4pACmCaBoT@dread.disaster.area>
 <a7baf44a-1eb8-d4e1-d112-93cf9cdb7beb@bytedance.com>
In-Reply-To: <a7baf44a-1eb8-d4e1-d112-93cf9cdb7beb@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 2023/6/24 19:08, Qi Zheng wrote:
> Hi Dave,
> 
> On 2023/6/24 06:19, Dave Chinner wrote:
>> On Fri, Jun 23, 2023 at 09:10:57PM +0800, Qi Zheng wrote:
>>> On 2023/6/23 14:29, Dave Chinner wrote:
>>>> On Thu, Jun 22, 2023 at 05:12:02PM +0200, Vlastimil Babka wrote:
>>>>> On 6/22/23 10:53, Qi Zheng wrote:
>>>> Yes, I suggested the IDR route because radix tree lookups under RCU
>>>> with reference counted objects are a known safe pattern that we can
>>>> easily confirm is correct or not.  Hence I suggested the unification
>>>> + IDR route because it makes the life of reviewers so, so much
>>>> easier...
>>>
>>> In fact, I originally planned to try the unification + IDR method you
>>> suggested at the beginning. But in the case of CONFIG_MEMCG disabled,
>>> the struct mem_cgroup is not even defined, and root_mem_cgroup and
>>> shrinker_info will not be allocated.  This required more code 
>>> changes, so
>>> I ended up keeping the shrinker_list and implementing the above pattern.
>>
>> Yes. Go back and read what I originally said needed to be done
>> first. In the case of CONFIG_MEMCG=n, a dummy root memcg still needs
>> to exist that holds all of the global shrinkers. Then shrink_slab()
>> is only ever passed a memcg that should be iterated.
>>
>> Yes, it needs changes external to the shrinker code itself to be
>> made to work. And even if memcg's are not enabled, we can still use
>> the memcg structures to ensure a common abstraction is used for the
>> shrinker tracking infrastructure....
> 
> Yeah, what I imagined before was to define a more concise struct
> mem_cgroup in the case of CONFIG_MEMCG=n, then allocate a dummy root
> memcg on system boot:
> 
> #ifdef !CONFIG_MEMCG
> 
> struct shrinker_info {
>      struct rcu_head rcu;
>      atomic_long_t *nr_deferred;
>      unsigned long *map;
>      int map_nr_max;
> };
> 
> struct mem_cgroup_per_node {
>      struct shrinker_info __rcu    *shrinker_info;
> };
> 
> struct mem_cgroup {
>      struct mem_cgroup_per_node *nodeinfo[];
> };
> 
> #endif

These days I tried doing this:

1. CONFIG_MEMCG && !mem_cgroup_disabled()

    track all global shrinkers with root_mem_cgroup.

2. CONFIG_MEMCG && mem_cgroup_disabled()

    the root_mem_cgroup is also allocated in this case, so still use
    root_mem_cgroup to track all global shrinkers.

3. !CONFIG_MEMCG

    allocate a dummy memcg during system startup (after cgroup_init())
    and use it to track all global shrinkers

This works, but needs to modify the startup order of some subsystems,
because some shrinkers will be registered before root_mem_cgroup is
allocated, such as:

1. rcu-kfree shrinker in rcu_init()
2. super block shrinkers in vfs_caches_init()

And cgroup_init() also depends on some file system infrastructure, so
I made some changes (rough and unorganized):

diff --git a/fs/namespace.c b/fs/namespace.c
index e157efc54023..6a12d3d0064e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4706,7 +4706,7 @@ static void __init init_mount_tree(void)

  void __init mnt_init(void)
  {
-       int err;
+       //int err;

         mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct mount),
                         0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, 
NULL);
@@ -4725,15 +4725,7 @@ void __init mnt_init(void)
         if (!mount_hashtable || !mountpoint_hashtable)
                 panic("Failed to allocate mount hash table\n");

-       kernfs_init();
-
-       err = sysfs_init();
-       if (err)
-               printk(KERN_WARNING "%s: sysfs_init error: %d\n",
-                       __func__, err);
-       fs_kobj = kobject_create_and_add("fs", NULL);
-       if (!fs_kobj)
-               printk(KERN_WARNING "%s: kobj create error\n", __func__);
         shmem_init();
         init_rootfs();
         init_mount_tree();
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 7d9c2a63b7cd..d87c67f6f66e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -119,6 +119,7 @@ static inline void call_rcu_hurry(struct rcu_head 
*head, rcu_callback_t func)

  /* Internal to kernel */
  void rcu_init(void);
+void rcu_shrinker_init(void);
  extern int rcu_scheduler_active;
  void rcu_sched_clock_irq(int user);
  void rcu_report_dead(unsigned int cpu);
diff --git a/init/main.c b/init/main.c
index ad920fac325c..4190fc6d10ad 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1049,14 +1049,22 @@ void start_kernel(void)
         security_init();
         dbg_late_init();
         net_ns_init();
+       kernfs_init();
+       if (sysfs_init())
+               printk(KERN_WARNING "%s: sysfs_init error\n",
+                       __func__);
+       fs_kobj = kobject_create_and_add("fs", NULL);
+       if (!fs_kobj)
+               printk(KERN_WARNING "%s: kobj create error\n", __func__);
+       proc_root_init();
+       cgroup_init();
         vfs_caches_init();
         pagecache_init();
         signals_init();
         seq_file_init();
-       proc_root_init();
         nsfs_init();
         cpuset_init();
-       cgroup_init();
+       rcu_shrinker_init();
         taskstats_init_early();
         delayacct_init();

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d068ce3567fc..71a04ae8defb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4953,7 +4953,10 @@ static void __init kfree_rcu_batch_init(void)
                 INIT_DELAYED_WORK(&krcp->page_cache_work, 
fill_page_cache_func);
                 krcp->initialized = true;
         }
+}

+void __init rcu_shrinker_init(void)
+{
         kfree_rcu_shrinker = shrinker_alloc(0, "rcu-kfree");
         if (!kfree_rcu_shrinker) {
                 pr_err("Failed to allocate kfree_rcu() shrinker!\n");

I adjusted it step by step according to the errors reported, and there
may be hidden problems (needs more review and testing).

In addition, unifying the processing of global and memcg slab shrink
does have many benefits:

1. shrinker::nr_deferred can be removed
2. shrinker_list can be removed
3. simplifies the existing code logic and subsequent lockless processing

But I'm still a bit apprehensive about modifying the boot order. :(

What do you think about this?

Thanks,
Qi


> 
> But I have a concern: if all global shrinkers are tracking with the
> info->map of root memcg, a shrinker->id needs to be assigned to them,
> which will cause info->map_nr_max to become larger than before, then
> making the traversal of info->map slower.
> 
>>
>>> If the above pattern is not safe, I will go back to the unification +
>>> IDR method.
>>
>> And that is exactly how we got into this mess in the first place....
> 
> I only found one similar pattern in the kernel:
> 
> fs/smb/server/oplock.c:find_same_lease_key/smb_break_all_levII_oplock/lookup_lease_in_table
> 
> But IIUC, the refcount here needs to be decremented after holding
> rcu lock as I did above.
> 
> So regardless of whether we choose unification + IDR in the end, I still
> want to confirm whether the pattern I implemented above is safe. :)
> 
> Thanks,
> Qi
> 
>>
>> -Dave
