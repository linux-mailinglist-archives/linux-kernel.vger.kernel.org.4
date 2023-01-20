Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74C675AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjATRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjATRKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:10:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7AE5E513
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:10:40 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KGBbwk003319;
        Fri, 20 Jan 2023 16:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=QKE9UVQdDv+uxybjkJp5/tNtaC+6qu/VI0mj8GrP/8E=;
 b=P0TGd+AV7LOAj7qEEVT8KLvkj/FElo9Tq/3lRkVY058A3TCQJcX/P8kY+GDu3fSsb4Cn
 rqpsYE9mx+SOzEHjb6uvvpJXKj9borEIHEUeDm5g1jcfocT3++Zt6h09GvNWVPO3HhZs
 DFoetUAHGr7ieKLlba//pxGZFlwIBYFJ45G0e4OlUeJNvujrT9gA/YpAYRTEqMdS3pIj
 qb79dBe7y/4mB5gMvuaKQc0QjFmv2259o1DiDEsdAokuXYhOyXVSwJMBc53KAW+4pb1p
 zsEsobhO7KpSdYD4IRJGrbNXyNmFjyZCVQNPRWFSXBnpOKdTG8gbKtmxctKAlmBqcMx0 ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medn7h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFWNJY004690;
        Fri, 20 Jan 2023 16:28:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2w1gwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:28:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SokcxsoHiVfcVl6YWACarchLgaBHlzsnRAi+tI6Mdyo1g23TymtBYW4i60RAXMo/KQPa9ZeisiHjxF2CjVaeNXkpeay/0GJdU3D27qI/zzj/seTaPHbS1j5AHK8IWlv4z4/Nnd8SM6z0kR9lwdzGnL2mZt0V9vcL+/IYsG7At0m8XUiqkzVE0hz1zrlYz+IFqaTq+fee9SbvYto7caJoVh9v4kDhiE7gj9M8SOHyj6dYwPT6H1cXip8S1tFur+3xAa0I8dfGRHJMhYhAo9G/10+egBAyBZndUBEMd82l+i99VP5y7z2xfiqdO1Cddm2+a6/HmffZBQF5kTaFQiilyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKE9UVQdDv+uxybjkJp5/tNtaC+6qu/VI0mj8GrP/8E=;
 b=D5QIiMIWyXI7s0gckdXCPbGZo/5W1/8kz76DAKiCdxLYRVsRon4l5WN1q04ANT6xggqFIJGzKtGsHt8Y0i4NiMMdrslSriQSDMvHI7oNwF2Cb7FV1fb2+NzJY5fXmGd5wQcATJOJHdwR4TKE2ZMK9e7i+s6eB0TvSmowIRDg8UzyjUVus2ZJBzRC7s1j0XMYE0J34w+cSeU3BbgSOyNAvdt1npDsAitoMaTdiB1DPWm3NPqBYL/t8F0Gkg8QuGI9bk/MmcDXoWxJvWwKFmfgkG3nB9Gps7/sBeidWwGK+gMD1o2ogoT4fNHM8++rVuEWvJHKVDtsh1/p8QsdhdF6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKE9UVQdDv+uxybjkJp5/tNtaC+6qu/VI0mj8GrP/8E=;
 b=XOoiBPAe+o9owOuSlhavBNQ+JxC81lnleROpgrCEpxxcClLDS6P2wyMisI0Tjv7QKmJbp3S3uiJWBhP4grDWuPM7ehw+ZcP35KQHBJt+6mPUwtwxluY93duYeWWz8XcmjZzIM9zRvCRM6JKt4fWUWZ7/95MFM70cHaxY3xQaWHU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 16:28:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.005; Fri, 20 Jan 2023
 16:28:47 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
Cc:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Li Zetao <lizetao1@huawei.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v4 37/49] mmap: Clean up mmap_region() unrolling
Date:   Fri, 20 Jan 2023 11:26:38 -0500
Message-Id: <20230120162650.984577-38-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120162650.984577-1-Liam.Howlett@oracle.com>
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a60486-397d-4a9e-789d-08dafb0367cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2B0d08nAtfASoy1USFGHq9/7v7Z4qDGglWC+tT/v7M8ceVC2AoJQ5Ey9pITFTVaglryNREK4T1CWqEYfHklpnA5YUVwxIU4lhnivrNNmyR9/u2CcEdA8OLTNi7rvlOH8Uf0q5T0BHIrumFG5sJEp3vm1T/RT0Tkd/PV4uBWF0Li2XuozBeuUvdo2TETdDpX0YxUP0oDfah4odpZOeYRBSIzm18gtn23Asu/q7XxAq/DfZoBI18ZIsw+1HV0vfbwnBAfaxwm9vZjKNFoKlXdSyi6EvqRY6wxO17BqhLwf34zxRzX5lE2pE/hEY5gHNsLzuAsDZYPXEcE3f+AsNFtRRtjewgxNNUWtOMLpMutvLaDiGqDCBsk6WhipQOmeCTRhGqxVMIL8Zn9dgCvBLOLvf/ah72NtqBwp1uX3e09YoXiz++yMS1JsXyDfNhbOOUduV+lOlrp8al1wn8fn9TKTJKWCNPC7jmuauyriuHLOeSjKmDewNUQG9jdNPAvBPwG4Na9wM8wKGgkGVVSVxhLlFzvVBhfpdppCPiP6Z6ph1L8UBifKov4i8PlQpgc4g31df9JADFH7PDDTlm4zLO/7WrJmxHfEWBgnkt08b4KUOcJwEky73OhXna8v7k+NpXrpTy5uSrm8E5hB97NILGO9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(186003)(2906002)(8936002)(5660300002)(2616005)(41300700001)(86362001)(8676002)(83380400001)(66556008)(66476007)(66946007)(36756003)(4326008)(316002)(26005)(54906003)(6512007)(6506007)(1076003)(6486002)(38100700002)(6666004)(478600001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ChpgXLPsbX4TG/TvBll/zpXNMrkYin3BYt4Z8ypAoCUUmRPeDcI+vJT7Qvx8?=
 =?us-ascii?Q?WEP5fKbubrOjc02UNX4s6toPz+4ILafZJqzOaJAzTuLfiueRDfokH9qktqyP?=
 =?us-ascii?Q?Diw6bcMcaU0k9VUdS7FBf+VyNn0nz4pZPWNBRDYqvBKBM+Zp3dJ9u7KGAbeR?=
 =?us-ascii?Q?3GVOwRHSUE/Fplli+ibT+d//QsztqP6scZmqc2isZi25YLYv47VAXkEOmzQW?=
 =?us-ascii?Q?2AnDDjYzsgw0n1xvPPtosdpmhCURzpdNcn8sGZLHJIqdbimhefPs9Hb4M5TZ?=
 =?us-ascii?Q?GuaEPlNHB//EJtgUZLbqT5TMX0I6nR1xw2Ag3EfUrgJE+0IfYkQC6cn/qYZd?=
 =?us-ascii?Q?ajTO7+YW8X0SHCyLrfB1iWyA0mEdBgfonwicfZJ5wO6gkhwY9+mJmylAI0gK?=
 =?us-ascii?Q?b6OdytMOfoe3QyQaKS4x0mtkBMK4LdmSL//YobdkioMNsEpF4+MlhruA0M0k?=
 =?us-ascii?Q?FkatMFFbWGNX99/yRrk+1KfotKiIL2PzfzQaLOdYEf1rJJk2yRcht38TU15d?=
 =?us-ascii?Q?myniaHjWSZwsx/2Pe7o71OvWqTWujnd9vgH67Iz6Sw2eYtk7o094kFGXCYn2?=
 =?us-ascii?Q?5RhRe5G3AhINIXx2yZ4LZD6k5ikmkM3BQIATwOsIPZJitXscc/Tp1LttMw+q?=
 =?us-ascii?Q?6QKeEZ7TkZX/6srvEJ7KIhisBumv0ho2C/nicdhmsKOTBTpzXp5lCfpNAtyX?=
 =?us-ascii?Q?InJQlE6bkOl61YfWOsiwcViOpxuqRW2BW4xWmJ75fmyytDZWlf1WudbDuwWm?=
 =?us-ascii?Q?3rnW8ffdS/KJcj5w2BWqZ0CQYO6ySC/EqXMR+PHnzoc9DC2b1KG2luYNacSN?=
 =?us-ascii?Q?HuDk0INApFKhz57bvXvQWzDdecogHWqCCzeLhLfQm016rgIUjfd4lQsk5wKe?=
 =?us-ascii?Q?vN8I1s4KY1sTYwTDFJAfwk0NHR/fLwDmKFRFuExBoM+FZDonL08RVIGhupb1?=
 =?us-ascii?Q?4veRoZCDBO9PL3/lL/IDnQMQQhAupfzAD9IlckUJlkWxUZx7yHtWj7qoaeDF?=
 =?us-ascii?Q?wOYIjl0cCvObzKaztsintQg5Xb6qykrfqvSH/L0J5FECXWiUXEpvYZD3Qpqk?=
 =?us-ascii?Q?KZjX3adoTeYQRkHzrJc5ZZYODyUAJ6GJ0yTEVMTRSCt2An7BO8pxj+hTS9V2?=
 =?us-ascii?Q?TKPNqpK4PpjoQ1/yvd1CjYHVGQnDRSRw7pQ7dTEgBzaQtxhWyfYJnVCpbpbz?=
 =?us-ascii?Q?/CzinQHnzhslNKu1ErQNKu6qPzgIu6/h3Qk8Y5cCx3KDyea9rbTt/t7UU91E?=
 =?us-ascii?Q?+BIvDoIfoGqTIZwEdNVo8Dxu7XnbhW+tWxz1HvfuQy0DB8wPWshM2wK+YkwN?=
 =?us-ascii?Q?zIYcDjBXYqvVAktzdFaXtXY2oESTy4MlNy1j7o3GVIUgR6L2nxWpSxfI2U8Y?=
 =?us-ascii?Q?e03FwmRACXCr9rHOKf5BYQuW/9iR/DP59ykTKmdTk2yw6pY9zatAtFQemzJy?=
 =?us-ascii?Q?uLlEZV/i4AohMLvgT5vz0C+5i9UGd6ZivFCqsZ0zGIsF33aFLPkFRspplDDB?=
 =?us-ascii?Q?tfaFd+6K8HeBT2eIU6oS759OeQWl61w99YZfJmFoHJla7aitLRvuiTWLNzQb?=
 =?us-ascii?Q?hNvhdI7prJ5+2NLo2c8rwF1aVaLYQiotNoF0u2/WZrsJT4+7lgbd6zgIkwwA?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ehNiJlIWL7GG5nuaCMcIMDGAO95kyt0Wc7xjqjEHLqNDJ6nUW4aL0mLNjuC+XEYK+a5a19V/XN4+ASKxd5qzKdXJdvVoBN9gZIO6ZO4ARPwmEEmP8Pu4ThJLV+1epPnsAHSCHY4sgMV1Z3mvFby4aTQx5ZOs8w5jcvwcGKgEkd3vkxzNC/zFGJ60Iwc3ZPPv7V/U72RYPJgQ25ovqhO+1mo1921LMYdcce16irX3hZIecPF+rnzBjtWcsw8otrgKVVJCVUIHx8U2c7U+uIkKxgPLbxIlyJBTT+0Yhqg6WdrY+NXQsQghMbuCPK9o+T2LrOB8FRexnrtYbv4KKam7SKJCkgnbvKEEqrx75o4NLjvWPC8MAdbIjomDTHMmP9ANEISrUK2KX1tOVYDYqe+8kwdkuCBCpA2CdgeG7mXET1riO/rWsS+gGJX35PHZLg7awi/rXKmOr9It0fde3y4lFhDWZMJ0tuRQOho5mvsvTVDc6a6uxxQEvC0Xc5jtETUsSGLyz8qO5ZnBtTjxypfz8KyEmICjObX/iS1UOCCehFUFnWHCb9iDJ2+H3J30KZA0Z2Jgm6UvLimbiqdOn7jghX6uiw5K0TTBlDcyGzzP+bMVomUwABi4rM0u76sKo88YRqcddHUIVsu7HeOSJs4sSqAqA52mkZglAkoKHeqyYWl766/oKSWMcxGi2UTeEX1TwWfv4E4Y5j1qdGF98ktJvTJfR1yj46x4tNgq3siXn4vkJOMbBFwpe615ArfGmZMOkEBXWJZ2365wmwHnJWd0r5Cenm3Lw8PETjeZM+3nkAEBhf0H8sa2WhSlpiuNQdU1+FWhBFvM9HU/fLJ75KIde+n4uzS5KS4c4bUeneIxFKj+xQoTdYm/JOz88yQihtKT0wF0Qvhp4TjzR8bEme1y0n+aHhZiFR5Wd/cxcFnu7jU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a60486-397d-4a9e-789d-08dafb0367cd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:28:47.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTwZmoFrm6DTjBNEF52BXq/HXUk5aGzpy0Z9FeNXvp8O22Tw/GDPWrZU9uUPRcm2ijoK3gLkFwnvJF4UX81Hsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=781
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200157
X-Proofpoint-ORIG-GUID: aHyLiMUkDKpo14uM2Oyd3qR-NloLUsNb
X-Proofpoint-GUID: aHyLiMUkDKpo14uM2Oyd3qR-NloLUsNb
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

Move logic of unrolling to the error path as apposed to duplicating it
within the function body.  This reduces the potential of missing an
update to one path when making changes.

Cc: Li Zetao <lizetao1@huawei.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b6bedc07ef11..d9e2666d8059 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2604,12 +2604,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
 		 */
-		if (WARN_ON((addr != vma->vm_start))) {
-			error = -EINVAL;
+		error = -EINVAL;
+		if (WARN_ON((addr != vma->vm_start)))
 			goto close_and_free_vma;
-		}
-		vma_iter_set(&vmi, addr);
 
+		vma_iter_set(&vmi, addr);
 		/*
 		 * If vm_flags changed after call_mmap(), we should try merge
 		 * vma again as we may succeed this time.
@@ -2646,25 +2645,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
+	error = -EINVAL;
+	if (!arch_validate_flags(vma->vm_flags))
+		goto close_and_free_vma;
 
-	if (vma_iter_prealloc(&vmi)) {
-		error = -ENOMEM;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
+	error = -ENOMEM;
+	if (vma_iter_prealloc(&vmi))
+		goto close_and_free_vma;
 
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
@@ -2723,14 +2710,18 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (vma->vm_ops && vma->vm_ops->close)
+	if (file && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
+
+	if (file || vma->vm_file) {
 unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file = NULL;
+		fput(vma->vm_file);
+		vma->vm_file = NULL;
 
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start, vma->vm_end);
+		/* Undo any partial mapping done by a device driver. */
+		unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start,
+			     vma->vm_end);
+	}
 	if (file && (vm_flags & VM_SHARED))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
-- 
2.35.1

