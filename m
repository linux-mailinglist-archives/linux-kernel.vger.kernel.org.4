Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B305C5B9077
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiINWTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiINWTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:19:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C87A50A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:19:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EM9q9k031220;
        Wed, 14 Sep 2022 22:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=73nPWJYn6DsvU2DsSwVM+vUmrXiJ+Unn+yfCo2I4Nr0=;
 b=LNW7p/CZnL1VS1XofYR6MnqhR6o5jYbOhAXIb++SY1t+V1sdUPRHUeUClajyGX1Lkl9e
 Uj6lwX4rcV/JAoFUcpcbTAcrbGjEHD+F/6t/Kl4aeZNAFZLXKpV9IJWTYAtveD7pHPQh
 bNAc3jgzQWMuZTkRcpkYoFBEAto7v1gi2zNcULFlBv6GMj0D3W81gBWJM49/jYqP+daQ
 MwYbSsTt8s2r9QhZ7++xnu9JCk0C8RQG+Xq8Ustq/8f0uCPoLpw6N8Ne2gZocPCQq1Kt
 eyPrrTI5kjy5dG1RJmnLuN9Ki1d2qhS4buKH0X4x5507A5O1RsvEfQHitcEwYOx+3CX1 2w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyr3shq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EMIItv019429;
        Wed, 14 Sep 2022 22:18:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjym51gxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 22:18:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNBv/mAaAIi7Sioy0w+TZ9oWP1BbJ7Q1A6XqLuMh20yi2bhJKAPTNln2Yax6UbJ4ckPrzNIrOUyej++F0PRdEwmSLV+vHMxl+18ZZgE0mqkhT1081tM6wkt2bqmiu11PcQ3dx8PR1Wb0izLNK/01KzHWhnfj0mhHnkWd1GB1Dz/S1aMBWkLgY8xSLi5AnSIC4PhAx6ybEExbXogYphLKzc0ya7AIQZ8C+TbLcjI0ygXX1GUyb4QB2nky++yO8oPxmDGvNcpW/A3zElzG33k2j9sMJq4jE5X8Gy9UckPjq463Ylj2VLfQwS/0odE4eEHRD0YHYq1T2mNQskpUha8chw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73nPWJYn6DsvU2DsSwVM+vUmrXiJ+Unn+yfCo2I4Nr0=;
 b=e5lwyFU8UHzmECdWMyHxd03fhvK+WD3AynV+p4ohUUf0i0wwvnSBHghDR4guviqNInNlqz4z5T3XHgFoXB5Ito98KrpsAW8M/8ErirwVLk4lukyz6I56AeXhgtxLsMfEeyoHkxUioHdzyH7M66Q3VzZEk6aO9fMrkfBEWBx1CBATcBTLuWSlJYaQTihz8xlKZhp5bgyAuwXNHKcyiUz+uTdiMtsSAmqCn5FT+7IopZikegRC0zzbPXpCMpZTYHG1SqB9eL2YQ6okn4JSzZpWm+jOX3Ok2gAkwH/RtofTnzHYdyvV79QjKVPLVFBhPBvVevV3S9ixRpoCXEvdbgOT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73nPWJYn6DsvU2DsSwVM+vUmrXiJ+Unn+yfCo2I4Nr0=;
 b=z6dHn7E6ls+U4FBDH2lJ83SwofrmPalvBn57L0lE5w1xx8zdr2lvgI2lAoCzAXoG6PIPIogXn/kbJzZPGcVFoey/BBEKi+ugAgtXiubeWmwaapdxK5J8OPpiPZgwJUIj4PxuS9jpWkzDKBmwG+UxV0o1iLFnfwV83Rqp1XY35Vo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Wed, 14 Sep
 2022 22:18:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 22:18:25 +0000
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
Subject: [PATCH v2 3/9] hugetlb: rename remove_huge_page to hugetlb_delete_from_page_cache
Date:   Wed, 14 Sep 2022 15:18:04 -0700
Message-Id: <20220914221810.95771-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914221810.95771-1-mike.kravetz@oracle.com>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: fed4d5e5-0d02-4fb4-8661-08da969f0b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDpbeEoGxAFAIjM+N3hRcxUBTXU76t+yZo46xiyRzhnydcrxoa0IsGxnhjxYlwRmR4yCctT4UPbe4fJzwlJDF9fN3DzdPhxaDihKYHpKqsC7mw9X3YIYX3NCPR2+PStnSGzfc5uOrF2zFKDLpde4VTXzcKs2TUxNGKGxGyof9j/gYN6pbM7tEd+Gjk/d6MLHzoZ/3UTwVb44J9jjkOU1sulHDvLYb+sCgEit9M3cGUlrr/KOu1/7p97ebyaI7TlC94Gt/ieK4oQOapjx2CYYnZtLBoe9aEeNk8mt38ztZdy16lxexKzZJVr5LMOAAIRN+jK5RlgrWDYEorSGmvGx/wQ1lohV5+PAODB6HN7hU7dCG9MQe2h/8hDPuPBeJmmHSYZUQtgy+VyfBo2VYFaupP/2gkyD5rYsLyjwLhlBemYlBzeZkR5PR1UYpONJeYF+TMYVdrVL1HLylTkuMiiyNAwuMF5P4+s1MgQnk8zWcSeQR31gsyJ9ekoG3HhjRwPyy2b/m+UGU1UskGszLu1GiO76seBKa9eghPdk2g1gnJkT1oHAwj8xYdxgPjWfLH6Ht3mfiLb8ycbMRC8YSZ8FCt0qM9tmr795lB7NxDr1ZXLEIFtmyo2EGVFyNgdn71u2sEvgfOpsHdNgbtOLKxDPYcNjNbuaLcCGXJkK2KyroXGX6Oc2N7ZF1p2mwfom6VKx4DGdkO/Vunf9Y1aGiYzI8vYuByKlOMObz9o+l1ND50WgxMmbdRnJXrrDAUel3vhC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(478600001)(38100700002)(54906003)(316002)(36756003)(6506007)(8676002)(4326008)(66946007)(83380400001)(186003)(2616005)(1076003)(5660300002)(41300700001)(107886003)(66476007)(66556008)(86362001)(8936002)(6666004)(6486002)(7416002)(2906002)(26005)(6512007)(44832011)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JDPb/tYT/opNocd87JMxDpK9jRdTTVt2q5ofh+7lBBCg21TeQIHCWi1QkikF?=
 =?us-ascii?Q?DWyJCoeY3l2cpBj/XRxO2H812OqTSsteSDQDFDE95mILCkE3cl3xtweUP4Z4?=
 =?us-ascii?Q?cLnXaxK8HsoK7a+H4RCAswO5cKhboGB8O7+PcTYQqY39eO02JmklEwCnqm18?=
 =?us-ascii?Q?ZYSKyQsxyWad7HOU2HtE5Z4kS2rzpHp24lSkaw54Bk6tGD0b4G/wBoMa+njN?=
 =?us-ascii?Q?UVM78wBarM0JOWMmOuSTy1rt1NPax1D+yvXvB7f5cLbpoAWUL/Ggc2CmcMcy?=
 =?us-ascii?Q?RsC2R1/wYiAq5EFOl1kPJWo1zdtQ+IWNSXoZsD3OksnG6hxVNUuFeNizGPmG?=
 =?us-ascii?Q?KCX54QI3RhcAVuvI8ED86XdQvlHt4BwQAIhJoLuD6oLDglLx859Gd0YVyjQQ?=
 =?us-ascii?Q?WkZTGVCfC3tAHFyfw8eqBNq+PLUx3ugkUlQ6ICN6IgaMenSLVtNUmRKeBwVV?=
 =?us-ascii?Q?5aNWNCmj60gm/C8AUR0COH6g4VO/dhWX7d9AhiVdfQq9irMjoDayPFLkeQ6a?=
 =?us-ascii?Q?henPomA2uuCNTc9+WTQb3Qf0MuLdPJS6+r94KI27ugyXADEleDPk+eM2ClHw?=
 =?us-ascii?Q?TKv+w43K9+c30kk90sSaaMQdVmNH6zUbfzUrAeilY8VcNwO6KAImNBWr5bq2?=
 =?us-ascii?Q?O+YfUmeqXXY6GGlKeG0aAeodpcpslfSqzKORNqfu0sbJmN+/4BGpnK+60twt?=
 =?us-ascii?Q?bTUAsY6eEb05tzQ3jEdeGPtl3blPqmxyOV819PJR0dNZ2DVa6nyy1lsQeR4V?=
 =?us-ascii?Q?C5ibTGRHSXQMpTLlGfWanMCH4ZMF5p/I9DXoyAKVnWMo0zrPtnD4YDxc47Qw?=
 =?us-ascii?Q?tUkyH6b0UYszoswwZYv28DC3j4v+ljt9zYWl1uH+z2rZ9URIZmO32SQmu+Dc?=
 =?us-ascii?Q?qNkZkWgZab2xs5NkHBg/imY0fhCSLESVHhm8vG80qva42r+b48Er26WtAt/d?=
 =?us-ascii?Q?J/0xjnBJc0XMlzZ+IbfVqYCWiNiTKQg33fv31dAEG8raBWpkiqhoASsqfdzo?=
 =?us-ascii?Q?W28XkDkGAacE09wsOipSODcddQQ6f2ytuuMW+EASDy3YD+/hPgZlW23Eegf0?=
 =?us-ascii?Q?F18rGPRk2capgAiPv48GpxSvi8EPQ/6Wnmog8Us0l3eEe1fVpEeN52J/2ojb?=
 =?us-ascii?Q?t1VGzUQCVDRK/PoO0Jsi6JrQgm68UsZANE7AJRMrxK5P66D7f8F4fuJVozcc?=
 =?us-ascii?Q?iM0xOL/o8bOTURoE64tW8tDkRYw9BaJ89n+jkSW4f0oLTLgPUBz4ayMxc13H?=
 =?us-ascii?Q?iVWlMCULzjV7+qH49Z1nwXwGp1GUlzyU2jOxJths/f3d7gV5OOT55gCGhtQ8?=
 =?us-ascii?Q?cUkfiHTrQ9QvjyWJMZJEEvtuaoeIOo2kP8vEH6JduadvpJd2nseq2YTYpaKj?=
 =?us-ascii?Q?XLYT4zQkpnwmx3BvQ8RnDkld9lFU9/CSNPm5xwNKNr3RUzCn1kpT0nDyN1hG?=
 =?us-ascii?Q?PlwzATth5OQ7oSi6mms6NoN0SZW5PUBflSjvlkeXFraYkkSAE6uS1uh1rwJb?=
 =?us-ascii?Q?9sx9yYugXIZ7FuEdKfzxs7T4Mk2S1BVFR3TtLoKuJB18aX75Wwh/mc2+2NWf?=
 =?us-ascii?Q?hTfAOZ51UbUKD1SSM/7ayG/65TKfKEaXeWdnAEDV1tcQXNGQ/vQn8f4HE7CB?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed4d5e5-0d02-4fb4-8661-08da969f0b13
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 22:18:25.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23LCo9UjX8wUJ8WH9IZWTYxqQhnt2ZUV4p7qgUynTouW6Jod8MU0cdjX3lyPxGbbIDnzygGMTev6S9B/Kw6cUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140108
X-Proofpoint-GUID: 0pWXxtYyyBO8C75-j4b6hA0JkX6F332_
X-Proofpoint-ORIG-GUID: 0pWXxtYyyBO8C75-j4b6hA0JkX6F332_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove_huge_page removes a hugetlb page from the page cache.  Change
to hugetlb_delete_from_page_cache as it is a more descriptive name.
huge_add_to_page_cache is global in scope, but only deals with hugetlb
pages.  For consistency and clarity, rename to hugetlb_add_to_page_cache.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/hugetlbfs/inode.c    | 21 ++++++++++-----------
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            |  8 ++++----
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index dfb735a91bbb..edd69cc43ca5 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -364,7 +364,7 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
 	return -EINVAL;
 }
 
-static void remove_huge_page(struct page *page)
+static void hugetlb_delete_from_page_cache(struct page *page)
 {
 	ClearPageDirty(page);
 	ClearPageUptodate(page);
@@ -478,15 +478,14 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			folio_lock(folio);
 			/*
 			 * We must free the huge page and remove from page
-			 * cache (remove_huge_page) BEFORE removing the
-			 * region/reserve map (hugetlb_unreserve_pages).  In
-			 * rare out of memory conditions, removal of the
-			 * region/reserve map could fail. Correspondingly,
-			 * the subpool and global reserve usage count can need
-			 * to be adjusted.
+			 * cache BEFORE removing the region/reserve map
+			 * (hugetlb_unreserve_pages).  In rare out of memory
+			 * conditions, removal of the region/reserve map could
+			 * fail. Correspondingly, the subpool and global
+			 * reserve usage count can need to be adjusted.
 			 */
 			VM_BUG_ON(HPageRestoreReserve(&folio->page));
-			remove_huge_page(&folio->page);
+			hugetlb_delete_from_page_cache(&folio->page);
 			freed++;
 			if (!truncate_op) {
 				if (unlikely(hugetlb_unreserve_pages(inode,
@@ -723,7 +722,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		}
 		clear_huge_page(page, addr, pages_per_huge_page(h));
 		__SetPageUptodate(page);
-		error = huge_add_to_page_cache(page, mapping, index);
+		error = hugetlb_add_to_page_cache(page, mapping, index);
 		if (unlikely(error)) {
 			restore_reserve_on_error(h, &pseudo_vma, addr, page);
 			put_page(page);
@@ -735,7 +734,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 		SetHPageMigratable(page);
 		/*
-		 * unlock_page because locked by huge_add_to_page_cache()
+		 * unlock_page because locked by hugetlb_add_to_page_cache()
 		 * put_page() due to reference from alloc_huge_page()
 		 */
 		unlock_page(page);
@@ -980,7 +979,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	pgoff_t index = page->index;
 
-	remove_huge_page(page);
+	hugetlb_delete_from_page_cache(page);
 	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
 		hugetlb_fix_reserve_counts(inode);
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 890f7b6a2eff..0ce916d1afca 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -665,7 +665,7 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address, struct page *page);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 00fba195a439..eb38ae3e7a83 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5429,7 +5429,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 	return page != NULL;
 }
 
-int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
+int hugetlb_add_to_page_cache(struct page *page, struct address_space *mapping,
 			   pgoff_t idx)
 {
 	struct folio *folio = page_folio(page);
@@ -5568,7 +5568,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		new_page = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
-			int err = huge_add_to_page_cache(page, mapping, idx);
+			int err = hugetlb_add_to_page_cache(page, mapping, idx);
 			if (err) {
 				/*
 				 * err can't be -EEXIST which implies someone
@@ -5980,11 +5980,11 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 		/*
 		 * Serialization between remove_inode_hugepages() and
-		 * huge_add_to_page_cache() below happens through the
+		 * hugetlb_add_to_page_cache() below happens through the
 		 * hugetlb_fault_mutex_table that here must be hold by
 		 * the caller.
 		 */
-		ret = huge_add_to_page_cache(page, mapping, idx);
+		ret = hugetlb_add_to_page_cache(page, mapping, idx);
 		if (ret)
 			goto out_release_nounlock;
 		page_in_pagecache = true;
-- 
2.37.2

