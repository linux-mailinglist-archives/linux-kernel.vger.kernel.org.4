Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7775E6764
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiIVPn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiIVPnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:43:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06239FB336
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:43:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MDjvXA032075;
        Thu, 22 Sep 2022 15:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=5ZqfCkNz6cESzkKFdGF1voMVusdcQyTRfi0LA23StCQ=;
 b=bcfDSH2Jp0ZxeuPNAVOLe7S5xLBbNrmGQKKrwoFABh2m+rTeGDN62ZXDtlOyZ4dkFCtC
 7M3leRFtMHbohVfq5dvYTZJANAIjV3WT25tTASDSNp7meiJqgb2ofr0XcMD+82WTyMhJ
 PTALotoQQEisBsl6mqORAhFRjz0mNSN+IizRmlJjEWbtKiYZ5UTk7fAqk7Sd8Lqvs0tn
 WOmJl1FO7OWiEhG0tuD4sxwR58BUEdjlq2WjuYEm1U9a50BBcTiRwpYVmKOnfWtyrtA8
 k6DDWvrihtWLottDtwZASdzDkrgEb59ixUJ4FRj4aq4vQJw0ZRAgns14oMqF59ZdCJ2M Ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kwxnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:43:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28ME2R6g001918;
        Thu, 22 Sep 2022 15:42:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39sxfsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:42:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2ac9ZbkFD24kxtUehH2OXVs3UXFQuzf5jqcVkqGh3eLBdgY1Nij1W0K0VCAyyBNwJ+1tvlTJVxeXt0D0jEdJ5dB6Jiac/OinaNXjktyBjxuTdYzO7+kwXZ8+ia4yhk4pIHnyw3p6wPVgRW4b2QSnd7JJZmo8aqHr4wrrIOLc5wcHMyL56Nx/O2oaD2YwHcgjJOOdZTeTKrgdjYiqsmeU+DZ7RGr8282If2Yd7kdw7jtRmf6aZeYQyzwas/eW5nEUpmUNtqr+QJXnqWwas324gHQ+3gbHwKNKGOccWQ7y0+ozLOXY6ZyZOJI3ge9g/j0Qx3FX795j2geEc+UpGxEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZqfCkNz6cESzkKFdGF1voMVusdcQyTRfi0LA23StCQ=;
 b=M1xfEIp7B6EVyQZgfphTG/DIY76VI+DwyM5zPFsWWP9eNT1ZDBbl8pz07iPUJ2yp9sYU+sd6gUO14cdXjg4wcHIlw90XBGbkb6tF34pKp7hC06q3QZ12dOZaeOaOCfJwhipJ/xHJnlz4dqUCKxcSANzf3jpUD+cNcm7tIeV9u2+U5siHTAvjEtSbbiTWS+6DKB6cxIq/Xgeg3IORejpFDSixrSepjc2YppF1JKRSH+bZCelVHIHMJhyPRi//MqPgSv4R/9OXuvrWsXcCSfDhrUALFuy6ShiZ+Ppl93nS++eDLnMEeyfQWniiIONnQZFE7KUzoAOatDaw2aAkwztVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZqfCkNz6cESzkKFdGF1voMVusdcQyTRfi0LA23StCQ=;
 b=pxqZ5I8wXYsNNogUGjov9rmcm2/eRw4gZNlDMKUbf7FwwkL/wU1MuXjB9mupxIH3KEx6yBZCqfrAHvc0DigkgUzjoUhwIvxqdBzPlJOhxuTE+CAmtpmG/Y0ZTVDwa1uzyPRtiV6Ksuq8Qos4Nk2wSqC/FPhPtXhsQfuANMb2Crs=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 15:42:50 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 15:42:50 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 5/5] mm/hugetlb: add folio_hstate()
Date:   Thu, 22 Sep 2022 10:42:07 -0500
Message-Id: <20220922154207.1575343-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
References: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:610:20::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 4351bc9d-3637-4215-3cfd-08da9cb11aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qE78Y16f6oV/rctsyRhq2dbw7Gvl7f3DSziZCXRhIt+d1I7E21qS39I+KiKoRNnL+h9qEWy3oBzchYvGLR2Lv0B4Q6vTD2i1m2IcelqlXFKDw4NFeOCqa0s+VWexNFi374+UG5cNVVLT+8/i6GRKkHW/IMX7i/Q1wQxPlDq1nqhxd4vjJi1GhtZqYKQ6xN5v/amZEMuPVBFe48N1/2w0u5jS8So+oCqVveIylx85KHlnKv77uRyeploL9iodfSkxKMfJL1oQzpXZ6FDmB+i0ARXEBvJUyXCpV03LTup4UfHIXvzwDjts/HG3uFzeOITPpwJyf3l0yPRFu4RUd9/FqlYZoHwPN5cCh2TyMyP/Ue65W88lsvdfnfQ8R++feM5ucXKkiFWMq+QL2kB4j5CJ918g/82dXnpwlJ4IgcO2fYlYkmQyAKfON/eNfIhd5m+vKDP0HUT6z333e1idKR8lm3VNvaN/AH0XJE7KwEdneBXcREvXntTTQYKpcc6PPOxGKv0Bk7JNn/ReNZNnRzIcU4MxvLY5d0I7LtHtDrKmtC85XQphH/FGaZj+TghdNrTv+ALQV3ZRJ+CfcjRRih36jmZ84qKd9dm07C0rm8S45uoUX1RGxsXQShfPBXEJQ0uvfDdiXurCIhexn2Gr7UMNYKhY5MGjK5w9F3ehaOh4UKyz916T6hjda2UaLQzIclJLBwMLjrOi/g2LqCrXgvRK6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(2616005)(1076003)(6486002)(83380400001)(6666004)(44832011)(7416002)(41300700001)(26005)(6512007)(5660300002)(2906002)(54906003)(86362001)(316002)(36756003)(6506007)(4326008)(186003)(478600001)(66946007)(66556008)(66476007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6zDjjggXT/dzfEoGZXr6ZXniyb8HgWiizAwTLHrT9L9xBoimHguJZbzdnZok?=
 =?us-ascii?Q?7YCIXdsxnGEOaMq4BdfDlMEifkuVVnix9SxWTM7+p8pi9LaAEiPrvOYU+tsV?=
 =?us-ascii?Q?iFbulwdpIPpXIVb9IDNqCwYfKUqrQujCNvcW8ABMj8HMxXMS+AEgqDCAT6Nk?=
 =?us-ascii?Q?74JRIL0KqgkukT1UsyXD2AYsZol03MZyPPVDEU0paWzwBudZpYzioqU/GH7d?=
 =?us-ascii?Q?H+7ppVTtACkb+isU43Q9SdY1UnyEB8HbnhSJi7ECr4GfQL/81zdGP3Quqe++?=
 =?us-ascii?Q?bAULyQFZ6hxJIrhFNIaOsWWZxA/B1kLjkkCk57GAaa7UhKIslGOXX310/6oW?=
 =?us-ascii?Q?oydRhqOWB55hsEHM/6nbSyLyw8FH9klUhiIvgae21bJtrlHMJGw56GcMbgbq?=
 =?us-ascii?Q?YwlR43iSPL/bFh5q5gIDpYJn1oM7J33ewp6GyIaD5PCA5DTTDlWUON4KKChQ?=
 =?us-ascii?Q?MRZvT5omt8o2V5Z/zY5vtrf9OFp3oAPz/W0nHpWsVKLs2mICsKJStNFKxqnp?=
 =?us-ascii?Q?vS+s8FULq1s0tadHs5xZ+fAB1DX7cWnbyJLKpb0vLNNC6z4j1Vk9YKi41Lll?=
 =?us-ascii?Q?rk6Y4Tz3k16azHPglsNGPqEigBJH++khVi19W6rRWR2AJNGVXX13DtUUxVaa?=
 =?us-ascii?Q?lUTnMUjG3/84unpQ8g68cVGNTHBM9x+7cjCiBjpq7XpGZxYQrjf9H0G+BLld?=
 =?us-ascii?Q?ktqTz2vYFry9OH9tdVsYgFux0+PmxGoBkFRCOCprehBEHT8PuJbfeZeFWZFs?=
 =?us-ascii?Q?yl6gB4L9IdF6riL11jIj2yP2RhuPHXxIVWIyIu6hVA8l0Th5sAKqXUN85dik?=
 =?us-ascii?Q?wGDPwnCWl2UL99oFnX+4GY6NPo0X+VxF4mF3EsOrjxE1WbSPIWn/Wdq29mhY?=
 =?us-ascii?Q?PQRSjWgLUnVTFS05KPdnha85d375tid4F6wR/uYEmgFghwJfECq0cGts4qBv?=
 =?us-ascii?Q?9yOO1Jato215o2WoBWN6YRWC7ZtYHWoevSWYsN3cfTaQb0GhsoBKpKJQ7Zyn?=
 =?us-ascii?Q?qT5LRjdiddjChta5IubRpTzAPJwfrnevPzhOh0AcRt1KtY4+XJCOG1M/iwog?=
 =?us-ascii?Q?PWb8eOzeWQbW4zEcBFOAHMfh2s9dVToq7iqOzqYoZbBt5ZwWRwD+XEmlODna?=
 =?us-ascii?Q?AvKq2q0WI7w/Bj2w8eu1DiGbhEj398h0+q51TO2lQ5V885JgJ00okgxPsnV9?=
 =?us-ascii?Q?EkWT/a+qmkmzL58Reowr3chNaS4tS7G43XkyUbi+AwjZOewtfb6tvC5gAKGw?=
 =?us-ascii?Q?adk4/hRJrxq5Sv8EDBWGMwblhIFWaMJsQ1ip/Mr60+UucdHko2J4C2aRQS1B?=
 =?us-ascii?Q?SmTrps4dvnTnAp21tnDSC797yqL7kEC3ZS+CfdQsuFx50ayagqFHVWwXF9OJ?=
 =?us-ascii?Q?T3L10FxYFY2QqXH9DFwPG1zIRomDFHhdKBdqHRq97U2WdI+XfBqizvq52hkS?=
 =?us-ascii?Q?LOQUH4IBHp7q65IyK4MHBWKUmKz60hM2xQTDQuVLVZRV/wGfCCrVPmEDVHmT?=
 =?us-ascii?Q?pfMThQrJvpBX74BbNVrLjaXbg7m2n05tAUGWl8QJ8WiyI6/VyyNOKcEiMQuV?=
 =?us-ascii?Q?fCBNs6ZARpHENK9ZbCKjSQgzHgyaO6IY74w+sPaNxqCeMAa2q6JCkj9J/I5G?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4351bc9d-3637-4215-3cfd-08da9cb11aa2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:42:49.9781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNpLMmSh7LqIqnnS9Lssqk1nDmBJ8ZIbjBjzI4whcPuCAywkn0j7ubVt+zVBAjo1Ij1onKyK/x++vA2hJX6pw8oV3Km3KAPVRvQ/Df6C73s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220105
X-Proofpoint-ORIG-GUID: tMzL79FvirsCMsd0nJ_Bk3JhACvCjL0j
X-Proofpoint-GUID: tMzL79FvirsCMsd0nJ_Bk3JhACvCjL0j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helper function to retrieve hstate information from a hugetlb folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 14 ++++++++++++--
 mm/migrate.c            |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f92b9e6c8f9e..b4473bc43806 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -858,10 +858,15 @@ static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
 }
 #endif
 
+static inline struct hstate *folio_hstate(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
+	return size_to_hstate(folio_size(folio));
+}
+
 static inline struct hstate *page_hstate(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
-	return size_to_hstate(page_size(page));
+	return folio_hstate(page_folio(page));
 }
 
 static inline unsigned hstate_index_to_shift(unsigned index)
@@ -1070,6 +1075,11 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
 	return NULL;
 }
 
+static inline struct hstate *folio_hstate(struct folio *folio)
+{
+	return NULL;
+}
+
 static inline struct hstate *page_hstate(struct page *page)
 {
 	return NULL;
diff --git a/mm/migrate.c b/mm/migrate.c
index c228afba0963..17b92af421b9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1607,7 +1607,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		nid = folio_nid(folio);
 
 	if (folio_test_hugetlb(folio)) {
-		struct hstate *h = page_hstate(&folio->page);
+		struct hstate *h = folio_hstate(folio);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
 		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
-- 
2.31.1

