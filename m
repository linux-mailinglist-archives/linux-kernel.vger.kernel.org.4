Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D176164D666
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 07:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiLOGSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 01:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOGST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 01:18:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA35C0ED
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 22:18:17 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF2OdI0016402;
        Thu, 15 Dec 2022 06:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=AuLO9/EBL3BOjYouIGAyrKOa3dcuBOE7HALsFuDpx+0=;
 b=L1UQyN9Pi37WZKrFqmn3bbYeI01vx8yZ5THPRGltEoL7RiHZwLxiG20C5P4ucOIP+1pQ
 hmhjN2mw88/MqZMAnKZnL2VZI76d/hsp/WyR6LqrKKxdmB2vkFFj5eQE4CClPPo31Qep
 SEMnCEWPNkOEgVheftRt2egaTowp7PbAXkjYhBI+ZwHKbe3IcEjeeOTxzchMU5Mjs+6u
 ed9d7d+rJdQama9J20hz+sl2qQvFVEsXhQXFHrDFU2c/YVReKqVjDcrqjVaHVFdx/hCG
 lvZ6zNzV5Nz+3iD138huBOV+PN1C7w8u447fiVweazqqvNtlYDFwPgJy7/UoHraKTeSZ tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewv5n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 06:18:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BF44XMx039280;
        Thu, 15 Dec 2022 06:18:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyev647v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 06:18:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCAHrq68InHCxRszBGhsrGLNG//Md6XergQx04q9RcgHHJIhBXTMx4j4y7bWhlDtsYvJm0MAZtHbcUGEAVU3O4owbBbBAMgx4ERSF3hJ+qhe+1P+z1lfV/KWupEh2uuxTvBnakAJv3/p0HXjD2W7HX+UzCGdFB90Vi9iNm0FIY7qSrsX3hHjcLX9i8cudftqgfZdDa5wbkmH2Q8WhUHmlVaMXv0HGPm9PTPYYKMNEUJrLQty0CQrr8MEVgqxhRpLeaifwbyFuhNJnMyS8mYNWnRDtHNmD/8rSAQasV/d1ynWwt+JoGdygeXiiGRE9XBjHfKkP2+ytoARTfSPVR6cQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuLO9/EBL3BOjYouIGAyrKOa3dcuBOE7HALsFuDpx+0=;
 b=EEzvSzflwEdagsexkfty3avah1Lnx+xDAMRqwNbTNj5kS7zDEeZcDcGW8nOVxeh9je/uiOjAVgM1zbHHr7SChW8KMqtx36fjYRgEn/bAG8C6nq5F/01kDac9uhNb+RordUIrQY1jNhb1RWDtwZ1Wg+ncPVfwtxitTpFWoBOb34V3PO6wALLuI8CCNxDKY3E/Mradyz2shLBw5pCk1H/YwG5VKXb3QGUB3XozTDva4GKLBzqbYIp1nBb5QIqzDaVpsd7/wCc5NMjzwTlE2DYxPCvV6LnDlY80Iv8iQTEaw1kdVlJ7le2y+s/Xr3IeuT8cfBFXQt9oVXNeWShmJkDLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuLO9/EBL3BOjYouIGAyrKOa3dcuBOE7HALsFuDpx+0=;
 b=aX1HtyNOrp6M+AsBQ11oshgcQSvotocji7KnsZVTV8idWa4j8H6NXrmzhYBrm6/J1X5Y1sBmpk7dLwqvR2piwqKmnoi67jidTrFRkx2ce3FCXUsJafu3DO+Cr2y1q9VE64H7FzKClzS8128QPQyJZ3bO0LqRyNzKhWc42TMEdS8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 06:18:03 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%5]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 06:18:03 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2] mm: move folio_set_compound_order() to mm/internal.h
Date:   Wed, 14 Dec 2022 22:17:57 -0800
Message-Id: <20221215061757.223440-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::20) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BLAPR10MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 843c4b7d-2cfd-47d9-65a1-08dade641f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xd2fmgQALQRmlTGsRUbnrScX4DUMsrHMb4F5RyICOoaiW3/KlGfoWP2wkFyboHejPZLUwUuuAoA4Kfv11gaX5MQkjwiEOGBlyezjuNHHyfVf5Ni3jxcBWJGeF8FEY1VWPuX4Zbiw3h+eT3T2dwut87pdIksAeruh4EJSW8NY5ENPjA+cJEz0j00199uEaGN37dQqN9WsnBmlB3mcikXoWWGjoEOVvaGXZqVZXrNuBWkFBWqv1R54vG9DFKpk9N7jIUTxzvFlst92zVDqHCf+GrAKFQIYiTgmfWvF1zfcZf0yg7Jd1pirkrNa/NfDZCq+1sv/HicNHAE36tv5AH5oLVqufJ6YO8praY1K1gup+tdsmGc5cCbSRvXgHrvNv/F5DF3kZQg/tYGz5NMFxut+Yk5F6Eoa7BqcFokqkZ7ht7aBS9Ioapz7Co2vuVSMU+DnCRegTAJB6KjKPUuysEh+71bNWG8VD3RIlsBkPTwU1JCeOHCcP/VbhAhI4cdrIXqVibRK2aP40rx5nGmYekAUJWYeeNeJlYVxXNnIEPfBluzUshituBlAtuNVoZdgy3zifsGcJLujtMRGcPK+2fW9zERoKa/0S16+e+HdoKv034MKoaw/06K891mG58gl5DNMI3MqoD2ugOTYuwprCg0VyU5JK7zGHN7guc2VOq6CKgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(478600001)(107886003)(6666004)(6486002)(26005)(966005)(186003)(6506007)(6512007)(316002)(1076003)(5660300002)(2906002)(83380400001)(36756003)(66946007)(66476007)(4326008)(8676002)(2616005)(66556008)(86362001)(44832011)(8936002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ftm5Vvy6PN9ta0bUMIaUhUCcW9p9mphkiO2q6zKpYkvwOnZPr/0ERAgkHVLz?=
 =?us-ascii?Q?NzEqoCXxVBJBHgHvdwK8SE6v6vvd88DSRmwXaJGlDQsh9OdQWZDse2kITOZK?=
 =?us-ascii?Q?NMD0+6VWqzLqn2LVzRxaCpbeIb7rbWfXfBauIASRFSOmlepfdP89Avd8Vic+?=
 =?us-ascii?Q?KKGh5yZPZKp1ONBqLpDDmMb2gcOzQNBE4aIVcogPkkkJJrISXGo5aPLZDDYN?=
 =?us-ascii?Q?mK51oxGHhTIrwQ6WETZNpqCI2oeOAXmYbLi9iKL7pCIrJhIkO0AzYyW8vJUh?=
 =?us-ascii?Q?+ufijWtsCcVa3KlW6Od7oBYtpmdN4SuQvUXXh2nSOHqJLy0CBf7HyZyaekm9?=
 =?us-ascii?Q?6+cGM3Gp/Om7Mjt7xDPJCM1ZReO/FXWc39REqBrwu63NB+1IjZN5fj+57B/I?=
 =?us-ascii?Q?lfBWM4XiCtK7URT8hebFcxbvqT1GZTdZkQbVCtt6puk/dRfHSM2ltVNDJi4n?=
 =?us-ascii?Q?Zq1hDi+SpzXzmY+EmvJxNNmiHZeKAY94TTAMgNT02AddWK/W//UgtrxZYxvM?=
 =?us-ascii?Q?IsYaxH6rbHYISCsQ7wyD7vVj7wykuxOX5HPNnr489o81IZEYtH0uFlsB/pqE?=
 =?us-ascii?Q?bUuV93G7ZEVlPSvfIe8W8V5PYoElt3wjf6tL/dbOKkl/D2SqllhA7d1UaCqj?=
 =?us-ascii?Q?07w+Am8E3AtM1gTytEXEcE4cbXtTQvGkLs9+X9NYQq2wiN4U7GanrmYgj53N?=
 =?us-ascii?Q?7kMg6/+4QriXyoHR4gWB5NS8XBQ1zL0VFT00h1oRkMUJAjb2n0PooeWFOiQ2?=
 =?us-ascii?Q?mWc3sIr0NUtMR6HWsVVttdhFm4PVQ+bQYeQouZAAmxiQH0ndTofk0jbgAxKM?=
 =?us-ascii?Q?kCqS5LjUnCgYIbo9iNZeFlk/xHS43+k0HnpU3M/UjUaOvXUjV5xZub4I5cOo?=
 =?us-ascii?Q?F5kPUz/4S8yDUfiXDQB+KQSLQHOYgzrLy9j6Iw/ifRCKY6sp2QIZBhViaImY?=
 =?us-ascii?Q?zZrctZWZ0N1NKq7WHKXsNv0Qa5KEaOsdcbey3c8gqUZ3z7/2Xrn/eJsw9/tE?=
 =?us-ascii?Q?+GAepKpQ2pHr03iZHQSuhlqT4j074SrIykDtkEyksN5r3r/OmnFtk8tkJJ23?=
 =?us-ascii?Q?8Dx/40YOR/k3LqH6L9tk/n7v88Aymxr5ko59/0I33KBQOwUOTUCSa/s9FN/V?=
 =?us-ascii?Q?cTJI0K518+E+2AWH8qdVerbBKW+SEr4sBcQrguhgScDcKol7kpgnvtsd/gnI?=
 =?us-ascii?Q?N09mcB3dWO7TiC3kNTXGqvu2meSTM109U3rHflDI9nU0NhFMVmx+0rAoB/Y1?=
 =?us-ascii?Q?roDt59DOgOkTfYB6WWvFA1V8NdAV2MQWEah6BTZduATKbmw3u+Uc69alx30x?=
 =?us-ascii?Q?9E0+4nzeQEa4e6QSUQmQ1/oyR2+hagYdjbAnItFbH8PvJnSHuoWFnBNRSyKi?=
 =?us-ascii?Q?gaitrt3XlOA64216eYN9u9mftZEFLhsx9WiOZZ/0elO7Kj21LoHcdjCpO3yq?=
 =?us-ascii?Q?5VYoXrcMKBwSfSA/4qv6Z/u7A/Zvux3yq/NaOwwvNVnwQNTT7/yzZtiFk8Zz?=
 =?us-ascii?Q?EaOhxyj+FccIZfTM4JOdifvKYDs9aunZwWYbjAotF+INvIXrf7KR5kpwibev?=
 =?us-ascii?Q?b14Cnxg1rcfllmjcpF+y4w9O2HSXCqb+A7Iz307d6xz4wxph5nhjwZZ885JO?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843c4b7d-2cfd-47d9-65a1-08dade641f33
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 06:18:02.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZW5VFiKgV6VGVUQ6u83Y/sdey+z93QIvRbjqHZUAWXfii8URMoMtxx2i5okqb1tV0ivtlJPiBUaiW8xGVfa9Xo2HtPUmL2Fhdb8bpciRu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_02,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150048
X-Proofpoint-GUID: XOdEpN_qEXdObNhDLpn9VXi0sF1MKPPK
X-Proofpoint-ORIG-GUID: XOdEpN_qEXdObNhDLpn9VXi0sF1MKPPK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

folio_set_compound_order() is moved to an mm-internal location so external
folio users cannot misuse this function. Change the name of the function
to folio_set_order() and use WARN_ON_ONCE() rather than BUG_ON. Also,
handle the case if a non-large folio is passed and add clarifying comments
to the function.

Link: https://lore.kernel.org/lkml/20221207223731.32784-1-sidhartha.kumar@oracle.com/T/
Fixes: 9fd330582b2f ("mm: add folio dtor and order setter functions")

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Suggested-by: Muchun Song <songmuchun@bytedance.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
v1 -> v2:
	- include WARN_ON_ONCE() inside the if statement
	- add r-b

 include/linux/mm.h | 16 ----------------
 mm/hugetlb.c       |  6 +++---
 mm/internal.h      | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7dc376052d40..300d92d2b49d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1019,22 +1019,6 @@ static inline void set_compound_order(struct page *page, unsigned int order)
 #endif
 }
 
-/*
- * folio_set_compound_order is generally passed a non-zero order to
- * initialize a large folio.  However, hugetlb code abuses this by
- * passing in zero when 'dissolving' a large folio.
- */
-static inline void folio_set_compound_order(struct folio *folio,
-		unsigned int order)
-{
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
-
-	folio->_folio_order = order;
-#ifdef CONFIG_64BIT
-	folio->_folio_nr_pages = order ? 1U << order : 0;
-#endif
-}
-
 /* Returns the number of pages in this potentially compound page. */
 static inline unsigned long compound_nr(struct page *page)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7cdbcc22587b..810e840bb4f1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1344,7 +1344,7 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
 			set_page_refcounted(p);
 	}
 
-	folio_set_compound_order(folio, 0);
+	folio_set_order(folio, 0);
 	__folio_clear_head(folio);
 }
 
@@ -1808,7 +1808,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 	__folio_clear_reserved(folio);
 	__folio_set_head(folio);
 	/* we rely on prep_new_hugetlb_folio to set the destructor */
-	folio_set_compound_order(folio, order);
+	folio_set_order(folio, order);
 	for (i = 0; i < nr_pages; i++) {
 		p = folio_page(folio, i);
 
@@ -1872,7 +1872,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
 		p = folio_page(folio, j);
 		__ClearPageReserved(p);
 	}
-	folio_set_compound_order(folio, 0);
+	folio_set_order(folio, 0);
 	__folio_clear_head(folio);
 	return false;
 }
diff --git a/mm/internal.h b/mm/internal.h
index bcf75a8b032d..1d6f4e168510 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -378,6 +378,25 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
 int split_free_page(struct page *free_page,
 			unsigned int order, unsigned long split_pfn_offset);
 
+/*
+ * This will have no effect, other than possibly generating a warning, if the
+ * caller passes in a non-large folio.
+ */
+static inline void folio_set_order(struct folio *folio, unsigned int order)
+{
+	if (WARN_ON_ONCE(!folio_test_large(folio)))
+		return;
+
+	folio->_folio_order = order;
+#ifdef CONFIG_64BIT
+	/*
+	 * When hugetlb dissolves a folio, we need to clear the tail
+	 * page, rather than setting nr_pages to 1.
+	 */
+	folio->_folio_nr_pages = order ? 1U << order : 0;
+#endif
+}
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
-- 
2.38.1

