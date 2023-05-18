Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156F3708529
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjERPjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjERPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:39:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF80D192
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:39:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JDRa018326;
        Thu, 18 May 2023 14:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=D8uB8KFOovk6IU0Nv+WqVCZaBG68SuibvA7m5a5k7xs=;
 b=HkR0/2957VGlci50qaSVyHn+h+eQ1rdxvh7aAvEmJ72jN+PvU2bGrE0NQL48wD+DZdt8
 SEjdyX7mT6HAce5FkW0tQUhoEB3C9OzPrC88bZKkZplKAb1UDBMdJDG74luSFYXyM3Ev
 CxKQ2H3X9XXfjV1Mt6QjcxPU45jjhWDdw3JzCmvp6ATlJcZvQpdDL0/xre/Ffpq6AiYF
 F21UsZ+JSV5OT9yQnC2fd+LTSrKuPsKR4dhBqJKlH4aH1CUWQhXGcopzY57hJA3h81tC
 +XWMCAIUqD1YfzCqJ38tEwV/3IMXtqXspin3/LIbsWtOpUfcBgfYSF1PwQXh5lHPKyar Ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j2vn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDjxeX032141;
        Thu, 18 May 2023 14:56:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10cwr04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzhdmZJ3LAc9RQYBSxi1SfVPEpJ7jGb+AIaeBC1QLbgE7FYMgq4PPFcgiGRkoZqVw5XlAwbAhjZvI4lue4DHaw9oB+5f2ZvVbeYB49/4cB09JzdPJznrBAlTIfw7vQh7ewd2RJie5+XsrbldqdXUsWd/uwXC6mYPa9w1I/rutPFAiCyAGQKJkShvSNRLiPbSQluew5jR6NdfuKhJAjeRz73NNM8ZejDqQFDyufiBxubWUrgpRVs0X33jOp1EAz+57dxr7Hx14JVUaF9cdo7+9ABOzwBQaLb45jAyX3hK+d252JlQFXgeNL0RYaBdpNqUdI2aD19Upcbu2hZ9z0uXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8uB8KFOovk6IU0Nv+WqVCZaBG68SuibvA7m5a5k7xs=;
 b=YaEl8Ca4Kf11o1pmj47ylnHPL4hQB8I+i+N8OvrOd7ky9MeWi+mLxnKf1d3qlu0XT/8WaInED8dNL3A8Y1CPyaUr1x/BbPqRCAzJAYH/oykIqLqOcft4/QRoXlr5AzIOt9xFD1Y7TILiu9VGxjtgEzrGuWWf4CjRaH/9wR+SlYd7GJqFIlD0GPJmZrBmyfgHrDuU/Pdmykl0BxxvH9BLpe/1nw5XwlZ8IVotGuCx29zvNjVnNbK2zUeP1FeliAEy73vas+ao+rELFQeBsvLgMYCQz9I3h96wCmC3EK9RCbApE5bL0oqi0U5JGDDnQr5czeotgFxwrQali0Dxn2GiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8uB8KFOovk6IU0Nv+WqVCZaBG68SuibvA7m5a5k7xs=;
 b=hd+SNp2TgHsjArBrs6dkY/89yYYzO8FSf1W8s/VjTD7lF1iObqzcVVwVGclCQwg6PYEaUAQZHCmJK6VKDCn1NRv2VaSOw6NU3gD2Y+dDaHVsHZmZrk+AACONmsWvZ38ZXFtoYClxMJm/MC4oYcJDnSor1QMJanSomJXthZbhwjM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:55:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:55:58 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 04/35] maple_tree: Clean up mas_dfs_postorder()
Date:   Thu, 18 May 2023 10:55:13 -0400
Message-Id: <20230518145544.1722059-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1184db34-e5e6-4bd5-db9d-08db57affd73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvteokC2pLglrru80UJ+KbMAcj7Z0p3STLAaIQ+Mw5xWimA81uHcdPZ8zqzaJ/DktMINJafJb/GBk4EH7+o0bmI2uglfq8JO5umHUPZhyB5m/+fqqXIjQQDGxfNRq44IVCvaDFlYGMcFQry9V8221RNPJ+gBydJsLO2U15VP/q36rpxfSwp0fVUKNOKEgs2wDXRKNaCblKRG17xabW6u8D8qTZKU8lzmj6/aSNDhLVE/bp8euVbwQrLPB4JaA8xZjK298923fe8RqufO2TKXPMQGDwLQ25IITvIYpNZRscp/ty81ab+6X8MNNn0wa060MyMnfdn2i5FQfnTlcut5RhjexJiUie7meeoksvF6vUHGwRySh5FFfY51AypMUPWXa46hsOWF4L7TvDjnH09Dtmk59/kTtHCylyAM5SsCXFGXztMc2gwnghbkOJ0dht8YPoCQefCobNJxGsGlENXFmx7sf9H09sHZ4InxEC5zWpKjClEU9jIZWetygZhTN/S/gmiSYBmcS8uJGFDg2hNKvUQJVu4fK3V52LGwUG8YJ6omk9ls+6G+R0CT0HCP7wN/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(2616005)(4326008)(6666004)(26005)(6506007)(6512007)(1076003)(6486002)(6916009)(66556008)(66476007)(66946007)(316002)(38100700002)(36756003)(186003)(478600001)(8936002)(8676002)(2906002)(4744005)(41300700001)(107886003)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e1weNKLKgppj7lJsrn7QK0hq13L+8ZRy8VgCwhyS5duG/B5I7eiTRy+exgb0?=
 =?us-ascii?Q?JVoVK6dL2qbBiDiC2kum+aqwRJHaS5o6QLvpaWuhbdEhh3sANNYGsv3Tl+rH?=
 =?us-ascii?Q?NfaY3MZjksDBbw+uGAde+dBwx0wObi94P+eM1Yw1juc9yIM4zyFsVCTIbLeN?=
 =?us-ascii?Q?xC/yT7WV4woqQV9YC3iK4Yq/GDhpKBkoVp5ogWdc6PMEWVOGy4r+OKi1dOAP?=
 =?us-ascii?Q?gKiDnnKr83NQ6p1waznAGgEFnWe3d7+iT/ETRCGqUEPcqhiaJjHqgW7A2f0u?=
 =?us-ascii?Q?z/8u1xiQDIyOIIZrB9CI+6+XuvHZgQ5kJLapKA4qSsTcoEZzzmZozeR+uhqc?=
 =?us-ascii?Q?7dzYwmfoD1Pli5bqaUhrP4GENWx/MEkcOgpm1lUHnsw0Uc938mhXtrek3jLF?=
 =?us-ascii?Q?mnIYbJDyNxHyXqbW0RCROxfSfYY+9+CNqecy+r8+b3In0sz+ziPT24sg5xK1?=
 =?us-ascii?Q?ysv1r6bNh6eGi5WCDbcQ9UW3YxSsVXY0Ahok/vqTMDHw3rfLOaNqvGtvQLnn?=
 =?us-ascii?Q?PxEmM9vCBR0UW4lVqgd6zz9srjI8NFxAWNDUUNuVtteTTYCIEtq5+Mol1rvL?=
 =?us-ascii?Q?rGNiQx1STMGmOggxvuI205Qgl7kshLkLNZ3eQrzY9aj7lNogxJ7x9qTbupkU?=
 =?us-ascii?Q?Pa5gr8DSH569dtma2fPBzUn4euceFkW0sF3WWBI0dY4cu1G+2NKMP/VtyukN?=
 =?us-ascii?Q?cok8SyFIrVMo2jui6YsjEbaWDKoa8BeIEgNCs5xlddk4Fq4ESt1H4lFsKrH5?=
 =?us-ascii?Q?ONmNg9APgoetF8YzQ0ovu4Hq6/gp2F+eKtDCQ/c10MlYYhTHEM8NSJM/iqsr?=
 =?us-ascii?Q?NOHU+5K0d9+kld16FuWAzw8123xrXu+aX+dgxX1l8UjyjRT5WtFz3mkF/ozP?=
 =?us-ascii?Q?TwxT0WalUpvEQJlCvXxhb4psBZ4uAskkuRF4/guVJ889LHNyF3Hvshv/iqzQ?=
 =?us-ascii?Q?iqf8S9RRYA2DMh4bmpsLOIRGWJu751qDCYIXqBtSU6lT3R3V93nR5NKR8IBm?=
 =?us-ascii?Q?MK08m2i2CWVtovDCaxcrI7iHpq5jRXYRCyZuGUpxUV4Jh5dkGrMWAdJUXvZb?=
 =?us-ascii?Q?Fqxknd/001Fe5l6kv7GioDSep4L99Ro1ppcPqMyTsZVuypHpG2xTBzKKcf7j?=
 =?us-ascii?Q?EGxP4pl70bKYpkyC0X88/yWCCz8mg6TPJMoFuV+7fOumbtKvv9dKFPYqCHT0?=
 =?us-ascii?Q?9a9J9XeYAZgeUqiJgivuAcC1JIx1uT2Gqt9ThNWC3+2cf+p2NzeNL3HYDrY9?=
 =?us-ascii?Q?lm0Xqo3lLzX8WM3eqZQQufMNQzF3SP3MSqPW7IBen/E3bft1bxFUJiDWlBdh?=
 =?us-ascii?Q?N5ZdwXoEdOvmSPDQbfBWvMhs8dZfVC6M2LGPXUkUtnlIgG0/jRVwzTzD2TWe?=
 =?us-ascii?Q?4nxDL05tu11U8LQnxsXxHPTatVbPAmXPOULmnKhhyLH9XH3aFFh3fKIlJ4CT?=
 =?us-ascii?Q?8hK3l07IkAYzndKadyTizHdw/J18mdTN3qSzWZGJunK74jmbNt3CUFJtXnv0?=
 =?us-ascii?Q?3v4ImysTxJHlwKuVknN/zhhmAEw0BF2X5Qf0P4C4aiGCX+SlasOs9rK9xD9p?=
 =?us-ascii?Q?yTPAHSAhlmKihmYgGhRy5pvHJdBuxibq1daaD348SbYEWLdy8bdt6Peg84/D?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JGC5dcW9CzcHNXIgSx1/setwd7iHYuSr9Jny1rZh2UkEXLLnHV2okAGLrC8mOeRPS1tmt8b1es/A/u7m72j3WG4TcLdHtBpOBC6IZsQvJ6nldG2Hk4zmEh0PrBYD1mqetb/ZpM/VQMrdnJM5q0OVSdaRSqUIOs7lfi4tK2YuoNghhGQPC6Hz4mrdHfYPUWBRMSN1Df9tbmNHUwfhxc29SPb4l81uBSIt8wI9C+wdSVkCM5IglCcPv5ybX0VTo58FmpoONgPWQFZUdCBsBX6656aAS5iyj9xVueyXCIPfS++/T3ADvhJ2u1mGIureX2KaQUggsWBbJMa8MbGQay656EKxkneZ94Ajh9PhFH56PQYSE3pqh4I9GBVsJAqdgqy+9x07ueOxCUKI5C4XkTGwUKCp+XC8ZDZFifnn0vQmNGJa29W135chbH0GNUcIDAF+vPj7p9n7s6LxxTCCE+S08yqKApbN4U153MFvckgIDUE+Hys8jUlBhemyByEugwRsPyw64UHm9dN588VQV3W6G7ztM55bKSQX00+h0jz/owqYY+zHeEDEPz7SehXa/wjH9F8v+LboomE9ParlgqWn/oiuR4EOXhQQ6U1Dn5Y4gsqsFB8LeK30iWsIyIR4hE1/whnz0OF3iWARj2Vq/kLEOYA/i/7zJZ1s9GtoT+c2uRzA1naFT/ftUFbpfuQH0uXOgKj/yu2khtBI9Ndr3I4uXgHTvVqhqN2naZlxWSN4xhJJd0HkebUZpWnfGIscIGbV8joAEPxtmdQLdzoUAo40I935vu00RwRmacw2/0BCZ7SsmzMpw3ID+U0Cnk2AqSevQBanfLl1/9+9D7ReiR5DXlX19Rh2tTWPpwrxx9EAc86Oe9L0GDBxuu6Sl5S5Vwr63WWYs+GgOP25ENvFM/PBPQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1184db34-e5e6-4bd5-db9d-08db57affd73
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:55:58.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/BdJU6pbhVPTwS3P+yUwUxcCs/I+fYrpO72xrYC0QXJMsKUYGPTt3VsD0OIz/VKIdjk+tTXb/buNB4yaKU5ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: SVv2g6y-nAsZHtPhTXCfHfpPbZIoebV6
X-Proofpoint-ORIG-GUID: SVv2g6y-nAsZHtPhTXCfHfpPbZIoebV6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 5b29d5a916f2..1e7e7249a0cf 100644
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

