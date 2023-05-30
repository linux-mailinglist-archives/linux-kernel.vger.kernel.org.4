Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB74716DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjE3Tkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjE3Tkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:40:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BB7102
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:40:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UJNmrU008438;
        Tue, 30 May 2023 19:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=ojlOUfItYtdZWxTopSJwNQjnNgRqTrdhWu+gqHbclyo=;
 b=yoZG3jSVq1qJaBULxHUZb2wzz1/k0HdTOtV+OV9RVmLZF7qXfrcwR6zZw3qXWvP/byIc
 rq5/nMKUJHiKkGnNdrESeD0RDgNEhvGZsZU8pCuYLdvVulHcLwvWgDKQKCgCEByfQmZ2
 /iVJKDBWsXJXUj1C148yhJqg64sBB6k5tq7wIfKs5PstGn8u2TX/e1AgvP5eQwbW94hB
 SqCRIEhOYywKFODjetn6QAO8QbjvWyUdM9eoSyeQXZvWOxdDXW1UiUkffcIAL3Be/4YN
 tjGdYl16m+WcIjXQADDndhMStw0SgBP5kSwg1U9WQJEuv9755tTZSUUIKsYgsnk/okzi Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjkr0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:40:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34UHr6Rr003757;
        Tue, 30 May 2023 19:40:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ybyrku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzE+6xxuybFJrSsArFkKZp19d1mdduJofmJQk76ubH9RVBrrrt0LwpxSgi5E3hluhSI0TfpYvb2cRhpC4WLFElN1EnkNj/2hFNMXQQssO0/66t/2ZxBCpHBkqYr4DL8LSb2aYUTd6bSGdjWrYGaImbWz6HGhao2zkOQWQR8WAapsnRt1bp2FXYSEW/JISYFigQ26NPCSnuXvzieFMqkyJKJ/4lpdiEWRbetr0uShD2JORKZEISGRPa7xetDz3OIZHDutvvDYK2Cr8/zNdV4P0OZtWI6WMMV8IHm7BKmy/TjuRXq/Ihn+91kozWYzUE9279aVNxByP49xbvTSuXBE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojlOUfItYtdZWxTopSJwNQjnNgRqTrdhWu+gqHbclyo=;
 b=HmsYF0ZxA1sqhrYn/OFZRHjMiCc7AqCyik1Y1BgoSNec9AwBeNj9x/n08o+yY1N/q3VrPoM+dtGzSgGxvK5QChXbjnq86tQ/QRlJOMHZ/ek75sqSb0Cqi8GKvtM48Dsp82e9rZmhNyHcyaRYgI9zhx9rzzQrmlZn9sjZiexbk/pAG5MhjrdntLxy0Jnh3Do6dL6Z/4sTPwsI2u9n0wssIGUuDN4f3XHU02+V1zmz8970HhSjx+hZl3CgR3pmLrwDQF2gWsF5s3fAitGos9WuzwjY/6VVOR2EQl510ZGU6T4q7iL1uYcs7mZNtscqRHIHG95MCG0e1fyF4KnisF2TVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojlOUfItYtdZWxTopSJwNQjnNgRqTrdhWu+gqHbclyo=;
 b=D1CQh1FU73kqCplj+iHyvwTR4AOrB0GxIk+6jTt5+eW6bWkbgkz/nqkAjfyc1BLYM9OoO/yvGh8WhoI+JbxdOaKMNW3hBMLZGDwcwzoP2lPFVrBg4DjDuElDPc5p5ym4ifCk8ctFqbFYoH14aEK6O/2mG3F0da4MLpg0eR2k1/c=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by DS7PR10MB7252.namprd10.prod.outlook.com (2603:10b6:8:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 19:40:38 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::11b8:4b2e:26c5:1bb3%2]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 19:40:38 +0000
From:   chris hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 4/4] sched/numa: Fix divide by zero for sysctl_numa_balancing_scan_size.
Date:   Tue, 30 May 2023 15:40:12 -0400
Message-Id: <20230530194012.44411-5-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230530194012.44411-1-chris.hyser@oracle.com>
References: <20230530194012.44411-1-chris.hyser@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:a03:331::23) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|DS7PR10MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b5009a-7a7a-483b-f729-08db6145be7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxXp4A/STa66RZQIz4pV4pE0ScDLQkI/b4+xCPZ/jC/k7jzBHkiXbwDHP4vv9nDOlS3kRCd5fLhQqvn3+QaWHCh6KGgMN1BcSqjgIa0qXdVku+EQHRMIudtbcbhf/7LAPaNDUWLUIT9a+njI/En6XLalAs+HWyUWFq7KTT2Gm0Zm52o5I8fUJIMo+z1dfks0+mUzwDeqB5OkUGlaURYea9mb5L38nufcwl9txtdzal/Ap9lK6EyyQTinyPiFKqAdA6db3vcvHRXnOQfTauEshYqACmSuT8aSwJ7sz3hqM2vmtUihQZiEwAQuDoJgPUjOWebYEvBcH89TOeHUC8HXayvqoXxi5CiqHgk6d3+f8CqtrF2DkGhEauJ7mOnOYAfC0FESIcoWhpCHucra6JWKqcQh1q+q0O9of2G4J7IPVpuk6Z/b83oA0tuWXJjOzigXA84r4qPMrTaAKWhIdECJJdL4IVazogijStf0FoRdzyi9TbNBaHDHuvXJHK7wCkHI56erPofiNWtzgwEN4t57/otP8oJEzKtIAtQJAoJXSW+x0ihcQWLJ693y8RnJluq1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(38100700002)(316002)(41300700001)(6666004)(6512007)(6916009)(86362001)(6486002)(8936002)(2906002)(8676002)(66946007)(2616005)(36756003)(66556008)(66476007)(6506007)(26005)(1076003)(83380400001)(478600001)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dbyGQJgAh6t0BCJBFnZjwvJSyXhnM1cSqO3um36NDowjeVKm/jBduF7XarRC?=
 =?us-ascii?Q?tJDjcKSg5b+ADm4sZ6MHAeTxqykXnUPuq/WfcGSv2mwBsRx3EfS2Axzrxp5a?=
 =?us-ascii?Q?foYaO5ioVG6LhA1FTXgV660rmAns6EExnoaKhHja1xUnZEYlfwZG3/mu0uN5?=
 =?us-ascii?Q?DanbZqtp7XLyqtKWWA2nFrlBHPNp+d018VrkkwlfJRVYXuDlrqriJTQAs42A?=
 =?us-ascii?Q?QZo8NYZIE/43nllBvfd/37lUBr4Pgu+n6SXG+EDCAYcLzcNSLhiGPWrjJe64?=
 =?us-ascii?Q?ZeRu4946BFF1SleTtMg3m57PM+kf+Lr8dw1ZKFXcvijxNnuV++hK4Heh+RPe?=
 =?us-ascii?Q?ShRZbqOVvHVXzusysLwSNOezDcFIsWdXDdS3tK/e/+X+DVo204+u3rKuak3g?=
 =?us-ascii?Q?06VPcq8qROT00ovdJj2b5wgwK6YZ6jos2vb1jEwdQWBJT1TOVrJlTMObs8VW?=
 =?us-ascii?Q?PUQ0bzkuyA5gDPb6ncY9Hgl6PE7FX14mVQNL+zUBSaQW7wuZVv6iVWBBBZlU?=
 =?us-ascii?Q?PAFh+7iWNrLGLU6c+ai7NsbaoVSsqoMHNJ7oIz9fpUIqEfM18Ixz2FtyESK+?=
 =?us-ascii?Q?C2zOS0Btwvok7ygnz+kX8WVI9lDLS/7Cr2DFARu7hL3BVsmhFGUiydKHVNOG?=
 =?us-ascii?Q?wqwldyk16066wfP7h6bkaMJfQm98bzVd+bPA4LI79OH2lskPw4iKnK9DLnbL?=
 =?us-ascii?Q?tI1txKcAu+6EOoS4/UJUSVKOqW+12I4zCMuYma6KyRh49XABg+ymOKnMcMRN?=
 =?us-ascii?Q?SC6Phrc4hx8Y/ME4uPcFzJtm4AQmjrU8diCBYcCaVrBzrRruHoOU0Fy+NHRp?=
 =?us-ascii?Q?wDVD7Zg7WmY0dNfinoB+Sp3psOXiJ0njlps5bwGuPwTJZjrrAvy2/7Ae6W4l?=
 =?us-ascii?Q?3+Ko6/cVdMGgofXorRX+4tq2wK8WzJ5s1AO0FzfjW21eiWcf91K3LwlCJi7T?=
 =?us-ascii?Q?j4TfMSdMrICoKnZQUWL2i8MuujwEI5ReBl/Ld5c2yHkO/zxo7iUoTN3f3hKt?=
 =?us-ascii?Q?cRiwE4n6+fUT5LBr1YHwfb/5aRXgNBjXK60d1A4HozRlGNykK3IMG7WKof/J?=
 =?us-ascii?Q?9MMlwgBdcRbs0RhWr+FCXTfQHIo6pJiZdeL08sZn1+hXqUOV6534tPIj6IEg?=
 =?us-ascii?Q?UzucxPOoopJBqeSnTuVp/g0GptKSWAcdsHdATr7T4KiiFAY6t1ypGWXOUPes?=
 =?us-ascii?Q?HxBX4ylxBtpnvMY3LjbVrB9W3RiuhBZm62aksoLR/GWa70/KDjXayfNgT/Zd?=
 =?us-ascii?Q?1tYIaDhwCZeIEpY3oFAuUTEi+ncWsf04QPJfLkETxMosvXTvxbYktViKnsnu?=
 =?us-ascii?Q?rXdNI8tUxg7Y5muFXKnHHY/9d5oS8Kh+ZRQLsXTR/ZbfJrUK9YcJE6A9w9i2?=
 =?us-ascii?Q?yMDgwv9Qqk2+LcETqHbMwUEXkekfkyt7uEQS8rDTRzIbBNYa9Tm8J4kPnYu9?=
 =?us-ascii?Q?luoi23Gkp7o+nFkerciDx37e0H2gvOGkp1Xn89JenICDMefvuGkM61DKRxA7?=
 =?us-ascii?Q?x+A4c+zVeIL4AT54nBUb4ZKkGw1lW80KMYkX4NPgJ2TVkqWNvPNZ0fgCAQDW?=
 =?us-ascii?Q?pZH6nhFoiposBTK+lcI+7hz5d5jMc/R06Wak6zVT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CdiWqXehZla4wE4Yu27HF8XFPrv/yQ5brOUoAx5Y8HDg67DCBHV8j6S8Hc8j5yLl7Z8dnJnc1spuSQeKk4kAgikUOUKFAxuGTpi7w0QZc5DOSBNLtaYFH2VPsA5C586pXJ2t7jdKp4TKznzI1tz6XazSSr0KJCz/9V8OEZ8JS/0Z4VjMvPvvX4UM+vZdVDYR7KDbWVS/X1k4I2vbKijS/1LV9Y59uygbh4jhCMYvXqOgBqEt6coqUKILyPAm34O6LZ3hMqOwPBGg8Qem4td4H87K3EeF0Rvym3rFgXn8CTkj1pwoZBdYacysLXy0/imvh5YMVuZgDzDH6WMKvcwGOMt/J0/mrDjW95X1Rp6BB0jPy+ZuKeaAAsGr3c79QJZ6Ojft3gtmcIjtq0MNc9WFjfP9AOOqxqh/HqN2INyzXPk6Lnu3TZ0ElF39U4qlPucqm6j2oP/IlIWnqsp9OEV21ejCnC+Xg3myotddNHFxtmY2+WpcOYU2OZtei8rF03Xs3GRXzENXp8R17KURNEXknjG7so20zWeKOz0D82xmUpazWXMS7dbs4xy6ciQT6VDVe9hE/SzjZIm9EKUOuqCcJwqJqewWRjeYW85XoTJwYpqm+anJLPpRSet3yXlHkYa/DEjQ7D2bTEUoL2FydyNnhXrk5bGQk+bUftSRUN0qy5nnv4ZD/q1fBrNEst+8V/ONJxmo/mQpl/TaiWuyraEU9VdSfOYhUeC1hSVkZDN5r/YdjFBbxqRc1NeLhODC9xwDzxCzA5jBO9XLX5cgi1dWjcDjYMQUQtCH652dgA0eOkHok0I+zMxTDR2g0YQ/rhXY0Y05D/L//cBs/k70b7mBgddSzlthvcnME0YEeyMif8yH121Ak6mI5KooCq+3q5NO
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b5009a-7a7a-483b-f729-08db6145be7e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 19:40:38.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RVE990Kxg5JQfYVFxGvQ+POCTv9cUWRN7HN1DBrYBNwkINA14RVN1iZwC8+g3uHOJsQHkbMX7uzSPK0WOU36w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_15,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300159
X-Proofpoint-ORIG-GUID: t4Q1Sn7kwBTMhEsdxujHGntetzpsfzyq
X-Proofpoint-GUID: t4Q1Sn7kwBTMhEsdxujHGntetzpsfzyq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6419265899d9 ("sched/fair: Fix division by zero
sysctl_numa_balancing_scan_size") prevented a divide by zero by using
sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
value of zero. When moved from a sysctl to a debugfs file, this checking
was lost.

This patch puts zero checking back in place using the debugfs minmax
checking mechanism.

Cc: stable@vger.kernel.org
Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
---
 kernel/sched/debug.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 066ff1c8ae4e..b9e53ecc539a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -216,6 +216,13 @@ static const struct file_operations sched_scaling_fops = {
 
 #endif /* SMP */
 
+#ifdef CONFIG_NUMA_BALANCING
+
+/* prevent divide by zero */
+DEBUGFS_MIN_ATTRIBUTES(scan_size_mb_params, &sysctl_numa_balancing_scan_size, 1);
+
+#endif /* CONFIG_NUMA_BALANCING */
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
 static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
@@ -371,7 +378,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_delay_ms", 0644, numa, &sysctl_numa_balancing_scan_delay);
 	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
 	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
-	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
+	debugfs_create_u32_minmax("scan_size_mb", 0644, numa, &scan_size_mb_params);
 	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
 #endif
 
-- 
2.31.1

