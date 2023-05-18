Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BA27087EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjERSoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjERSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:44:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4FDE46
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:44:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IrcY012408;
        Thu, 18 May 2023 14:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=or0gvhiuj20PZDjQz2A9EQ37j0qVAfTsjFswHLJTGPw=;
 b=CSWqg4nUL6VOOAxgLKYWBJUqPrEMgnAi30X2s/XfZgwf69fT2F7vGduGLbollPkTQc04
 B37U2yN/d9Wd4oAEANtNiOvXyoXs4V7NsNhXBjqMwtpj4MvVUdDMUZtnI1pCYEorRbT6
 uiNGrzv1zPGKghZBf7o42tJXzbTPogPGuUs7wVcBvHt011e9Sn5ZiCRgQ9xofAjbH1+h
 BBRnPRjsUdO9ApLRrIU32JdyqzF4VUGVGtSGpU4HCcay/Rbmpia3I0ob7jPGNlPwrtfW
 OSG/Gx9cpfN0Hbd1+vnU/ASNqlRa/7AyJt5mKnksw8+mXsIyXUXgx3bjOZGggOZwANu2 Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpjrc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDRG4I040136;
        Thu, 18 May 2023 14:57:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106mqvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 14:57:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kivZMgiCADNvPP/bnLWhfr3RKRkyLFoapxV2Ia0qdKx54mLmZ92WIISyr6zNVK6uoJ1m2MRG7JJZ6KsGrGeskg1f/CbWwWG5yVwic1Z9ZQHexDkGBlGd5hTGCiALpRH6ePF/IddfFPIv1hOPgPqHUNpcKZXdNt4TzHa2hHpp6VuA4yHGzTrkCTvppOuMzqfJqlCz5dJd2dfzi6KnF8hZfQYYBnHW7Vli8QCjutqi7shIEHUwQqLXxfn2iNC89krov9LSn10nUWRwmm3Pr0K7wCev1tuA+946hDndRGBbAwzxZxCOPwxRsFpZ8ngf/DJNrZ+G9Myhm6nsR7P4CmuDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=or0gvhiuj20PZDjQz2A9EQ37j0qVAfTsjFswHLJTGPw=;
 b=NFkpgovCiU5LN0OIWHjH50j+Jd8suDj0ot/Tm3b4qAUwEaJhtjJtKX5pzUkrwiG+tPlH73t4IxmLyUUg67VJQt2B/Zx+jZrXKTJ3fA4a//2cE12jvhNtOoNTVNfrt5VJIXlfvuutzjbvIjR9UlFg9YzrolxHL4+IlYzYzJXefxilehcY9TF5pjxwahX+Hy9uSWIeV+EtPSkIE/VZVqwiTCkpbNmklIt+aIPWT3SbigvMxDYd765YewT1z2Tq278kewyEkZ2Sns3gSuZxbhoS/0IrXsgdJYdZ8QV/4Q/EwbknlFLlit9tbULtkcQwkTdc6yjNC4az2XLXjboQVAPSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=or0gvhiuj20PZDjQz2A9EQ37j0qVAfTsjFswHLJTGPw=;
 b=GBFkYnvAIxBjUYAhRkSwprKBJZl+rmv07s4BnU34WE8lqSFPG1OvycKvzGksrsAE3UzCIsF/NM7mNqY5/N9GwFfePYIQQO6+zeEDwg232V2oiG/FEF3eaj2UwtIRD1pCNr1o0BT79LVKRbssqFZGOZoFRKpwgO0zwr46mNb+1No=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:57:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:57:03 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 30/35] maple_tree: Introduce mas_prev_slot() interface
Date:   Thu, 18 May 2023 10:55:39 -0400
Message-Id: <20230518145544.1722059-31-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
References: <20230518145544.1722059-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: c9479452-a750-486f-a4f6-08db57b023ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1yDEz2POcDLDu7IMjvaVrCiVWrmpyY/N0zDxhKerde7AFqJwsERgEZ8LaMDmN/ViJA0PkbOCPgV56L0ro2ddqoooBwVQ1Rv7kcypCiONX+dbSk4tg8QT95d5FnTtMeNbs9DUhF0otygo326vqySKXC7ngp9tReKos1EI3jEnJqRbp+anS2itGzp/dq/V2u5Ttp5ySwSmeosF6oZBFNUBq6XX4jUrG1vq5zUri4//bGVYpka9+kWlOZEONXxC97Hp4evM3ASXmDXd5X/t6syiYF3kabjsLJ3ZQimXNYGKzRoRfOgwsRG8qKyB+24+m6lVFiaIypS50FHebLP+pMFd3Cvs0b1mbvGQ6WROz5crWQQmlcMNmR+a8ntad+KVj3ICRzeWM2n6+sxreu4Q8lwO8T2TdkjChrgjpgU8PfV/axZqRvXr5FOz4JThWUK2JIgwaZdPTpMuCq2v068r82/kwb/xYZfaXyZIypbQ90Fan+4v8F8n2uCLkFA/9wty/x3A3V1/FehMliG7ZgadJREDBmw+Yh0qaAvSeDszm8p8uKmC62jupp6rXBMyIVegUk2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(8676002)(5660300002)(8936002)(4326008)(316002)(6512007)(1076003)(83380400001)(6506007)(26005)(107886003)(86362001)(186003)(38100700002)(2616005)(41300700001)(478600001)(66476007)(6666004)(66946007)(66556008)(6916009)(6486002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0MCPEWLhyEsDB2Or1zso+damDL0TbbPnAZxqgVEbX8nUL0cMMstfE0Pku30n?=
 =?us-ascii?Q?uLQx6QfoFURk2C9VRdnY8nQEwu47ufXCTmdCVV92TxNai8g/Ypz6AE4gQbq5?=
 =?us-ascii?Q?KZ36vPTxgOC2dALj9NAFefNc4Prr8TjcCm+lXj+zdui+Yt/53dTkMQXqfUA6?=
 =?us-ascii?Q?itkW4cKkzjCbAnR6mO9ojWAQ8/wabtraWaQW9YpE+1Agvfqw5NGpg/OgZca9?=
 =?us-ascii?Q?RKkZDY/FJunBw1uGIx6lnGqv8sBBIzsGVLKdBTFXLpJmWIvt8tuxo9k9JVRq?=
 =?us-ascii?Q?BNoqWY42wJ7dz9+8wThNQrZ9936MlvYDL0BQENIiBuBvIP2uTmTv9/aKJLJJ?=
 =?us-ascii?Q?BGnvmu9VLKFRcWGWyF3jpDLy6IrbFcE/kzFD+PPthieVTh9yQJ8FXDS7Lj75?=
 =?us-ascii?Q?Z4m/au8p6H9C/WMhmJ9s7EcR/BgCOvPSEAh8CdbW4A1Ttvl/wkKW17ib9J4w?=
 =?us-ascii?Q?05VGeRfVgYF5abe1gYr6JY86E/pkxcbnjucxUj4BG7/l8QGEo60AYZtg1wBA?=
 =?us-ascii?Q?VTE5ObgTajLerHVDeSmeMJMM464EcmBnJxIemNWuW6GpDIfgYKvmd1GMjd6+?=
 =?us-ascii?Q?cMR6WhFdOjeSfjIizHUK4II9q3eAYCWmFMEYgvXy3eJRSXJeErkZ4sZO8bw4?=
 =?us-ascii?Q?h6BTO9TnFr6dCapLA3Iuxz4KFgePawDjQp3oRqwmJi7NxvN6oHx6941ekPSg?=
 =?us-ascii?Q?XGsYCFDYssFmkZY1V9T9jcC/5Td7oDA3Hkx1bYeeG5YSsD13Y24YLOXKyimP?=
 =?us-ascii?Q?UAnhNVBURxX4fLPUdKyhKvj1IzORquiiQcLCGfCgpdGUaHc4Jznzv69LYJFS?=
 =?us-ascii?Q?IR+U9Bvn6tYyIu7fh4Az0lIjJW114WvzWDQnqWD0lx9LVDpHPLllNoWFQ2z6?=
 =?us-ascii?Q?JNH6ls9panZZ6c+D+4E7erwlwJAaQjGzTcD6Mtfu6zHL1bk7B7E3Ca/mtCL/?=
 =?us-ascii?Q?VQUBZPE3mplWrdJG0dGo3Dbb9ARzwlo4ftrwyXlkpbYgl1fbWQ8b2ljpU1Zi?=
 =?us-ascii?Q?m72L5MnjKoRx9PLUAXrf0bEGSJN6KC58VI0qKoJ5zr1BOT408fijbKK7igOm?=
 =?us-ascii?Q?LEalfTYEVKpr2UrcN5YLaqigE5XlWkOrVndVHfTBDiCfoam4nHW62nb4RcCC?=
 =?us-ascii?Q?FSnb/lMN1CN9KgVPxgSKcr1zltlsURfZXJaDrEnoHL0rbWAjAY/Nu+HSvLHE?=
 =?us-ascii?Q?aqOsFxE0vKkLJy3Fjuow9S4N4iXSzZ3YLM5yNdSvh1t69GCDhVP4dsSCXLP5?=
 =?us-ascii?Q?IBV+UNr5hbfbC86bp4Yp+6KgO/ibq4YItryaNKcDRnU1RBCFHxPoIYtPN6si?=
 =?us-ascii?Q?ONn27AyUxlPIoSobEcR+BAjMSDmFxFcZjiLIjQkcbZRj2k5tKUDKZTs1JMM7?=
 =?us-ascii?Q?uaUpqBnXGsdXEJYgnyAK5gxdlD/Lg3bMqZcSQzkT0Rak3UJZgJCNWL7m59f4?=
 =?us-ascii?Q?Zv7q5EOLgLUad7zDIFQRoftCN8n4P5hROeVOWRzC54TliI/KOOLWHZSE0t7/?=
 =?us-ascii?Q?V46p4iZT6gUbPTGKJZae5riipEYDrEH6uXFhpx6KcbedhnSNq2W6rgP4LDwv?=
 =?us-ascii?Q?j41Y3JwKjGzfpghWjWa7813GJS8itIsUj0btG94bCFxedtMhIFH2nuVfd5Tn?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Izqmc6ywIC5brFHk8D3kaMnX6QFaWhghxhcHTOLYGlYv6xxIX7zlrg0Qo1Ln8Ro8SR5LOnpQf75p3MRCt2Vo3Fg0lV8FtE2Bbc64+WCHp6DA5Tj4w6OoTYVCh3DwJZVJy18VM+3Pz0gD/IqqeRG51d0PmLp1FpLPU30hERgxNh4g+p6OF3PDLVgmiHTnIbXLGGe6EC8lv0yxk+Rg1hTzw4qU00oWrhFpSsJH0mawl93ZvfYuBXVT3ep/NX00xTjimCzzqcO2b+RlL4fiJx/GBCWkS+eh16kkfiTiHZDzSKci21ytsXN4GtMKmLggQJyD1GRiOic1fMqPYwCfuG4PgQnDyG4aYe1KZ30IUm5+w33Necu+mp4XajJoRUT5ekYS5BZ/tc5vNBIwm5v41af3lafnavmGO9cBwiWXKgoXJBFR5vkaK1Sp1ZEon7Ef4UvJuZgxsOB49ZW9dAMfZbJlcNQsAjSR5UV70YQjJU16TWbXZUuu53atLj7jyu8qm7xXYco6fz1JXYu57pCBD7NfhdvkOsxVE4asCdSHgf5sUqz294nEVJOi1h5XTMWEUPjf3xmBuGzUDxFPwkKM9mklGBMkonFeGQl0i/JeLsiPjVjFSMz3Cv7+iVcIhndU0fXA1ozWnDqOm7INUk186kK8cnmrxaszi9/f/1fVFFc3YGDDTlNUthGYZkqW5o/0CgCeU7ZvqSksG1ZNptVwHr2cASOGyppM+9AG1iEe70zsT4riLKY0mBEqXQhaN/wJh8FT1EDiTlKe0GorkGKN++g/z3+aUlFEQrx21HbvrRDLxTA+JDTpXPpabqajlvclvklU9cTLEmoTNX/DkouPfIMAezrjNYyf4wYcG36pG4KLHSyn0atGJMZGmRl75IH1mRpKIauzLQG13qP31nnOMxp4Vw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9479452-a750-486f-a4f6-08db57b023ee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:57:03.3059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sb/Jw1i9iI02wjT5fKPEVvblSp5Lb0K3oiEzPRWzvDQXE6TZb8PINUk/mRrxhzPooWRRTKMA1M9x9YYiYYJ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180120
X-Proofpoint-GUID: 2FMAuV0vgW1Ao2acIbNdOwHuF27khLAr
X-Proofpoint-ORIG-GUID: 2FMAuV0vgW1Ao2acIbNdOwHuF27khLAr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the user needs to revert to the previous slot, regardless of
if it is empty or not.  Add an interface to go to the previous slot.

Since there can't be two consecutive NULLs in the tree, the mas_prev()
function can be implemented by calling mas_prev_slot() a maximum of 2
times.  Change the underlying interface to use mas_prev_slot() to align
the code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 232 ++++++++++++++++++-----------------------------
 1 file changed, 90 insertions(+), 142 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 25748014fe34..f0e9ce5b0515 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4531,15 +4531,19 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 	int offset, level;
 	void __rcu **slots;
 	struct maple_node *node;
-	struct maple_enode *enode;
 	unsigned long *pivots;
+	unsigned long max;
 
-	if (mas_is_none(mas))
-		return 0;
+	node = mas_mn(mas);
+	if (!mas->min)
+		goto no_entry;
+
+	max = mas->min - 1;
+	if (max < min)
+		goto no_entry;
 
 	level = 0;
 	do {
-		node = mas_mn(mas);
 		if (ma_is_root(node))
 			goto no_entry;
 
@@ -4548,64 +4552,41 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 			return 1;
 		offset = mas->offset;
 		level++;
+		node = mas_mn(mas);
 	} while (!offset);
 
 	offset--;
 	mt = mte_node_type(mas->node);
-	node = mas_mn(mas);
-	slots = ma_slots(node, mt);
-	pivots = ma_pivots(node, mt);
-	if (unlikely(ma_dead_node(node)))
-		return 1;
-
-	mas->max = pivots[offset];
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
-	if (unlikely(ma_dead_node(node)))
-		return 1;
-
-	if (mas->max < min)
-		goto no_entry_min;
-
 	while (level > 1) {
 		level--;
-		enode = mas_slot(mas, slots, offset);
+		slots = ma_slots(node, mt);
+		mas->node = mas_slot(mas, slots, offset);
 		if (unlikely(ma_dead_node(node)))
 			return 1;
 
-		mas->node = enode;
 		mt = mte_node_type(mas->node);
 		node = mas_mn(mas);
-		slots = ma_slots(node, mt);
 		pivots = ma_pivots(node, mt);
-		offset = ma_data_end(node, mt, pivots, mas->max);
+		offset = ma_data_end(node, mt, pivots, max);
 		if (unlikely(ma_dead_node(node)))
 			return 1;
-
-		if (offset)
-			mas->min = pivots[offset - 1] + 1;
-
-		if (offset < mt_pivots[mt])
-			mas->max = pivots[offset];
-
-		if (mas->max < min)
-			goto no_entry;
 	}
 
+	slots = ma_slots(node, mt);
 	mas->node = mas_slot(mas, slots, offset);
+	pivots = ma_pivots(node, mt);
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
+	if (likely(offset))
+		mas->min = pivots[offset - 1] + 1;
+	mas->max = max;
 	mas->offset = mas_data_end(mas);
 	if (unlikely(mte_dead_node(mas->node)))
 		return 1;
 
 	return 0;
 
-no_entry_min:
-	mas->offset = offset;
-	if (offset)
-		mas->min = pivots[offset - 1] + 1;
 no_entry:
 	if (unlikely(ma_dead_node(node)))
 		return 1;
@@ -4614,6 +4595,76 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
 	return 0;
 }
 
+/*
+ * mas_prev_slot() - Get the entry in the previous slot
+ *
+ * @mas: The maple state
+ * @max: The minimum starting range
+ *
+ * Return: The entry in the previous slot which is possibly NULL
+ */
+static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
+{
+	void *entry;
+	void __rcu **slots;
+	unsigned long pivot;
+	enum maple_type type;
+	unsigned long *pivots;
+	struct maple_node *node;
+	unsigned long save_point = mas->index;
+
+retry:
+	node = mas_mn(mas);
+	type = mte_node_type(mas->node);
+	pivots = ma_pivots(node, type);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
+
+again:
+	if (mas->min <= min) {
+		pivot = mas_safe_min(mas, pivots, mas->offset);
+
+		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+			goto retry;
+
+		if (pivot <= min)
+			return NULL;
+	}
+
+	if (likely(mas->offset)) {
+		mas->offset--;
+		mas->last = mas->index - 1;
+		mas->index = mas_safe_min(mas, pivots, mas->offset);
+	} else  {
+		if (mas_prev_node(mas, min)) {
+			mas_rewalk(mas, save_point);
+			goto retry;
+		}
+
+		if (mas_is_none(mas))
+			return NULL;
+
+		mas->last = mas->max;
+		node = mas_mn(mas);
+		type = mte_node_type(mas->node);
+		pivots = ma_pivots(node, type);
+		mas->index = pivots[mas->offset - 1] + 1;
+	}
+
+	slots = ma_slots(node, type);
+	entry = mas_slot(mas, slots, mas->offset);
+	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
+		goto retry;
+
+	if (likely(entry))
+		return entry;
+
+	if (!empty)
+		goto again;
+
+	return entry;
+}
+
 /*
  * mas_next_node() - Get the next node at the same level in the tree.
  * @mas: The maple state
@@ -4798,109 +4849,6 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 	return mas_next_slot(mas, limit, false);
 }
 
-/*
- * mas_prev_nentry() - Get the previous node entry.
- * @mas: The maple state.
- * @limit: The lower limit to check for a value.
- *
- * Return: the entry, %NULL otherwise.
- */
-static inline void *mas_prev_nentry(struct ma_state *mas, unsigned long limit,
-				    unsigned long index)
-{
-	unsigned long pivot, min;
-	unsigned char offset, count;
-	struct maple_node *mn;
-	enum maple_type mt;
-	unsigned long *pivots;
-	void __rcu **slots;
-	void *entry;
-
-retry:
-	if (!mas->offset)
-		return NULL;
-
-	mn = mas_mn(mas);
-	mt = mte_node_type(mas->node);
-	offset = mas->offset - 1;
-	slots = ma_slots(mn, mt);
-	pivots = ma_pivots(mn, mt);
-	count = ma_data_end(mn, mt, pivots, mas->max);
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	offset = mas->offset - 1;
-	if (offset >= mt_slots[mt])
-		offset = mt_slots[mt] - 1;
-
-	if (offset >= count) {
-		pivot = mas->max;
-		offset = count;
-	} else {
-		pivot = pivots[offset];
-	}
-
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	while (offset && !mas_slot(mas, slots, offset)) {
-		pivot = pivots[--offset];
-		if (pivot >= limit)
-			break;
-	}
-
-	/*
-	 * If the slot was null but we've shifted outside the limits, then set
-	 * the range to the last NULL.
-	 */
-	if (unlikely((pivot < limit) && (offset < mas->offset)))
-		pivot = pivots[++offset];
-
-	min = mas_safe_min(mas, pivots, offset);
-	entry = mas_slot(mas, slots, offset);
-	if (unlikely(mas_rewalk_if_dead(mas, mn, index)))
-		goto retry;
-
-	mas->offset = offset;
-	mas->last = pivot;
-	mas->index = min;
-	return entry;
-}
-
-static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
-{
-	void *entry;
-	struct maple_enode *prev_enode;
-	unsigned char prev_offset;
-
-	if (mas->index < min)
-		return NULL;
-
-retry:
-	prev_enode = mas->node;
-	prev_offset = mas->offset;
-	while (likely(!mas_is_none(mas))) {
-		entry = mas_prev_nentry(mas, min, mas->index);
-
-		if (likely(entry))
-			return entry;
-
-		if (unlikely(mas->index <= min))
-			return NULL;
-
-		if (unlikely(mas_prev_node(mas, min))) {
-			mas_rewalk(mas, mas->index);
-			goto retry;
-		}
-
-		mas->offset++;
-	}
-
-	mas->node = prev_enode;
-	mas->offset = prev_offset;
-	return NULL;
-}
-
 /*
  * mas_rev_awalk() - Internal function.  Reverse allocation walk.  Find the
  * highest gap address of a given size in a given node and descend.
@@ -6017,7 +5965,7 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 		}
 		return NULL;
 	}
-	return mas_prev_entry(mas, min);
+	return mas_prev_slot(mas, min, false);
 
 none:
 	mas->node = MAS_NONE;
@@ -6232,8 +6180,8 @@ void *mas_find_rev(struct ma_state *mas, unsigned long min)
 	if (mas->index < min)
 		return NULL;
 
-	/* Retries on dead nodes handled by mas_prev_entry */
-	return mas_prev_entry(mas, min);
+	/* Retries on dead nodes handled by mas_prev_slot */
+	return mas_prev_slot(mas, min, false);
 
 none:
 	mas->node = MAS_NONE;
-- 
2.39.2

