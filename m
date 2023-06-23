Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BADA73B958
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjFWOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjFWOE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:04:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0187C2693;
        Fri, 23 Jun 2023 07:04:53 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDuriM028139;
        Fri, 23 Jun 2023 14:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=err5CMmGfZX6yghBvdJwQ2rOl/tPn2f2raSRJUGn2XA=;
 b=q3+bfzV4MdtjCwpgUooIhOjAaDwa2Nbe4eMPI8qXfanxMa5dazVay8KhhXILz+jbjIbA
 2IfEVnzHExG0nl4QIMbPokqpwZb7RbftYeq6ms0+HJchwM+gCKSAHMLTzXAohyW/YNAA
 kxhiNMV77vwgVmweu04XTxILmaPggSmv+wJQm4cXBrB5xcHIimSAEs1bUTsifiSXohIc
 0tNtrqtiAIYbMSJJy3e1N2jrELHgOKBzHfdyCIMUdsTi+0O6rbsYr50ckx5IIJr7q46H
 zumdJRUKRUBsFe3TQzls05r7YWYARUhnXNyFH0fScZ99sCMC6duYxZKWZnrHj7WDp5BU Gg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rdcqrg425-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:04:40 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35NBjGos011443;
        Fri, 23 Jun 2023 14:01:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r94f5358m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 14:01:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35NE1DOI42861130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 14:01:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BAFE20049;
        Fri, 23 Jun 2023 14:01:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71B2E20043;
        Fri, 23 Jun 2023 14:01:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 23 Jun 2023 14:01:13 +0000 (GMT)
Date:   Fri, 23 Jun 2023 16:01:12 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.5
Message-ID: <ZJWlqGlx6LymL7lO@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _HIEVLSU3GF6zRsFylz6yAj1nRFuIXT1
X-Proofpoint-GUID: _HIEVLSU3GF6zRsFylz6yAj1nRFuIXT1
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.5.

Thank you,
Alexander

The following changes since commit 03c5c83b70dca3729a3eb488e668e5044bd9a5ea:

  s390/purgatory: disable branch profiling (2023-05-25 19:41:45 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.4-4

for you to fetch changes up to ad3d770b83afffd10abf624ec80c408254343a20:

  s390/defconfigs: set CONFIG_NET_TC_SKB_EXT=y (2023-06-02 16:09:27 +0200)

----------------------------------------------------------------
s390 updates for 6.5

- Use correct type for size of memory allocated for ELF core
  header on kernel crash.

- Fix insecure W+X mapping warning when KASAN shadow memory
  range is not aligned on page boundary.

- Avoid allocation of short by one page KASAN shadow memory
  when the original memory range is less than (PAGE_SIZE << 3).

- Fix virtual vs physical address confusion in physical memory
  enumerator. It is not a real issue, since virtual and physical
  addresses are currently the same.

- Set CONFIG_NET_TC_SKB_EXT=y in s390 config files as it is
  required for offloading TC as well as bridges on switchdev
  capable ConnectX devices.

----------------------------------------------------------------

Alexander Gordeev (3):
  s390/kasan: fix insecure W+X mapping warning
  s390/kasan: avoid short by one page shadow memory
  s390/boot: fix physmem_info virtual vs physical address confusion

Christophe JAILLET (1):
  s390/crash: use the correct type for memory allocation

Niklas Schnelle (1):
  s390/defconfigs: set CONFIG_NET_TC_SKB_EXT=y

 arch/s390/boot/vmem.c                | 15 +++++++++++----
 arch/s390/configs/debug_defconfig    |  1 +
 arch/s390/configs/defconfig          |  1 +
 arch/s390/include/asm/physmem_info.h |  5 +++--
 arch/s390/kernel/crash_dump.c        |  2 +-
 arch/s390/mm/vmem.c                  | 14 ++++++++++----
 6 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index acb1f8b53105..c67f59db7a51 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -45,6 +45,13 @@ static void pgtable_populate(unsigned long addr, unsigned long end, enum populat
 
 static pte_t pte_z;
 
+static inline void kasan_populate(unsigned long start, unsigned long end, enum populate_mode mode)
+{
+	start = PAGE_ALIGN_DOWN(__sha(start));
+	end = PAGE_ALIGN(__sha(end));
+	pgtable_populate(start, end, mode);
+}
+
 static void kasan_populate_shadow(void)
 {
 	pmd_t pmd_z = __pmd(__pa(kasan_early_shadow_pte) | _SEGMENT_ENTRY);
@@ -95,17 +102,17 @@ static void kasan_populate_shadow(void)
 	 */
 
 	for_each_physmem_usable_range(i, &start, &end)
-		pgtable_populate(__sha(start), __sha(end), POPULATE_KASAN_MAP_SHADOW);
+		kasan_populate(start, end, POPULATE_KASAN_MAP_SHADOW);
 	if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
 		untracked_end = VMALLOC_START;
 		/* shallowly populate kasan shadow for vmalloc and modules */
-		pgtable_populate(__sha(VMALLOC_START), __sha(MODULES_END), POPULATE_KASAN_SHALLOW);
+		kasan_populate(VMALLOC_START, MODULES_END, POPULATE_KASAN_SHALLOW);
 	} else {
 		untracked_end = MODULES_VADDR;
 	}
 	/* populate kasan shadow for untracked memory */
-	pgtable_populate(__sha(ident_map_size), __sha(untracked_end), POPULATE_KASAN_ZERO_SHADOW);
-	pgtable_populate(__sha(MODULES_END), __sha(_REGION1_SIZE), POPULATE_KASAN_ZERO_SHADOW);
+	kasan_populate(ident_map_size, untracked_end, POPULATE_KASAN_ZERO_SHADOW);
+	kasan_populate(MODULES_END, _REGION1_SIZE, POPULATE_KASAN_ZERO_SHADOW);
 }
 
 static bool kasan_pgd_populate_zero_shadow(pgd_t *pgd, unsigned long addr,
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index be3bf03bf361..aa95cf6dfabb 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -116,6 +116,7 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
+CONFIG_NET_TC_SKB_EXT=y
 CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_INET=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 769c7eed8b6a..f041945f9148 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -107,6 +107,7 @@ CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
+CONFIG_NET_TC_SKB_EXT=y
 CONFIG_SMC=m
 CONFIG_SMC_DIAG=m
 CONFIG_INET=y
diff --git a/arch/s390/include/asm/physmem_info.h b/arch/s390/include/asm/physmem_info.h
index 8e9c582592b3..9e41a74fce9a 100644
--- a/arch/s390/include/asm/physmem_info.h
+++ b/arch/s390/include/asm/physmem_info.h
@@ -3,6 +3,7 @@
 #define _ASM_S390_MEM_DETECT_H
 
 #include <linux/types.h>
+#include <asm/page.h>
 
 enum physmem_info_source {
 	MEM_DETECT_NONE = 0,
@@ -133,7 +134,7 @@ static inline const char *get_rr_type_name(enum reserved_range_type t)
 
 #define for_each_physmem_reserved_type_range(t, range, p_start, p_end)				\
 	for (range = &physmem_info.reserved[t], *p_start = range->start, *p_end = range->end;	\
-	     range && range->end; range = range->chain,						\
+	     range && range->end; range = range->chain ? __va(range->chain) : NULL,		\
 	     *p_start = range ? range->start : 0, *p_end = range ? range->end : 0)
 
 static inline struct reserved_range *__physmem_reserved_next(enum reserved_range_type *t,
@@ -145,7 +146,7 @@ static inline struct reserved_range *__physmem_reserved_next(enum reserved_range
 			return range;
 	}
 	if (range->chain)
-		return range->chain;
+		return __va(range->chain);
 	while (++*t < RR_MAX) {
 		range = &physmem_info.reserved[*t];
 		if (range->end)
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 8a617be28bb4..7af69948b290 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -568,9 +568,9 @@ static size_t get_elfcorehdr_size(int mem_chunk_cnt)
 int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size)
 {
 	Elf64_Phdr *phdr_notes, *phdr_loads;
+	size_t alloc_size;
 	int mem_chunk_cnt;
 	void *ptr, *hdr;
-	u32 alloc_size;
 	u64 hdr_off;
 
 	/* If we are not in kdump or zfcp/nvme dump mode return */
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 5b22c6e24528..b9dcb4ae6c59 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -667,7 +667,15 @@ static void __init memblock_region_swap(void *a, void *b, int size)
 
 #ifdef CONFIG_KASAN
 #define __sha(x)	((unsigned long)kasan_mem_to_shadow((void *)x))
+
+static inline int set_memory_kasan(unsigned long start, unsigned long end)
+{
+	start = PAGE_ALIGN_DOWN(__sha(start));
+	end = PAGE_ALIGN(__sha(end));
+	return set_memory_rwnx(start, (end - start) >> PAGE_SHIFT);
+}
 #endif
+
 /*
  * map whole physical memory to virtual memory (identity mapping)
  * we reserve enough space in the vmalloc area for vmemmap to hotplug
@@ -737,10 +745,8 @@ void __init vmem_map_init(void)
 	}
 
 #ifdef CONFIG_KASAN
-	for_each_mem_range(i, &base, &end) {
-		set_memory_rwnx(__sha(base),
-				(__sha(end) - __sha(base)) >> PAGE_SHIFT);
-	}
+	for_each_mem_range(i, &base, &end)
+		set_memory_kasan(base, end);
 #endif
 	set_memory_rox((unsigned long)_stext,
 		       (unsigned long)(_etext - _stext) >> PAGE_SHIFT);
