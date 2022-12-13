Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625FE64BE4C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiLMVVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLMVVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:21:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B82D7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 13:21:29 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDL2BXS004143;
        Tue, 13 Dec 2022 21:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=tbz2o372kFK52fa9A8G+DL5Zfl+sf1AKtKrlVdDAuos=;
 b=Y07sWXJZcXGneLr1Jo6Se+nJUlpLA374hwso0jdhBRZEvQIuBkgE+G8vWRibt4jTZ5oM
 tjSeQMPqRjKQTmjpKBLkVaJVteWcpSdaphL0IttBrZ+PrjXgefqL1Qqgc2rt4PwcEjt6
 2hVhfg8QEOTwoLDr/DxyyL+nlWmLcdnBCMAkEuNcCnLaAkkRxe4iB20WpwKh9sxNnW/I
 PEaVzaeNYRvRCDPfaN/y7AnBvAN0aDF69xJX0cKfbLVRtvxgWMJ1RHkxZgIcMdDK82A2
 ZirVHbTSJohGfJrq25hDm2M57bjWaKkNtC2/syPRvhPxrpkUQXKcJ20/zfkf7kzEeCwF JA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyewr9d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 21:21:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BDLG6sf031758;
        Tue, 13 Dec 2022 21:21:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyenwpr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 21:21:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO9/J5fKvHKsUDjO/SI4jVgvq5Tdz2j+iZdz/dknV01xIYEl96iPRyDrIxa2WMSYl6hMmZFqvP3b/5BDA2Qf6U9oGhRq0HgrL+i6ONqXd68WSrFO2WFJKdbkYY/irBeZXZLk0B8UoTzyWxun5Ys/ljG2lM9LMblSj/apLBKwhkXmPgr+61eM2m73yVmrjDoMNGhV3JIvcoHWmyZYPcLbHtbWDD0xV60mpFR3k3galNKpYu/FhQQvbShEkoe45bQANSVFcqmuG30r8akNTdkI/0bUponhTUHDxGMFa4hT3ascSUexi2Yq1xrIiEwqmHVvPkREryvfo39roZpdrPa4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbz2o372kFK52fa9A8G+DL5Zfl+sf1AKtKrlVdDAuos=;
 b=H4KB2pUieyjMPzoNsefFd2sABB0KnDFFqkox3SlEs/KuUqp0RJy0OhZIyV5L/73M1DF496KZZooE5jR/wEafcQAUzpJH7VsMWPanfZj8gJpk9Wlsu8mqF6uhBBG5TZH6XIxGRfRHoRP6CT5HI+uDDEeN7Q0BsHfeoGCblKluo5KoOYyxq7QQKFfIWVWdP2Ns+wf7PS4Oci//JSZ3zTlKADLqvbmDo4YstZmBbEuWZkfjZZOpzpt3G8z4TLxA17pF7ag5v06I8b/Jnx4QVe2u1WHG2G1Y/66VO/5r/h8UtSjOu8G7PHRdNj3Orezov08uYrsn/zdaceNMoL+ondIjSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbz2o372kFK52fa9A8G+DL5Zfl+sf1AKtKrlVdDAuos=;
 b=U0j55XeHq41CHjMSXvugia/uex0WCOwja/pBPndk3ZgaasTzfNyQ/DR9KADqoMWBKTfIm/QTsk5FAZHbyV2+IL3B5HX6lJp+MLJmaTZIZcU49JthmCSXByQUQjBJ829NHx9q1sdvEToVP8LkPmtxRDvAMPzjBzLne6YVCzfll3A=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BL3PR10MB6235.namprd10.prod.outlook.com (2603:10b6:208:38e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 21:21:10 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::51be:1301:5ec3:996f%4]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 21:21:10 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable] mm: move folio_set_compound_order() to mm/internal.h
Date:   Tue, 13 Dec 2022 13:20:53 -0800
Message-Id: <20221213212053.106058-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:a03:80::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|BL3PR10MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e489208-b4ae-460e-556a-08dadd4ff406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nX9jV17kodSNPKDwwJeDXYCqVeQuU3AIpkqFrdqIuW3uPvwyCvJZxJS6JJayv3xzdzaeTmw1gDfobsWP9lopPRiq9aPXjncOPl/b/8gJUGVBFNyoTKFNMvsP1GQLiVmuYw+ikq9rA2oIfEnfuWbkPZ6JY9Ty41XaS9eag/gHLd0k95cMj2x0TGeXMjsAMf9QcGr+XJ6UnK8aCatxqemsDwKXQXqgocgB36r8+SZeyLnw5GQ8uLMBVAa2ARUq62Xsgr6dqra1mADk0wtxcs20vYlwplNPcx6Yf/eTBaVzfv6fn/c4By4NsVQ0y5fsC5oR0jCnfCagYpE10Ou8kJKHgGVz9TtTE97rrkjI4kD/8veKan3/LUJtKUiLU0RAD4C+Z4mSZabE5+PiwAxAOHjFR87Y+wHZML6bQRXlhz/LxAwisGhjyNVSGGrFxg6uNZFZqihCPgYrVDQdTpgcuFecXJZJcRQP+dS0aLXqefC08wQYJdlbhTIHtRqW1AmDZWftT4o0VpkleDqYcNOtg05aQfLK/lq5g66f7L0WVctOOq8rQrGN5w48hHmT6vzQSs2bHOldxwjyuSpVkDGwGp/Jj4J1dczKXGCFB8pK2o/ttYcngLQ3USyGgqP52Ha1/OBHVZZ95+cVP3gRU9lZLhmEIXnfZKNIUwZO+TSM1KI768E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(966005)(66946007)(86362001)(6512007)(6506007)(107886003)(478600001)(6486002)(6666004)(186003)(41300700001)(2616005)(83380400001)(44832011)(2906002)(5660300002)(8936002)(66556008)(4326008)(66476007)(38100700002)(316002)(8676002)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+QAiiZh4+JfDHbHs3tCs0YkX3qQ61AovM4hgFqqRuP3MbA+vpFC0XZY3hCN0?=
 =?us-ascii?Q?jjy3F4qDdJ9cc23OHPejCHSfInxTF0gHumdSpkmQIC/0ebWSceXUtDYAiAbg?=
 =?us-ascii?Q?S3uIEe+3LVsKTWlACjfpUqOJp/uaZpBaXLNhtu1q74NA/8H1amvlNhUFaLYu?=
 =?us-ascii?Q?A8MUgoeXWR5a65Hq2stWd2WELVH/cRsPJD63TkhAWfIPedtvtiCNv3HtV13w?=
 =?us-ascii?Q?+TUj0/UNhLjHoN1TWRJ8LOnHwISGIn/x2rSiv4pY3ScqDwrpViY+tcMgoEfY?=
 =?us-ascii?Q?aUDoak+CASACpquafqTOXphz9KqxWPRZphab+L+5H3J01verMhWhQctYaiLU?=
 =?us-ascii?Q?9/lpr7UshrHsZj7KiohwjwqKuTzd0FjsFuTKj7ptm6yLitZr70BsFntxFS41?=
 =?us-ascii?Q?f89P7wyPBB4xvyW5TB5/8TLYqJxnkmoffG0TdcOtn7OZ4g8FiXkc6QzrU/Yg?=
 =?us-ascii?Q?x1Gyu9N80vE346AuC2dWmgVuC80SvBNtpSOidWgeVlCwrchcxpOPVZuSfqTg?=
 =?us-ascii?Q?9PsTGHpz5r/6Ua34UioCmk7HsJgDOO2pOaLKvvNOW/yK1/QxjbWLx0/ha8hp?=
 =?us-ascii?Q?3pYy/qHYrxgm0lFUwBw+tV+Nc4AqIooiZX6NKriSEV+nxVk+3nJamKhdlJ7I?=
 =?us-ascii?Q?2qDH3dEhwSuuPBHsn6j2kGgEx8t55V3ToXURvfhOKJVBQLAFAUF/3knTkEvB?=
 =?us-ascii?Q?I96z1NDw3WUkvHH2lyxUGsUD+Q5Rruuofw+7sELxUSru0+NrgjU5l6kTqy5L?=
 =?us-ascii?Q?JmPlGvrCaEFGbvIwIfqveCd9ywMgwtj8X9pSdCwINhgN1eZ2N5r2btXAE9Ru?=
 =?us-ascii?Q?BCP1PCqry7CPHxhO0pMf0R4C1RORpU51T+a9AnLRebNuYXD82MGUfjmSx0Wy?=
 =?us-ascii?Q?KpCJvHyuupqZPAfMeBL1VDJEInbdY7UomFzdhy3RXquB3Z7bY9n3P99pR9ss?=
 =?us-ascii?Q?n4m2ib5sSVNTDuhJ+FbNry5MSzkhOfqRqG1Qc+yj+iY8AhLd9UUeJaYIGHsM?=
 =?us-ascii?Q?UAtJsX+lg1Dq1VgWt49VXnfJxmdL2mWxhGy7gVLL1TcN3WJoMdC3vYpaGtSs?=
 =?us-ascii?Q?vyo7Yqzq8PKDVitJhWv3ii+TSSvrUiZTfvtVlPLOusdHqqxNaphUf2TjD7/K?=
 =?us-ascii?Q?9Clk3npnU1GUPWyBl4DxSz+eRfofug+joXSe2c6szjcy6HOANjZnNTDV7Asv?=
 =?us-ascii?Q?YSksKkbxH7iIUdGGu3ARpe2HDPK/Prl0rQYloDhE3ql7zjRwTzie3b5td9LW?=
 =?us-ascii?Q?fJzsHrQX+yMEd8frizoQLcTLefNi1l/OvMKFumuKISFJb2o8HPAcVSft/mQw?=
 =?us-ascii?Q?JBY1LFbKiUNsR3lYEPeYQ1psx22sWvxgqZ1v90KeeFtne5v03ct4XJTZQSJp?=
 =?us-ascii?Q?Ads8DodcbPjEBanJqSmFiIA2JByc+XsKqlEyOEa60XiVgcMO/xXpf9tHLwEK?=
 =?us-ascii?Q?fU3EunTjq1AOFBwGRUZ8mtE+AfLiugOQq3HWaJGpqNnyRFV0f+VrJNY6L51j?=
 =?us-ascii?Q?jfQW5JqVPPXMMUv5ztv2JHuB0zfOJVt86Uw4HdsMpl1EkuQKXH1qOydjiXeR?=
 =?us-ascii?Q?6XMNyNXOhXjuC+8keGTyd8vi5WfpPjG3CDtP1epShQAP1bHz3LjOgsjYkotl?=
 =?us-ascii?Q?UA1ncieiTpTXLr2XwYsNgQpelAyk6KufySgR5CTp6lkCz78ud75UT/kLZBGn?=
 =?us-ascii?Q?Vc9v7g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e489208-b4ae-460e-556a-08dadd4ff406
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 21:21:10.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHPw5sD2S+HIDazsPqn/5d9wCxmcGmSL2cst1ddDIVLE6Jlk7HxSA6EmJ17DYg0qEy08qaXRens/FgYc6yQFDKOqdGqTFmTI6i6iWf9lsVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212130185
X-Proofpoint-ORIG-GUID: UA0zIuPeZm9cIOBjZ5kFdcTF7SikrJZp
X-Proofpoint-GUID: UA0zIuPeZm9cIOBjZ5kFdcTF7SikrJZp
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
---
 include/linux/mm.h | 16 ----------------
 mm/hugetlb.c       |  6 +++---
 mm/internal.h      | 21 +++++++++++++++++++++
 3 files changed, 24 insertions(+), 19 deletions(-)

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
index bcf75a8b032d..829b6a60ceb7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -378,6 +378,27 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
 int split_free_page(struct page *free_page,
 			unsigned int order, unsigned long split_pfn_offset);
 
+/*
+ * This will have no effect, other than possibly generating a warning, if the
+ * caller passes in a non-large folio.
+ */
+static inline void folio_set_order(struct folio *folio, unsigned int order)
+{
+	if (!folio_test_large(folio)) {
+		WARN_ON_ONCE(order);
+		return;
+	}
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

