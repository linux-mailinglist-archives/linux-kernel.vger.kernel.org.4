Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336997086F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjERRcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjERRcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:32:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E651721
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:31:53 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6JQvD026628;
        Thu, 18 May 2023 14:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2YVRakESH/s1ICwCjt2PceIsUR1vzhFGi+kMxu5HLEc=;
 b=G5Ar9Xc4wZRZ+JDgd9WLGWNeOaRPt8sBmEp8/J/T4KHHswRArG3PiOtcro35uu/Mdw3p
 L+W97fqR3kg40yd/oMsxLyQIyooMpHe56AFtfX8rlEcUfycYTFBTE3y9PFKFTxyDH7Cl
 CjLMTk6GEo2RVRbxVfbQ2MWVIrM1qpFNwy/m0lmNMNRWENcW5W7uiX+NqoZ5Y3V8KG08
 0EQQqy79Sb25pgVrE9z9muoZPXc+RlCUPnJeT8uYfeS9Haa4wX2dGEBXt3UCHz3oBchW
 GBLf1FnDmk7W/4O4Q+OxYwuRHeOkUJBQufz3TiUf2RKpL4Obx8ZLz9ZTloBSNxypHNJy kA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc2uff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IEJepY036702;
        Thu, 18 May 2023 14:57:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qmm03w4f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRzApWUsXmPv6VbTzVgd+0sdldQnn0LBKiXPdrtbaRcBE521GlS4JPl7LQYxrnRxzn71tE80rd2658JGPjnUXfTKATwGBc4t7kwMZhWyGnpHhuSwKw3y6lEea5gN4zYVhSEHc8x4an8K2NYnkU4EinI4qTABs8UpbiWarPBYFHhVpLit/tD25Q8LdKRJhO+hvwrVv0mvL/EsQZkVEjXArD+d32l5fqDV73vP6PJWiXioTSVxtQ9Emtk8VPO4VdYucSUHJ+XXp6XxuuXc7cnLk0wzS4NVFvBFBHrb5Hb5QDFoW6eD5kNn9PS1bP1n7tvE6aTav/Q/h4+HWoRJpaVmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YVRakESH/s1ICwCjt2PceIsUR1vzhFGi+kMxu5HLEc=;
 b=ib1nMNbmmL0yfPTXaj1Z9DtQD/3cjuDPSVT9jNYK1lJZ9B9PqucNRZ1Lrj8t3c5gNiE/qZk5AfPNUzxW2scJEgJEZXne6fLLRXa6hi6bK9eHvibTmQe9OKjcib2eGi7svvxkEqQs/7M2CS+A3SwVc0ChA3LgPO0k+xtMhDniI1vjXOVnRxq0Ed6UQwL09gkNwwr6V24p0BgQf1KWirg7tXf5wt+iBkk0NeNb61XFJKTWAT/zFJVk3IIX6DSCOZrmWXyAAdCqGgrLPJF6P6jEeq2n1yU6EGUBq0t6UWol1plknKB2aiX94NfBpHASlyqhOJ45pBfLTWx1HyycvNWQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YVRakESH/s1ICwCjt2PceIsUR1vzhFGi+kMxu5HLEc=;
 b=teoqPESHr89IHaOWwEAKn9MUNOy8cBPHm4jwYztUyup4INjMYIMlfNxpQ2ZJ2hj4/8HBv1DjBCP80biENEHPgt+LSMnBytgTU7xc37TguJAsMMmFFYAhzz+c0TzsWp6BtPRY1moo5N6eFIeeJaDIWY30nuvaS/oJGJVqCAoEaiQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:57:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:57:08 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 32/35] maple_tree: Clear up index and last setting in single entry tree
Date:   Thu, 18 May 2023 10:55:41 -0400
Message-Id: <20230518145544.1722059-33-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab5f90d-1f66-4183-a940-08db57b0274d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRtO07/Nhzy++WCs/z/sWpJbwp67XBt6QC8xkfzh3LXdExubo2lrsQmVsE2UNktvvuPm22wliZNLwYX+7x4STrRHSvbHlOkzRkV18EzhvIU4xLhzBFk5s3pa22EPPDyA1K6CAUvqtboHeD+PcKx0n8tol/ZWDDRcyHK6atHgQEzxgmEgbiJ5PNrvXFxT9BGKjBKl2A4biPWU8P+cEIpmXRcl19XlCI27wLQQsSOYjCGAmdKF9OAGUE7CPbZRg2vSh/+chKf1Gwx3k7YKw+tgy3TherpElk5o9XuXzAgHzXfWC84QAh32lZ+EmNDu59alZouKOjB5hDZMG2TmBhdj8mWEgkmh2sS8/GSjkbY4jyVS93QsB1J+oygYxq93rJ4DCuTRglAF/E9icp7tiXcPW0+i7R+r/GRJDWdSnKMq46CurFw3MOKbFjCO71qRCZKuDTjooBS4Whyf8p29rW9cr90LsXZ7yTaJHSeNf4IH2TOrpTjiAtEhD6+YT+cuCGTSs24a4K4oJfzz92IPlIO/6VA5+VDhj1AE3XUm6/MshnVSiWiMSjzGEmhj71n1cD3E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(54906003)(41300700001)(6666004)(316002)(66556008)(66476007)(66946007)(6916009)(4326008)(6486002)(8676002)(8936002)(478600001)(5660300002)(86362001)(26005)(6506007)(6512007)(1076003)(186003)(2906002)(38100700002)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/VVapN5yMF50l9fFsQevuqQedAsm3rR70BvILbkl9XkHot4uCk9B+6AUXNcG?=
 =?us-ascii?Q?61KST5hPGONTxy87acc+mbX6al/eE7IGVhGDVmnQ0VLG6+NFqKP6K5U+/Hl9?=
 =?us-ascii?Q?1Vn8G0ukZ9YL5J7pMkkhmd6G+Z6V1TaVXM1mMx3JSS1vkjNbW7CJ5qF2uLBF?=
 =?us-ascii?Q?8VQFhT7DAqJiVaF+TuKZrXhs0X+zJk7dNQKJT2qjDHklMzwbVxLlbiYkVAov?=
 =?us-ascii?Q?b8AKtQet/ia1NYW8RtA81pz8ZomiQezWE8yQgZ3LcQI17mCv9MZgcHfYm5IT?=
 =?us-ascii?Q?wS4ae8uZSbLLiWTaC42qzUZXs+UJxeETFIJDyrw4WgRDpvBblTvWoIsF0s/t?=
 =?us-ascii?Q?1+GGPxnNskcKl5IwwypYIFMyXo2WjNYqpzQzWYaXQyeIyAmQhXea8ieLtvRK?=
 =?us-ascii?Q?zNieBrMPWK/nO2jhjWjmaHIKbXSKt2V5YqwwNjNuReY5p0deX61HuzhMYOeV?=
 =?us-ascii?Q?nsHLhEBCf5SyXsp3bXkiIUGYphSM469L21cTCjVjOFPXNIUr1HoMz3/w7ZmB?=
 =?us-ascii?Q?IxX26aYqOFRHrV2lje16wVPXMSfNjReUEVrUR1oz5g3ZrJrMmIDDREV0yeWw?=
 =?us-ascii?Q?9iScDhWJ881KkDdWdI6DSC5ijh7sj7c8feKvynrnOVcJaIdGMOV68MtfdwyU?=
 =?us-ascii?Q?lwTyaSYjH8AK3MU3mc8ssXM97Q0SB9Ax1exxrV4LHmdFatST6xGkCaNOgzkw?=
 =?us-ascii?Q?qZu+uJTq5tcS4gCmsObqPkVIn5qfrbd8rKKLP+6aqB2SpdJNDGy8UZxOXRal?=
 =?us-ascii?Q?V4hcrpH6lowC3kk8xUfC1yLb04nUUdkRgY4SRebFggUMIWVKfBGyr9qYZu8s?=
 =?us-ascii?Q?F6eZeEXqC8PgJnJ3F9qRiuINg+xhHjY1ipincuHjrPjuC15TZln5Bvpf1riF?=
 =?us-ascii?Q?iFE1JnZUyJ5M0HaHYGnffW9+8mrgc+sh3G1J41wnyUAQAipVDmZhWcVtnNPv?=
 =?us-ascii?Q?A3UMCniMd/ssPwUiuiReODopJqNn0gysVAcDnSY7XCI5473B7vsB0Tg+gNLb?=
 =?us-ascii?Q?qeRlzzcwEhc6Zua15MzD6iRicPyvGNLJ/j/iAfrYdUya2S6OaLXX4recfrbP?=
 =?us-ascii?Q?jPA+VCn4A1KNcyg6J+4eBnFgGNKBdtxKT4tITmrPEqhrMP6qREGKBi9D+L6C?=
 =?us-ascii?Q?FIYrVN1Qc7g5NcAKW3Q/UWwyR4scSzvvZ41x/DOT8KhB5B8RdHeNxbz6i9je?=
 =?us-ascii?Q?f5PLxfNSKb3l/r9TwX6CQvCrWmrTwJ5JcZRrYJD+x4VGs5PQwXusYVmWANhI?=
 =?us-ascii?Q?Nwpqozc5eIoRKjat1aCRX3PzuIdYeewWw9Zas+LJPR00vRsjIgFZz8vdJMW9?=
 =?us-ascii?Q?80kkhpwwnCgxidZF97F9wFWuLA/PogW1ZMxhwqJP8nwb/ihAa6VyAu0dRjIl?=
 =?us-ascii?Q?owF254slBJJYNIVtkOlXfy8nQ5ykHSudWQRs0g7AOF0MX6xcRahgo2X1dy6O?=
 =?us-ascii?Q?1zKTxZj1GvZu0Yvzl0eQVkDBzJmqY1LbH8HTOGuZuVVJRURCsPmfmcEDlQUE?=
 =?us-ascii?Q?m3yIfWFTaDmTyUu0egu01BMpE7AFbASYwKunWmQKqHmNW7nziY9QryDfJdZ0?=
 =?us-ascii?Q?rR0NHNgUyRj/dHtVIaMwp0fLHOjfC1QRNrNTrG4Y2vOATzeXW771n1tt4emB?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?q+0rTE4w9d79GNjwee0KL/KLLUhoxkJhiiGlqY+VwvR4Sd/GfbVAObm3wAfI?=
 =?us-ascii?Q?yETDxx8nAzvlRgZiiZesZgAoxcXt/UOFVadV6hTGmiDF+xEI3CymuxSb6d3K?=
 =?us-ascii?Q?K8reLfCte5+3StiES5/A6hn02Z/Kj8zt8BUkZTd2C910xjuRkOyWF+5N9910?=
 =?us-ascii?Q?KmVMoQd0nfN3y7TlU+dnQn2k8cER/qwI8mYhabtAhSNBlTJ8REnLIDIRdgu5?=
 =?us-ascii?Q?4Q1Y+YaIRUHJPNJRn1vEh7jfTVDtPlukMrN/+39eUcQCXDl78U7N7DSiKAwz?=
 =?us-ascii?Q?lB8zvDptX0IwB8aZBrQXmYOJeAYE4I6jIl6gGDakbR0EHNjHhF6eCOy9bSUr?=
 =?us-ascii?Q?3cb8ABY+OsYsPhGt+qL3uOyAvBqHe0xVu3gUnw8StCiMeJ0/TcB562YGE0Ls?=
 =?us-ascii?Q?TfsT8eU+z4+XQZuO/zknci7DbxoLLmmuLM5CQc1Zm4CW08wjblDdJGMWwQcN?=
 =?us-ascii?Q?qjinKSlCQFkboxA6TdxJapVUM91ljF3/zh5rJFuvdiSo0RFFpSiT8AzwW6qo?=
 =?us-ascii?Q?10h1ccEFUrjkRoR8MvwG0+WCDgE5v111NumOdaEVWdthJYBq5ywnOpM+uk0X?=
 =?us-ascii?Q?CDFLkfMEZCsvL4F9L0DPT639cBDZi6WB/N6ajSVMohQiiQYgjTiwG6VkdqYG?=
 =?us-ascii?Q?kFFy8gcd2oWLhXX+xxLFYAenLlWGTLSTao6ActSYYVqin2o755/sG7mHdhTx?=
 =?us-ascii?Q?Yk8fifLzoJSzNM/eT2AB5spNPwjj+sajUPrV09aqQuAec4piEllbyZYveDmd?=
 =?us-ascii?Q?l7LyXrrXGkc28M8w3NflbqXmncri0yjTQOF7K49qNPuPFKT4dOjHGRQF7fBJ?=
 =?us-ascii?Q?U67sYb2LlUBaG8c4u6NtuHnk9/e0SamT44C8PXilfJO+AGgikhZhIS3aJe4+?=
 =?us-ascii?Q?JoN0DkxfauXGef0KxWJoa85su/Rpbd+aSpDVB82tgnVbRdDq/tDTsk8SVCf0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab5f90d-1f66-4183-a940-08db57b0274d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:57:08.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSSGbwBLvcdE/glxqAZoH8DR+FTceS1v65A4Blie/sgsNLpyDDLkEMait4NP+KHng5y1K6SZdaWLFphqbejlmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180120
X-Proofpoint-GUID: -je11Ztu6r8Uiz_XU92f1zpGVMhmsl5F
X-Proofpoint-ORIG-GUID: -je11Ztu6r8Uiz_XU92f1zpGVMhmsl5F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is a single entry tree (range of 0-0 pointing to an entry),
then ensure the limit is either 0-0 or 1-oo, depending on where the user
walks.  Ensure the correct node setting as well; either MAS_ROOT or
MAS_NONE.

Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fe481d4e5e6a..1e70a1b0c6f0 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5022,24 +5022,25 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
+	if (mas_is_none(mas) || mas_is_paused(mas) || mas_is_ptr(mas))
+		mas->node = MAS_START;
 retry:
 	entry = mas_state_walk(mas);
-	if (mas_is_start(mas))
+	if (mas_is_start(mas)) {
 		goto retry;
-
-	if (mas_is_ptr(mas)) {
+	} else if (mas_is_none(mas)) {
+		mas->index = 0;
+		mas->last = ULONG_MAX;
+	} else if (mas_is_ptr(mas)) {
 		if (!mas->index) {
 			mas->last = 0;
-		} else {
-			mas->index = 1;
-			mas->last = ULONG_MAX;
+			return entry;
 		}
-		return entry;
-	}
 
-	if (mas_is_none(mas)) {
-		mas->index = 0;
+		mas->index = 1;
 		mas->last = ULONG_MAX;
+		mas->node = MAS_NONE;
+		return NULL;
 	}
 
 	return entry;
-- 
2.39.2

