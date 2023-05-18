Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6367B7085DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjERQUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjERQUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:20:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493E8E61
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:20:15 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IrdL028532;
        Thu, 18 May 2023 14:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=qP9dd19Zy82dZAbmnDhZ0v5iuqHTboMRfJ22/dlTxVI=;
 b=qgMZr/RXok3QHpyEKEoCL9oWQu/WE4lc/0BJv8A0PkzpEHhuZd9FfBtAfR8XIIXmVufA
 9oEspFjlkvzSrLmzfrUoNFoIRzeR/+gfbPZOMO3mwBpiaDIzbXGigSYxL12b5L6pMZQa
 at53Ey61zXX/nb+BoxWmTRcTbuayUhzZrqTJXHxiFTxH0JcNDsT4FaE2B8EBx0MUwGY0
 QhNP5H6iMjKCj3ik+mhMuGZIWVHJQCGRA9SDy5eRTJ/GRcZZDUnu4a2dAUSZ3rHOx73p
 Lr1+tlup6ERbkaRBXusrYPyvJmLGt0haopIjHqwE3ACsBwvnw+mHaaVMgvSJ/rsv/fgG 8g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc8f90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IE8Kdh033921;
        Thu, 18 May 2023 14:56:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj107c820-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1HbdzodyUEmDt8qgExqAgR17vmORMZ712RSA9f69mlk8TpLcRurHms/AkOZpx1JZu8MeNdZ5nNXbZK+l2Iby4hwC6g+msdyoVEhsiaM/+M9uGTvD0l+eYJixtLIOVrkPjeGtqNXlD4xINT6L4SF1fx2nn/gvIrZ8Jvp/qhGJ3IPRryUwHCrbEJYdnrw+J2ZPPdjz6M9MwV0rG/egj3HlAVcHExrwU5M0LjSW2BLBOEvB9ZTFahkSC+FGHNjNbNJOY+GZv/vnkrl5dkjHUtJ3V04MBSKHcF/MUxv3DvmbIgfxr48aq9R4zEB7mSjen4ecjgAeRDW7BKDx2eDgOUFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP9dd19Zy82dZAbmnDhZ0v5iuqHTboMRfJ22/dlTxVI=;
 b=mQdMPqwGhp7fhO7NCEyllGguMJXCePtPqQhOgoRTy1DZ81qI8DzzWCbhXG4W7ucKTAPPsUAj8KBtpqCtlVFKTQlp3OMHlFHIaNbgzfUY/uMpV/d5g6uuj89+1nfA9Tgj7JA13mxS4N/ehJLTnRC16eJOYouX/5lDZ+EJQKjGdviK6HsorRn9NfGhVUnPQzF4OoeqZ1qBmOMJLrACrwgznaxA8AE8FA5wWXkZjvQplFhtbzmnLeBY/V6XrLOlzVMcqJuSdrITGRyqgUJh32Ib899qeC/goyKwlRrd/+iDfnVKUUrBzhz/adiEJ/bzCwMVmbl4kxT6X/fYvLdMbD7LRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP9dd19Zy82dZAbmnDhZ0v5iuqHTboMRfJ22/dlTxVI=;
 b=WseFp9PBoz8E3udTMsIr/wxjkacvCo+xLobM/Yp5QcD2VhqCR5PhlPb96cTLc3ga2BvuYv2x5D3oQxi/AOukyhWBfjaSJQJDV8e/ij2+EfRmsQwQlGHeQntZFNjhmb6HFQuBLEqAeJu5hXL98sAfa6Vl5l9/6Rt1ZOO6QcdHLl8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:56:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:10 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 09/35] maple_tree: Convert debug code to use MT_WARN_ON() and MAS_WARN_ON()
Date:   Thu, 18 May 2023 10:55:18 -0400
Message-Id: <20230518145544.1722059-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0339.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7dc1bd-f484-480a-1998-08db57b0048a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3JL1brhEGCGnEjf/xBg/Qesm3oG3tQD07Nl/CY4LcrePXQ8Z2XbQuwOkxBjvXxxhBtxj4yNUbdDpuQ1oWhUIMW3MDuB2mJqArIS+O9pQGUMzxN2y4Nk5rmeUWgIvClduWGkfSE3cQ1hqEI2VncX+KEhJ3qaqAKGbcOa/bcPCAufykN2tG8mrmJPt6r1wiwRIjjR5hdpyIqMiQg+bDDihcceLPskJaaJJS43KEJY2LP0dnH9iZU3vr6KM9oxHRwT5Yh0bNrXV6SHa+HSUTMKKeR7QTzA80cLHd77FTh3xIFV+Fd2A2uFAco2k5rJzf4c8cdbLdHV5rKbC9Xl3yWmWY0U1dNeyf8ZGZbyxFc8NPYgKYkTPrVr+BhcsQEBvQtSdttuFXsDI3wpB9wAj7L7+Zgaksuk09mquwQyOgPSTvwFtcZtKU1IRx691rbz17vUrjm+ctUiAVwk5/+zhcnjl8d/3eRWItrPZQD/gxDubU9PXmWP7hHwWlS41Sktpa1kXGSbzwJe2u+z+lhDoECZyFoJmSASpOogB9WDIiygww1t3erfxZLq+bfHIu3cEi+/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(54906003)(2906002)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EW8ci2CTAWH6+Mb2mhENOzU+LYwG8KJMK0yo/8dJJpao6Re3G9YK7uKwo3wq?=
 =?us-ascii?Q?X52uKdGJ32d6pBiuUnyyOGqPpDc8SlxXHyRWg2s0NPdM0UTTi4vofClWXOsF?=
 =?us-ascii?Q?Xe2GoF76ahOGEJm3Wqi2ao2Jeaht9MCIkjo246TCdm94gTawGe/fhwrb9jPn?=
 =?us-ascii?Q?JMhm2xfmk4rUCJtsIDD85LvjRBBNVg9RqPV2FMxRm7JE4HQdqxsMKXt504Pp?=
 =?us-ascii?Q?ps4tqI6UaAu4DT4JjGrETTxCSQnNSQDPLjq6mJkqPBqvRyFEKI3eig9f9RjI?=
 =?us-ascii?Q?y0oDNVQdaIVI1RHH+5V7SX7GnEH3SPFUE5x8bzALEGZRfLmGd9BPJKe4rOLQ?=
 =?us-ascii?Q?fESTTNTr0avG1EJN/s+rwXlS/C7DpYqQR/ng4Nfo62avfHGUsGjjulLp7ut7?=
 =?us-ascii?Q?+B0tzRzobiSGktOB8gFbYnzzl18/XOnKje093ooqI+sogy9YAJ5QsgtJXmvm?=
 =?us-ascii?Q?rwvHsN8AfncPKeOuED7LqVYtGVhss7rrGA3Oi1YAVF5y9rVDq4M680vVfVGi?=
 =?us-ascii?Q?S9W39Eez6g8XrabHFki09ywzJrUemm1Qi8wJ9XvfYKdU27gOLsSzPhqvoKtD?=
 =?us-ascii?Q?enPutEVHsKfWA2+rxBvw2jkfxIHZxETFdc8yWHQbkYJrAST30+ske9qWVyzd?=
 =?us-ascii?Q?D0+dTWqmABkuMvqPKNtw81bxDOJ+vozoFN/l8bZ2xvpoBRkqFYXtzB8V8dMB?=
 =?us-ascii?Q?FySkCqrcsZdDcJ0YP0TK5f95v8S5L49jAHXRaKjmUYy33BAW/oo48kJCu0jr?=
 =?us-ascii?Q?SIUCFBapnI6V0UxArFC07EMca7i4Exy+0hqagfK+LelFPeTh/blwvRdeFURn?=
 =?us-ascii?Q?T3w+iYzb4+y0GZpThyWnRWoTXnnfq/pzMN0EvbHN2nKhJtICVxBwFLONgeGd?=
 =?us-ascii?Q?2CaB7PWgYWrY+xD7iRUyvmmbBk8qEoHAN4NCv+qhBH44tkplR6jJX5mfcDke?=
 =?us-ascii?Q?HJneG5nIY1FjMZcWEOEvOrbO/UfEmjVdbefO6jcuc9VwBFir5ypXAGlxpcl5?=
 =?us-ascii?Q?TdwQfnk8WururwJPiF5thBPWI/s18HK/plGjfJRUIpOwTg4Nuj9fr5Eg6Vmy?=
 =?us-ascii?Q?KM05THxrUniKTJdCYG+yG5yHUezmq/Np3SbLl27r0y+7uuvJ2q7EJ4kUP4uf?=
 =?us-ascii?Q?VLcl7ijzRofSivmINMSLWiTtL/paQ2cpfgO0y5ImyZnMQ132lMcKQRgVDUYi?=
 =?us-ascii?Q?8/gmDGO0G+fMlVzI3B5F/8dGtkmMT9KdCyKg7iNcDtfAuha4CT42/61a1f5Y?=
 =?us-ascii?Q?eDNVjDQmNHNoI1CoWE4DVWAlWGpz0+uvyEjtpKrGgkO/OKLOcfnX9S5wX5bV?=
 =?us-ascii?Q?SQ31c/zPvN+fMljgqguVRS9gWshUBmoqrG/mVHwtIxmCTz+n7ZBHrH5/QhCF?=
 =?us-ascii?Q?685pT4grd88igmNdIWnY7liAPDVGdeuezlPrKuc165urH53qorAy4jPR2S9o?=
 =?us-ascii?Q?7p0DrUKmgM9ltpOfssxd4w9wIPTaOrn9NYCjNkp9Cr0rETis+a/UF7VO3Fqy?=
 =?us-ascii?Q?eBpmuSS/yf4txpp1s0SFvsF3IWAgceVTVpsTLFtgxhyWYiOqClggPNej+XX7?=
 =?us-ascii?Q?P311VQiPo/LAXVBYO4hq/fLBDhrn8rf1cWMSrxlmuAQMOvbCflzZyFKDGtjf?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pIUr0crr65TNOutO+R0F20AFejSzK7Qekf0kCGpOSjE5JB60lGtLgu1RBBDTLyFv7M7WTqzu6hEH3hBkY5RgbKVkdjITNcSz72VIIDSL/z/Eu0VYFtYfN5WxCFcCVtyL69hkvYAMgTfMV2CRx++X6EfCYvGfbrmY/5mY8BIZqgJMFeGaC+fNHCQ8O/2MW/irbVBy+4obBKcmN49KgF9vFOVW/0B1b7o4O+GhdjeIm9dGPwQkoCmmnoSdVaU7XZ/78o1h4quH5UvPnImpqoG1930QLxKbSNMHL3XM4/zQ+AAVMXS4LCuBEonyHJyV2bR1z8Cmfv+XFflXqkXHYs5pQ4xgSxEXfasKeyqFGWGdaK/2V0OsDL91RgYwqjnfWhGqZnO4TSGOVGS6V7VW/uRJpbFlozuHTISSPaUoExJI9B+uhnLuGHHq2hIXBNllaspS5fUicaE1Y98KmF7qn/Q5x4+sToHs1P2eC6OzGiJmNfDxcfGRBaYzXI49o94CEzARLaEaZRbPbmEsHO/Rvjh+WYioBK4IxSzdIc1ygXb15e155C+QCuE2NzsdyN0GfQAXEmviLqKU5jgCyJgnGoSpPZGkRY5NO7sME7NX+HIKOYnZXILk0c6/ODLbXR18DQCP5g3MBzftTrrTgh6fqr78tyTRjtePDKMnQgLbk63bj6BqDugFZLptC/P7v95rT0ry+Myjn/asEwh0rpsuoYvUVYk4YsDFJxSz74kiBwJ61TVPKVsxYVGHn9XdFuUhTVdhFZd09yeqSz8m23pHGKCBPe7uPkPTOEfCx7p0z3o73lwiKAR66fKsVUh5Ezjs4hPTYJWuG6gYQOfgNPnkYlyz2M0Fh6KUvQnxyRJdJfua+kAucwBBzUL2j/38Rlu4vlguOo4aeN205h7p5Ll9V+6SRg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7dc1bd-f484-480a-1998-08db57b0048a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:10.6571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yoTv4b2lpjrbLpQ68hea+H/xuH9F3sPoKYGbdBiMJDgP+/iDvfhrUIKzeJocAxvBBjItZr5X3Gp7l3x0e+jzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-ORIG-GUID: Hp7Z5ks0L0a7gtK-oW2ABlSPG1UfeVJL
X-Proofpoint-GUID: Hp7Z5ks0L0a7gtK-oW2ABlSPG1UfeVJL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Using MT_WARN_ON() allows for the removal of if statements before
logging.  Using MAS_WARN_ON() will provide more information when issues
are encountered.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c3ce2bc59412..8fd83f21caf0 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5698,9 +5698,9 @@ void *mas_store(struct ma_state *mas, void *entry)
 
 	trace_ma_write(__func__, mas, 0, entry);
 #ifdef CONFIG_DEBUG_MAPLE_TREE
-	if (mas->index > mas->last)
+	if (MAS_WARN_ON(mas, mas->index > mas->last))
 		pr_err("Error %lX > %lX %p\n", mas->index, mas->last, entry);
-	MT_BUG_ON(mas->tree, mas->index > mas->last);
+
 	if (mas->index > mas->last) {
 		mas_set_err(mas, -EINVAL);
 		return NULL;
@@ -6529,10 +6529,9 @@ void *mt_find(struct maple_tree *mt, unsigned long *index, unsigned long max)
 	if (likely(entry)) {
 		*index = mas.last + 1;
 #ifdef CONFIG_DEBUG_MAPLE_TREE
-		if ((*index) && (*index) <= copy)
+		if (MT_WARN_ON(mt, (*index) && ((*index) <= copy)))
 			pr_err("index not increased! %lx <= %lx\n",
 			       *index, copy);
-		MT_BUG_ON(mt, (*index) && ((*index) <= copy));
 #endif
 	}
 
@@ -6678,7 +6677,7 @@ static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
 	max = mas->max;
 	mas->offset = 0;
 	while (likely(!ma_is_leaf(mt))) {
-		MT_BUG_ON(mas->tree, mte_dead_node(mas->node));
+		MAS_WARN_ON(mas, mte_dead_node(mas->node));
 		slots = ma_slots(mn, mt);
 		entry = mas_slot(mas, slots, 0);
 		pivots = ma_pivots(mn, mt);
@@ -6689,7 +6688,7 @@ static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
 		mn = mas_mn(mas);
 		mt = mte_node_type(mas->node);
 	}
-	MT_BUG_ON(mas->tree, mte_dead_node(mas->node));
+	MAS_WARN_ON(mas, mte_dead_node(mas->node));
 
 	mas->max = max;
 	slots = ma_slots(mn, mt);
@@ -7133,18 +7132,18 @@ static void mas_validate_limits(struct ma_state *mas)
 		if (prev_piv > piv) {
 			pr_err("%p[%u] piv %lu < prev_piv %lu\n",
 				mas_mn(mas), i, piv, prev_piv);
-			MT_BUG_ON(mas->tree, piv < prev_piv);
+			MAS_WARN_ON(mas, piv < prev_piv);
 		}
 
 		if (piv < mas->min) {
 			pr_err("%p[%u] %lu < %lu\n", mas_mn(mas), i,
 				piv, mas->min);
-			MT_BUG_ON(mas->tree, piv < mas->min);
+			MAS_WARN_ON(mas, piv < mas->min);
 		}
 		if (piv > mas->max) {
 			pr_err("%p[%u] %lu > %lu\n", mas_mn(mas), i,
 				piv, mas->max);
-			MT_BUG_ON(mas->tree, piv > mas->max);
+			MAS_WARN_ON(mas, piv > mas->max);
 		}
 		prev_piv = piv;
 		if (piv == mas->max)
@@ -7167,7 +7166,7 @@ static void mas_validate_limits(struct ma_state *mas)
 
 			pr_err("%p[%u] should not have piv %lu\n",
 			       mas_mn(mas), i, piv);
-			MT_BUG_ON(mas->tree, i < mt_pivots[type] - 1);
+			MAS_WARN_ON(mas, i < mt_pivots[type] - 1);
 		}
 	}
 }
@@ -7226,16 +7225,15 @@ void mt_validate(struct maple_tree *mt)
 
 	mas_first_entry(&mas, mas_mn(&mas), ULONG_MAX, mte_node_type(mas.node));
 	while (!mas_is_none(&mas)) {
-		MT_BUG_ON(mas.tree, mte_dead_node(mas.node));
+		MAS_WARN_ON(&mas, mte_dead_node(mas.node));
 		if (!mte_is_root(mas.node)) {
 			end = mas_data_end(&mas);
-			if ((end < mt_min_slot_count(mas.node)) &&
-			    (mas.max != ULONG_MAX)) {
+			if (MAS_WARN_ON(&mas,
+					(end < mt_min_slot_count(mas.node)) &&
+					(mas.max != ULONG_MAX))) {
 				pr_err("Invalid size %u of %p\n", end,
-				mas_mn(&mas));
-				MT_BUG_ON(mas.tree, 1);
+				       mas_mn(&mas));
 			}
-
 		}
 		mas_validate_parent_slot(&mas);
 		mas_validate_child_slot(&mas);
-- 
2.39.2

