Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B41615503
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiKAWco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiKAWcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:32:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189681D661
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:32:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M47Bc000479;
        Tue, 1 Nov 2022 22:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=CdIzfapkQVtbsXAtb8JOdiuB/Or3txdKboEQfHS7EJ8=;
 b=c0oE/fHmIzWpu3mTihBDjklHwh8ROfcSX4S3n0Z/pikpzlRS505TE7cdzx0rkL2HpwfD
 rovOnWMGxupTRm53yxWhQzs02FD7Me0c5cWfPuNJDBsiKcIFN/MZ4jf5Bm9FKWmADYr3
 bI1jiIBGAlzDqQ/7OMWqlRaW4RVlEVGgNPhl8SPfGD0ozDGaq4MCg19OLOptMJOMNz9K
 XK5s96/MqRNemUMTdS+F5sLyw6SJlv6lTTlCdeHys9SOwucdn/F1250RsneSTIQy9LoJ
 ozwDZkrRAUxEgxt+htGJA11inN6p3UrTCd8V0Tq/Z0/UZHeOEbvlqCiRuoW4rto4oH7Q HA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty3036e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1K49x5030290;
        Tue, 1 Nov 2022 22:32:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4x6yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNcZtmt49yQQlhITg5qiV3DhIvIlbBextyqLpgyhYdRs1YzbImgWEpVH/3OYR8Af2/lIzNbEkWQVDfdB5a20YGVGRI5XDef4P8YIcCInG120ZrDWJ7qbtkWqPI/YjAe6DFBea5mDJWlr/a1zbWFtZlC+r/r6wdaI+MccNZ1V54GqhCL+LHJWN8JGKmfo7HFRXrB2wpTv+82XTEVE/5teNKXiDeqxnMUO8XvjFnmWz8DXUz6uv5vO3x2DJRG3JO8R56+lOkoq0GcHyVM76y81tmSidZM+A02v+iDCaOWtJBf9qCWgktG61m+tss4U6VEUcBr3OlvggZInHRZj1kgCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdIzfapkQVtbsXAtb8JOdiuB/Or3txdKboEQfHS7EJ8=;
 b=ddOlAwNg6XzEEgbK2tgipYVcRmjOjRC9jT9LBZfMqZ4dW2zq0qr2kcYnz5Kxx1WHR9dwJQqaj2uhcI+e3xnuUaXlIy1LSKaA8ndbBCCXV+TF2I4hmHuIsqTJr5XhPdAx9/nCsOPqqDyYKZzyN/OiLv1s9TkkBA2IekbyF4vB1rTygMC9soVXb1GCfeK4mNS0bVyw1T0Z0OI0QGNtQGa8lbe/thWzvFDOrkEIaq4icDGKtEsCtPCrpWeLKYOlbsQ4WxU2G1VbEilEFZneTmkIJWm+pccEoUPVt7se4dsqv0fah1/mu5cXxaTW3weIZ140pI6wskN8cXvgJELP7rnsJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdIzfapkQVtbsXAtb8JOdiuB/Or3txdKboEQfHS7EJ8=;
 b=CsDHHNOolvGnZ+VP63eoiyeeIIZ15s5Nula3U28LvuFvC+DzSLFyCjENg0aHUL4KEJaM50u3R0NNEkTVXR6uvaSacI7706BqQGR8RY27rW/YM9snkSgnkkUKE/ch4gePfSE/LW0f7zgT1F5noRl1//zpUOYLnBZvuyCMg/VFyJI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 22:32:02 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 22:32:02 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 4/9] mm/hugetlb_cgroup: convert hugetlb_cgroup_migrate to folios
Date:   Tue,  1 Nov 2022 15:30:54 -0700
Message-Id: <20221101223059.460937-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 898877bf-93ae-4607-753e-08dabc58e5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lv2+sjijDaJNY3W8lYdSATshLgQE7P2EE1l47XcgH/ryKap+aBCNoCYvq3ZbgrLd+bvYSDe/hFz1Nnom+DKJyftcKweIEjKf7EW/Xzco2VIodATwk9uQq2zB94OjwuM9dQGt74dw6uCNw3CoEkT+ifYDLA+c++7OFts3vR4SEVRKX2HtF1+rQ38GRNdm8CItGkFzdTe4DsgPhsNFoXLumeVo/x4TYdr6hRTSfa+z7Z8cwL/JY0z6EehMsqj1eNRQOgNqB7OZi8t0cTDLjvOe9BbR9IYuk/FQkB/z/zJrLzmZW/e50+5jNq7PXtKelaxGMw6ude3Zo/HYcgdChz2qXRxH1ufcgsqZrN/tjPew+hpVuDbuSInC2yqRscOkiiLjWgqHhabzwdl/s8loPRcjMUz0ryXK9VBHH+Gu2KeQfa0iTN/5OGHilqHpSpkvXiS1Ib7JZwNkv/GJEcsgP2eVsUrvpG9BqDP9FWkUNdKh5LV5s2Uw49Y13YH3U3VzD7xvSH6ENQqcM4AFoPBKbnUXM9HswJ6hTN3AaVGPdH8o3kC7KSFDhMBZfoh5o0s8NXyfkUWiPD3WtPhIhPq6Okw7i0NOh7soqxtZTIp+tpuInH3UQahFhKwwuiBMVMCKogs/BDSweULCjxpg3sPkqrAek4rDZ79aJEApS5RNPSXESNpy3IeH0ciwVZRRmk5cVQKmcrj6xoHlT1p7EpiS+xIRoCqPNUSElFkQUMx3k/Xj/hLopaNRZj/3MhirC/jvrRF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(38100700002)(36756003)(44832011)(6506007)(66476007)(107886003)(6666004)(2906002)(4326008)(316002)(66556008)(8676002)(6486002)(41300700001)(8936002)(66946007)(5660300002)(86362001)(83380400001)(186003)(1076003)(26005)(478600001)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ssI+HkU8FLXTYEGQdIyGBGuGCmrnFbPWBbHKTXyOc7SQnSh0TKoUUFr5Cnv?=
 =?us-ascii?Q?eFgZCMbPWoaX/X+oM0o+AvsTOIo4LLbnQg3PzekAc41O0Ec1hrJnKaStxGSJ?=
 =?us-ascii?Q?n8cok9iUGir33Oo/JMaYODE8REn5GVr94qdfGoKgnqC4kQswKQa2fn0CLkGc?=
 =?us-ascii?Q?Lt1mGFrH2z1fHOnoRjAZnT+FTGXA2TIevLmdiy1rthwRPlLOAEZnPdkkeIol?=
 =?us-ascii?Q?YgMZByPTGxQu4ecbwt+XAYBtDF/jRPUqelLG9eJMIA6aqu8lEu+6EAtyQFXw?=
 =?us-ascii?Q?c7dbedttDGoX9zqSSSooQrWrZFOPSCyjl0l4eP/pDGDEfm3e9HmbWxZhFW8z?=
 =?us-ascii?Q?1hOxJWS/+1rb4Dharg66+JQcE8m/5sXa07EwIdONeaqTccVBqyANYDUDwmyb?=
 =?us-ascii?Q?ta7rQ+7s84xoq0BO9rUbeCVgzPRFT2VbETETLyjiroo/wEmYbOgiOObXmB4M?=
 =?us-ascii?Q?MOU/k8KlunwWR8RMYHUw+EWrKLniBb+jDSLzgI+A09ymWwlagr6e2cdlrqLn?=
 =?us-ascii?Q?km/jVJH/Rl+GC68hs9HR8imoim2hkZ+yYH/psVspysxOBvTTkXN6Ytnpm7mG?=
 =?us-ascii?Q?EAL4yMtccrzQpbIlIEj77Gg5D2C7jLWPZWlMqpvP0EI243n9Akn0YEl1s4ly?=
 =?us-ascii?Q?JMt+z0uJIWc4ZnLYIp+roY/sADvMxeg+xAp5mkEFx8yVJVmXeP9ooqEzDd0h?=
 =?us-ascii?Q?UH2Sh4cyQubvEo5yzZAouk0k+G5oBaGcJz+U6ymZpIZ8tppD9TbtyptdjYa6?=
 =?us-ascii?Q?mxY9RuDpCcX3cVULArEMSXBFxR1sMwoCk4B2TJGDxG79RDD7FuBgQh6rcDtS?=
 =?us-ascii?Q?91E5JCgXV9Pd2yAMwFTaS+g+crtgAgKgAl0PfgKHtwzUHbR54dHppuecRrJ9?=
 =?us-ascii?Q?xBD9M6RiUvcBMot21RRMhwtbUgUv9kbkBdwz0sH0ltkm7tuAv8Nj9Acy7Xlf?=
 =?us-ascii?Q?X1W/MceLmRAyolfRYcHpEGRF13LKtJHcBMXkcyK9Ca80w+bMKzht+qH7z3Zp?=
 =?us-ascii?Q?hy5kWF1IiakKuidvo9ItJHKLgTgNq3tZn7UGkrJWaDxisCPr5mlJKqHrtlc9?=
 =?us-ascii?Q?SH3lP9RfXnepf2KyxcIDvPAfqJG58sdBeWaCf/K6tx8sPPAWol0scgxIiR/i?=
 =?us-ascii?Q?fcP5sM2VkEj5IcEyFDJSHEB4KnoXYzrV8dCGGdaVV+fZbivuwoNuL0GJ4cr6?=
 =?us-ascii?Q?JczE2msPX49CeMZ37HHuw19ANMK5214C0zufA9gTPHqjMvd9bNoeXzGHuhvt?=
 =?us-ascii?Q?LwHdFijHIGLPkIBIzCFXu1NPAWJa/ccMDtMJWrFGC55uFkTa9Up5RPeVcI6s?=
 =?us-ascii?Q?zQxz/OHODSyZxdUsDHmU+8MewFNBG2Jv8jhuwA1PV8erjb2xEgoN3+j2nf8T?=
 =?us-ascii?Q?xa7sJHuCLxP9SWEw7fO6aR7UcflZ9+3NygF3WDe36UWa7pm8HuQ5HAej8riQ?=
 =?us-ascii?Q?DfoI6F87vdZh4a/Fwuw4o3J2c7gVCrXI8tcdWVovxzaM2R4t9ZRSsXTQModw?=
 =?us-ascii?Q?9fHD5OPVQjqHs2tFc6YIn9hebgpU5g2Tcax19hYNNb2XlY7/gZhaCJ285dxa?=
 =?us-ascii?Q?ELnTRbC2WN9bs8xTHzhM/6eehRXg4GpW6jYWGRS705yGM8SgIQZCz/AdJYPx?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898877bf-93ae-4607-753e-08dabc58e5a6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:32:02.4100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiR5hfbOZ4LPSuVbl4hUSv6t4PZkyKuNiuN/8fXryvReKDvIJJKQw4OaoOndsGb05fi/vMe5xcP+f1AF+/52wKeyJwfH220OjJAoGIl0QFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010153
X-Proofpoint-ORIG-GUID: keq2EAMAWdL9QVtGVzVZVGUr1Tgdr3sF
X-Proofpoint-GUID: keq2EAMAWdL9QVtGVzVZVGUr1Tgdr3sF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up intermediate page to folio conversion code in
hugetlb_cgroup_migrate() by changing its arguments from pages to folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb_cgroup.h | 8 ++++----
 mm/hugetlb.c                   | 2 +-
 mm/hugetlb_cgroup.c            | 8 +++-----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index a7e3540f7f38..789b6fef176d 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -177,8 +177,8 @@ extern void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 						bool region_del);
 
 extern void hugetlb_cgroup_file_init(void) __init;
-extern void hugetlb_cgroup_migrate(struct page *oldhpage,
-				   struct page *newhpage);
+extern void hugetlb_cgroup_migrate(struct folio *old_folio,
+				   struct folio *new_folio);
 
 #else
 static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
@@ -286,8 +286,8 @@ static inline void hugetlb_cgroup_file_init(void)
 {
 }
 
-static inline void hugetlb_cgroup_migrate(struct page *oldhpage,
-					  struct page *newhpage)
+static inline void hugetlb_cgroup_migrate(struct folio *old_folio,
+					  struct folio *new_folio)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a6384fb0b57f..2a48feadb41c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7290,7 +7290,7 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 {
 	struct hstate *h = page_hstate(oldpage);
 
-	hugetlb_cgroup_migrate(oldpage, newpage);
+	hugetlb_cgroup_migrate(page_folio(oldpage), page_folio(newpage));
 	set_page_owner_migrate_reason(newpage, reason);
 
 	/*
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 692b23b5d423..351ffb40261c 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -888,13 +888,11 @@ void __init hugetlb_cgroup_file_init(void)
  * hugetlb_lock will make sure a parallel cgroup rmdir won't happen
  * when we migrate hugepages
  */
-void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
+void hugetlb_cgroup_migrate(struct folio *old_folio, struct folio *new_folio)
 {
 	struct hugetlb_cgroup *h_cg;
 	struct hugetlb_cgroup *h_cg_rsvd;
-	struct hstate *h = page_hstate(oldhpage);
-	struct folio *old_folio = page_folio(oldhpage);
-	struct folio *new_folio = page_folio(newhpage);
+	struct hstate *h = folio_hstate(old_folio);
 
 	if (hugetlb_cgroup_disabled())
 		return;
@@ -908,7 +906,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	/* move the h_cg details to new cgroup */
 	set_hugetlb_cgroup(new_folio, h_cg);
 	set_hugetlb_cgroup_rsvd(new_folio, h_cg_rsvd);
-	list_move(&newhpage->lru, &h->hugepage_activelist);
+	list_move(&new_folio->lru, &h->hugepage_activelist);
 	spin_unlock_irq(&hugetlb_lock);
 	return;
 }
-- 
2.31.1

