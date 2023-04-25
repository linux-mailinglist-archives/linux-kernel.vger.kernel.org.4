Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AF06EE3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjDYOOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjDYOOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:14:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38C51547F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 07:13:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDi2a1008719;
        Tue, 25 Apr 2023 14:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=bmSYkPqvnaVhYx4pD2rduyU9aD84b3mzvnm2w3DPPtE=;
 b=IidXUwE8YmdGl0fdrg5c/7jbYeFQtCa4+263h6INtHFTYbml8+Am1KIzppoVIF4Y9asO
 dVkKCcP5wsxuKSkVqIQjwLipFIcvJyIFdU4xhD6DN0QxLc29j6FwXuYIbx6bTmybUlDv
 jUBa7DGintogkl/0HCqDy1pKLMb4ErSh7CPtMvsQqL7HdEvQtoOq8Z0WlsqK2IoW64ne
 16PI3yVEqPEnssqxdpST06DRk5M7gXO7oh0zgZ8de3C8kV97zCSkMNxsWGnsAjho72zj
 KiZ200zeMdcDANhUd/ev6bCjlf9PkGelSjJptOxikGvAPGggws1U56ZpZs5Zk5SPYgOf Gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460d5e7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33PDbqwV013387;
        Tue, 25 Apr 2023 14:11:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q46168f3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Apr 2023 14:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSzV0xIbdRXR42kRAGNfHaBXU4pO6WTRNrr6KMpL1dRHrOAE+A7UzxNdi5M1yMWc47OsXMDugPFrziKBLmPba4DD9McrucikAFi9vFUqTPAIPLnF6RW7RNR3Xm3rhbZ/ItEh5G7mhhgUu2u3BI4JG00GcW+ZQ5aWamjdbHIfbrZuueLzT0GIfPkykSYd5BThT6AAftpTJJNbaKoicbrtmJK3FNyVAmYdWiwsYDz16AFDgxSCBp3svcxv90pY0tvnitwNEiDmvtlL2zAfrYNIOfWA+D76HqEhKbYIkFqSwy68g/PMlddMzfDA5FdlVenJ6lL2xjaLoJ5hIUz4UomHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmSYkPqvnaVhYx4pD2rduyU9aD84b3mzvnm2w3DPPtE=;
 b=DKnRhQnY2VA7sH7ZKLVsl6E/c9GwS9UC2gdoDQZa7kkfUtfPtn7qS3GnT8TqLdYz9JSjN8L34dQzP2XuAmOz6J40vcPutlLG7gaNJBc55OquNVT9chH3eWruOEjYwWFQE5ZzsPVLr8S0DhLqFgwzQgBxwjAcjAnE0nslOtT6Zny/RVEyrdM7LNHr3Jw7mecjUy1q28wEKEHwK03IsXl2TtHU6jH6pZEtKurgCcFynwS7dGVnxqUftQ/d070r59RqVqqqHxcqpm0JasiyHY+1ElKlUQyCesHPNHfQ/z9DfjxX33G9LEJTHx3tZraWoxynobLl9uW2mbODAtWlb++YfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmSYkPqvnaVhYx4pD2rduyU9aD84b3mzvnm2w3DPPtE=;
 b=KwWH1GQMrniSUDcG1pj14AhiUAgo9AetL+SCjcbEHfgeSMNugXslA7+sgxhzER+iUHQrHCWTyPQo2wmF1LhRrJoHb6jRqVOZ370s4IuuEhdkxh9xXYIS9EVyeXmueOQOiddlFScE5jTUZ5ULm1ap7k4w9TZtVrrX5rV6T/uZyuE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Tue, 25 Apr 2023 14:11:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:32 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 30/34] maple_tree: Fix comments for mas_next_entry() and mas_prev_entry()
Date:   Tue, 25 Apr 2023 10:09:51 -0400
Message-Id: <20230425140955.3834476-31-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b55d470-1da3-4151-aefa-08db4596f88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJ3yflsN0hQtib0jUvAetPlwu+JA81Gb2pDJYnJGB1r//TwDgNe+ca3aVpU/TDuQueRzGKdMjojZ+MBWJCdGDxJIrQn0Fh/orEhBH9WSWhDlH/LbYrZTYzBPQTm0Aav1yC7HHJKf/la6W6K39pWeiQDyw+e8f+IYH4KtuxmXKIGVJYoqoRHoRFXSJqZeKS9LnW0CiZd+/amHuN4QIoe1X/tineXGeJ0RmefMtJLJXR9zLCwFLiMDjikhqWObQ3+CEfyMbfokNLDFLqdTIsEm8S9KfXypIzV+No/1rk68YjdAm97EFdtZ6eqdhl0c/wesSKZHoUAmZuAyK7/EAzc+dVzgx4S7V4LcGsg9L6ygk5HaMNyYUlJoFzZ0Z7ictDDbJqEhHNprkYgGKPp/BCRXDtcqJqbEJ1o4nR7BtIOzGYJQR2bpZYFC48Cvui7REGR60MGyK0eMm6mT+L3cXHvizCdcBdZI8fQ7iYkI1HSOdYepWsVdUEuFE2xeT6xXJfdxvHEAEv1cHGSI0eYw97mEout52dSrlM2IOTWSE++4azHygdijn2sSRc18WEFvG1oF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(316002)(6916009)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(66556008)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(107886003)(478600001)(2616005)(83380400001)(186003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WJAcrmVj+y/ZynBoY+MvWbs67h4PhCQDyfzhP8nfeOLoBU14QfnQgIiqNKQ2?=
 =?us-ascii?Q?MvZlwKAw62BCMoVjg7DIYzKvyyfbox0rgU7TbdFMJtHxGh8mG0i1x/4v1EOb?=
 =?us-ascii?Q?6QJms766XJL4fZ7ma7iiJ3Vqp20mnXHL3yyGW2IXUN51+XEc42oMcHa4hLr+?=
 =?us-ascii?Q?/3/ftqM4POGbyhlPLzbhvun7LERJtOK2OEOliOrUoVa35T2VuMPsyudaqBbY?=
 =?us-ascii?Q?Ph3Eg7RcMP39h58MVuzwBZOYc0ybx6MUQSzZJdPt/CaEu6M80P1eGm+EktsC?=
 =?us-ascii?Q?A8AS61dcVlTPX/QE36GpTykyVwxpE67mZ6BcqfWILxjidFXYMp+sBl+GQKyZ?=
 =?us-ascii?Q?PvY1d2ZArVL9vA7WFwy8TghRPjlxPYdj3UF7JYfq/WWX/jVUi8A+HOXVOxRL?=
 =?us-ascii?Q?gvc7S8r+Y6460BtHrq4JZPcJOq67A7UvRMhkRcYwVmEZLRDbBltaBynmbhfT?=
 =?us-ascii?Q?YYSfxjQbssYUqDjRyHaiFLAR0TReBd1dzXCjafv0WDMIHjo4AL6ElfbL4ifO?=
 =?us-ascii?Q?xuj8a52ej8uk+HMXLbl/D4Vwe4O+c/9MIqKqBMJjmndWbeBBYVF/zraOChja?=
 =?us-ascii?Q?jYmbnudes9mtfjaGdB3Rw+cgBgFUtWMsDedm99vol6mke98QBJpMWATcm1If?=
 =?us-ascii?Q?M4/i4onpuT+V67v2WT9qQv/7m4vAkiLoeEVzT0s41yuUo7VuYNWREg6+50Jx?=
 =?us-ascii?Q?eJhvQlj26Tn1k/XVbZFdKpgoVRukZHy7VCDlEo0/hQDIek3NUbuJsWPBMNgx?=
 =?us-ascii?Q?GI+tYGoE8hmZhxWAKJp4vIctt/+LSlf+SRIPMGyiqq2bb61WPWbSZGoSihxs?=
 =?us-ascii?Q?F1KX/g0Ny3PHuEiPKiG8nQYLiHlTr+++XcQ08H4XQxwnV/FYzdScfJObJUg5?=
 =?us-ascii?Q?6OpavF7b4VoOH0IEFUBX/qR06hCjKLnO+Rv1+hXsV7y6Toh+UI7DvpPBbNeb?=
 =?us-ascii?Q?S6bvkZwb9mOy9DVolpZNW0VbfrFffRYRTdsZBRTG0+pCCYlnLfxDQVYdxanI?=
 =?us-ascii?Q?oykoN/Zm3gpLaIsHYuRpJzl5lntMfKK/qv1I3tyxWMefo9ni/92SQnu8brtY?=
 =?us-ascii?Q?Llztz2BiHvcuysxyPui0RYL39/tVcDBF+Dwu/5tBMT6/GZ+DIth4tHFXqceN?=
 =?us-ascii?Q?cUk5OGf8pMXKZ4koHD5w+Oh98YAgg5a5FIfbWm3YqArnSWYm/o7nylncCDh7?=
 =?us-ascii?Q?TFlx4rrzOqCu14sEC+hK0Sr/XjiwsqfTBV+myhxRuqFHZM6KfDjsJumT8tNY?=
 =?us-ascii?Q?7X7QoKPHljJwdMvpXeQtOdZBmSpNSBrPqfTly14zHO8j9yxlM48SM6hrxUFd?=
 =?us-ascii?Q?LtvdnpFhbaLDi+Zu96NSg/puRcf18K5OU1GAyE81y6TFjjNCb31SVTLjq6Pq?=
 =?us-ascii?Q?U50l6tZpWTa7MsTZC3Fq760XdcoROeMjA038prdPTDtXI9/8P8WLXlzw3REN?=
 =?us-ascii?Q?+tjkAZWrxOsuTceYc3T/MMfL3AR5DQA9iwRsvxzomYgFP+c7MQPU3Jzi0vF+?=
 =?us-ascii?Q?xQMKddC8Dz70L7L3MXa4K+KGOM67QMSNe49kAOWUxNpfesIT2Zdeb8YisYrq?=
 =?us-ascii?Q?05z1MdU7Y6x5kuEGhVZxNyz/afP0yDilQaoukHBuartjaihnx4sYf490H97V?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3Hn4KpGMNiuGzwP8j1I1iDPUZFc0KkMNMYjG6V2SdyKbai6IMlUgsrq0XI7wfQGwp9UySNnV+MIUdgdPBBkLboeiRaupWy8zpHCkOmk4QVv11uCBaic6+MA7ysyCCqAUeDDBKrD7nQxoKQazx4v018sRoR7nVhr2hFUP9xHG6/fNZzghfh5PRjiJwNIAm0y7fI7/iodDe4Rd0x+tZKy19UAkBlE+eSvPaZODfcJo1iX/dt+p9IhC2ZtNVqwCdUBch1vnSqRMj4RiAScaZFqFwDn9ThSfTrSsCM8ZqU+RG574jZruAdIR5H3u14Q/yLRLkOW826a2oozqpocjUmK5DN8d99hjf/CUMj+g/qLzI2peBx14j1pykVIif9QZ3zwgNaWgZPxl79FhOEsA3DZ2LU2BfYJtU769e8UXG1zJgwaYMyCk5RHjQtZ3+egxb4fqRHkLFQbPsNVL0vzeLXLyTjtVh8lq0DY+jEEJztM3gWE2dA+qRIE0bKPEDLvaxIv35kxsQGiPUXqsWv7xh/Y6uANuaTw2p7VFDR2Vx05FuJu6P7mP1F4+eV5DXZZyZ1mqaRDzF6/eXMWIM8TMS0B/FYJRnGu86AqMejZYFADLqSZoX4V2HuVnjXmveeXCMCZtsTthH4eVgAEupPVJmuX2FmS3oHXLY2gFvFdDrInNfHZRR7eJKBeh1Zc9M0FgK1yBSB0H7FQnNegy2DI8eWnF84WRFF7R0564E5jWM+iJbSK9ya6921vZbJiNPXiFF7auUg6ihh+jclhMbGKq8mv90m3i0zk0YfMdfuJP9H75LC/VuPGXIAxprVeSoX4aV1XWDXzXSLZ4UtRgmTAP8XgScrHAikVz/iBOjgpSmLS8y2aHp60qBTicj+Pv0ptQs09AOdoNU6ICEY+fzG1XnCNHbQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b55d470-1da3-4151-aefa-08db4596f88b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:32.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnjflXOc4C25tq6tjN/BFIoSN/0fRO+c70HN69fwSUZfsBOfwan6oD04QQ2BW8qasw0hZqlnbjE+Sm19D2VNCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_06,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250128
X-Proofpoint-GUID: Q82MKt_jneol0Q4HlIiFu8b2jdiDyytc
X-Proofpoint-ORIG-GUID: Q82MKt_jneol0Q4HlIiFu8b2jdiDyytc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 297d936321347..377b57bbe6b9b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4814,7 +4814,7 @@ void *mas_next_slot(struct ma_state *mas, unsigned long max)
  *
  * Set the @mas->node to the next entry and the range_start to
  * the beginning value for the entry.  Does not check beyond @limit.
- * Sets @mas->index and @mas->last to the limit if it is hit.
+ * Sets @mas->index and @mas->last to the limit if it is within the limit.
  * Restarts on dead nodes.
  *
  * Return: the next entry or %NULL.
@@ -4836,21 +4836,33 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 	return mas_next_slot(mas, limit);
 }
 
-static inline void *mas_prev_entry(struct ma_state *mas, unsigned long min)
+/*
+ * mas_prev_entry() - Internal function to get the previous entry.
+ * @mas: The maple state
+ * @limit: The minimum range start.
+ *
+ * Set the @mas->node to the previous entry and the range_start to
+ * the beginning value for the entry.  Does not check beyond @limit.
+ * Sets @mas->index and @mas->last to the limit if it is within the limit.
+ * Restarts on dead nodes.
+ *
+ * Return: the next entry or %NULL.
+ */
+static inline void *mas_prev_entry(struct ma_state *mas, unsigned long limit)
 {
 	void *entry;
 
-	if (mas->index < min)
+	if (mas->index < limit)
 		return NULL;
 
-	entry = mas_prev_slot(mas, min);
+	entry = mas_prev_slot(mas, limit);
 	if (entry)
 		return entry;
 
 	if (mas_is_none(mas))
 		return NULL;
 
-	return mas_prev_slot(mas, min);
+	return mas_prev_slot(mas, limit);
 }
 
 /*
-- 
2.39.2

