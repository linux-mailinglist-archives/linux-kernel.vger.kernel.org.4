Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C2D5FC46A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJLLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJLLol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:44:41 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9459AF41
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 04:44:38 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221012114433epoutp0471e8966d0fec9047980c819c2c2c55a3~dT7RjEAlH2682926829epoutp04g
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:44:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221012114433epoutp0471e8966d0fec9047980c819c2c2c55a3~dT7RjEAlH2682926829epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665575073;
        bh=UufJyg2PI/ZyXKKoeZVtIkjKAjo+Ytd/0dZ8TWXNLwA=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=VWftrKD9K5Q1HY8IZQMoGZbC47WgU6XQwp6TCyjRFzc1ni2IT0D00tkOz14JiqmcL
         cE5TuOCC8Nj2zsP3b4Ak46qxBTnOwTVrotfVXD0NHEEWXA/ca2SQ6JgAv9TTthrZ7F
         gzEVEdWWjJdGsrRt4lw4mz9XPDidJSJs/mUq0N3s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20221012114433epcas2p1bce86b0c75673b1e44cb28409091fdc3~dT7ROH91o0477004770epcas2p1Z;
        Wed, 12 Oct 2022 11:44:33 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MnW5r3mPpz4x9Pw; Wed, 12 Oct
        2022 11:44:32 +0000 (GMT)
X-AuditID: b6c32a47-873ff70000002127-b5-6346a8a0091b
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.E5.08487.0A8A6436; Wed, 12 Oct 2022 20:44:32 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] mm: Fix a pointer coding style in linux/mm.h
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20221012114431epcms2p300e2de357b68c9ae0a04a60b34f3dc18@epcms2p3>
Date:   Wed, 12 Oct 2022 20:44:31 +0900
X-CMS-MailID: 20221012114431epcms2p300e2de357b68c9ae0a04a60b34f3dc18
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmqe6CFW7JBqdfSVjMWb+GzeLyrjls
        FvfW/Ge1mHr+CJMDi8emT5PYPU7M+M3i0bdlFaPH501yASxR2TYZqYkpqUUKqXnJ+SmZeem2
        St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QCuVFMoSc0qBQgGJxcVK+nY2RfmlJakK
        GfnFJbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZd3bbFzyQrbjw8z5bA+MriS5G
        Tg4JAROJGYd2M3cxcnEICexglNg08T57FyMHB6+AoMTfHcIgNcICthKXrs1gB7GFBJQkrh3o
        ZYGI60tsXrwMLM4moCvxd8NydpA5IgIrGSU23/vIArGAV2JG+1MoW1pi+/KtjBC2hsSPZb3M
        ELaoxM3Vb9lh7PfH5kPViEi03jsLVSMo8eDnbqi4pMSiQ+eZIOx8ib8rrrNB2DUSWxvaoOL6
        Etc6NrJA/OIrsewgD0iYRUBVYvqsjVBjXCRaPvwHa2UWkJfY/nYOM0g5s4CmxPpd+iCmhICy
        xJFbLBAVfBIdh/+ywzy1Y94TqEVqEps3bWaFsGUkLjxug5ruIXHyWCcrJNQCJS73LmOewCg/
        CxG2s5DsnYWwdwEj8ypGsdSC4tz01GKjAmN4bCbn525iBCc3LfcdjDPeftA7xMjEwXiIUYKD
        WUmE1yXELVmINyWxsiq1KD++qDQntfgQoynQxxOZpUST84HpNa8k3tDE0sDEzMzQ3MjUwFxJ
        nLdrhlaykEB6YklqdmpqQWoRTB8TB6dUA5PvxoxSBc741OYwwZc3H4uvij5wJnf2NhXTt7vL
        F0UIsSzeoa/6K/Ra+R61x4KL1tjqu9TKdes/31yeY3fkuSd7wU/l9Tv3dUwxMNy0a55iT8uF
        8O6N07uEFp6y1VujZStoFDz9qUyW6id2i1NbLX+ZXz2kKesRn/6hkuHoLs6AfyF/04P2T93U
        w5vrb72vafpN96Yz+/et7vOp01lluu3jCQ8dDp5YyeWaVya9b9x6xLKiPm99tG5Cza+CGw7b
        56T7Hr7TqeCZ6BaXtDn/ofSziOr310r8BdLum2dUz/ipel2y4vML8Zqn69xE1vJnRZS6Mqbx
        VklatJcbHf1rGFxZoPTGojLncMa8GfkCSizFGYmGWsxFxYkAhSdvsfcDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221012114431epcms2p300e2de357b68c9ae0a04a60b34f3dc18
References: <CGME20221012114431epcms2p300e2de357b68c9ae0a04a60b34f3dc18@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove white space after pointer in linux/mm.h

Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
---
 include/linux/mm.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..d0c79446247c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -72,7 +72,7 @@ static inline void totalram_pages_add(long count)
 	atomic_long_add(count, &_totalram_pages);
 }
 
-extern void * high_memory;
+extern void *high_memory;
 extern int page_cluster;
 
 #ifdef CONFIG_SYSCTL
@@ -537,12 +537,12 @@ enum page_entry_size {
  * to the functions called when a no-page or a wp-page exception occurs.
  */
 struct vm_operations_struct {
-	void (*open)(struct vm_area_struct * area);
+	void (*open)(struct vm_area_struct *area);
 	/**
 	 * @close: Called when the VMA is being removed from the MM.
 	 * Context: User context.  May sleep.  Caller holds mmap_lock.
 	 */
-	void (*close)(struct vm_area_struct * area);
+	void (*close)(struct vm_area_struct *area);
 	/* Called any time before splitting to check if it's allowed */
 	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
 	int (*mremap)(struct vm_area_struct *area);
@@ -558,7 +558,7 @@ struct vm_operations_struct {
 			enum page_entry_size pe_size);
 	vm_fault_t (*map_pages)(struct vm_fault *vmf,
 			pgoff_t start_pgoff, pgoff_t end_pgoff);
-	unsigned long (*pagesize)(struct vm_area_struct * area);
+	unsigned long (*pagesize)(struct vm_area_struct *area);
 
 	/* notification that a previously read-only page is about to become
 	 * writable, if an error is returned it will cause a SIGBUS */
@@ -920,7 +920,7 @@ enum compound_dtor_id {
 #endif
 	NR_COMPOUND_DTORS,
 };
-extern compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS];
+extern compound_page_dtor *const compound_page_dtors[NR_COMPOUND_DTORS];
 
 static inline void set_compound_page_dtor(struct page *page,
 		enum compound_dtor_id compound_dtor)
@@ -2597,7 +2597,7 @@ static inline void show_mem(unsigned int flags, nodemask_t *nodemask)
 	__show_mem(flags, nodemask, MAX_NR_ZONES - 1);
 }
 extern long si_mem_available(void);
-extern void si_meminfo(struct sysinfo * val);
+extern void si_meminfo(struct sysinfo *val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
 #ifdef __HAVE_ARCH_RESERVED_KERNEL_PAGES
 extern unsigned long arch_reserved_kernel_pages(void);
@@ -2793,8 +2793,8 @@ extern int expand_upwards(struct vm_area_struct *vma, unsigned long address);
 #endif
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
-extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
-extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned long addr,
+extern struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr);
+extern struct vm_area_struct *find_vma_prev(struct mm_struct *mm, unsigned long addr,
 					     struct vm_area_struct **pprev);
 
 /*
@@ -3220,7 +3220,7 @@ void drop_slab(void);
 extern int randomize_va_space;
 #endif
 
-const char * arch_vma_name(struct vm_area_struct *vma);
+const char *arch_vma_name(struct vm_area_struct *vma);
 #ifdef CONFIG_MMU
 void print_vma_addr(char *prefix, unsigned long rip);
 #else
@@ -3230,7 +3230,7 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 #endif
 
 void *sparse_buffer_alloc(unsigned long size);
-struct page * __populate_section_memmap(unsigned long pfn,
+struct page *__populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap);
 pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
-- 
2.34.1
