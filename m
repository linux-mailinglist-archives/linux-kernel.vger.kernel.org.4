Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23F75FE777
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJNDPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJNDOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:14:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46D013F11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:14:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E0HvRI025579;
        Fri, 14 Oct 2022 03:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1b2Agnqraxu+oJn88SnZ5zrHf4rJCayWbQEFBe9+MkU=;
 b=WSlTCLG5ruakkQSnrgZjNgZhoI7yK8xPwuMNWZfoSXO2+B0utuvkxP2onlzN8/QgNEGB
 gKHm6LQZd44VJGDzKk/mDhnBVVB5EZNHjGZKd4pD4r2gAc3kTpE4RywTdIefOf3cXgCY
 9AGlP3NEJnTy5XdXenCyFwaDyVpiuPV2hkKYvRZlbGIaxtBww/iqgxuOrtMgtiGZ+32+
 ZdAUT/ufT8zcunu6PpmnTnn4zTWggsD/wMlBy39qSDGrmi1CEXcw9LFFeTQ/4S1tNdvj
 KOVJSwjGCUvtXHVkfxNwtzdPGmiHKujc1KvcFzaNN9bOch0yT+QY1l7KpwEB5XaE0lr5 uA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6r4v8tm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E31XVp033961;
        Fri, 14 Oct 2022 03:14:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn6j1jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHJRPJnTwZQbFMv8PNMvUxM7wanjawELicy31RDc4fVRpkgIScRkVqKgxjJb1jCDED3uJgJQ2hwyRKUuGBAXoL3OWqFwGNq7UoDfYT5f0/5vllWKbLi8JdOKNsbU2NA9AdvsRP3/TFQvrvaVjQZrB2lqk1f6dSuqCW3tbpxFKRPYFFr70ZXB2cNHavonjGgyfYCL/Uni21YVDD5YxgCYZl0JU9E+gvlvKhpu6qyVMAT7tCoBnv6z8hXDS6gWrVW4k/z/rhXYiM/Xit7c9r68yyHdvvp6ygQ3A3p6vrhZc3RGx53Wfozdl6OYajCr9mkyFYHNwq3nPj8k6K8ZJwW7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b2Agnqraxu+oJn88SnZ5zrHf4rJCayWbQEFBe9+MkU=;
 b=ByV1ZhdS81/YYw6nHRePJfOccMQfKo96yzKshyeZOuXAqOGyPd85vNIZqFeE5vBWtLWjpc31Pj3fSJ0N4jpvNsSVL6nQU6J80HSeh2BBCBxoKk42dHMc7ta3x2w5nQfnCCWbTQp6JNIsExFsl2u/awsLOoLRcG4ej92bkUY/ALvOZuwYFWF3Ucgkgqa8dUWqO8FjytKBkX1VvSsrzBe9BP8gml7eVYJO1TKJap1FlB66TzejuVo3ge2J23rneBemrW629JvwkDOXASj+flYvJeZ0KDuzuTifMcmAVjikSvNTEcXPtO7PDvTe2Kyj8q2/8XXktQ63dc5dw89/ln95qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b2Agnqraxu+oJn88SnZ5zrHf4rJCayWbQEFBe9+MkU=;
 b=ZfFI8mUb0b2tp4tMgKExrghM+p6p+rx8uboLoRrydnM58qSVsh6KOpJTbxiK/ptgqMo4uyMjDeX3ev+GLt/vz/6kmlnPiYrc6QeQsikeKwvmr9BifaInbaAvrAoF1yraKVRbtNpH6rYXMgOHejYHMeUnj3oSxb2imeJtqiktJrQ=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 03:14:00 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8%3]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:13:59 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 3/9] mm/hugetlb_cgroup: convert set_hugetlb_cgroup*() to folios
Date:   Thu, 13 Oct 2022 20:12:57 -0700
Message-Id: <20221014031303.231740-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c46b78-2333-499d-39ed-08daad922340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tc1JQMK5n/omnoZkDGChU/t2XQsWPrOHyQbbYF3PxiUCW3GnI7VDdvldY/F/FBycLdY49lg6tKUgvzXbNXFQhza6cVkTGRvkj0KffJAcDPALGoBsNPyb9kdPupONwr1tsXY6g+dNyQSgK7aUelJ76w/5Uo/zZy0Oh3adV8fJC6aU+HqM7GLs3vVgfgWWOCEVloX1jU4k6O0ZuWYt7r3W4iwTq2Z2IOx356ASzm6Stf2ef01pSWOzmB15a3i/G9HFWYj9Z5FgsiRGeLtO322EasJXv8+VT5O2EQwppyYo12R3XZsGynaT3dquAoJ7eojagw0eUbGbFBpnMnBHgY57N26Ef2GGBig43cEuBrgshPK73lHB/MPCWcb+GrzkSwGsc5Ivclg8dqZGIn4kobntpmd+KfVFSVi1Df9M5d2a5Lz5++jDduLuYVnyChH768Q2tfD2nfZGCiOMVzKpVu3qsZo6LTdumndBwqX/XIgDSnLfPKKnJG2ixcOzSHJOcxg017ggCzE62Gs8zhsPdXbNKISiDsZARH6SoRIdLTS1GXO8HvauYLfaYPQcPj4eSD5Z6e/P6iG2ms0ZvlJzsPhFm866U451M/02pgrg/eBlnxAqyD8XtBVdwbB7ThmYFX1a2UjuGm16gq+6hvRvR7C9lqKNdTgB/6UJ+3o7sXVjexESdVM2WnLU+4G14CMKl/iP2ILKvovpcy9WS+bUtTGB1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(478600001)(6486002)(8936002)(66556008)(66476007)(41300700001)(6512007)(5660300002)(26005)(36756003)(2906002)(4326008)(8676002)(66946007)(83380400001)(44832011)(316002)(38100700002)(6506007)(86362001)(2616005)(186003)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fJx0UHXk3LbwlDu+fvLVbWC+YijCFoV8pMsMZ0KwiXuQESgOexuRTx8Wf4oB?=
 =?us-ascii?Q?QDQMFAbnj89lePwFAz8IkQoA0MzB0LHbdDWCuuu3ARwjaoj/VFvoNAp5Y3Dm?=
 =?us-ascii?Q?r8TSYTFTKryezKhsFcCcuGGptOz5lP3+KdPm7uhhZyB/fp0D+JPhFQBoarxW?=
 =?us-ascii?Q?3BSYWAp+6JGdPiQSG87JxLi/7S1BTN6GfBl7r2Etb8/ykfY5cVJMveyN3bTh?=
 =?us-ascii?Q?lf2wtdZM1vIorPTL5U+rUiZBf7T64r9ROw+bkzqyTaa+Q44xTy9Up5D4vA9D?=
 =?us-ascii?Q?06wqtPJ17h8dPusnNM8fV5ReiT0iqhltMtJ0SBdvG2GO0GFwjKIfeXngTLJT?=
 =?us-ascii?Q?iA55KqsAAyrYelp8TLy/gD9guYIJfTPrZOlerxBQPvaxmVlEhRWLrrHW2ynX?=
 =?us-ascii?Q?9WAwOpwcRt3JQclbmQzEepeUOi1kyuwOg/FbR5WStelzqs9eR2E+MMuqWWeB?=
 =?us-ascii?Q?fwGhijncSEiUhS6xieLLRyndM29Vj6hb8VjIU/lb/dchd5B3emxPbgcoa70r?=
 =?us-ascii?Q?OkhB8WzAC7DMzw4jvA6r0tVy3UQdjgwNFcs2kycNoie4W1ZbsNQ+QPyI2hFg?=
 =?us-ascii?Q?HoCr1wmNwuhU6008+d8Dm3GIuQICgL/0lfN2XcEDPCU23JCiIytyYTGwsEDN?=
 =?us-ascii?Q?a+TMAAl6jRmWcJ98KHkqihzu+ZOA5PmjvsU2imOUBRM4H5TazIDD/gSiADK3?=
 =?us-ascii?Q?+FyesCdUyUXgBaOJmkYaM1Ms7yGCQ2bdZgjoyC5bMbNqyrYAGs5WyKdFs8WN?=
 =?us-ascii?Q?rxFg0nv7JJTCfBIKy8VB64ngzTFzMUo/XYp8tOyoVgqThlA4VuxLXVkNE/Ge?=
 =?us-ascii?Q?VOCnvuRUBodEwk0KwFaqzXQzLAZ04rukzXw+Wjw12RP8PXeGynE7YskMbllr?=
 =?us-ascii?Q?FfvyXcKv3dj/WaiM2Ebtal2BL5evIjk4eVepYlRo549cHJX7MahTBWiYIRPB?=
 =?us-ascii?Q?u3UMUQhZ8Sqy5z3XmsT70046wgg305m9Kgq+gkeI9Bu+iwcqCOG4IH4ubwyO?=
 =?us-ascii?Q?V6o+qVxzAGV5gPMweSt6JQ6B5NosqxGz2t7d5KxXVjEWpvaZf5ZWAnetMd22?=
 =?us-ascii?Q?6YCbRfwSv0DCukOS++G1pdZbzacWKfcoDkbGNgh8ZKdLX505ebgT7mDSuNgs?=
 =?us-ascii?Q?OCiAkykIulfQyp1PkbZAxR0obgyZVG/nN7UTbi4V75xoJSOA89d81E8WdL7C?=
 =?us-ascii?Q?fkcsZUl3NoZllSvrF1YKKYR1XSKjPTtQ/g0Lnx6B7SdMANmdWBTUiH/r1UC8?=
 =?us-ascii?Q?mWQVpY5KDotKdYv2teNdg3gQieuzgQv6szVP6KwAnbzdLi2VLt+VVJxT+CAu?=
 =?us-ascii?Q?VUZS2DTEpARCS5Yw1tV0CjyAknm42mjXzjQ4DnP+lUHJ0RKjoKCfkLJ/bozb?=
 =?us-ascii?Q?mq0/lwKGvLB+u5IvdO0hsyaOK1AWqqCQM60TVWCiJN71c7q3uH7ln1/+vcjw?=
 =?us-ascii?Q?RwRS+dWh8L7SbXtaWOQte0JczVc0tMdhhoBdW8BIMKMt476eDhGrfxQ3SE5I?=
 =?us-ascii?Q?T2iHvq/m3Pwowyq6Z1e1I4p1hFW8Y3zwMMtVdQ1MKxs9aFJvS7A4aYLBoAj2?=
 =?us-ascii?Q?W14h3kX42+z9am9cyL8iPugiH1mv485+k8tLzRufTWEFdL+4DJAB66dtN+k7?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c46b78-2333-499d-39ed-08daad922340
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:13:59.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTb4ZCoJ4TY6vq/f/oAIc9vWv+GxnKA3+F2MW4/YRlrRcOaWnMjc6K2BjG1gbQ4J25F+Yu8IbUURc47gonQLpXiAQ438249tvaKJ8ZdFbyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140017
X-Proofpoint-ORIG-GUID: VgCWlwDxQRs6oks54bePRwP_a7ha_Usw
X-Proofpoint-GUID: VgCWlwDxQRs6oks54bePRwP_a7ha_Usw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows __prep_new_huge_page() to operate on a folio by converting
set_hugetlb_cgroup*() to take in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb_cgroup.h | 12 ++++++------
 mm/hugetlb.c                   | 33 +++++++++++++++++++--------------
 mm/hugetlb_cgroup.c            | 11 ++++++-----
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index feb2edafc8b6..a7e3540f7f38 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -112,16 +112,16 @@ static inline void __set_hugetlb_cgroup(struct folio *folio,
 				 (unsigned long)h_cg);
 }
 
-static inline void set_hugetlb_cgroup(struct page *page,
+static inline void set_hugetlb_cgroup(struct folio *folio,
 				     struct hugetlb_cgroup *h_cg)
 {
-	__set_hugetlb_cgroup(page_folio(page), h_cg, false);
+	__set_hugetlb_cgroup(folio, h_cg, false);
 }
 
-static inline void set_hugetlb_cgroup_rsvd(struct page *page,
+static inline void set_hugetlb_cgroup_rsvd(struct folio *folio,
 					  struct hugetlb_cgroup *h_cg)
 {
-	__set_hugetlb_cgroup(page_folio(page), h_cg, true);
+	__set_hugetlb_cgroup(folio, h_cg, true);
 }
 
 static inline bool hugetlb_cgroup_disabled(void)
@@ -199,12 +199,12 @@ hugetlb_cgroup_from_folio_rsvd(struct folio *folio)
 	return NULL;
 }
 
-static inline void set_hugetlb_cgroup(struct page *page,
+static inline void set_hugetlb_cgroup(struct folio *folio,
 				     struct hugetlb_cgroup *h_cg)
 {
 }
 
-static inline void set_hugetlb_cgroup_rsvd(struct page *page,
+static inline void set_hugetlb_cgroup_rsvd(struct folio *folio,
 					  struct hugetlb_cgroup *h_cg)
 {
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bcb9bfce32ee..4d98bf7ba81c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1758,19 +1758,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 	h->nr_huge_pages_node[nid]++;
 }
 
-static void __prep_new_huge_page(struct hstate *h, struct page *page)
+static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
-	hugetlb_vmemmap_optimize(h, page);
-	INIT_LIST_HEAD(&page->lru);
-	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
-	hugetlb_set_page_subpool(page, NULL);
-	set_hugetlb_cgroup(page, NULL);
-	set_hugetlb_cgroup_rsvd(page, NULL);
+	hugetlb_vmemmap_optimize(h, &folio->page);
+	INIT_LIST_HEAD(&folio->lru);
+	folio->_folio_dtor = HUGETLB_PAGE_DTOR;
+	hugetlb_set_folio_subpool(folio, NULL);
+	set_hugetlb_cgroup(folio, NULL);
+	set_hugetlb_cgroup_rsvd(folio, NULL);
 }
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
-	__prep_new_huge_page(h, page);
+	struct folio *folio = page_folio(page);
+
+	__prep_new_hugetlb_folio(h, folio);
 	spin_lock_irq(&hugetlb_lock);
 	__prep_account_new_huge_page(h, nid);
 	spin_unlock_irq(&hugetlb_lock);
@@ -2731,8 +2733,10 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 					struct list_head *list)
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
-	int nid = page_to_nid(old_page);
+	struct folio *old_folio = page_folio(old_page);
+	int nid = folio_nid(old_folio);
 	struct page *new_page;
+	struct folio *new_folio;
 	int ret = 0;
 
 	/*
@@ -2745,16 +2749,17 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
 	if (!new_page)
 		return -ENOMEM;
-	__prep_new_huge_page(h, new_page);
+	new_folio = page_folio(new_page);
+	__prep_new_hugetlb_folio(h, new_folio);
 
 retry:
 	spin_lock_irq(&hugetlb_lock);
-	if (!PageHuge(old_page)) {
+	if (!folio_test_hugetlb(old_folio)) {
 		/*
 		 * Freed from under us. Drop new_page too.
 		 */
 		goto free_new;
-	} else if (page_count(old_page)) {
+	} else if (folio_ref_count(old_folio)) {
 		/*
 		 * Someone has grabbed the page, try to isolate it here.
 		 * Fail with -EBUSY if not possible.
@@ -2763,7 +2768,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		ret = isolate_hugetlb(old_page, list);
 		spin_lock_irq(&hugetlb_lock);
 		goto free_new;
-	} else if (!HPageFreed(old_page)) {
+	} else if (!folio_test_hugetlb(old_folio)) {
 		/*
 		 * Page's refcount is 0 but it has not been enqueued in the
 		 * freelist yet. Race window is small, so we can succeed here if
@@ -2801,7 +2806,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 free_new:
 	spin_unlock_irq(&hugetlb_lock);
 	/* Page has a zero ref count, but needs a ref to be freed */
-	set_page_refcounted(new_page);
+	folio_ref_unfreeze(new_folio, 1);
 	update_and_free_page(h, new_page, false);
 
 	return ret;
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 600c98560a0f..692b23b5d423 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -212,7 +212,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	/* Take the pages off the local counter */
 	page_counter_cancel(counter, nr_pages);
 
-	set_hugetlb_cgroup(page, parent);
+	set_hugetlb_cgroup(folio, parent);
 out:
 	return;
 }
@@ -894,6 +894,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	struct hugetlb_cgroup *h_cg_rsvd;
 	struct hstate *h = page_hstate(oldhpage);
 	struct folio *old_folio = page_folio(oldhpage);
+	struct folio *new_folio = page_folio(newhpage);
 
 	if (hugetlb_cgroup_disabled())
 		return;
@@ -901,12 +902,12 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	spin_lock_irq(&hugetlb_lock);
 	h_cg = hugetlb_cgroup_from_folio(old_folio);
 	h_cg_rsvd = hugetlb_cgroup_from_folio_rsvd(old_folio);
-	set_hugetlb_cgroup(oldhpage, NULL);
-	set_hugetlb_cgroup_rsvd(oldhpage, NULL);
+	set_hugetlb_cgroup(old_folio, NULL);
+	set_hugetlb_cgroup_rsvd(old_folio, NULL);
 
 	/* move the h_cg details to new cgroup */
-	set_hugetlb_cgroup(newhpage, h_cg);
-	set_hugetlb_cgroup_rsvd(newhpage, h_cg_rsvd);
+	set_hugetlb_cgroup(new_folio, h_cg);
+	set_hugetlb_cgroup_rsvd(new_folio, h_cg_rsvd);
 	list_move(&newhpage->lru, &h->hugepage_activelist);
 	spin_unlock_irq(&hugetlb_lock);
 	return;
-- 
2.31.1

