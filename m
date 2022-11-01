Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6337261550C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiKAWdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKAWdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:33:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C21DA56
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:33:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M3xWC016221;
        Tue, 1 Nov 2022 22:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=S17dg2dyeQUIoXTB9U1R9CMRu2YgHFA8Z60QOzRAZ7o=;
 b=Jr+UOFti3vagBqAktcoRadVUKEkNGiD906OrBY7jjb89KrwK4D4EnPb+i8x7LaIgyiPt
 VnNvjfl4JqMcU2BJ23q0U+1O+qPn8kX79He9nd2tnCutl+XqYjOfVJ4CVLxySTKq8hV6
 gUIGPQmnKKPli65kNkqWHJONituGAs3O7MDUbMcc8M8fcK22b/SD5XbbyAAsp2IbVpYM
 x+3LKtYWtYhKPRs+N+ekbujhBfK4oFqOE67yFizIEAppOLlwsRvdQpsRS9soqpZjqPe/
 CNUVGW/YWWx7bONw9psx/nScHuraOk0iw+HXtkzwVco+Km2VyFjGFD9ySIAs3IejjJVX ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgussr1xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KbWqC014088;
        Tue, 1 Nov 2022 22:32:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4w34x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euUPyiBWkBgxH6KIlWovRKYJS+NoQyGhXxRtg77RlhhGPc0ZPOGPy8A9hlg32bMmGxXGtrZLMV9+B90T0vtH1psbFj+1+Jia6H3iPdBQqZTUd5lnr6LFHOS9sLf/Bvc+tzge1Ncc7OHH0OKerVr4LmNVIEp8FgvByPMHdmuudOCxAZBmmKTkdUzexZRzCZsyuPnR/9O7Vnf4R1HKXLbTKIhObu37np7ykTbgQ7q0j+6167dfEjQO3Xuf/lwg7FNs4LocLURuV4rx0NUaWkhx9BhQglEirSt5Mx+Jl4CESTvFcrS2Tbg6PTcmgYJRE1iMx9LjB7Ctl9gTBWpOh78xUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S17dg2dyeQUIoXTB9U1R9CMRu2YgHFA8Z60QOzRAZ7o=;
 b=XZ0J0GQIUxm8g7OGBBj6pcLBVkJygpWznYp24DjbKBmxB3Narp/L6At2eZrRaDqKQyc06RdDqweOA98rRFEGje/y24HUt83zHx0AOguZtRyTb7Z/yQoMTYJNvCfo1Okq0hD61MUbx3jEHCeVxJlBQ9PGMINZvfeVAOPWIvfqEmR8YFgJHRmnr5eXU8XL5UXV4fivv5i/ujpm+2EjwooMLyxs32poPb5yWsBrcSjKl8GHEMcYK1XPW5B8za4RZbTMgkIG/4vBWZDIeS7uWDfnUYfGms+CCn7W7a+AEEVJORBEeFWF0U7vU1bdtq+oVcl15dmrBcPyBwofKa06wexTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S17dg2dyeQUIoXTB9U1R9CMRu2YgHFA8Z60QOzRAZ7o=;
 b=rUuZMVtKi85I5TDzsR/tq8dH73VrKUHfSiK5qcDhV5oBcCNtJV1b69K56MA9/Fza38WGthSpDyVXG7azZt9z3SVbB7j9dfNTB9D+qq4pEN+KQZPqv+mUWLbrNyuIOzuxx4auw43x3aLqJ00Au49ICfc7QAaBNg9UxNJWJCsASrU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 22:32:52 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 22:32:52 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 9/9] mm/hugetlb: convert move_hugetlb_state() to folios
Date:   Tue,  1 Nov 2022 15:30:59 -0700
Message-Id: <20221101223059.460937-10-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 09bbf4e9-4ef0-413a-bde8-08dabc59039e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9PtVLjkl8kkh9zOZ8k4H1g/XorjWHAdWsijrxL+QfLV92HomvVqCShUUVBE8KW7faGIo4V7iw/esYmxRbLWG9SBx3q5RVJXESWZavoJsYZEhZagiW7w96qbvcft6lbkFc2SlxV80d8KCVz7xRrQXsYOMKcmqKKGDChXKE02EMcJ/syCYxHD8+OAMF1SxUERY+7ELlQEHvt3U8mKbMSV5R1QMlCEBx2U3Pri8HBMECQ33t3yZrOKfTs5mlSAedKpktlkwdG+2LMzCbi5iEagl4iAS0qoaHJeBnWCMN1IOH9EnYQAZCko2Aa+zShvDAAfSW8otQ/Q7ddqgkvITb6HfKlcWTxMT0KAqzr1PBsI/Ha652owlc+Pa6LpxCt/7cbRwT3/EbYfPNuXujNSUbnhoFl6NDcKe90Wtgeg9TRgEtozF+ZJYtVu4/eWDfJFRND5xuXOz0ZgKXpD+B+PEpvpftZ0pNbYo4iS/VQxwkX64/TP2hTVM6J7P4T0dmLG1COBZ0dvQ7CIPl93cQ63j2AXYdp7k6YpRrFeZ9ygXUiO/DvPnbYPPWNuvjLoNb1FvNaLYanELfwB3nVLP80rmevsoEtLA9/4Ir7pQxC2o9Ww8XvkkMFyfElnhz31G3JXSzE1ppNj1MzJwJVFFwLsh3R1xwulMukb+6mRXALpplOBCHlP2kjsGP8O+MC6Mi3rWm2fbHj2v+6GuSmQVl2bT4wNhnUo76T1467mDks2zFd7GfHgqSmSGlSUXVFnr/UwV7Za
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(38100700002)(36756003)(44832011)(6506007)(66476007)(107886003)(2906002)(4326008)(316002)(66556008)(8676002)(6486002)(41300700001)(8936002)(66946007)(5660300002)(86362001)(83380400001)(186003)(1076003)(26005)(478600001)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IUrYBReM8eErcC1KuLAXTTbGtLqAj37GNPGK2OkUWm37RU6yje5P9L00XpYF?=
 =?us-ascii?Q?Fkk0S8vTBXhYCbvMVhag4iuJtckSN59+qYQZLl3aJ5240JYmXzpM/FlDEVeE?=
 =?us-ascii?Q?cTt0XWRQRXwPZwm3o4ixagkgHrn7h/5rz5/3WPsBn7OJmApDx6NnMhDgSKeC?=
 =?us-ascii?Q?xDcgi/QFTby6TsXzx4yFxUSJi+17UztEKSdCkdTwmPrsW7FbIlvN+Bwuh7ap?=
 =?us-ascii?Q?g7SzDG+He/l213wCFXbMHruoYwxaQIh1NIZRnJqhjtoa8XxmaMV9/DfjPm+f?=
 =?us-ascii?Q?ewNeFIfzxJLYxD6Ncu+D4bkewxzmQM04drUfeP4r7rTDRoh6zUioXiIe1tzb?=
 =?us-ascii?Q?H9ofnQQiLYAXlqvlByjggWO7w43biaGh4R2q07KiWqLlUHymRKTV66cZ6HiV?=
 =?us-ascii?Q?YxLk5AfkT5jaiOmtu8+sKguD6vCUr/R68pG78bVo8MKzJlbxspgqzVWyzznm?=
 =?us-ascii?Q?Y4hqoxYL5/DU1J8y4TG6Vf9vm2WPpmTdW7zs20SQstre5dg/rEks3vfrkamj?=
 =?us-ascii?Q?eH9ZfLciCQj2PQkjRPX5Uf5UpNwuQUivjjfUTU4in2rJ+/tDZKngTyghoONQ?=
 =?us-ascii?Q?aVF3lEFqkIjYyfXm3MPB3Q8NE/7KghNY5tuLfspwiECMkAs651wTGiziQv96?=
 =?us-ascii?Q?yDpEeeBhTqIa+lIfY3ccQjBepZRlglrFipxeKZ0zaQpmhcxY3qfVdgm1SydH?=
 =?us-ascii?Q?YuAHQHtaOjxKI2+VouEY8j5eERl5a2JiwGSiruwb6/QQDBz3crMCrR7HCWjL?=
 =?us-ascii?Q?A3BImxvpMEl3YQE0qM5b4Y/rYluDb9yJHviL+QIg5Jifqq11KxMkt6i3Fq+l?=
 =?us-ascii?Q?HlfwNTJI0BUsY8rfavxTYzX2zO4JciJOYAUQ+vLHRDz8/V05SqkPrmgRh3Jl?=
 =?us-ascii?Q?W2tYo1+jklFDFk7JdL9dpY54u92WDguJysBMMErqzo2guJrFLXgGtDINtpe3?=
 =?us-ascii?Q?BWP+RP8Mj0CZeqROpr3qkqwVMe0MUAGz8xzTJpzQ18Q0B5tQsGeMzswSIfo1?=
 =?us-ascii?Q?eaAvqycw+Kmy5uwRD+OKjV+uMcKunKaE611posdc103pkzEPvYIPfTyEb/1d?=
 =?us-ascii?Q?3VSEksMhBkn8sbF3oDJzIngnDJmbUdVOh4UTYT8cDUM6jad5UafipXQt1atT?=
 =?us-ascii?Q?NSAlzRHBmdn0wuBWvT8r1gE/XZ1Nj0BLBu4ZFHui8KYnT/c3zzlojCySEJ58?=
 =?us-ascii?Q?rUtZgd+tHHCqZSx8++at10fn36tmqlTXLDgGk697B3SIUM0APqTHIZVgPGfH?=
 =?us-ascii?Q?dy144cwcoEMRkgfOFD+xcK+JO+6sVhQYGfGhLcGX4MGWeYOjkREeiNzW8k1b?=
 =?us-ascii?Q?7+WS9zkOtq3K+x0rzvLuJe/mmeyk719UMZ2idT/Ns/QxkAalyFEGarWvi5dw?=
 =?us-ascii?Q?wwTSXjA2QNQC+bGn9v9Mqi7ykFpSLMWI7A+7+Lib4PQGQsYZdvq7DovGLssf?=
 =?us-ascii?Q?pITTSVhaBRZQ2bSbHy2FMZqn0Vv2Yp4XKkhwkGXmJCBVKCLUXaBd3o2xq4of?=
 =?us-ascii?Q?wNFGF1Gyo2Z4CkSPYLfZHY597Epnh7utFc0r2xAjCzdR8Tic4KbStEIprG2U?=
 =?us-ascii?Q?pJPecGRIIudLRZB46aBlALcEiyFllbDBQbASDEQbS/maabR42cMtvkjDro3Q?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bbf4e9-4ef0-413a-bde8-08dabc59039e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:32:52.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /n377HLAIYQcJ8lgYrKqw05wCtirD3my68dfjeBZEq5f5xl/a5LZ9JxiqUttQi/6p4X0KX9Ua9KbPVCnKg8kNFULkBz+Rd+Yr940KxQn4/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010153
X-Proofpoint-ORIG-GUID: j1spNW1vW_Cn6TdX8aw24239zZYUOnu8
X-Proofpoint-GUID: j1spNW1vW_Cn6TdX8aw24239zZYUOnu8
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
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  6 +++---
 mm/hugetlb.c            | 22 ++++++++++++----------
 mm/migrate.c            |  4 ++--
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d81f139193aa..375cd57721d6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -184,7 +184,7 @@ int get_hwpoison_huge_page(struct page *page, bool *hugetlb, bool unpoison);
 int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				bool *migratable_cleared);
 void putback_active_hugepage(struct page *page);
-void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
+void move_hugetlb_state(struct folio *old_folio, struct folio *new_folio, int reason);
 void free_huge_page(struct page *page);
 void hugetlb_fix_reserve_counts(struct inode *inode);
 extern struct mutex *hugetlb_fault_mutex_table;
@@ -440,8 +440,8 @@ static inline void putback_active_hugepage(struct page *page)
 {
 }
 
-static inline void move_hugetlb_state(struct page *oldpage,
-					struct page *newpage, int reason)
+static inline void move_hugetlb_state(struct folio *old_folio,
+					struct folio *new_folio, int reason)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2ecc0a6cf883..2ab8f3b7132a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7289,15 +7289,15 @@ void putback_active_hugepage(struct page *page)
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
@@ -7306,12 +7306,14 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
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
index d7db4fd97d8e..81f9a36c754d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1278,7 +1278,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	 * folio_mapping() set, hugetlbfs specific move page routine will not
 	 * be called and we could leak usage counts for subpools.
 	 */
-	if (hugetlb_page_subpool(hpage) && !folio_mapping(src)) {
+	if (hugetlb_folio_subpool(src) && !folio_mapping(src)) {
 		rc = -EBUSY;
 		goto out_unlock;
 	}
@@ -1328,7 +1328,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		put_anon_vma(anon_vma);
 
 	if (rc == MIGRATEPAGE_SUCCESS) {
-		move_hugetlb_state(hpage, new_hpage, reason);
+		move_hugetlb_state(src, dst, reason);
 		put_new_page = NULL;
 	}
 
-- 
2.31.1

