Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1A872D0D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjFLUl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjFLUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:40:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911FA1718
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKOQGg002209;
        Mon, 12 Jun 2023 20:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=566WjR9HOsaiTi90oG2qxgL9fq1TpDqi1DBa3zdZrq4=;
 b=s88SGnntgJmGn+MPF4muwVC94AFY2YTnhmSpHciXvH/IZmaSbcbUtIOkJx9Th3RsKk7b
 3wKDkFWumq2HLXT+lIGJxRJaJw33EHXkbIpJj2vBxl3fAblzUDywtGb8TTnK/eDc8sxS
 p8hpvaZXfxB1LqnM8P8tEwBqg7OUOeWNjtrkHfJBlwG82ylGNoqC2Dl97LjWpQV9RtC4
 whQdtlak4MxzMcyobgYqlVTUdzDmu/C7zcTVtdIi8h/5vzGPgT8b5HAekU4aocYVGGWI
 AWnp3qt+mrHKCDmE9aPdx1+6wdH1EzYAwRTntY8wthCF5tz9ZNCi+McmH5c26Mgke5/b iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqukv5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CJd8Kw014064;
        Mon, 12 Jun 2023 20:40:25 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm31597-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 20:40:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hm2L81BeB3ccBfsgPP8tGY36kwj2U9s3v9SlYSunHcTJmN8AYFbiXn6lQmsh2Vqd2XyEGuT1gtqqAvXJGmgVEQfWNMfXAwI2j83Zi+ULCDQq/KZ7WfduOOzCiKzwoNLUwiwhu7HkeVIX9ecnXyTw8ZPiODbqI0dOU6YBknRU9i2rWzCm3n3qPs7kB/NwF3bz49+h3HjvfACobCMuF3emuXInbr05QmqFiYdB/tmZ45LNsIYFmm+STBhKG/tE7xhasQ7134KXGqHiLPA4oanyGrGo0z5Cw0RGOr7PMiUQAPqq34sbUnuGwt5tsXdpUF6U2FfB7lLUwE0vuGQy+Mugbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=566WjR9HOsaiTi90oG2qxgL9fq1TpDqi1DBa3zdZrq4=;
 b=kbTt5Wj12Hh33U9BzQ9XHwp908EVbSH9vMtCVpwAs4vtebzvpQsP8GZp0FcupWOcjanT2UTq+cxQFNev1wWUhQn2nZwv2hJOQLNvTXzH/OIKNCB9MkHmBoUEAejUiPBcLb+oCjyh0egeRFG//wT95x83bImKtEEB7kNJ3wQmIFHTpbjvVg/lYH5VlD1A7ZKDeWkk+rvhgdBMy1gShnrZ146rdVXNWQwoZgX7NUNZ2nBD95PqhAlN3CsVqC1da8C3p5ljxaP6lOqSAI68dOAG2AU0gfp0iUg+D2AjgqPJ3XDK7dgU4itHAiGuv8tgND2xgwqqyVtTgMc5Yqp7kh+1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=566WjR9HOsaiTi90oG2qxgL9fq1TpDqi1DBa3zdZrq4=;
 b=O4w93raSfb3728A3uCHIarYUMVg5FyAAEDXMtg0R7BIQyyAJ80WRi767YwmnVXeeaCFQnF+KSs9mR/wGv54gziZVQ8QKdMEZPv2ALZ2HDZ6lsN7xsHb/f6gX9fI/aP776PgswQSH6z6EoYtpPuZD/dU6NpDhYXLqCSqq6FcY5no=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 20:40:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:40:23 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 09/16] maple_tree: Re-introduce entry to mas_preallocate() arguments
Date:   Mon, 12 Jun 2023 16:39:46 -0400
Message-Id: <20230612203953.2093911-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: cec6426c-3a27-4f87-57a9-08db6b853ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6EPS6IEdfiQYbbm4yCq9ZiuY5pCRavKFx9MSuqYSUNyEEfKwPKQHNf3KyRftd9Ys5cjH+pGeSl66b7MfT1u4X4UHsIMMRiqD+5X8FjN0NgIjYbFhYi5KIke4mz1072svwC7iirGALKjVDlwzq55jgShwKObOTeOAA2NG8l8DKzrH0gJYWB+LZkeIk3gI5dQGbDFUHMsVh5VaQIaXTHap4IHAjKxKqxQwC4RHI1F8kNgOHJJ+wIGJbofq4d2afYm7AjSHO+d18K1a+dBytlyRrE6de/APQasnCq4kbWU9Mi/mt5uYHIC+nTxO0mxmjTV0cgd/XRnxGUYykZTtPafMVW3rBxnB2Z+WITwpuHwf6D+9fLCvZA5O3r+8sRUTLDJxNOjl4EgPDpPoypQ0+WMsIXJcRSr3Z9BLLnM41zxp3fWSo+hQ0gtByaaNDHyN9nQ43z6wS7/cXv5NQyvTUKEYsBkx3Gqbdlpi0+paoQXxeaoXWQCgrhdBVXeaUaqd3GMhk2+KJPMhyB7x9Wnn5SR/wPVUHrFhQLH1kvGmrrV4kZ7Y14l9wIQDiXXZV45TChO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8936002)(8676002)(5660300002)(4326008)(6916009)(66946007)(66476007)(66556008)(316002)(54906003)(2906002)(41300700001)(6666004)(478600001)(6486002)(6506007)(26005)(1076003)(107886003)(6512007)(83380400001)(186003)(36756003)(2616005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l0QCH4m2yJ6H6YXabrwcUWVhYuLHGXwtx1mE9VMEp9RncJg3AuIcfO+eylZJ?=
 =?us-ascii?Q?4FxT7wRywJHsCXUmzlo02pM6FaOrIGrOV81CbshGUX/hROTixyCrtHSomQtT?=
 =?us-ascii?Q?0NY9v6scoI8AQuddBefLNMvHc5Jp9gWkAJnOyxAj+WZdkE6OrqCL3gdmEpwp?=
 =?us-ascii?Q?SSiT4IPcYd54XeoxHMQJXdzvdY2nQ30ceOu9a1rUR+dVWxtpsOMXczON71jA?=
 =?us-ascii?Q?aKMVdgG1Ht7G+3jnqDXjkIcmkWFNTcO6+/X20il5n/lgIxhoHdqKsmi9g6n8?=
 =?us-ascii?Q?h2JzzLZyWr8lxOLUO0AixiZUBV3LzbIvG8GO54I+4ndF0lk4eK9yyCid5Q6B?=
 =?us-ascii?Q?PirX/g/zeOcT697NbslqI2EiZc5uQeeUIjUKt7xjD0wIi7HRS7gvgrci6PXw?=
 =?us-ascii?Q?ZTwYJmd0EzV5f5ntOh7D4LUD44uFmCw3G1PtDiY0JmwUXkfnblwki/l562ph?=
 =?us-ascii?Q?bfiZH8GhLRCV+FAv93miUZHcqwo0XaF3VWekTgAgf4XsDbkKJ42XreUVk28v?=
 =?us-ascii?Q?lSrMNzqUuOKIvqzUmF3oxGX2JYWp9SP/TPZ9uAxySFo3J2x8NBvl4LvPyu+L?=
 =?us-ascii?Q?iQc9zTeG0nwZWFCKWHbn27gWezHaVfqm3m1U+KAVtEjmzFSCMDeD2Pz/lWv6?=
 =?us-ascii?Q?tYvtb5B0EalbXpRj0AsV6Y5jO2S9BZJfaJ1psZ+hZiJ10HNuz8c3rrf3TjZA?=
 =?us-ascii?Q?WGHLmTyfKUGvde53K/XcUavp+t3HW2xWfk8z3A8f2Xou3xqcWAHzDwOklOub?=
 =?us-ascii?Q?Tu/+f7VFSruQ8CMUTw57LemOo30SAHpGfYTpHnZSrr6iYmLDaP71VS2XwxIU?=
 =?us-ascii?Q?EMTyi+69JZX2LpNflNnieI+Z4AJeWW4JWeZji5gFxnYOxXZkv/OMAUvcsylb?=
 =?us-ascii?Q?n7nyFnsN0C3Bt3RHYZZMGTzxlXK5I1+rjINiXLekCPaLlVThdoMDT0uo+YcT?=
 =?us-ascii?Q?/dVFZtX2wk5Q50D4eTI7PriBgum5+934NBBF4SzTGlKdypeUqUAvN73C/IV3?=
 =?us-ascii?Q?QWjlWX76WZBm0VdW4JZYoy4YECisvdEt6Z6iolUhY89j1/JRVV/vlWvU66Y4?=
 =?us-ascii?Q?LMcnWlla5NZv2OY5fKQ74C5kCqKQLQCaHlqdZVdZ/J7Ne5kBfoH2A9el66hW?=
 =?us-ascii?Q?xcqiQ5Yj5F2L5MsxfeOzNvOwp9P9rkqQjnkGOpd1yWIpEqiiDeJlLwClXNdP?=
 =?us-ascii?Q?wqUHe5ivYW0wVDpTrcMtXEIPfbK0Mw575EnaHu7Fir9EzPGESkJ1QLkCVoVk?=
 =?us-ascii?Q?RyX2NIfZGUdHg1e732CIiKxooVmaqOn3jKUICDFrJVpuZlTCnIXBERNSQnBG?=
 =?us-ascii?Q?ZBxOuiSGIOT/VXjqtNPgePrR2xjmbc5LIox2gweeSXWYZdCISRLmJJPQ4hVB?=
 =?us-ascii?Q?VCaXgYKGbttFeNZ3OgzSCT1EYMeMw7KxDjJRiRG8cC80tKFfhdk9zhdEQaLV?=
 =?us-ascii?Q?j/0SuRQkQvo72Xo5yjepA6y1FWAhsf8V0Fkh/M4fy/a79py4TxFPjpRHwLBw?=
 =?us-ascii?Q?X70lXLuQVW0m3sF6ASNJJZG/tXMuK3qH/1FuXaMrYXPGFQXdAR6BinCy1nDs?=
 =?us-ascii?Q?E0qI2uonA8MI7gS86CNu2SOP8ZhWa2disMe1XVRqTQCK+VvkSuljn72m23D3?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?46OAOXoTQK6kGORyFmOFyAsaybHpiC/Pmt0t9j/iZoSuiIwAvFMOkggPqv/2?=
 =?us-ascii?Q?a1FCqblm1JSFjSmAClUCXssg+vCxxLLB0VUgnGgGMVCnKghucmO9C2M1aGfB?=
 =?us-ascii?Q?b8KMBhpuwKtu5ICkj0MdIGZO5fgNWArd6j2axOoyrsB+bmm9tt1CMjLVEWL+?=
 =?us-ascii?Q?ghUNdAU1o/0ULnhnclUBpP/2LRur617+1/RKye+Fvf7FYIO8GdTncETt2PSX?=
 =?us-ascii?Q?eV8nM4kQOVIN+YiDGpxN109Z9W9+VbznpxdPbzXxTniysdrwieIrQFrbOhhz?=
 =?us-ascii?Q?MFOFmPFyQJsbNoozs7rUSYii3JaQpKTJgDQcXZaZcRgMv2/nTjxakyuYWDxD?=
 =?us-ascii?Q?FHnZqv3SJEnZ9Dwa04FsqhlYiDeh4+cZuDT3jygT3s4K+B3TUwJ+pVJuQuJn?=
 =?us-ascii?Q?BtnLAQY/jKdCg2RZ/BkGB8FgIIM24OJqEijtguJ+A0y+/ZQsEnycxsdZ/TiW?=
 =?us-ascii?Q?KbZ+cq6Oa2ZFlTXm8dfKoAZJduzGMlFq86pVUCINQkMr/G3KKfr3+Mxgkp0t?=
 =?us-ascii?Q?oS4ow+PpIJP+nwNT+OSAaR62cPshisSIPGthBjRmZStXnauHdLOIZOMUMgM4?=
 =?us-ascii?Q?U3Fmn5EAp+EhxFNFDlUOfAkEM7BA4qZfWFkT4zgtm5tSzjgLuQLzAlBEn7tq?=
 =?us-ascii?Q?g13rww25+zRYZ0ImtJ0fwLLOY6ZCA7gIku31sn4eXADEsaYsHLJQuny99m7U?=
 =?us-ascii?Q?VIiRNBRVW2krMudle+90eSKNweuZQHSVYxfNs7QW30fAqgv7438+X6daDQ5n?=
 =?us-ascii?Q?zIRhZOzKNGb9UrfIpKv3JBXRsULGZoluP2G86C0JNGq1wG8PWvrvjglQ6N9N?=
 =?us-ascii?Q?1uq0rr1kjO7X977koM3aaNkVkX++RCQeNmNS94SZWy2h4e3ZwVlE/F5XWB3f?=
 =?us-ascii?Q?jgV2hNdHZGIp9YHVFz9lROwQbGE4AJD25YfXofrGfzMWZKtt5+KbHlxG+Nrs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec6426c-3a27-4f87-57a9-08db6b853ee2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:40:23.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZcB1aUyHxXco7EeZPAEUzNmWN1F2S7I0LuK4OUI7ZXx6tMWL8vWi3rxofFOOuAMyYwZC4DMjlLohCQf1rwmUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_15,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120176
X-Proofpoint-ORIG-GUID: ULVK4N_hTSzwuBw0zczigZ84pYV4HAkk
X-Proofpoint-GUID: ULVK4N_hTSzwuBw0zczigZ84pYV4HAkk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current preallocation strategy is to preallocate the absolute
worst-case allocation for a tree modification.  The entry (or NULL) is
needed to know how many nodes are needed to write to the tree.  Start by
adding the argument to the mas_preallocate() definition.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h       |  2 +-
 lib/maple_tree.c                 |  3 ++-
 mm/internal.h                    |  2 +-
 mm/mmap.c                        |  4 ++--
 tools/testing/radix-tree/maple.c | 32 ++++++++++++++++----------------
 5 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index ed50d8f459e6..e18ecbefc7f7 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -458,7 +458,7 @@ void *mas_find(struct ma_state *mas, unsigned long max);
 void *mas_find_range(struct ma_state *mas, unsigned long max);
 void *mas_find_rev(struct ma_state *mas, unsigned long min);
 void *mas_find_range_rev(struct ma_state *mas, unsigned long max);
-int mas_preallocate(struct ma_state *mas, gfp_t gfp);
+int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
 bool mas_is_err(struct ma_state *mas);
 
 bool mas_nomem(struct ma_state *mas, gfp_t gfp);
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 815c64f4c370..fa51abaab09b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5535,11 +5535,12 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
 /**
  * mas_preallocate() - Preallocate enough nodes for a store operation
  * @mas: The maple state
+ * @entry: The entry that will be stored
  * @gfp: The GFP_FLAGS to use for allocations.
  *
  * Return: 0 on success, -ENOMEM if memory could not be allocated.
  */
-int mas_preallocate(struct ma_state *mas, gfp_t gfp)
+int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	int ret;
 
diff --git a/mm/internal.h b/mm/internal.h
index cdf06f680d6e..2691deca9699 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1047,7 +1047,7 @@ static inline void vma_iter_config(struct vma_iterator *vmi,
  */
 static inline int vma_iter_prealloc(struct vma_iterator *vmi)
 {
-	return mas_preallocate(&vmi->mas, GFP_KERNEL);
+	return mas_preallocate(&vmi->mas, NULL, GFP_KERNEL);
 }
 
 static inline void vma_iter_clear(struct vma_iterator *vmi,
diff --git a/mm/mmap.c b/mm/mmap.c
index 8b3e58d6ac40..75b2a86e1faa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1982,7 +1982,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		/* Check that both stack segments have the same anon_vma? */
 	}
 
-	if (mas_preallocate(&mas, GFP_KERNEL))
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
@@ -2064,7 +2064,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 			return -ENOMEM;
 	}
 
-	if (mas_preallocate(&mas, GFP_KERNEL))
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* We must make sure the anon_vma is allocated. */
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 03539d86cdf0..cfadc4b75d51 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35383,7 +35383,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	for (i = 0; i <= max; i++)
 		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35392,18 +35392,18 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35412,26 +35412,26 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mn = mas_pop_node(&mas);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35440,12 +35440,12 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
 	mas_push_node(&mas, mn);
 	MT_BUG_ON(mt, mas_allocated(&mas) != allocated);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	mas_destroy(&mas);
 	allocated = mas_allocated(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35453,21 +35453,21 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
 	MT_BUG_ON(mt, allocated != 1 + height * 3);
 	mas_store_prealloc(&mas, ptr);
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35475,14 +35475,14 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated != 0);
 	mas_destroy(&mas);
 
 
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) != 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated == 0);
@@ -35490,7 +35490,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
 	mas_store_prealloc(&mas, ptr);
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	mt_set_non_kernel(1);
-	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) == 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) == 0);
 	allocated = mas_allocated(&mas);
 	height = mas_mt_height(&mas);
 	MT_BUG_ON(mt, allocated != 0);
-- 
2.39.2

