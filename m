Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71225E6763
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiIVPnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiIVPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:43:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806BF3728
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:42:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MDr6cM019797;
        Thu, 22 Sep 2022 15:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=vs3uGcyuJwjH1tT4Y3xaeZVkuQRVxLri+x4TZ+Lsu7g=;
 b=vFSK5Ii/OWFTy1aIv2fBs1cjLAzItaj4edy6afB/EQv7dO05kk2Sm+BArFN9Rz2GoyUl
 35DQK957fp621KmpkAVfovNCfnFq4RtzRVQOdKIjjHsdZwHeeoDMOql7PAzAOV99EYku
 UrzHZndCkeplXNAavPp3zh0b8zCXlRPe2z8aiN0ObYsnHmudvj0nsXcNcOnswQukaUNr
 MbmN3d6j4TPTq2opXmaE1tHAe79D2hHWtBrVw1ZzWia/Kvm+tH0+y7dm4yufit4LvLR6
 kh7gfOPAY2BMi9eaZpfoTMy+AmAlfcMmJh5AmXUhWsZompztSk2Iw/QcejdbT7FxEiEW 2Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn688nbxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:42:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28ME743D028880;
        Thu, 22 Sep 2022 15:42:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d4rfgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:42:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvhNo925XcODcpdKAjUpmkyf1mnL+CYaeahXc4gKOCHl+2e5NPHBoW1b6mgsELSyOz/UUmpMoy4uUAM1cNK3xKqLrpv4N2gsVF9Zvm1x567MQMtNq+oxhbNjklT17Uu0t+AABlpW/IaEsRH9+peQwXfofDKwlCUVK67CsnsQUVn65rNUF17i3V5h1XU2GZCSoCUOasq2fW/90v/o8NDOAOGliiIBPt48UZnjDggDGSUMD0kCOihddtKQmRVEmBNfepLMBeD03b+sx6B4yoEY0AbtungQjnOU288DjBSRwwnhBWk+S3Wmw7nHXlju2X1r2/sbFfpmL00hb1vbS7uChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs3uGcyuJwjH1tT4Y3xaeZVkuQRVxLri+x4TZ+Lsu7g=;
 b=UW+izZ56SG3Vwg6lILCnShAGu64mOslo5hFaZeLJ5HDvoHk0VpoWsiyleKU12pAB4LP/eRpNvBetlpSDz2zsQrI44nOrMkrd+qWgOrEbkXVoPZQJ2UPFR067PLEfTw0Gu4Nri8a2oJttm3VLOsjA2w/VabGscjT8Fy4YqFqLAi3LaTfEdaQYipxDar/R44hFNH/i/v87UZMf2iHL2iuD7+kajnWDVsoBDG5xaJM0R/Qx5z8nJuL5Ba4VH3K9YljpyWpTtnNV5BD7M6PbfWb9IRx0WOHi/lsUzriKDbAC6UQkYGR5QpZPqxwk3tNN66ahgdGk774pljOhkZRDesTlxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs3uGcyuJwjH1tT4Y3xaeZVkuQRVxLri+x4TZ+Lsu7g=;
 b=eMKlyTfeHPc9+loGYwCFBj00FsuB8MkeqQmTHNljdWiHX5vV56jEGrUjU0Ib2ZkgDCAedKQvZYqBi6Z0sDj8sGAZvjlu/b8oSDDFwli8dR+9vt1ro576WYglLsG+hOjqushhDevVF+33oNUTJdUBmfon3FYAZypogQOASxM+X1o=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 15:42:36 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 15:42:36 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 1/5] mm/hugetlb: add folio support to hugetlb specific flag macros
Date:   Thu, 22 Sep 2022 10:42:03 -0500
Message-Id: <20220922154207.1575343-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
References: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:610:b2::35) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: b64c7c5d-7663-4c47-51e8-08da9cb112e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SiMXZvHPpbqKUwa3ifWfXcxNbJhBqM48VMuv0vs51jtzqSnJq48UwNsMtQdkbMYIBr5MYYF9YJz52Oqgj0aZmkQAm+cR24jfYomeiJxggrmItv3IVKcqxWP3GG5itA7PtsEQviqpJjd0S/MGgH9BHyaCNfFzTBGkib1p+Q0k/rIKG6DMdBPM/3UYqo8iM+73pVHiG7kbDZGi1qIXqdlx0S9Lv6ml1psXnjCjxKsmFE3O9xgxmhAQkBBkxNkBNk15zVNw1xfQhfILPAj7sxdZMgQyD4jHl5GHHWoMhedUuFCSD5/ycXApXouUqxgtTBCSemHbkpjbX2USPEXdWlRP5bz00bMiWJt3OFAAgnI65judCdTHxfKre0+SLMRbBEF7zHYC99CZvCxzy74MEluNAJQKEi+tXB/pyZiNG+nMyleffnDanlChSy4wK+Y5SIa0CpnUwgbxf1vW8juRCLf0au3P8ZUbp297u0+SyD57X0qNvy9pOpVpxJ7QMLHj4GCgBRbZmsu6O3ToP2bgGkZGwM8bXuUF6Ht3p96kolrjMqRMskZtrPlDrANFdBgZyFZTwmlOAAie43Qe5ctoXycmuAgGEUFErZXgVlL1MzEM0baPuKdbJgN31KX/nMeoMNUl6Hkede6uht1HRjkT7AbBrq8vgd+b2RnxZsdOcUP9SXGdHyl3U5lswvWq3K6Ksdxfsxt1diVrOPNPEAGgKN+9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(2616005)(1076003)(6486002)(83380400001)(6666004)(44832011)(7416002)(41300700001)(26005)(6512007)(5660300002)(2906002)(107886003)(86362001)(316002)(36756003)(6506007)(4326008)(186003)(478600001)(66946007)(66556008)(66476007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DeT6zJ16HaptPua8snaLemGHm0HZ2sukKjeyeGRE/zpk1znLfMMMPh7Ma9KL?=
 =?us-ascii?Q?cUqmPaEi189bNR/s25ygD+TsmDDDl82TuoZxhTAjnMlDKIaQJlNpm0RIX+PG?=
 =?us-ascii?Q?XVz7FeYyKWqY4BWbVI0Y1ZcnyQN5BJhKIhTQuLs2KJ7f4zf+O77FZ7SFp45S?=
 =?us-ascii?Q?df9I2kBnDN6QIM6DMa45PBBncwCcHgHSpSx41N91gF1moI3HHj/lzVzqWz+i?=
 =?us-ascii?Q?rSuZPtdeocu6QZKdn2Kt87qgjFDWIP36UpscnE3lO9wgfq3EV+DzjWRmu1iS?=
 =?us-ascii?Q?0OgM9nfdmi2VLPvnoVqgEBhlMU1KY/qlM/uVbiVebENsfRNMmrN29ZLE6IDk?=
 =?us-ascii?Q?hk7WbUilpOzyVvBI6hVCtegktK1dgNGP/1qbjBAfySeGNsmnQGX6Fx21oifb?=
 =?us-ascii?Q?G/d6iDQKsrWNPkRQ12MCfw60eTjj9pytowN+iY7Y/pLbKX9ZDD9GbbH8rVDh?=
 =?us-ascii?Q?Ujk2ejtztTYktXaVGOzr0lQbjzxSPtXSE8CVktLovTeScJ2a84UN8a30+Cmd?=
 =?us-ascii?Q?E5jrnvgXpHwW7gfVQMVgBE7e+zn/LxRfPHKHK8O85n/+DOocVoIWbHB5nUgR?=
 =?us-ascii?Q?9U/bpZP71VJsjoSiXcgiK8HuQObI3DCHFmDFqyT4NjZ6qwxVBVhi12m20H4G?=
 =?us-ascii?Q?/PgJD9Xsaq/O5LLi6qco31ThYs3O7SOeqQv73tTqMTPPqKRVHK8JwJU5dfR4?=
 =?us-ascii?Q?BYeUEZZvW3/AGFk/qYlPjWp3JuOIVieOCbQY+XdVO/cs3M2/6BCzzsfiU7Pl?=
 =?us-ascii?Q?YfA0BJ62JKYiFuRFUt3sp7LwWZh1NqjV7JjORQfS6l1Cxc6PHWQiqWhJ3DUy?=
 =?us-ascii?Q?KrFNBy9SiNPoL3/1khjl91EPOpkNtmqCQCPF7q7B04GS1/DWIXX1zXTzz70w?=
 =?us-ascii?Q?YslM47x7xF0QU3jRpcrovsnaef+OJkwy6T7Rt66z1q6mmvFnZG7j7ClxauHl?=
 =?us-ascii?Q?tdwwYG5W2hCcIZtow2vT6M6hwSH1y3NB0wPhXP6U24bFr7JdqhXCFPGyCVHJ?=
 =?us-ascii?Q?WGOYF3RZfJVVoPZRuDTrPfjEqeTaCHYHx/JrggT3YhlGLF+akZEbtcmLYRzK?=
 =?us-ascii?Q?mN/16RwaiBDNYIGqez/dOywb+BllLWEY234NrCK328eO7pXQ70QQmiQ9DBAl?=
 =?us-ascii?Q?7GqkJrBfQahEqZaPcJor2F7xbcE/0xS8Sq9D45jFx/OVbYW9oTrLZI+W7Kom?=
 =?us-ascii?Q?SCxkRXoxI3p3ETZxd86dHVTYS3aOaATm88DmRFir9neuDRiIFpZJn4PfJGvH?=
 =?us-ascii?Q?ggta/m1MfV4kmcIOCeHu2eIqtf0p0FWAMQ/Sqd1foYkkLGXEkayrTzPlSxEg?=
 =?us-ascii?Q?lpgWBSO3wR4QcarGHyJCwfBI+fu7e/A+FBAT3EKIzNFhfzWQOIVdImtQdwZT?=
 =?us-ascii?Q?0w7SRQNDQaoHo2L6IjdEenm03oN11HPd9Fd6JS9hphc2n0y3wQYy9nhsd0Nz?=
 =?us-ascii?Q?v4KlGdq3bL5WJww4Pfj1PnoJIM4FdjqvM8HYEO+ZVgdH6/9tXYE/LkBjspmE?=
 =?us-ascii?Q?ypRSaxAUZ6lyJjbVTFyZHMP6DIjY9QRhloj5UOF8hwMs78i825Uy8elq+jBB?=
 =?us-ascii?Q?zCj+Eaz9tnHyvx2g+XdFOmuTNruj/qOgnEgWLHrsKvDpXq8Fghd2JNa6XcsV?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64c7c5d-7663-4c47-51e8-08da9cb112e9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:42:36.8792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Acn8NrjIhPPK16Jt9GhL3e1lg6ZrkLoNTSm0o6JKa0QhgfYRQcPcDcEmpEOdUyGjbcLF9b/demTrrdT281YkL3LWHkEBEPBK1ffiMDUWJlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220104
X-Proofpoint-GUID: cF1Sp1jIf5mE3HS_2TWTLYwLv5AR-pDo
X-Proofpoint-ORIG-GUID: cF1Sp1jIf5mE3HS_2TWTLYwLv5AR-pDo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows the macros which test, set, and clear hugetlb specific page
flags to take a hugetlb folio as an input. The marcros are generated as
folio_{test, set, clear}_hugetlb_{restore_reserve, migratable,
temporary, freed, vmemmap_optimized, raw_hwp_unreliable}.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cfe15b32e2d4..8edcdb6a833f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -623,26 +623,50 @@ enum hugetlb_page_flags {
  */
 #ifdef CONFIG_HUGETLB_PAGE
 #define TESTHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+bool folio_test_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		return test_bit(HPG_##flname, private);		\
+	}							\
 static inline int HPage##uname(struct page *page)		\
 	{ return test_bit(HPG_##flname, &(page->private)); }
 
 #define SETHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+void folio_set_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		set_bit(HPG_##flname, private);			\
+	}							\
 static inline void SetHPage##uname(struct page *page)		\
 	{ set_bit(HPG_##flname, &(page->private)); }
 
 #define CLEARHPAGEFLAG(uname, flname)				\
+static __always_inline						\
+void folio_clear_hugetlb_##flname(struct folio *folio)		\
+	{	void *private = &folio->private;		\
+		clear_bit(HPG_##flname, private);		\
+	}							\
 static inline void ClearHPage##uname(struct page *page)		\
 	{ clear_bit(HPG_##flname, &(page->private)); }
 #else
 #define TESTHPAGEFLAG(uname, flname)				\
+static inline bool						\
+folio_test_hugetlb_##flname(struct folio *folio)		\
+	{ return 0; }						\
 static inline int HPage##uname(struct page *page)		\
 	{ return 0; }
 
 #define SETHPAGEFLAG(uname, flname)				\
+static inline void						\
+folio_set_hugetlb_##flname(struct folio *folio) 		\
+	{ }							\
 static inline void SetHPage##uname(struct page *page)		\
 	{ }
 
 #define CLEARHPAGEFLAG(uname, flname)				\
+static inline void						\
+folio_clear_hugetlb_##flname(struct folio *folio)		\
+	{ }							\
 static inline void ClearHPage##uname(struct page *page)		\
 	{ }
 #endif
-- 
2.31.1

