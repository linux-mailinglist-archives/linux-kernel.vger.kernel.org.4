Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C89718FD9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjFABHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjFABHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:07:14 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 18:07:10 PDT
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D65119;
        Wed, 31 May 2023 18:07:10 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4e18:0:640:bf32:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id DF30E5F08E;
        Thu,  1 Jun 2023 03:57:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id AvBYmkxDemI0-xmefqHym;
        Thu, 01 Jun 2023 03:57:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1685581032;
        bh=jwTFdF6Jc4HXQmg9VAOI45bTrfpn1DcuZsOOAkfIXxs=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=n3xuoI4yrBr8y+ddKMSfKazGR+ICb6Pkvg45czOq93hr+jLSnXjhZz+zxw/9NQQfV
         zIaXgvhlUPK+AXWZwlOt3EXFgR56Y5sk35If3hLD7P0BwZI/gWCOwyXwykM9VxTLjB
         nhY68N26vN2DkAN7yKAtMifojqO7BrnBI+bFDnJ8=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <bab60fe4-964c-43a6-ecce-4cbd4981d875@ya.ru>
Date:   Thu, 1 Jun 2023 03:57:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [linus:master] [mm] f95bdb700b: stress-ng.ramfs.ops_per_sec
 -88.8% regression
To:     Qi Zheng <qi.zheng@linux.dev>, paulmck@kernel.org
Cc:     RCU <rcu@vger.kernel.org>, Yujie Liu <yujie.liu@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
References: <202305230837.db2c233f-yujie.liu@intel.com>
 <eba38fce-2454-d7a4-10ef-240b4686f23d@linux.dev>
 <ZG29ULGNJdErnatI@yujie-X299>
 <896bbb09-d400-ec73-ba3a-b64c6e9bbe46@linux.dev>
 <e5fb8b34-c1ad-92e0-e7e5-f7ed1605dbc6@linux.dev>
 <bfb36563-fac9-4c84-96db-87dd28892088@linux.dev>
 <be04dc3e-a671-ec70-6cf6-70dc702f4184@linux.dev>
 <44407892-b7bc-4d6c-8e4a-6452f0ee88b9@paulmck-laptop>
 <d4b1599d-14c1-071c-6205-09fe60f2ed8b@linux.dev>
 <095806f1-f7f0-4914-b04b-c874fb25bb83@paulmck-laptop>
 <26da75a6-115f-a17a-73bb-381a6b4a3a75@linux.dev>
Content-Language: en-US
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <26da75a6-115f-a17a-73bb-381a6b4a3a75@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30.05.2023 06:07, Qi Zheng wrote:
> Hi,
> 
> On 2023/5/29 20:51, Paul E. McKenney wrote:
>> On Mon, May 29, 2023 at 10:39:21AM +0800, Qi Zheng wrote:
> 
> [...]
> 
>>>
>>> Thanks for such a detailed explanation.
>>>
>>> Now I think we can continue to try to complete the idea[1] from
>>> Kirill Tkhai. The patch moves heavy synchronize_srcu() to delayed
>>> work, so it doesn't affect on user-visible unregistration speed.
>>>
>>> [1]. https://lore.kernel.org/lkml/153365636747.19074.12610817307548583381.stgit@localhost.localdomain/
>>
>> A blast from the past!  ;-)
>>
>> But yes, moving the long-latency synchronize_srcu() off the user-visible
>> critical code path can be even better.
> 
> Yeah, I applied these patches  ([PATCH RFC 04/10]~[PATCH RFC 10/10],
> with few conflicts), the ops/s does get back to the previous levels.
> 
> I'll continue updating this patchset after doing more testing.

You may also fix the issue using the below generic solution.

In addition to this we need patch, which calls unregister_shrinker_delayed_initiate()
instead of unregister_shrinker() in deactivate_locked_super(), and calls
unregister_shrinker_delayed_finalize() from destroy_super_work(). Compilation tested only.

---
 include/linux/shrinker.h |  2 ++
 mm/vmscan.c              | 38 ++++++++++++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 224293b2dd06..4ba2986716d3 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -4,6 +4,7 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
+#include <linux/rwsem.h>
 
 /*
  * This struct is used to pass information from page reclaim to the shrinkers.
@@ -83,6 +84,7 @@ struct shrinker {
 #endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
+	struct rw_semaphore rwsem;
 };
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index eeca83e28c9b..19fc129771ce 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -706,6 +706,7 @@ static int __prealloc_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
+	init_rwsem(&shrinker->rwsem);
 	return 0;
 }
 
@@ -757,7 +758,9 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	mutex_lock(&shrinker_mutex);
 	list_add_tail_rcu(&shrinker->list, &shrinker_list);
+	down_write(&shrinker->rwsem);
 	shrinker->flags |= SHRINKER_REGISTERED;
+	up_write(&shrinker->rwsem);
 	shrinker_debugfs_add(shrinker);
 	mutex_unlock(&shrinker_mutex);
 }
@@ -802,7 +805,7 @@ EXPORT_SYMBOL(register_shrinker);
 /*
  * Remove one
  */
-void unregister_shrinker(struct shrinker *shrinker)
+void unregister_shrinker_delayed_initiate(struct shrinker *shrinker)
 {
 	struct dentry *debugfs_entry;
 	int debugfs_id;
@@ -812,20 +815,33 @@ void unregister_shrinker(struct shrinker *shrinker)
 
 	mutex_lock(&shrinker_mutex);
 	list_del_rcu(&shrinker->list);
+	down_write(&shrinker->rwsem);
 	shrinker->flags &= ~SHRINKER_REGISTERED;
+	up_write(&shrinker->rwsem);
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
 	mutex_unlock(&shrinker_mutex);
 
+	shrinker_debugfs_remove(debugfs_entry, debugfs_id); // This is moved in your patch
+}
+EXPORT_SYMBOL(unregister_shrinker_delayed_initiate);
+
+void unregister_shrinker_delayed_finalize(struct shrinker *shrinker)
+{
 	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
 
-	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
-
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
+EXPORT_SYMBOL(unregister_shrinker_delayed_finalize);
+
+void unregister_shrinker(struct shrinker *shrinker)
+{
+	unregister_shrinker_delayed_initiate(shrinker);
+	unregister_shrinker_delayed_finalize(shrinker);
+}
 EXPORT_SYMBOL(unregister_shrinker);
 
 /**
@@ -856,9 +872,14 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 					  : SHRINK_BATCH;
 	long scanned = 0, next_deferred;
 
+	down_read(&shrinker->rwsem);
+	if (!(shrinker->flags & SHRINKER_REGISTERED))
+		goto unlock;
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
-	if (freeable == 0 || freeable == SHRINK_EMPTY)
-		return freeable;
+	if (freeable == 0 || freeable == SHRINK_EMPTY) {
+		freed = freeable;
+		goto unlock;
+	}
 
 	/*
 	 * copy the current shrinker scan count into a local variable
@@ -935,6 +956,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	 * manner that handles concurrent updates.
 	 */
 	new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
+unlock:
+	up_read(&shrinker->rwsem);
 
 	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
 	return freed;
@@ -968,9 +991,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		struct shrinker *shrinker;
 
 		shrinker = idr_find(&shrinker_idr, i);
-		if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
-			if (!shrinker)
-				clear_bit(i, info->map);
+		if (unlikely(!shrinker)) {
+			clear_bit(i, info->map);
 			continue;
 		}
 


