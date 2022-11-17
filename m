Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930CD62D3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiKQHT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiKQHT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:19:27 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777AB165A4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:19:26 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k7so822138pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2F1Gvqt/Q56rI57EGntvViKlZXpCO31yBDbo9Chm+4=;
        b=OInrjIJb+zpctma3IvYVArFUeiEyzg2eW2VpGlSGYfRa4spB/NJyuFmt9+YkAEbLxD
         eVbAWUV6/QzVBBMBNFk0ZBQ0zbk0XCPap3dKrd+59hpOoVwXbfBgPzuxw8aBAHBkQzVr
         U125oCXOKcMJXCT+FKNHw8WP6uuZxf5UVkpJTF16JXfoUL27tcO6F8nZIBBlc0zKLB07
         3OwYEEW2iVje+2CVhKYSgmZsJr6p9t4fOmLfFwStJYi0HlqTVbNz3vPgG2HYJNe0A70E
         8tw8poGlqSBMcksZmvYaxutCbwqoaT9Yp93dWWYEoZc1B4M11OD5O+QsktO7IjgItdu2
         wlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U2F1Gvqt/Q56rI57EGntvViKlZXpCO31yBDbo9Chm+4=;
        b=lufn2Xz2ePPOOmn1U/inQMn1z4RzlJppynu6vE0RlB7oJY9ln5vD2CTsxWXjOgx1bc
         JLA8WAVoL5o0tXfV2IuYWcffasEvC5I7sLgO1u2y0NMH1Pew6uhOhtJ0BFnqnqkSJliQ
         GK3EiMrI3Q9e0UM+NjbeZ+/hJN1WzFDisEpwFSrvjKDf51yYKkKFdazqEybp4pbUpgfP
         NSjeQhkeNI1qjzWIdhBXC+dSH/jpCvKU4idMqgwYYSYQ8ydFCEPxZUfYX76FaB1fK32F
         yMFKoDMYdB6UCnPF9pkTcexHOFktrCI1H3HCF1ImJFmJvoiGQwbXWyd7bwc0Y33U2Es/
         SLzg==
X-Gm-Message-State: ANoB5pnUGMIyBH6ndAN7k4KqGRCUuJ0ZBftIt0VKtIWtyyg2sk/Vb66b
        CqYF+y3ixd+tmlMtEcdwnOdYzg==
X-Google-Smtp-Source: AA0mqf5wEXQHErhBBGxMw+n4hHa0kstF3CSQkP6tE64hX1AHAC8zFohruy5DaoR1XqwZWrNDiAeJsQ==
X-Received: by 2002:a17:90a:8d14:b0:213:e4:3f57 with SMTP id c20-20020a17090a8d1400b0021300e43f57mr7246449pjo.204.1668669565963;
        Wed, 16 Nov 2022 23:19:25 -0800 (PST)
Received: from [10.68.76.92] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b0017808db132bsm427529pln.137.2022.11.16.23.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 23:19:25 -0800 (PST)
Message-ID: <6433156f-34a8-400f-e282-91268b242279@bytedance.com>
Date:   Thu, 17 Nov 2022 15:19:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
 <20221111112732.30e1696bcd0d5b711c188a9a@linux-foundation.org>
 <a44f794e-fe60-e261-3631-9107822d5c36@bytedance.com>
 <Y3IqLzvduM6HqPJV@dhcp22.suse.cz>
 <3a3b4f5b-14d1-27d8-7727-cf23da90988f@bytedance.com>
 <Y3KFFfMFE55lVdNZ@dhcp22.suse.cz>
 <82c9c89c-aee2-08a3-e562-359631bb0137@bytedance.com>
 <0bd0b744-3d97-b4c3-a4fb-6040f8f8024a@bytedance.com>
 <Y3T6SqZvAmSG5I6W@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Y3T6SqZvAmSG5I6W@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal, thanks for your replay.

> 
> It would be better to add the patch that has been tested.

OK.

> 
> One way to deal with that would be to use a similar model as css_tryget

Percpu_ref is a good way to  reduce memory footprint in fast path.But it
has the potential to make mempolicy heavy. the sizeof mempolicy is 32
bytes and it may not have a long life time, which duplicated from the
parent in fork().If we modify atomic_t to percpu_ref, the efficiency of
reading in fastpath will increase, the efficiency of creation and
deletion will decrease, and the occupied space will increase
significantly.I am not really sure it is worth it.

atomic_t; 4
sizeof(percpu_ref + percpu_ref_data + cpus* unsigned long)
16+56+cpus*8

> 
> Btw. have you tried to profile those slowdowns to identify hotspots?
> 
> Thanks

Yes, it will degrade performance about 2%-%3 may because of the 
task_lock and  atomic operations on the reference count as shown
in the previous email.

new hotspots in perf.
1.34%  [kernel]          [k] __mpol_put
0.53%  [kernel]          [k] _raw_spin_lock
0.44%  [kernel]          [k] get_task_policy


Tested patch.

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a74cdcc9af0..3f1b5c8329a8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -105,10 +105,7 @@ static void hold_task_mempolicy(struct 
proc_maps_private *priv)
  {
         struct task_struct *task = priv->task;

-       task_lock(task);
         priv->task_mempolicy = get_task_policy(task);
-       mpol_get(priv->task_mempolicy);
-       task_unlock(task);
  }
  static void release_task_mempolicy(struct proc_maps_private *priv)
  {
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index d232de7cdc56..786481d7abfd 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -62,7 +62,7 @@ struct mempolicy {
  extern void __mpol_put(struct mempolicy *pol);
  static inline void mpol_put(struct mempolicy *pol)
  {
-       if (pol)
+       if (pol && !(pol->flags & MPOL_F_STATIC))
                 __mpol_put(pol);
  }

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 046d0ccba4cd..7c2068163a0c 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -63,7 +63,7 @@ enum {
  #define MPOL_F_SHARED  (1 << 0)        /* identify shared policies */
  #define MPOL_F_MOF     (1 << 3) /* this policy wants migrate on fault */
  #define MPOL_F_MORON   (1 << 4) /* Migrate On protnone Reference On 
Node */
-
+#define MPOL_F_STATIC (1 << 5)
  /*
   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
   * ABI.  New bits are OK, but existing bits can never change.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 546df97c31e4..4cca96a40d04 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1247,6 +1247,7 @@ static struct page *dequeue_huge_page_vma(struct 
hstate *h,
         }

         mpol_cond_put(mpol);
+       mpol_put(mpol);
         return page;

  err:
@@ -2316,6 +2317,7 @@ struct page 
*alloc_buddy_huge_page_with_mpol(struct hstate *h,
         if (!page)
                 page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
         mpol_cond_put(mpol);
+       mpol_put(mpol);
         return page;
  }

@@ -2352,6 +2354,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, 
struct vm_area_struct *vma,
         node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
         page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
         mpol_cond_put(mpol);
+       mpol_put(mpol);

         return page;
  }
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..ea670db6881f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -126,6 +126,7 @@ enum zone_type policy_zone = 0;
  static struct mempolicy default_policy = {
         .refcnt = ATOMIC_INIT(1), /* never free it */
         .mode = MPOL_LOCAL,
+       .flags = MPOL_F_STATIC
  };

  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
@@ -160,11 +161,19 @@ EXPORT_SYMBOL_GPL(numa_map_to_online_node);

  struct mempolicy *get_task_policy(struct task_struct *p)
  {
-       struct mempolicy *pol = p->mempolicy;
+       struct mempolicy *pol;
         int node;

-       if (pol)
-               return pol;
+       if (p->mempolicy)
+       {
+               task_lock(p);
+               pol = p->mempolicy;
+               mpol_get(pol);
+               task_unlock(p);
+
+               if(pol)
+                       return pol;
+       }

         node = numa_node_id();
         if (node != NUMA_NO_NODE) {
@@ -1764,10 +1773,12 @@ struct mempolicy *__get_vma_policy(struct 
vm_area_struct *vma,
                          * a pseudo vma whose vma->vm_ops=NULL. Take a 
reference
                          * count on these policies which will be dropped by
                          * mpol_cond_put() later
+                        *
+                        * if (mpol_needs_cond_ref(pol))
+                        *      mpol_get(pol);
                          */
-                       if (mpol_needs_cond_ref(pol))
-                               mpol_get(pol);
                 }
+               mpol_get(pol);
         }

         return pol;
@@ -1799,9 +1810,9 @@ static struct mempolicy *get_vma_policy(struct 
vm_area_struct *vma,
  bool vma_policy_mof(struct vm_area_struct *vma)
  {
         struct mempolicy *pol;
+       bool ret = false;

         if (vma->vm_ops && vma->vm_ops->get_policy) {
-               bool ret = false;

                 pol = vma->vm_ops->get_policy(vma, vma->vm_start);
                 if (pol && (pol->flags & MPOL_F_MOF))
@@ -1812,10 +1823,13 @@ bool vma_policy_mof(struct vm_area_struct *vma)
         }

         pol = vma->vm_policy;
+       mpol_get(pol);
         if (!pol)
                 pol = get_task_policy(current);
+       ret = pol && (pol->flags & MPOL_F_MOF);
+       mpol_put(pol);

-       return pol->flags & MPOL_F_MOF;
+       return ret;
  }

  bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
@@ -2179,7 +2193,6 @@ struct folio *vma_alloc_folio(gfp_t gfp, int 
order, struct vm_area_struct *vma,
                 unsigned nid;

                 nid = interleave_nid(pol, vma, addr, PAGE_SHIFT + order);
-               mpol_cond_put(pol);
                 gfp |= __GFP_COMP;
                 page = alloc_page_interleave(gfp, order, nid);
                 if (page && order > 1)
@@ -2194,7 +2207,6 @@ struct folio *vma_alloc_folio(gfp_t gfp, int 
order, struct vm_area_struct *vma,
                 node = policy_node(gfp, pol, node);
                 gfp |= __GFP_COMP;
                 page = alloc_pages_preferred_many(gfp, order, node, pol);
-               mpol_cond_put(pol);
                 if (page && order > 1)
                         prep_transhuge_page(page);
                 folio = (struct folio *)page;
@@ -2219,7 +2231,6 @@ struct folio *vma_alloc_folio(gfp_t gfp, int 
order, struct vm_area_struct *vma,

                 nmask = policy_nodemask(gfp, pol);
                 if (!nmask || node_isset(hpage_node, *nmask)) {
-                       mpol_cond_put(pol);
                         /*
                          * First, try to allocate THP only on local 
node, but
                          * don't reclaim unnecessarily, just compact.
@@ -2244,8 +2255,9 @@ struct folio *vma_alloc_folio(gfp_t gfp, int 
order, struct vm_area_struct *vma,
         nmask = policy_nodemask(gfp, pol);
         preferred_nid = policy_node(gfp, pol, node);
         folio = __folio_alloc(gfp, order, preferred_nid, nmask);
-       mpol_cond_put(pol);
  out:
+       mpol_cond_put(pol);
+       mpol_put(pol);
         return folio;
  }
  EXPORT_SYMBOL(vma_alloc_folio);
@@ -2286,6 +2298,7 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
                                 policy_node(gfp, pol, numa_node_id()),
                                 policy_nodemask(gfp, pol));

+       mpol_put(pol);
         return page;
  }
  EXPORT_SYMBOL(alloc_pages);
@@ -2365,21 +2378,23 @@ unsigned long 
alloc_pages_bulk_array_mempolicy(gfp_t gfp,
                 unsigned long nr_pages, struct page **page_array)
  {
         struct mempolicy *pol = &default_policy;
+       unsigned long allocated;

         if (!in_interrupt() && !(gfp & __GFP_THISNODE))
                 pol = get_task_policy(current);

-       if (pol->mode == MPOL_INTERLEAVE)
-               return alloc_pages_bulk_array_interleave(gfp, pol,
+       if (pol->mode == MPOL_INTERLEAVE) {
+               allocated =  alloc_pages_bulk_array_interleave(gfp, pol,
                                                          nr_pages, 
page_array);
-
-       if (pol->mode == MPOL_PREFERRED_MANY)
-               return alloc_pages_bulk_array_preferred_many(gfp,
+       } else if (pol->mode == MPOL_PREFERRED_MANY)
+               allocated = alloc_pages_bulk_array_preferred_many(gfp,
                                 numa_node_id(), pol, nr_pages, page_array);
-
-       return __alloc_pages_bulk(gfp, policy_node(gfp, pol, 
numa_node_id()),
+       else
+              allocated = __alloc_pages_bulk(gfp, policy_node(gfp, pol, 
numa_node_id()),
                                   policy_nodemask(gfp, pol), nr_pages, 
NULL,
                                   page_array);
+       mpol_put(pol);
+       return allocated;
  }

  int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
@@ -2636,6 +2651,7 @@ int mpol_misplaced(struct page *page, struct 
vm_area_struct *vma, unsigned long
                 ret = polnid;
  out:
         mpol_cond_put(pol);
+       mpol_put(pol);

         return ret;
  }
@@ -2917,7 +2933,7 @@ void __init numa_policy_init(void)
                 preferred_node_policy[nid] = (struct mempolicy) {
                         .refcnt = ATOMIC_INIT(1),
                         .mode = MPOL_PREFERRED,
-                       .flags = MPOL_F_MOF | MPOL_F_MORON,
+                       .flags = MPOL_F_MOF | MPOL_F_MORON | MPOL_F_STATIC,
                         .nodes = nodemask_of_node(nid),
                 };
         }
