Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E895B907B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiINWUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiINWTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:19:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E7F21BF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:19:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EMIhCf027338;
        Wed, 14 Sep 2022 22:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=YgYkt0QuP9ElyM3GYKSupA5PKhlljwrykt+N//yr6Sk=;
 b=O0aprwbDZJxPyxCjRnInoT10YiNSrEC8lpjxXpaFpDS8ijPvdi7R/Oe6vMXJ77SSWnjn
 3KrYET85Gm6G1OPoaTzCflbChyL4fjhy7hyln/1xkxJiVhWJ6j2mTkh1qQ30zJqp73f5
 ZHARUHHVGR5V1UWo+Y+PbzbXebvaTTy5WThG4hQJX7XxXBWYRFKuFgUL7OdcQza62urK
 k36wbLrIvJS5v2tK6+fqO8x24ZFfR0Jk8f0gOZPM+/9RoSbgYuJhBDYQhK+ri2ZCpDPq
 ciw00yFISGLRmSrmV5zpHthMzHX2kz4YD8QvTuGaoLJ0G80jxFOH/tNOBRMB+cacjnIX 1Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyduppy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28ELuQLB009613;
        Wed, 14 Sep 2022 22:18:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyedadwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdHiT0oeWnUkBaGuBpns4akjaLB6DpfplDu7t0to26RGIdrnmx7gyswyzktCLiNq4fDdOlYT5dNU/ZSKrABW8EWFB8HFd7KOALNw9pR2B3hsJxtUPGGQYCERlsVWriY1CGgeQSQb2uH1ch9sTxrV5b2bO0UdEi6cqS9UK8uCNtkRoDPTjcVVLOic+saoZSC7Sqj3YNUFcsNlEBgjLdtQdV++L9AUdDmhMVI326x1ndgfM1TDvZR4+xFCsiwF7UbkqUyoYv28FxA9WnBEeVXlRj36d/ly2LJ/I8jDYTewOh/cbVRYSSdkZEetH/Ek79i6fenMcmQS6eskjK9PIwNr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgYkt0QuP9ElyM3GYKSupA5PKhlljwrykt+N//yr6Sk=;
 b=AaojvL71ykzR8wbHHp2vCWRLH4YT6Q8nV+fReKomNP0HzM6khh7EQjvAWoltQ2Z3gLg8W7o/OyiMH/++sos+xaAhLJAXgL4R1cEkXuegG2C9Gvyj0rbFUWK5MW6l4DhqK709AF8GY1hEnsiAmu9UBT0WWTQkh/GIhmSJE6Z8Z/p+BlfdX0yVnIo4ifozlNlONI7ct0m8IDbPDoMnqVJ2bKFCGeO6zjAs8UUXuOJJ83GxDnUPD35BQr6N9zTYU3pOK10LwIHskkysXNPj588AgHtnty9xry7h43tbS+cNS0NprIqc6B6CqOa/zW0800CMwsxDQ6R5b5vx2Q+9P9Ilfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgYkt0QuP9ElyM3GYKSupA5PKhlljwrykt+N//yr6Sk=;
 b=O93Zdu38aIhHKC96gJs4lDNvZhBeFmiU/8q3gdAoQDMhNvV2qTAQJZa91L7zLJpup+s5TPomsZbZVpNogauj7WQ0VRcT3K8+P29+LkfP8t4QK1rX3CCFnKL1lr6xxMgZv4t2vqFjgJp9nv/MhE/gxAkxkSk32N0jlR4sSc0P9yw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4390.namprd10.prod.outlook.com (2603:10b6:610:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 22:18:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 22:18:34 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 7/9] hugetlb: create hugetlb_unmap_file_folio to unmap single file folio
Date:   Wed, 14 Sep 2022 15:18:08 -0700
Message-Id: <20220914221810.95771-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914221810.95771-1-mike.kravetz@oracle.com>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d30b1de-46a5-4735-05b2-08da969f107b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ek2fhnQWeKBdZE3NGSa3ZTktMmLHX2qwOSDFJB7YZzdSdVd4T/r6Y+hwmQk5IsSJsYIVevMdj205Jdh12XpCWQsYj7mdmsHBAMcj9feGRecaCrt8I3pbNrKm3kq8Jm8bb9B4dUTTq+mGs0L0A7RKLXf1oSp1yLtS580n9WsyPhEaJI1zlT3bkfzTGNRs4k1tjndzXgzjjNdNxVHLOMSvf5NImJkuDcxdUe0Dc+anrKQ1NL9o8YhS3f9K+NzZM3kbkz6opVLIlwDgoe4i+/pJkdnncHU3Fp+W7AUFe6ycPv7zWrSy7YeuuArnttll0A336eLv+b65I6+7ed4fvZnfgf2M6aMI92NbRxVmEjWs5GzhMikq3Zks+OlNdWk8WA3xwezynNuqcouVnMBHTBnf2Vs32V8jRUAR7o3diNQIHLmEFO6gYMjPTGrtSr6urq0fhnQ6oW4jlt9sQl9ivW0ypmU6UFUUDF3KNoBMc7mgipw6z+bVRWa4FIMK2ALmV26QPdlHWUwvXVvHSkciiHIx67H8jPiP/JIN1iqpALV35D0FuCystyzBiXzt/0/ru90Cvv9ggpowP/yhRn+UZGxNQ94u1Kw/07GWs+dn1MSW9qPSP+mhJ9y9c0gcDGYzQ2uer/+52ouT3wHhcHzMtYs8Cl1mY3oyiIsMk3YvksJFeDpDUrlRfWCiVfMI9i4ma+rzMO7CiqP780io4FJu7o4XVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(6512007)(7416002)(6666004)(86362001)(66556008)(36756003)(8676002)(107886003)(83380400001)(6486002)(66946007)(54906003)(44832011)(66476007)(8936002)(5660300002)(316002)(41300700001)(6506007)(478600001)(186003)(2906002)(38100700002)(26005)(4326008)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v93JHpVRFbb0PlIOy840rJlLYDtxWdSY/OBYkoI1HoN3Y+Hwo5pdBPyXKaE/?=
 =?us-ascii?Q?5P+mT+CfeVnQuaL7Utv3n6rbnglMv8AxmtjGtdullvU9+8umxktSxu2wcLLI?=
 =?us-ascii?Q?UuqcdAJ9pViZ8KNicnDOK5aViDzNrsluwN+pm0C/pFvaL1fGKlrswpCAN+we?=
 =?us-ascii?Q?ievXqYbO3pu+E0eg73caNgqczfaGlTikkvb6ZIz/Z+lUu4Q5Dya/rYBRxVfL?=
 =?us-ascii?Q?e06RAc55UnfOBLFDKTHg/bf5+iDjJXJvA3vc0w6C+xPMj+k8XGC8SOpLjitm?=
 =?us-ascii?Q?j1YozRbCFdAnReXcfNtBLADXxtz/zmNkJwJppvzwoDJSugTVXCzuuPLVqtbj?=
 =?us-ascii?Q?r79MR3IJTmrYf9HY2PWFNREP4NnCJ8m5Xs9AnNo0GtuGiuAKb2NSYuiMXSWJ?=
 =?us-ascii?Q?4yCYZT3k4nvpizf/WxMctHVrlr6+CfDLWg/UTk/jOmz7TXZJNfB4ZIuCPVGB?=
 =?us-ascii?Q?iGecuSaZ4+ex+LF4TjLF4lft2EGIfnevbLUiIlr2eGDzTMFsKO4fQkNuAahM?=
 =?us-ascii?Q?Lu3At8BXRPkhRhRjWPh1TdpcuX20GtmNsw3DIMccabGJ6sO6mr3Ujb7gE5Rx?=
 =?us-ascii?Q?rQO2LtwEDJhPJKVMqpU4cs8hdYoH2XvP3Rf5jY2coHHNMeewL8W6osPQcZFz?=
 =?us-ascii?Q?J7oKP7rhL/vLGp5fFwkCNXjBqtayWAn5FEcfU8FrWO9dM36cTYkRoO361KgL?=
 =?us-ascii?Q?tNPLgefT+OCXEO9OjusIkiPMkUXNPWRqSiSYtoucXRig9l9Yis23hxrjKExI?=
 =?us-ascii?Q?CMTNWvpl3iCglGDEMyKQzKV2LOm30UNkZqsLZHHtVFhK+oGlLy+L48vwmkTt?=
 =?us-ascii?Q?HLRw0QdyAlvYeT366zbI9GcmmqoMV3Xqh9BSHCo/kigxFnSsMIWMtzz+j4+q?=
 =?us-ascii?Q?llk8NbT4nJhbLk1i7LgqfiMruxIrMzC/kT4WPtj4yIF0mWVJqnCWoBOiQhns?=
 =?us-ascii?Q?Q6a+SrKXvkRz8Oj/WeZEsyqk6GV4auoET3sz0b+/wPXKRwiKlBXjhjC4IGZD?=
 =?us-ascii?Q?L66OCqbeoRcQablSZcUs++loT7mynvXwLumhEMrfdvHa/FO+24g8yrOml2Ne?=
 =?us-ascii?Q?sF+ZNj+A74siPUpoHBGVz16OSdzVD1QOz3t3oaJ9RaAEvyfhNRiraCvEQQKP?=
 =?us-ascii?Q?nXq94JDvDRhMoHwtjXJKJtl8KD+vxr1k6npqFm5raXerOzh9s+alwfTn8/+G?=
 =?us-ascii?Q?3nr8rd03AlPomRc2SqiDziO1h+Ht+37PVh9izm2qyn5sgk6HQP8ucEG7iXUA?=
 =?us-ascii?Q?SFhq/QvmAL0TA7SePShctwbkvb+UlLNj/Ib5FmnweA9o88EgHiWGEU/C4DDq?=
 =?us-ascii?Q?u2V85Z2x7ZmFF4QLxJJ15nCgofnyeVZ57xwftcfMSwIw51MsCUHzQjngi7ra?=
 =?us-ascii?Q?ZPV1uiFPz8Pp2yf5/bTQYpuALEb8x3cGHGFSxtFNiTNJjlxDAs8fg/6HCnyX?=
 =?us-ascii?Q?UvFSZcjeuKIhkZCpL82D8df8CkaYrYetsTs6lCQLF+elWX09FtFnxsEfteeP?=
 =?us-ascii?Q?94rVhgp68XS9YhSBRQ/11/vwpAaV1rTDWd6xb7L3cEKLIkRl90UTaqcCSEDk?=
 =?us-ascii?Q?LrOgvS+UN17iEWkEY7+LocPZBGeXZyIGt7Nui/eHhoJxlMFpg93wWYgUQvaz?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d30b1de-46a5-4735-05b2-08da969f107b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 22:18:34.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5brwB27MUbXHWRq+WQd1JHiQ56b8HFyk8REbfJuQMmEH3OW0DVfoLI8hsBVjczE3AgUlwldaEVTRn3uMvUIug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140108
X-Proofpoint-ORIG-GUID: CCej2BkDRArpAEAYlJMrnFMEMtH-umz8
X-Proofpoint-GUID: CCej2BkDRArpAEAYlJMrnFMEMtH-umz8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the new routine hugetlb_unmap_file_folio that will unmap a single
file folio.  This is refactored code from hugetlb_vmdelete_list.  It is
modified to do locking within the routine itself and check whether the
page is mapped within a specific vma before unmapping.

This refactoring will be put to use and expanded upon in a subsequent
patch adding vma specific locking.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c | 123 +++++++++++++++++++++++++++++++++----------
 1 file changed, 94 insertions(+), 29 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7112a9a9f54d..3bb1772fce2f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -371,6 +371,94 @@ static void hugetlb_delete_from_page_cache(struct page *page)
 	delete_from_page_cache(page);
 }
 
+/*
+ * Called with i_mmap_rwsem held for inode based vma maps.  This makes
+ * sure vma (and vm_mm) will not go away.  We also hold the hugetlb fault
+ * mutex for the page in the mapping.  So, we can not race with page being
+ * faulted into the vma.
+ */
+static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
+				unsigned long addr, struct page *page)
+{
+	pte_t *ptep, pte;
+
+	ptep = huge_pte_offset(vma->vm_mm, addr,
+			huge_page_size(hstate_vma(vma)));
+
+	if (!ptep)
+		return false;
+
+	pte = huge_ptep_get(ptep);
+	if (huge_pte_none(pte) || !pte_present(pte))
+		return false;
+
+	if (pte_page(pte) == page)
+		return true;
+
+	return false;
+}
+
+/*
+ * Can vma_offset_start/vma_offset_end overflow on 32-bit arches?
+ * No, because the interval tree returns us only those vmas
+ * which overlap the truncated area starting at pgoff,
+ * and no vma on a 32-bit arch can span beyond the 4GB.
+ */
+static unsigned long vma_offset_start(struct vm_area_struct *vma, pgoff_t start)
+{
+	if (vma->vm_pgoff < start)
+		return (start - vma->vm_pgoff) << PAGE_SHIFT;
+	else
+		return 0;
+}
+
+static unsigned long vma_offset_end(struct vm_area_struct *vma, pgoff_t end)
+{
+	unsigned long t_end;
+
+	if (!end)
+		return vma->vm_end;
+
+	t_end = ((end - vma->vm_pgoff) << PAGE_SHIFT) + vma->vm_start;
+	if (t_end > vma->vm_end)
+		t_end = vma->vm_end;
+	return t_end;
+}
+
+/*
+ * Called with hugetlb fault mutex held.  Therefore, no more mappings to
+ * this folio can be created while executing the routine.
+ */
+static void hugetlb_unmap_file_folio(struct hstate *h,
+					struct address_space *mapping,
+					struct folio *folio, pgoff_t index)
+{
+	struct rb_root_cached *root = &mapping->i_mmap;
+	struct page *page = &folio->page;
+	struct vm_area_struct *vma;
+	unsigned long v_start;
+	unsigned long v_end;
+	pgoff_t start, end;
+
+	start = index * pages_per_huge_page(h);
+	end = (index + 1) * pages_per_huge_page(h);
+
+	i_mmap_lock_write(mapping);
+
+	vma_interval_tree_foreach(vma, root, start, end - 1) {
+		v_start = vma_offset_start(vma, start);
+		v_end = vma_offset_end(vma, end);
+
+		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
+			continue;
+
+		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
+				NULL, ZAP_FLAG_DROP_MARKER);
+	}
+
+	i_mmap_unlock_write(mapping);
+}
+
 static void
 hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		      zap_flags_t zap_flags)
@@ -383,30 +471,13 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 	 * an inclusive "last".
 	 */
 	vma_interval_tree_foreach(vma, root, start, end ? end - 1 : ULONG_MAX) {
-		unsigned long v_offset;
+		unsigned long v_start;
 		unsigned long v_end;
 
-		/*
-		 * Can the expression below overflow on 32-bit arches?
-		 * No, because the interval tree returns us only those vmas
-		 * which overlap the truncated area starting at pgoff,
-		 * and no vma on a 32-bit arch can span beyond the 4GB.
-		 */
-		if (vma->vm_pgoff < start)
-			v_offset = (start - vma->vm_pgoff) << PAGE_SHIFT;
-		else
-			v_offset = 0;
-
-		if (!end)
-			v_end = vma->vm_end;
-		else {
-			v_end = ((end - vma->vm_pgoff) << PAGE_SHIFT)
-							+ vma->vm_start;
-			if (v_end > vma->vm_end)
-				v_end = vma->vm_end;
-		}
+		v_start = vma_offset_start(vma, start);
+		v_end = vma_offset_end(vma, end);
 
-		unmap_hugepage_range(vma, vma->vm_start + v_offset, v_end,
+		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
 				     NULL, zap_flags);
 	}
 }
@@ -428,14 +499,8 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 	 * the fault mutex.  The mutex will prevent faults
 	 * until we finish removing the folio.
 	 */
-	if (unlikely(folio_mapped(folio))) {
-		i_mmap_lock_write(mapping);
-		hugetlb_vmdelete_list(&mapping->i_mmap,
-			index * pages_per_huge_page(h),
-			(index + 1) * pages_per_huge_page(h),
-			ZAP_FLAG_DROP_MARKER);
-		i_mmap_unlock_write(mapping);
-	}
+	if (unlikely(folio_mapped(folio)))
+		hugetlb_unmap_file_folio(h, mapping, folio, index);
 
 	folio_lock(folio);
 	/*
-- 
2.37.2

