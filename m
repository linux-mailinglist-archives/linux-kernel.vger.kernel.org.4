Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125BB663791
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjAJC7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjAJC7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:59:13 -0500
X-Greylist: delayed 1319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 18:59:12 PST
Received: from mx07-00575502.pphosted.com (mx07-00575502.pphosted.com [143.55.146.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71814101B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 18:59:12 -0800 (PST)
Received: from pps.filterd (m0320706.ppops.net [127.0.0.1])
        by m0320706.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 309MfTlP007514
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:37:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wistron.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=POD111722;
 bh=0Efe0IdJZ09bYdclt8Yk/75JQR99O1nVzhlYHWDR0/w=;
 b=GyAvMXPY88KTq5kxyFRKMsgCO/POwoe9tIZsU2UrOeutU3wHV+jmFsHpd7Xk5hHn2S5K
 8XdehRTyOijjcPlCGYlXH0zxIWV+O+RohY3LWKBMocd4FOfSFKjqz28ncZYNBeNoTd1Y
 EojoYWWfXFbwobpc5oFwCZ+9Ujz37w+aDE7HJH/Cy+mqihGEaZM2WMf7XUbcj1yx3F92
 HvtcPBSS2Q80JFtQQRdQHCGldegTKcHOz9ctzf+5HamsvO2EBeOuzfqZM6euiiEVN0PK
 ROH8fwLkJQaW0r9bGYUmr+GBBHwsgxBsDbTZ+5IJ6L0UIU8HnZ7hj9Tb9A43MSOHxDWL 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx07-00575502.pphosted.com (PPS) with ESMTPS id 3n0gbqsc1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:37:12 +0800
Received: from m0320706.ppops.net (m0320706.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30A2OsQt016265
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:37:11 +0800
Received: from exchapp01.whq.wistron ([103.200.3.46])
        by mx07-00575502.pphosted.com (PPS) with ESMTPS id 3n0gbqsc0x-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Jan 2023 10:37:11 +0800
Received: from EXCHAPP04.whq.wistron (10.37.38.27) by EXCHAPP01.whq.wistron
 (10.37.38.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:37:09 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (10.37.38.70) by
 mail.wistron.com (10.37.38.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34 via Frontend
 Transport; Tue, 10 Jan 2023 10:37:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty1uRtRi5bayIQ8hidEQHwqcjj4D+MNrPsre5u1z7kcyWjIvJXqZflvWx0JahwdlSNJg0zvyWUVpDN2KyGedD04f1sTi8zV8IGqqNE2E9jKbJcEG32kx2esxaTxHylXqDZz9o5YSPTr0KFk8sRY9ZbB62Pf6KdH1MqFbDo4EOy4XiqLuSdnvGo17tWusbNlFFm6SArBk9vNtAfqqN/0xzGCQ48ynV3Xp+B3n4LPOJEAsHBAZm8voEzK3S53wGFr3Bo49zsmkyKM5K1wNuIGt8k2rB34ROZz+RdbJ0G8iOcXFfWDJnjD2IPefcaGBUc47yOGrNnf3V7xyup/PTQ0pBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Efe0IdJZ09bYdclt8Yk/75JQR99O1nVzhlYHWDR0/w=;
 b=NhbGSUGu5NQ2xghjln5hnyQIT/16WlmNKPfqet+1ASB8i6IOLZ4NhFpMG7vO7VVWkn0S1A4Qv2cjQ9AwMXwpQoJNF6+6jaZ84gNV6zMjX/BKXqz6LWdpYVevpy+ksFV29Jc0V9hYLgB/61Xa/JvSTApkOW6CP2mnTXk8RSwsxrZUk7YViq6yViNLTM47QPA2Eka/mETFwQ6swjwPdp15i3LSoYzlUsPJyhowjayBT9h6n6QyePDyy0N09gQpEcs+Fq6muDc4S8Gi4CyAhA6AwxfmU3vKIyEKk8mo/6WAuLxyLvUkCLO65WMoNMv4D3H+EN+GVn3wtUbL/u2iJuFlOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wistron.com; dmarc=pass action=none header.from=wistron.com;
 dkim=pass header.d=wistron.com; arc=none
Received: from SEYPR02MB6230.apcprd02.prod.outlook.com (2603:1096:101:bd::8)
 by SG2PR02MB5601.apcprd02.prod.outlook.com (2603:1096:4:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 02:37:07 +0000
Received: from SEYPR02MB6230.apcprd02.prod.outlook.com
 ([fe80::3d39:3684:4875:3a5]) by SEYPR02MB6230.apcprd02.prod.outlook.com
 ([fe80::3d39:3684:4875:3a5%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 02:37:07 +0000
From:   andrew lien/WHQ/Wistron <andrew_lien@wistron.com>
To:     <myungjoo.ham@samsung.com>
CC:     <cw00.choi@samsung.com>, <linux-kernel@vger.kernel.org>,
        "andrew lien/WHQ/Wistron" <andrew_lien@wistron.com>
Subject: [PATCH] extcon: Add EXTCON_BATTERY type for battery presence
Date:   Tue, 10 Jan 2023 10:36:56 +0800
Message-ID: <20230110023656.1334114-1-andrew_lien@wistron.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::36) To SEYPR02MB6230.apcprd02.prod.outlook.com
 (2603:1096:101:bd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB6230:EE_|SG2PR02MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 567f0221-3300-4f69-1b49-08daf2b390c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yad5rFqCmf+cp31RPy8WyVgQ3JvC5fdGISYFBcG7aiiA+NN/zguRcHhixomgdOF+ikdJqSqKENzx2VXu8/kaAGws7PyU3E1O9KP9NjNbzZinpaOPl9Qi6Fu1S/nZ8AJkwn7FFRFVAT2mnGyF/ivrHThuT5mwGvBhKKJwPDI/ZbGm59tF8VhTcuj3NGiwpdvJLfuw80JWLcg4ut+ndlPktOijP6zzui9YBGBCR08rqRGYWQY7OWC329F2fWS4di9Ne3fgxv0qCPh86veb9nKHqjvYdSIEYyf9Vz3aJJvb/i7YJfRZwNiT2Mk49jVIMVw5Ebod7Hwj5D2/r4gGAsRctPdlKHDEUOn4Bi1eoxEN7X5nA/XU/zaa+hJpB4cRYoDBaYX0mN/fSNoRznWbDXie8woQK4bo36J4fwIaB9Uu7Vhnrdh25UOA6afmVkGcCLUi3F3/tpTztem7CUu6d5/DCq8LzYhP/RJPfZYWM890wck31mygZIto+cr9/muPfKRJlS3BN/f9t0hwQgm7hv6FSTueMq58t5ORFLEw9/0lPet0ILwfYIbencuBTJpyu+aL1ULdQkQPLc7hwEFniPtRBn/Zt2aiohF6QUJQb1jttpHYxbDkvhv3X55buBKiQzObjKwYcCodspRNXkTsz6O+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB6230.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(38100700002)(83380400001)(86362001)(41300700001)(8676002)(66946007)(66476007)(4326008)(66556008)(316002)(2906002)(5660300002)(8936002)(6512007)(1076003)(2616005)(6506007)(186003)(6486002)(478600001)(107886003)(52116002)(6666004)(6916009)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Qc5xil8TErsW70+Zr+7oK4fGEcizc0oU7rYUZynLi84fmCOttvqzOgI+3NN?=
 =?us-ascii?Q?DubgAWbrz+vd7GuRm4fWXHVeiEz0rqujebQUXXh/0xifNsDNHy5ReVxf+MbM?=
 =?us-ascii?Q?5pJ2FO3QqpDTciL4eNrI1BKzjabuC5ebdyz2uXEOmxtol8RJkvpRiwuYU1p0?=
 =?us-ascii?Q?7+llhoYHe+L2C4u48zE8BFjSaHH0thSJd21UTYw5Tq3vWuszA9bWKTxIDF+3?=
 =?us-ascii?Q?xeirqUZ4G3VA70GDBJ5pmk+vKSYo9UBIPlpJg1nxxzneAw7p++xM+25pF9rm?=
 =?us-ascii?Q?yAdhQ1HI0aGn2sVnpz34qrTivXJMTYHxZSVmGvq5WaWhbGcp+VXdH6uUQpn9?=
 =?us-ascii?Q?AKd6WS1TlAl0DLQ5JBegUpV0pyx5gtH/hj2p+WguvSH8lOrOxQUwjyAYHb4/?=
 =?us-ascii?Q?1RY/PDF03fWIwzH1yVeWKhk0mxX3w1q0omypytrhHo0a4mA6jCvaYuLHciId?=
 =?us-ascii?Q?igGvstvW+RDMWSQq+qR/gtotIOfoW4y8wE4kS8jOJjck1eugSRJeISF3BcFo?=
 =?us-ascii?Q?lJhp9DishUQKhuk+2fF9oerdL6Ig+LYZHBlZcwWvHhL1H4uuUDXhZ+9xXWx3?=
 =?us-ascii?Q?g578zrX5l+bytbXu8MAk3huAVsYAeShOKf0kBFBLxbcTFFNUvP1Ccxmj9VRi?=
 =?us-ascii?Q?pMU1Bct+OogN/+t4Che8d7gvUsxHZzxycdXmOIzuV9kOwC7p3quBgHADps73?=
 =?us-ascii?Q?LYPOpWMh08PCLmhayupH8+veKPDDW6a9IBqKUESpMqcNzx/HI5LaLt6FqBwj?=
 =?us-ascii?Q?gkUCBHk952SVcEbzpLZhZIDte1ZD1xZ17A2Cvs+XghkxyXyvQx+Yo0hTRiO8?=
 =?us-ascii?Q?m6WB9HdAUMFkrc8RRRujkBzOascr97vAxWc5vs4d5jtuMSL23X3NTGSSHKLn?=
 =?us-ascii?Q?mFCeQkdIT3x3PSflY/4hxHBtwG8wGdKR/ljgkDEfjCOIs4l4ZWzM/QO9v056?=
 =?us-ascii?Q?6iilN+i2mOx5lXfC/Ac1IE6qccuk2VPVHQPeHQOLwPHXQNiVq01SyFV3ascn?=
 =?us-ascii?Q?WgtDjgVt7iLKT7urTgcAkIkHPk+ynyldcjq4scAC8WUArC/tFtYdw8obRuQk?=
 =?us-ascii?Q?AemX6aq8Mr2s2gZ5jEqLwsoN8Ju5/Y6uqki/75JFrU9xbRaHp2gIK/NnVEnv?=
 =?us-ascii?Q?Rnw2XH19wAduKUNrmcf6MQHgS9gKqrKTvW68xqhhsUQc0bB3ho50CK2/yfva?=
 =?us-ascii?Q?7eVYyMY9IrpboRqea8XDFbLYNLpYmLC+T+IwT4YZgCmtjUnd2TvfqSUG1IXw?=
 =?us-ascii?Q?5tics7yCDMIcsO0dgmdE4wVWMul2Q73Y9fqJnF3y+bGAlFQYi0ZDiD3hW6rq?=
 =?us-ascii?Q?3wzP048HwveGkwzFYsWpSUKPS7LaZ2j00epGw6S7hqJ2MdDubNqi6LV3+Pdf?=
 =?us-ascii?Q?pTY1R6u1VR2vTuaLLwD6ywKSU6gOw99aEqXm6ZOEnZrJ43vtGiq6+GZfQ75+?=
 =?us-ascii?Q?ICQ6NIPPOnQN1l0S/SHjoQCGpaBCu+tzJqRzkI/g0TNxHk4z8cHlntWL9WSm?=
 =?us-ascii?Q?2byhMBz465yI8xSodt3l7TltEEmpDvSFlDraVgRhDCKqBW+f2fc+xy2rV1CP?=
 =?us-ascii?Q?MRrXxgWoPvPBS5wDoj26tEQs2OxNsD9fyTsN4mVr1/Wecf/x5KKJcZ819OQ3?=
 =?us-ascii?Q?n9zyczxBN27ASU6HBmOWtOz8481mNTexzBLEENI+gN77IT1OiHkRxJ+F/yQq?=
 =?us-ascii?Q?hTEkJw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 567f0221-3300-4f69-1b49-08daf2b390c8
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB6230.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 02:37:07.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de0795e0-d7c0-4eeb-b9bb-bc94d8980d3b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqI0M/oT3vsREn4RF0yrLevk4HaNYxRN306657BiKbrTCUkOnZDSeWROn3yLnvXmTetBa0/4/kMWtuVg5EYV2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5601
X-OriginatorOrg: wistron.com
X-TM-AS-Product-Ver: SMEX-14.0.0.3092-9.0.1002-27376.004
X-TM-AS-Result: No-10--197.876700-8.000000
X-TMASE-MatchedRID: S1NZ8cTSw6D/9O/B1c/QyxFbgtHjUWLyPsGG+kQsvKhMotU/QFIFG+go
        SvaKsl/kIvrftAIhWmLy9zcRSkKatUqyi4srEQAuTZzfA1mtzbt9LQinZ4QefCP/VFuTOXUTae6
        hIZpj4MuOhzOa6g8KrZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--197.876700-8.000000
X-TMASE-Version: SMEX-14.0.0.3092-9.0.1002-27376.004
X-TM-SNTS-SMTP: C50FA686985822CCB2FA3F02DA59A58F11C1F1B8EF8D9504FC1327BCBDD8FE2E2000:8
X-Proofpoint-ORIG-GUID: aJ8NzxfqKo-8oiCNqBff-2ryU4_Uaqx7
X-Proofpoint-GUID: _2MRthcfefQfLazgUCRdBoQXp_zi3f8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_16,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=653 bulkscore=0 spamscore=0
 mlxscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100015
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This information can be useful to device that support battery swap,
for example allowing them to indicate that a battery is present or not,
so provide a standard way to report it to userspace.

Signed-off-by: andrew lien/WHQ/Wistron <andrew_lien@wistron.com>
---
 drivers/extcon/extcon.c | 5 +++++
 include/linux/extcon.h  | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index b4df4372f097..6c47d23244c3 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -184,6 +184,11 @@ static const struct __extcon_info {
 		.id = EXTCON_MECHANICAL,
 		.name = "MECHANICAL",
 	},
+	[EXTCON_BATTERY] = {
+		.type = EXTCON_TYPE_MISC,
+		.id = EXTCON_BATTERY,
+		.name = "BATTERY",
+	},
 
 	{ /* sentinel */ }
 };
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index b0b4abb018ee..88210b481b6c 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -81,8 +81,9 @@
 #define EXTCON_DOCK		60
 #define EXTCON_JIG		61
 #define EXTCON_MECHANICAL	62
+#define EXTCON_BATTERY		63
 
-#define EXTCON_NUM		63
+#define EXTCON_NUM		64
 
 /*
  * Define the properties of supported external connectors.
-- 
2.25.1

