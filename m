Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34D6154FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiKAWbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiKAWbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:31:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE240DFB7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:31:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1M4RI1022369;
        Tue, 1 Nov 2022 22:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=0y7U4m1rgtY/XjIHSb406R686+vacpNNe3hnGCIrPrQ=;
 b=dX7mUKbW6thO5lLJCYsM4GvK52Lib1DL+WIGWzl9TrqGm0I9RQFLcj8B8fHm8WIGxY12
 mq4FW4uffUjc1kb+MuHeZrxaH3yaSI+fofQLuVSaOOGyA5Rpa/Ok8wXCbfoE8c87eF3O
 03LB7yG/HakuZAClYBZEe+O5LcY2TLWLWPmd0+77cUayqIxk7ra0o8wOvRol9YVUA7wU
 YvvC2YZ8nT5sq8wnf7Wer5czmVYPIBgeI5Eqh+UWJ7ufduMelvEBn9W0tL7X6OTSx/T1
 NceMD12IAT377Qd13LWMRJKld/PEJVcGx/9qfR5XzVndglZrO2vTbrTdoUJo4Iicj7RF 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts185c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:31:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KS202014193;
        Tue, 1 Nov 2022 22:31:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmay6k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 22:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXnswm1HAn68UIehYYBWBiuxggCp6zfTcAnziNpas282yVlddUYDEEKn/N2H+ga5ZXURbMJ52lxQA25K/C0wGlm8YopBcxZL02tuzk9yfFhG9YCMJSGyk/YsFE1NXBIEQ8bPLxFu2lFa4CI6HuZ6SqoDMz+NoIPYpUOrW+SRVmbfod+ohcGapRb27DADk7mvIwvAcU8SqU37Tfo5vDYaSzOHAGUk/HA5cqsTHElh2tRg76B46hhnfgbmoPC1QvyFDeJCLtbgCjOJCFSf02CScQxFIlb7N7JJ4TNMknedWT36xhmNE0qSiocsPzsNLUn6XEj7WEsI3bxu2Iz8aeLeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y7U4m1rgtY/XjIHSb406R686+vacpNNe3hnGCIrPrQ=;
 b=acK1GOgfMZPfGaTm8A4WevypDENSde3WJvyKTIqwNGtkYzs56gBkskFR0kDGvKyVMvmgpch33h21or5bGTjMFxPFR0mdhpWSTPzLe7tl0N1n8Dul78czMftqgK1Y3DVIsWcFKT1rFgid3Gz7ACP33AyxRE74/eBJ9mi1dSzdnYSZC3umhKoZy9U53W/WjISzANMisuzQXnwxS4WF2LcIPCVRvOZSjxVsw/c1/joWNMxd89ejVNQnihg7CM0s/ZKPFiAmPp/8HwsUPkunxQEHkoV8X72yTmXcmdkFC0cVjcfShXkQCspXTq6o/EWL9SQIPYRLkCEPuLKLbG7UGxla9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y7U4m1rgtY/XjIHSb406R686+vacpNNe3hnGCIrPrQ=;
 b=ZigcA0rdMbcJ5l/+5UXoQKvBUPipb+JMM+vgYrISUFxxKnjm2OFtLo1uISxGC8jMovLymIPcl6culz74QpqbjXBCXCupDk6wn3GUoGXs7Ij9OXRddyNlLFJl/U+mfvGOCB90Yq875czBWCYFP4qJoBNGrd34+WyxE2eXCtF0X3A=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 22:31:31 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 22:31:31 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 1/9] mm/hugetlb_cgroup: convert __set_hugetlb_cgroup() to folios
Date:   Tue,  1 Nov 2022 15:30:51 -0700
Message-Id: <20221101223059.460937-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0195.namprd05.prod.outlook.com
 (2603:10b6:a03:330::20) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c06e1c3-2ed4-40b3-07df-08dabc58d31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3eDUFZtxqU2e8W3zC7XuW9flI3m7JMMpUb2exux2+2PGy+o4kazCIIzUSt+r8Fiux8KbDn3J0TkpkQHLbYrEcFx/NpKl+kRiU0yoL5xyH3YwL9w8QYQ1slxx879LaYpqyw39MXGj0iFb306huSXmopMDTnKAeGnVgLVAEM+wrzPg7NAAA5kWnVnL/AoFV2OPnIodNa7qDuFtFrBdXSyTQ8kFTiZtjfDsEdlYZmzn0xo/K9J8schA/sy4eLbk5nQjzPi2aGnAc/TYdluhGnMlf42wH4Q2WY5uEtu4JD5fu4K6Aw90vTRMPXSdRZ2X0yKlYGJjZD2H5C1E1ycPKUrigiJTbG31GF7nUb7O77eqCAKgpHzXCirrax9fYXl1iz4RsLrzw0zvsTmiZbRaBgiZrwFRj1G1jb3Ad1nLWCI3XwpXAS2zIa8rdPmMPu9pZI6VcMf8KZ7mTEVeV+SCZWaNkYmazpiqoITSxq/UA+Xq5Az3txYOA1qr3CAElGvgK9tJL8VySwKDYAK5UHOVxoaiOCF4NDXn+zz3937mkIDl/jlZh1asYO5SkhRWGAGK/CiDiki8wHXAtRsJFRTxVYS9GWFRHHeJM7T5v6jkIKkpF+Rgiz46YWwFkygYxnuhg1sqdwLwe3JC6cUHFZtsMdUUu6QT77C/GjoSqIZK2C8lEV3xH6wIAMM0TH7rVwhRmpVqBMih1BzMJZIMcjqWLczzVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(36756003)(86362001)(38100700002)(83380400001)(2906002)(5660300002)(44832011)(107886003)(2616005)(186003)(1076003)(6666004)(6506007)(26005)(6512007)(316002)(478600001)(4326008)(66556008)(66946007)(8676002)(66476007)(41300700001)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IP/PHilhxeLZYLbw4UsjUl9JGT8dQFQvJgAvLwOxhILe5rL8mhz7Nm3p+fyU?=
 =?us-ascii?Q?qN9QubYkUkc5b8pVhPmS7dUS7XGMclMhcCGDZaZ0zJllYT3eO8tmEOOGCSWR?=
 =?us-ascii?Q?3LU27hQiDmaS8LnUjOQW3ceRf9CIGFhjpjaSbkugjGLneKQJAz4ZTxOHnx4q?=
 =?us-ascii?Q?Gcgy3Qe2/e9nHkWekbyuX1AODqgqREb2tabOQs408/pAu55W7esg+DV2IAJw?=
 =?us-ascii?Q?1+XVdcEvWcHmSRMCez7Oc9kNQMRMA0EitU4nSkckVuxX5Qq0mG7VgR6ajwkN?=
 =?us-ascii?Q?29fSSXcisZzgZpUBBd0abe9HlPiPeL9y90848NOtVTW3rpLC1lLFIxz7BPOF?=
 =?us-ascii?Q?rVuFQLNP4HSxVMU7W2MRbdH7jmfVPYxeO2MRkl5ej4lyFFlXsBbcdiv2L93q?=
 =?us-ascii?Q?8e/qTIHhIiNLKV7/5sAL6wzccK1bQ5Dj+3Uoul3F6rH7bo2FITF23orgACoS?=
 =?us-ascii?Q?9BU7EiEkzhF2FY04ShPV9YbjY7byh+hisirEZbOhV25/7a1d3yYG/UbRqPGB?=
 =?us-ascii?Q?E4Rq9aei3nLd/vvuXTv5Ifh0/TTkM515dAssA7sya8lh21Lml8j7GhU16Dln?=
 =?us-ascii?Q?pWrry/WskpdM7ndKoBUuywqVxNYDIc66vWtSS8P8IPLs9AcVc1oe2rC3jGgK?=
 =?us-ascii?Q?n2vfDWa3jxzwsGqwLLYOJ0hdpLvqDTvPkYVZvrMdT/BfN6Oz5pBkT8WDjVOP?=
 =?us-ascii?Q?cpi81ISjxiPVF4LsVXk+QjaG7m41ISRuYfJDmv1lO9ssrNK5WKJp3DppqlX5?=
 =?us-ascii?Q?cZUomoum1dastdjZIJK6ARxhqdGDF+48wky5708eHCXnD12mfZ94iDYBL8rU?=
 =?us-ascii?Q?0EeDuuPMYNoWrusu63IvJOzEpEQIzXY6xvnxSLX7tljo8TVlwnvRt5JOdGKV?=
 =?us-ascii?Q?l1ChnbQKMohEs+xQNxW40XcjYkyPIPPq/o7+QTPnpDm3t1ZaFW0RqzZRp6PR?=
 =?us-ascii?Q?GmBZryh3UGgiVNWAUlPtDxQ/oUhyK4hMX6yaY16QZiASnTmp2HQ+PUhxbkha?=
 =?us-ascii?Q?/RoE7SKj95sdRsA67SMmWNuVTQTcUrfzS11fdgEYQ+k1Gy02QomVOAxEVDOs?=
 =?us-ascii?Q?l2UpSaVzsPD7N8HU2N42aDJ0Cqc35CuoA+pZRXocaMzebEyijDL4ZwLxgz+a?=
 =?us-ascii?Q?AwxA6wCEPY+unMs97AjDEyeB0uz2b0DOcIxm6q1mDKnBFqzkuX8oSNoLVGA+?=
 =?us-ascii?Q?nDSIoV3551x4p0BAvSdUvb/jRWBlkubXONWbWWqhnvEZPf8mSMCCXxVWmw6G?=
 =?us-ascii?Q?etj25bV00DKloJf6GsL0S915UHndMaoQHTuoNV1nRikndavI5bD2aNJd+Mpf?=
 =?us-ascii?Q?mj/LQqIrLmGVarycKeU1L4uQa6pRNZlTnCh7UsCiQgzzLlaJoxl1kk+hba1V?=
 =?us-ascii?Q?wWc/fRHP+kPkbJPPArPLozrr6PPW6Ly4vRwwitbTMEHoTzyTzcDDCbxW4gcr?=
 =?us-ascii?Q?HkLWt92qSLkeP6u6D3TnXU6EUJpmqcJwqyZNK+tEXd+kbmKCAu2lpheRXgeV?=
 =?us-ascii?Q?OWrKeoainKT3xuzmRifDSlAoZNWeCtdzdMUCns2k6Jm3grO6RUhBMB+2dEEb?=
 =?us-ascii?Q?T7p6kmjoZzuEn8rrjFjxob6VXIdg5bLcWJpHWNlYVfuB6a09L85OFhb9onWv?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c06e1c3-2ed4-40b3-07df-08dabc58d31e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 22:31:31.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tjcug+k4Jut4EsNRYFKxBzte4YWyUJeBQHCZUJAO5U0bLsci79aehNVojpp38RKR+/y4K2E2mWCFDfxdop7A5/YTB9Y6d7BOaBVuVqerk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010153
X-Proofpoint-GUID: YTOsMfqqGSGZ3dvVGy2Sd7nTZy5YGTus
X-Proofpoint-ORIG-GUID: YTOsMfqqGSGZ3dvVGy2Sd7nTZy5YGTus
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change __set_hugetlb_cgroup() to use folios so it is explicit that the
function operates on a head page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb_cgroup.h | 14 +++++++-------
 mm/hugetlb_cgroup.c            |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 630cd255d0cf..7576e9ed8afe 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -90,31 +90,31 @@ hugetlb_cgroup_from_page_rsvd(struct page *page)
 	return __hugetlb_cgroup_from_page(page, true);
 }
 
-static inline void __set_hugetlb_cgroup(struct page *page,
+static inline void __set_hugetlb_cgroup(struct folio *folio,
 				       struct hugetlb_cgroup *h_cg, bool rsvd)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 
-	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
+	if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
 		return;
 	if (rsvd)
-		set_page_private(page + SUBPAGE_INDEX_CGROUP_RSVD,
+		set_page_private(folio_page(folio, SUBPAGE_INDEX_CGROUP_RSVD),
 				 (unsigned long)h_cg);
 	else
-		set_page_private(page + SUBPAGE_INDEX_CGROUP,
+		set_page_private(folio_page(folio, SUBPAGE_INDEX_CGROUP),
 				 (unsigned long)h_cg);
 }
 
 static inline void set_hugetlb_cgroup(struct page *page,
 				     struct hugetlb_cgroup *h_cg)
 {
-	__set_hugetlb_cgroup(page, h_cg, false);
+	__set_hugetlb_cgroup(page_folio(page), h_cg, false);
 }
 
 static inline void set_hugetlb_cgroup_rsvd(struct page *page,
 					  struct hugetlb_cgroup *h_cg)
 {
-	__set_hugetlb_cgroup(page, h_cg, true);
+	__set_hugetlb_cgroup(page_folio(page), h_cg, true);
 }
 
 static inline bool hugetlb_cgroup_disabled(void)
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index c86691c431fd..81675f8f44e9 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -317,7 +317,7 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
 
-	__set_hugetlb_cgroup(page, h_cg, rsvd);
+	__set_hugetlb_cgroup(page_folio(page), h_cg, rsvd);
 	if (!rsvd) {
 		unsigned long usage =
 			h_cg->nodeinfo[page_to_nid(page)]->usage[idx];
@@ -359,7 +359,7 @@ static void __hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
 	h_cg = __hugetlb_cgroup_from_page(page, rsvd);
 	if (unlikely(!h_cg))
 		return;
-	__set_hugetlb_cgroup(page, NULL, rsvd);
+	__set_hugetlb_cgroup(page_folio(page), NULL, rsvd);
 
 	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
 								   rsvd),
-- 
2.31.1

