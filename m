Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B71615501
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKAWcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiKAWcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:32:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB391DF29
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:31:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M4JkR022298;
        Tue, 1 Nov 2022 22:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=SoiSZrAfuSEEqpTJ9G+tvTZwSqBKFi2fmlrDiYEXpPk=;
 b=gjMgF6IKhIskf7KabNrBJ5DCrYJpZG9GffF+udzbzL0HHayMmSLppOrsV+mh1mldZhB8
 Iwoe/3cA3aDPMlOx/k6LR4L37eU4XbCFtEUpS/sWWn1cKrzXnc6dUbU4IoeztcyYFu0M
 eYcpS4h0NXWnGQL2K9QVDSlMEIm2xUMlfzJgv8O/MzLPC8GxUgObLu1Y2CwmGv0b6Imr
 usAqdnVTyFWCNchoDE0rzMuzBPlklaewSEwMwtcL1Vb0/Pqy4GAIAamef8YmhcK9G/6e
 BCcKLrw6mlUvMB3dlKo21Dskj7gISvSlhVhfVqcy12IhDWpYVVOmnu52Xvd7gfia7Zim lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts185c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:31:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1Kkd8m030335;
        Tue, 1 Nov 2022 22:31:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4x6ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:31:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8xr1bkltI3vN5I3Xg9aUpVbWaO5XNnh99ERhC0uYbILFe8/g1xot/+fEzyk/o5Stsi8UrXfs8BbIeUWorhbqWkTUaKZ00Eq2gT6g9oUjdWYRh/OIGCNWZhpDpZReNSPNViVa88oOSRvwcpBncsB8+fyL7mDVTAKk2A9SL7vanyqrP/V91QW2ZCJFrEdfJC8WfxwByBVn2GvYQMLWXI/jmpLch5YE+JTE4KViql8BbxNPEnHms0j/S/pU4w1E5iiGNp3rr1wutIC8yl4tQWTy/xSFGLcgFupOB9lTTiHiULwyZVsk3QxdpbWSSlHR0vaw7P7JL3SEvWlXSVoymzEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoiSZrAfuSEEqpTJ9G+tvTZwSqBKFi2fmlrDiYEXpPk=;
 b=H8GB9bSAmUM4GBbeYCDCU5IdwyNcwKUo/Nvx1D+MH+GX+tzbwAlIIF+sL5NhCX4R7i/cIlFuckBAfM4OqCj/z+bPO22/cPdm8Uf1TAvv+nsJJUKBeh3JDJQZxNDXBf+SgcbXWGpypitAPH8qvduHyMLV8TGco253z1pXorsu+af46buaujSKSJw0amPMb+3qGmhdIIGr0p04D8dsnpCVo15ev/fbbsj5gFKyJ/GcF3p4/V3QtRaV3DV/9bVUYFtLKW9fV22c+09lmpakGOy049n1uAY4rXXsrEP0TWR7ACt4sNQAiqPpn9MJgWcZQgYWlQzMOtlTjuS1dlhwYXTYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoiSZrAfuSEEqpTJ9G+tvTZwSqBKFi2fmlrDiYEXpPk=;
 b=ASEqAG6jQLDaH42agdItsrYtyEF56jqGudHxBZ6SpDbaXuWePqYFG1EIiYI8BKmg2NkwJ7bG8UpOi3gSI71wjMNRjBeuAQ9kUiVVJg0f0XqhbYMeizDvBGx8E9bCFeIUEe4fmIZIqmh/dsZ3BBw+bBQAnaLy8MPETBO9TNxj55E=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 22:31:41 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 22:31:41 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 2/9] mm/hugetlb_cgroup: convert hugetlb_cgroup_from_page() to folios
Date:   Tue,  1 Nov 2022 15:30:52 -0700
Message-Id: <20221101223059.460937-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 94aaf729-55aa-433f-0bec-08dabc58d949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hD7Nc8ksVvD6yrBpHKF3Y3VIN8uBAXlYiWrK4XAKJl3ouUE+DnDRlZsL0Eel16hMnwhf9ln7ti70RAEf7wMlqRCibRLB50+znuYqzu9Tu9G6Vj0VbzccsXPdlPbJuAVuLSD3Zm1dsgnoM/uCu6b+x3nX8ggEi4WAYp0/lg3cnjkChV8NHjtRuPrzxTeRBQO47j8Ir9VPU8aHRSA/H7lKkWflY48BRaUSXiB0TqxDuND46zMIGl8KYBRXWt6THbcTUhzqHpFuMJ9pQV8DP8v3Gy7eMf5x1QGUb/aGiGfoUyScqK3TFXu+Um9FIPZF7YgRR7Bpq7idFH3tKNOTB+byjgqpclGCec2w28mCkPLdyzK/adWFFJ/O8PUc/L1JCYVVC7jEW3Ozd5VcFJ4Oj1EPG1yefNd/bCZSrq4okV+kqOHYPoYv3MKnBIlvd4Jb3/CTnmnaiD5wSzKna1F3TmNjAv3MHNgg65GRiznfqbaaOrYwVIjy/Uu1nGArVg6AbFw8Za0pH69veZRs4VtT071dQlOlPl5pD4ir8M24nc94eOPMb8KMMg1zqgRgUohdSNHRTtu8lrXDPGng5sY/1f7C5pwRVHMKZGE1rQIumcbmA2KnM8uHKaMnOYnfISwChD0nV4rJlF4kH/f+e/QYM7T1Sn49ShXtrD6IMOGkbL8TLYb1n/Abnc7dQIAosArNGqaW/lCRbMppQ2t3aKDXo9srmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36756003)(86362001)(38100700002)(83380400001)(2906002)(5660300002)(44832011)(107886003)(2616005)(186003)(1076003)(6666004)(6506007)(26005)(6512007)(316002)(478600001)(4326008)(66556008)(66946007)(8676002)(66476007)(41300700001)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bsucmbyEmhjQqVBnqS7Qm7AeDMDKNzuKyPp8sbI1tPNs+iF/AGXIEY70rVXk?=
 =?us-ascii?Q?Lee8TAeTqH6Xj+Io/0uSy0POrJ5SOVVvIT80I4XTGF/jikv6ST1xk4v9PvVn?=
 =?us-ascii?Q?v31qQ1+EnXqtV6H3HLYl43PXU1/5x/Dk3B9aSvg4JA+eoq8v6XYSVwg1oYXm?=
 =?us-ascii?Q?sRZk0zQXFyFjCMp005F1SL1lOUI5Kxl+Iuygp1USHpqd+3+00UzlROi7s9kD?=
 =?us-ascii?Q?ZW0lVcn4K1ofu0JQ1DaIyBWMFKvtXrKUgHwDM4gEseWmoY0GPGNZePinnPiH?=
 =?us-ascii?Q?r2QLRarhPq7wksM/Wlbxz7r9gIubnnWQ/+mtxsxGrZModQvxaJabyq6Ui5bb?=
 =?us-ascii?Q?HauiwTfyMOeXlHh5a8fb7YAkrmOyB3BUYu0JQVDIQFyDo4XNI0S24oBT3ttl?=
 =?us-ascii?Q?oGFj2FaIjZUxqSZbWAlArb28M4i6E2vPz9yzMiSMhKHrblskPF4OzcTmHSxs?=
 =?us-ascii?Q?vz0P/yTT4QMGMVGTClRY3YXOD90vCr5aSDzhHYO/aLSL8T8MdSzqgp7RZ8yy?=
 =?us-ascii?Q?QxLTW6TJeiNfiohSZvhIWTDJVHmk15uB9oMVo7j+mQrO73gSJfif+FveQkAN?=
 =?us-ascii?Q?DcNd/qBRVcepUJBY/Y8iTQLKURjHZwme0uNH5E+0weEKOqr6q4EycxzYn3Pk?=
 =?us-ascii?Q?Nl6skXi3bxCN6MZpfGWQRbhlbXIocgw5o9RL8j45Mi8pzVLNPk6qSf1EXFJB?=
 =?us-ascii?Q?5W1yJZH6tjGwSM9p7Ev8GmOq5w1sS0NsAa8hGVBCfZbKUZ8X7hnEefn4/wUA?=
 =?us-ascii?Q?Ld6eXtzhUbaGsrNSqIs01+NHEWNzhUgZln+MP81iXbhLFxwlX28ZzeYyYlAQ?=
 =?us-ascii?Q?yOlOCi8XIWjJsSxeIeTp79b1KAMZp/h/VfYZnauzonWNx7NaQbtI2LOuJcnO?=
 =?us-ascii?Q?VTTVUuYQFVrsjHHl0qm28pLuuee2KjBizo5Xcx0ZjvUa0AQGxzIflmncnyUN?=
 =?us-ascii?Q?gcx0tFhz/hkhcNT6Z2ikTJ9L1q+lb9lBxmjnWmtGH0MuX8Z+qIasmei1xA9d?=
 =?us-ascii?Q?T1+/wrIsaIXG+wkCx9R9JoUwHWZZ28/J8yNr69KoW0xGjAk2cZBtL+fWqvVG?=
 =?us-ascii?Q?WZimO0UgzNSs/yZ1AzJhD9H0RrdKq2sexNEsrEvUVrkXY99iEd4/ejTxaGq1?=
 =?us-ascii?Q?Pr8KA8Q8nOuFKtHX6b0qfNalnbTcXMDdhs+bcn2MMN9+ndTycBi4+VLglKKN?=
 =?us-ascii?Q?UI7BtliO1ldjrOQsixRIw1u60PYV+f48OGyaX6LTAUB2ncGXhgcwweO9ql5W?=
 =?us-ascii?Q?SeV2c4EM+mjsfk9oTUeVOJG7cHQMj3UuvBkdXHz2y3+VNtCzI07y1Pp0WtgD?=
 =?us-ascii?Q?YL3ZpPURUB5Ep3IPDEipuJP7UQ3PKElcFsnDsVpeweuQFzBeArDFwjAtDC+m?=
 =?us-ascii?Q?XohSd7amp6ye7u94uAJCJRkeaATLTu5kI4XSnSh466zs8oEDzQ4fQ1JiYD7i?=
 =?us-ascii?Q?reZywQF5PP1F5EJNxiiyZGQgiTnHf+zUQMTdFBbg4qdT7Zr+310P0QFUkuXN?=
 =?us-ascii?Q?ZhDWL1GNedcBwO+NihBMb8WSuNBC/DvowqV9Tx7HuLjFOLFHqZM0KxEw2Ybg?=
 =?us-ascii?Q?BHboWrE4ibkh0K22hqzqpE5sFBPiwYWIdMFbJnWWPhJaAEb3mCy0Q4haW4TB?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aaf729-55aa-433f-0bec-08dabc58d949
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:31:41.7589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iUgagMhTJLIxyP8vgDvQ7tM/9t9VFqm+0TIBWDFE9OKL7hiaOUZZD6xmdYuMD3GZ+zkpdhK+lEpnQ5JnBpbglxarRXMcZIubqsRfqn79KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010153
X-Proofpoint-GUID: SEtxQbJ1PNByXguBpFBl4bFlbgLavqOv
X-Proofpoint-ORIG-GUID: SEtxQbJ1PNByXguBpFBl4bFlbgLavqOv
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
index 518dfd0a7dbe..27b87dc85c48 100644
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

