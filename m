Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670875FE776
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJNDOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJNDOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:14:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3D310FB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:14:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E34A8t006784;
        Fri, 14 Oct 2022 03:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=JmGIt3Tl013Plbg0tYdWooZLBzr8VHykld6KHkpJ/Gw=;
 b=dNbR+bLLZ8vuZzujnNq0dIM4F3oIOyvAvun42+FLyby+hO9MpoPa92XhttZkr4YmGuH/
 W/mPWqf89Yc4vv9lP6XqpkuO2LPKgLzasdTDJ/u4M66ejI+x6uxf7xxynDMJAkcICOGr
 umseTJ4sGDEyVpNc26qNnt+VpwYASlruOT0PkaumoQciaC/ooO7YSrSNsE3RbuzvSZ7X
 7GQe9Z8tesmcbCeJ1GRQyWCBcdsbLClgVoUuwC+Z43Pjao11XxEyh664N58ZNqb++pbV
 XYmU/oBmsCW3b76X3v+lPKxwqN7U/qoZFxi3vSt9fJMeGSz0Dsoxlf0FJ44l+TUNf51B Uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6mr29k0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:13:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E0Se7e040328;
        Fri, 14 Oct 2022 03:13:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynddam5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXoZkzHpoPJNxD637ugUFu+U6pg//AU8z7cyW5PsoM6+kr3udb53O30pxKN3Wk+q2STIjCwOlDR9RXCfJYr1CB7p2QSRGfjP1mDGUpZFSWq9VkyRmDNhKyms7mAparDOTSWbuytDX+dj0niWLJ4Iy7Ky1xZQDIt7A/6oT+ziv2CZG/wjzQra1yZHGMCq/JSXSHFltKo80Qvj9kSq6WNGHnRDZCGziTnschuBWH9j7p4tUIdBqs4nwxDfdzlz/zmUTf8gqwobAktY3E08sZAcWzmCkHu+f70HeKrKMSnm8H4I7w3GYOhxIBaWZ4C58rwUsVhUo/2rRyIK6XowhWNlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmGIt3Tl013Plbg0tYdWooZLBzr8VHykld6KHkpJ/Gw=;
 b=H88dikQHMIayqDCmqsD9rqPhbP4TRdivpCJapImKOjVGUkkcQ94TXoGZWDv1c6/uhDptC5unCfcpi/Fl1bgAmASpUTQdzuG/WXp45PjoTUu/CsL1VmDIbyuhoQ6FVgC3sNjZKIzdf5W5tVTH0c5Tiggq/hn2EnW+Ap7hULrv5hZZtx5JXV1b8kjh8HKWGFxS1g1xLhzPEqyIrmK2s00VBSIBKbli6JBVxwF/BeLpNuoi1RNTkOaHhWJeTT/K/Q2edFlmZstKhmw8qaiE02lSqfLZLV47APsbsW1gbUwE/W+euq32EmGZ7JefiNxlh5oZrXKXW6iHkLZh6xId0q5XAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmGIt3Tl013Plbg0tYdWooZLBzr8VHykld6KHkpJ/Gw=;
 b=qQhuDwsltZeJKmXufwbMyXszyeJ8ps9QVFZta6JMl1GBSQRfVwkskFKUL2I+fnirKIhUn5FKtRmgAxWTjNdCOjUDcENNazNqGsUK3LHm/RkCbJT4YuHLyWW41FzqQ5BmwPggLY5Rluk0D3pjcKlRWzFMegal5U43wzUOfJ6RNHk=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 03:13:51 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8%3]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:13:49 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 2/9] mm/hugetlb_cgroup: convert hugetlb_cgroup_from_page() to folios
Date:   Thu, 13 Oct 2022 20:12:56 -0700
Message-Id: <20221014031303.231740-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:217::17) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ac85bb-b9c4-41ed-af92-08daad921d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdhOnA6KRN2YfQIgJaufFxOvo3l3uPE1cBWSmrQfVdivfQNCeKERPFHRbvPqt7omySufVJURCHY34/ziAaCKR67wOp5eqjaqS0Lti+BLdixm3DtPcKFVKdl1aGYuwhaT6om1eely/6vatUuvkJd5pIdgS9aBc8DGV/FeaP/2JufGdeHRPScS/r1eXgTctH3xntcw3JPkKonTBw9jqjA+SFOlmMkbEqI6POgwvO95C9cje8ubRPzhawHqkdw5G9cx8V5V/qpgJpkchqKtERLS04X8naCMuufqsCSEc5HlNqRToK/+tma4jadGvvGmUC7ehc+8gHEADuPskACohKW4CCQuaxVsALUXY1XSJVgn0CKWWLGNnXvee7nnUlq7AEmmXpM2GTGva5XYW2cWwNzNHCoczLXuKCDfp5q8GgXz5IdREDR+9jH7EcO76hB8W1c7wdvqsfxTcNUxN+oW0giYc+bobP4OOwVCmK6lHHyEgIFb9ntbMAk9lK0ZUKAWJy0gdyDtBxWu48kWl96cBbpp8b1VMqYTHrak0Gw9gtxKo730toEBhzcwnmwBXW6rTcYCVbE2aZMQmQJF2oIC66aYOZR7q80unbNe3LwofdnU8One14cYtFLpFNzqBSO9uK8JqbNYm3hUu+nay3nb/nW9i/4YbZWl1ZI/srPtRsctC7kKaxpS3ONSgfkYgwEGH/BVgDBBKW8+2BfPJ1PuK3ztLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(478600001)(6486002)(8936002)(66556008)(66476007)(41300700001)(6512007)(5660300002)(26005)(36756003)(2906002)(4326008)(8676002)(66946007)(83380400001)(44832011)(316002)(38100700002)(6506007)(86362001)(2616005)(186003)(6666004)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A/FoYYz8IMVnM83IGAwCpnHZa0MrnEGO45Vrbd7OlsrppL3dPhnlfPrLaz/D?=
 =?us-ascii?Q?QsebwqcVUll5PjfMOTTNqyIRwup9ZHSXcHxwJig3alnQyrOI9wSadCfOLnCk?=
 =?us-ascii?Q?DfKcw3kLow1UKw6riyurNb7L2aKvRBTjs8H/6zmeP28r/ql1M/QfntFBtuEH?=
 =?us-ascii?Q?PIyILO6bl/k35R1w66uHSTB9kabSOqrssSyoFZoH1+rLFPhx8ola0tPhsJ09?=
 =?us-ascii?Q?G1mojg6+aZ5Dv9h55+DprkHMdz5eeN1cmMWpYxy0tAX2MzYBnhdQo+aJbmqp?=
 =?us-ascii?Q?evDy/p1YDJMIxJXMDDQDpuvxYpA6G8DVfedPwEz9wgS3FeTQQhodHHcAeI9e?=
 =?us-ascii?Q?N5A9Gd6qVvgPNWRdWbTnqUBNNOoJo+8Hbm4wL+0UOCxz1m+JDFpjaCJOZSW9?=
 =?us-ascii?Q?OlahaPaRTSdNUCoFWvXn4Loe8oeuz9kJHj60MtCIvQZ4Dxdfhd53obKsBopo?=
 =?us-ascii?Q?4tzcZ6Pe/2tx+BIToiVlwfsfQS/i3+99p6tOcHgGshSNizu7x+07Z2akNd4i?=
 =?us-ascii?Q?Z9B+J4tvjbeB1SbFiqrenlilXaEBl609o5VdSl+Pq5apo0vMBrKG+ZijjQt6?=
 =?us-ascii?Q?F1NUccQevlG21LeT9R5sdzpNYDNqQt5e/m+Hsv9O4W26+KJh4OwHvSB5/BWj?=
 =?us-ascii?Q?SK1GMh/Cv+2macpn/rl57Thp/++y1g+S3GLvayyopRUhcp590T4+aiEcg59J?=
 =?us-ascii?Q?XQkWn00Lrf3csKDybENUcrkVT8fX3GNnUxIciwPSnRltMOKXEQO3cq/nFPyQ?=
 =?us-ascii?Q?MbQ9UyRlD+DBC6zT/tx+E0egixu7+UYrNysmaQP8wan9rEzueztUSsgSfuAm?=
 =?us-ascii?Q?yjDZMv+Is+udqTY0sSSMwGEuaAbaxXsEFilWlijwi9YUqgC3LoSsNwaao2HD?=
 =?us-ascii?Q?08/OSFO2tDY230m+yR8/lOLJ1T2RazvKrO9xHpo+MwgfOZPazB4ZaP080GgO?=
 =?us-ascii?Q?2mt5PyQKbD8s3c124aPXlOYaNifxluJFQRGpTIjA69S7n9sk7fq3eQOoikJx?=
 =?us-ascii?Q?hoAvEYZdjcvLP2tfLdeJhFLstyNoT4IYpAjrPrzkmFXjFW+iQD8dguibhpbv?=
 =?us-ascii?Q?bxpW4m515mO5xg1xmOlbBCEdFYkzca36+qiLqkOEUNIyWYub0vgJzKRfPwBi?=
 =?us-ascii?Q?sC2ttAJceW8+8iMBo1VhXXbYsY2IFtQXE4vTEiZTxUqGs7xCq+xLujLrhdww?=
 =?us-ascii?Q?vGlVvGYvPJHX5ymikjNE6GNNDexZ7a/aNbjxxd948GkaDhawr3lw4CdI2D3V?=
 =?us-ascii?Q?jCnGgLkHvO9vz2jkQD2+9kclaFAaFGLUjBEAUDYr/1y53A3fYulPVGoFkwPD?=
 =?us-ascii?Q?1zop1yKwPbbAbPr++CxDoQDPZ4+G6eIZrq0y+976xixE6F2FRsGnphAKZbMi?=
 =?us-ascii?Q?fiydnAuGaBaPQScoWmPY8GLqJSYM1sCj2M68lwf0AqvPsTr2FCJ9PeTRVqZ9?=
 =?us-ascii?Q?aAV+N9qem4iGoAScUrg5S9a1GPkpzS9NkNYH5otQNFBVMhDDS5cOWq27Sp4I?=
 =?us-ascii?Q?tVVe+U0+hEwISEYO2deOCbgfVNwhFOf9hV+OBO22PU44S/GpzCEKsssNlwPt?=
 =?us-ascii?Q?8jH45hPN5h9tyOWITprt/Ap1V740zMQ17+TPsjs7H7yaJtI1m8l1uuupLvhc?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ac85bb-b9c4-41ed-af92-08daad921d61
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:13:49.7524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njRMgr3Vzcy5mr2BrQdr2oxnbUFmSJs3njciWcHlgAODZzGJJO77Urm8LzllUMdIrkNmOV3sh3TtiZZcB+dN5IsoVSawpua/+YwOhV5Bqws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140017
X-Proofpoint-ORIG-GUID: 51biPprJqisMaHiT_z5g2AkJAxiTTztY
X-Proofpoint-GUID: 51biPprJqisMaHiT_z5g2AkJAxiTTztY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce folios in __remove_hugetlb_page() by converting
hugetlb_cgroup_from_page() to use folios.

Also gets rid of unsed hugetlb_cgroup_from_page_resv() function.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb_cgroup.h | 39 +++++++++++++++++-----------------
 mm/hugetlb.c                   |  5 +++--
 mm/hugetlb_cgroup.c            | 13 +++++++-----
 3 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 7576e9ed8afe..feb2edafc8b6 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -67,27 +67,34 @@ struct hugetlb_cgroup {
 };
 
 static inline struct hugetlb_cgroup *
-__hugetlb_cgroup_from_page(struct page *page, bool rsvd)
+__hugetlb_cgroup_from_folio(struct folio *folio, bool rsvd)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
+	struct page *tail;
 
-	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
+	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+	if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
 		return NULL;
-	if (rsvd)
-		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP_RSVD);
-	else
-		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP);
+
+	if (rsvd) {
+		tail = folio_page(folio, SUBPAGE_INDEX_CGROUP_RSVD);
+		return (void *)page_private(tail);
+	}
+
+	else {
+		tail = folio_page(folio, SUBPAGE_INDEX_CGROUP);
+		return (void *)page_private(tail);
+	}
 }
 
-static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
+static inline struct hugetlb_cgroup *hugetlb_cgroup_from_folio(struct folio *folio)
 {
-	return __hugetlb_cgroup_from_page(page, false);
+	return __hugetlb_cgroup_from_folio(folio, false);
 }
 
 static inline struct hugetlb_cgroup *
-hugetlb_cgroup_from_page_rsvd(struct page *page)
+hugetlb_cgroup_from_folio_rsvd(struct folio *folio)
 {
-	return __hugetlb_cgroup_from_page(page, true);
+	return __hugetlb_cgroup_from_folio(folio, true);
 }
 
 static inline void __set_hugetlb_cgroup(struct folio *folio,
@@ -181,19 +188,13 @@ static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 {
 }
 
-static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
-{
-	return NULL;
-}
-
-static inline struct hugetlb_cgroup *
-hugetlb_cgroup_from_page_resv(struct page *page)
+static inline struct hugetlb_cgroup *hugetlb_cgroup_from_folio(struct folio *folio)
 {
 	return NULL;
 }
 
 static inline struct hugetlb_cgroup *
-hugetlb_cgroup_from_page_rsvd(struct page *page)
+hugetlb_cgroup_from_folio_rsvd(struct folio *folio)
 {
 	return NULL;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4133ffbbeb50..bcb9bfce32ee 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1434,9 +1434,10 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
 							bool demote)
 {
 	int nid = page_to_nid(page);
+	struct folio *folio = page_folio(page);
 
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
-	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
+	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio(folio), folio);
+	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
 
 	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 81675f8f44e9..600c98560a0f 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -191,8 +191,9 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	struct page_counter *counter;
 	struct hugetlb_cgroup *page_hcg;
 	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
+	struct folio *folio = page_folio(page);
 
-	page_hcg = hugetlb_cgroup_from_page(page);
+	page_hcg = hugetlb_cgroup_from_folio(folio);
 	/*
 	 * We can have pages in active list without any cgroup
 	 * ie, hugepage with less than 3 pages. We can safely
@@ -352,14 +353,15 @@ static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 					   struct page *page, bool rsvd)
 {
 	struct hugetlb_cgroup *h_cg;
+	struct folio *folio = page_folio(page);
 
 	if (hugetlb_cgroup_disabled())
 		return;
 	lockdep_assert_held(&hugetlb_lock);
-	h_cg = __hugetlb_cgroup_from_page(page, rsvd);
+	h_cg = __hugetlb_cgroup_from_folio(folio, rsvd);
 	if (unlikely(!h_cg))
 		return;
-	__set_hugetlb_cgroup(page_folio(page), NULL, rsvd);
+	__set_hugetlb_cgroup(folio, NULL, rsvd);
 
 	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
 								   rsvd),
@@ -891,13 +893,14 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	struct hugetlb_cgroup *h_cg;
 	struct hugetlb_cgroup *h_cg_rsvd;
 	struct hstate *h = page_hstate(oldhpage);
+	struct folio *old_folio = page_folio(oldhpage);
 
 	if (hugetlb_cgroup_disabled())
 		return;
 
 	spin_lock_irq(&hugetlb_lock);
-	h_cg = hugetlb_cgroup_from_page(oldhpage);
-	h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
+	h_cg = hugetlb_cgroup_from_folio(old_folio);
+	h_cg_rsvd = hugetlb_cgroup_from_folio_rsvd(old_folio);
 	set_hugetlb_cgroup(oldhpage, NULL);
 	set_hugetlb_cgroup_rsvd(oldhpage, NULL);
 
-- 
2.31.1

