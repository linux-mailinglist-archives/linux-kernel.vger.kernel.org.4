Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D96C6EE3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjDYOO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjDYOOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:14:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54843B1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:13:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDiZb5006059;
        Tue, 25 Apr 2023 14:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Cwe2E6An3ilIZZ99/IBBEa89cMtvEgGITgAPgWQCdgw=;
 b=LR9i+Aorzu4QSjLjC3Rdjg7fTF1M4tD2gMlWCPtULkgjDJcYf7OjVXUHT5eIytUkSzO5
 tVnYI5hA0wzV1cGQFeF3HfSe8BjWcWZZU5ZUte0JivfMhJT7s3AL/YnioPWIbP7Zv2gK
 j0RNbjdPeQYvIOhnL5HT93GSScc1fbGN/AE4ETYijQdXBA+s6yaqwuTFXZ+7fb+l403h
 UTCU+LUjsXLWU3SqGNXrV00GCjr+08zeFYsusfM4TTK7Rx9IIgaavQoMCAHpEjdvtc6V
 CB4xXLOt+jjUOvQl+LVvNEKE26TWgNHJtQFBMTXqBZHRQc1f+JXTWXzKb2/MPPLABGv9 kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q4661wgpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDalUR025010;
        Tue, 25 Apr 2023 14:11:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461crdd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glsvj7ZzWMCF865BrFcYWMDvxlsL1tHMUJ8lr0GK/XKrypvuhUT3aSEpXNqQRUaVeXZF+AwpnFHFbURSNzMkD7h1yYZ6sTDj/chkpCRy3cRr2B6WbuqLiUqbrrkCZWJvt6admIbgluv2s18K2c3qeGokCdNCtsaF0w+CDNA4D1MoyKRtujh0Th0i2JmHAGYl5NCFUXvqJlrJlq2KZ4SZQ9SU/Ytx3xUNfryNo3uQe1Y66VO8aMqammNAiS4qCel3L0ixDXnaKVpHogYmFNJ7W7f5KQVBc1ykTsBeQT31YVqShR/1nL2VA+sQWy7nwaC4QM9ge94Rq6YQ/UtLBXbJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cwe2E6An3ilIZZ99/IBBEa89cMtvEgGITgAPgWQCdgw=;
 b=FaUwWMhyhDO6liEAri1wt60hitmffEd8tENgVWh7fp6FfSrBUrnIz9AAVB+K4TJ0Dfrrf2Hg4ya1DDlqJAnqD/pyswvSn7a56mAG64U3YZZqgJ0GUvVB6LaVtZbb21rqH/KGqKhjlfpTlE54D4Ps8qjKGq927+NUH+tvi3DvmNbdILAxWi+YL6fHSQAO9tUW2+AxTPOUqfprRJ0giLnIVp0lVzHOl15006oqF8g0RpKfCl4dFkvC0wLhfQ0FVqawphvvXEQxVD/oxxWUrgK+8fidBG9Qjdty6ArHuZfX8ysmqW5YyUjIY1HXLkVgV74L9u9bTpGgAbdtaHDS5G5piQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwe2E6An3ilIZZ99/IBBEa89cMtvEgGITgAPgWQCdgw=;
 b=wfqeQ/5dibdZtJ0b44JHqdVV4A76dgyZ0WlRJ7H6Kl4Sypz25wzLc6ZDm11QPGgwM8j36HHN7E7MCOPT3Ijjzee2Zue0ELoLQEeLiZvggpuezKA7YsxpX1wjQ687YmGzkJ4HMrGC+K6S/veX6IGxExoD9ZmC/Zy6H250pJFk5Lc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Tue, 25 Apr 2023 14:11:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:34 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 31/34] maple_tree: Add mas_next_range() and mas_find_range() interfaces
Date:   Tue, 25 Apr 2023 10:09:52 -0400
Message-Id: <20230425140955.3834476-32-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::7) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: b6afc938-be71-4b15-d6b4-08db4596f9bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtuSP45pr6UEZg5Hgw84rM5Kd7NFy+KoljiH5uzJy0ENqKifh81214k6K/XZi7q4snfBSDdJ2i0RUft448fa3vERyfiX6hnAD6f+ECMZY+FMIPv+MFXxUovfpdypcIxDZVV44izWFR2PL17RrQAr4UpOsQvyCQ+mkf1ujNoAHXnuy7hjGddisE3ocKjqeUM3Sxr7y6ABsn7yk+OK1hDmAnDHGGnkFQ46VXZxuMclyWPs7DUQWzjIg+8YG9IcY/cg6JuzZLLZXs9qJb3EZje2pRFYOxm36VkvhXLrxwD7a7M/KGC83v79WNF6bja8mGA+upXcosW1fUQsP1b7nDZIlFVMxeGpk0q7Hw3uFrTynLeoEB0gd0YkDfN2iHXO1Aq6IGLJwJwlqSFGDg6v+PzTF6c09SVpF3GfRqI01US4tgKUQIffpFnkIEmEqZMaf0Xj3osxcw9guHbl+kI6ZiUmDwmRHNQVidUIRsqeeEoYRz04guLWjRaq6ABIlZ0FK70givyx0XrJpC08D+5OtXUTzR4K+KU63qbWZAMKoQkkNvtQ3pLVEcbuFmq1N7OqULZd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HG1JfSQDdLYL7wPgzuhLWVHWqQysaBACWe7Nsnb2qgy4459P2kpJnKS1GOPh?=
 =?us-ascii?Q?bqZZwobQerkTFtleKBqT178BOA/X9iY/LItCmgUCRoaUS8eaH3UhJpW2q7Hi?=
 =?us-ascii?Q?Zl6tR8jq1Sk1OiNJCszRi8H9j4i7xro7rybPXGTU+Av2sqfIWaHDEDNhVmCe?=
 =?us-ascii?Q?QqRUwwLSPrLka/2WnjBKvGbdoMQ2eNDmxwfxDMCqHnJcNIjqm+VD3BlRg5vM?=
 =?us-ascii?Q?DkYjxdPgw4Y1dcgnzPJbRgikJN/dGd29O0cCUPpoU/wW6dyNEOcJpYrsLV+N?=
 =?us-ascii?Q?iPKMPtthlAa+p/0ZoRrRgz3a/C7n2oAdTLjIjBuJ9vMmo5KBEafDuWdpXkI+?=
 =?us-ascii?Q?N8/hgY7BMFJeRQXOe69x2zy4KiUgqU9jFLngIYnP1XZlw7x7yEmuTaGja1bA?=
 =?us-ascii?Q?i01QQtjBRgoC3/ja15RWVsLgzPtgQUKUXo/gHfRmA+nNE4Ym243Ffa1rl098?=
 =?us-ascii?Q?wGLtIh/NbY1VJDey2Wig8phb8HSougk0QUBQhOqast52CRI7CnsVlthteEVk?=
 =?us-ascii?Q?heIGk9cswbaoUSEtLWZU/Q4aGpmymeNi0qMOrnhl+Af8YryVYGCCOxZ50B2o?=
 =?us-ascii?Q?UAQAjjL3vWMBnpNRIztulLRynDhV7VAT/nEDfE0fD+u5p3N4o4lM9mPW1OYy?=
 =?us-ascii?Q?GYZ+JfN7Y7bV5ywQs/iKm1AbOQaWnzH/1cCiZAAx+SC9jTL39byn3btMQhKn?=
 =?us-ascii?Q?ucLVLt7qc13xcne6NP9fWK/8goKaO6yUtp35cgq2xE643NzopSl5crti9+X4?=
 =?us-ascii?Q?TygvQPCBvbcDL7Km5xpJ+ZrmYwTL7U5OWs+b3LP9u0CIELbQ4PgbB2MwkvwG?=
 =?us-ascii?Q?GDuIKQl10tSQgYHELW/DHx6Jfj0mwzpRB5piA5cOknLxbVL5EJQhYA37e0A+?=
 =?us-ascii?Q?vzBM5AUiNmQPIYel4nL6s9HSLIZ7alFBe+/Ksou5V29uQqZ0R8Z24XBU9Ztu?=
 =?us-ascii?Q?7TeDR10For1xiCkLDV/idBEAjdVEsxZ27TD1HD8WS8dFKxUH28mq/DQJ2U4h?=
 =?us-ascii?Q?mFJWnt28etaTx8BsG/+q6vMgFZwSJFG/HpJxAIEgDv3gtIFzMckwLinRM/WI?=
 =?us-ascii?Q?AfXnaPLkMoFUUpfEVHOWC1u3bMKBSGAJK/XUMy+zo9CfBMUtcdzgVRSSqMtq?=
 =?us-ascii?Q?1YVH8UkF1JXt+TAr9m1Nyjtoqnoop2wmPkvLlrX8MJojkyAS/DxaA0TuCANv?=
 =?us-ascii?Q?H7ZJthMsZ6ima2qduhLqeLmSEXow7ewofzAYptgHxjj0sdMmvAUTk7NpmshB?=
 =?us-ascii?Q?RrmApyrTLq2PmHy7uUoCHo8oWAUuVXPQCcMaNnTr09nTgi2MTK0jlxLqfLbO?=
 =?us-ascii?Q?xO4zq4gXS63a1Ily05bG6mNIpna23yYy4LXuXa5yBxMfTarWaaUJVD/pVdFi?=
 =?us-ascii?Q?etUi4pIzKjFKES5dbFO6rhnAs2l6CfuM16QdZEBIP69PNgPQLWmVVIuCdH4C?=
 =?us-ascii?Q?tBvutJcy7btG/1Us9E8SNF7MXdPt0PNcVpHwRvcYZymyP19FBtFJe3L9ifzh?=
 =?us-ascii?Q?LIMU5A0Qs9jE6lhzFphfG98GaRqzYdjLI6n/I/DIGkgt5am1X/s8SyDNcV+p?=
 =?us-ascii?Q?5jV+uXxMjgqtXtwMRE2dvPyO/i5gGW0gy3W3B3tSOMxz3kBt/7SUGeoohsPU?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: utSP+mPRwwgwjisM+ek0do9z3BRQD5H51iajqe+9ihvp44GhEoK/gVT58o3/XRKZZB3uJg2gHPXS4EML1r8TSWqz4rCA/mx7u0SrpA3J+9lGrDAmBOo/Nu3/6gX03DQEzHFGGyTFAahmhauXqF6s8NVAE93UO2sRmZ890h9OU9vASp6hW4jojDX/gAdv0OFZxrohBRoQIMgGgf1hivdRJRKk7YU9a/+vkX5S0mvMvuWKkco5Y6wrY6YMYE0EtYc4/5mhmu4ecFiNI9F05HWOuFZGRXUw/pjY5fGfaKUyJsW40ZfKP0tlff4vp+yRn49N0JU/xLrW0vgz0UkuERJILY+btErS2YIQ0aTMZD6zvIyyMeB1olKYXOHqhdF+n9kw843PzhT3m0ibLLfg5UXXds27Pfl3dw5+c01JPDxyZmUMAdlsvyiTywKl92UA+BWv0K9tiXdh6JFidRNXlSEjZHBs7bybTgiL9AVihI7AI5yvl//RAgVUEfX5DNf6ChuHE771UKRbeBkhvsow7f7j6+B0eVikOoxm7iAMB8fEZW6cQEOhxmJSByeoquXaXAW7l0OPtNYjbkAhcPNTM2D/tnf/eUPiBMqXDZgljnxit+AT4rRarzETC54XpzGuoykMK2H0Kv/NnQoS20gjyHt/N0V5v+ENHmTzRcjp5gLLNhegZviAh3nrTaaQbS0geH852sjURMiU2i90KQQNdeVPDnXfsjSsf4xk4lsR50VgWH++YWOHKqgTRgUiu0irRmp8tpUxru+ohsnNHMWq3UlEckOd9BEf4C0Vi1bhboEjE266naRhUN9l/rwY6lmhHDxtakww7+q89525LCpSUrWG7CjYQToQWlHRPvvavi5iVYQ2h9owWA+dpcuS723F1g3lFRf/uTwb1mUFPl6kcCiGNg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6afc938-be71-4b15-d6b4-08db4596f9bc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:34.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ndwc0dttlEvf0UkjAZ5Tx+uvDQLv/JWkyauggXCeeBgP1p1UB8ugJj6+4RHKMlbbKQDd95xopbYTPnm2EfMIZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304250128
X-Proofpoint-ORIG-GUID: EIKEmd8HKhYWBO8pQTV797H4zd_xmm_t
X-Proofpoint-GUID: EIKEmd8HKhYWBO8pQTV797H4zd_xmm_t
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of the maple tree may want to move to the next range in the
tree, even if it stores a NULL.  This family of function provides that
functionality by advancing one slot at a time and returning the result,
while mas_contiguous() will iterate over the range and stop on
encountering the first NULL.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |  14 ++++
 lib/maple_tree.c           | 148 +++++++++++++++++++++++++++----------
 2 files changed, 125 insertions(+), 37 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index ed92abf4c1fb5..1fe19a9097462 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -467,6 +467,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries);
 
 void *mas_prev(struct ma_state *mas, unsigned long min);
 void *mas_next(struct ma_state *mas, unsigned long max);
+void *mas_next_range(struct ma_state *mas, unsigned long max);
 
 int mas_empty_area(struct ma_state *mas, unsigned long min, unsigned long max,
 		   unsigned long size);
@@ -528,6 +529,19 @@ static inline void mas_reset(struct ma_state *mas)
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
 
+/**
+ * mas_contiguous() - Iterate over a contiguous range of the maple tree.
+ * @__mas: Maple Tree operation state (maple_state)
+ * @__entry: Entry retrieved from the tree
+ * @__max: maximum index to retrieve from the tree
+ *
+ * When returned, mas->index and mas->last will hold the entire range of the
+ * entry.  The loop will terminate on the first NULL encountered.
+ *
+ * Note: may return the zero entry.
+ */
+#define mas_contiguous(__mas, __entry, __max) \
+	while (((__entry) = mas_find_range((__mas), (__max))) != NULL)
 
 /**
  * mas_set_range() - Set up Maple Tree operation state for a different index.
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 377b57bbe6b9b..137638cd95fc2 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5847,18 +5847,8 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 }
 EXPORT_SYMBOL_GPL(mas_expected_entries);
 
-/**
- * mas_next() - Get the next entry.
- * @mas: The maple state
- * @max: The maximum index to check.
- *
- * Returns the next entry after @mas->index.
- * Must hold rcu_read_lock or the write lock.
- * Can return the zero entry.
- *
- * Return: The next entry or %NULL
- */
-void *mas_next(struct ma_state *mas, unsigned long max)
+static inline bool mas_next_setup(struct ma_state *mas, unsigned long max,
+		void **entry)
 {
 	bool was_none = mas_is_none(mas);
 
@@ -5871,19 +5861,63 @@ void *mas_next(struct ma_state *mas, unsigned long max)
 	if (mas_is_ptr(mas)) {
 		if (was_none && mas->index == 0) {
 			mas->index = mas->last = 0;
-			return mas_root(mas);
+			*entry = mas_root(mas);
+			return true;
 		}
 		mas->index = 1;
 		mas->last = ULONG_MAX;
 		mas->node = MAS_NONE;
-		return NULL;
+		return true;
 	}
+	return false;
+}
+
+/**
+ * mas_next() - Get the next entry.
+ * @mas: The maple state
+ * @max: The maximum index to check.
+ *
+ * Returns the next entry after @mas->index.
+ * Must hold rcu_read_lock or the write lock.
+ * Can return the zero entry.
+ *
+ * Return: The next entry or %NULL
+ */
+void *mas_next(struct ma_state *mas, unsigned long max)
+{
+	void *entry = NULL;
+
+	if (mas_next_setup(mas, max, entry))
+		return entry;
 
 	/* Retries on dead nodes handled by mas_next_entry */
 	return mas_next_entry(mas, max);
 }
 EXPORT_SYMBOL_GPL(mas_next);
 
+/**
+ * mas_next_range() - Advance the maple state to the next range
+ * @mas: The maple state
+ * @max: The maximum index to check.
+ *
+ * Sets @mas->index and @mas->last to the range.
+ * Must hold rcu_read_lock or the write lock.
+ * Can return the zero entry.
+ *
+ * Return: The next entry or %NULL
+ */
+void *mas_next_range(struct ma_state *mas, unsigned long max)
+{
+	void *entry = NULL;
+
+	if (mas_next_setup(mas, max, entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_next_slot */
+	return mas_next_slot(mas, max);
+}
+EXPORT_SYMBOL_GPL(mas_next_range);
+
 /**
  * mt_next() - get the next value in the maple tree
  * @mt: The maple tree
@@ -5993,22 +6027,18 @@ void mas_pause(struct ma_state *mas)
 EXPORT_SYMBOL_GPL(mas_pause);
 
 /**
- * mas_find() - On the first call, find the entry at or after mas->index up to
- * %max.  Otherwise, find the entry after mas->index.
- * @mas: The maple state
- * @max: The maximum value to check.
+ * mas_find_setup() - Internal function to set up mas_find*().
  *
- * Must hold rcu_read_lock or the write lock.
- * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
- *
- * Return: The entry or %NULL.
+ * Returns: True if entry is the answer, false otherwise.
  */
-void *mas_find(struct ma_state *mas, unsigned long max)
+static inline bool mas_find_setup(struct ma_state *mas, unsigned long max,
+		void **entry)
 {
+	*entry = NULL;
+
 	if (unlikely(mas_is_none(mas))) {
 		if (unlikely(mas->last >= max))
-			return NULL;
+			return true;
 
 		mas->index = mas->last;
 		mas->node = MAS_START;
@@ -6016,7 +6046,7 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 
 	if (unlikely(mas_is_paused(mas))) {
 		if (unlikely(mas->last >= max))
-			return NULL;
+			return true;
 
 		mas->node = MAS_START;
 		mas->index = ++mas->last;
@@ -6028,14 +6058,12 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
-		void *entry;
-
 		if (mas->index > max)
-			return NULL;
+			return true;
 
-		entry = mas_walk(mas);
-		if (entry)
-			return entry;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
 
 	}
 
@@ -6043,23 +6071,69 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		if (unlikely(mas_is_ptr(mas)))
 			goto ptr_out_of_range;
 
-		return NULL;
+		return true;
 	}
 
 	if (mas->index == max)
-		return NULL;
+		return true;
 
-	/* Retries on dead nodes handled by mas_next_entry */
-	return mas_next_entry(mas, max);
+	return false;
 
 ptr_out_of_range:
 	mas->node = MAS_NONE;
 	mas->index = 1;
 	mas->last = ULONG_MAX;
-	return NULL;
+	return true;
+}
+
+/**
+ * mas_find() - On the first call, find the entry at or after mas->index up to
+ * %max.  Otherwise, find the entry after mas->index.
+ * @mas: The maple state
+ * @max: The maximum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find(struct ma_state *mas, unsigned long max)
+{
+	void *entry = NULL;
+
+	if (mas_find_setup(mas, max, &entry))
+	    return entry;
+
+	/* Retries on dead nodes handled by mas_next_entry */
+	return mas_next_entry(mas, max);
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
+/**
+ * mas_find_range() - On the first call, find the entry at or after
+ * mas->index up to %max.  Otherwise, advance to the next slot mas->index.
+ * @mas: The maple state
+ * @max: The maximum value to check.
+ *
+ * Must hold rcu_read_lock or the write lock.
+ * If an entry exists, last and index are updated accordingly.
+ * May set @mas->node to MAS_NONE.
+ *
+ * Return: The entry or %NULL.
+ */
+void *mas_find_range(struct ma_state *mas, unsigned long max)
+{
+	void *entry;
+
+	if (mas_find_setup(mas, max, &entry))
+		return entry;
+
+	/* Retries on dead nodes handled by mas_next_entry */
+	return mas_next_slot(mas, max);
+}
+EXPORT_SYMBOL_GPL(mas_find_range);
+
 /**
  * mas_find_rev: On the first call, find the first non-null entry at or below
  * mas->index down to %min.  Otherwise find the first non-null entry below
-- 
2.39.2

