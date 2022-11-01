Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D80615505
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiKAWc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiKAWcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:32:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F81EC53
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:32:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M3wvs008145;
        Tue, 1 Nov 2022 22:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=NgzM/uc542FIf90DF6eXVseMOqdsd7MbkDuWx3iKQNw=;
 b=vwqqLDnfJWEdsJU89cCHjg9+ukUwvIEKGng95YqM2mNSGImUg4mVdffraNFqOpqcyVOj
 f0CCBjv5tAw87oO+qAhF2Njml/vtrzdcAcfVmqUaB9L/Whpjn0tb1yg8FzcL1Q7vpVhX
 sYUeja2ocC3BA7RGmn8khNXHVnFHaXPewIm2S6A/3kMlMqwmUbJMBA+vYiE+7YfH/WVL
 RMb2Ky41s1iLR86o1nGOzeQmOTtjFF9Q6VNC44BGwpcAWlMSfLssFhXITQkckzDBmOrz
 ZW79m+emrg/+7Y7DopatgGzkXrZdjnJwSOmvmcVBaypMWhk89HbJ7rthm9IO7TKeaURj qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkd7src-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KbWq4014088;
        Tue, 1 Nov 2022 22:32:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm4w2s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr8g98akcftOU5py7Fk4CyZ54Xf2liAbLNiL9x2dLS5oJeQ3VZZvC4V1AS2wU7B3uDjPh1plRGfGZ0uUiEUOFon5xzsNHN5nlF9Nbw/7lubJxNXCG0h4ohx/qjD+lQMuv0Aet2aSVy1x5BrzrBmR+SXHGBsIw51letP38zbpoVBNqarDum52HYhq5u0OKEed0vbNNw9fTCPDeHcZwGeseOffiAkctcUuXJ6jdYtesvkb39UEdwPbsK5eVHcP5CnfKcfI6qH+pfScwQMhbcRzkSrW7U0pks7tv00uDswQ7Q+HjBrOCG+OxYjkkJlB33bkLlNwzFDiy3Ya+OcjVHdQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgzM/uc542FIf90DF6eXVseMOqdsd7MbkDuWx3iKQNw=;
 b=YF6NRclSF498nPQNZ2NucuG25pg/Xb9p1n9OOhaKrbDK2t4jPg3FWXR4CseCzXpevhTPp/REXNDCbr8tAZIy1FMktHCVI+xt7BBteqzSKJucU8/fEae6wlAtAdSpKM+yrCYC9m8LEfON3kGwRyLjelIkP5LlqL4/FCmaV+Ky1LoH6SSNoEq6o5h+Y9uN9hDXi4lrTqng/z2eGeR4t1GEtB6nRb31ZMPpcxvDybm2P+x05t6ij4+JsrirUKItKbUpBYqCqCBf2o08dEUuW3sJBndjvc+NS/9XkfVZ4TQI8koscdMxFajOC1qUqp43mhsAkQgtcNGSaxbAF82p2d/fAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgzM/uc542FIf90DF6eXVseMOqdsd7MbkDuWx3iKQNw=;
 b=FbNVwmBtxMw7ZyWsCiektv6fj8zJwMN01GZUQIOHv1D2sHp2pRXicgpGV//MvynCwIsqGR0NMDG64I1NhnPV78yj/rcX8yUUDg7wIRnvAil7PH6f7LZ1n5VjHrrFYhrKbOCBuGYGRyM7IWzU9GUE+Fcl1VLHVAZMOE+9opHtvBU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 22:32:22 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 22:32:22 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 6/9] mm/hugetlb: convert free_huge_page to folios
Date:   Tue,  1 Nov 2022 15:30:56 -0700
Message-Id: <20221101223059.460937-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 135548f8-3249-4a60-84bd-08dabc58f1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEGL+iBiZCA1XPvEA+PPaz0lsDPGjn5No1gwjwLqQ4S1GEkdGtpE8E8xUDuHO9XxqepV2zbNXARPw7SrqcFEgbTq6sYG0R+v87xF9cmvLrgG8rf5hq1xlFjSTvABE0AbRXwawWe09CEe+Z+cjwdZSm+JMV+55ccDa4tEC6tUJ4VK8G49NNd35PIN0KL603YUT1kCwEK8nKxTFv5wV6qtGNeIxHMumTIXd98OIv5EcP9RKUF6YYcf4jkaq+SdWGNsulMU45XfwT7TSMLJXiTg6j8ypvcwbytuYhuXh3Mi/ASwoZ9K9bmlF7qYm7nGKp5nnzETnm551m4oDJguKih0GAH4qYT02PubagP5okGK9X+dwxd1vM+NzC4s5zIagw+PmCv+OcKMFZ7lO4E9DhXISb/U6IgE7sZyZcRIthNa/B2l89w6Ibly+uF00hxmsNo6IboK91aFfrvOwlHAsMi/afAM9EGLMI3Md87wl61GF1ixrpp8BWD2SEs1PF2OWtlp+15P+3NQAXnCRWvPzZ5LiNoKE5kw8l5+yVICTBVrC4bjT+qG1Nx9wwbXJtNf0gYtZsFYAMMnhs3ktQ9nVUQzkkudmS740GzVlKEDp5ePG3f/9Ozp2RrDZWCEBW4v8FtpbCBtUnyjLETPoBmi3eN2OcSraUh4CcUK4DNOU0sS1tzBQvmlhn5mOotR8UAEkhfqCrNgrI+1pQ0HWjdfnUiU5EkfuZnYRliej82oCduoOXS9kuDIEeknpSz3YxXk8n/RQ3jPFgBVEf9aB9cIxdd9Xzfgcsun8Iu48rvjGuSjeztMXrmhqs//RRHevwyr8vvK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(38100700002)(36756003)(44832011)(6506007)(66476007)(107886003)(6666004)(2906002)(4326008)(316002)(66556008)(8676002)(6486002)(41300700001)(8936002)(66946007)(5660300002)(86362001)(83380400001)(186003)(1076003)(26005)(478600001)(6512007)(2616005)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J9busoF8641pajFMZK26QDJWMC9eNJnMEUb9Em7swpHrHtPU2X32rScp53BP?=
 =?us-ascii?Q?GtNYJMhc9q7Gm8Fe665WY+u0mKd7mc24ngd2aRGIzRDYfUCR2ER4n7ovlT47?=
 =?us-ascii?Q?PxVmame8ZBMwfIkd0E796/WzNr5UjdkNTZTHAY3/IVzLf6qgYS6bqb94oMmo?=
 =?us-ascii?Q?D2ekX1BHvx8q7rrCG+CZDvqtv5PIqCla8Nz64kUMf2FPrNkOKN8diBQVUVzx?=
 =?us-ascii?Q?FEGg+3rE5msjpAdPFt1IjDXY/kUxGBS1z8I/9C2BYpRp1O/zsz9Q5LSoDumc?=
 =?us-ascii?Q?4iCWfX6SKSem3qX4nL0UZD1dNrAp7grBYGmIk70nZK4DSb7ltwnJpvlyjYix?=
 =?us-ascii?Q?Y25NOwNga5TvRtzTpRi+nfyizppeCN5OnvlsObYhntjLTq6ZNBMsO9quQISG?=
 =?us-ascii?Q?4khB6rNQ665Mvjcmx+DBdRhBmKMiJaCU0fsWMTRhlE7M1H47Vrvihq5bWWBW?=
 =?us-ascii?Q?9qjYbvnQjEEQ7hsgOqBL/WXB0tlql7tGfTb+CsBaHeOb4OvPglSeXg5M0tvn?=
 =?us-ascii?Q?KzQ8tq/OGA78YMBi/eMNi33QEXvjhMiUwBwk2Yf05Lgj1GOCrLf7LXeuPfb4?=
 =?us-ascii?Q?reI0qXlANuCvp9BMy1fakf6JMtK/ad4x8nsIEnmxZ0SC5cCT2MGcBmibUlT9?=
 =?us-ascii?Q?gwEkTBCaRP/ynWMxagqA7ocpwvgaXtQQQhsqpP9sEvRLz/85A5Nb7a+9F/IU?=
 =?us-ascii?Q?DlSQXD4/VGJkflDyYapsTuwpoApj+6EsKmc2ntFDgKFpwg5S+pLnF9m2n1ez?=
 =?us-ascii?Q?9ggG1h05U2aPX00t4Jb4CeT5IA+qs7CuuxfdjTu1KScaGwuU6u51+Q9LihQA?=
 =?us-ascii?Q?n81+fjRHwb6juSOwnqyFqks5H0A9F8qsKnRKkxrH75syrynxAXtf7x/+dnwt?=
 =?us-ascii?Q?mQ9syXnG2G7iTnPMLgXNu8osGqitSKAK/lCbQyeCbZyIEvZMyI1gxLU0qJwd?=
 =?us-ascii?Q?VtkfrVyatStakhusCUS5cgf9GrSfj7mtydHMdXHj1S+OU/XJn/YiJem3LFzs?=
 =?us-ascii?Q?8D/EPShPiwyYLTeqayNr+AT5AXyEbABzze55/wDYJnANRag4V3RLw65GitcQ?=
 =?us-ascii?Q?Gs2iGiO24exVdUDDxHvy5xQRr++firDkv8wm1/hM4FdZPQF3CIIn9LMxydrf?=
 =?us-ascii?Q?XcH6psp7mT6RTYwMWuiTrFHGDdTBgvRQlP00Zh2xOcSJ4VtRzjAgZlZ6jpZo?=
 =?us-ascii?Q?C1PgWF3XgJ89gZRfkbU8ND9MsNYPbQocMKO42JgRlWptfucWkQFs+5Y0cDMv?=
 =?us-ascii?Q?Tmln5segISHmV0RI407vcbTrGlz0BwsZ4asR+/syQpnxkyzBv1P9Nl3Pg8BV?=
 =?us-ascii?Q?iydvNuGQhs4eX78dG/nC+h01KinTgqO+W+0VRVWTLhR4xiGyes9czQhSZ2fl?=
 =?us-ascii?Q?nqOPO5munDNrZGAkKjPh4K/YU1fXWO2eknhr+p9jgShwIjDzDmwu8QQhMb8y?=
 =?us-ascii?Q?0c/YkhpaRpzYCjgN0ZEqoYgxgy4unL8w0HaexK0mDidmDStxqrY4KVpj6tSw?=
 =?us-ascii?Q?e9h464uFi4culWvvdyxdcPzF+VGwT8zpbY80oMTwmNKbcaPKH/Rs8VupaqNT?=
 =?us-ascii?Q?sdkMs4Dckg8MCiC8pHQ/ypp+WEDy6ESpqEAu/M9k+904qM220G1/YAj5BLrw?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135548f8-3249-4a60-84bd-08dabc58f1bb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:32:22.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tCCZN12z1p4r9TM0rxZVW/o5Piq3ddKpgI1ZDkIRqRy8RxUW5fyJj4U7WI6d0yDk2qp/AGU1vaydA+f9MtVwp7PWTmAgH+qr3kjnhZoWKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010153
X-Proofpoint-ORIG-GUID: YQZ88rmXGSxGHijqNTIs84qIUW4GC6b8
X-Proofpoint-GUID: YQZ88rmXGSxGHijqNTIs84qIUW4GC6b8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use folios inside free_huge_page(), this is in preparation for converting
hugetlb_cgroup_uncharge_page() to take in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bcc39d2613b2..387b8d74107d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1688,21 +1688,22 @@ void free_huge_page(struct page *page)
 	 * Can't pass hstate in here because it is called from the
 	 * compound page destructor.
 	 */
-	struct hstate *h = page_hstate(page);
-	int nid = page_to_nid(page);
-	struct hugepage_subpool *spool = hugetlb_page_subpool(page);
+	struct folio *folio = page_folio(page);
+	struct hstate *h = folio_hstate(folio);
+	int nid = folio_nid(folio);
+	struct hugepage_subpool *spool = hugetlb_folio_subpool(folio);
 	bool restore_reserve;
 	unsigned long flags;
 
-	VM_BUG_ON_PAGE(page_count(page), page);
-	VM_BUG_ON_PAGE(page_mapcount(page), page);
+	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
+	VM_BUG_ON_FOLIO(folio_mapcount(folio), folio);
 
-	hugetlb_set_page_subpool(page, NULL);
-	if (PageAnon(page))
-		__ClearPageAnonExclusive(page);
-	page->mapping = NULL;
-	restore_reserve = HPageRestoreReserve(page);
-	ClearHPageRestoreReserve(page);
+	hugetlb_set_folio_subpool(folio, NULL);
+	if (folio_test_anon(folio))
+		__ClearPageAnonExclusive(&folio->page);
+	folio->mapping = NULL;
+	restore_reserve = folio_test_hugetlb_restore_reserve(folio);
+	folio_clear_hugetlb_restore_reserve(folio);
 
 	/*
 	 * If HPageRestoreReserve was set on page, page allocation consumed a
@@ -1724,7 +1725,7 @@ void free_huge_page(struct page *page)
 	}
 
 	spin_lock_irqsave(&hugetlb_lock, flags);
-	ClearHPageMigratable(page);
+	folio_clear_hugetlb_migratable(folio);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
 	hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
@@ -1732,7 +1733,7 @@ void free_huge_page(struct page *page)
 	if (restore_reserve)
 		h->resv_huge_pages++;
 
-	if (HPageTemporary(page)) {
+	if (folio_test_hugetlb_temporary(folio)) {
 		remove_hugetlb_page(h, page, false);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_page(h, page, true);
-- 
2.31.1

