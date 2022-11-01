Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C597615507
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiKAWdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiKAWc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:32:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C441DA7D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:32:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M4FL2025143;
        Tue, 1 Nov 2022 22:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=U8GNRVdIZHDwJjSJicnPzgyXDu2AHHtDvyuYMdP+V7U=;
 b=k0fhNIbQ7b/86LTdsvNqlx8+Qumi+VTZrlV4SQ8iO9ug6zE571yRkIGZZslmhxAMyt52
 7YyaGwcCe/vP3OZ7eDwM23DhOQK1Ohq3nReU10WtdeO96zgSbd91Xwo2dq8C1JU3gfGb
 4o/zJFLeWVEAf1ZES+NopUQgoTjyRMDnbcyretvIT4Tbu8GV9vjxpKM99NjYHCkoaKR3
 9Yii2TM5YxF1U8nE2EydNUDax8+tj6U/xKyGNE2WBdZLhHaWGdPSH1SAPoISYDaLnPg6
 xqsPXSBrJHI708btvSUQbfvEbfELNg0KKO/AtbOUu6N9AcMKGxdbUemVA/IGvqhYxZ62 Ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2afx2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KaD3L014155;
        Tue, 1 Nov 2022 22:32:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmay76j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkUhIQJHBFV6H/8t9sfk1TPzfCv2iL8aV6qhimv8j7BAPvuu0wX5C6k8Rj/4hs+rPnFLilTugVyUXy6s5063cK2M4O+jXbz+pEIP7x7J2Zk0yl0qVRQ3SNXrbsxjAjv7v/PZDJI15htL9bPALZRKCl0Jisa+SpWRf+jwcjh6iQGnjRQjizylnTZVChIqSQlRhngQs20v51niR2ylegk1967AB5dnx4UQMcvRK/dtFVyYQK7H1lidG0we8H/MzDPa3J1t6lmq6KNlS7S3djJt494P6K9yoQ0ZWZ4yrCeYfQOHuJvqMlau0qSNTXsTsf11GTTw9QgpMiTqZiaDpnilWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8GNRVdIZHDwJjSJicnPzgyXDu2AHHtDvyuYMdP+V7U=;
 b=CaBSgOfemhb2VzOmbFGY9NfB5nrcqChHnQ66oX4gsPguu2/cPLxHM/pDf7Ez68z6OCKCkqosT8ugxhx1cJ8NqqonG7mq4pj91d8aVbuS4gF3MvfPuk6oYzRYVNYhetdfRG2i9FDMPe7QA18FeoD+aXDfv+B9+gtrshT2axny/71YBk91FjTbyuE4efG48oxNTP/H/3ATJC7XeJFLkLaO3ppe1fxxL0T/SAo9qWZPm+GXIn1kG+iRI6uuaUViP4r+U1kNOn897eVUuq2/YyGja+M6gvhRraB34icUXRreyw3dz+k3ubbeFrqZ9OUa2lU8z4s1GUfG6TqrQxRGPiQOrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8GNRVdIZHDwJjSJicnPzgyXDu2AHHtDvyuYMdP+V7U=;
 b=c3q6WUBJod9yiAe3MVR3gVEHWjPS6u7zA75Kd4IQhfnG3joUJI5IFEM2vb0UIaNH2MGXzmZo/8g9RjjH2/AgGVN32ngvehQMBiRjCOhEyvqop2Bh8MVh/igzuLdgmSzb2IHyJUjAR3hinv7LS8DpAzCZSuQdwLV7qYdJ/j3ch4Y=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 22:32:42 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 22:32:42 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 8/9] mm/hugeltb_cgroup: convert hugetlb_cgroup_commit_charge*() to folios
Date:   Tue,  1 Nov 2022 15:30:58 -0700
Message-Id: <20221101223059.460937-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0048.namprd17.prod.outlook.com
 (2603:10b6:a03:167::25) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa8d2c5-80fe-4182-bf5a-08dabc58fdaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /L8roKBLr5lc1a95u+kYdzzAKlq7gpQmVUFWJJxDgQtP40D0uZpKYzynY7emrWtr6R8UnoN7nspiZi46Z4hSLNAPMCsZRMvFldd9Vz7nRfYwnuVFX1QHBFTiMuTB70qy7/GV9DZzUsPQMxy9n/uY2chy3S3iMYzJTfMpcEgoGkmCtC1FGJrugidB9vOB+2PL2TVc5JuKSHBABNzHHxJnRxbD9glTfR8aWYxizYT9Uc5dTxGYPg+wJA+n1Hnl3e7CxhKCfY3wYUWJ9d60coEPJrlZhJaYaIyWmRy7AnmEKIMMv2ROFxz8Xak7EDxr5R8b9nYGa7+SFrLo+sUmA7/q/pGi5qCIeIdQKAJCU1h8FVedFf+SZ2zSkk3Ss3nl4hFN5E9OZLoGFtGQ4zEPFsE2oqVDNuDayAjojkloaYglQnsBZO2K0hFb96w/pXRdluNelI751JHUocrPFHc3brQuC4dsEn4Hfl5RPHe08GiY3EU12PR56vnnnMxt49nkKYNWCxzaOq7mn49J8kEO2o2GZiEVuptYUVjaMYNISRDUeOja3nPsf/uceCmGRpnroH2ifqLNrUUCRjTfI6VBWbBZK0V/FQNAHHKznjbUSpTKYLvAHJ2ZIP4ereTpW0MaBlZXty7HQFKa6rkw40esfKFMzn/Qnjd9/fSuHvPsWRDRyXlMjxSlsL9gN+6oEd4uvLggT8wBZhI7h/JdEhsUURs9qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36756003)(86362001)(38100700002)(83380400001)(2906002)(5660300002)(44832011)(107886003)(2616005)(186003)(1076003)(6666004)(6506007)(26005)(6512007)(316002)(478600001)(4326008)(66556008)(66946007)(8676002)(66476007)(41300700001)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cr6mnHx3HDzEBQki4iK7S0Vh+Ph8zrK1Zq2nxlbE4Kixp9OhHcUqSQQcH14n?=
 =?us-ascii?Q?BFnOTsXoF5UWXg4nAs3FMcfHWGtd2XrFCpOjKy7i+BFLUxvpX6oNRf7cpS7F?=
 =?us-ascii?Q?VgnCXK4/dsX0b4SDun4gc0x38oMQK3q35RDRlmn/DEbxWf4kVWU4DUJ4hsVS?=
 =?us-ascii?Q?nHihYq62wpJ9HyCR8gM7P5kA01mROF6qeKzyOtK1P1sjVIu+mxjOPm7DA3Wa?=
 =?us-ascii?Q?mVtBc+D5yI12puewA06si/d24a7C1p9y4mqt+9tsWAVlyBoB2nhFtEpGYpD2?=
 =?us-ascii?Q?LckxpaZ/fKoZDZG+GYycll8bBtlp3CLN94Skwa6hSDq4x9xeKsm6i2t35c2K?=
 =?us-ascii?Q?u8woBQyVScV9UaC6c5Vz5vpnqbg4i4EZ+wfRVO1XRyCiFGUl8OayjV0L7Vje?=
 =?us-ascii?Q?1l2wckOKO04qQ+MYwRQSPb+3uu5ckEf0Ijj28ilAUPHCcup08RIDcgJMyqD1?=
 =?us-ascii?Q?slAe6rqEezEOFYQ5+cA2HwjvJJbg4Cdq8bZ1Obn2BN51sdSzliMUUcVvA3zD?=
 =?us-ascii?Q?tsm7xvpzSpN+Qf6eD38tXn4/QNWFEfkdq/NHUxFmTPAaRkI5YsMGZO9ve0hY?=
 =?us-ascii?Q?uVv3NK8SkYlKA/1as2UUYPyJlNc6xINc2xLJlptO8Dr+zd/2QGoXx8wCzSrW?=
 =?us-ascii?Q?4OFvG1aO1LrE3PxWwp1ybmwSJJRtZ666nBsaDBqm/oiejYv960bD3Ah7lpap?=
 =?us-ascii?Q?ftS145VJfDtGvPMC6r+t7Jr8g7QofUiUG+B7BYLoO0oqDEt4Z9f/afsZdrud?=
 =?us-ascii?Q?dVayfWiaIRhEp4WNrd+y8GGYG/Tiu3uF7UC0f39Fa3HayIXr9JWbKNT3liPf?=
 =?us-ascii?Q?qLtp13hLkBF6AEAaIP305S8yXQ8qOi9CG4Ck+d+knRBDg4P/zq1WaPOCMv6j?=
 =?us-ascii?Q?apNQpHYux9HCrWovscBvJxxLbtY1O+D6c8UcgtbcqvHKwdepJtKgARmHgWc3?=
 =?us-ascii?Q?83rZ7r2NFUibHAVWSI4jaDeGly5cjmcpv72YXWk5YpITcsZ370LEsenUgBG7?=
 =?us-ascii?Q?NZzZmBho/9wnI9twXQMWRJm2I33ngafO5sWqPP8JV2fQffNyFwU0NUhIloNA?=
 =?us-ascii?Q?4+qjUP6bpTgNnex4PtO21BfpBMLSPE5wA/y6oXu0gyl+jRllqImwz3kJHcEQ?=
 =?us-ascii?Q?Amu6N/uOorZNmMdWd6gVbpP53hQzNZbwXsQQuAWqnQUw4vgMVAN6niBgcu+D?=
 =?us-ascii?Q?FbLOO7a0vtfDmpGMm2fVMvLF3S6SMmaXrGKUt6LMvthYMRNSu6IoDCWWU/R3?=
 =?us-ascii?Q?2sBORTSFod3Ww5cLFnleanxWfsaFK6KXUdNOCoQoo1XE5txVJ7IpASnUt63b?=
 =?us-ascii?Q?TWI6EoKise2lW7jleo1bOtc0QyLP9GXwAqetLxL67IyCIs4KfgLzB+tx9MVk?=
 =?us-ascii?Q?us0r5N3JfnlhNjbwmKnOC/TmGNUvx9Df3ckNGDM19t4Q31iB3CmnE+CPxvjs?=
 =?us-ascii?Q?5COtOUGfBUCxgmXCnSkvWw91iFw56i+jrzfcBHT3+t6J3vlsiJ7xWV0J90Mv?=
 =?us-ascii?Q?Y07kkcAuWi964sVfXB9fLnWZYEfMuDk2mMND7cqu3U1DyXV0GPfHTHNohbwp?=
 =?us-ascii?Q?xgbSSspr7bJ2jdsJR5B5ldSFGy8bdfQ13jap16tREK9fMO26JgR2yPZQKdoE?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa8d2c5-80fe-4182-bf5a-08dabc58fdaa
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:32:42.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkQ9oohsh+vj6yLqYTl/ddruHVJeBb8y5w7GYjsOnWxZ/1XaO/T/PtBHctnwXCF0dP3z2Wk7I9ePOBfMSbndL49V8zv/2Nn0GCPbHjLYfXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010153
X-Proofpoint-ORIG-GUID: PrvyYc3TPCdxkyBlbsklyfp4fw8O3R4i
X-Proofpoint-GUID: PrvyYc3TPCdxkyBlbsklyfp4fw8O3R4i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert hugetlb_cgroup_commit_charge*() to internally use folios to clean
up the code after __set_hugetlb_cgroup() was changed to take a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_cgroup.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 7793401acc12..69939c233f4f 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -313,21 +313,21 @@ int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
 /* Should be called with hugetlb_lock held */
 static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					   struct hugetlb_cgroup *h_cg,
-					   struct page *page, bool rsvd)
+					   struct folio *folio, bool rsvd)
 {
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
 
-	__set_hugetlb_cgroup(page_folio(page), h_cg, rsvd);
+	__set_hugetlb_cgroup(folio, h_cg, rsvd);
 	if (!rsvd) {
 		unsigned long usage =
-			h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
+			h_cg->nodeinfo[folio_nid(folio)]->usage[idx];
 		/*
 		 * This write is not atomic due to fetching usage and writing
 		 * to it, but that's fine because we call this with
 		 * hugetlb_lock held anyway.
 		 */
-		WRITE_ONCE(h_cg->nodeinfo[page_to_nid(page)]->usage[idx],
+		WRITE_ONCE(h_cg->nodeinfo[folio_nid(folio)]->usage[idx],
 			   usage + nr_pages);
 	}
 }
@@ -336,14 +336,18 @@ void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 				  struct hugetlb_cgroup *h_cg,
 				  struct page *page)
 {
-	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, page, false);
+	struct folio *folio = page_folio(page);
+
+	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, false);
 }
 
 void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 				       struct hugetlb_cgroup *h_cg,
 				       struct page *page)
 {
-	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, page, true);
+	struct folio *folio = page_folio(page);
+
+	__hugetlb_cgroup_commit_charge(idx, nr_pages, h_cg, folio, true);
 }
 
 /*
-- 
2.31.1

