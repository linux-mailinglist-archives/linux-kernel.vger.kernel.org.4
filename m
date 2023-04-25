Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7546EE3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjDYOMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjDYOMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:12:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A4114F6D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:11:34 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDibcD005249;
        Tue, 25 Apr 2023 14:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PlmOS/szkQ4WyeioHt4vufA0c5KhqWY6gRcjYbxG4dA=;
 b=sWlFQZ+qgJKWKvJ8tGfh+pW8GvG/RjcSdBYDhSwItekx3ppKcjEXQSJHgA7h9J1Jd8cn
 etVSO1TKCMkdfLJYb6o8cfA1MI0xqme1QNWs6SdwRtOjiq1lJnsqfYRh080koWFaFnfL
 hqEYGNmb+U0U6v+Ww/l1qcQ8cDtmmQ+nJ80Ef4ENu14CN0Az0WQvmCOVDjW1CMNblOsM
 80O5S0GyFc9plUkZKKnX3h6sLnmHf8ca7pzCpH+6d4ciyzS1+o60An/dQ6D59GwmUU/h
 +/mUy52tHjDNFRQzzPKSY4kvra9uLmEiMoXq5mQh30w30S4eW+Y4shnAxre1Je8KN9VZ Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbng8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDwhPV024866;
        Tue, 25 Apr 2023 14:11:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461crc9d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Duc0siHIquKObAEbhJEGKiN3+oqmvSqsPXpRaytDB/Y/CIYpCP3ZrQGP4UFjZp01ilzV0+EoonFAvQgpLeQ+QWHYHSetaBMxUgB4vpuT0FrPUVECEX6sIFD5GQu4jXOq71u1VaKbvPEdNe2oKau0MIKbpQteUeFxQTwpQMuDsCUhB0v1saGQhLhDhkGosfokBBouJJN9DLuHq1UFUHe/RoGZB9VqlfS9JZFpOO6fVIohcF+VJ90JcARpKcq9AqQ9XRmeiJYmvI5/vJsC38OUwgEL6CDN9mc7kBlh2gF4M2DdqRjQ0NhEliDkF2S8Za0zGrysaWFkf7hyU4orCW+Wfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlmOS/szkQ4WyeioHt4vufA0c5KhqWY6gRcjYbxG4dA=;
 b=IWM2upYHMjrwqQn2c1zncD8A2P6YtY0AprQgNlUHRmkBNc5rgjF8O6ACh1TWQS/D17V4uvzKwYvggJ1wDzYlNB//wDrYcEfNTfrPVADQePT0knpMYhTya5uipGcNYHKg7FsLb8/6SH5JWW6S64NtDcmvPDFmbJ1HSUBlbJK2V7BvGG00yz/vEvTRiPMiSYxiBxOH6J9MPdwxLCJ9hQaRGB/ug60sDi+4jCUKqWluPOzz0RKd3GkWFVTStMKJpsnmn1k70inoi3sO/L/YLyKGzzLfS9OFSipO6Gw309sI4XE6JJMBaDNAzUtrC1I23GCKEJPVlbZHUJqceU2UVKmINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlmOS/szkQ4WyeioHt4vufA0c5KhqWY6gRcjYbxG4dA=;
 b=FSHJM6h57HzUFZ9drklWs0zWsLNg97yL2mBotm2bxYxFfCkXyGioDeiZU7oiffCZtQDY/yYglWo1mtBV5zxFCOq0rdO3OZuOC/VZ6UmXpAnqqJpsVoPgz6x/HYgMAGxgRQUNpEsYsg60w2sTRNg9rm1+1YMRxlKvhIbIDmb2mIY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5572.namprd10.prod.outlook.com (2603:10b6:303:147::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 14:11:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:02 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 18/34] mm: Update vma_iter_store() to use MAS_WARN_ON()
Date:   Tue, 25 Apr 2023 10:09:39 -0400
Message-Id: <20230425140955.3834476-19-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO6PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f1e9c3-6bd8-4a6c-8028-08db4596e6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9KKxVugNrc6XiVSyZVT5W5wWVwX8l+tOYr/1+B8LNt9j26cbNCe5b/GO2eKmTrq58VK2mUgzDB1tUbUsTsoFL3GsV+aBbq4Rkg6OZS9fcXbcFoioHCBGF84dsgo5HjXDcSO+kLYJQ4Xw1iI/2xd1Lgzb4/61A0DzC0XEgnWaXPbMw3/lBX11ZpRmjp1ioQF3jVe+jg/Akmbl8VSbpNRJkoJjy5UFlxafaQGN3MC9tVZnQti5o4FBg64RhJJyO6v96MIgcyde+xC3r+HBu8tgcVIbg1Ah5lU4eY2teqZPDJlCqO3SN5/R9fyemVcjqygTVOvOcQ+naZVn/or+Mu9PhrvwJWYH8bUlNq0ZmBt6oSvq6tnPnBeUrUFDNdC7VIMERr7XDgUaeCzAhTQ3kpi0h8mF+5Bx44ZcsgtCOTEhTURi/oC+WMgZzTZm3Kngn6jTVkjK+r9JMQFwzT8NcqG5w0jpklxCkha9tL+pZ6lw2Nx45XgnzJUXFmPEudI3D8NUU7aCZfrrYz93/gCD8dxiOSacGaRZSHzq9aULj49m4iybjaP7Il3av0Ir5tEe1pD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(86362001)(36756003)(107886003)(186003)(6486002)(26005)(1076003)(6512007)(6506007)(4326008)(6916009)(66556008)(316002)(6666004)(66476007)(66946007)(83380400001)(2906002)(38100700002)(8676002)(41300700001)(5660300002)(8936002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wXkWA8QArP4h1oqP5mlHlKh1bKVSo5bL//6/3iwPovBvD2vxVI62HV1I7HJt?=
 =?us-ascii?Q?zTcdmH5aPPBopPiosd7imnB8zaeLO8gVhzGYW9kmgc91EvqIMoCjQbs4HlGh?=
 =?us-ascii?Q?l5pXh1V/geoxn4IiFXHnmBiSmyNdjWLD1pVhAkuVKprMwCYoa5fB91uD8YWJ?=
 =?us-ascii?Q?wlvF1GY35hAWfKj9o9dwk/7mp9yfCu08CSnJsu4a7Y1UPmaU7R5MhZKhyvne?=
 =?us-ascii?Q?EmF9FLdVSr0yukn8Syb/viaXjbFCsZw8W0hk02/oSowkB9GAYtlSXPuCNeri?=
 =?us-ascii?Q?9Um28iv8L0kT6aBJ8Az1vvhTWDfbq9ofMhsBCaFPF/qU96Tb2xBVAwIqbKRq?=
 =?us-ascii?Q?a9oVEZ0K2EkevrDi7KmnBBREXXLKTzUAbAobuGlOqEKa45h4jwTAU+ZnDyh2?=
 =?us-ascii?Q?yLfLJGVzUdm0HmkNLZn8cMN7q8Of4Js/ohj8n7AwedS+mV2gTWUiQR8jjQIs?=
 =?us-ascii?Q?oTJeyKVRpmD4T1zcEpZekEe+ot1i43mIapZVFyxuPl6avYNDaYW/Npguzxpp?=
 =?us-ascii?Q?akLCi6xTCh3BEfb3oMPj8gRpRx86fp0Sxih1wMn7lITwNLiMYNY8qUXkrM3f?=
 =?us-ascii?Q?8hAbh64R6p1+Z9IFXlYDRwIRojPUT0wCzssGz+jnqSXakvF0dT7rCnxhVYPI?=
 =?us-ascii?Q?J+Xc+osnQiWtrDVYL7nDYqiG9dcum0Zqb/lP/LE2OduzlQci3ky+AJmMLqnp?=
 =?us-ascii?Q?X4uR5TNGFl9ne38VCt1pdWE7rOwhPAfBUtzemG1SJFvsjXLM5lcQ7Iqr8xPp?=
 =?us-ascii?Q?M6gNGMlMS9KfINBI7WjNiY0RjhNF190mzi2l6xpmeNFp/RlX77MQ/xTUQxWb?=
 =?us-ascii?Q?K7R/StN7wZHhuT8A/PdCNG0o4ptfi+DhHyAyC9F8ge69xM2xUYncZcYLeLP9?=
 =?us-ascii?Q?E5u8+eBIA34iM9Xu9y8PTJHab36TAMbBlWQ52MlFMUK15G/Qd8ug5ADPjW4n?=
 =?us-ascii?Q?pRLvYO4BjTwNcqfaC2VdLve2/ZyVwE0je0zBPP2t4uPIbCxyaD36WUY4Kx8E?=
 =?us-ascii?Q?uqgpEu5I72ojTJNBE1UD4fkkcX/tYSOzktzHHHoWsyCICZp63ERIX8zOGQGw?=
 =?us-ascii?Q?3eWlRznAA1VSK4fsbqwcPv2zYHUx2RLV5TOnWS5vzdeTLZyKklHpSG2EilbF?=
 =?us-ascii?Q?Sgwldxgcif3nPTthsqR5DBOicE1F7H/8EaB5i0t7/9n8cxDMZNZXJg//3Trr?=
 =?us-ascii?Q?KvWexYj5Il7jJ8QZ988i82TO54pJ9jKW/HMH3P+c1vj7dsMJlbOz6RiEoIsJ?=
 =?us-ascii?Q?hrFmnD+euNjH+5/YViiz5VK6t+Fh1McZoZm0M8HaeDYUCGtuA5xWs7lJXXzT?=
 =?us-ascii?Q?ECMteuxOxAPXkn0odJADzEv9hlw+i+uIyn+L3Ert4lFZjakvtPTtxmV7wAjd?=
 =?us-ascii?Q?gF/yPkWeQ8j8dHLZdnlNUEhruoam3F/9jgHKr4T+IZEG0iymt7PGKNiSchML?=
 =?us-ascii?Q?GMDXV9/IAiayx2zYLLw6qosPLz5iY6XvF7DvFbc1l4jh4KB69qRQ3Co872Gs?=
 =?us-ascii?Q?3I3fp7qWYi0lm1Y30aBA6F8kMtcXqjacxJZFtwb1pIX/2iGr31W6W4ujTcnr?=
 =?us-ascii?Q?egtOjY/UK7FFotW3ADikcJp2sXTZXuVtdJ4t07SuD9vCb5mRHSm6zW7nj7E4?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zyk+JndoPwUW6mj1AogQQIDUDtc9JFcKADgzZFlEm/jJ83iALjVXYLNwR8KwBAwBGFtUCDrUFq4Vh/7+fE+wvHn4XE7y/X1M8rw7FmPXUuzN+2wHKpB7zS14sxU+wttOU9shUcwhHL1fWGclp6ts+Jh/jofQY4aybZyncwk4LRrih/vu2iUtQWXXVuZT+r+QQrT45NZma55fWTvO5cZkhnvjrkpnA1LQwVDHbwJl7bWgtID3IyZNLY5+J0p5hwVD1mOSmiHrMU72XYGqDl4la6hOOld5dxJt2YiEya5TFYsGCNfVmaNmobe9dzYYw3nekEC6ztoxtiegIsFa52n/QKFjruyagIKvp3tHpPPW6LEfWL9Mt8GepPEfp0PAwdhvzBkEZg30OKs6bft8ynnY0lzYzIk3EZKCvo1JPHDtTDFKXqpQc+VEnBasSjSDVH3Kenh54lFpy9Uk+7QyEq36nrAg/lSeU2t7oEaqo5mTP4B1re8SeYXfVk1OwF+h3Ey3tOli4yoso8NN4Z0BvO1tjgs3rMFv5Y7Ro7YI6MHKDUeBv+53Z+fgAPkXcdFi6YkGBvKcqM8qG0rUIeJjN7qxm8aCU55nAKm4XJcBGgnPhRdHiEpEpqSv0dE9wSflmR+nxuz0+GedB064HOVa9C7k963oJ27XkMOiFB7WViuD2yvTIidEEuI2KAAyBwyjxk+ngJEcxKPfWW7MP8miBq0PGYerBGEI83rVURCJhGYd36/ayLMEOplCAX/0W4G/6JijNtsQr30v8Gu/cMdqzjxtaDJGT8nHhZ0TACuae0P1HXsSnZ3RJocCvhph4N+22Tvsd82SWZPC55TX6pILI+azfJ/AFK/krfQjvYizrMYNQfMJl7BDfLF+THZ5j7S7yguqAfcu+rfI2nEJ79qVjkP/xA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f1e9c3-6bd8-4a6c-8028-08db4596e6d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:02.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJdyZ5pEjlo6FRLjYS77igpTZ5rH7HVUSMBqOBnxiDGE0GdXULqKiVyJ3jA488rIaH0gzxLhM/4X3oRy5+GUSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-GUID: 13y978_N0BgYI3m1yxMH7up-_yVuiL7c
X-Proofpoint-ORIG-GUID: 13y978_N0BgYI3m1yxMH7up-_yVuiL7c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAS_WARN_ON() will provide more information on the maple state and can
be more useful for debugging.  Use this version of WARN_ON() in the
debugging code when storing to the tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 8d1a8bd001247..76612a860e58e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1047,18 +1047,17 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
 {
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.index > vma->vm_start)) {
-		printk("%lu > %lu\n", vmi->mas.index, vma->vm_start);
-		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
-		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		vma_iter_dump_tree(vmi);
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+			vmi->mas.index > vma->vm_start)) {
+		printk("%lx > %lx\n", vmi->mas.index, vma->vm_start);
+		printk("store of vma %lx-%lx", vma->vm_start, vma->vm_end);
+		printk("into slot    %lx-%lx", vmi->mas.index, vmi->mas.last);
 	}
-	if (WARN_ON(vmi->mas.node != MAS_START && vmi->mas.last <  vma->vm_start)) {
-		printk("%lu < %lu\n", vmi->mas.last, vma->vm_start);
-		printk("store of vma %lu-%lu", vma->vm_start, vma->vm_end);
-		printk("into slot    %lu-%lu", vmi->mas.index, vmi->mas.last);
-		mt_dump(vmi->mas.tree, mt_dump_hex);
-		vma_iter_dump_tree(vmi);
+	if (MAS_WARN_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+			vmi->mas.last <  vma->vm_start)) {
+		printk("%lx < %lx\n", vmi->mas.last, vma->vm_start);
+		printk("store of vma %lx-%lx", vma->vm_start, vma->vm_end);
+		printk("into slot    %lx-%lx", vmi->mas.index, vmi->mas.last);
 	}
 #endif
 
-- 
2.39.2

