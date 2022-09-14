Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673AE5B9076
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiINWTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiINWTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:19:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF6F86B74
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:19:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EMA2PU000788;
        Wed, 14 Sep 2022 22:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=WWgFa5uvH4cxJCWBo6D7vjTXo0sJrhLbYOZnN6Af1kM=;
 b=Kko7SIoA+IIeIrBt1b+QlvmLxy8+khTSidnYyUxPK6eIOftFtdQehjRQkCZ2+INUnQWY
 U5adHVLIOVTEihsBS4Y/U+KN1auWV/hDoqefSC9FOpyK9RyUuPOGhkxvcNzUlNDiJhMs
 a846rObNLAuLIQhkZ72vtdGVWCWyrKmrX9e4ZMXDQ8Mln1sBAeyBKG1bBl5MqpgKT5Lv
 Xp+x0RxXyray2na+gJkQD90p0eNDRcrQoYbX47vHy1kquC36Lc0UozD8E8UR1kSR0Kmu
 A9gih2zd+YX6CtWhVLcZvT4Grf8jSCXu7AXR8xngrjV2emFh0Zc5trQqSSRIuQ4Act6z fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyf3jn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28ELrNe6006549;
        Wed, 14 Sep 2022 22:18:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy2bjuf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEhAZ8aUK7pbhgyuahZi2B3/lEIHd6L3qE6Efo3abq2tcAReL74dDItAZz24azsKmDM82SdhBT33gwFU9QpDpM22Mzj7VojMcwL4xb9V73uwswaURXn3FuHz7c9jH9jFoMDTOxrggjapcvhQvxOv1YIIupZQ4oXZBaw3IBe2WKplLFItuCAxLo4NT1xjJGIiyEy8kyt8i8/se3nK04mIWn+aTj7WTqx3QyjouyRCbCuVV5p/qrGHagDjLpVVG8td1w/5yToseYxTcGMBQWeSUVoqOBZmBV7lRwu8Xj6P/QpvgvKUGjCSjUQfSV5x4p2bmIhpAk4WJSyXdilK4Fn4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWgFa5uvH4cxJCWBo6D7vjTXo0sJrhLbYOZnN6Af1kM=;
 b=WTqzQ9zAZkug+MRRZUmNGsFixN4HDGnGcQQqDlPvwbz43gB3B4tZ8skyKZiPeC9SLEXUj/0A3RzygE+zaMdXZFgZ2htfkA/e/YVks1CsyRZ2qMUfnV7mGQahsbYglpwvmCZLVlbOSm8cfcZhZKdT1tyKELMQYh/uleaJJrt2s5FwD2ekoP/fSKwH+VDh6OrNw/F3+p3L8fKReOTEb4aOnpkNEmTVjXgDS4D7w29wUp8wBAENzv/ceJTsk1HJrF7ZnHWYExSvt/WjET34B2KMcPcGXTa74bQYGS0nrOCe3qg+Ut1BeTunTVbUUSaqcBv1UFOm6r34HKOPw4QG8biXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWgFa5uvH4cxJCWBo6D7vjTXo0sJrhLbYOZnN6Af1kM=;
 b=DqpXcWI4rU3rLaWzAXHSALgMM0eLKCEtk5OZUy8EqSUIE+kWtBWbpwidcwuHksXYASFkPJS5SsXi05REweBXdAIB9oSo81+LpDGxkeTCvJ5/Um/++1IP2B8xVCtpyXD3d6D4VsntmGd+xdF1+nljaNZ0QBjciqxW372eNkxA7ck=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Wed, 14 Sep
 2022 22:18:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 22:18:23 +0000
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
Subject: [PATCH v2 2/9] hugetlbfs: revert use i_mmap_rwsem for more pmd sharing synchronization
Date:   Wed, 14 Sep 2022 15:18:03 -0700
Message-Id: <20220914221810.95771-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914221810.95771-1-mike.kravetz@oracle.com>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0312.namprd04.prod.outlook.com
 (2603:10b6:303:82::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 6443825b-dd8c-4e61-6ea1-08da969f09be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lo5UJ63f2XZtY8xEQxrekAbBjEUG4EVI69sZIXmYp6y/8KwszMQWYmyE95il8gZguYqXwgqzFYzJFzvVzH1YBcCcN0leq9Zu7q+u6k4b609YIJy0m3Ty61n12zSFuRSj6mEJ/RFgy/82eAHEda8eWpiGnz3MFE/JVBWYlWt49SofhFhtvYUN0f9INNgeIqLMyViYkQXrzW5DsyLfkfp9CtDcsWg16ki8IUqMeBF0l7OfpRtmV2o/iRKoUaBM1IJVyYoZD4/WhZ0Pe4Ejb/s0TkG0jDqAamB6AhkW4x4pEYLmShk/cmkqOFe8Pq4ZV4n7bI+gWTKLoIE5gA/++4RGs5PEd+TnqVo2/OcqE3pej546bgTxzCnthT4gzI7PJCp+sBHJ+x3u3K4ztkPLbYuQJYzKRXipAN8Ypj2jY21brL8XyeC9GdWEOvvpilUmIxZhLUZrA0i7izhp5XgrF1xskmrdgWsUXRT18+hTlvRfQ0AWWLQdp/J8WX4q5wOBb3i0/hcRYRvQaLQvRuYt6gMwnjYkmkhXMXypDX1y6PcbB31+hSprpCO8qiKdrzSk9R7qMDDHego7z8BsXvNQIquv8l127ELwsv2QkuEnvtvlxuhmS3+YjxnRDS6wu0BRgrEPj9UiNy/80xz4lpaXsLBLpS+mNEKu2R1rmzI3fvJ83b0o97aZNGBJONjm4VAUr1lsNNP5WAKAV0hw5pjm7/b5AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(478600001)(38100700002)(54906003)(316002)(36756003)(6506007)(8676002)(4326008)(66946007)(83380400001)(186003)(2616005)(1076003)(5660300002)(41300700001)(107886003)(66476007)(66556008)(86362001)(8936002)(6666004)(6486002)(7416002)(2906002)(26005)(30864003)(6512007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J1Ymtx/Ci0K3NDy6iwzUctn2M4kd81dSEpUttHF/UDXnUZ0kxS1QapZJRWv5?=
 =?us-ascii?Q?P7dF8StBPZa2r2haYQEnF8cJhl/hA3NqyLv6fh/F2aVTxYaNZ1i0c8bIAYEw?=
 =?us-ascii?Q?0SmmCx6LVEzB+RdQ8jQfIdZV0uQ4IlfA3fz2Um7bSzYV3osOlce36NviJktJ?=
 =?us-ascii?Q?7ef9hZ2THrkz97k1kiEivNsaaUScUJ9XscmyELiTIrHmMBiwJm6OxS4I0hPb?=
 =?us-ascii?Q?hIhavAO9zqzGbn1fOml6SyHE8Dc7FDvyRO7pV3DKQiacoeHDAR5eDKA9GyKK?=
 =?us-ascii?Q?3cppl0CP28rkGust0hmLwiN2t9MOCz7yhBu3htdwhVzj6PKeGt2/PhnbSDNA?=
 =?us-ascii?Q?LLYWtXVOy4EC3YooF/YgbQ+tJhMik5ltb/LnCzW3a9QE0bM+7CB6362o+3fP?=
 =?us-ascii?Q?BbGS/0ZOzeT0+xuJDoLnBhNgNRJEyvtFWPHkTMbh2TE0Q59ucn7VMgfIBi1w?=
 =?us-ascii?Q?54R6fLWt4z7sk4CQFeRobSaHsIRm3edaI8YO7+AEMX5DeaN8g5H48+pNkctn?=
 =?us-ascii?Q?GFcGuRNbanzfc88x3SwDQHmmRiEeg1hpxC/xQ5xp+WkvRTt9f17kH73Pw/b9?=
 =?us-ascii?Q?tgA06Nsc1Q/IqHkWdX+Iyb5gJ7aUXEUxmhoC+BikF8/Qg8goKQGrB0qnHMhc?=
 =?us-ascii?Q?jC3HTrWZYB/hlu+Smn1eSwXwC9U/PhEcbpUlHvLgZLE+uit4Qn4tzFxxn5e6?=
 =?us-ascii?Q?2oTi1t/JaXlFxirPTb1xccEi+h9P2MlvpPxKd47ugNo+ed4DIGOIqizYKVVY?=
 =?us-ascii?Q?QBkpbIAailtNL2USXhSaMykzDy3f4LtiCGGalUefhlBOw0TA6lheD/6mBhds?=
 =?us-ascii?Q?JjFCodSQexITLisF4Nnz5K7LfijIsiAFxiC+LQJWnS12QNOU5Lgc1lVTqhBr?=
 =?us-ascii?Q?a82zYePQxoXNzDdq00IpYqVxjoy4d51oUi+wcqxO5bpJjUAQuKn0Rh7HsV4n?=
 =?us-ascii?Q?+bRzu2OkCXVXuw7VFpHR1TXzs9S48OY/zJhbHIiSh2OVG+YwnsvM/ocaqpEQ?=
 =?us-ascii?Q?3tNEjs5e4gynCdTlQbZkdbd1UZyK+JWaoJLc6zq3b1ZZeHDaM4AyEiL+IAeX?=
 =?us-ascii?Q?TbV7mUtXgsIewMApFkpuf1V7+75GDn+Kt/YqlemWuEMdLSxf7+oDnDQ4Z88S?=
 =?us-ascii?Q?fd+W/Caq00kKDjbmlIi5dV9KMCVUFk+aeS9q3HzI898J7jEf/3ZXBaQH2DrU?=
 =?us-ascii?Q?uqZO/Nlp27gJhCq7uvuI6HIoM0zeG3s1Sm6RJiVeSPBDHiZJFI9mBF9OclEd?=
 =?us-ascii?Q?aWNBP0PBVjn6Xj2oYwzfNeoOuy07xBs8fl/RKW+7UUTgzDs+gQv3pEhtz9ca?=
 =?us-ascii?Q?ew4ZhXASj4SA018asQhVy78ZM88u/Uq7qx+/1CV9azM9TMPPr2WQQ2+6Huh9?=
 =?us-ascii?Q?EoPAnobsOm5KnF2rUETDRRkF2YPDhkuljw7kE1GXa7k1SPLiwnEdVqdItHKz?=
 =?us-ascii?Q?Hszktaqarm4lcGvT2cHJOuFM2HCMYak+LABHx5R8Qnvdr7iqtOxI2IL9bMUV?=
 =?us-ascii?Q?emCTdM9cCPt8MCCDtKTAWN6Mi73pLG2fLVfU1KaO9UjHtOeIrj8+cfTsW/ip?=
 =?us-ascii?Q?7QP+dZSANGOWMHZpaG7KNd3kZWbiEGFPh4zTPql5kyu7rU7WsP3SHsbk5mhY?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6443825b-dd8c-4e61-6ea1-08da969f09be
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 22:18:23.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBIoKe0s4962hSjH+K3zMf4B/C2dE0ttVnF5qEO3JkQiuV9GhDHFyR6KATlhUGyAqPnJ0jf777z/IkKHUpzwFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140108
X-Proofpoint-GUID: sjQciN9cBpPl3dePeAIQlRszQPesb11b
X-Proofpoint-ORIG-GUID: sjQciN9cBpPl3dePeAIQlRszQPesb11b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") added code to take i_mmap_rwsem in read mode for the
duration of fault processing.  However, this has been shown to cause
performance/scaling issues.  Revert the code and go back to only taking
the semaphore in huge_pmd_share during the fault path.

Keep the code that takes i_mmap_rwsem in write mode before calling
try_to_unmap as this is required if huge_pmd_unshare is called.

NOTE: Reverting this code does expose the following race condition.

Faulting thread                                 Unsharing thread
...                                                  ...
ptep = huge_pte_offset()
      or
ptep = huge_pte_alloc()
...
                                                i_mmap_lock_write
                                                lock page table
ptep invalid   <------------------------        huge_pmd_unshare()
Could be in a previously                        unlock_page_table
sharing process or worse                        i_mmap_unlock_write
...
ptl = huge_pte_lock(ptep)
get/update pte
set_pte_at(pte, ptep)

It is unknown if the above race was ever experienced by a user.  It was
discovered via code inspection when initially addressed.

In subsequent patches, a new synchronization mechanism will be added to
coordinate pmd sharing and eliminate this race.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c |  2 --
 mm/hugetlb.c         | 77 +++++++-------------------------------------
 mm/rmap.c            |  8 +----
 mm/userfaultfd.c     | 11 ++-----
 4 files changed, 15 insertions(+), 83 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a32031e751d1..dfb735a91bbb 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -467,9 +467,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			if (unlikely(folio_mapped(folio))) {
 				BUG_ON(truncate_op);
 
-				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 				i_mmap_lock_write(mapping);
-				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
 					(index + 1) * pages_per_huge_page(h),
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6c97b97aa252..00fba195a439 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4769,7 +4769,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	struct hstate *h = hstate_vma(src_vma);
 	unsigned long sz = huge_page_size(h);
 	unsigned long npages = pages_per_huge_page(h);
-	struct address_space *mapping = src_vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
 	int ret = 0;
@@ -4781,14 +4780,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		mmu_notifier_invalidate_range_start(&range);
 		mmap_assert_write_locked(src);
 		raw_write_seqcount_begin(&src->write_protect_seq);
-	} else {
-		/*
-		 * For shared mappings i_mmap_rwsem must be held to call
-		 * huge_pte_alloc, otherwise the returned ptep could go
-		 * away if part of a shared pmd and another thread calls
-		 * huge_pmd_unshare.
-		 */
-		i_mmap_lock_read(mapping);
 	}
 
 	last_addr_mask = hugetlb_mask_last_page(h);
@@ -4935,8 +4926,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	if (cow) {
 		raw_write_seqcount_end(&src->write_protect_seq);
 		mmu_notifier_invalidate_range_end(&range);
-	} else {
-		i_mmap_unlock_read(mapping);
 	}
 
 	return ret;
@@ -5345,29 +5334,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * may get SIGKILLed if it later faults.
 		 */
 		if (outside_reserve) {
-			struct address_space *mapping = vma->vm_file->f_mapping;
-			pgoff_t idx;
-			u32 hash;
-
 			put_page(old_page);
-			/*
-			 * Drop hugetlb_fault_mutex and i_mmap_rwsem before
-			 * unmapping.  unmapping needs to hold i_mmap_rwsem
-			 * in write mode.  Dropping i_mmap_rwsem in read mode
-			 * here is OK as COW mappings do not interact with
-			 * PMD sharing.
-			 *
-			 * Reacquire both after unmap operation.
-			 */
-			idx = vma_hugecache_offset(h, vma, haddr);
-			hash = hugetlb_fault_mutex_hash(mapping, idx);
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
-
 			unmap_ref_private(mm, vma, old_page, haddr);
-
-			i_mmap_lock_read(mapping);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			spin_lock(ptl);
 			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 			if (likely(ptep &&
@@ -5522,9 +5490,7 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 	 */
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	ret = handle_userfault(&vmf, reason);
-	i_mmap_lock_read(mapping);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	return ret;
@@ -5759,11 +5725,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
-		/*
-		 * Since we hold no locks, ptep could be stale.  That is
-		 * OK as we are only making decisions based on content and
-		 * not actually modifying content here.
-		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, ptep);
@@ -5771,31 +5732,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
+	} else {
+		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
+		if (!ptep)
+			return VM_FAULT_OOM;
 	}
 
-	/*
-	 * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
-	 *
-	 * ptep could have already be assigned via huge_pte_offset.  That
-	 * is OK, as huge_pte_alloc will return the same value unless
-	 * something has changed.
-	 */
 	mapping = vma->vm_file->f_mapping;
-	i_mmap_lock_read(mapping);
-	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-	if (!ptep) {
-		i_mmap_unlock_read(mapping);
-		return VM_FAULT_OOM;
-	}
+	idx = vma_hugecache_offset(h, vma, haddr);
 
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
-	idx = vma_hugecache_offset(h, vma, haddr);
 	hash = hugetlb_fault_mutex_hash(mapping, idx);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -5860,7 +5810,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			put_page(pagecache_page);
 		}
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		i_mmap_unlock_read(mapping);
 		return handle_userfault(&vmf, VM_UFFD_WP);
 	}
 
@@ -5904,7 +5853,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 out_mutex:
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	i_mmap_unlock_read(mapping);
 	/*
 	 * Generally it's safe to hold refcount during waiting page lock. But
 	 * here we just wait to defer the next page fault to avoid busy loop and
@@ -6744,12 +6692,10 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
  * !shared pmd case because we can allocate the pmd later as well, it makes the
- * code much cleaner.
- *
- * This routine must be called with i_mmap_rwsem held in at least read mode if
- * sharing is possible.  For hugetlbfs, this prevents removal of any page
- * table entries associated with the address space.  This is important as we
- * are setting up sharing based on existing page table entries (mappings).
+ * code much cleaner. pmd allocation is essential for the shared case because
+ * pud has to be populated inside the same i_mmap_rwsem section - otherwise
+ * racing tasks could either miss the sharing (see huge_pte_offset) or select a
+ * bad pmd for sharing.
  */
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud)
@@ -6763,7 +6709,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t *pte;
 	spinlock_t *ptl;
 
-	i_mmap_assert_locked(mapping);
+	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
@@ -6793,6 +6739,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_unlock(ptl);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
+	i_mmap_unlock_read(mapping);
 	return pte;
 }
 
@@ -6803,7 +6750,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
  * indicated by page_count > 1, unmap is achieved by clearing pud and
  * decrementing the ref count. If count == 1, the pte page is not shared.
  *
- * Called with page table lock held and i_mmap_rwsem held in write mode.
+ * Called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
  *	    0 the underlying pte page is not shared, or it is the last user
diff --git a/mm/rmap.c b/mm/rmap.c
index 08d552ea4ceb..d17d68a9b15b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -23,10 +23,9 @@
  * inode->i_rwsem	(while writing or truncating, not reading or faulting)
  *   mm->mmap_lock
  *     mapping->invalidate_lock (in filemap_fault)
- *       page->flags PG_locked (lock_page)   * (see hugetlbfs below)
+ *       page->flags PG_locked (lock_page)
  *         hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
  *           mapping->i_mmap_rwsem
- *             hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
  *             anon_vma->rwsem
  *               mm->page_table_lock or pte_lock
  *                 swap_lock (in swap_duplicate, swap_info_get)
@@ -45,11 +44,6 @@
  * anon_vma->rwsem,mapping->i_mmap_rwsem   (memory_failure, collect_procs_anon)
  *   ->tasklist_lock
  *     pte map lock
- *
- * * hugetlbfs PageHuge() pages take locks in this order:
- *         mapping->i_mmap_rwsem
- *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
- *             page->flags PG_locked (lock_page)
  */
 
 #include <linux/mm.h>
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9c035be2148b..0fdbd2c05587 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -379,14 +379,10 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		BUG_ON(dst_addr >= dst_start + len);
 
 		/*
-		 * Serialize via i_mmap_rwsem and hugetlb_fault_mutex.
-		 * i_mmap_rwsem ensures the dst_pte remains valid even
-		 * in the case of shared pmds.  fault mutex prevents
-		 * races with other faulting threads.
+		 * Serialize via hugetlb_fault_mutex.
 		 */
-		mapping = dst_vma->vm_file->f_mapping;
-		i_mmap_lock_read(mapping);
 		idx = linear_page_index(dst_vma, dst_addr);
+		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -394,7 +390,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
 		if (!dst_pte) {
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -402,7 +397,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			i_mmap_unlock_read(mapping);
 			goto out_unlock;
 		}
 
@@ -411,7 +405,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					       wp_copy);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		i_mmap_unlock_read(mapping);
 
 		cond_resched();
 
-- 
2.37.2

