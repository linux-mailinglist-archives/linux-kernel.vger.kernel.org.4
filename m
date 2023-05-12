Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F61700E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbjELSVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbjELSVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:21:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF5E2D40
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:21:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4eEw021823;
        Fri, 12 May 2023 18:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=C3AbTxtdfyzVTdgMrkt+8cguGreW/PZzveEPUyUGMKU=;
 b=qXl9GI7uRcDpvpPIS9y4V0HC26ZHe941/yKegFXZSZhNlkzg7POOAWmHwVUxjAiyGrxU
 I1DuAnFNK3o8ErbdrKPFoZOfAzVlx9IRlXHVkuOj66tUCp5M3GwLRdOQ7eeRniFbEE/6
 90ivv5HDp2ppL6d68EbHgzj1UV8k+/wM2Vhv2W3rVpHXY8Gw3JNnkvVvV9eyi4TZfFG4
 3JiP9/hg9YqY6Rq9laPgOXzBAsy1MY8ai8+zTk9DxwHevIX+6gEm4A6j/e9yxSzVRTT/
 ZNq7yIEO9PL63xyoT2LdWDWQBT06bUGaeIUuE90fSRffYbKILHN/oIObm4DWga0PrV4T Yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7793gy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CHQEjF004541;
        Fri, 12 May 2023 18:21:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pnt4yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:21:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hE5dtjli1v6coEhxgwgrjn9jDB9HsLl8RIkpza09bZvEUAg63r5FKLiPSrOfutxaaMhxVMNWS0MP22lTphCnNQr+/Fb/d7d2tYVlCZTXHckMBErfpZl4dfSY2wJZSvi6GphlhSWy/em0Z8lBklP/7TkdO0cdTeXBtQ/9Ss6c0JR6E7MD5yUCwR/ShCN+zjGhur40/4UDRqhmB1v2Eqe9zG8CIpPyWGUeVHmeguYR/+bhs+PAz0eUqevyZZT0dXWIooS2jtk2FeZwl5W6RwI93lpJ9KI2/SJuUEsGmf4PBHKIeYfcs85QC4w0vPqnNdjBPz+HKXJvYj8Q73j0EFQ3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3AbTxtdfyzVTdgMrkt+8cguGreW/PZzveEPUyUGMKU=;
 b=fsJpk5C1CmRRrpj8hL5+lqCV5GjZ8FAocmzz7iRNyAYFm/Z2taMjKQtkUn3cf6eVo7jl3beSRLL5head7okLS8uH3hUXMigEn2uq7yL+TLh6BFIm/OWNk8y7FgCP0LC8LuwwOchRPnPaN3wx3ws0mRC4cU1MEO3HM1Hg9XXeQTGiRyWHE+g5DTm0O8RdpnT+vCiQ3bmgK77lCHDwOXrMIiqFhDp75djrCGt+kZwXXf6z6X622MOidWjhrWoGuCVtioqPnfxNy5+Kdued2foZcwsDkQ3NjSwhBL398errnklAJy+FtHdlxCMQZbENTompwzq9DE22VZdkq3EBEj3qHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3AbTxtdfyzVTdgMrkt+8cguGreW/PZzveEPUyUGMKU=;
 b=Or8gIF6BWJXGllovJFlOXfbGrULvUiXHhAM4J57FeExclBIIgfw7p9BjnMNeR4VHoxt0KqvQYREaqP6fuPuB6ANj36ssTNo0fxO97mBxw0MRdN7ELHVF81dzF9503Zlhpe3WK7IFntHmeFPuPHjqZZv20/EPzENG2OTWrY05MNQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Fri, 12 May
 2023 18:21:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:00 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 04/35] maple_tree: Clean up mas_dfs_postorder()
Date:   Fri, 12 May 2023 14:20:05 -0400
Message-Id: <20230512182036.359030-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d44c8b-4fc0-468c-1083-08db5315a33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLjr/AxamIRgKFL5jHVTmPIJ2X/f6MCN0IPD3WKwGxGPiglsZDvcXHdoj8ehwoJQyn568Npl0XMnfKpukgpmn+OsfRbxT8LMXICkyspFD7bcQ3nwkHazCRsUXdu9aupbfxtHsaumQ2p7JEnyAJLu63CUNX/pVfZubzXgvbVZC3qQdVYRnTO9CTZZimQk8634cFUUGlfm5DeLovCf0hhvjUstHMpRjc5nqZpufYCVJTm+FwosZVz9WxwzWI3Mlnvl8xvEC+QEZuNxOrU+Qp4JUSaVJv3NKg49TGkGiVlCCsa/88l1vc5wxU1ZFBYjd3GSs9+EvLFProa8utQIlUmzJU/dWyo1XuFFBxZQVbP3tDrykxorIM8sl/p+pHSF26Ado8/o3U/Ig/hCczvXWtobDiWgJf7rRWhkblUdO78v4duWUr3P0W0gxNB5Zy6LGFZJJVbSA+/sdPqsxrD7tLR9Go+xHzqS/OFQQfzA+gVnvQSOPeSTjZIw6u/U79I26yBqS0NRypSz6vQuvdXqTGjT35SBB3lf7VOwCaSmuicD3VbfcFqOSoFTDvfBW98t3UZt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(4744005)(2906002)(6486002)(66946007)(41300700001)(316002)(66556008)(8676002)(5660300002)(36756003)(4326008)(8936002)(66476007)(6916009)(107886003)(1076003)(86362001)(26005)(6512007)(186003)(83380400001)(6506007)(2616005)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l8X6QelMcf1LfwQCgb/9v3LnyYhFcf84zP8etX8QK+65evsmcWSi+CRMxqHY?=
 =?us-ascii?Q?pHGsWb+9jKO1OZhDGMNRh8JT1hAzO7r5x3GF3eGltIpNRFUUpFeCL4gO0q2w?=
 =?us-ascii?Q?OZMbp9dLriL+idT7dU83q++r/zpf6VH44AM2cDR3jl9PCeNXiFBO8A6fKhoK?=
 =?us-ascii?Q?E+9Ez7fcW3Zx93iAZrdc2pG/SHtQH4hGMjBYo28Jsm01DFKfsPKNW+rIKlbx?=
 =?us-ascii?Q?/+iqLBYFO3dDJKdaOc4xtYMS8y8gzQnX9A7FGVMFgHhQwhO1NCnme0XUSUbj?=
 =?us-ascii?Q?z6CLpVunOHJD8Xtp64DcMF7lrVnK0qBknc8G1zfxTbxcqrma23yEyknoWPE7?=
 =?us-ascii?Q?pXJX8tdC/CX8jAYgep/+2Ci7IZd7UdzxX3cMWmzddhi5iMuP7R5SiFaTI9Zo?=
 =?us-ascii?Q?Tetdh8DxSQ6iK68xSQ+HjITbxnjMn+cCiMMDoIiMOu2zv8G4T4pBlQSmUJEg?=
 =?us-ascii?Q?I4YPKg7BELcSqN9Ar8QRj9ypV5w1Tir6zPwPAItBkwnmCTrRYv+stS67amTM?=
 =?us-ascii?Q?kToVVMWB3T2EPD0sN8vOGM4UbWRlKeqP2gDixorHPqncaQirupMq99gnO7xR?=
 =?us-ascii?Q?gpeot35J6d2Q9dba15iuq+FlLZJ61ZSwgUiLpAwvRsGoZwqnLMsaPlUHhb/W?=
 =?us-ascii?Q?ZOlZf0hD/cLgAFhEAePI5NRpvzHApPXA5ruKLfphdAQv7e06hnvkr3RqFTfs?=
 =?us-ascii?Q?t9du1m50MHfAwf6UZ0uC3xbVH+nB41sUIPBHRZj/P1FWgw3+8bKzIkXHVdRL?=
 =?us-ascii?Q?X8LfpEtWzKbiE119nKzd7ow4J7Z5JvygtJQoZDos9uUP6/M1ky/fcqM/APPy?=
 =?us-ascii?Q?IwV3GCislf+Yjb6tjy7c06kOtWe5RkMPIUHpQUt77Ibg16OEFfHx+NgBXJeX?=
 =?us-ascii?Q?fa7EboN33uicxZioNBC5ArKrC/3d6DahwQcUmTd6yg9quUihnpBnm1kK3K/J?=
 =?us-ascii?Q?7sTnRBApby1zb/wyLidHKsWMUrfDqTYPwxVah0XSVfyQQwA7Z9mFOtXGqG4S?=
 =?us-ascii?Q?DxeeieWfYb52BGWWGauodps4kVfGm5/mZzPgTKbqRiefaQPwv11djO0A7C7x?=
 =?us-ascii?Q?4Kew1F3dMFV+wGrhcVFE8qDVXZar1l1LUgj36ANyRzJ6+wpjPpQZke2PBEAi?=
 =?us-ascii?Q?ELoXI8iAwsfK+F7GaZSJyDo9cBE0rckgJR5CxWjcFMw98yzqExUGYKpQKHYp?=
 =?us-ascii?Q?7UpaNxOWjbeIsfB8J6v570NVnrXTkzWwd7OwDktHkKdvC5gQGgBnRXAqRWLT?=
 =?us-ascii?Q?ihDNIjJ9mAJiSiNCM3tRQ81hvIRoVv6kN6ZJTMB2GAPBCe8gFpDZtsP9UUcX?=
 =?us-ascii?Q?lPF9ZVnFZz+o27T5xCoqr4ZgKJm8CWn4gRbvH2q+QPNL54Y1C6HbDMpEOPJE?=
 =?us-ascii?Q?fImGxvWFhClQArCbS6o3SbJnRsko2dARt4HbV2QlJxyOFwnir22ex1EeRwiR?=
 =?us-ascii?Q?MwibguPdDay8+SbUc5fiDH9oU6zqouK8ZG2qrxqpDBM4oN+EajP/XFu/jRqi?=
 =?us-ascii?Q?ZN+UJje+ZEl+IT6uSNn/+m/KdYxHJa5LktEIjBTEgX20/8QeGXCHnYowYybD?=
 =?us-ascii?Q?QvxbLxIn7VzeHQQX9KL9u1w+/SQOFxybs+In/geLyqSVtF9SRucwZ2RX4zcT?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 47zrvRpNWI83SbFrTj8fbJ273AqKwfvmVZkkyJ1d3Qe5a6Ci72gYvlNrN9UH2NeLaUvHXp6RS2/T8kxuFz6u7XTcGqQrUXT4UUBGzI35zPSGBr+pA67s64zMIHBx410Hvvw3av2l8GbmIperS6Y5hRfJEToX/w3tkSduJcV/ymS5WobvS732M3uLICFUoFUeNr7DTzPLrQrYQ61EyLfGw/80P/sznQ3Fxnulqj0Robtcy1hkBrIFSf8f2VU4JVhmuxBtqb5be2W/05zNnwUJd8/eIQgiGY9UlPX572IYodA7JgTM9u7ZBL7uxi351DLOQooX5DM9ZvBW+Co8swf3nqi5UDHx5IljkAqHbSTlcpmxJsTLo55Kf1w8kDRx+okkx7l1KvIP0XDTpiAoty4JmLpiKegPqKMe4SMAG6VPwgOhpZD72Sj6+fAUsB4P641wDt36lszko7DQNl6664uN9Qd9wCtU5oE2gGUY46W5GlS3amxROvs/RMJrqtkOf0TJod5Psqx5k/F3zuEzxsG4A1HbWRIubpnhC1+JVWpptUtOaN3xvF1djJmRCOvAMCn47fpPJB4wPUX+MH9IUvULd1dHeirW4/7FIPKL2yDGRxl5kt0hmesXZ63VDp9BaOLUM7aXtWA7ZcqS5c7DO+jaR21elXW9wP8IQwZbBS6VWl8tfKou3+joV+Tv9VgSVaAmVkE94HyKZLJmXSwoLGEKSR2EGplNEQ4Uc73W5fhb0R8Wz7Elu21sS8mNTgv1CakeKHEB2bck3e5C7OuBUbbWRGxTVpqgzuOc8tdo5scetHliexWf2gJW+nINLMd77VMDdQUzLqUFyJqITYTsZ9YKiIaTecY8zFEoB3fo0h0kP0+y3eedCiVQHkOOO1BgoXzXhwjkHP5o0/pjKuH6SA8HqA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d44c8b-4fc0-468c-1083-08db5315a33c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:00.2232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBG8Wqdk+CAC0C5O6w2epvuDhEbQ63esyoeiJptX/1g3uG8mfgZEesohwRdB85/IMuDFa48TBWmJl6/9vi2pYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: pdGR9WO-QTcOnBwEEPmPwXTzEYM6S1jA
X-Proofpoint-ORIG-GUID: pdGR9WO-QTcOnBwEEPmPwXTzEYM6S1jA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert loop type to ensure all variables are set to make the compiler
happy, and use the mas_is_none() function instead of explicitly checking
the node in the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5b29d5a916f2c..1e7e7249a0cf2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6739,15 +6739,12 @@ static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 
 	mas->node = mn;
 	mas_ascend(mas);
-	while (mas->node != MAS_NONE) {
+	do {
 		p = mas->node;
 		p_min = mas->min;
 		p_max = mas->max;
 		mas_prev_node(mas, 0);
-	}
-
-	if (p == MAS_NONE)
-		return;
+	} while (!mas_is_none(mas));
 
 	mas->node = p;
 	mas->max = p_max;
-- 
2.39.2

