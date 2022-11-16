Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E135362B43E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiKPHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiKPHxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:53:08 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F4A13D3A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:53:07 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG7IFed025354;
        Wed, 16 Nov 2022 07:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=EcA75F8cZO2aTdwdgrbcgF7SVITLfWHUdtAzo94G/J8=;
 b=etGsHY18vF351w7Zc4BWolaFDclCASiFQ2qxcP8yoKeWxuX98/p6jDo0G1FveMRwXSDr
 GvnO2nxCaNHk21vsRbKIGMgIaZJOa8Cfueji6CL41FTtGVTzL88fsk4xMqn+li/2zLe9
 h4wuYf+imtdanjaPHUF82IDMY5vZ9Q60tfOMlfTNmaezAVvi/anGUoIK9cEM1qoQOKKl
 m2Mc2x6XeNNHWm5mB81HpfjLQY147acY7bLyjcW92S04kEpWXBOxYTDnGoPMUOe+25dk
 M8ZSensmgz7fCk00pvkwZAkvgD+TAxkX8aaXVxgYcBWR7l4g/4mCIYm6mlXTY+th6+OS 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvubk8pw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:53:00 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AG7KMis031866;
        Wed, 16 Nov 2022 07:53:00 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvubk8pvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:53:00 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AG7oe8J020609;
        Wed, 16 Nov 2022 07:52:58 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3kt348whsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:52:58 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AG7qtYP3670712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 07:52:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E0C442042;
        Wed, 16 Nov 2022 07:52:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2A1442041;
        Wed, 16 Nov 2022 07:52:49 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.163.49.19])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Nov 2022 07:52:49 +0000 (GMT)
Date:   Wed, 16 Nov 2022 08:52:45 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH 3/4] mm: mmu_gather: turn delayed rmap macros into inlines
Message-ID: <Y3SWzbS4OJoz6ppv@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221109203051.1835763-1-torvalds@linux-foundation.org>
 <20221109203051.1835763-4-torvalds@linux-foundation.org>
 <CAHk-=wjf+gN25grUT3o3XK8-B-b2jhBuN8YMLQvq-=AXTcuFXg@mail.gmail.com>
 <CAHk-=wiFmm+X92Ghkz_LDG53djReK=idAj0uvSdES+yeG1X=Dw@mail.gmail.com>
 <Y3SVqePHGXRUagyF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3SVqePHGXRUagyF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TjCzFlvACOESvlAtylpDdab9GpHaMHK3
X-Proofpoint-ORIG-GUID: NddfzGPYSXY_LoFYeBWMpz-zUn4Nd-fN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=718 malwarescore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make tlb_delay_rmap() and friend macros inline functions
by using forward declarations, which allows defining ones
after the 'struct mmu_gather' definition.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/asm-generic/tlb.h | 56 ++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 317bef9eee3c..33943a4de5a7 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -261,13 +261,10 @@ extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
 				   int page_size);
 
 #ifdef CONFIG_SMP
-/*
- * This both sets 'delayed_rmap', and returns true. It would be an inline
- * function, except we define it before the 'struct mmu_gather'.
- */
-#define tlb_delay_rmap(tlb)		(((tlb)->delayed_rmap = 1), true)
-#define tlb_reset_delay_rmap(tlb)	((tlb)->delayed_rmap = 0)
-#define tlb_rmap_delayed(tlb)		((tlb)->delayed_rmap)
+#define tlb_delay_rmap tlb_delay_rmap
+static inline bool tlb_delay_rmap(struct mmu_gather *tlb);
+static inline void tlb_reset_delay_rmap(struct mmu_gather *tlb);
+static inline bool tlb_rmap_delayed(struct mmu_gather *tlb);
 extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
 #endif
 
@@ -338,6 +335,27 @@ struct mmu_gather {
 #endif
 };
 
+#ifdef tlb_delay_rmap
+
+static inline bool tlb_delay_rmap(struct mmu_gather *tlb)
+{
+	tlb->delayed_rmap = 1;
+
+	return true;
+}
+
+static inline void tlb_reset_delay_rmap(struct mmu_gather *tlb)
+{
+	tlb->delayed_rmap = 0;
+}
+
+static inline bool tlb_rmap_delayed(struct mmu_gather *tlb)
+{
+	return tlb->delayed_rmap;
+}
+
+#else
+
 /*
  * We have a no-op version of the rmap removal that doesn't
  * delay anything. That is used on S390, which flushes remote
@@ -345,11 +363,25 @@ struct mmu_gather {
  * remote TLBs to flush and is not preemptible due to this
  * all happening under the page table lock.
  */
-#ifndef tlb_delay_rmap
-#define tlb_delay_rmap(tlb)		(false)
-#define tlb_reset_delay_rmap(tlb)	do { } while (0)
-#define tlb_rmap_delayed(tlb)		(false)
-static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
+#define tlb_delay_rmap tlb_delay_rmap
+static inline bool tlb_delay_rmap(struct mmu_gather *tlb)
+{
+	return false;
+}
+
+static inline void tlb_reset_delay_rmap(struct mmu_gather *tlb)
+{
+}
+
+static inline bool tlb_rmap_delayed(struct mmu_gather *tlb)
+{
+	return false;
+}
+
+static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
+}
+
 #endif
 
 void tlb_flush_mmu(struct mmu_gather *tlb);
-- 
2.31.1

