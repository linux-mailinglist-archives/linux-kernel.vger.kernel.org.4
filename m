Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0621C700F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbjELTc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjELTcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:32:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44718A56
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:32:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF49kG010140;
        Fri, 12 May 2023 18:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PRIktY12WJ8MfHPi7O5sGns7YnMuRlsbvHwTkhOWO68=;
 b=0AT4ROCkQGbC5dE00eMRNqWsjuBu9ofs/UD25Yacoxz034fFyQEhq88dXKSm25XLphMH
 mvURzQDheM6mEFrufJb31SDzHMohDsx9luFJjFp6XL31Xl8ONXp8+ya1yj7+HuNH5DYl
 j2t0nPRS3+1krJfyAUlfuUB4CZKaxhXAV5C9r2eQd2MiPWGa0PZ/ZvEZ5VB5Sz0UO0eA
 f4KtL5lzq82EXwPYt8v1wgcp3tJfqrlg4osm6F5aC5q6FNEwPKiRReycq3TJqVeOu4a5
 d6wxekb1Alz5pzYX22+WZp7qteGpKyJy+csbkaI9dm6XQvINwkcUyND80Q5knAhvwDOt tQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf776ubh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CH0vTO024102;
        Fri, 12 May 2023 18:22:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7y8gu1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3xswBKZXd5kwHLx14vzqEp2FT9Hyn6cMrI69Pb+crNC4ZZKIYDZ9b9E1t9qMxoCJ7AfxpjStwauZMvYab966menCMxyi+qByvjBcX6RTfLUAwQmAz6CgOxFzGSzjV7MjBemmI4fEjlZftsco9yLaIXMQOhxE59lhiiMes51wz5ujCfO7lcZzzx7+X3uzstzkDBGAB0AwG/8Yv7BRCoDoTqoyOaVIZeWQK0uweO2M6B8Cnahla20UG0Ju2sRaDUFhp54zVZ2LqJztLO6tBmJvZN2F5ys8dwvgXNj7qUZFciZZOzYzWouvKfhf2TSHBMo8XUxPzVeobglr6+UGcq7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRIktY12WJ8MfHPi7O5sGns7YnMuRlsbvHwTkhOWO68=;
 b=RupEpF3mHkcnROpNtAa2/vTbM/z2KvX0H0Ma+Hhs/8l0aFi93xVgiwhsLDgnZEZ6SI+yFp5/mVeB1oJ3UpNIokUvfKxBGG+9HJqPfV+zJGq8jDwzpsvjcvAtbz2VHTZZIJumaaQ4zWOVG2u75gOKk19XdL+bU9mqnrlRAdrfRvywNCqUcKBv+PqYhTGfF4457zihZgHmCwRrVivti/goUoUEGvim0OHQTYGwpq3tnHKSVZ6GFKba/U/1qpAeQ2LOWj2l9j7IDNPa/ImgWOT2rqaeE+zeNb7ZI4Jtk8hTHxGLpNYeGAIaFB/FS1gRij1xJpupWifVDW73avSDJ8yzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRIktY12WJ8MfHPi7O5sGns7YnMuRlsbvHwTkhOWO68=;
 b=EbSR8r6Bsq/PkWez4/SeJfiaRH/saAkf7PtXLKMlKYq5yAcNdKgUlEQ8Fa3PY5vf2UDiI3Jiq3QMrMdZH4000zswCo50iSlczM1ODrQqWRENHF739A5cVOmBU8V3a7qaaZZQdqoFuwZNCJd+jtKuYOWR41pKu2VjW0v4PzrVYYs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:21:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:21:57 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 26/35] maple_tree: Fix testing mas_empty_area()
Date:   Fri, 12 May 2023 14:20:27 -0400
Message-Id: <20230512182036.359030-27-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0194.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bd813d-7273-41c1-244d-08db5315c53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AqYyMjyKvRVQ0Eg86mNVJfnOklHNh2so56GJjGEKBFf6VU/myxddZaJmajpZVf+vmPATRkaUUsZIz6Ey6Ba5ck/O5H3cX/sk7InN4lrrutvPgqGhUK4uakAYytqiGT+bbWVyarHtc8efRiH75P3urWMGvqTB2BqNonzpWEksn38WpvHckdD2p5UeIFKQhQnGEIV9k4DppSpiNXBr2Gdn6T3oemRyxRuaPhqm4K/wMKhgjGmxaUb69sdvOX+/Bw4W2COw4eroctpk6gMKKDzncMyUpXwUURNQQQOLEmRqQJZDQgSN07DpoyQ04bIvIZLUs554TgWGR75j1l/OO110s4WpOss0VGTTAuKvjDlgypE23FTcuIcAxtXwRVy1HMmKIuNlZQ/ypNrRN4vulkNeAXTRLwAY8juYVOQ7eFik8uo4OOAbZS7gMTVt/Ts/NpJ6/8P1tJfTtk2mlOE7w2P286fOz+ojJCWbTQR6kLpzfEZ8EIqVLDoo2Jqg+50jL5cJaGE2MIjafIHxcXRnEvmPYyP9Zk+EHiUI7pP7wOUQ3pWcKheLZ/7PtKjrKtBdJFC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(4744005)(6916009)(66946007)(83380400001)(5660300002)(6486002)(316002)(107886003)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XTtri0Nk+smCoP++dNCwuTP/RpUqNnkC33w9SntRyMkOJk8wCRKRr0sIzLPo?=
 =?us-ascii?Q?ZHTdne/5anRRHo3/5hOEdaV77pdzs+K3WhGnkBN1xs10YTCpGcIgcdc39Krx?=
 =?us-ascii?Q?m/eHKBO7m0x/LWsd+8lbpnKuMuqhZUE6rrbno7N0H7aJe8aYA/gwhgNjS7AI?=
 =?us-ascii?Q?AYEHYTKVuFTTaWXGmVVeW7QhnsDvzyhVoWSqLpV0+98bGPJ/WqbKeQOY32fo?=
 =?us-ascii?Q?CsjOzJKDlXopWFI8tlhNJjBHU2ftmhY3n1bIvhasx+gtfCLUaBfpbloTP7Gh?=
 =?us-ascii?Q?xGN8oN4mhZf+PUsQT1ro5zhxUP03zLfBgrlwAOvbXuCzC7cyLhHIt+NIhzwY?=
 =?us-ascii?Q?WXdqeOZUj+HfiyMNhIurb0YL4nWQjsJcfPnUfKxQDpyz1msC2TQ4EBbGN++R?=
 =?us-ascii?Q?Crwe9bx4AIWgYNEF8NnudEIzJ5ETx5txXWDgTwQD2cOFTwwW+upPmfcEan1+?=
 =?us-ascii?Q?lkHF141d+Aq2kF1hVLRM9noinyrdLgJVhxzGDbgl9pl859TZmorsVx7AWte4?=
 =?us-ascii?Q?OKOdqmnNakH0kVHLEB2L4E7xlkXGXjZghR8YvUxn+pmdGD3unkS/pxuZKD7O?=
 =?us-ascii?Q?e6w/srC5PQvLNMNvcCkyL3k4NkXT9QChLjrgstAmlJXCfbrOfxuj7YVClSRk?=
 =?us-ascii?Q?QJs7wKkva/ESsC0IMZD6PX2dCqlstE+95daqRXf0GjnbPiqTLInV4H81jCxP?=
 =?us-ascii?Q?sdokdkDLqK9w812mNGbfuXwr6InxxISrJF3sG0s5khugkULkySnqRYdjb4w8?=
 =?us-ascii?Q?okkrjILEcubNiNC9UOktFztcjhuB+lUz3RYsEps9cq88+ITBIp6P/e7kc1eg?=
 =?us-ascii?Q?EjemTND6APepSqNRrvTTNu8mpdS4tNKJF4XLkU6VZgdBQ2eqASnETRK+0D9E?=
 =?us-ascii?Q?qdyvWkhqznUMhIOmyxGtprpcBNdkjXIRT7NotUkJ4JqzWMfySOjfobAHPvkV?=
 =?us-ascii?Q?sj9QrNCmqLcepjiQ4TP1K39m+SR8F4583N4paoaW6vZjkvjTKfxQvR3jiKz0?=
 =?us-ascii?Q?c4nw8uumJebJnBH8eowirOxMroubfgan+hlqhWtlgd+y1w0/NzfNtixRNtEO?=
 =?us-ascii?Q?h82wqJJlE22HJc+id4Rj7HsqBxlKn2yAMNJiCuEZL0xLDEWCqOVpj9sdtOUt?=
 =?us-ascii?Q?y5R/aGxJIJXwVYQRAYxay8ZKO+lHUBCbJjb5fNlkGcZ7GyBcZ1MBACpsy5vH?=
 =?us-ascii?Q?MQsJybBFZ0SUXitdD4zj1BjcqwwRu6WVNvRnfEW0SiLqQrSiO6RH0BXxfshx?=
 =?us-ascii?Q?chNMsgvx90wl9LoWVCOEb0ZEfh+RaxYwvHn5kvjTGwztZfjJDDW2yx5CTHRf?=
 =?us-ascii?Q?BX2+mPWjvnCX+rr03uUzgSHqbbGseoQM3ZsgLqcas6v03z4HUPyj1bfCdRG/?=
 =?us-ascii?Q?LBkL5PazhUYNzqCuTZD29K+orpL1ReoYfjOfJoMP+TzQ1VZpE+FVZozl8kW7?=
 =?us-ascii?Q?Q4WugCEjqtZIGz1s7JxlFPZiaYP29zTlMzJgwAOfYcnx1db2LQKd/O8QB1AS?=
 =?us-ascii?Q?fZlrveZ4dYxqtTIPAbTvfVpvmnm0jr5B3SUnSciQ7sd4rSUFFeqpaOO+tX75?=
 =?us-ascii?Q?aMv5CQGkJWGOhy2ZRvLAFgc1Pt3u3ze/bGn1mdc7az4PQVJQUhGueK5olcwt?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6YhwkrOiyAY12er7VsnALcPEHOL1n2vLXLQUWOdKIW9e5D+sNa46prEvns90hjojb4c5OSZ8WxApnSSql9XFw4Vit6spT8vPZe/EOphZzapNle3qJ7CAuo60kntBhn6Py7DYTwwyKKzrZP+YrKONXNrrDnEQInPVIpUx/rCmkb2qL9RHbKcuQLcoMqX7/egpxJMqKus87UDfw+2YeaH+GreoaUHBS6dndmPPRK2CUjF8FBBWMzEEy2IWggYsV8uLZpkvH9IoYhtou7mSHrCPkVxqpPwiLijwRP+99AUZ7xGlIctL363WpZIsq5O93MYDk6MNqDcKmiWiYWIHluZS4vpIsrsX1vuU+zL0ZNJ9By6Fdb6kLLG6l6mTJpw/VOWy2dVYF3GPZcN3YqHebnc4QtNgM8+8LeXlA5jVl/uyP4LdXXv1cd2j4C++hKgpdTsww/mGrrUMPOOFWqxPbYyQJTLjIfnwZliZNbS/HjDADZgHVKQI8tegaJHJL1UnJYz/3wG0u0gDNtvlubUCtbqTaaug8FxjB0EnSuUMbsFdMTfUzUGCLeBuZ7Lxs9jCBL6/hXs0FrLJgQh0QhwFqScTgLXMMxG/vNutedxnBtBPqWYHHk95MoZRmcueCVWmU77fu2NksCpUGUSyzZN77mNWcKuO+ROT8W2pdE5arNb8OVGWMzpljOexDhWfU4L2WXKAZc5WuZFi2lrUoaYh0UyXQEI2xwkfcjUkna4Xq1EfEG8IH0c9n4DqH07bPolxraoDBtULmU+qxS8kYnVlVw/hoSjV3ePAwewHEr0oRJXVnW0HOs7FvIGiCVn2u5d5oWtXrzA0LM21yprwuriOByG36l3ltnGY/e+NeitrIqNvcbn3I96PfgQkfH33gb6VFrm3lUnxO+Gd4OKFw5q5TYYlhQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bd813d-7273-41c1-244d-08db5315c53c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:21:57.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW9rseCGQqAWatr10Qzizc2nM2kJHC/wwouIQ6F2ZQ8ErXmkYoJmXnEVcEM5SzrE/yldRI0fFwHjn9sE4X6NnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-ORIG-GUID: exUI2Z0Qg4bWTLqpJBkMYTzz2EqWlIor
X-Proofpoint-GUID: exUI2Z0Qg4bWTLqpJBkMYTzz2EqWlIor
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Empty area will return -EINVAL if the search window is smaller than the
requested size.  Fix the test case to check for this error code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f167d6ef81591..d295fdee2faeb 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -2697,7 +2697,7 @@ static noinline void __init check_empty_area_window(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_empty_area(&mas, 5, 100, 6) != -EBUSY);
 
 	mas_reset(&mas);
-	MT_BUG_ON(mt, mas_empty_area(&mas, 0, 8, 10) != -EBUSY);
+	MT_BUG_ON(mt, mas_empty_area(&mas, 0, 8, 10) != -EINVAL);
 
 	mas_reset(&mas);
 	mas_empty_area(&mas, 100, 165, 3);
-- 
2.39.2

