Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F295FE77B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJNDP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiJNDO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:14:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD732FC33
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:14:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E2hdXx000655;
        Fri, 14 Oct 2022 03:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=BSmQMWtOsOQUlCDLLHdXQwox8wfT3/Dgx95AOUTYQoQ=;
 b=RDc48+5ZSbe3A2hf1ZFX/OexCkXL8ZnYs7+bQAUg6SIfU7jnjeMBotfeD3zTAxVzHb0w
 5eu2GRARH8tDkUHgC98LjF5qvxcpd0c9rjy9Vf6mB+xPCnKX8+yzMMynXM1YCikDt/g2
 crXcxiNFaBAx1v3d72MQj1qhviOm7yRKtjNuR23Nv2cBgx+7zHHa1U3ivNDi4VDdDI8c
 9AABaXKX5xPt5EWkIjTtcXNB8fho9kzlWZ6evjU0DkXfofkb+OzrqiDi5NVRP7A6zOiV
 d9k6CvhKjK0kJXg4+u/J9zQltjxihjdeQfqDeG5QUpduvY7Qbn5lt2/h9nHSp+ESM+ZE Pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k30ttf35f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E0MWPP018229;
        Fri, 14 Oct 2022 03:14:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn6t0up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 03:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6ae5n4+0X1SoiKP2CKee7mOnHUV+6h3jDvIukG2hTg+igExKJ1xXK1cr+ava3XmpLCypsIjJoysCAfmhnqIWHI8kIW6/n2wC6eri1KfAU2TiwSZ3labL6D57MBsoHIXJcAnZezmhVvQf0penmXqLcocbOO6BgW7ChCjPfoq7BlLVXNAUfe4yPcY1ZgitpwGiiRkcWeI/qNiL3bpNcwxypELwm5PpbRUF+4s1/Zg5mhnzJpezoh1OHAI9eAFS0rCasMlNTPG3YQypEatWswoUPhe6MYe8hVBJwBudohqjhhEoQrCAua8Sri6wJKDDbvhyVCHIskvbuKbZ3ApcHyIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSmQMWtOsOQUlCDLLHdXQwox8wfT3/Dgx95AOUTYQoQ=;
 b=YdsMXWU0LDNMyrQRfGa/plKp6RqjFCgzXDgO5hKLW/AFFAqzwk26Hk0Lov6Pj5wpeAunltaJUxcwNBU4wLnVYOAiRV4UhPBMg0sZC2cdzlp8gXfwNUUXW/1qxDxd0RWFKsoqXTkeQKShpDJUBsxV74HU37xvM8YfZ5FxzcG4jLmG21CQAIXG6DRqzl3N3FlY96v0iFnWByo1GM219fbY2kYZgclJXzy/etUCwiJoPiCENsZOgx2keNv4QHEDC4lqLlF2lITZo5oLwrnO8bKwYEl9/Q5zS/+4yWvD6byNP2cpcol0YTX0IUIGY/EZpLGEKK4UbasXOBNCx4H0KavByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSmQMWtOsOQUlCDLLHdXQwox8wfT3/Dgx95AOUTYQoQ=;
 b=kWffB5G9Gp1dXT4vgKnNl+ioUnH2u1kv7zP9jDRSExRaLlkvcCyYQCzpIG63vUatciyc3yfh+hhcy7+ax9nENjiIsPHZjXwtOi4DvSMcjTAv1cCez88kCwlqqXxmXqGv+mRedmAw3N07S+cgxKgYrtAVpZ2jYb9jco/nhgI1Ysk=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS0PR10MB6750.namprd10.prod.outlook.com (2603:10b6:8:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Fri, 14 Oct
 2022 03:14:41 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::c026:d7f9:58f6:a5e8%3]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 03:14:40 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 7/9] mm/hugetlb_cgroup: convert hugetlb_cgroup_uncharge_page() to folios
Date:   Thu, 13 Oct 2022 20:13:01 -0700
Message-Id: <20221014031303.231740-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
References: <20221014031303.231740-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::41) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS0PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ac0c45-a099-4ce8-bf4a-08daad923b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgmKRxFb2smrcmp5PonCS1vj6qjYqoz2voBcm52Nak++KK8G88q90ph7gu2q/hFjMtd8jhYg1cvAGshQAyY3f3xKEgwzLpk6z6qk0gNSrSc6QA++hcbPbcr011a97Lj82xMbltcT/axO7I7mxeQjDmXaFWF+J9A2PszcIGCDs5vjQ/nOyag3nSb1oTiUBSZ7EwOQOLGelq0h4jpLa8y0ncX9N/Cz7llLlE03lVOvAjlW1Bl+5T4buo8wlbkNEH/HelxXJLRmUBWX7s38IMOQtM6CrXp6L+n4guc+dECGYYa9jZ0IbiaT9t9KrLqjY4UOQl7v9Cd2t1u+dCSFALUOZbgNOcXpIMdM3OoxUyBmPT1vyMqRhytFLg6Y2vbFsYUrScbQGD5vOoLzwhJ8WUluGXRfDoiB7syYGhuktcgOsY0qvzJkqUHYjwLlbBYzgskIcqyHjUdCebRU6uE1pWwbALI0I2B/gOWvuCcGi7HgfuIdfw9rTfXOX9zo2wvNj6B6x5W2GOW22MS3mh7s9oTlieuVF8WFYGSAkFHc1TSAs8dzpYzttRuUvZFtgVCDDu8xb+yySNriuoV35ZuFchKjU6b1OYMiYCW255LFY1E+YxhLBUN2rejn08T/fCztjUNmniJZuHe/CL6Zw6hMLPI0W8srIT8KDViTVlzxXH9BTVLIpipobj4/FPz31JEtwKqMEMvFQDwbNrYGg23Ix5IKvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(83380400001)(2906002)(86362001)(26005)(6512007)(38100700002)(316002)(478600001)(186003)(41300700001)(8676002)(6486002)(44832011)(4326008)(5660300002)(66476007)(1076003)(2616005)(107886003)(66946007)(66556008)(36756003)(6506007)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hy3tMw8em/E6Nvm4wYNkhbJl5IO0IeU9kZtKHDuBOGKDiditeKEAnbKEx9x8?=
 =?us-ascii?Q?ckpImFqqDERsSbVdpBsE3OXya1A1k0OIq7K5Cz9SdHw8BaqYpnQuX4yXCyai?=
 =?us-ascii?Q?NQJZmYqdhK7QSlvy9cQ6zdmAVbJtDsgVRQPvzNR8f+jPe35mP8+1/vnF9vc8?=
 =?us-ascii?Q?u4BnJfxmpslKFTMQdFMiQ6KCcSlo5s1uH+cYBi30KIo7trAysEHSutTmzYsh?=
 =?us-ascii?Q?tGWi9gWQgopVOgpuFkfZv0qJyZJtKKN30Iv+qD8F/7CeOzt9RGxoh4aYAcMF?=
 =?us-ascii?Q?BlvUwZjxOiy2pC673IHWVL4W0FksJVjJ+Cc+AFczL1rSYh+OaggOuxzzEqjI?=
 =?us-ascii?Q?jRdwzTbC0AeF3k22WeC/muXjTvYw0GKRqN82YE5JGG6ae0Tkz+CmmotEdRR9?=
 =?us-ascii?Q?dnRlzYzJElBMST8Z/JCCJa3BYvGoBG/jc7cuL1DTeLrgsCBH57qJHth45Uun?=
 =?us-ascii?Q?dkcUnWXZU/ru39oUypMTaQhanBv/Ty2ve0WcJ8wmvWrUaZbVp8BnOj8vU9OU?=
 =?us-ascii?Q?FzKWkM+VI17cK/OiRVSvTirHlD/G0jtFRhb9CNR2saKMkhSowiYR6lReh0UM?=
 =?us-ascii?Q?n5i+ubN7PtG2i3AaKl3TLsnySc8HIB4kByMMUNjLR7HULSHOHmm4zMO3o6ck?=
 =?us-ascii?Q?D4SXadJCOd7yLC4RdBMnjMb2aXmLAysdXkFhYkuOqtZgROxT1hD//IEZZKiO?=
 =?us-ascii?Q?FgrUeF5M0NjblJFPrE6UzcTkJZEK871c9GWzSfQf6kvOth4jFp0NHpJ+3wHK?=
 =?us-ascii?Q?6XXFaaKVsmXNpsPwhNT8Q0uZX85h9g8wBwnq0qpEECtpD+JVQ34h+LtX8k25?=
 =?us-ascii?Q?BRKO0RVS3uQc4rZvf/ziEPiVrRuYvFHK+z0j8k/gf9LxEtB94WE+HJ8Kfp6p?=
 =?us-ascii?Q?PqhcJaTD1haX+GW2neR5e6r6fxd7ypZV4hKsSs0NHLdS8BagRcHnou+5jFVA?=
 =?us-ascii?Q?2/knhgMhc7A2RNgzQDa2+sPNeS2ff0+gTBB/ccfbV1Zq/+TIzcYyw2VtP1+H?=
 =?us-ascii?Q?GqQgyB28HAJ4StGm56rzVi8rT/xKgzrD1JzPCi8BQ1OUyEbIgxPsv62dGLqr?=
 =?us-ascii?Q?hAVj1XenhdNIhW9iZgV1AhBAaSClrPqZkwxjYs+sUgFn8IehtkOWG3SEwVA7?=
 =?us-ascii?Q?5qV6UA6rs/6JW5HhSSOz6rJXh6Yo4eJDYlFjIj7GdstxPbaN0wG64OxgRtGH?=
 =?us-ascii?Q?Ms3Lgz8cZNEQkfdvViM8afwz8McszRzz5CLCPMMxqglaaOdDYT8yDiPcfJfU?=
 =?us-ascii?Q?zh5UK6KNZVM0jA9Yx0l2bKbnNs7miJrtwHKS7t6hrVu6OJbFgmKbTW1NuUvx?=
 =?us-ascii?Q?3wx/9oRQQuurDuEwq9IuQ6xGG4GWAErPBoQn7eB7iuyGMqE3u6gkqIjWYFbU?=
 =?us-ascii?Q?zYpBWlPo1g+I7vl133qONQ17RL4rJ/1yUsKUowyuAX+Q6gJjd/swBYiCa5x/?=
 =?us-ascii?Q?zzYw9ZpsqNrKOJ9w3WgvRozMUFF2/h/meEAn5973vxs1cZsKUBWEoM2QAJfL?=
 =?us-ascii?Q?pCQ7ZmAuX3Ygud4I4KULG2to9r7M+W1JCU2D/j3+aCrFP6gyOwI2KrGkkuLt?=
 =?us-ascii?Q?EswswWuJKr0ptLzKlwegwznf0Hro/eyJkKc2gEvJ0NY5IVHNjjW2p4oDYEkL?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ac0c45-a099-4ce8-bf4a-08daad923b4e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:14:39.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Az2xqJkpd1nksfJFDKGlZf0bNjjNb1ssUC5uRGup16NySQacrk9wn1meIpGUs7cZfa5pC+OafDBk1/PIGasBuTsbtH6doWGb8T+ZdR88Vgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_01,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210140017
X-Proofpoint-GUID: H4ZpfE_l9dEB1_i2hyjL4tZXrNhjrGkI
X-Proofpoint-ORIG-GUID: H4ZpfE_l9dEB1_i2hyjL4tZXrNhjrGkI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue to use a folio inside free_huge_page() by converting
hugetlb_cgroup_uncharge_page*() to folios.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/hugetlb_cgroup.h | 16 ++++++++--------
 mm/hugetlb.c                   | 15 +++++++++------
 mm/hugetlb_cgroup.c            | 21 ++++++++++-----------
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 789b6fef176d..c70f92fe493e 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -158,10 +158,10 @@ extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 extern void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 					      struct hugetlb_cgroup *h_cg,
 					      struct page *page);
-extern void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-					 struct page *page);
-extern void hugetlb_cgroup_uncharge_page_rsvd(int idx, unsigned long nr_pages,
-					      struct page *page);
+extern void hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
+					 struct folio *folio);
+extern void hugetlb_cgroup_uncharge_folio_rsvd(int idx, unsigned long nr_pages,
+					      struct folio *folio);
 
 extern void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 					   struct hugetlb_cgroup *h_cg);
@@ -254,14 +254,14 @@ hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 {
 }
 
-static inline void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-						struct page *page)
+static inline void hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
+						struct folio *folio)
 {
 }
 
-static inline void hugetlb_cgroup_uncharge_page_rsvd(int idx,
+static inline void hugetlb_cgroup_uncharge_folio_rsvd(int idx,
 						     unsigned long nr_pages,
-						     struct page *page)
+						     struct folio *folio)
 {
 }
 static inline void hugetlb_cgroup_uncharge_cgroup(int idx,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5228c2b805d2..d44ee677e8ec 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1726,10 +1726,10 @@ void free_huge_page(struct page *page)
 
 	spin_lock_irqsave(&hugetlb_lock, flags);
 	folio_clear_hugetlb_migratable(folio);
-	hugetlb_cgroup_uncharge_page(hstate_index(h),
-				     pages_per_huge_page(h), page);
-	hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
-					  pages_per_huge_page(h), page);
+	hugetlb_cgroup_uncharge_folio(hstate_index(h),
+				     pages_per_huge_page(h), folio);
+	hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
+					  pages_per_huge_page(h), folio);
 	if (restore_reserve)
 		h->resv_huge_pages++;
 
@@ -2855,6 +2855,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct page *page;
+	struct folio *folio;
 	long map_chg, map_commit;
 	long gbl_chg;
 	int ret, idx;
@@ -2918,6 +2919,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * a reservation exists for the allocation.
 	 */
 	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
+
 	if (!page) {
 		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
@@ -2932,6 +2934,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		set_page_refcounted(page);
 		/* Fall through */
 	}
+	folio = page_folio(page);
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
 	/* If allocation is not consuming a reservation, also store the
 	 * hugetlb_cgroup pointer on the page.
@@ -2961,8 +2964,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		rsv_adjust = hugepage_subpool_put_pages(spool, 1);
 		hugetlb_acct_memory(h, -rsv_adjust);
 		if (deferred_reserve)
-			hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
-					pages_per_huge_page(h), page);
+			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
+					pages_per_huge_page(h), folio);
 	}
 	return page;
 
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 351ffb40261c..7793401acc12 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -349,11 +349,10 @@ void hugetlb_cgroup_commit_charge_rsvd(int idx, unsigned long nr_pages,
 /*
  * Should be called with hugetlb_lock held
  */
-static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-					   struct page *page, bool rsvd)
+static void __hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
+					   struct folio *folio, bool rsvd)
 {
 	struct hugetlb_cgroup *h_cg;
-	struct folio *folio = page_folio(page);
 
 	if (hugetlb_cgroup_disabled())
 		return;
@@ -371,27 +370,27 @@ static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 		css_put(&h_cg->css);
 	else {
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
 			   usage - nr_pages);
 	}
 }
 
-void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
-				  struct page *page)
+void hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
+				  struct folio *folio)
 {
-	__hugetlb_cgroup_uncharge_page(idx, nr_pages, page, false);
+	__hugetlb_cgroup_uncharge_folio(idx, nr_pages, folio, false);
 }
 
-void hugetlb_cgroup_uncharge_page_rsvd(int idx, unsigned long nr_pages,
-				       struct page *page)
+void hugetlb_cgroup_uncharge_folio_rsvd(int idx, unsigned long nr_pages,
+				       struct folio *folio)
 {
-	__hugetlb_cgroup_uncharge_page(idx, nr_pages, page, true);
+	__hugetlb_cgroup_uncharge_folio(idx, nr_pages, folio, true);
 }
 
 static void __hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
-- 
2.31.1

