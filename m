Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A57615502
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKAWcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiKAWcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:32:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930E1DA5B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:32:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M4JCd028857;
        Tue, 1 Nov 2022 22:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=KdsTBTYZo2zEACK2jZOJjNNyRhYH9a6Qvdu9EMo+Lyg=;
 b=VyULCVEpNhKG3o7B7XY73zWpXQO0mddCgo0+WcV+qLe44zPMv9zfc4nMdXVTa+Qe4CZC
 o6Ihd7ihLfzp5ArU+cooZtDxep6qpIEgcRHO+l8LhdOTHXbf86x+QQWAsWZRPe1UjZoA
 Jcja4jjPcVTBT1CcpWFk5lm22bwoEmlCVm7qm5qPt1N5e+EaXk91Ue9FcRcwpIKayC8S
 zxdHO+xv9gd+m/mJIJf47zQ5l04Wy/WHqY2r48ia2NkvxEk40lmThZZ/xwlT/iKQt7R1
 x7WBuhVACdSgGvxFks6rjyfgQRFlk3XbFDn58LBA4eTTBo/31EoYUOaNm9PN3eHs4WZc Lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtg3s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:31:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KF29a030232;
        Tue, 1 Nov 2022 22:31:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4x6tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:31:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLT1B8lV+CuR87uwcjW1rxoveUJHn1V/PP63wMUlmvivDDzzDbhNbtZvCzdggZFip3cJrFhxZ4lK02CNxbr9bWLPQ7AC8fhHuE+vOMqVuDP7WoigVY6DzAqNZVlR5Hgdxh6JHt6XsmtWaWBRsQyyN93AQ1UqnYtN/sUqpAmUaDJLTj/V1E/OhGN6sfEuX1e44RDhmf/I4FzgCn6XnI5jYL8kqrGgtF2QJpWzRSkpIR87ZQ9XVZ92KHxZq/xYBd8A1vQc5OFdkhhX61NnxsthsVfSMvAGhPrbIv5OJHRH9q0FtojdDuMEEQkKRenVS6gQ9iONBpEaxo5t8ZaepPPfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdsTBTYZo2zEACK2jZOJjNNyRhYH9a6Qvdu9EMo+Lyg=;
 b=NsiQvz8AH2eOujNYNfdtj8cAXnb/+Tej7hzquz9eKPtFAHpfl0Yozrm9PM+7kY4UiTdh56rHrv3C9RQsccBg7xkhA//V+P3IDRAw3Lv1+/uquf9JI7jkfPhi77bI0Yvm/uHyqhvMyTKsNVi901gG3ASvpM1TAYUUQqHK8rm9knm/OaEwd9dxZd/tWb1stYRl6skAVp+RWcHJj4YujE6V90txZURahF9sVsZWRPagJfEQzj/cQvG/H5CVTfYSfjD3J24rUPenr2NFPpCy0NXu4/QdEPMA93bJM8zDq9Ptz0iDG8oswFpkiJOb+HmHBueBFp7nadkHkSkbn8pSiPYyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdsTBTYZo2zEACK2jZOJjNNyRhYH9a6Qvdu9EMo+Lyg=;
 b=AvD41R2PtfQ/jjBlbEuNLnLD1KarWWY1kL4+1UnvaWmUxubWBc1qO0E++/NT0yitwt/en6fDhi0VdKFd/9nQB0D3MmcqIBWnLXNRS8MYc/XiFJtjnPBF8fPNmYNC6khFtBsMvtdpmj2OCfggQygXtKDjYFF/ZywA0t84ThyVcTE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 22:31:52 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 22:31:52 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 3/9] mm/hugetlb_cgroup: convert set_hugetlb_cgroup*() to folios
Date:   Tue,  1 Nov 2022 15:30:53 -0700
Message-Id: <20221101223059.460937-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::19) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 20df8c7b-6efd-47c5-7f9f-08dabc58df76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opJn6QpbQ1J4U+cu+b/r7jFZNIid56xmKlHtGxU1Uo3GMH4aBLPEflS23UT9rR8Y+VqVwAc2Oi9MvmmA8CsbXZ4zg5LsxPG0D1T7rWhaT7wL++m1S7oi15umhCJacz9oQPdg3tFTR6tehuzWqEVaVcwtXw24ZzA/dkrUqTisvM/HFoQXKu45Bfy2RJlMI33d6zUNfq6yb/SX78SFBQ1UPP0XbkNQ1I9aQkcJYigFwBxJLXuNjS+AH5Thuw1zC/ypEahScGb+XJbYk2Y7oBFunXRtXcte/2hCNYapLe66atxsl11bfJMGJc8+45i/ZXuRIoueuktHvHjikDcSi+AuJdROZZe66D0wnKTSljmlriVHU/GqVel5uMKjJuTy9WB05dp7GsgVfhWJoP17eSG+YzuLDPtyOHNSrwuNtNkpq5wKe6QVjT4vx8fkz2xRBLdseFu2DlE5QnVV/n3s/HWTirQinVqeTP0Vzi82391f3h61bvD+a3PjOPRhn0sNheTY9ACUOH/trtNx10tOt2OKrqRVI//125WO69g+MvYysQuc3nVzyP2ugjybRhjU2G5Q8gOloekfdIHCLT6bBLXRiomywyS5XbIFQVGXX/Dkn86e7lO5quyNntfKuncEMD7cGbWECNxkohLHm0IcTtx+uFWPeOGqjWCyfyLzJpIEDsUx/PFfA40raI/KBc3wXFcfL0KdyrDqNS65ehMI8E9A9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36756003)(86362001)(38100700002)(83380400001)(2906002)(5660300002)(44832011)(107886003)(2616005)(186003)(1076003)(6506007)(26005)(6512007)(316002)(478600001)(4326008)(66556008)(66946007)(8676002)(66476007)(41300700001)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8uwvm5xOc+u2rYtdqgT6e8vZOkkN/widhml5YtJAWo+hjBq2EmaDgD0xdDUL?=
 =?us-ascii?Q?IpN6qUo4uwBMh+YGbzswjpEYtcGBzIgL7Yg9tnRYEMAhj8ZBlQnh/piKV7Pr?=
 =?us-ascii?Q?mJa4DjUZfVMnIK/WB3nVm1aILq6Tdtr1cG/Qrx+STYWiVYx0SYQUsdbSC19+?=
 =?us-ascii?Q?316m1p1MNWVnvIy4MVphXjnLuUaPitRbaLVEAA4krK2k/edePt9NXVOKXH/v?=
 =?us-ascii?Q?0v05vdKIPqegjgZdeQBU8dvlUbMb2PabAiAqc/CWD9E1lPuQ8+1rw+X6pL/K?=
 =?us-ascii?Q?zcDsWWqJ6YGjKxy3ZDE6bFMdAwwPDJ3yck24BqxNjHFx+UqUlj7IxAlpH+iJ?=
 =?us-ascii?Q?QlYq0YzQDpP88uSvCpBTmzaFrL9XHlp8jjn01DHQpY/T2dgpyHR7yU7Xx0uJ?=
 =?us-ascii?Q?xLoW5Jy3P/rZFJPosN/Y0ZiX2IPDJvBzpM9+VbbTSFSW6/IwcDvofqJiYa1u?=
 =?us-ascii?Q?3QKF5Mk+UE6/DmwIzP+WxfH8ERFQp4Q9gLT7fwzNdZOFz7ajGAudc9VAW8tz?=
 =?us-ascii?Q?eV+7hcfi6tAnsFP9BDiSYjyv7EDB0Klye1v1+9L92htBqJoyMiB8heQGca/C?=
 =?us-ascii?Q?644q4MDv4vVFq0hNKtxgCn7G4Pz3VcZ8/FrUKDEuUPAd2lni5t6kbTJWOznJ?=
 =?us-ascii?Q?0RkZynl+sdlLIhlDQtFZLWEJHJNw+MpbyDvMli8J4iuutk/NkcqlGGD1GWUZ?=
 =?us-ascii?Q?kU6YX0HcgHeRSYa/YNjRd4MkhY3nvHsh/9R2rK38vJmYMQbl8R2w5qapFktQ?=
 =?us-ascii?Q?snsvYRKpUkwd50FG81uGMjJX5s0tmYK+N1oiTqVcR0sjgDU+0mwWwV7xI0kK?=
 =?us-ascii?Q?HSsoqRTgRY1ZL+Hip4r50OSUgbLCYv/Rj+bdv1Jd4N9ILgSZqqpkSHMTgbEV?=
 =?us-ascii?Q?2Xqo3/FuvSDuQxKUk8Mw6y5eeEwwPUEwKAR9qC0p4yoIhEaefHqvdHopf5xH?=
 =?us-ascii?Q?8gIrfUh5Td+7cAy+o4kiNnc2cC6zDfLaIu6p2jFWbHiYSR5i8sR+KOjsnv59?=
 =?us-ascii?Q?52AzNBCdse29bPPGjROtKn95Ceu2hj6En/oA9ImTT9X42kF0InXlRyAH1cE5?=
 =?us-ascii?Q?dSz02eQ+Go47J8TEkl1wRQ6SgJOauI8g+TygiValKDulNeN6dLi4AmeeRi3I?=
 =?us-ascii?Q?N9tOLyXPdBwHPvvCMJSJSGuqzmUfYlVIR+RHWzWoq4Y7x3svEv8eA43FOpIh?=
 =?us-ascii?Q?SctWTNMh3qMjDfJwpDJvCuFRpmk/NCEbl2gQSuHpvSSb0w0hc7CbZCGDRypK?=
 =?us-ascii?Q?MTgaUH+g+NgGTzYmPmXTIGIQJEWRZIFtziQVmsf2j7cfBKJiPVOKh2AV5qEP?=
 =?us-ascii?Q?I7+QSWOuuwHo/bPSUpI42V3AJSVmPx6pf43m/WLWbeka5c1VS0vDZUL3eEUv?=
 =?us-ascii?Q?Uac6jNy+xfdsn3SWkDuJCb33uZWJmDWzScsRDWYPqLUwwqyMr7yZhq9y4J8E?=
 =?us-ascii?Q?Mll2JuIikiyVSrWHx5eR27Hi9+sm6FrNns2JgM3gprQC11bUZz7wHTZJpVGz?=
 =?us-ascii?Q?LNjNTct33zSuyPiXJVNgmO3LoUy/6fVKvwZkBT0b2eMsukCmL9j9iigSNl0V?=
 =?us-ascii?Q?h7TuPCphJanvmsp0v0ipchKj6snZLkAI0Sm5ref2/Sn46JsYNA3tVS2SKEnr?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20df8c7b-6efd-47c5-7f9f-08dabc58df76
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:31:52.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ux9XJ94S/jx6IowvAUtprtQ5P42aeFUg9CjUXr8SOvyeGffkcp+NVpSHTVrU16zu1t7h/P3YyswGQ5sjx1i8AQmFXgp5206yq/4lOItvd7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010153
X-Proofpoint-GUID: jFH3CoGXk2zKwRVj2eiCVUOydnTd1XdM
X-Proofpoint-ORIG-GUID: jFH3CoGXk2zKwRVj2eiCVUOydnTd1XdM
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
index 27b87dc85c48..a6384fb0b57f 100644
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
+	} else if (!folio_test_hugetlb_freed(old_folio)) {
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

