Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B46787AB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjAWUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjAWUZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:25:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D43212E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:25:03 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NKDmbQ022179;
        Mon, 23 Jan 2023 20:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=JfFX0b2CIlyocqogZlxkBT4HhqRHSXFipYtB+o3pynY=;
 b=YY1P+/luo4+SsLljrQ4hlJtKuMPPSNxnR1LJlt1NqZk1w3HOYu1HZlS9KVAAKFJz4jrD
 MqbkBp+EzKLcoCCRmHzHV4d5yveuVIrlrnQGSlTpogoKXIEynkJLEo6qmW/QzZeXkkba
 in3MIrTDnZTMP+rp6xXBijqzRTxUZakq8iU/QZs0EUsfxT/kh2Eyg6F45Z4MnHOt7cUl
 wlpj9LGQGfLVcSeqWDD6OcERZN23OcG/z+WznCbUefbaACYinMcGzBCjbYEOfc6ROr4s
 Xz1VgSZWuBIKpoed3WGZSlvFSeFUqBd3pAuWcgZSUoNdpSZppRbD3c4miBh67JDpygnt Eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86u2utqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 20:24:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NIhMLi040190;
        Mon, 23 Jan 2023 20:24:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g41fcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 20:24:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FamlMBvYphuLe3JFnQJvSEYokYqyd/bUkHWEfcFCM7kJfQfo1iZ0/ZlUW3ZsTZcblQnxDlHcznehO2JPSn1KbThBOGcFLO1v7+4m8EwRDukPQ24/i9YEYdB/eiN6kADn8kzEWnwZph2pb9YT9NCp7z9FT5ZYNkxW2HzoiwCDh9wRE/OT/0WFW4gE/zrqUYfDJDab1cLzFFJGeEpJ0VcP0LgVd1rONFMTsggxNH54VA8vBTXbMP3rMI0NrIIBJkpyHGAEFAa8Iwe9PbA9Huf53EuPzaMXLYCoEyRwcFEDRCIOE6XdxQ9qS9ZKjR5gedug+HD4xP3nv4DLSe48py/69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfFX0b2CIlyocqogZlxkBT4HhqRHSXFipYtB+o3pynY=;
 b=XorSyspAm9tWYV9TQc7F996dnXz1JL5xasRY25BH1rkUQ/q9pglWrPFi9dQVtUK3T/cKgh4X56nS0/5Vq2cz/NPLGF3eZ/PS+FDrRIbnJrvd41TFkwGxKL9fFY+jAjYKq/SEup/9D/IOyVT9SRNPbo/9fyy/kl9sbtAJt4W476vZDaiMDnOMVOkG7iDhJ0wScg//8NAIdsQyOtu9tqqz7SOz7v/sbFmGFT/oKMc94H1v6QDG1f1Sdhn8StsbKNfRv2DyPWlgIcOhX4hp+rt/CkRlWBkj4oV/JgANi6O6UTV9x4PE6ox0GE4UOPJKM/n8eXgXSWluvNT4Uzpl8xpu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfFX0b2CIlyocqogZlxkBT4HhqRHSXFipYtB+o3pynY=;
 b=hspzSNv2y8NMUTTw69RRMQH+3qFyeLXrb6cFbGvAuGsNFNZgeXWQiFb8WCFZ3BiCuDwxSU4y8Zex7KHaGOqImzKr0iD0pZvCt04byTyHA4wb1PGjsjP7oJlUZYOTrB0usd5lY4koOD8EkTdguX/C2tcw2G2J98eCOBlYPF5VLt4=
Received: from BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14)
 by DM4PR10MB6013.namprd10.prod.outlook.com (2603:10b6:8:ae::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.16; Mon, 23 Jan 2023 20:24:43 +0000
Received: from BLAPR10MB5106.namprd10.prod.outlook.com
 ([fe80::682f:125b:f637:f89f]) by BLAPR10MB5106.namprd10.prod.outlook.com
 ([fe80::682f:125b:f637:f89f%4]) with mapi id 15.20.6043.005; Mon, 23 Jan 2023
 20:24:43 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        osalvador@suse.de, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 1/2] mm/memory_hotplug: remove head page reference in do_migrate_range
Date:   Mon, 23 Jan 2023 12:23:46 -0800
Message-Id: <20230123202347.317065-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::30) To BLAPR10MB5106.namprd10.prod.outlook.com
 (2603:10b6:208:30c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5106:EE_|DM4PR10MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9de00e-bac8-45f4-e112-08dafd7fdc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJkvCticmoHWQ08s36GoSqm7oVXD5RUpWZQO5k3AZOOxK8OS5Qm+dA03oqSC4tYoLFr6P+OVsf5E9ncb8rUFu0Gx1AxZJf78dSGZewB4nJvDT9+x5Asl/XqmrXurh5TCwlObwzYS/ThshWocg14rLhXrV4yi3SN/23m/PvjYBOQ9nz9yoQAnYGDvbGItvkBDIV0FArg5R3qGqSc/88gpCpnWpI+NRaq25C/HqbWtRTfxUw0JDmzk/ON3rVwUk/KXAFfGccq2jRtWM1+5QyYs+feAJTwaO2KBZRoBkVHtxQSFWdjhPsFFE+KMeyWFD0wEjgtQSYRilD4guZZMEsYW23yVJ9SuAznX46HhYgtyxu509gS/9m4t1s7O3SZDZteEIcM27bF9YdZ0aefIVmwtErWQuKLGPspmwkuvqx0v7Y+Ck79N3xKdLC6Xqb/FO6nB6fKejmw51ue1jUsSyGg1r6RHr+WyFiLl0jICr3UzfkXf6Ail0spPD66cFcVEDVinRNH/wmcGVX9uxkY01wNeLEuB4+WIoDDsDaTiZ44zvKwP5U2YvD+DzV46pK1Le5yEyyE2+OYEkopdg2q6odP7/QnkD/PgAuMtcYDKyFt9qducYxHHz3EzmtnCwuwm+qH30Ql2pdjYrmqIErhnTWFBBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5106.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(36756003)(316002)(66476007)(86362001)(66946007)(66556008)(4326008)(8676002)(26005)(186003)(6512007)(107886003)(83380400001)(6506007)(478600001)(6486002)(2906002)(2616005)(1076003)(5660300002)(44832011)(8936002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?80xXFqETGEL7MMrJCd7KIPcyweDlNL+96lTObhWTkeYJYQYM5JcEtxWTnbdW?=
 =?us-ascii?Q?MsiRNeeub7cULNqcwsgzXg4ccTfWFTd2id2A6CKeI/KakAUE4vbLQiOxmQ7Q?=
 =?us-ascii?Q?Zit3K1eC8LghP2L333vJ3HwZIfCZMa3hvOGEtk24b2/b5wLYGdL82LCpFpCQ?=
 =?us-ascii?Q?IXm5uBPku4h4ANeKCypZavcnzc4FMm4ZZOK7XnvyfMynrVEn0ZjYcL4f/oA8?=
 =?us-ascii?Q?ul2wHJp3exC85AAIg3s8Iw64l8uEwtF0qNWGB6CG0Ii0avTlDdmINif1P4VA?=
 =?us-ascii?Q?ViKObM2NJvfBA3ELk1UWWO23/fgpWCDU5f4IY03qLBFTGShpciZsLUo1HFU+?=
 =?us-ascii?Q?ITFL+LqDa1m3xJuqS4lMUKHZLGRIV/ZxQE1wsFv1ux5uBHkQUA25YFQyrPZC?=
 =?us-ascii?Q?V72pd3ms0yEnW3wAqcHaCv4qPYzZMSG0TOjNmjtziF067XmLCP44ykaPav89?=
 =?us-ascii?Q?J1vDbSuTTNzwjC/LFdEXgWxz/K+0XOdmqffI24FS7EBQOaSVI5cnp4hpHYKr?=
 =?us-ascii?Q?QkJPX2ukBZMj75CJ6RHvXZwnexyLNTSOFJ0lQJUCVytltT3o6BfiRlj/bFzi?=
 =?us-ascii?Q?kPLy6t2/wRpTRZKUoM6wAZn0JGFLK0jIlJLP5k+vUK/6JVuKwePoeN+1df3d?=
 =?us-ascii?Q?Eu1/X0A6REPdmZkGXWkVQQuyF546PktQYJn1H+VOSclqcWh7+x9p/9L5tf/Z?=
 =?us-ascii?Q?R0WiZxnHijb4VN/Vt+CgmlLB+rb2xEcb8XmbAihnxHnuyt1yI3xSlfZyi0bu?=
 =?us-ascii?Q?JAe/6wyIy6w/CwBFVxyZPv17BBwpactM8Z2AnQPm1oFcM902zWavJMl7/3/5?=
 =?us-ascii?Q?/4iKT/+b4grW+ySEZPaf6UEvFkRnBS4XTk24ySGafIIDxZCdducotOsBdOai?=
 =?us-ascii?Q?9oKZb4EHKjoeTDPZk61Nj22zlKDeB0uYRJCnjtcPWnkjU1WaBkeDVAtwzFd9?=
 =?us-ascii?Q?9K9HX0XqNvJGguXUmry01fO8UdSCxKdvq94hPHa4MuCTrPsom/wfcrygxkST?=
 =?us-ascii?Q?5n2uMhMeKomapOKJhcjYLwHXLmd9wnp5q6VlLhI9XI45RgHMNBdDWuo7W0y8?=
 =?us-ascii?Q?fPtJ26UG8XG/JZMTgxEkcNIXkngyMoWFqT5Y4EFP8S3YI+vaxIMt4AvLDE2Y?=
 =?us-ascii?Q?Xi4vVUYq/3FxIhfOhzrFvA6wc3Yz0+Gqn8KLBtLkdSUUPqWcuQHgCXybuYbM?=
 =?us-ascii?Q?oUma63Mbjzh3xwG862s9M4OL6KzMJGixEukQoaUOxvYm0FMJ4IpV52JAAkZ2?=
 =?us-ascii?Q?aniy2zNb7II7EGkSDoAYSnDzF5CpzdMKXk3rxf4SqnGJGQ8qjaPscwLA7BRT?=
 =?us-ascii?Q?C0DKMyJc6FubtF7Wvkydjs6q6XnDXOziYoO7Gmzd6BNK+TtLgme+S0LEbgyO?=
 =?us-ascii?Q?+af8kZrPsAmRKNnRLO6V14WBGkMNM0dqsIFno45VJqew7JqRKAR3NLHaDY2l?=
 =?us-ascii?Q?bBwquOJN4iPZypO+IQ7M1OC6ECjjdDNKYnZuyDXqc2TBJML31MgVjYlWmpMC?=
 =?us-ascii?Q?3g2/uQWRkkRMU0ojL+KLJMoh6c8z2bgDjnjZVpZeHuhr+d+TUt+SBTXGLM4y?=
 =?us-ascii?Q?UIBkNWNdABhh0DFEXLdtqPJW8cy64G0+Qpmbz/v2fCJgS2/14xUSHqOCJbWD?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Bd59JLjyDkafp7U2UZy7uKnyEjlBaUmLo8sxy3u3qFta+bytgOa84REUW1Bs?=
 =?us-ascii?Q?YFN8vvF0LxhvrhB0sG2iGzrG3Xv8rUDuTuWUYOlxjEVBRuQ3ONor7iK4hcrE?=
 =?us-ascii?Q?D54hmUDdY+YRI0Mszo830BjIRJXlbrCuDRfSuZht3ZNK9OFTpWanavEX6Yez?=
 =?us-ascii?Q?4iZjeFwheADE+Mapk1wL5cP89rXZlLQ+AfkqJhM0FtwW3rvRSM1v/OYV2QHb?=
 =?us-ascii?Q?8hcf2jzuLSmkWzWd4/3D75WQuHB3a0aQ7ujJ6ksoG7GKdkZ0Mp//+2eYjTbR?=
 =?us-ascii?Q?Sl3fh+tWkUQif2llAlTcFy8ZmyqmZJ0tDP6d6vCtMf/UE5gnq6cBRAqTj14q?=
 =?us-ascii?Q?KgzPXENL0erFdiMKyy1S9m9aRy6mbddlmxsIrJ+Pw09vSrS8x7T7EfKQNvdp?=
 =?us-ascii?Q?S6VYW0eaANnWS9xmvyvcA1BMwi4jTuldbrtnXLIG62gNr0auvpjP1+3w4quH?=
 =?us-ascii?Q?mjUSiUJ9w/5H2VCl2piErO2FoOdoEesD8gFR0srs59bNxR5JepYq7xLlrM4z?=
 =?us-ascii?Q?2OC1ceNe/IsZvi4gej6G0VVz6qGHZ+MdEQJs3mmRbgF/ROhpNeOtUyCVrrSd?=
 =?us-ascii?Q?hXiHjqLCG9nAAaePR5k1d76bj3t1XrLw22gEsjPRAgByJMnAoR0K7QLlJQs7?=
 =?us-ascii?Q?6j8wVaEk6TD6ncdLP+iQmOJ8j8dhUUHxxm83E9LrVJmcbftFoUtOhkjlGxIw?=
 =?us-ascii?Q?d1GuZNAZiMdY99WNipXGHxbZisk4p6M19Ox1bfKGoIX5bwzyeHPmLAwPFOje?=
 =?us-ascii?Q?ZLYO6apq1qvTKCY1EEmlBq5S01XZ5QANGMd/hqqKIFVmIExVkpsNUgxnOl5N?=
 =?us-ascii?Q?t603u3aBLwL3yuNnK3HZqxG/caTgxD4OOnv/YxSSg+MvD8Zd2Jw2tLiVfmea?=
 =?us-ascii?Q?ajZY7lwKSwe4YLAQPVdeghCbkrrd0NvM40KOoj7+TdRZXczShK5LATDHSHRM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9de00e-bac8-45f4-e112-08dafd7fdc6f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5106.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 20:24:42.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rV9rdyA2Mb2nuAK1zx5849jZnBK/Aw0NPk+y6xxGm4ZBe8TRFFQKt7igNLOIxvzE/5EYsqt9QK6R/QtQWpyQZY7BOzQUwOuAsp3tRn+q1UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230195
X-Proofpoint-GUID: ZtoY5MbMW4W_QoSf9eh0B_g7F_Do_80K
X-Proofpoint-ORIG-GUID: ZtoY5MbMW4W_QoSf9eh0B_g7F_Do_80K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The head page variable is not needed as we can use folio equivalent
functions.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/memory_hotplug.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a1e8c3e9ab08..ad09189786b1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1624,7 +1624,7 @@ static int
 do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
-	struct page *page, *head;
+	struct page *page;
 	int ret = 0;
 	LIST_HEAD(source);
 	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
@@ -1637,14 +1637,13 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			continue;
 		page = pfn_to_page(pfn);
 		folio = page_folio(page);
-		head = &folio->page;
 
-		if (PageHuge(page)) {
-			pfn = page_to_pfn(head) + compound_nr(head) - 1;
+		if (folio_test_hugetlb(folio)) {
+			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
 			isolate_hugetlb(folio, &source);
 			continue;
-		} else if (PageTransHuge(page))
-			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
+		} else if (folio_test_transhuge(folio))
+			pfn = folio_pfn(folio) + thp_nr_pages(page) - 1;
 
 		/*
 		 * HWPoison pages have elevated reference counts so the migration would
-- 
2.39.1

