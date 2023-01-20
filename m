Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8E6759DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjATQ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjATQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:27:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B8A80BA6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:27:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGDi03014958;
        Fri, 20 Jan 2023 16:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=gaRC0UaKncm++u9odhpjI8fRluITG3k0f7+eaHoArxY=;
 b=KGH8uVVP9vibqQp46kMV5OjEanuIb12b1u95BCUWtaNFIQ+k1ioAjhKfzw5r9hWiRfEk
 wrG/iBa8bBTjcrCa5u2WBJONIdz9LOtdJk+xp2ffTE2dLHeNGmTww45PEwyHhIMP1gFa
 /JFbnhqcEwwpWKSDgnpCVSMrHO8Z7g7KNwLfUf4gxeFJdabFLIKcM0kCCfqb2r9EiRFo
 ZbRCe1Hm3E5M52WE74IDFKuVEaJuSsmbZ2WNVvFt0Bd0A93c+Q8DVQ2JXZc5Fm1VM3Zl
 9XB0rOfEbIG5Olzouy2fGXWacmTAQEC9nj9DlcCs5iW41Ra0M0iNwSaNKFlihqjyHosw CA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxtd208-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFCKs6000835;
        Fri, 20 Jan 2023 16:27:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2su36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcYj0QBJHZeIyeZzqWZEbleLty5UeNisgR1fb7Kfq/GLmuAs3G1BevbnfNk7bi6wNAna6byut79XLvg/nxnPJpqpp4EJiMy8OUGTpOupEsdTdUdzScSF2lEVmb5UIMz13UOTLm5LeICn6ctphtynjQkyZ0LjweTvObjEZBFQS6iiGFLsTO7A+D9dkQaLy6dF6HOy/jaPbxlGSDwM9vdi0sKWFCvcW4g3SaG3IE8LpOf3I98Qq4TvUQEeYz03M/Pr1ci6HAvZsf3Uem0x7LoHQG4rULy+IZH2iKSr7c8mf7SCrjF+ZWVI+Id/+V4jL7Bub2qX9caz0OR4YS52jbY4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaRC0UaKncm++u9odhpjI8fRluITG3k0f7+eaHoArxY=;
 b=Sispcde9lKt+47Bew+1adYAKU3zOLBFQi0SQSGSXXnbQkzk2xKlHvxpRmuo/RhDt2Qd2teGcnLpVizk1E/iRETqafVM7jwsyViNVD6v0z/6ifq8IU8G2AMGIhTCwuA75StYuhhFcDHPIPZTc8ZW7gc7n94CEMQ0NoG9AWiIzopyJqe1H41yvXT4QdN+T81hfYdXuiVrrQ3EBkAgwZDhUewNnUm3Eadagv/wBX52riOmtu2ozjsKzxFW9S8BqcT/NqpAOZBeI7w80BZYSmsH5EscsjFERxf9hF3gRQSZPvO//CuuimqTnDzhzIY+Ns/TOaCEgJJpOSFTe2DBwY42ifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaRC0UaKncm++u9odhpjI8fRluITG3k0f7+eaHoArxY=;
 b=X6ffASFIckleuAZlgH4aSi2T3ZfY1ipr/h9rIvQ8uhHJXKJcEKtlcX98h5d2e8qd7kXeQKp/6yUNqE/NtPoljrO/eHAGdehNunwnxBZP6cBLX2g1CYKmIz5eUI7kCepTO6mkKwxaDt9Uvjy3/eQkraJw/lhlqSvJTNqewkQK2FA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6026.namprd10.prod.outlook.com (2603:10b6:208:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.7; Fri, 20 Jan
 2023 16:27:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:27:12 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 01/49] maple_tree: Add mas_init() function
Date:   Fri, 20 Jan 2023 11:26:02 -0500
Message-Id: <20230120162650.984577-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a2a8f2-7daa-4c9d-573e-08dafb032f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmBQZBcoEFlPLbZoiGaNUOgIISV81nbgPI3lFeXvInxtITOM+sHL131n/MXNEei0c6sN1DYTXgQablA7pvYwKsa26T0dg0zT67GdRUvvFKz0nx/zhOw3Cfhd+2dPoeYKF/tLWopviXmc9gzOoe4cBHdgnl+zqPSNWw3jNWjVC/Aja5vjedrCx5IElk0B21tJ0c0cbsmw/kvtzJ1gxqBtcbQ+IY3h86J9ywCLaVV6O/RMBCATNknM99NTztEwrltAMHCDrdJWct6Oi668FcDA1tiX9WcdT7SYX+KdEGmmtKbblFfQGaLpQypdDm2FaV1sw2tRjxxrOqUGHW9SAN6srDqq0m63I9DjR/XNXaUGFdH0XGWzOH38ETpRN98CN6I2U0vXgMypalw1tYGRNe7ss+zaQBDUtGmXDGdBd4+F3jlRM+w0okff/1h+ebfSOGf6EFMKHtnveZ92cOSniZSo5ja3P081LwoOkGODO8RdCWMAi5OatBwTrc26vZUF/9TmoqKVQspoduaHgv2TEeYFq8Lft43V6IamdbemZfixfQVhdDJAncVsqYCuxyEBn0bVEvqloVQRoDazyzeJcVdXo5tRhunYEnJPGHSQtQAWdknp5tJQy8kWDYZqTzwsyKFT+zisqfw6KnBk8a1ThP0r1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(5660300002)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(36756003)(6666004)(107886003)(38100700002)(6506007)(26005)(6512007)(186003)(2906002)(54906003)(6486002)(478600001)(316002)(2616005)(41300700001)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8tpy08uxvOZRonWYJh155SJNa3zD/VaVm50JUA3LR/7z/HBBLsfq07WUl6uL?=
 =?us-ascii?Q?YLw/7haHPTKXC/c4grjtnlCtTZhBdJN85xkILzQknsslohvr1YUiisA3t/uk?=
 =?us-ascii?Q?sueelhS1buZ/LKyTXr3rBRuKbqpPxRIJoXOstGSpfhR7toquo9/X98+5mOf2?=
 =?us-ascii?Q?uGCAqzbGln/7uq7UhqcBvBM/MYc3Fkuwy3FHkD/tdQgeMLMAJHFCcVi/zXD1?=
 =?us-ascii?Q?GLYPQv3t+6r8FE09Kg20zN401MzpYI3lkF4BKF0eTZ4RWcNM5y+YQKS01LJm?=
 =?us-ascii?Q?EuOOHoiODHMDwViOBQE8ON1uHz2hib99dCQK+65jAOlLxr1uC6VFnJOiuDvO?=
 =?us-ascii?Q?z941uhjkslfi3XRcJ4kHoUKyR4aAxrshUZEsBismlS2DuSgw2EpPzc2PJzO4?=
 =?us-ascii?Q?0B4ez57Q/1VXdeRKpdsxsBhPMCh5ytlyg2FI8cOmW1YXOjYwVd3qjMhhiG8c?=
 =?us-ascii?Q?HZzNB88elraI32ozvm1GCdrRt7Uin83/XPrMOnqZNFYiRA2XQJhHadeKq97G?=
 =?us-ascii?Q?kXbNh1FA4OP0Roi8H6uU8IABPSZkZTe5tJhO5+k+xLEHjRCowzg2ZBC31fF4?=
 =?us-ascii?Q?jmarkBEftA82EGMMbQClM5w16WPuPO1LOpjWsQ/Pwc5WnG87Ena5yaKeuCrw?=
 =?us-ascii?Q?ndIRVkAV+iz1ERnnhkS+hvdQ/DykxkvP84kL7dXPOEJHGh3kZTtYnivYj4gH?=
 =?us-ascii?Q?HeLZp8IkRiFgTE0EbHhAcQt7b6XntXdK6BganG8ULiv0sXPeXPRUK/tb3ERX?=
 =?us-ascii?Q?R85nWxBURT54pFkbfVGmSmSn+eIpGnrIHhM7Z0r5NMbOuqtAEARmsqzTnO/n?=
 =?us-ascii?Q?wNhsvIMvn5zEDfQmtCBqbV3oDvd/0ZF8JG0A6/G74iCYLqYEyCxP8Z3v4WOY?=
 =?us-ascii?Q?aEpVXAiQkKMVgTX/N8DdTZTV63PuEFH1mghRejHGxqin9gTDiElS/1fmKjR+?=
 =?us-ascii?Q?1Km6OgspcYywnPvyBHkYpREzLNr4QIpJg61YJPko2oqRTdwSj8ZCgAAB45gr?=
 =?us-ascii?Q?gPPcncaKXwGf6Zm3/qx2SqYEFRPoEeJLFwgt2gHEdxyeMVMm6oEnIQXfa0vz?=
 =?us-ascii?Q?DTBF5+YW00rbF2aygNiF9oMUGbysyUG2PGQX+0YYZm6KEKtgXtIkWvOTOQES?=
 =?us-ascii?Q?A7VHBFO7WbjaCWlMl963Hw4xnEgViSDkxvqDma/Ci+q+ESEXZSmQj2pgZq+E?=
 =?us-ascii?Q?PvZXi6Ucd3S1SvOa4bOkzhHhJWsVQFYw3VFtnV9r+lyJRdMCNZmfLgG6XMoB?=
 =?us-ascii?Q?jKuQ4OOvuVHaNDkBi1kxCsDeiHAEV2EFOd5sfWrIAJKpXBhuNReRcSIvzwIG?=
 =?us-ascii?Q?tqMd5w9QyEYhye2vqusj7RHRISA/Jr8T8zIkv6PnYizCIcXg1tIhzS9MjsLK?=
 =?us-ascii?Q?xOepNbvIIxJSg/dY1zeck5I6SbvqfHOHHWgy+M9UznUMJRM+s5hLkzu9Z/JM?=
 =?us-ascii?Q?t7k/6qNuuHcZY+FG69xLG16ciypEroJYlZcBX0WlF7Rbmh1YQQxd5GkNSw7I?=
 =?us-ascii?Q?ifQw5T2ZgjT2JXf/RpxcWtQJx2Y05RB80FaAXjkVPjH3Ihg8d3jKdZOelBl1?=
 =?us-ascii?Q?vgFYIGAuZhx7Q6Rgq38fd16D3qQUgZ0d5HqMNWDCubMGOTJPbvGP363vsP/J?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LjY3/xPidX/ynofAiH8GEbKSf/r/82EkbPx9sDQawv1VTOr9zRD9rZcw/NXcZgCB4k6UxpfVfZua4VOMp+YzBN5x+QsgWCXYskzar3NkkP8f43++1kGAV7QH2B16OfYGT93bBgEAaotQtVOs+c2hE8RFK/7MEGMpAPA9uRc549rtnBaDgd+OEnHKgSq5p/1IedGchOgXoru+JEIGueKjJEW+IovXyXsgYFd5n1RKMcbFFeQuIujS+6aJc3Jdu283iWdVWw37sHlwFUz23eWRLBz3izw0AFVajtM59ad7Az+hbFMdcefY9z38WdTln9AAQ3YjqZyyMDS1wk/a2QSVjax9Abb4Pdo/kfX2TiLB3IDK/yHnZ/Pt1jk8QmltEJb0HFQuuhpIvgwhy/1uOaIb2iwrFotBrA4WO6WMz9UMVTffX6XiKqROr1pedLLhu0kAiu5Yxdnl6ECDaWmC8nMfOl7CZfgWq2MT2d/Hgga/1voyboMpb9kylcXVLlvwx80GxkBXLKRElm0+irB8IT+U68M+k2T250GVyZlGbBxk3AUWryukB8JfMtYPMEqCjUEEOIHDw7jX5GIJ1yqkzGV8b2MO0kJCmptr0gegEHSPvbyfHF3KfhydNRnqYprj76Cpdk0FDybLi8Ysd/FBMuv955CMDedIOE+vDeZNvqtQcY4RuIAOUXTmY80u++3TswJvCDZaIgKtR3frqYGAjRBBOHdZrW7NReqKO5c+4UUvzRfPQauE5OOaceCI/uaJtY2oIisFHWQWjfwIRcl8HjJ1MEsIYe9n9L07oW01GTt8J0rBX77c5yLppzxswIJOYk8Ox9QddCcaP3lO+DH0yBZUhdN5KhNvQRFS4c06mBHbv5jFeWHEumCOP+JxgF1mS6ZmOhJ0gZWr/5DLAERvBf7Osw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a2a8f2-7daa-4c9d-573e-08dafb032f52
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:27:12.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGVBsn/6nNNQlJgPnIdDrTl4FWQNBo2UndHLFy4ZCZfj2FenD78VmshlOm4WLQaJnv9OO6sinlvkQOSRekv37Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6026
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=988 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200157
X-Proofpoint-GUID: 9HjLK29bQlSJkLOaqVAeDev-W6X1D2iB
X-Proofpoint-ORIG-GUID: 9HjLK29bQlSJkLOaqVAeDev-W6X1D2iB
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

Add a function that will zero out the maple state struct and set some
basic defaults.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index a7bf58fd7cc6..1fadb5f5978b 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -432,6 +432,7 @@ struct ma_wr_state {
 		.min = 0,						\
 		.max = ULONG_MAX,					\
 		.alloc = NULL,						\
+		.mas_flags = 0,						\
 	}
 
 #define MA_WR_STATE(name, ma_state, wr_entry)				\
@@ -470,6 +471,16 @@ void *mas_next(struct ma_state *mas, unsigned long max);
 int mas_empty_area(struct ma_state *mas, unsigned long min, unsigned long max,
 		   unsigned long size);
 
+static inline void mas_init(struct ma_state *mas, struct maple_tree *tree,
+			    unsigned long addr)
+{
+	memset(mas, 0, sizeof(struct ma_state));
+	mas->tree = tree;
+	mas->index = mas->last = addr;
+	mas->max = ULONG_MAX;
+	mas->node = MAS_START;
+}
+
 /* Checks if a mas has not found anything */
 static inline bool mas_is_none(struct ma_state *mas)
 {
-- 
2.35.1

