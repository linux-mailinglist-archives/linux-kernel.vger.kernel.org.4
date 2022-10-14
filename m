Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038055FE77D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJNDQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJNDPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:15:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C57CE1C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:15:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E33xiP006651;
        Fri, 14 Oct 2022 03:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ISMhie7jByGxhiOgIqWmSQOUNT5Ar7QdCS2YsPKVfQc=;
 b=A5lMSoUICiVAJLhjTUhEO0TBol4Nhh3DU7O8WMdt3aUEjjU6wa5wG9d/Fd8BBs1H+5Vu
 bzayVRDURv1YEXN9AEMg7kZZQi434ZINhL761MwMdIqqLfgAvSCnlnc+Mmv1oMPABygt
 dI6l/nufQCsibZ39oO5W7U42TtB7DuKWX04fl/BzsSj6Y2j5d1LFuaEpjpXSpk4Pupb6
 tsF9mgAZzSO+PrwWj8v+4tpS59+HVsEHAdl6XdcVcUu/VYK5x1P6Q2Z0c/589E0nIUjU
 fnoSGRZU9t4iu9wcxdmuCC0PcWBsMjhmnC42sTpjN3gPbPgXPuDAtoNU5vhMiy56Z5if SQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6mr29k2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:15:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E2I8UM020773;
        Fri, 14 Oct 2022 03:15:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn6j2af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E08VCO7VlCl9Ty6zyh2DDEcdFbsR3npv7PqAUGswypvE3fgxKgtClMUmUJ19uNN30xfWVZ08flVeT0Pwn33NkUJcI5Gdy+XuvM0OZ4Gstgqd6UxWmpfibhbXbOs3VGN+WNk/JX/uZ8D0zHCcAyUAjhbspvzVVOgNl+C95IIxE6yP4g47SiOF6XYS3nGfIDcPgKy78nW0PtFMQJSUPo0apUyixzYfWD/LFZytR3M2Ik9QTdj0P8HzU7x60o1C0t2KvjuiZ+cS+Muw0Q0tmCjNxyzLPKogZY1fFTsDwjddHVBwdwo7UnB/aostfseOQXz3Q0wFM3R/f7lXFINm4N4PLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISMhie7jByGxhiOgIqWmSQOUNT5Ar7QdCS2YsPKVfQc=;
 b=fhDbdI034ceX+vIHjl1pz1qTMTmKrTl2WMxbMkVGcNydYJBfcNVilWyxLEZtvVXCwB4bsUza6SX4kUCJpzKwRlOjltgswF2cZpW1j6B4C2TL9H+cHmMMz+XdDg4OaSsAYJ9lquUo0Cv3qk8oS/1h7/FsnLTSWoeeDzVVjO5TqIPcKv7FPrsZt1taMLyJNpFPmOKxsHRd2+bcZSORPP2O5YesYtmkRJk8U6xxj54cLCLreFUuMNZmWh19L1YmhifYguT+8t+W8MT3moSSG0rz0D1tQDzhEXoFKFLbmV0xr7t0COSgoBk7p1LESKxTucT6oQQfuug8fw7dBYG8t2Tgvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISMhie7jByGxhiOgIqWmSQOUNT5Ar7QdCS2YsPKVfQc=;
 b=cAwoyvcpIYEpq2bK0qoThgR3DqmP5Zd9qzvFEAFvSwVYw/yhlKCu20WEnKQOwCKUgwHKa1i1Gty7yfgjpj7cZm2B5CXXSQU5HylWtFk+SVonPFJ84Oyvov9UcRQFK0FFosaxv/VsnkPkkUsnjclNMr34G2BKVhQVix+nzN4xJYA=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS0PR10MB6750.namprd10.prod.outlook.com (2603:10b6:8:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Fri, 14 Oct
 2022 03:15:02 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8%3]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:15:00 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 9/9] mm/hugetlb: convert move_hugetlb_state() to folios
Date:   Thu, 13 Oct 2022 20:13:03 -0700
Message-Id: <20221014031303.231740-10-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::8) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS0PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: c52a8082-5bd3-4783-39a8-08daad9247ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrV+FqnSwXYO50CZ8TSn/FAH9BbkeL3ycKKuD4N2J/Td9fHMLc27XMhlaNbCQlXae+PyaxsXSxkCupFxXRXRGR6dfxb/vJpEzqkTOcZm/fWmjhGZLylhzstoH4U+U1V9FnP7reKI2aZ6Smnj2ogWlD//94RK4kpmobB3SpNOKtMreTx9p87hqfKi3OjW12N5avS5jnT/rTmUF3/H5TWgbFEDzmKi6Ovx9u8ucAgMRNRQQA11OgyufFg5gs5KsE6doT+5EDKLfrDznVCn9DctcCp7HvjAMiV4M//u/FsolqBOtjmZUI0jX3OaotmAuCMTtqY+n9qJ50Oaxkry/ZKeCEdxZF6WIxt4d4VdCtlT7cTR5NKSYiSvUaHR/F8ap79d0XamghNQB54nKqwiBqAHcjGCTGZmoJsTQohh7tCHtTVFs67HnQh2KJnq3hOtOu6VdGzrPzBaNjL4W5YnVL7rvnWTbpz+dKX/Sr/pueryV/RFxa8LXnO2jUTVF0AkBUyPpXj5Y89tRp/hmE4eA/e5exL1prkOPTPQdp9bPcivkRX7XuBWUepcqLNbBMImuw086KH5s6slUyTe1Cdr5ZFns3k2pKUxO+BgQ53xFQ4APxPk4vGQwoJuUyGKZ13CxzILi5tEMjmpMCiAoauMxIljgA3eDMP2/yXYpITbwkUpJrsIIqiWrvMIK3dySB1iv9t3gCujrOkGcJVwYkKgKcP3JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(83380400001)(2906002)(86362001)(26005)(6512007)(38100700002)(316002)(478600001)(186003)(41300700001)(8676002)(6486002)(44832011)(4326008)(5660300002)(66476007)(1076003)(2616005)(107886003)(66946007)(66556008)(36756003)(6506007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aqnwsmW4gpkm2D8e4XTRyJZIaqiAd+F0W4WTw92AR4C/S88HwoK9qRTAC/Re?=
 =?us-ascii?Q?bOJvtLxyL9GVv7TFe+PKP6gg4aL/A9n1QwR5n2SK8kIpYMSfjrYAFs6q0Dbo?=
 =?us-ascii?Q?LqlyOpciYiEWLGfoUZyu9gSsSGLFdsdjwjkB2dUr9GZXs9Y6HvvU++mBzx4Q?=
 =?us-ascii?Q?xMytpWEVR0KeTimi3F/eA0SSTG/Bbzz91j8oGc1wJgojqMWpJUSZzhzDB/qr?=
 =?us-ascii?Q?JPGB6mjJsHmls127dgRfugNDinVzhRRT5XHI7ZstZJkZD0BVAbX7H5yjYViq?=
 =?us-ascii?Q?OIDTELwOhav31Zi7a7BeOIXjWcTj0O09/2dSuKtPUAVnYucb3/rK0aK6G4aG?=
 =?us-ascii?Q?yTYcLG3zgAxB4OklmMkZCsuhcvbZilf9st+896tMcBUSZVD4zlt2EqJsMFRv?=
 =?us-ascii?Q?CTKtBQcmQiXuLVwhJg/MF+ci4ohNC+ErUF3dWkdOZuqQu7kcpD4g6V6P7Zy6?=
 =?us-ascii?Q?HiBHOfb/UwAJ43XooDWagEgOOWzKlbWWad8MnuSgFTmSG+cdNmh4b0igvNy3?=
 =?us-ascii?Q?DibjZygmpow/VWocxFXuXSYsLP6l5q0/blsmTQkc1Pbmt/YmMjiO2MliYPK4?=
 =?us-ascii?Q?qvvQ3PeO9QcBVcyMLnTH06g0g7h6noH5/tdNhfdn2pLn5L4LAEcU4JaoAKf1?=
 =?us-ascii?Q?OS/Mis4MsrL2VOTUx92SOugV+EC7U6rLrqPPz0p56gKPM+tNqY1ru7SNTmva?=
 =?us-ascii?Q?JA3pfNUSQ6zTSZgB9LIjCKRlX2nBW0SA0Fk7jq6WKNsfEccRTlC1sHa5WV44?=
 =?us-ascii?Q?zKMuOv9RRnlmNIclV7aKJCOXpAeF4cPsjVKLeFtvEhvkb5aclXg0KWT5L/B2?=
 =?us-ascii?Q?hgPny/g+qJc/4lpzYWbeATwmWiXmsi7Z1UfH2+FK4fXFEI4DQO6f4Sy7gt0q?=
 =?us-ascii?Q?r+87NAg6CNLcDFPQOmkoRuuP0v9e8snOk1sLM9H/PEyBj4JXI0/AaUAQ0MdK?=
 =?us-ascii?Q?0MQz17fPEedqx65oG4vWecgbETbXKgWPdj1/dT3T21P8yae3fel5Otr1acc/?=
 =?us-ascii?Q?BS/QCVDzvHiRLFXZoffTdDxMR2Fcgt0f06j+QDVTp18zyVg3l6a1yWrZMzI7?=
 =?us-ascii?Q?l8JXAeZ3UVwQoUYaQIk4Im+q3G/LzWjegY3aQlVnI06Kp6i8cIKU4AxvT0dr?=
 =?us-ascii?Q?FQ3+7EZLEG/203ylhCChKrF7VAGwELivThAsdVXTxKw9f5SgZIrqcGw96ZIE?=
 =?us-ascii?Q?Boo11UNBmdGVxLkSAH8eHnu8uHRHG9nPc/fpBdqMV8rZe4QeYQIjCMEFagBr?=
 =?us-ascii?Q?kLj6JTT9GthamiIjbDF0FRsmzaFPVy/kX443mG8tv63eXJakV9B+7w6yUtNi?=
 =?us-ascii?Q?SfYXIjhVnsaMjmu3zpXFIkw9FXeyhZpKw99XLWKSjOZs/k5tZRA8ekcMnkLq?=
 =?us-ascii?Q?BT4ryNEfCtGi/XviIYOGR4HDZVBDKkrhetlUKEfQZhvjApWyoH984a4zuesc?=
 =?us-ascii?Q?RWNxDKyWdwh0nWmZ46hi7R/jBzGkg3dH6VwAQ3qaYWqnqKh/3K6CFLJI3M6z?=
 =?us-ascii?Q?ysK/oakQ2oHRytCCGFWCo+XGduAA/oSND//vUpoq7LHmqZ9nebVWyzzrx6p2?=
 =?us-ascii?Q?txtIsFyGSEb/DjlGxMppYKP8wcN23g7NLZvSsT4NCciqEo0pwoqp1Lqg4O19?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52a8082-5bd3-4783-39a8-08daad9247ac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:15:00.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKFWBqwmJ2ZMwneJzAq5aH5q4ehVQGp0SUXWUN41ugaYbau6niLd9wWoiQfdXNwoqY6eQV0nPPgCXDgpFTsy1gSSy3M1FYg8QfTKi+DkbUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140017
X-Proofpoint-ORIG-GUID: dHjXz6wSVy1VdDHsqPk669P7pF6F__cB
X-Proofpoint-GUID: dHjXz6wSVy1VdDHsqPk669P7pF6F__cB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up unmap_and_move_huge_page() by converting move_hugetlb_state() to
take in folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb.h |  6 +++---
 mm/hugetlb.c            | 22 ++++++++++++----------
 mm/migrate.c            |  2 +-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8cd8854f41d4..bfce1b48fbaa 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -183,7 +183,7 @@ int isolate_hugetlb(struct page *page, struct list_head *list);
 int get_hwpoison_huge_page(struct page *page, bool *hugetlb);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 void putback_active_hugepage(struct page *page);
-void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
+void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason);
 void free_huge_page(struct page *page);
 void hugetlb_fix_reserve_counts(struct inode *inode);
 extern struct mutex *hugetlb_fault_mutex_table;
@@ -438,8 +438,8 @@ static inline void putback_active_hugepage(struct page *page)
 {
 }
 
-static inline void move_hugetlb_state(struct page *oldpage,
-					struct page *newpage, int reason)
+static inline void move_hugetlb_state(struct folio *old_folio,
+					struct folio *new_folio, int reason)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d44ee677e8ec..351e7c8a585d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7288,15 +7288,15 @@ void putback_active_hugepage(struct page *page)
 	put_page(page);
 }
 
-void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
+void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason)
 {
-	struct hstate *h = page_hstate(oldpage);
+	struct hstate *h = folio_hstate(old_folio);
 
-	hugetlb_cgroup_migrate(page_folio(oldpage), page_folio(newpage));
-	set_page_owner_migrate_reason(newpage, reason);
+	hugetlb_cgroup_migrate(old_folio, new_folio);
+	set_page_owner_migrate_reason(&new_folio->page, reason);
 
 	/*
-	 * transfer temporary state of the new huge page. This is
+	 * transfer temporary state of the new hugetlb folio. This is
 	 * reverse to other transitions because the newpage is going to
 	 * be final while the old one will be freed so it takes over
 	 * the temporary status.
@@ -7305,12 +7305,14 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 	 * here as well otherwise the global surplus count will not match
 	 * the per-node's.
 	 */
-	if (HPageTemporary(newpage)) {
-		int old_nid = page_to_nid(oldpage);
-		int new_nid = page_to_nid(newpage);
+	if (folio_test_hugetlb_temporary(new_folio)) {
+		int old_nid = folio_nid(old_folio);
+		int new_nid = folio_nid(new_folio);
+
+
+		folio_set_hugetlb_temporary(old_folio);
+		folio_clear_hugetlb_temporary(new_folio);
 
-		SetHPageTemporary(oldpage);
-		ClearHPageTemporary(newpage);
 
 		/*
 		 * There is no need to transfer the per-node surplus state
diff --git a/mm/migrate.c b/mm/migrate.c
index 55392a706493..ff4256758447 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1328,7 +1328,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		put_anon_vma(anon_vma);
 
 	if (rc == MIGRATEPAGE_SUCCESS) {
-		move_hugetlb_state(hpage, new_hpage, reason);
+		move_hugetlb_state(src, dst, reason);
 		put_new_page = NULL;
 	}
 
-- 
2.31.1

