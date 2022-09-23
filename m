Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378CE5E758F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiIWISm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiIWISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:18:39 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558064E853
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:18:36 -0700 (PDT)
Date:   Fri, 23 Sep 2022 17:18:27 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663921114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6upSXBJLMhKZpE2evjezlcBk7TD7ZtUUvTObEbiXTq0=;
        b=IvTGKCHp/Gmb+0q8QNzcoO8KC28UH5zIu01DT706O+l2+l1pI81tnqpRItUUUqgVwhBMPz
        vdedmjWA8MQf1eoG4/EdFA3IXBqR5WgXRy43cRwsOnzgFfy24OX/iNGt7ZZqqEEuhiWZqI
        g0fpcL7uy3kzJ4cAXZgVCGKBtkaT754=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     kernel test robot <lkp@intel.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [ammarfaizi2-block:akpm/mm/mm-unstable 480/484]
 drivers/base/memory.c:186:34: error: 'struct memory_block' has no member
 named 'nr_hwpoison'
Message-ID: <20220923081827.GA1357512@ik1-406-35019.vs.sakura.ne.jp>
References: <202209231134.tnhKHRfg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202209231134.tnhKHRfg-lkp@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:00:13PM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block akpm/mm/mm-unstable
> head:   1dee68cfead9a3a85e244a274b4e85620abd5331
> commit: 69b496f03bb46c7ce743aff0d976c078d753d6d6 [480/484] mm/hwpoison: introduce per-memory_block hwpoison counter
> config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220923/202209231134.tnhKHRfg-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/ammarfaizi2/linux-block/commit/69b496f03bb46c7ce743aff0d976c078d753d6d6
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block akpm/mm/mm-unstable
>         git checkout 69b496f03bb46c7ce743aff0d976c078d753d6d6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/base/memory.c: In function 'memory_block_online':
> >> drivers/base/memory.c:186:34: error: 'struct memory_block' has no member named 'nr_hwpoison'
>      186 |         if (atomic_long_read(&mem->nr_hwpoison))
>          |                                  ^~
>    drivers/base/memory.c: In function 'remove_memory_block_devices':
>    drivers/base/memory.c:870:61: error: 'struct memory_block' has no member named 'nr_hwpoison'
>      870 |                 clear_hwpoisoned_pages(atomic_long_read(&mem->nr_hwpoison));
>          |                                                             ^~
> 

Thanks for the report, I should've used the accessor memblk_nr_poison()
to acccess to ->nr_hwpoison.  The following diff should fix this.

Thanks,
Naoya Horiguchi
---
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index c9bde4c4ffdf..f470bbfc68d0 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -183,7 +183,7 @@ static int memory_block_online(struct memory_block *mem)
 	struct zone *zone;
 	int ret;
 
-	if (atomic_long_read(&mem->nr_hwpoison))
+	if (memblk_nr_poison(start_pfn))
 		return -EHWPOISON;
 
 	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
@@ -867,7 +867,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 		mem = find_memory_block_by_id(block_id);
 		if (WARN_ON_ONCE(!mem))
 			continue;
-		clear_hwpoisoned_pages(atomic_long_read(&mem->nr_hwpoison));
+		clear_hwpoisoned_pages(memblk_nr_poison(start));
 		unregister_memory_block_under_nodes(mem);
 		remove_memory_block(mem);
 	}
@@ -1199,4 +1199,9 @@ unsigned long memblk_nr_poison(unsigned long pfn)
 	return 0;
 }
 
+#else
+unsigned long memblk_nr_poison(unsigned long pfn)
+{
+	return 0;
+}
 #endif
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2fe42bb9a517..5445943bbb4b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3282,7 +3282,6 @@ extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 extern void num_poisoned_pages_inc(unsigned long pfn);
 extern void memblk_nr_poison_inc(unsigned long pfn);
 extern void memblk_nr_poison_sub(unsigned long pfn, long i);
-extern unsigned long memblk_nr_poison(unsigned long pfn);
 extern void clear_hwpoisoned_pages(long nr_poison);
 #else
 static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
@@ -3298,6 +3297,7 @@ static inline void clear_hwpoisoned_pages(long nr_poison)
 {
 }
 #endif
+extern unsigned long memblk_nr_poison(unsigned long pfn);
 
 #ifndef arch_memory_failure
 static inline int arch_memory_failure(unsigned long pfn, int flags)
