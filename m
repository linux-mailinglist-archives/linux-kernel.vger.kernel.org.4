Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367A55FE77A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJNDPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJNDOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:14:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721C61F2E5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:14:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E33nZo006589;
        Fri, 14 Oct 2022 03:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=9UkqaIPxVIAGRp4AHqMGFSJkoHo7vYoVRFk1XahV5z8=;
 b=beoHE4A2zZR1WHmaRroXAfVJ84/y+nX3mM19BJaZPuwdbwwwnBdnDnN6eSbq/4tAm6qp
 qslX3F4Q+S3PyG3j9yl1r5q45zkYHxCL2pc2sqRTrFtdNHSLbjl/eOPl1XQ9V3FcrhlE
 eR9qcMFX32ogB/4v4NVga9kn083N1WrkKw1OpMgghmLxqFbh8cuc6hPgPVl23rs2SMPB
 0ZzgXSdvLF7ffuTYr+qzKKUyldg9oxqY+yTcP7ysXmH9slNyqbj2VQ+t5qjI/++16zhJ
 sAIJ+1XaTusEQ6zkdMvEumQJQgq1O2rA/Vuv5cXvtfQf0POv8ToiNGedszYs2H9ON2Vc XA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6mr29k1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E1eWcv025311;
        Fri, 14 Oct 2022 03:14:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn716v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUXRyubV9hzkGbXEOMsJL/tUns2elKAOdl8GnZJ1JTXeFXxBbL4r4Lv1JPo1r92R6L55uFR5vlgTdwG9NLXFZ3uCHv98qjLXUXTHu0jliH28BZ2blRLmv0hoxv9x3c55sscT+TnIeRRz5+Az4KfRVhVkz+fwmoClVPpJp19QV/ueeBnpnumvLPASZ14NV1b5LXO4l+3W0SFWDPrTVb/M0EC7Vv5ZBaqhVDolqO6w3SSvLBe2OCdSOTdE5q18thHBQGBCk5a0TKiIT2qUOTJnyFIlZAvOLia/e4Nw+JJ9aHUpsszlaCRWjEA/6lGgryrFmx9f/S3z4Y1CuyetPvkNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UkqaIPxVIAGRp4AHqMGFSJkoHo7vYoVRFk1XahV5z8=;
 b=V8cWKj3vsFr6GaYB/CJc+R8CiVZ++h2xDY2xjcTxJljmJBVlWkED1YXvGKTqxJHp/GuRkv7MBdaBBFjLjvSXT2CLblStUOuEMjUL+z4nASKy4a5yCshcruKeknZouxl2FMWdED8ae/aVJmxQ1x8OHjrBk/+B5BZ1UJiPZbzFFmm8qUsYDRCm+mZk1eaWAQeQFbUbNNlGMeW0o2t6UQxfwM9YsQxrSSYkn/EQhBO4CjyWNmx8yuNyHGEAeJ6OW5j/xbbMZE4YxCoFvlViKjTiJsvJG8R+C/Q8Psy+ctCkGhuqwzQQl98w50mbmMbl4zw6zEjOBCqLJpD7177V55NvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UkqaIPxVIAGRp4AHqMGFSJkoHo7vYoVRFk1XahV5z8=;
 b=r0nbVOZjxFge0ealZRjq8naKYXXwx4R8HRngtvZ4iXEpf06L14AJoJ564gh0Z2qE2EdZtMIS2U7QzWpvmoEdGsqb2+ZwzYcfjMsw3O0GREdl1qwPQdn6LwssdDDHhD5ItbDW9P//0d3NbSu4NTCITz+nKH0zwilOhf4ZsD2xHqc=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 03:14:30 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8%3]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:14:29 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 6/9] mm/hugetlb: convert free_huge_page to folios
Date:   Thu, 13 Oct 2022 20:13:00 -0700
Message-Id: <20221014031303.231740-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 5572897b-ca4c-4c65-afb2-08daad92351a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Lax5pIOuAsvxvnALBUIxTDdvu9n9gubIEOnO7Oh2sbxA4kJgPMNV2NUd7E+pEUh09owDvVF6LB/aq2MDDdYp9eet8yihifK/NE77sUeEzb/MCJZpwA5yGczqkeXqpfCSyUaHm+5ADcnKZ2nHK+kDYAa7mbju/70ZsD3ZfS0L4aPz5YXkzjc9rueEQWyt1xP9Mb1fhqccPPkMtXXqG2OEYo/tjRWNXeK9jXGKVRLTwkun+nf60gPMmm+1xWqSL0uv5I3YVecJiFpO+r6wAkWb9SP+7H+UzGvpQdPRwRLfiXy52SSrTPSry/8QmB2IZ2WsLBdwuAS6Z/c6KstFYYWL9VY46tdJNIYX6MrGrggh/teHGwZCH+amIv1vyzyViX2zKZxeIOjlQq/6YqLDIGLYpAgPs+ph/TEQpEMX7ISGB4uhQVzAykM1zKiMstS+LBUjfP7n9yEEOLRy4EAEdQh0Yoh71Xpz4bVHOGGVL40khtJMS43M8GYrJbr2ns2fgOM2AwyVLfiBJHKMR/2IW9aBfpsjCWzBAwXqcU+H4NZuE1Qkt9mvWdKRlUwKqolB4xXchLn+PyUQWoNyldtM1T6g4d/pcftW7a9x1si0gRmqk5SrwSqtKaew2jU5tBmBYtOjgVSkWWrpsG58TPC5cpMSdK5BuGR3DVJDkrawJ7LRHrtqly8FWr/Azi09g0JW3FIK3bgDfP7JIG67Z4oMTBVKdMiij6LaWnf51Ax+4N90PtCn6TPe5kFtdivatip+p+E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(478600001)(6486002)(8936002)(66556008)(66476007)(41300700001)(6512007)(5660300002)(26005)(36756003)(2906002)(4326008)(8676002)(66946007)(83380400001)(44832011)(316002)(38100700002)(6506007)(86362001)(2616005)(186003)(6666004)(107886003)(1076003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xzXqxjnh5aLIAYnUh4Eqv8X75jfrXiDeyXi42J2mreHcgLAKCrAbLg5ureRx?=
 =?us-ascii?Q?n6kE5XVPXP6NGnJz4c3DTcN/CHC+KiVP4n5FZW2ddpYHgT6W5X9Oj4DoP/6K?=
 =?us-ascii?Q?XmwCTn3ZVUrLnlB0utINnGcATfo6RPYL7wjx3rH7XDzdJ5QZQZqf0WnI1ets?=
 =?us-ascii?Q?QK/vzMqQLrpN6c5vZotfYIlEEyvo/t+gWPB/PfklLuhc7mtSy4FvlLZWpAAU?=
 =?us-ascii?Q?1sOAbZb1NKj86IISPE8Yd/aBQSnHR59RbrovENcU4KDk6KXdRsIkuIboG1yP?=
 =?us-ascii?Q?egx1yCmGENWxxx2AfEo+wp4e2hOiBQUiG4hhVz3wsJ6K+ZGowQjA1/MaQjDZ?=
 =?us-ascii?Q?bHdbiLgqFgSWGYZwNJrKHKEX/CO+8Je3J4xCQ9WtGOd2G9kpP/4LRTnaTLrQ?=
 =?us-ascii?Q?ntqyjFPD90hXNvkp3xbKm77GQph6QRmPnDFXVtTKl1K+RgPLTJsTYR3QCw1h?=
 =?us-ascii?Q?ltGkYC9Ny3ENVxFG/T1C9uKeg3/A5sde2K8chWuRzb3ybdrLKobwjukA/zig?=
 =?us-ascii?Q?f3WEAITXcuMfV9ODoBVnr8C0Avp3hD2KRCXpayvkjgWFviSsezUcgfoSpkud?=
 =?us-ascii?Q?3OwZ3udmLij6swN54OMT2pwDF3YjnmogErrAL43jpo/T2kpI0zCe1V4jniYK?=
 =?us-ascii?Q?H4iawqiMr2gpFQ3gIYGjFzhruu/myeQvmJHExFUQDF+TG327upwxxR8PYtXM?=
 =?us-ascii?Q?2npgl5yMvV8Kb7Nmo4TWXwND7L4kJj7Rj5wkprohbO7Z5ctxOmmTNooTzWIp?=
 =?us-ascii?Q?FPCRD8QU07semBMWHsmppfmTOyJSYxyGfRt2yuOJB8IskWQfyEJphvldwsMc?=
 =?us-ascii?Q?kNaDpzBgjKN4iLUCLBg7SHpHrP0UdPL75b1rGvSZnNkMQ06Dch/WoeNRZZth?=
 =?us-ascii?Q?Vk68tm/Ha4X4KQ5o+1XKqlTMHyR4L0Q01ixYnZMi+r4PARJA+ThppxZSHApR?=
 =?us-ascii?Q?4J+iUcDgZoY1+d7vuvLPE3znqZJhTKxx2Bu+dh/y3PJzxcWZLIOKl1QIrDW3?=
 =?us-ascii?Q?ZbYwtwThcgj/zZCXrn82nxc9Cav9KiW9pcR/qleYx+QqJh6NvS2e1ZiSNCpa?=
 =?us-ascii?Q?uPEkHCBle6bLVWxBUskDMDXBtDdcjAeyRF1tpa+1fBIvsL49xo6OwLfXMWny?=
 =?us-ascii?Q?dNvb7BNkDHHA2Vwg2/gQjLxVkigXzXWktDXAFgh1WFXLojM2WhYtsMGUUUbr?=
 =?us-ascii?Q?33k78CrqpAbpBQccZpYotp6VG/aw8klk4L3oGx21PlR6b5H/165PNUwz8rh3?=
 =?us-ascii?Q?5yXWCGpPEzyVYPiqLMhDffzjU4E+9S885o2Wa7TqY2lAIc/ffdw2jBjPs0aX?=
 =?us-ascii?Q?VF5tUMZs4e9LshK8iTwDy17cuBvSaHZP6Rlp4vEzSab+9X4QvMBidL2RsMdo?=
 =?us-ascii?Q?y/2rBJT+szkpEWatMPnCV6Qirm5TLRhYnqoSNooK9tMu7bjYktvVP+Qc/Hsk?=
 =?us-ascii?Q?28aX46k7Gskq3c0kOm/pnTf8HgE91R2dysic5cFxhKaz+zlrjWs3xdSe1ZID?=
 =?us-ascii?Q?qLaJ6LFyJsDVjHbExzGGR4SKXKXGUPKviwCO0PYLpgjlyVwuxq3BsUbiZw9P?=
 =?us-ascii?Q?+uucsg3UBUhJlSGmkIkrTzU6joay19uXfwKe3otlurYDqQHC1UQn/4bkwHFK?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5572897b-ca4c-4c65-afb2-08daad92351a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:14:29.4903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGEP8qh9oHCHSwynRrDGAkyrjIkMizaXEJi5Q8TUvhHJKmWVmHb1pJZv9FnoWyKVFHYq3lKMDV0k3iT7Ab3VIy8GUqlwyjCvxYBEBNo8YOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140017
X-Proofpoint-ORIG-GUID: GmNl-L8uOwKaYqJ_n1erL4C-6NSAQnAz
X-Proofpoint-GUID: GmNl-L8uOwKaYqJ_n1erL4C-6NSAQnAz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use folios inside free_huge_page(), this is in preparation for converting
hugetlb_cgroup_uncharge_page() to take in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 44a9a6072c58..5228c2b805d2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1688,21 +1688,22 @@ void free_huge_page(struct page *page)
 	 * Can't pass hstate in here because it is called from the
 	 * compound page destructor.
 	 */
-	struct hstate *h = page_hstate(page);
-	int nid = page_to_nid(page);
-	struct hugepage_subpool *spool = hugetlb_page_subpool(page);
+	struct folio *folio = page_folio(page);
+	struct hstate *h = folio_hstate(folio);
+	int nid = folio_nid(folio);
+	struct hugepage_subpool *spool = hugetlb_folio_subpool(folio);
 	bool restore_reserve;
 	unsigned long flags;
 
-	VM_BUG_ON_PAGE(page_count(page), page);
-	VM_BUG_ON_PAGE(page_mapcount(page), page);
+	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
+	VM_BUG_ON_PAGE(folio_mapcount(folio), folio);
 
-	hugetlb_set_page_subpool(page, NULL);
-	if (PageAnon(page))
-		__ClearPageAnonExclusive(page);
-	page->mapping = NULL;
-	restore_reserve = HPageRestoreReserve(page);
-	ClearHPageRestoreReserve(page);
+	hugetlb_set_folio_subpool(folio, NULL);
+	if (folio_test_anon(folio))
+		__ClearPageAnonExclusive(&folio->page);
+	folio->mapping = NULL;
+	restore_reserve = folio_test_hugetlb_restore_reserve(folio);
+	folio_clear_hugetlb_restore_reserve(folio);
 
 	/*
 	 * If HPageRestoreReserve was set on page, page allocation consumed a
@@ -1724,7 +1725,7 @@ void free_huge_page(struct page *page)
 	}
 
 	spin_lock_irqsave(&hugetlb_lock, flags);
-	ClearHPageMigratable(page);
+	folio_clear_hugetlb_migratable(folio);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
 	hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
@@ -1732,7 +1733,7 @@ void free_huge_page(struct page *page)
 	if (restore_reserve)
 		h->resv_huge_pages++;
 
-	if (HPageTemporary(page)) {
+	if (folio_test_hugetlb_temporary(folio)) {
 		remove_hugetlb_page(h, page, false);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page, true);
-- 
2.31.1

