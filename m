Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFC5E6765
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiIVPnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiIVPnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:43:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6537BECCC3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:43:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MDnSF7019832;
        Thu, 22 Sep 2022 15:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=bt9CtrWG1S5Son+fucIKpV6bB2mdF26ziAG6aIl1FPs=;
 b=qcWw37R7Vhy6jshL7V1eQH++I3VDvENRgZQArm0tnkVmYqCT0JVbmFwrlwwv3HOGnqqb
 z6pp9h8QMKSgjEMTDmovnGd9VGoTr6a8XeZxoMKvf7kIs5636qfEl06JpvrEbLXv5wrC
 NEYbDJOJl6XE9EJeJRzAVNzZnLTwvB61dYtfZMfQQHikrjwfTqefaRwGT+xHQa7i1DNB
 5RZOOya0wERUnTGcr+Mr7OfHFY4f69I4egON8CaBd9sy59lPd300F1L/oLC6m8c/bsBK
 mtJQusmocLqypH0KxIQ7EWTfGsPnlp3/zOILdRgJfTGpG7rXSdpSOYQVAJ6j48lUgRaB sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn688nby8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:42:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28ME0D7m010184;
        Thu, 22 Sep 2022 15:42:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cbdwgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:42:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ25lqQA455H5DAGRnguP13W4ZN2oLIl+voh+8uvgOfhO7EzQlWBaWuW4mxj+nmk/M2T5o0vUnyTfOZ/29z1akByGEr+UM9uKiykphtlRJvNsLqGSoXYpKNlyjDsGE2D1l1Ch0UYlQxQymSAiZ72FLxlxwdrczoqMXkMhoDkJDk/Kq6/tSP3WcFl42J7X6/u4uJ4t0JhEBAcByjs+4TSlOOsL0LNLdRwPBMGJTDqDMor6q/1oFXSWCPjZOekrS1Q3F+IyfuTeVJIvzbt9L17b2rIPkjtSfLSgLVm/G1fT5D2w7+6z5+ztnEoH6U/RGUp5VnEa7Xnn7Jg1J1sLAdWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bt9CtrWG1S5Son+fucIKpV6bB2mdF26ziAG6aIl1FPs=;
 b=LzapEor+VP49iAIxHAQQFk4Zv8REFf61Y4VJA68WhIIRU/h5w567hABagsFpoiQOliPzK/kulC8jy0TeyFvSbZM3GDeUpbyvaBc5p8Urr3/vMF3eU8M4PEgt+sf4DVj12MJNzbue6Agv/d8N5fq/u5l/lKcLExN6n6yp67Zh2Q4T5O7EMt6GCP4I5Z9Pcb0XH5hcaDXj77pioeXonnCfur4RhKPDRoXO5mgmuUwL/BYs8ejkmVU2J6XLXx/mPnivmIUn3phD/8nTBTOKUYTTp4CjX5wQHfqWbqMzgpT5RFQIw/XGtfVEU2OfSIwRLZGj+VF5l3uLGoSb0KoMT3sCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt9CtrWG1S5Son+fucIKpV6bB2mdF26ziAG6aIl1FPs=;
 b=hVCOYZRRhLEmkJdRYR8MwtyL+xAVu/nzZs7JCTA1BgXyeDAB9caJhgYj3C6wkpfF4MI5kKgO0nvN5jUO3f8dcFG23Pb0AndbWILa44+WomFWTeI9DMPZWX/ICdoo3p7mUIkpaGPAwipplx5tUvIOq44P52JlFuFxWzCdWPP4KHE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 15:42:46 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 15:42:46 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 4/5] hugetlbfs: convert hugetlb_delete_from_page_cache() to use folios
Date:   Thu, 22 Sep 2022 10:42:06 -0500
Message-Id: <20220922154207.1575343-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
References: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:610:4f::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: baa36f1b-80af-4fcd-e349-08da9cb118da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4QY9knvumZF/wXGxvMHlPUbEPC9BTVG/fASd5y+UP7ZyzJOsibvKpBLfG0Cq0ptoc323s+FAB4kFTH/IQBLIzZ3yc1ubavWNlkKoEgTrJHPruZMnuh2RnHYObenttokqIsCB7BL4dIdQA5XBzRrwrGjDHrBnxBP+Yl1ufe2/OqRNAqDSeOoVz5QyHR1baFh+9zR2L54Ys7bAnIA6s/W5D5esdUP5kOiAkMU9g21bXFEMPwrPUSyvqzAMtpygagVPjhdgCPxxY72+K9htRPXgWLYIIzzZYiasARdnibj350+XduytDc3y/bq80w9oiShAiXbl30ElEjti9U1F5r9g/FNa3lCmvZ1Z12UetUTqJUIFHt9uF7+oQ4WgCnMI0rrty/pFuRi3rmYx5ZNwm05wMTgbrc5yN+Xq8o3ZMAW3K5GRSwbsTml0DxI4/r1fWsEnvrcNSoHJeFuxrTfBhoaTC2XMhAsCivwxqjWsx1Wmdur0C+7ifagPtO6IG1RmbRydPaxyoL4dOTw2HqKdTl25u9qdm+J7Vs+tnZc6MsCwt56o/EDK9yq2p8QIx4gMZo/o+IhUUjG8ygZpn82qeY1hCrN+CID1DD8VgoZQGnh1MvD5fLKhrqlfOcnlPV3Pj3/gm5ONKEg5a4lFcufrFZ1ol7RzNYNONncOIi0769CU5EN7LbGS08Y45XTa6z7XR6R/zwcSf+XGWlue2Pd/l0ItQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(2616005)(1076003)(6486002)(83380400001)(6666004)(44832011)(7416002)(41300700001)(26005)(6512007)(5660300002)(2906002)(107886003)(86362001)(316002)(36756003)(6506007)(4326008)(186003)(478600001)(66946007)(66556008)(66476007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9AJ9fEwx8kPFkvZgY2yzU8nM85t0pBEUoDLNXoSqbwftB37Hw2mejyUDdGAu?=
 =?us-ascii?Q?nqKbjhV5k6GlOS4UF7GS0bfM0SUdvWYc+cbU+wXy4Dje11n0dbpQC7DW8+8A?=
 =?us-ascii?Q?kOpZlhY10/6drpx4sPEzgtWp66Naq4MC8fYwgWrkFYel4sJ6MCd3n9jZPQPV?=
 =?us-ascii?Q?wYP68aeHOIriFPJXDqKKNVJ/UjN4m3sc6RAXtPeXqepOniH6aCcw9WLwOgHV?=
 =?us-ascii?Q?WQYMywB2OpymdrCBaN6cby7Kxwp6P+D8fQ1vCRXN49MQIkLv+5zaaTKzc06a?=
 =?us-ascii?Q?+a43mEVwCPg/I99vT2S9THkSO6i+Hhv/whrrWLH3xf2XMIahlJDsDXGjsGRS?=
 =?us-ascii?Q?+wD6Q4nD1YAdXLfYIpGTshLhV0QVDtmPUDRqkDddFy3Y6hFz+7w4wrZcc6d+?=
 =?us-ascii?Q?QIx36uuFhucQOTYEqOrS7GJXMQwewuiBTB4Vz5oLCRE0fVQUGq8SRoQlIcH1?=
 =?us-ascii?Q?hHOziOuax8Zk0riNQgKWFpS82U3CyeEqlvGes0Z7XlGz59bzzU8Zp7rT8n12?=
 =?us-ascii?Q?BP6BAS+3ex28fyE8HJJJA5WbysJm7yZSqwpgTf9s7/m5SQB3Fyhnz1MV3XjV?=
 =?us-ascii?Q?mCibzpBbX1nQlIo4AWhhFS/lmwvUwzjtGZVS4J/+n/Swgm9mXREo11+QLVe3?=
 =?us-ascii?Q?AOd/KqRzmcRY92OK8oxJQz3YvjTS38cHt0tPASm5BxJv6E5WGXep3DnlaCJ7?=
 =?us-ascii?Q?Ti90Dhh4mOihIdUDXx7ARAap81jhK4iL1o8nNOYr8zspM/foooaXMNv/3E8C?=
 =?us-ascii?Q?Q2Dkdi4YoEMpcLluIi40StQPUWwOCQ9fd/nWYxBanGn38t7c85xyqrQvJ52Y?=
 =?us-ascii?Q?KISMuK7bltLG/5k1kzTGaGFuH2x8pW96oECljT3P7beYfzWOTs3gZvUKSR6V?=
 =?us-ascii?Q?UHVsk2xYB4HSeSfSzWIdXL0E1hKogslWXRrHH1WFdAeRdP8rRSsateYhF0Ni?=
 =?us-ascii?Q?A6sEQGrrsPI9B73N7VPp76lO8w+4u0nnlsSkbbrLCQYWcVxs/oySxjbZWaH4?=
 =?us-ascii?Q?VKMSzqCNnVd7sH7uypYVI+7w5VTlLntuNYVn4uthuSYDpFAJpqvGLp80Nd+b?=
 =?us-ascii?Q?ddglm5+Mao0TtcGxfgglivlG1H1JQnHfwNjvbsCxHupIL1aUu1Ku6ZPNIo2J?=
 =?us-ascii?Q?cLN9WVLvddhnY48bxkjbufV2fzjaMi9ew2Gau9InPC6pD62zlldZNhUs4cc0?=
 =?us-ascii?Q?wYfqklzPmWkKwOGmXIVIFQtT0ZXEYyApEFDHGRQXEPviItqoiqvSkFVnu3SE?=
 =?us-ascii?Q?hNHJm9+qz2iQFhzEWmErLfJpu2RXbiKiUVu5DZfCvDRpXSsEz0OgmcjOWgis?=
 =?us-ascii?Q?iTuWJbQGKkr1slE35iXMkXFEKaYafeT35TDIA2SZF6Gl2XVz8a0P4gc0aeIy?=
 =?us-ascii?Q?CXvaP879ESnocjP2AgztN7Nv4qB/i3y/QHT0wx2YOFLbLvIovNOhgiv8Z7SF?=
 =?us-ascii?Q?2AWfXCY2g0qQb5GQxCZvtujjk1VbWgAA/cqt6/gD/WOPZtekqpZDIGE7342A?=
 =?us-ascii?Q?iilwx3KOmAcaRZyplTyV5fYD4//xb+ehJYVlJYPffmi8DjzAahLsH6bCHx6Q?=
 =?us-ascii?Q?oLmgK2NwmaO8Zy/XV3CLsgXkspvFsX5erjO7GTDxvuK8u4duM6m/nxmdm0nO?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa36f1b-80af-4fcd-e349-08da9cb118da
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:42:46.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6SZ+BsxltLxEIwXbmENJ0CZCokeH4fbZDQ7jEOGY368RDvfn+L+L0cxJHTZ8Frrz/I5K/3QTjMTeIKM2RmTzLDkNkoBY76HiCEO2267bxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220104
X-Proofpoint-GUID: 8ezqDllgYqfP0qGJunrBOFnePlb_e7Av
X-Proofpoint-ORIG-GUID: 8ezqDllgYqfP0qGJunrBOFnePlb_e7Av
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the last caller of delete_from_page_cache() by converting the
code to its folio equivalent.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    | 14 +++++++-------
 include/linux/pagemap.h |  1 -
 mm/folio-compat.c       |  5 -----
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 5a4b136c6c36..4201bad56542 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -364,11 +364,11 @@ static int hugetlbfs_write_end(struct file *file, struct address_space *mapping,
 	return -EINVAL;
 }
 
-static void hugetlb_delete_from_page_cache(struct page *page)
+static void hugetlb_delete_from_page_cache(struct folio *folio)
 {
-	ClearPageDirty(page);
-	ClearPageUptodate(page);
-	delete_from_page_cache(page);
+	folio_clear_dirty(folio);
+	folio_clear_uptodate(folio);
+	filemap_remove_folio(folio);
 }
 
 /*
@@ -574,8 +574,8 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 	 * map could fail.  Correspondingly, the subpool and global
 	 * reserve usage count can need to be adjusted.
 	 */
-	VM_BUG_ON(HPageRestoreReserve(&folio->page));
-	hugetlb_delete_from_page_cache(&folio->page);
+	VM_BUG_ON_FOLIO(folio_test_hugetlb_restore_reserve(folio), folio);
+	hugetlb_delete_from_page_cache(folio);
 	ret = true;
 	if (!truncate_op) {
 		if (unlikely(hugetlb_unreserve_pages(inode, index,
@@ -1122,7 +1122,7 @@ static int hugetlbfs_error_remove_page(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	pgoff_t index = page->index;
 
-	hugetlb_delete_from_page_cache(page);
+	hugetlb_delete_from_page_cache(page_folio(page));
 	if (unlikely(hugetlb_unreserve_pages(inode, index, index + 1, 1)))
 		hugetlb_fix_reserve_counts(inode);
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0178b2040ea3..4611156ccfe9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1106,7 +1106,6 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		pgoff_t index, gfp_t gfp);
 void filemap_remove_folio(struct folio *folio);
-void delete_from_page_cache(struct page *page);
 void __filemap_remove_folio(struct folio *folio, void *shadow);
 void replace_page_cache_page(struct page *old, struct page *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 458618c7302c..e04a61905d4d 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -118,11 +118,6 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
 }
 EXPORT_SYMBOL(grab_cache_page_write_begin);
 
-void delete_from_page_cache(struct page *page)
-{
-	return filemap_remove_folio(page_folio(page));
-}
-
 int try_to_release_page(struct page *page, gfp_t gfp)
 {
 	return filemap_release_folio(page_folio(page), gfp);
-- 
2.31.1

