Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821615E6762
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiIVPnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiIVPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:43:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71029F373B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:43:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MDk22U032064;
        Thu, 22 Sep 2022 15:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=x5Tlvkf8RgE8zYLmzgrIUP4A5q0zok6YkaD1iMXGP9I=;
 b=cMwKQCyuNl4hX4rXt/lcZ6EzSMqy+aLGbGssw79ArRCfdD6A9QE7mEcTauMzFNEM81Ch
 H8inbVX8dNtdrHqQpUk2+qiMVu0Z46TfZnFMbfZCFbADDdaNWfR3gKecVQ0TWrQLSQJx
 StO3PAnnu7b/ezR73CBKhU2msCmveMRUIm8Uv5oiEGG03x9fhJ2Avyrc6Q1TAdh1t9R/
 GPp0RZQdTVLYAYd4Oku36DBP6Qk29/cV49+5W2I6Lb1tJrlhrh11kP7pJi6BVLIHq5x+
 e7I2ms1kUP2Czl0g1C54X4uutxLgceJO65qdg6hq9Ao3Owe1oOA234X6k2a+XhGYk2Kq Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kwxmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:42:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28ME16HH010161;
        Thu, 22 Sep 2022 15:42:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cbdwch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 15:42:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kevrJbALdNPi1dsFu9H+4fdAqH/Jl6GRza7ejcs7TRs5+sM3HAST96cl07+ZeLYRqoWqsZcWy34I5aYVQvWkeH7kaefEIvBXcXTn3lduPbPpqoCvEVKyULe7i1cVywUfBq1+LnySBoOMUIO4+jpYT2IG8jA4RqPD/0bGnM+TzJukivNNqknvYci9QbFWRnzk/Bl4lkoIcTplZbJO9vcT8grEGSWXGb2aOgeDEPx3J6aaQ0ftqr3W45+YiFjdc7xzWruu+PSfY5GCqg573VkDJoIKalQu5QT+MojeKsZNYLwIGN9NqryJXgkzrAvi4ZKLNyAkKmut+VHP5bdoFnxI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5Tlvkf8RgE8zYLmzgrIUP4A5q0zok6YkaD1iMXGP9I=;
 b=Xb/xzxhqWEOimaI2VVIWbcRn1QpXcaVB5DxIQvEHI0CBLsi12tNrIv+AunJa43Dcn+T04MCm5gfJacfWkPm6lRZDDYYzi9CQK3jdwGU2rGzr+tZpGniUXYfXVbETBaU6OPJNu9JnaVCD1fTR0oNOzW1EdKY65mkIDufISExuyAZHiQZiSYlhjHY7KFEogg20324D4OhH49wwAOenaek9zmlqcRsRupU4NO6PJNGGfLtvBJAeSNeAjz/YjKpS/Urq/SGM4+icBueVRnpLYkLsXaMHZhotRUAsweGdV3KG3OKVSdwvXfWNGMmw++9MiQt5a4S7U21T1eRvyWxXcH4m5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5Tlvkf8RgE8zYLmzgrIUP4A5q0zok6YkaD1iMXGP9I=;
 b=bLquq6u1J/4Lp7e2mq4zLSdYBLqfOt343xf+C77H53eDDVi1bRoAwZ7adg+fOoQ+JiRv8PFLIQi0W4ikVO1HJUKIcEXUNo91lc9HCI0qc0HloVQJWVuOhCt7hGDymxwvjTvskMIKU77JanFebCXkGdZtPqcKvXByzEmeURYnzmI=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 15:42:42 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 15:42:42 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4 3/5] mm/hugetlb: add hugetlb_folio_subpool() helpers
Date:   Thu, 22 Sep 2022 10:42:05 -0500
Message-Id: <20220922154207.1575343-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
References: <20220922154207.1575343-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:610:5a::14) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 399f1db2-750b-429a-cb95-08da9cb11662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZzY/jmlNus3q+GXV+cepb4iY5vnxfogGLq+Q03RXG0PRCX5TGeyZki6zZHFGRiKhrjob927CGl3TWyoTx9ViHxhbritxsAjMlHDS0mYU6HmNJ8WfLE9K0690tVsJkehCdZOaIUMo7+neYu4SCe2bv/TQKtidoRyuZna9OnClkWqcMNQt+KnkHtN6CPEibR7XegFgbf6SooVoii/T+u8pSJmT4GowQkR+NiwCncGhc/g20igrjP391QMMci4t3kRdni7BTKq4Xp1ltvdELKsJ3LRhum3SrzwLP/gC+Js0Yb6C54jttewmu7uDre2g04QuRQkvKVWZGYz/Mz7RySlx+uqICMkT4/4riF6P71upvJP98VPQ9pea1OaKQpg3Z8G1VwL76jsT7iq97QZG5FfgqVwICsaiZF5e6KRjfBlU7r2onI8x8bZfTYgq/isVsBt5zRfMyt6M/+EVaBFcfCrONvSgQ/4OcHlQNTSqQwsYj5BMAOKNQQl2snhugNvrOpoxV6Ed8wR9IQ3EqRwtX1H20gVp0oebyQQ6JicZbjRLMh1hmogD7N9BvjlYDtvJsJDMQDJpM4MHlsmsVReCxobGbU/iqvuFsi7YMLd14lGiG+DmkXJB3YtWFCGw8wtEPC0WLACwH4LHeLe9dTt2ZZtZkB543g72OF+62//Z6myS+Sa3Lv2apns/mK1TiyBZO4kV0dD/lEtK6u6dfJrQBrR0TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(2616005)(1076003)(6486002)(83380400001)(6666004)(44832011)(7416002)(41300700001)(26005)(6512007)(5660300002)(2906002)(107886003)(86362001)(316002)(36756003)(6506007)(4326008)(186003)(478600001)(66946007)(66556008)(66476007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lWoHR5K4CkygZ6x6MDjes9w+UadBTurk6/NVrgB4cdkumMvyBsbV9KsjH+6p?=
 =?us-ascii?Q?ukoMGdY5WeJu6y6K3ayYGZ5X1O0t33gQAZWYHzhJbZXBVUk9U8GRjZRHGu13?=
 =?us-ascii?Q?bO2HhMX/i/xKY4aD7+JmmxoJcbporwBC+s2eZI74thDN/M5vizLaKdwn5fdK?=
 =?us-ascii?Q?NjRetUMAbWan3FpFI8KAsSsPQHUtt/yDUN33oH8ntJ3rkxv9axsIaEP6OPN9?=
 =?us-ascii?Q?gB8hgdQisufr/nlyKGWiYlj5c60Iadqz+YzLHk3DAAOkUf0TjWF4j6jVVEaW?=
 =?us-ascii?Q?i3VX1ZVtZEPMUvRTXShKx9mMKp4okFYkLCgG1R0VuT3nqWr2DAu03YBiMl1D?=
 =?us-ascii?Q?bKzgd6HJSo4CotOlPY8zVoY6y/gPatEPfYvBzWwldO3TejkJgwKrUHRjV9pZ?=
 =?us-ascii?Q?u5TLvRCRWrBzIQX5HgDDwE+xa3LB5I5FTLQGFXVhcrC/xdU1JEkB2AfIDSJX?=
 =?us-ascii?Q?BcZrKzz3g9lPCBWD5QtA/iIdHhzFBXHLzyXypIvp9c6W4xRY7g2wFxTSspDP?=
 =?us-ascii?Q?Tw9l5/V83F5hchZ+wo7BbsCjSUyvaviDDD40kFcT7Nq3SiSJm+2kAFw4ZTbx?=
 =?us-ascii?Q?PL17Zw2mzvElNyioyYHADctIZpKVlz9AlBPDMbzRvrwYLi4v/68XGz+FYfY9?=
 =?us-ascii?Q?aEuvtZ4d7FBGgERsO9tV4ZIwjy5zBlHsJFVo+wsdpOVpaLzD1KXmgSsLW+Ph?=
 =?us-ascii?Q?8INMVWx/sp1o5LczMAxpJlmakhbhhMWvRj7udr4U00M9EArtNmSU+6OzQxrs?=
 =?us-ascii?Q?/MDywuCBIQnERPtlEPmPn9M3iRw0IRTqigWAawjz1SM9q5gva8F0hm7+5xEh?=
 =?us-ascii?Q?/alqMk5blQvK+/IkK2h3NAz4vWL3brvFWMRlifXeTeI8S4lqH/EOCx9TRXGR?=
 =?us-ascii?Q?CWkJXn3WBOpZFlInF8lSI8s7WYp721EvdiLPiWyOAFSBCgwso1JC36hLRGcD?=
 =?us-ascii?Q?KCq5kTkGEVceyEOnLUleovnKQ3xtwdkqE7Lpqk8I5KNw6YJzsq9F+q1IP/wg?=
 =?us-ascii?Q?gXCsVFRrIeeWYpww2u+iKOCsWXUP2acQFNc/MWuC5jMNYHlsZb71dtR5wZ24?=
 =?us-ascii?Q?3MDppBcozZHJAbYY3PexAvUw1HNUE/3TC6mZChKLuxu/z9JAgft3BCmazyFH?=
 =?us-ascii?Q?+kEtPrHIucRU0s5iUI79S3dT+slELZ6f+p6xCxXFNR/aVY8oUE6J/WkimFnW?=
 =?us-ascii?Q?8QGHdayfRMHsV2+yWnwHb9SzO4IxXSPwD/oRJy4uRSS/oq6zrHq6gjlvcQC7?=
 =?us-ascii?Q?3IOqhrYXbXJ0BboQPAh/ldrksHPKv0lHoDbDLvoCbHJ01ndwrbsXQn7/v8ql?=
 =?us-ascii?Q?h0JwTaIlVj8+ae2m8wul/ba2uXaFk/xH/lkvZgD1n53PXOqAcZ12gfIYoGAv?=
 =?us-ascii?Q?MyHhiK5kZl2d/SY5KNreEVuorjd3WqYUo1wMzqtWgzrCMJ9Ef9Lj/XM5iTHM?=
 =?us-ascii?Q?oNnBfT9xqHK7jSLQQ7nPY+Z8BLIV7ynkaoyxnPz47UEoe0QlmzVPEngavDMN?=
 =?us-ascii?Q?6uqJUYRtzaQghpHA1OcvhbpK9JxwSes5IrTylG+xSI4GiuLHQt4gEhVNhgH0?=
 =?us-ascii?Q?80mJFwGC0nAJuM3arA1rcobX0fG/gHctdB76I8KUC1f5l7zjOgHIEM7a8mPS?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399f1db2-750b-429a-cb95-08da9cb11662
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:42:42.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6tpiRx5uMYdwcrUvjCENiwU59yOhO4Gqfy9gdDUKY68sMYMj6nNFbB+2DmKgAXwDq/Y5jDvm/1u5DaFPikvWkxH29a3AUmy2m+P/opwt34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=878
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220104
X-Proofpoint-ORIG-GUID: wE3HS3cQJCotp-6d_3ECx8pirY_HJouu
X-Proofpoint-GUID: wE3HS3cQJCotp-6d_3ECx8pirY_HJouu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows hugetlbfs_migrate_folio to check and read subpool information by
passing in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    |  8 ++++----
 include/linux/hugetlb.h | 15 +++++++++++++--
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ed57a029eab0..5a4b136c6c36 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1099,10 +1099,10 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
 
-	if (hugetlb_page_subpool(&src->page)) {
-		hugetlb_set_page_subpool(&dst->page,
-					hugetlb_page_subpool(&src->page));
-		hugetlb_set_page_subpool(&src->page, NULL);
+	if (hugetlb_folio_subpool(src)) {
+		hugetlb_set_folio_subpool(dst,
+					hugetlb_folio_subpool(src));
+		hugetlb_set_folio_subpool(src, NULL);
 	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8edcdb6a833f..f92b9e6c8f9e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -752,18 +752,29 @@ extern unsigned int default_hstate_idx;
 
 #define default_hstate (hstates[default_hstate_idx])
 
+static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
+{
+	return (void *)folio_get_private_1(folio);
+}
+
 /*
  * hugetlb page subpool pointer located in hpage[1].private
  */
 static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
 {
-	return (void *)page_private(hpage + SUBPAGE_INDEX_SUBPOOL);
+	return hugetlb_folio_subpool(page_folio(hpage));
+}
+
+static inline void hugetlb_set_folio_subpool(struct folio *folio,
+					struct hugepage_subpool *subpool)
+{
+	folio_set_private_1(folio, (unsigned long)subpool);
 }
 
 static inline void hugetlb_set_page_subpool(struct page *hpage,
 					struct hugepage_subpool *subpool)
 {
-	set_page_private(hpage + SUBPAGE_INDEX_SUBPOOL, (unsigned long)subpool);
+	hugetlb_set_folio_subpool(page_folio(hpage), subpool);
 }
 
 static inline struct hstate *hstate_file(struct file *f)
-- 
2.31.1

