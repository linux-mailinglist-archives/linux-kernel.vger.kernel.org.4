Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AE5616BC9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiKBSKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiKBSKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:10:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8922D3055A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:09:32 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2HBXXT011227;
        Wed, 2 Nov 2022 18:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=VOfZR1bfgraHOMF0H2A4SdBgmD4c0rbRbY/XavBwa1Y=;
 b=Yh9X3toCIYMLmmxtgI+miLyc8gO8gV0gSuTgldwyAbNb79EjR/WjFKT2muCoSCnCaGRC
 wIualL00FcSlWJRTfTmp7/kUKonwM3G0ixhozFeh2TPSNYRVTKp3IbeyfvZ3VFZY1lzb
 qpHOxxQY7IsQ0gs8FPGAinZQBQCJM+A5btZmnuHDcHF8TQ+agScJ8m+odQUMBR8vO7xx
 sz1mz5OGbc2V4+RJD5l/0vK3v/Byvzl+C3/B8yFNGEDTl7ZpJ1psf33tYpj2uiQowXyM
 knZ90yAOCCA9MqtzTEIBgRurLIRo1y4CWVzRzh26AhgTPyIBslHt1oZdveXaIisUy/vK IQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkvbyaehx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 18:09:23 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2I5a9e032273;
        Wed, 2 Nov 2022 18:09:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3kgut8wfpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 18:09:21 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2I9Ie2197148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 18:09:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8491A404D;
        Wed,  2 Nov 2022 18:09:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E33EA4040;
        Wed,  2 Nov 2022 18:09:18 +0000 (GMT)
Received: from localhost (unknown [9.171.5.179])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Nov 2022 18:09:18 +0000 (GMT)
Date:   Wed, 2 Nov 2022 19:09:17 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: hugetlb_vmemmap: include missing linux/moduleparam.h
Message-ID: <patch.git-296b83ca939b.your-ad-here.call-01667411912-ext-5073@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ec98p4g_hAQ4m1_VWDE0Alz8zEb-aPWF
X-Proofpoint-ORIG-GUID: Ec98p4g_hAQ4m1_VWDE0Alz8zEb-aPWF
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=912
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot reported build failures with a 'randconfig' on s390:
>> mm/hugetlb_vmemmap.c:421:11: error: a function declaration without a
prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
             ^

Link: https://lore.kernel.org/linux-mm/202210300751.rG3UDsuc-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 30152245c63b ("mm: hugetlb_vmemmap: replace early_param() with core_param()")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 mm/hugetlb_vmemmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ba2a2596fb4e..4962dd1ba4a6 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
 #include <linux/pgtable.h>
+#include <linux/moduleparam.h>
 #include <linux/bootmem_info.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-- 
2.38.1
