Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA16759EC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjATQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjATQ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:29:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A910253
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:28:33 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBbwf003319;
        Fri, 20 Jan 2023 16:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=mvMGssGEYPvJ5KU/V0bTBtugeWrNBGbZe4Gk2T9rYno=;
 b=CqS4l5aocyyCQr2N465NILACzxaTUaSrgjvXtOW5pi6Ly7/X8LvUet/SaeeUp6R5d5oX
 /LiFFWpgd5mmYEjeSh3SiDRd2ugDeB4KgD+/FU8m4yJnnkpzerJXxwhm7XEyrNgC2r7D
 7SP9iNA7lyqim2Xzj61R2qLp03PZJ2KhHU1Y5haNj9t0JgGCTmu9jHSKTBzM3YvUEMuV
 8Di4CnE+enr+rLOR4iKIYlsA3VIApag3bkWTfC6WGhV/0O8QCDDVo8xDBu063oWyZpuc
 oxuuuer/OoUl/zEJvrrr2TTe0UvvTMtRPcQcX4nygQjH7sBVzzn5jMfH3eeb5GG55YfE Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medn7f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFNX9u018804;
        Fri, 20 Jan 2023 16:27:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quj9ynk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGmcfHGmNmj74ctpNx+d/8HcYLpun2yzNMVCc6NbzCtQ09czyEJz5XIxn8fjL46m2ItogM/oxl4QWPEmAf08gjvlZXT6KQPUeI1asEklSLF7XB2G+V3n19bohMC94y4EysLvGvDAOiwtCjxC8e7/7xoIb45KED2ssAzYCE7X9Q68zValIGq6GfWY7NOyRbtcVeU1cbBKHBqIwIi6qEessKf0vXWTukk35Kl7E3xtxkHNDX7v7zRPV3I/y3JdXriEce4rSvfRpAT6ukFFixIPWhrPoVTzbfw+8E9kLsmfZpTJ+JHwp0CyRK65uUEIHWdraQax0CK/gi3UQ5FvlHmeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvMGssGEYPvJ5KU/V0bTBtugeWrNBGbZe4Gk2T9rYno=;
 b=k36Ak5+X/hSi4/wQz/JDPdwOML/ncat451oOVqv34OK35OSpttqtHBULOK8zb844cO7Ml4YFw8PY/UmE/O+6zzNN1wIeUMOhWlTbdbyWh2Ue325tbTX5Bn2qgpuo/v8nJ+InbKi81sz+fmbPjWq8JdVXhIdFTXAug8aeGvyK7P5v3wvxMzi+l1/9wCkBdBusqO1FEdVIE5T9TZB+Na3Zff6SUUKp2fyBpzWoydkGBIZcriixYqPqqwULE/LGq6emNjLlemLeVnL3MGEZtLU+xFJ1MlWXsgv+WmG5OiUWNhCOPBscZsCR1Kc+Ge9yhMulOFRG9KUQzIa+3XbXahFqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvMGssGEYPvJ5KU/V0bTBtugeWrNBGbZe4Gk2T9rYno=;
 b=R3i9l7evgHKerkBo7n9sL7TJDhksGLKgbJwqp87WUGDpdzZGki87tvFOAFXpGDsAWQrqHHPePygj/foDkUL5lV2jQIWc7+IQnpBEsahHoA0YPfK0EXEic8X4Oei+hLgM+vgOeg701/8JWTInj/Z+b347+NlUZAYlmRUiuKIkIjk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6619.namprd10.prod.outlook.com (2603:10b6:806:2ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:42 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 13/49] mmap: Convert vma_expand() to use vma iterator
Date:   Fri, 20 Jan 2023 11:26:14 -0500
Message-Id: <20230120162650.984577-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 39632f80-5f7b-4e60-9870-08dafb03413f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4f7osJblERjIU/YhjawrJffF9Z7sJKCv4k1Ejp+7Wr+7M2/58u2+YCzS/94nVTw44mOfzU3lUN+EydrI5G7pb6SpRzHgL1ZwlFaGJ77gP2eue5sCtO+Ck7v8L86q/O6cUVGCEem9WzAfy6yMLMjsdWoQot9B/UqTCZER1AEDlzQKVfEgzhf0ejP0ObWlk6B/pX1pbPjYYh/wkmqK3405JHFYNdmwNfYTnYkzvfCmmx20ed8kI9ntgjBQiSh4IW8kMI/B7smT/sk3VrQA+wIVhpeNGGxk0Ri2cafiEGCcfgYZA5dvjFVFyoZNU00lXxG3RDsrfJnWcUedSkvYEwbU7mCwJxOX4zm06pnPdsXyXywHxJYPt3GufTaQyb1LwG02100fCrybhchhbaxs0k/9CdS3rh6qaqq4BAYzfjW3FbITWKHqiPUaKhFLL7bybCBdZC+spTO2SiQntnhkzdUKhNl3n5wNvyyd0Ykqojtj9yE2L8J+jVIn2I2YfXGg522NKC5cx6uJHYw7eUZUasv2WcGzTkSgNkbojI1OvbA5UvAMmPM6RJKPwg5DP4H8bKHS9VCKeLUIAyFpyPUNkQEPhc5BpSVE8mqiZaERc0gis7BfKGTcUUR574UHMhOR+lkN2fKInQ+lAzLDH4/qCP7NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(83380400001)(54906003)(86362001)(5660300002)(6486002)(2616005)(38100700002)(8936002)(478600001)(6512007)(41300700001)(2906002)(107886003)(6666004)(4326008)(8676002)(66556008)(186003)(26005)(316002)(36756003)(1076003)(66476007)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f6cDNRwmI0a4Lg+BJvw8pqvoDIIYhAfwlWE7tEYAjx9qdak4Dosx5R4B8RXC?=
 =?us-ascii?Q?HNZ1effBnwCuGs+wLAgJoG6BlJEkFZriegXrDfRs2NWmJlvvgRYHZ2/Nxdd3?=
 =?us-ascii?Q?bj4vQqvzepYQAg4Q7hBpjWtn7SSoDLRd1jWkvh/fiIcOgjYYHlcstF5SZK05?=
 =?us-ascii?Q?I+uoezhYb1keLTPHUVsxLSWejW4dr7highERGwsWVFET4AIWqgmgP7ZHRLgV?=
 =?us-ascii?Q?hSVOVw4x6ijqJptiQAXn7OdgPeIR523t9ezGLbhW/DgMYegwvnF2eX+pRcjd?=
 =?us-ascii?Q?m/QljMXSo4q8tJvdbU4BrR5zMnu4PsfZZtAMXLu5WjU03GSI/4q7nTodScIM?=
 =?us-ascii?Q?AU8SO+/7pJshdrRwbUztjN5z3z8Uy7vIGsovwdAS+xJ39dNs7ATu3JACcwGl?=
 =?us-ascii?Q?QGaBtop/xqH7s1OJaTE7BhVMv0k8vUMtY3U5MmEwGclfHie36HrlSvuujv2u?=
 =?us-ascii?Q?RYoLsPSrtm6eyxUdH5YYYChJ2x5NTNcr3NXEmyapF4QHi2LOdEaqunwOFT/e?=
 =?us-ascii?Q?RNOj2L9gey0t2A/zrkRovwgeQZNLzU9Hc+37tmY/01N8fB06bKKlaTEjfHke?=
 =?us-ascii?Q?lKHA5NpQY4UrukPV2Hqd5aWWT9iCPIXWIxu0pNMwzYFxQ9Z/i0wA2W6w88QA?=
 =?us-ascii?Q?e1quNyix8bXoFfow+4/ROWxPVmqgwzA/LZv5aycGQAO3wDycj0ZEwysxqTOM?=
 =?us-ascii?Q?QuWar+pNRX+l9ogXxuJgmITttnGOoJpVcjoEkNher7pob+TUu74vRv79WM/G?=
 =?us-ascii?Q?obDCmltltNL6ds1YEjgwSv0afnuhl0aq2s259SMbFn95g4dPYYKxkI4hepRq?=
 =?us-ascii?Q?cgvHAujhLp0umFsupFokUlWslhyoClmqunHkQq0+C/knihpZHcjKCgZZ4yGS?=
 =?us-ascii?Q?7Grz+nBDWyYhVrLOV3c2YCiIax9CZ2Jx7272teddTpPkmxJDNjazx7w5kaH8?=
 =?us-ascii?Q?AHyh8waUO0cT/q7l9zGl4M9Ijox5umSO7LDZsRx5jZXW/B4QvOSHrv18XHwV?=
 =?us-ascii?Q?WBCH0d7lie7b0JvircFSUu/rEpRW4fkS8Cwjap2RLxgIpN07auOasx70AyAs?=
 =?us-ascii?Q?xQfJb53bveF0HFEZm5WJsPNvyMtcGxF2egvtkIfbckWae9JMpfOYIN2GD0F9?=
 =?us-ascii?Q?THe8Baw1y6iX9Gs6SoebZlkrtQiJN7Tyf+UTwuz+YDUifIcsPusKge6JPdJU?=
 =?us-ascii?Q?GVBMIJ08xk4o+mOaI2L1iGVxKrONjOmoCDWcoGLzS0EZFuk+CIo+xAcKX3XR?=
 =?us-ascii?Q?Q70f96BwJa3XXuI4iFNgLBa2uXnxfjnwGGblwb55NRe+qp18vD2yxBZ6tj6R?=
 =?us-ascii?Q?BKUvHFKxNJCyksEEoQKXEuRRGd6RVLnIMSEy5j1RsTH3e9pG9DJ32Bdddbff?=
 =?us-ascii?Q?amUKgD6WlluFoQNTawU58/vlVgt9hGBYRhfJlGXCJvom2zeUerMl3KKEX74x?=
 =?us-ascii?Q?4pEhPbKoX12pPlhuosrxhKwY95IcMisPJaefBIjIC3W9UcVg1SKyrryWGFp5?=
 =?us-ascii?Q?+4X5Q7ZVQCUaAxEv/hewT8nQbVrPchjc15SABB4PnklXcwXCbgT8SmqjdBAI?=
 =?us-ascii?Q?0oO0mwDNrpbURjwtXG2n6tPrgaxlblUFbbnWK5e0/4+fcY1yfpqk05BiveOA?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jRQ++Hxi+Qq1AwEOaeWYN4ImpnLAAb5bSyrwVZszDdJcWvIJvFOrEnUT+DAC1QrdrDzpkpnzRX5E8StqfWehvzYa74X380hYgOR2rM0UE2fZ6ub7K7wsjXOD29LixsGn4/xTAtx9keuJY2RuOi+DUu7ISuvX8L2FgJcjfrE+yTr138NcdQV5Gm9L8Dhmiwg33boX0mZEV2RQEEHBsBpYd7fkZQ9LZ50x8kg0Qc5TLpv5Cw72TXeRkyT2oDqMMWE3pBaNaTwp8F4rIQnR3RwlHJvoVl0zB6moHsaFOMdHKYOC/CQlt2sjDQyA1i2BrboTI92nppf55TV4SnpSkh9E6T+eDYEefR0n5ZM4CRFJdkmwICkzLjjj9A77QPyNI8CyROM588TvwWzMZ42qUtyDt2zkPqSNoMstj+1pEWfuFARMTplANE/3PdIEDJWfXaxaySJXzbnaSmSu3D3ByR7YjVPwQyqbjf/4/amvgZ2jgmt7++rTGYLBt7WI1kzl/SKB91sAbC0iBZZa8urGlJ0PwkofH6YhHeTVZdKk1Jffo1I1BMSS88BTB8ysh3KFci5mhJaT5SwWulgiYrQ1UtjHeOc3vVsRoGUiNgyXLx7Ldr/o4WRhClz+wfqZVKgQ3FV5LNaaFNSRlIlr2B7ycpoQkUp77/8xmEGH9eROUljoduBBTvgayCnsp1TCoKWcgmPFQK/GVJdZk8hiVulCra659j/ahk3NpW9BfmbfkZm21U3RZBjnv7bx2qZ9uaMekUAdAdIvYG2cGOOGo+TwA/z2ixoZEcJrSNzaAec+1ABGGQlQvhvl3+1oMPndo/tIJgDPgIEEgpYhOTaEPXwmu5oB7ZW9yEOu4qTKsdDdFSzzF73hHxH/kD3TWD1rHFQuZexbBPbXDNMwcs8Rq1CW5fQPEQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39632f80-5f7b-4e60-9870-08dafb03413f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:42.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 920xUNrellIVqZKpNF+1+tJfc4vidy8xFjuR9eAO/kqa+wPwyTZtKnOvqhwzKlXNJvCUrNF5opcGTR3Nt5960A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: 8jQncsdDebilWSu8GEFcUWnv_rhC7HP0
X-Proofpoint-GUID: 8jQncsdDebilWSu8GEFcUWnv_rhC7HP0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the vma iterator instead of the maple state for type safety and for
consistency through the mm code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 18f5f71a9202..2ec671a119c1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -527,7 +527,7 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
  *
  * Returns: 0 on success
  */
-inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+inline int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		      unsigned long start, unsigned long end, pgoff_t pgoff,
 		      struct vm_area_struct *next)
 {
@@ -556,7 +556,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 	/* Only handles expanding */
 	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
 
-	if (mas_preallocate(mas, GFP_KERNEL))
+	if (vma_iter_prealloc(vmi))
 		goto nomem;
 
 	vma_adjust_trans_huge(vma, start, end, 0);
@@ -581,8 +581,7 @@ inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
 	vma->vm_start = start;
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
-	/* Note: mas must be pointing to the expanding VMA */
-	vma_mas_store(vma, mas);
+	vma_iter_store(vmi, vma);
 
 	if (file) {
 		vma_interval_tree_insert(vma, root);
@@ -2600,7 +2599,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Actually expand, if possible */
 	if (vma &&
-	    !vma_expand(&vmi.mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
 		khugepaged_enter_vma(vma, vm_flags);
 		goto expanded;
 	}
-- 
2.35.1

