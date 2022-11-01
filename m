Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E19615506
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiKAWdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiKAWcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:32:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80BB1D644
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:32:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M4IQ7022294;
        Tue, 1 Nov 2022 22:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=oMoaqEGsyjXMIw0FpWQmzwCjhrFnxArtk8XMtNUcCPg=;
 b=MO+PJM/2T3ULc9/NlMiM94gKM96/yPQYSwpW2RfsVWQ86thYE21Nx+MqTbZefzFN9O9R
 NKl7srUp5sbjLPAvSC48TJSQoCSLfGQBVS9p+cTZd+GkENjbGwnZPw8UpNn+Krmwdg8D
 2ld7zsSquTYJDZ6LucMedboOcXpuGAlAqLFdVkay22+MrlFZjqg7SAdFvUyAs3Kv819J
 yVpAYRTzSnX023OXnWk99K3o7PeXGTdmToOO6RVIkkibp5j/x6uhPZOb940l1KBR/FcL
 Um3qg/bjeu4iVCNI/Jp0dMT06D4DAM4qFDEb0rGiqYd6hIVTwmrLX8/b43sEJEIfZHqw Ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts185ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KUFO0014174;
        Tue, 1 Nov 2022 22:32:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmay744-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+qEyADnYwA5LCaIMHJXv6vTY67doYyR8GiiRDXFO2aaHnV0xCIG/EKEf2a0J3ZvEpA/QIuxTKk7u7ThGYEuvN9nATJqwsG97TvzjPOMoeJWbZZl0ZSBFQG6yQVRGT3FoXTAlxJ2x3WKb9qAT0KA3djZwnndzK5JM4X4vlGeYpJuIFnyQf3eoxbhSf45VQTgXuIMT8lYQvPzZ7ROFo0FU1XGRfYZvNC3OWHXG7TUSzNcPHG5KYjiCqAhwJ8x5u43P91vfXPFDVUqdUI2Ai5aE43o8LIlXAm52LhG8w3ETQs52mO08QrD+5XcsmolUkTcckNUmSwC7GLi79TK+KOUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMoaqEGsyjXMIw0FpWQmzwCjhrFnxArtk8XMtNUcCPg=;
 b=NTg0S0iYLZpI5XpnWKttjDLNDD5c2QZ9v5ddJDiY2Fu9OmJV+ZbjTtCH1zF06DCSaNTqG9uGOpV/XYqr9v74V6HV4nLeuFb13bp2Zz+PiAbjuprTgdpk6uh+1C6qpztnqZc+yCSJ+07AvwRtJ+1Ma0ryWGvpvXX2jjWG7TF12h0c6YOBlXKVn5/mqiNnTFSW8zZy3V37xxfPG3DtB/ZYtUgvcAOHH0vZrTo3cZ/SHZrUN4/WrqQ9KcoHFp4mFSr49xITq1yz0WeA39uIDJkuWbe1Xc1vbxJHlSkuavXeWKGo8MRgdkjcF8cnIDI/kGBEd6c2hRkjYYUsZ98kxPW3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMoaqEGsyjXMIw0FpWQmzwCjhrFnxArtk8XMtNUcCPg=;
 b=Q9TWcM4OhzCGn7n7bSbOuEZgPwZsptfzPVKxH9S0tSpAbiQUizuCONKpyDcnYEygN9suxZXwsTcXzbyALpf+39oaKDS8WojSvhbC2HIx50O4ArNVBv+s0DNvSLeV6ipFj0C8LwkebdGuV+RDwW++chlfN5f5o+7/XkbSVkQTXHA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 22:32:32 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 22:32:32 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 7/9] mm/hugetlb_cgroup: convert hugetlb_cgroup_uncharge_page() to folios
Date:   Tue,  1 Nov 2022 15:30:57 -0700
Message-Id: <20221101223059.460937-8-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: af68a9a9-7d8d-4190-0850-08dabc58f7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeQ9jYxa8G9aYaiJV+4T0JLSuoSdXI6L4+Higx1LB4pIhaDJL+F/6fwfxrXtPVg5wbHOlvm5KhWg+KEPz3uynzrr9mSQ9GpoEAsJ1fhnbHxcFzULY/DVjiQ7T2d2xApuLLYulk388Mn7XvPQJCTArTrawTGUgoL4rdP10c9JChPqmIbWhoi5gCKWFEh9m8yBtfFsYALVrod/ybqLHrx/3d9HXKCw83tscIK6AvH+bibP2Pk6AyMxWSADv/05zv3ioL+rWTv/i8J4cb1yld1dUdz+S/pOqGnDISLd+obsqBoWe9dkAvC9OqJvh/FwMGFQpZ3rx3l5qhB6oXn7g2DEtGCnwTUgMMa0/CixyMDud8xHRc7wBrTRBSTmR7gtM5p3J88Bd1RZYj+f4rrZzARwtzflcDMIAkp5TTjEv22qKuJztfIA6WKUpTaoFT/jcJUI3ES0vs4JwxezffLTV2vN4pa6gk53erZHZBisj1Cb6cUzpiq8xLMkX7JxHLFIrQIutxcMvyZXdpOUQOxt3ZIt0mDU8ZXZzLjXwPj8rU8BtCTtWjn/FRIsbNfJkAhI1jmAHt8es6X91Cps3GoiwYgKgO43KkYqXjLO7YkuW5z6aQj6QmiIAcdyVihtl2firdzzm2Ul+bMIV8buYR3PcahDLMJ9oAKpNC3ivtozLKNQR7SrIc8g7CKBz+iwa5gisDQOjtOy9Pr+jzsXu6k4jBXEOhBEQTBuKSURiGF0FlIkCtuN72WRmbWhaoq+bu7aeFE/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(38100700002)(36756003)(44832011)(6506007)(66476007)(107886003)(6666004)(2906002)(4326008)(316002)(66556008)(8676002)(6486002)(41300700001)(8936002)(66946007)(5660300002)(86362001)(83380400001)(186003)(1076003)(26005)(478600001)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZCCmPcY7r6gGpMgB27Sbn97EIy4d0IZxzsZApIXXczPA9jwv+6Tqdny0cFI?=
 =?us-ascii?Q?k8T9kGwQkreG4Lp6q51QzGB/eo93IpKA5sHZN27Lsi28AZRrcmGHYUH3K2i5?=
 =?us-ascii?Q?JcQwYa3QHpj2ez7PMyomJVC3xHJUu8nUUbhE4+3M3Bqw8Yih1Pkr1ZNlsqiB?=
 =?us-ascii?Q?efKekJIzLHyVaUihlcATc922X2TBCBG2SQG6ntyclaMcQnDs1fF2lg4TiYYv?=
 =?us-ascii?Q?FWfZmRYwzUiU2v1Nx+m2tECUkU7MjNCa0IeVDuxAMh5KopDnHLIYg3l7Djf3?=
 =?us-ascii?Q?IhnE7Q7zquGLfi3LeaKRzbZTy3qhYxzO9K/20n/nOHHAqyAY2/609DmRkn26?=
 =?us-ascii?Q?kjDnVC0FrAPOna3CoTMzKXBW9jkE+nndgBPjw1E/CQcTWd8GyyVNailZ+hp3?=
 =?us-ascii?Q?kp85huTZ4ckF2/1XPbsJWfQ3FQpzXbk6Oafdnb0Ml38uj9OXxV2xu9B5nH87?=
 =?us-ascii?Q?Ds2ZT2YTcp51UU3CNIRrkZ46B54RPL0BawJQKJ00UjdVcdA6Nrlj1ffOzTpx?=
 =?us-ascii?Q?APeKOGX423/uKi7nDY2aZsctpBvesLo7jXV8ztIJWW9YVQEDSVSyviiOCK82?=
 =?us-ascii?Q?6JfC+HYtw5ALX1CzqeiAsGkuzfRVz8v0gqKsVxoxm5hJBHDA4hWO2NIqH8wn?=
 =?us-ascii?Q?PixKg3nunGS4p0Yc5DU30QVY5BfjJqPwy0jAJGgc7cEMHXupioQXBwGU/vMY?=
 =?us-ascii?Q?rTwrk4hI4VzfCPnF3IVy0YlPPegP7WN2nUfOcLEkCVDGLNbZohJphDHiTkg+?=
 =?us-ascii?Q?/EfXG3r25DrI28kAG2RIeuHhcd+XqdlMitt2xOOzQXBzxlO/ElMA2hNgZaIH?=
 =?us-ascii?Q?2gxuANaqXLMD8lm0dcG/fnZW4GC9X5WIoQWFeuChtjyV5RCxCIDuykRYmQuh?=
 =?us-ascii?Q?ctqx5znaPSuVRkAiFHMnCMnr3MskApo+xFgEz5ZvUZx3gMxu3ZqGRiDQTrRJ?=
 =?us-ascii?Q?LTKh2FtM7v0AC1QkMc+8Wzw7sqnvh0eQQHbGEYqnB4/YnaVatnLg1BMp3QMb?=
 =?us-ascii?Q?ip1gRiQmOocwLG5KeAtmOAcgCh2jPYGh4UYO62GZvigsE6NbmIv2zUgptjBg?=
 =?us-ascii?Q?QkXvIsskh5pIFpKrKYhGyf5E2NTqFy/VTvydDAKDo2L8K7NRy8HS+HWiGokp?=
 =?us-ascii?Q?w0kur61BVg7KbNrH3biq0ymyHFCNoNTTZKnTfU6vRm4QexCoWzLhL65SyzuN?=
 =?us-ascii?Q?yLeNlKnv9btvGDsmPO315oPgAhlVeExRBZgZp780oPZjaM0ouXhUq7SvfPiD?=
 =?us-ascii?Q?QUk4GOLyhw9qnzYVvMLIZOtdmwWUm65QdxzIto84tKunG+2KyCLpbjdWGmn7?=
 =?us-ascii?Q?DiEtHil2V+YSLLR8MsaAobUDtkSZH2ITLB4oRmeM4YbnpZKkeegkK3mOpOLu?=
 =?us-ascii?Q?aAAbP5QDq58LhSeRW5hRqwKIUufkofwY/46AKGAqrvtw58BDdoh/gOdy1tOs?=
 =?us-ascii?Q?D3g8Efae7CkOazEZBFA8Q851a1Ed9S5uLEHCdKOjEB/DXKEvvJKq7PicUlls?=
 =?us-ascii?Q?q+fjpTmvm2lHkKg3zrUIpNKMY5SB3A9WYNJnvzCMgD3NongY1CIH0eu1VtGr?=
 =?us-ascii?Q?Nho0BF8AMX4h5CUbpygAZVIl9lbttlXqlXUgg4q7z98MTS4Me1+/vstS/sNM?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af68a9a9-7d8d-4190-0850-08dabc58f7a3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:32:32.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlwY7KQL6VHI8eakBGdeeQ0j2aKEIkdm9FUGoc4XzGUejF4Q5r/MdiDHzyUe+c0b60f0yN2tz3PB8gZVIsVYeFzYs3D0YxA8cwvPe2ZPBOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010153
X-Proofpoint-GUID: 7nS8A8G9AwEmyi43NEDUG9Q1-R_Ptfwl
X-Proofpoint-ORIG-GUID: 7nS8A8G9AwEmyi43NEDUG9Q1-R_Ptfwl
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
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
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
index 387b8d74107d..2ecc0a6cf883 100644
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

