Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D25E547C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiIUU1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIUU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:27:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A66A4B1F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:27:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28LKFolo001258;
        Wed, 21 Sep 2022 20:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=/4jHefN9pHRE8l3sPijWyECV3L96Vv4AHyewMvKdmSs=;
 b=AAQ+GALfhGDCLpha3thcQMoZDWRe/S6IQguLJQRlwopOyLSqPx/Zt3rfJq6UQD9KD8DZ
 FdkFDHdJ0j/Ty8W46pliNR1A+KSGAOj7ZjsxyIJuvGgHkBDkUIaeBfIRzHUbHHikEVRo
 swEninEH7y9SWC9ZeZ1VuWO49REP74fLGM0HcHtGcmQ9z7PEE1Q+2JQp0cTmrwxig7Nh
 2k4ll2eVKg/oltP9759KsjnyWAi0jphbg8BnZiFzhcTHTg9YQsZbUzxxrz4mVen/MA1T
 vHVQfbI+ENP3kKdHmGa7K/winkg+pgvD4oTg9PFTMhRpw80kSE+RZx4tSZKnI4kEBNbH qA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68mbmwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 20:27:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28LHoQg7027851;
        Wed, 21 Sep 2022 20:27:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cpugp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 20:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSIUdtQgSvrHzfsbdm5iuhERS2xXhXZiJob/XLhXv8ACKerR2oIUWcFQHOi0Jz07X/3k1FYqI01X7RgORIXZT0M0eF/E2MV6xxV7PW1eNlxOjWMfCdhbZVI9Sc37MLSZlS4QKZTGaTD1QGyWdiVuIuCAbLixEVKtoamp6gohGHp+Ji+7a0wcN7hMceCvQarXHGJgd2skzCr4P99pBqSvR4QvLPFqHNz086spmDBXN0VRwtV7B5bhrqHOw+Jfr1ygMCXsKmBsnxtTwY9EqYKPoV/2pM1LuAfPKOMl1PvKA0OjrWkNCsZweN6oIRZZiyFTfBAh1FUYXDzf7r5LFwbawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4jHefN9pHRE8l3sPijWyECV3L96Vv4AHyewMvKdmSs=;
 b=Vnuz3aKWuuuyLIpoFuZ4CFvheLb+azurRGvfFtNtYZpZycC2363YhsJmOw0t9DSW9wYETgb4LQUxi47hAqi3+1vJ9U3zgMlj4tF+BLOHzL70m5gOwA5LkvJ8Su7keWL8l4SVd1pHt5b0I8b1bdVFIf2zXwy4U0dc7jGoOy1uklFL/9N8ekQbKILJjaUZ6yK+G5pH3idO9e4aYgjcOKO+2y+05TmQh+5Uuyjfw+s3NOsLGDOC6pX+Jm+bRpSgfxMOuEIxHaOZXIhESU6yHC7p0VAP3cb98JivvrR5jTDXJSxDwd0X+wVt9JAtOaxXvGeOtHItmKPr9/Gfe0dP6SDbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4jHefN9pHRE8l3sPijWyECV3L96Vv4AHyewMvKdmSs=;
 b=m3hHUTiODCAlFF2CIf3X+Z+t2WwjY5tLt3J3sNHtnIxO62nz/fP1+AQziH+4qTM7hNhTq0chb2dr3163nSGPw59+9KKH6fSu9yKOS/In7HxWTGhbLMYi4l/hPFsagFM6YRG+UGMrDaV9Gw/dGac+bfkrTlVGtYIG8Bre9RYeOME=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 20:27:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 20:27:06 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3] hugetlb: freeze allocated pages before creating hugetlb pages
Date:   Wed, 21 Sep 2022 13:27:02 -0700
Message-Id: <20220921202702.106069-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: f22a483a-28fa-4e72-6397-08da9c0fa67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SssKaBY1Gcr+Q65BcEAq0fxgcdOZDuNNSk1R0REhb9RHCjrAKGEvqQwM5YT8a3jtiAUyeuPxk5E3NhW1c1K9QnCfAPjjlbCIGGkVrgkcvTeQjJf9HURhyiRi5D1JCw4IQv0JPSnvCsf8xiTJ71HanYDaGggqvwfSzDQ5BzQyJ7aDZklYvTQK/xcILUpx8w45jNxRwWhXdD22d6yggbYNDRRQU0mcpLpEILyQcr+5x0tOvsmnG2sYAaJJRrnPYWTZkVuz+P+HNlEvqac6JPWnAOkyXHs9NN7eR9gYEqEYBU2eyPgbns9g869pSpA75cldlURftGygxzeVDDqVhLVK6Ub/mR/dOt1SuqW4ixRjXwegoD6QF6Pj8tnqAoDPQEGC1n9J0Dyu0iwd44H/FULTCIcJtWLWlb+FhuHvZk8SZwFi/WaAmuhfjN251BsX4VPmd7v+zUEYhYdnfcBCRuuDbpz0l7zqgkd+EOGWQnd8Vw24/DZ0McuEBQlCP0p1gCbXdtlJzHuQ93sDxxUhEkdor5m26bjMc+ccxDmRm35wHsWqUKdPC/bpjfenhvfXf1ThF8PuSgtbY4wx6VP1b7Jjq83rxL3N79qjUWs+JVb86gYuNQUB4wStRSWgXJ+p0jRzxPqyk5a6TF6Z1GmM/wKXvGIVigPKwQ9myWykqf+FptcH3E3+l78hzK8MXRm14VpZG4tyQeftTeRVDL1E6/hKEv6vlNpm8mgZIpBUtPEoZrscjKujZselT5xuVHgJ0uyPUPsVzVH2BTnmZ0G/hKWBzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199015)(26005)(2616005)(1076003)(186003)(6506007)(6512007)(6666004)(107886003)(30864003)(83380400001)(2906002)(44832011)(5660300002)(4326008)(54906003)(478600001)(6486002)(8676002)(66476007)(66556008)(66946007)(41300700001)(316002)(966005)(8936002)(7416002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9pXQ6LxfHx1cqKck6PV4XIRsnpiyWIcHK8Dw/8q3d+FblbOS2sZdobFQbbs?=
 =?us-ascii?Q?nGmnmsMbZml8UIaNhA3HcOc6lzJFxcSwHsk5kA+BYzFkLbcOZxDo9m4yaSpN?=
 =?us-ascii?Q?NUtluvZz0fy/oyNHS4mBeuJEOARdavAKtJdAPT0WH2qTXnTc64yeRP0qla/F?=
 =?us-ascii?Q?8UR/BfY9v5hRt8AkrpcEZHz43n8q4CGEYAXR4+eT6JNWuVmMduNrXnwqz70d?=
 =?us-ascii?Q?iWdcMjLKOrgOecZNlIkCLmwSxRSR+LACbeKgFpIlEadtwmc10Jdrabsvye0J?=
 =?us-ascii?Q?QdswHDsXr3eoWyl0szp4OWTwZVyUp43wjAHQHByw/YPlMN/KUD0y4Rno58wB?=
 =?us-ascii?Q?mCPAAVI0LK+iVxcuGhlTPIXE49ZI2dgO/Q5Q3xLprfDWl8CxEb++hfaZJOjJ?=
 =?us-ascii?Q?+HE4CiZf5rmjABdNbIbvItSQBRUSx6Ycx8zU8S8TdqDYLADIPgcFf6UL4Oky?=
 =?us-ascii?Q?3s5meFszUljHG0QIGvl7vugMVYmVYKAtd9qSc3S6hbC2puI/xJv4rb6Ar4Qm?=
 =?us-ascii?Q?ypp99hOxONIopeQdzibpCPHGnwYvgOntp2rj2XMSajN1Wze04vvp0LCPUA4M?=
 =?us-ascii?Q?1NBRy0ZocS4eefk7ssZNo0OJ9IV0vqUTm0CY4fy75oGri2hXKOBsvreM7Bon?=
 =?us-ascii?Q?g/DhmV7nMd6FI98CHyffAzRHBF2v2tNjznn6xlYi3oJuQWiTTUVZKThIZOvZ?=
 =?us-ascii?Q?3dz4x14eIZ3XVxeE00Be7Rlgctt3U+MtoNGZ6kbvWapLNUjyNzy9anCnSFDi?=
 =?us-ascii?Q?e1gIN74Uxi6cENDhFEH+AAGRrVKqD7JJO6GEt15U9hly0fXtPJAB+O674MDW?=
 =?us-ascii?Q?umkWgtGQyFiBt6eGtnKHNzvim00WL39JBawMiD42cOrDxzC5VyAMTadgYf38?=
 =?us-ascii?Q?Pz09sQf6ROg6+CRt5NvRMCP00Rl8kvVM6kXaminyvz/Q1onb8CIF9W068UWs?=
 =?us-ascii?Q?AJJyaBSZosz/vMNuJmcthu7Tl7vl6FTfHdjuW7GanR74DpJ9OxqjOL6+70vJ?=
 =?us-ascii?Q?nkC+z4uIy66tPIeFUxLIIwpiOATwyAQuunGHhZ9Ep2DAjZUBqORJe8drGCoC?=
 =?us-ascii?Q?eFEVh1u+mWxE2uTbZvwbhUDdhB+n3Vk0gvDAVTdzj/tfmEPvjlJbfShNNBu6?=
 =?us-ascii?Q?lpqTCMi0oFRAfimCqeyfpUSSdtZAOHp2wnF/S6FcO5M34ciep5+00D7Z2Pa8?=
 =?us-ascii?Q?bx/6Cvf2SfNwjfmcQ0NYWOXvf1paZ//yA41sVhfU3ihATsaKpfly0Y9ctLOf?=
 =?us-ascii?Q?yGKmiX5el0/vr4DDfG5T+lM10hvfwaVckTH5uqgd/aZGYVS2IIweiOZMZdZj?=
 =?us-ascii?Q?VjrCNVT/urqBbkgDZLksY/xJIEbj1ob8V9Zaco1K0lot4khkolY0+0ruQNwb?=
 =?us-ascii?Q?gBf/trlC7VeFKDkRNqMR2KO7i77D9VdtY+ZJEk78S1HZN7KRVx0OXrW46dwZ?=
 =?us-ascii?Q?P+MAY2/cyhCTmpYNhopVUwhgMCebS7KAV0pe+9EQGgfkRX7pg7MrjnDuj+Qb?=
 =?us-ascii?Q?U+z87G1zyayDi27PufZP+k2yefSQI3U2qPKrlgKSh+d63W7hUlGJqD96h9Jv?=
 =?us-ascii?Q?9RltzzbZ0kbwvGDfRedg4C+Unfzd4FLBSMezHgC1uvPaXzkUyj0fLe1Pp+nE?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22a483a-28fa-4e72-6397-08da9c0fa67e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 20:27:05.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4Lwq6D1btj4GqaW2f/C+ZmJQ2wAKESFtic0J08bZDub4sNdJrxixCki32c09Iq0eMiIO8GZobKr1IHl3f5zpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_11,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209210136
X-Proofpoint-ORIG-GUID: 1oEY7Pn1_F24I-VZu6Qv15IL12l5hGf5
X-Proofpoint-GUID: 1oEY7Pn1_F24I-VZu6Qv15IL12l5hGf5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating hugetlb pages, the hugetlb code must first allocate
contiguous pages from a low level allocator such as buddy, cma or
memblock.  The pages returned from these low level allocators are
ref counted.  This creates potential issues with other code taking
speculative references on these pages before they can be transformed to
a hugetlb page.  This issue has been addressed with methods and code
such as that provided in [1].

Recent discussions about vmemmap freeing [2] have indicated that it
would be beneficial to freeze all sub pages, including the head page
of pages returned from low level allocators before converting to a
hugetlb page.  This helps avoid races if we want to replace the page
containing vmemmap for the head page.

There have been proposals to change at least the buddy allocator to
return frozen pages as described at [3].  If such a change is made, it
can be employed by the hugetlb code.  However, as mentioned above
hugetlb uses several low level allocators so each would need to be
modified to return frozen pages.  For now, we can manually freeze the
returned pages.  This is done in two places:
1) alloc_buddy_huge_page, only the returned head page is ref counted.
   We freeze the head page, retrying once in the VERY rare case where
   there may be an inflated ref count.
2) prep_compound_gigantic_page, for gigantic pages the current code
   freezes all pages except the head page.  New code will simply freeze
   the head page as well.

In a few other places, code checks for inflated ref counts on newly
allocated hugetlb pages.  With the modifications to freeze after
allocating, this code can be removed.

After hugetlb pages are freshly allocated, they are often added to the
hugetlb free lists.  Since these pages were previously ref counted, this
was done via put_page() which would end up calling the hugetlb
destructor: free_huge_page.  With changes to freeze pages, we simply
call free_huge_page directly to add the pages to the free list.

In a few other places, freshly allocated hugetlb pages were immediately
put into use, and the expectation was they were already ref counted.  In
these cases, we must manually ref count the page.

[1] https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/
[2] https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@oracle.com/
[3] https://lore.kernel.org/linux-mm/20220809171854.3725722-1-willy@infradead.org/

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v2 -> v3
- Fixed NULL pointer dereference in alloc_buddy_huge_page caused by not
  checking for page before attempting to freeze.  Thanks Naoya.
v1 -> v2
- Fixed up head page in error path of __prep_compound_gigantic_page as
  discovered by Miaohe Lin.
- Updated link to Matthew's Allocate and free frozen pages series.
- Rebased on next-20220916

 mm/hugetlb.c | 102 +++++++++++++++++++--------------------------------
 1 file changed, 38 insertions(+), 64 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5ea0b1b0d1ab..8bcaf66defc5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1787,9 +1787,8 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 
 	/* we rely on prep_new_huge_page to set the destructor */
 	set_compound_order(page, order);
-	__ClearPageReserved(page);
 	__SetPageHead(page);
-	for (i = 1; i < nr_pages; i++) {
+	for (i = 0; i < nr_pages; i++) {
 		p = nth_page(page, i);
 
 		/*
@@ -1830,17 +1829,19 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 		} else {
 			VM_BUG_ON_PAGE(page_count(p), p);
 		}
-		set_compound_head(p, page);
+		if (i != 0)
+			set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
 	atomic_set(compound_pincount_ptr(page), 0);
 	return true;
 
 out_error:
-	/* undo tail page modifications made above */
-	for (j = 1; j < i; j++) {
+	/* undo page modifications made above */
+	for (j = 0; j < i; j++) {
 		p = nth_page(page, j);
-		clear_compound_head(p);
+		if (j != 0)
+			clear_compound_head(p);
 		set_page_refcounted(p);
 	}
 	/* need to clear PG_reserved on remaining tail pages  */
@@ -1936,6 +1937,7 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 	int order = huge_page_order(h);
 	struct page *page;
 	bool alloc_try_hard = true;
+	bool retry = true;
 
 	/*
 	 * By default we always try hard to allocate the page with
@@ -1951,7 +1953,21 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 		gfp_mask |= __GFP_RETRY_MAYFAIL;
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
+retry:
 	page = __alloc_pages(gfp_mask, order, nid, nmask);
+
+	/* Freeze head page */
+	if (page && !page_ref_freeze(page, 1)) {
+		__free_pages(page, order);
+		if (retry) {	/* retry once */
+			retry = false;
+			goto retry;
+		}
+		/* WOW!  twice in a row. */
+		pr_warn("HugeTLB head page unexpected inflated ref count\n");
+		page = NULL;
+	}
+
 	if (page)
 		__count_vm_event(HTLB_BUDDY_PGALLOC);
 	else
@@ -1979,6 +1995,9 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
 /*
  * Common helper to allocate a fresh hugetlb page. All specific allocators
  * should use this function to get new hugetlb pages
+ *
+ * Note that returned page is 'frozen':  ref count of head page and all tail
+ * pages is zero.
  */
 static struct page *alloc_fresh_huge_page(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
@@ -2036,7 +2055,7 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 	if (!page)
 		return 0;
 
-	put_page(page); /* free it into the hugepage allocator */
+	free_huge_page(page); /* free it into the hugepage allocator */
 
 	return 1;
 }
@@ -2193,10 +2212,9 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
  * Allocates a fresh surplus page from the page allocator.
  */
 static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
-		int nid, nodemask_t *nmask, bool zero_ref)
+						int nid, nodemask_t *nmask)
 {
 	struct page *page = NULL;
-	bool retry = false;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
@@ -2206,7 +2224,6 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
-retry:
 	page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
 	if (!page)
 		return NULL;
@@ -2222,34 +2239,10 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
 		SetHPageTemporary(page);
 		spin_unlock_irq(&hugetlb_lock);
-		put_page(page);
+		free_huge_page(page);
 		return NULL;
 	}
 
-	if (zero_ref) {
-		/*
-		 * Caller requires a page with zero ref count.
-		 * We will drop ref count here.  If someone else is holding
-		 * a ref, the page will be freed when they drop it.  Abuse
-		 * temporary page flag to accomplish this.
-		 */
-		SetHPageTemporary(page);
-		if (!put_page_testzero(page)) {
-			/*
-			 * Unexpected inflated ref count on freshly allocated
-			 * huge.  Retry once.
-			 */
-			pr_info("HugeTLB unexpected inflated ref count on freshly allocated page\n");
-			spin_unlock_irq(&hugetlb_lock);
-			if (retry)
-				return NULL;
-
-			retry = true;
-			goto retry;
-		}
-		ClearHPageTemporary(page);
-	}
-
 	h->surplus_huge_pages++;
 	h->surplus_huge_pages_node[page_to_nid(page)]++;
 
@@ -2271,6 +2264,9 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 	if (!page)
 		return NULL;
 
+	/* fresh huge pages are frozen */
+	set_page_refcounted(page);
+
 	/*
 	 * We do not account these pages as surplus because they are only
 	 * temporary and will be released properly on the last reference
@@ -2298,14 +2294,14 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 		gfp_t gfp = gfp_mask | __GFP_NOWARN;
 
 		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
-		page = alloc_surplus_huge_page(h, gfp, nid, nodemask, false);
+		page = alloc_surplus_huge_page(h, gfp, nid, nodemask);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
 	if (!page)
-		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask, false);
+		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
 	mpol_cond_put(mpol);
 	return page;
 }
@@ -2375,7 +2371,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 	spin_unlock_irq(&hugetlb_lock);
 	for (i = 0; i < needed; i++) {
 		page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
-				NUMA_NO_NODE, NULL, true);
+				NUMA_NO_NODE, NULL);
 		if (!page) {
 			alloc_ok = false;
 			break;
@@ -2737,7 +2733,6 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 	int nid = page_to_nid(old_page);
-	bool alloc_retry = false;
 	struct page *new_page;
 	int ret = 0;
 
@@ -2748,30 +2743,9 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	 * the pool.  This simplifies and let us do most of the processing
 	 * under the lock.
 	 */
-alloc_retry:
 	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
 	if (!new_page)
 		return -ENOMEM;
-	/*
-	 * If all goes well, this page will be directly added to the free
-	 * list in the pool.  For this the ref count needs to be zero.
-	 * Attempt to drop now, and retry once if needed.  It is VERY
-	 * unlikely there is another ref on the page.
-	 *
-	 * If someone else has a reference to the page, it will be freed
-	 * when they drop their ref.  Abuse temporary page flag to accomplish
-	 * this.  Retry once if there is an inflated ref count.
-	 */
-	SetHPageTemporary(new_page);
-	if (!put_page_testzero(new_page)) {
-		if (alloc_retry)
-			return -EBUSY;
-
-		alloc_retry = true;
-		goto alloc_retry;
-	}
-	ClearHPageTemporary(new_page);
-
 	__prep_new_huge_page(h, new_page);
 
 retry:
@@ -2951,6 +2925,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		}
 		spin_lock_irq(&hugetlb_lock);
 		list_add(&page->lru, &h->hugepage_activelist);
+		set_page_refcounted(page);
 		/* Fall through */
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
@@ -3055,7 +3030,7 @@ static void __init gather_bootmem_prealloc(void)
 		if (prep_compound_gigantic_page(page, huge_page_order(h))) {
 			WARN_ON(PageReserved(page));
 			prep_new_huge_page(h, page, page_to_nid(page));
-			put_page(page); /* add to the hugepage allocator */
+			free_huge_page(page); /* add to the hugepage allocator */
 		} else {
 			/* VERY unlikely inflated ref count on a tail page */
 			free_gigantic_page(page, huge_page_order(h));
@@ -3087,7 +3062,7 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 					&node_states[N_MEMORY], NULL);
 			if (!page)
 				break;
-			put_page(page); /* free it into the hugepage allocator */
+			free_huge_page(page); /* free it into the hugepage allocator */
 		}
 		cond_resched();
 	}
@@ -3478,9 +3453,8 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 		else
 			prep_compound_page(subpage, target_hstate->order);
 		set_page_private(subpage, 0);
-		set_page_refcounted(subpage);
 		prep_new_huge_page(target_hstate, subpage, nid);
-		put_page(subpage);
+		free_huge_page(subpage);
 	}
 	mutex_unlock(&target_hstate->resize_lock);
 
-- 
2.37.3

