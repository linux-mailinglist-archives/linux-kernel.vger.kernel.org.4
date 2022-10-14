Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA165FE779
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJNDPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJNDOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:14:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BD53687C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:14:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E386Qc000494;
        Fri, 14 Oct 2022 03:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=4r0kBUhUUQoyOllhANKTHwaqm7Sl8FIuHUpB7uEibbg=;
 b=FjeGlljgeM5zXr/CtGEw/yWRMAmtV/TpJKyxmykdQlbSsDqbVWcMs1GA9Z6XlJoWVOQn
 b+V8WG8MhAik1tvap2DBgQI/tzCuBzO4ZH0fBrsEGm40P4PBtlNpamrS+QrB25TEA0Ip
 hLpCYhhP1hsNPWOuSHuPQI9S8fXAoY9b/PPVsFGWF6bRgvxfogrNlfGnPpk72b0TuqtZ
 +Jn28Lx1RgTo3Sme6fxh3RPhgROygoVbt6ZaLrr57n6+H4MwQBF46vDpTDAVFZTD/NrH
 YtaQKUdyrQgJsks8qu/ehracGiIvov1NBH2jDlD3Nvg4LQCcpGBx1SIAVSqIcckaI1/w QQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6qw7gwvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29DNg1XF009730;
        Fri, 14 Oct 2022 03:14:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynddber-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTZXAwGeQDmBCTvncmLKfZNXZpvgtpMqzooj+qm3XthGZZ3tDyxNJApmqw5CB130ndHPrPj2/pl5kiqb2HTemoqqICA03GtPk+abvBKCijU6Uz7D9p2fcgtKLoSBGF3W29GajXlewcExm6EENe4NtaLdvUmiXjLq4VJCXkoW67H2aPb09nb74Et9ppTOKGha57Jy7d5vTb5DEkvAu2XmnWocpDjcGmiuOxn3advel5bPOXBC418OIPCk8VnAn0Vn4blTuRvfK/c6k/ahbxtf3HDLQpTi9dVzZqJj87NrkJ8meIGm1jVk8IPpWEVP7/iQCnqlwoFPUMeQE9MnBOc7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4r0kBUhUUQoyOllhANKTHwaqm7Sl8FIuHUpB7uEibbg=;
 b=e+jGCe4t3X/kH4+aTPmbd+JiCConFQdkHw3fi5uQWMJbIFjigAUETXlhF5/mUVXkZ4aaOvo0zGKDC/roz9WLgmhIYMWacHTtarmY+K3Jev5AgPd+34ajgPGafaN7HvvD+kWnoNSE6HuV2FzWmWW+T/rMgtDw/EHgFbRuQzsS4vzj8KQrzLbgov+nUVqWHW+f1JXfCEr1yoMWaqA4kzDvMXpFhJAlwALB+h98fJRPFXcrV441i7vWqFsvkB796ALctqdMVOG7iJwjcJZbSPwKA52qN3sqF3X6jMtkb2BrfPF0etozfu0XnW8zky4JsVpVecoTl1zOHl2NE9m6roQn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r0kBUhUUQoyOllhANKTHwaqm7Sl8FIuHUpB7uEibbg=;
 b=G5p0nr92j3ZyxAhOFggW2qGYdokAvufz6gVvxaD3SbwF57bbRp/8yeCP6mWeX6dQgQv0D4qLv7rc4EZaaWUhP9YwOj56RhvCycqw0kBZgyb9ttYurvsoRdDcF1axjQR4fUYbiDBVqPNrtTWQgEAsK/G7J8SqJn4iABcKpkP0VRo=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 03:14:20 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8%3]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:14:19 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 5/9] mm/hugetlb: convert isolate_or_dissolve_huge_page to folios
Date:   Thu, 13 Oct 2022 20:12:59 -0700
Message-Id: <20221014031303.231740-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef9c240-2fbc-4d54-4427-08daad922f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bM34Bz9noFPvv4Sw4dpfbhVG/t4UfUbHvRqF4I8e13OxsaU/6ou2XJxmBDGwnySqrF+/RZz5+I0ewE+F2yjDcEIJjIG2VGK1a/U8W+raaBirkb+RvNzysdRTnlPkwEGA4cCrbCCtiWbQOuSexGQH0P6m0f11E78LSRU16KMaEYuu/LA2dONI6B+975PW539FcP4r+Vqh3Bpi6KFOCFCwOuMkgtApb51OyckeXtZBr4MYWemT417emxJwixU2fblIC1d393Y2kWHDCjcnUePNnualVJ7mOcwvK8e+YKvozlKdoGVr+N7cNt0ze3KFdSvaQFE4rJwGiEfHTr21qKunWnuc+iwvXSQRjqo8rTxA7KRcRoD6gHjFCjbaegKKawJC4bxHyhHtw/HBLKebjr/iIDdjmN2/tU5Qb0lutCxadX5wLUHPerZfprKZ6BgK+Ms7CzgGhKiRJAWQRbSHvvTYUjLibFKFbydzczvFR/wEF9VeIQTg+j+4BxgPOYvZkaIU4LoYzXWtLqN/i06fugeCO2oVG/U160xKAJQ11oI8Uy0PwXuS3i5jymFJjVOlnZFnPlU0EdDpO5mRo7saWM1c8n+hwbBLJ73WVr5HGLcFxIVWjHHwatL837K3sm4gea0I1yM+p3DpIdovSSDYqnQhN8AB4s4s4stGryIZhrWAD+3AksRbUMUSP5c0Z76ACRipf0RhtXeSfb7doWesjbXUn+osT9JIBdnjqk8UNo9zUJTqswF1xVvvyEk5mB1ljyRb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(478600001)(6486002)(8936002)(66556008)(66476007)(41300700001)(6512007)(5660300002)(26005)(36756003)(2906002)(4326008)(8676002)(66946007)(83380400001)(44832011)(316002)(38100700002)(6506007)(86362001)(2616005)(186003)(6666004)(107886003)(1076003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PIyqcFD1kPm2Psf4TUPHab96WU9cijJlKGGGjyKsvWVYzWyrucAoxTwX/wek?=
 =?us-ascii?Q?pRTQtIjH0oxK6vK4l5aewHGrW7czaFsVtaENRB1uu98tdsBuWyYGfiTSadHw?=
 =?us-ascii?Q?W7DsLy0YU6XNJt4ifGWSgavQ0IFjoKjd+hNfJltRyVZif04EKG3lodDyDXoC?=
 =?us-ascii?Q?apzZpKw11rZ2dy+TazThqH8WlWRHUCMjbvq269LkS6YDcnu8gqJ6K+rDVUBj?=
 =?us-ascii?Q?hBVt6/PNLI1Rji6vKnSi5DaWgDXEf1HqHA5XCIvW04Ap79nPCjBbqHg4eTfg?=
 =?us-ascii?Q?2UTbnsb7RZxGt6RMee8GtmXAwoSdl7kuMnZLg1TA7WDPnMhNwVv6/s/lnOF1?=
 =?us-ascii?Q?Jn6+dFa4eyw7Br5d7l9P5lUmmtRyo1W3XGiT1LhQXgMKuGp6wF8vnajg2SY0?=
 =?us-ascii?Q?GigiVmBOuraLqOXM/F+hcc5LU/SVwMTissVR3yVK8S0Jw9xPDOiUX9i13XKA?=
 =?us-ascii?Q?JhKkrbgSEuczCPGbUipM03MfoNrFjyJ2X/PQxNKxSyOC5GMlWIYPjXcwUn4A?=
 =?us-ascii?Q?sy0m3yoUIkQLW4U4k7LeNipmMiofRBzF/c4fS6i3f+92QfbvrrIB7gaFc+L/?=
 =?us-ascii?Q?UzZ/or8ouAorqBvuBScuxvSHzSr+/fWjzknyZPb0ZHSeaWY1iP31mjS8/mzN?=
 =?us-ascii?Q?q8n7UxMLDW/3RQu3qcWY6lal+P8HQCN7gA0PhYyfegZM3CY8jkjAkun/5g4X?=
 =?us-ascii?Q?yUbgaq0p7WLeE7oj5VPQ3yMJSkGLgjKMMck1DctI0KebdaAI+Yb6oMm7dnFK?=
 =?us-ascii?Q?8ZCC7xgp6ccQjh0/6Wduubd3cm++T9Il29bqsZxDDOSVfb1XBQ/DmMreWa7J?=
 =?us-ascii?Q?vWZWr8547XktMsmOJCYs/mei6c/g+CQh8lWz7L6j5h//VEEO3k1Dij//i4Vv?=
 =?us-ascii?Q?1zh6zW+Y1NVSBgPXlhyNrXNJLkz/NlBBg/7WfrDdhpxF0mZAiWFeHxgyRP90?=
 =?us-ascii?Q?rTzwRUMDeUYvMi14J3IxaE99yP2+c/fw26JA/PS2FhjWyWc++8h7kWMF0+qv?=
 =?us-ascii?Q?D4jWA2r6rdK69aF5LN6rPAldfn0JdSjMf3e1FYlRXo32Ys7zcZ2iBGW8YC7O?=
 =?us-ascii?Q?zhxTECNeFUknmNXR2aEOQWoIx/Qj/HErJQBkriPzk7mVTGBhZHlFntNRcZO6?=
 =?us-ascii?Q?+aJDoTa5j+NT0sTW7ehVK31BysKCBuioQ7b6zfE/cWJUKOnZ2udix9aewHzl?=
 =?us-ascii?Q?stiYrGSPNyAlAiyiipNy5PxS0sRWrDYXFyu5VDHbcFEQ+SXFm28RvqmVyLHk?=
 =?us-ascii?Q?kjicx+l7APQkqJX832UOBQk4qMruE5EiFJ/wJol1wrJjdOmQF0zVsVbBBw+h?=
 =?us-ascii?Q?9fL1Jf2X/T9rhZD+JxWTl++xJRCpHZmaTE3ECkxOjH4k24qlceeLn+QazZTf?=
 =?us-ascii?Q?aMskwczK/vyKWnuOy4fuBOAq3lpZiVZsARhrgh8gf/UIhYYNfab/p+8WMDyX?=
 =?us-ascii?Q?eN2qPosqBj3ueXUQ0StXx4FfIGNR4ZzejSKHffo9989NT2WxJhJrvH5n17sZ?=
 =?us-ascii?Q?hYdDh3mciTPPxunT1IH1WXZSdZ6wkqGOJoJfnCUqcVXJUtEHRHaqG2yAn9Ji?=
 =?us-ascii?Q?EcOX7mtGhq6AbxEWoHZk24uZ5c1a0Gb/nYTdP65C64zGBfCAoKsKZCeglVou?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef9c240-2fbc-4d54-4427-08daad922f45
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:14:19.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5y6t2LN7fvIGvLipJqZJRqPOTNSaasJta+BozytKrxX93J8c7nv3OrN0bLSDwRWN+cLzWQUB3R9vI1OEWow7ufqjA0XUPLY35q8E8Bj066w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140017
X-Proofpoint-ORIG-GUID: f7SNV-cu7ldKIF1UQtAN0QgtMpE-0b9U
X-Proofpoint-GUID: f7SNV-cu7ldKIF1UQtAN0QgtMpE-0b9U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes a call to compound_head() by using a folio when operating on the
head page of a hugetlb compound page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e2dcc9cffb2b..44a9a6072c58 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2815,7 +2815,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 {
 	struct hstate *h;
-	struct page *head;
+	struct folio *folio = page_folio(page);
 	int ret = -EBUSY;
 
 	/*
@@ -2824,9 +2824,8 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	 * Return success when racing as if we dissolved the page ourselves.
 	 */
 	spin_lock_irq(&hugetlb_lock);
-	if (PageHuge(page)) {
-		head = compound_head(page);
-		h = page_hstate(head);
+	if (folio_test_hugetlb(folio)) {
+		h = folio_hstate(folio);
 	} else {
 		spin_unlock_irq(&hugetlb_lock);
 		return 0;
@@ -2841,10 +2840,10 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	if (hstate_is_gigantic(h))
 		return -ENOMEM;
 
-	if (page_count(head) && !isolate_hugetlb(head, list))
+	if (folio_ref_count(folio) && !isolate_hugetlb(&folio->page, list))
 		ret = 0;
-	else if (!page_count(head))
-		ret = alloc_and_dissolve_huge_page(h, head, list);
+	else if (!folio_ref_count(folio))
+		ret = alloc_and_dissolve_huge_page(h, &folio->page, list);
 
 	return ret;
 }
-- 
2.31.1

