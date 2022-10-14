Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0225FE778
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJNDPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJNDO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:14:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F23F205DF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:14:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E1kIlx007683;
        Fri, 14 Oct 2022 03:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=YwOiu07DhwM1iywJ5BTRvmCQY83wPPOpkpjDxWRM/bk=;
 b=0D0zkiWafRtlqKX4JxAnAa/PJAPIHFUTacS290z2mvAtYfNIv8o7DGmwqExeqg7IYtD8
 kW8wD6izfjvwSDKdZVs7rDbIRszAVbZTIDt4pEs3tX5cDJtbHEdmGFN0Rs4VcpH6tWXF
 0tWp2b/OTA9Dh8iNY6yGL+w76MM8WEBTdilfUqe3JI7Od/p5pBJoSjcDVj87cyNp6Y6V
 rRqsyXsuiU7A9wr7NNrbTlipiUeO4FTeO7bCh0nW4rw707EkiIyXDRQCECG/PM3a1pTW
 HQMNda5ZUvlV4g8605mm1kvudNbOq/WV/9E38GvrYXnoLNEu99mfZGyrn6AiE9956wwk Ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6r4v8tmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E0IiGT003847;
        Fri, 14 Oct 2022 03:14:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynd5qme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8D0eMVm8BVuz5YqRLdkPghyhzwse6L6VY/4geUrpL28dtOugHWYyvPt/n6Y/VNpr5kyH247VSh08daHF/i7/ufR1L+08GfbUemsHfJ7SrKf4Z3rBJAPBYbMFG+YknGv3zgRXxL7Mfm0V0UrnNnVWVV2uno6Z9uYPJL1TChqilbsdfWtnrx+hqREOUwjvkP3UbuzeFqdv7vR/ny7KUlfb3pkVeTBU+zDElNEuRxQyGsaDRiEx0B7/00WC0Iwck39tvrCzW83paNC+SooEchGuG5PuMfh0GqeFrf9JRENDA6oMjNhEEbFG70WAYA3aC+1aMxiBKl8gM6oK/1cg27QMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwOiu07DhwM1iywJ5BTRvmCQY83wPPOpkpjDxWRM/bk=;
 b=hpyIFzH3B5+y17+U+LjdhgH73IDRlg33IR3N83XjdWqr5AnpBM00GRNBDp1+QMtjFeQ/6K+lSrS8Ib3qomUOxlLhBAT1YX0hznb4CiD4wIPTCLQShmkC1TCUBc2HaYRFO6Ww/pGSlFVpXLT1yU3laR+rbvVeg/d/EvT+P2um+jTFsSmL2CIkG65Zh4DuSJOWvu45KVNcuvMXJfCu4iVBdbu+BP917Z8Uj7rj1czxVy1V1eoopolLyBlaMTPC/GXWh/EQOFWXNILclWCTkJgpBxYEGV/Os+tLqyWHojPKIjAc0gqUbHsTzrjop/lkrusP14/csKRazqd+27I9qK2nfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwOiu07DhwM1iywJ5BTRvmCQY83wPPOpkpjDxWRM/bk=;
 b=VaM1WJiiFZcGSFZKshISexMYKmUFx1CodyALEOFZe0+W395oL9vrxmnwabupkJfpV5HVe3Zkol+wLZ4m5EraZetDKXolcQLA2paoZs38Edvh9FvTwk49LfAQMqEIOCNfOcSDgZsT7XXJeA0kccI8n77r6TQxpB18eWM1/9Qv2Sg=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 03:14:10 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8%3]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:14:09 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 4/9] mm/hugetlb_cgroup: convert hugetlb_cgroup_migrate to folios
Date:   Thu, 13 Oct 2022 20:12:58 -0700
Message-Id: <20221014031303.231740-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::6) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 748f0995-e5a2-4a1b-e145-08daad922950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgHImaNHMGSga3CR11Thk2yV8s7ScpQpUDWh3lWIpQQLPM1Aax8yzS87ehDn52xnW647+02m6lTDE7yXeJybYQAFAso2G1cp3g65BDKoq0J/aOldPc/DCnE4zXCkLAay42kuUt+NVNWuDd2hnA5qI3pA+af3Qt7kpa6lyLeNcAcdff7FVqd/uuefuxf5FIBoD3DCDewux8ry0VW7dA5Vo/7lJMe6vtgUufAjJ4avaURdqXOhtVVMihR5kYtwg+oStjI3MCg90UjJW1uUY3u9FdebwhlnUH6fjo62Wku748W7pgx4hwcFb2axuFXyiickqxfg/QmvEuwxw/YZRCl1ePHpJ0O8cnTuwj+8ksnULZvAekrJ4kIqUj1dehyoFx6dbUWaniiTn1k5ukOVMEa9oCEcCpMNkf4ITRLrquZXty95hczsz8k2w6xAIQp7vXUZpr/fzO9spnipVwz0TrRGj7UnHjLXiGADn/Rzv4uEpquG5gU67w8zPfWccSXRxrd5sI1K6O9sVNDE6lJ1tV7ahNXian8OsGb2mnbNr86LeyG2wWGFUkzLUrsLnDA3p1Mj78aaVd/PnfS7b+0g8xMCJO3sklw3nyiFSRMRIGbfaFQLumhn27p63v2uzpzXOsXElOLDTxeJcH5R8keovnJPs5M3uTUsR2NZVDY4h8iyqxdntdeS7oOndqPJYQaEvjsYf+Ny8nTNJdC7vsVyAI0O0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(478600001)(6486002)(8936002)(66556008)(66476007)(41300700001)(6512007)(5660300002)(26005)(36756003)(2906002)(4326008)(8676002)(66946007)(83380400001)(44832011)(316002)(38100700002)(6506007)(86362001)(2616005)(186003)(6666004)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mcf9Bnd+bsbuN8GK+h/PbtHwdf2S1NVZ2zdynb4JlzrMQvDM0pSCKlIfoats?=
 =?us-ascii?Q?d/z1IJHi1OTz5LVRdJXBLu3lTseZt5SDA1oioEu9nN7C6vArxxBd7Zn0WLgW?=
 =?us-ascii?Q?HYWFJhggQI1jocmHe/WJVZfv1mFvaI1EyBiwakY3DLPP49kgqrU+5NJtTxBq?=
 =?us-ascii?Q?KmMzJ8mooCUwblZPLhP8yg4wpldeMw24JpoPYFrKRh2wvs3DuXXYj7bd37/U?=
 =?us-ascii?Q?7xKV0Knw+OQyG+YpzFwhvwj0Meoq3d0PShz4NW3pV0Ko9ZhJXu3cptKLwHuW?=
 =?us-ascii?Q?cAJBdZMnqKUW1mzL5Fob7oYt0RIO0eDBaEDohCvD59cy1ooAqA1ipiDIepN8?=
 =?us-ascii?Q?dbYOQAGaBphnKTkw+jkLciZHYRdEEP5GI8ADbAI8zPPDPOnk8ZnvBLm0atTK?=
 =?us-ascii?Q?lZ/nI3oKHC+JqKUTL2vRUzYWir01Oc829YAPIiU1I+nQdB5B71C4jAT1091h?=
 =?us-ascii?Q?OB1Bjn3cAn3bqVPqhCgbdfwgs1hBxWmM3osEA0XpZ16DIieYmzyUwcbub1LC?=
 =?us-ascii?Q?pocyCBVsC3GRQi+RzpuaVGAGScSfYjgBOy4PxJiOMx97f1NCJpkW9vqe/tyl?=
 =?us-ascii?Q?/efzFO/bnfTR+uPOq3PVDTR41kjdIbJ1lSppCnDDKqxt1yxX5Yo/HugS2vkB?=
 =?us-ascii?Q?sg/uB2Ezjz3F5bYdrlWNfjMQ6FwoSKg9FDubeuUGa+7DdcMh5yrAe3e/dDoG?=
 =?us-ascii?Q?o05TzzHK0WUwBRwgKlBwCxt6QODJ7aofurdLsjm9ACatP+VmLwf0ABuUOafJ?=
 =?us-ascii?Q?G8af8NJgkoO/PkJavCl+mw0iqN5PYg1EBwfqA/Vswa9I3XJBSlWcYFRBa1F6?=
 =?us-ascii?Q?xeyi78oa9wEfV2oe9/hQE41dSjiC3HpBGPbBpZMrozPiLUSXCNGVGMYRjmLC?=
 =?us-ascii?Q?GmCt/5WdpzTwsO4QgnOXU5p9tLXuTvNofPrJ1P1DIgOc2w8vMFQoaqY/8Ewh?=
 =?us-ascii?Q?fO8K8OrNVKPAP/djggaxRi94gNojD4jFmFvp8gkE2Huw+XOhSF1DPdip9mn9?=
 =?us-ascii?Q?ioP29MPUrflJfA3t7QdqvdYeImK16AEpIDcEduOwHV7ojCXzdvnGbIr198kl?=
 =?us-ascii?Q?QifNcMgHRE6hT7z1D4q+2XjL0aJRXRmme9TpIBm2iYn9oR4xHz/ZfM7a1o6y?=
 =?us-ascii?Q?hU9cdAOCRhKEunllEvRFGgIiC83OYmSarJj6Ut136GLnqOEEdQtHKIhiHNSi?=
 =?us-ascii?Q?QlwF0fLPzZYnebo1I5wGFMO02GtIn7chFexQvyhmYOCROYxDlOeB/6Cn/BF+?=
 =?us-ascii?Q?87s0LlGAJdvtrTBWyMapfDVQVLvDSn0WhBEmIkMWw0AD1TsYXcWn0pzn4XEZ?=
 =?us-ascii?Q?kkt/krqmw7m4U5KvJv4t+unJQfCqyD3sHY9rtdvXFgz+0nMKVErbdaAP0fdH?=
 =?us-ascii?Q?zKS49RnY6S66POo13ydx0UAERWNkR7zZMPrcWrPzXg5UlwuU0J8nQyTAPX39?=
 =?us-ascii?Q?tTUMs4l0cMKrtJXoj1IwiYij38kGPkzTO2DM+4x+mKLEDX/myue9BG/Gl3Hy?=
 =?us-ascii?Q?r5PdxlAi3XsQXkkZ5e02KctlfFfB7UdXGRgWL2uokmVdm+97YJhfSusBe0ZU?=
 =?us-ascii?Q?3pZGlZC3o5rawvvjyGnBKWWChj59xP/anKOe4mcFUGptkSIzk7PGUKLNNXRo?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748f0995-e5a2-4a1b-e145-08daad922950
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:14:09.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 997jn/dhCaFUJQgOxgze+cJp1AZc77da6JtNTEZf8TkR3PwlJDqApnBOc8fHsYLioinZVBB0OLT8RaIRYi3g47IaBYKDG2xw3Z3aYs449Hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140017
X-Proofpoint-ORIG-GUID: sotljtfVBdFULi6CehXL45UcHx8xALbD
X-Proofpoint-GUID: sotljtfVBdFULi6CehXL45UcHx8xALbD
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
index 4d98bf7ba81c..e2dcc9cffb2b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7289,7 +7289,7 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
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

