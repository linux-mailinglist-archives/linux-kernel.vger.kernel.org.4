Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7E0719077
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjFACSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFACRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:17:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A55BE78
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:17:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJxIZv031538;
        Thu, 1 Jun 2023 02:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=812rbvUohctb//QCwvvGnF0ZAjJWMAJsWaUHeAI/wzk=;
 b=VtLlUUCc6qPeRuH/7fzXqO+5xSVMgFdn20yfHZnk1N67UHtbwGmT9A/CEkRpehIbbIfl
 Jwb1Vad9KABNwiWDGYl5H2ltFdhCch2j2bjUq7G4qMQvFX8JkHxgR9YEvSuMynuRST3T
 JbGF8T8oNE6ALsX7yg1PGk1JZ76JpqGEfiNwguM0BMj+zNlYUXPsfBZ2ZAqAkO+GI8kW
 PLQzqnSCNBeERklI3KhZnP2zRxTLrEDyA3ptpqKNcCDaUcVpuk+dY9TJQ0VUefI2XW5Z
 mJ22YoQmRysc1XcdBx+diObPDgM73Ok/z4GZjhdDOfbUH0xWEDL6aCxriiGXCMLKFFE+ Uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhj4yhmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35116JEK000447;
        Thu, 1 Jun 2023 02:16:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8qb17j9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 02:16:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inSgIMjM+QIhvuDU1irBKfvC+YyVRujZKxp6qDEKrCNbD9TR0b9gwpx4Jbjps3JiRoDR+8joP5YpDMBN9oEj4OkqahtA+8ZqnaKPntSxv3zWvcwQl/ThoTY79yFu0IgpFNr38lMTVGcukAw0JchtOE2nP7HW7glFoE/k3yxW28eKF++XNqKzVSI3wdrKkivmzH9hc3edOyL2A8ucHxxQIHrY5g4rOeYPJvFgvNmRjg8jsVShO4G4x1l/BKxcM9oEyE7LcbQkMVbN4vDdzrMpDfFM/R1Y3mMb7J+apNGsbLvNV3zL9YQ1SUjyfW5zRBJAxCVosF6GgLz6tKjefjrJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=812rbvUohctb//QCwvvGnF0ZAjJWMAJsWaUHeAI/wzk=;
 b=iY5ehkunVVfgnkw2Q+4nxp9+Ac4dBxiEv45QWBZ9K9qX4x62EKfIoaA6jYDJWvujtYkAGXjlmMaSCvESfGLqQc8FIl6NIblGCCQag2clFgEAHx9BNp1N6GnvykdeLU0rTNkQ1FItgyuwZJyvsc0NTX+PYWEa1Ll+bLgfeATS9ya531Qw5fm9SlmRW44kLlPcJ3FqUZAUcT18A1JUGLzxPQOGFZciGV5rsPGE+ATiMJx6fEWwkpSRjUcSjzDLmX1MUjBvPRq69hgqQsovEEe5Xqvqs+xMGRZSxW8OxPyyntUZta9lNTawQHF2SgxRp0d2QHQxsEcMb8Ja1kNRbHu1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=812rbvUohctb//QCwvvGnF0ZAjJWMAJsWaUHeAI/wzk=;
 b=RpdTAPaJoeCUQHwDgo0h2jZ1Zf25E+XFtJcWj6VgI/eBxTA/PMb0saEbQsd6VMYg2EXkrmilURv+CYgbQbg2QFG4yf/I1puacMDTPceLq6Q/BKv4ybI9SVD1FdBjGMHaZbLBitGshprQO2rzEBhg0sOwAeAJVlGvbf0ugbpWg+g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 02:16:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 02:16:51 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 14/14] mm/mmap: Change vma iteration order in do_vmi_align_munmap()
Date:   Wed, 31 May 2023 22:16:05 -0400
Message-Id: <20230601021605.2823123-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0004.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::17)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: d779e1e2-9258-473d-6f6b-08db624642ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbRNEAa0ANSU02qR7ZjZJ/DC/pBblu2qXs/va7ivxLxv4MnNuHv7UhFpwpYrS/x75bps1TxaILzdcKgyQGyd4MhPNTM6c9232xK2aVj/J0geuUXKA1QkiTWs8BQSb9Ef+b88vGO69QwKMGfdRmXMtgcyzM7bA9+aT7otsvGywtVcftYe+EXj/dieHd0yBMY7T77FZUHcQMtQeOKXT7GybsNLHX6WGlEMLRselUy7p4Zj1FKMu0z3vFQiiuCWiR7W/tvE92UiGvTesouOkJ+YvUr+FyCzuKigaYLlUTZQQbBxSrVXB/mhmEZSnMhheVo7z5qBd47HjBOsDrayuO2cMUrDmIuj/oxiIImO6Um99XNYBtLQ4PWDB7ufCWYNud0eO/bXkaRkQNKWg3DY+6XJf1/JVDmm5ha1kc4Bios2g918o6ZLW9ZqIua0h8Xh6VgcNlkwJIFiNCET+zZkKr3lpudU0ZddiprsDE3Ol0u1VmIzCSX3LETZik1e/dwIV2zbh6PfZiIGk/MiF+wi6H4y0MhIGiJCS/3kL7uPKTA+VZGE1lRZoN4Pemk1px644pFO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(36756003)(38100700002)(86362001)(8936002)(8676002)(41300700001)(107886003)(5660300002)(26005)(1076003)(6506007)(6512007)(2906002)(186003)(2616005)(83380400001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(478600001)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hcuSRLZiYUk9Rw1L72oqrwDHH6AsieMCHCiRMtg6VwvT6fstiPI5A1G4H7Sw?=
 =?us-ascii?Q?CZtIPC1aUvdOi8oQ69PyyCaHRIP1GOC9bIuACyC8oLRONuiCER/zixbXj8Sj?=
 =?us-ascii?Q?Q7zmKzGEFjeOx+JJ1+IPN10zpxyCKdhgM3s90SqAZy9eUqM4qH6+UGt5EwBr?=
 =?us-ascii?Q?FAxhebX3VqIPLU9kzjeqZu+gxrEiAB2/tM5FmDr05Q2Fbx8OoCFL6KGYRxru?=
 =?us-ascii?Q?TzEIGkQyAJuEoWVhybY31x37RElb1zpt1EKiWHT6BiGXfOlPwY0pTv7uunwh?=
 =?us-ascii?Q?B4J1sJm++pkTEj29SN4Z6H+jWW4TKIIp2PVTogzqKMvXj215c6To/dVXd6Z1?=
 =?us-ascii?Q?5DCyN1AGGEuehXI+eoK3m1Q9nRrTnkj2dWNskvzHead5iG2fbzFVCfgBiFdO?=
 =?us-ascii?Q?DjQVvnxunGjUbpsKzTYsnsfbmegR8sdWJ+OlFf9pE/kZf1YJYA6Uo2YhMDAX?=
 =?us-ascii?Q?DevhgmI3tn6o8UyCptYa/nxLRSlhpFDdcRgjbUABPrG3mS8ZzN+c5uinFNkn?=
 =?us-ascii?Q?2DmcD4wtik0e3h8p4hXhVLyi3qv9fwNeDr2cRtc+D+Mbvy0hJvE/XHhnGeno?=
 =?us-ascii?Q?s/TL0kgtMXbCaaoXUWc/MtJB2EGAI9TKyij/Fm0Sgs/TGDXHYBDBe/zjRI6U?=
 =?us-ascii?Q?7b5yizZzi6OLIvT8Un1Wge7MzZRrak17Q+HxeJfm5H43UcGmWdTp0UfTDEgX?=
 =?us-ascii?Q?hFcduQBDeYRxPmSAe+cR0THDExb6lQSjJ91mh+w0nB/34fbOlTnsDROTLHiv?=
 =?us-ascii?Q?g10hZ8NCgMi1urMGS8jjN50m1d7eK4+6HUABSJpEBj9VL22SHEX3lvhECfJ2?=
 =?us-ascii?Q?TXV6pLIp7tNdNkdgJJFGswFKyzdX9JMy4FpLccJximwlD5JrNWQQJkMnzop2?=
 =?us-ascii?Q?URN6pxmPxlIolQYgo2w5b3JmLyM4D91mYHuprbHYDm72oAmhmsWr7X0Ub4eD?=
 =?us-ascii?Q?rgxMj/esGZT6nganfOWihSlQWY+Log3g5KDuIrRfmRQ83zGxWFgg969VOJo/?=
 =?us-ascii?Q?30I2+bE8jNlcLZpCzInK1xBmLeGsFSKcwCLbRp8weoLPS4cD2ONNHWzoRtj8?=
 =?us-ascii?Q?VScriRTEFKLchMh9KLzvROiXWOjJlwU2Ojmj3/ow/KN/NzLVX+or6s1W958A?=
 =?us-ascii?Q?Pxt5vX2pTD8iAWNdSmicMwZt0fxOlmXBSQyPkSz2tAv2ub1xDNZmA1nhmlAe?=
 =?us-ascii?Q?5UNpvaIW3Mao6R48UXCbgBxCkdcu4Q5EGzcX9XlK4JxsWENnVArRFlKAW5Rv?=
 =?us-ascii?Q?qflfhYXyQS0pn+KcTsWMVEevZfBXwosakmf86CTfiha4C13ao6tPfZpXiivv?=
 =?us-ascii?Q?YBvxi+YRIgoV4nOuJRKEeiJY2M6ECyIYJRtLw53azWb1DBdxSzgmwRFzMrG2?=
 =?us-ascii?Q?PDWLF3vi311FEOg53Tij4W39t2vNK1ZOXU0Zmx4PoXWgayAzl1mEYP0fVAUe?=
 =?us-ascii?Q?Q5LZzc7dr6Gn4MIF5zU7n3MvYoHev4ehTMCb4o7ULUF0or59dBi8XgHnr+lj?=
 =?us-ascii?Q?gtyz/UMRb/H50E15a7pY34Fm8p6BLzbuNV+MQX7xwcqPqb/Tf9CFTsETF4e8?=
 =?us-ascii?Q?I8eShBo9LWT8PYJd/v3yQHnbSuD0yO/NSlG1Ste+qZxpVdgcBCvn0Bc5Gmy/?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zjIG+OqMQlIRyfIMRDNJyXegG0+JAZW/yAY3fJ2QWUkOlIa2OaxdLg/wmSHE+opx7AGVZP+cEPnOfOcGNhaVsFAhSQTd4imH1sO4JlzMDiyJKPvJhThBQpNI8omS6zIR6e60Rc4lmkwi+5py9+PFCKd/prujibC/+rqNb+2dgKTdhsLfyIqpesF48F/wH1Qlxt+TOFNJoZGwfrRFfX7PPmbF1Hme425TjdwoVmmvB2U7v5G1m+QwEgnNxCsGgW2JkALgsQvZBOtx7BWcXU8KWpwKSrJ1BFE5ncCPyA8XskwCQlkk9uk2JxjyOomsu8ip5D2ug49XxbJ+fVAu9HcHeYneTgoIXxy+mULbPA0NCeaiHd/lrlE2Le23JuRXZdGKvWozCDAalzVydogGB0X9BfKcT5RPa8EkPGvLIEllC0t3GG+/EjCz4tmAgDY9PITHvQ0ummVtbFtFy/0qUw91xIT98q2bQjm0XLebTxCH7gT6UO4XuxVKwryZO7peo89tIUWDGo6XP01G0S66W66Va4W+nNODuNHmfax/KszzxRclI/h8lYLKVOIJaS7rFG5hFC/FyqdAFRVbpgD0fu21T9m1iMKgzs21ApOsgXPTVMEtGiAoJe8fBnoqHuFESkcSO3e09PtMWMVv78sVTWdJt9laaoIMm6vapt0q4qd2cKhHhNLGWAnV+PQompYq2uivm4Dgpq3QSfCZ71hKRIFLEoJpYwx8sU0BZTteF5PXJ5k97f0pYL4GrUyVQFYbvhtbqalMT6w9NzUxLw52vXJvNfHWRNDHfkxtRRynBncQNPc9rTR2uKbLlZNhY+hQdhSZuWz3/xeOiQNnB5WfqeDHKUazIPCpTG8UY/iMhQVM4gAjROye5vYw2rnxfQ0UL+cJk7dYHkiw/uSwfHkjJrN+Dg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d779e1e2-9258-473d-6f6b-08db624642ff
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 02:16:51.5873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFzB9exa0yaBCbQ4wUjxynv6oXM/QNJWdNY0tC2zGR98Y2laoTL/kRDNfvivBnRpaHfGdebcOrKhhnxUuE3Cgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010016
X-Proofpoint-GUID: B8ukiy97ucy4fh7unnuhltLuxCJRvBG1
X-Proofpoint-ORIG-GUID: B8ukiy97ucy4fh7unnuhltLuxCJRvBG1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By delaying the setting of prev/next VMA until after the write of NULL,
the probability of the prev/next VMA already being in the CPU cache is
significantly increased, especially for larger munmap operations.  It
also means that prev/next will be loaded closer to when they are used.

This has the consequence of needing to change the for_each() to a do {}
for_each() when writing to the side tree.

Since prev will be set later in the function, it is better to reverse
the splitting direction of the start VMA (modify the new_below argument
to __split_vma).

Using the vma_iter_prev_range() to walk back to the correct location in
the tree will, on the most part, mean walking within the CPU cache.
Usually, this is two steps vs a node reset and a tree re-walk.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index eaebcc8f60d2..429e314bd134 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2395,20 +2395,17 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = __split_vma(vmi, vma, start, 0);
+		error = __split_vma(vmi, vma, start, 1);
 		if (error)
 			goto start_split_failed;
-
-		vma = vma_iter_load(vmi);
 	}
 
-	prev = vma_prev(vmi);
-
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	for_each_vma_range(*vmi, next, end) {
+	next = vma;
+	do {
 		/* Does it split the end? */
 		if (next->vm_end > end) {
 			error = __split_vma(vmi, next, end, 0);
@@ -2440,13 +2437,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		BUG_ON(next->vm_start < start);
 		BUG_ON(next->vm_start > end);
 #endif
-	}
-
-	if (vma_iter_end(vmi) > end)
-		next = vma_iter_load(vmi);
-
-	if (!next)
-		next = vma_next(vmi);
+	} for_each_vma_range(*vmi, next, end);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -2467,12 +2458,18 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		BUG_ON(count != test_count);
 	}
 #endif
-	/* Point of no return */
-	vma_iter_set(vmi, start);
+	while (vma_iter_addr(vmi) > start)
+		vma_iter_prev_range(vmi);
+
 	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
 		return -ENOMEM;
 
 	mm->map_count -= count;
+	prev = vma_iter_prev_range(vmi);
+	next = vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
-- 
2.39.2

