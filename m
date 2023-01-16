Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E2B66B94C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjAPIvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjAPIvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:51:24 -0500
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824482716
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673859080;
        bh=R1MkVwKw4SVD8VGIJsVY3vh0jT3ecgY6xhTPS0PMHGw=;
        h=From:To:Cc:Subject:Date;
        b=mGM+/SqvNW5r8gj0LReSFicbQWyjLLSSgpxQwGGDDsgR+tJrp4oM4V+hrCMouCJjt
         5ypu3IRXjENSRazjJL2Sd/o2kEbWioHNzIQ9ZwSJLKsrRygomsKXr3vYuM9aU2QKgv
         bDglGetYnTVv+nNn6LzeZfJRnQiGYOTi87McQyZo=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id C871FCB7; Mon, 16 Jan 2023 16:50:07 +0800
X-QQ-mid: xmsmtpt1673859007t57b7839j
Message-ID: <tencent_ABA832E296819D1053D6C625ADCAF76BC706@qq.com>
X-QQ-XMAILINFO: N+tZcXNNUKPOz7d0LD9yTwYQiy19jrVBu4JFFzVHpY4SeOf9/tE1JIJZSs03WX
         m+ryEnM9CkwDhuEgoNiwTeWB8lxeOgnCky+hl/ImZiX7VXkWN1wAQAL+EEYrKzLFdg/osIqOVsGT
         9WGtMeuI8eVaY+N8CddcF4yJm1BXjqJ7pEScqoU4MstSrlrRzyfDIwqGmcEA40YfLEgbt05nwCz+
         5+Li96eS4mgMgGkUuXcwLEXfK/iKXhvheVgnUpuZy9YSFeBJcNHP/n479ZrIdOqzyYWj16gVYFuj
         I9SlibgsbEYDja5qeiCeC7pRQpRQn+c245Np52fNPTc7QjPepuaIF7OufaezrPjQNePB2dINRUKg
         EsjbXL3ms8t5gULPaw14EmOO2VTD6utAMeQgPh6p+bOuuQDlFYwchGcLSFcitd5QnAuWPzaWxVvo
         pn0RMG0At4rEPeRYHFsH0zl+qSfez3jo/L3J4Iuh8k7DkCH4NLDq7qLwklF9GZ3vHNXg/prQ07w7
         xsgXiHQQaAE32IZ6ZqRA1aGG5+lPDYD/R6bYcj2nP0fxvtvbWyALkT1J3WH4ZZf7Wrx0do8agfW/
         nh+mqzGYuS9KOvJNwP25xWz7+3FFUgM4DFNt978IZzi2RGrdunJaTJRA/NxUneFtpdZWWLoycalW
         dC+Xtx5/fWKnuECBE0ubdrvhJh71kpkB7lP4+iRRpkKNtxUqXnBypPVapxb1KaBvzVsaO4T+19vd
         uM1lZATnj3icuefl1Hc8Rxc995Yd9oNRP3uy2dc7gjk1RDKfGz4v9wPUvbPPzKOGn7kkvyhZlVKT
         T9FZ97o8QJDA67v2YkoERgoxzz5IxeLXlRbXfVDbrL96vw2RhaKtUOEJmalYc2FHCZXE162svuRn
         7KExYuCKTpZVtI69Kk7693Rhlynqj8eiCxvrDZZm78Vdh1Q5E3LDv+7jxEMOtT+8I3RTj7MysePZ
         419Yb19s3i7/VZ/3GkNnhYVCYBSK7s9QEQcGOotI4=
From:   Rong Tao <rtoax@foxmail.com>
To:     cl@linux.com
Cc:     sdf@google.com, yhs@fb.com, Rong Tao <rongtao@cestc.cn>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-mm@kvack.org (open list:SLAB ALLOCATOR),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mm: Functions used internally should not be put into slub_def.h
Date:   Mon, 16 Jan 2023 16:50:05 +0800
X-OQ-MSGID: <20230116085005.24972-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

commit 40f3bf0cb04c("mm: Convert struct page to struct slab in functions
used by other subsystems") introduce 'slab_address()' and 'struct slab'
in slab_def.h(CONFIG_SLAB) and slub_def.h(CONFIG_SLUB). When referencing
a header file <linux/slub_def.h> in a module or BPF code, 'slab_address()'
and 'struct slab' are not recognized, resulting in incomplete and
undefined errors(see bcc slabratetop.py error [0]).

Moving the function definitions of reference data structures such as
struct slab and slab_address() such as nearest_obj(), obj_to_index(),
and objs_per_slab() to the internal header file slab.h solves this
fatal problem.

[0] https://github.com/iovisor/bcc/issues/4438

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 include/linux/slab_def.h | 33 --------------------
 include/linux/slub_def.h | 32 -------------------
 mm/slab.h                | 66 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 65 deletions(-)

diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index 5834bad8ad78..5658b5fddf9b 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -88,37 +88,4 @@ struct kmem_cache {
 	struct kmem_cache_node *node[MAX_NUMNODES];
 };
 
-static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
-				void *x)
-{
-	void *object = x - (x - slab->s_mem) % cache->size;
-	void *last_object = slab->s_mem + (cache->num - 1) * cache->size;
-
-	if (unlikely(object > last_object))
-		return last_object;
-	else
-		return object;
-}
-
-/*
- * We want to avoid an expensive divide : (offset / cache->size)
- *   Using the fact that size is a constant for a particular cache,
- *   we can replace (offset / cache->size) by
- *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
- */
-static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct slab *slab, void *obj)
-{
-	u32 offset = (obj - slab->s_mem);
-	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
-}
-
-static inline int objs_per_slab(const struct kmem_cache *cache,
-				     const struct slab *slab)
-{
-	if (is_kfence_address(slab_address(slab)))
-		return 1;
-	return cache->num;
-}
-
 #endif	/* _LINUX_SLAB_DEF_H */
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index aa0ee1678d29..660fd6b2a748 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -163,36 +163,4 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
 
 void *fixup_red_left(struct kmem_cache *s, void *p);
 
-static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
-				void *x) {
-	void *object = x - (x - slab_address(slab)) % cache->size;
-	void *last_object = slab_address(slab) +
-		(slab->objects - 1) * cache->size;
-	void *result = (unlikely(object > last_object)) ? last_object : object;
-
-	result = fixup_red_left(cache, result);
-	return result;
-}
-
-/* Determine object index from a given position */
-static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
-					  void *addr, void *obj)
-{
-	return reciprocal_divide(kasan_reset_tag(obj) - addr,
-				 cache->reciprocal_size);
-}
-
-static inline unsigned int obj_to_index(const struct kmem_cache *cache,
-					const struct slab *slab, void *obj)
-{
-	if (is_kfence_address(obj))
-		return 0;
-	return __obj_to_index(cache, slab_address(slab), obj);
-}
-
-static inline int objs_per_slab(const struct kmem_cache *cache,
-				     const struct slab *slab)
-{
-	return slab->objects;
-}
 #endif /* _LINUX_SLUB_DEF_H */
diff --git a/mm/slab.h b/mm/slab.h
index 7cc432969945..38350a0efa91 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -227,10 +227,76 @@ struct kmem_cache {
 
 #ifdef CONFIG_SLAB
 #include <linux/slab_def.h>
+
+static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
+				void *x)
+{
+	void *object = x - (x - slab->s_mem) % cache->size;
+	void *last_object = slab->s_mem + (cache->num - 1) * cache->size;
+
+	if (unlikely(object > last_object))
+		return last_object;
+	else
+		return object;
+}
+
+/*
+ * We want to avoid an expensive divide : (offset / cache->size)
+ *   Using the fact that size is a constant for a particular cache,
+ *   we can replace (offset / cache->size) by
+ *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
+ */
+static inline unsigned int obj_to_index(const struct kmem_cache *cache,
+					const struct slab *slab, void *obj)
+{
+	u32 offset = (obj - slab->s_mem);
+	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
+}
+
+static inline int objs_per_slab(const struct kmem_cache *cache,
+				     const struct slab *slab)
+{
+	if (is_kfence_address(slab_address(slab)))
+		return 1;
+	return cache->num;
+}
 #endif
 
 #ifdef CONFIG_SLUB
 #include <linux/slub_def.h>
+
+static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
+				void *x) {
+	void *object = x - (x - slab_address(slab)) % cache->size;
+	void *last_object = slab_address(slab) +
+		(slab->objects - 1) * cache->size;
+	void *result = (unlikely(object > last_object)) ? last_object : object;
+
+	result = fixup_red_left(cache, result);
+	return result;
+}
+
+/* Determine object index from a given position */
+static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
+					  void *addr, void *obj)
+{
+	return reciprocal_divide(kasan_reset_tag(obj) - addr,
+				 cache->reciprocal_size);
+}
+
+static inline unsigned int obj_to_index(const struct kmem_cache *cache,
+					const struct slab *slab, void *obj)
+{
+	if (is_kfence_address(obj))
+		return 0;
+	return __obj_to_index(cache, slab_address(slab), obj);
+}
+
+static inline int objs_per_slab(const struct kmem_cache *cache,
+				     const struct slab *slab)
+{
+	return slab->objects;
+}
 #endif
 
 #include <linux/memcontrol.h>
-- 
2.39.0

