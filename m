Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1705C6D6C25
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbjDDScq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjDDSc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:32:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412178A77
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:29:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DwrME025597;
        Tue, 4 Apr 2023 18:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=kfa+RU8nR2vnYyyZYfy/e1+pAsF3kovtLFyx/INmi28=;
 b=otpttKA7He6EHSA6ZK3K8UBV3U6b341j3k+dvs5wTFXq19FVsxNJ950HcpSiuS1a5efF
 B93BqW2J85RD+W3g7mgX2ggBLEegoRcNzr34NWoT/Xd7Iolx5kI2QCA8pcdPaJ2igGz4
 7G4wCnlmHWLzMd2PSVkK29/xgSagtpmdLqO2O7CJ2bSjzq5raOtNvP/8sPTfzmMh8b4P
 UV+mVduS3yvshtviTH01nWulr15vvZL5Ww5CMvociJzt8NUoLDI+AF0mBwbjbMtJQiqi
 CNWVkdhl+ee2MEsE5+Bxyr6v/Xefhx4sLvWZg1CEs052pWb1AwypakTpgZY2cZ6MsUZY vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd3xkw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:29:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334IHO7j017226;
        Tue, 4 Apr 2023 18:29:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp7hdpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 18:29:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHsUmeOTX13BO04bkra5aZGcKeXS5dRV8GJg2UeNRX7xAMjz1MOXfS98xuZOFdfALPdIAcT4LyyqIHGO2AolvwcgqW3QdtS4IR4aYH8GxoMyuYoJ62bzA14cK5OypNgwFXEVxJ/ZAf596uHbBMS83RSB82f8OPMd2CdrUtONueKHSu2UVbdEbUmBM9KClqrvnacYdeP41BcX/noVJggMo9cKnhf+rq5Mr39jhOCeIf7Wn430nPMXVzWsrsGW+DHO8RzTzbPfjfG+s6oVzxZ/ARpJTFS4IpUhzxktNxfB6MiRPi3zN19JH8qPgWqnLAFX+y8KmK1zG9M8U7GuDHglZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfa+RU8nR2vnYyyZYfy/e1+pAsF3kovtLFyx/INmi28=;
 b=dwxKbrFrhgMk04KHqDVgFS81M5LueztuL0xTFm8eUF0lDaR92/6xd6C9E34zhFWIEoNXEn6sJyoB4i8di7Q8S3VlY8h1f2YmX3gLqJfc/ZjOLa1pSLeL502pqH0yjTRnZ8EtDx9u9SGUsljl3vq+NijC1M+l1LJ0zzgZDeu3i1zZeMIuGAkJktepcei+PHDGUVYdsRDLS8Q8P8rti+yS4TcFxzaykHnJ9yAt6x6iu5xmjexbBWCFScfdTiA7vI9h7FRN265a8qAiYEzpPbKo+FuFquhZs7ZuxilqYfkycxrEikz9fSUTnNZ6PrUHrbzd/niE60JMG46yYdACDuCPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfa+RU8nR2vnYyyZYfy/e1+pAsF3kovtLFyx/INmi28=;
 b=FC/LJJDHMTmcze/6zhxRQzMUoTK32pPVQfvz86MmWFe3ovrwKTI7kFH23/um9NJ0tDJv9c5LHsmxkWdxhLbLz5k1CRFM+FZtJYlXCOW+QV+qT6OXfzj/0/9ZqFt/vIO88kMTP16MzZ5vRy6ppJj4pJDmqa/yw6BHSpYshRPlkCY=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by DS0PR10MB7065.namprd10.prod.outlook.com (2603:10b6:8:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 18:29:28 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 18:29:28 +0000
From:   chris hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, peterz@infradead.org,
        vincent.guittot@linaro.org, "Chen Yu" <yu.c.chen@intel.com>
Subject: [PATCH v3] sched/numa: Fix divide by zero for sysctl_numa_balancing_scan_size.
Date:   Tue,  4 Apr 2023 14:29:15 -0400
Message-Id: <20230404182915.2264557-1-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0206.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::13) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|DS0PR10MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 510c3bfa-c59d-4c95-c5ac-08db353a8631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ulm+76GE7g49EkN9gsf/m6/wB6CG4s2zSxsaU5O+p6u/cQJ5qF4ClR937yCDhy+K25dssLUPJKBsJjo7UyttqJg6acui5lZ3EMvMeHJB86URb1NHH7qRpm1p9lec0pLzEB6yRiqdXYkJ8pBcfZYI15TwAsSiIS1dyf7n811N7O0kwWehVIgqQgDIyzYrAYRW0VxvTO7IWVgGFBSkg/wOmrKkPB+xtDsPxyu31XDn1fn40Ni30lRuuqG6o724pPDu8ZJlzoKb6AQjRatUgRu/F+dhKt/VTry7GDbMZSk+Ze1r5imHNpfP+TgGMJ0D3fQFIQhVOfNzo7dtPKTkiNOE55NYosSRiNPeVMQR8PpSCGH/IcCqbM8TcLVj9xZjAuSfF6lX9VnhmRwFaeWb9w1cmnyLWyh4yr4UbEPFaWlIwdKsVX8TFgpTu4i6et3nX/blnmxixomYKMjH0OKnqDzgl7QYCX5i4hQQPlyP2aXoGeBQpaJxb8j4CiXtHtGmM02ucmFlBXukF44WRrNCwPYdQGJN68KioNPQ59perVpgLn2yBJhwX/01QfsHgDy30qXd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(1076003)(6506007)(6512007)(26005)(86362001)(186003)(66556008)(478600001)(316002)(6486002)(36756003)(8936002)(5660300002)(66476007)(8676002)(66946007)(2906002)(6916009)(38100700002)(41300700001)(6666004)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hLECzwDM8/pVvQR+YYgBXK0cvFYep66CbNz0PLE65T3qEd+WSbJzasNC0/1O?=
 =?us-ascii?Q?N1xLzq9X1D9TtKJQWo6djr/exDx2KOoH9aaK/dbSvSqqMZ+SCcQPINswoFxK?=
 =?us-ascii?Q?l6eN/YNJ8r/exv5P7ccWWY5vAYT/O15fI7oUeqxPr5xfWYBVr8fXuwx7B96W?=
 =?us-ascii?Q?yuLqgLtcycD3W0j3qKHeli7Wa7HRwERVTY9rl23ZHGM+W4l6OHbTB+gGgEKt?=
 =?us-ascii?Q?u3NZJiaJTHJlZq7kR8CuR70EhWw/zJCRJB/f3XUDvIohcdwh3QN3yMXtOAa3?=
 =?us-ascii?Q?ICjkN20QKaCmBanwXkQQxezVhiZAli3wqIR4S1sk0oNa7cw3S7LPClwAvGSr?=
 =?us-ascii?Q?OGZZuj+p0us4NPId3Vug41ck7JbEgMeMkv/KMc+j/jWcM6uzy5SdQbLsUlm4?=
 =?us-ascii?Q?moAnM4dRQlWFS/c/CVLH9qzeK7QW+xv1Mn6N5hqBJiNQ7nJ3svqfak2RGTPC?=
 =?us-ascii?Q?mJrhLuVeXnbDNFaqrJ460rwEgi6suPSwLD75xEAFQxmCqbhySIc4VV8E8Bep?=
 =?us-ascii?Q?+3P82Mn7v8uy7x2l79cSBX/IxiUaByiwiQkyOUbi3PshvxSm4zpgRetwReQf?=
 =?us-ascii?Q?FfQoKHty+jKfM6tiRgNgXjBhuG3FqnAelGW/d/PfXnFJDvgp319EemhLTK3t?=
 =?us-ascii?Q?/2+O5jJiTxuD6rzjs1ZrY8zf7anzNX2CCmyBIbJSbDDG4TRLaxZNciz/3s8S?=
 =?us-ascii?Q?EfJvWrQLAfluRtDqjTaATh2uqVMs7WPWa9uWeSqgIv/wcMqS8JGDHRVjJXMe?=
 =?us-ascii?Q?Ln/UrNXtN+0SCb8ACmhkxLZ8awndobyWcRGP8KKDHbbsUggliYivxcjmauX/?=
 =?us-ascii?Q?JdHjb2QhbBUOZAg7Jd4g+6ql+NkpHpXxTDjhbHGfLrXw9ZtqQCxn87fOpOfQ?=
 =?us-ascii?Q?DsxY7lOrLhnU0IurX/TK/MhyC+NX8hBIJK0S33sCzNCmtQoWmpNEo8/YDcpe?=
 =?us-ascii?Q?aULm/F4auR5o2zq51sOJSdrzD9eCdcoVZz85Gpa1kB4flylua8a85Yq54Jlb?=
 =?us-ascii?Q?OhsH/stClcLNhf3319dA2+sOtxsrgKPWvzhBHkWukRR5GDO1f4ZI/zSFR9D8?=
 =?us-ascii?Q?/UHjRwFV0m/0G43RIx0NVg7eQBVyy2OBDKMMrXyd3DoAlS/yS9l2Lrz8Dyn7?=
 =?us-ascii?Q?Ba2D8/JAeHSIjTwV8OonB7P1/I+LB6Ennt8tCf6Cp0R/r+j6I/z7WRVQJ/yW?=
 =?us-ascii?Q?4RPLSjoGSkCmbiBp2OcDdfICT6u23qfdbkG2Y3maVQf4zRqb2W6oyRQNYFBg?=
 =?us-ascii?Q?NSB0VsBOHoFf4ECyOL5gE7WQA5vZ2zpxP8kinAg8AvgghbH7Jxro3cQkx58M?=
 =?us-ascii?Q?vYy9CLEDJN29g3g0Urs8L0uHuBUxxya3IZC0/qCaiSWTL6kKVLYO1m+2FZpc?=
 =?us-ascii?Q?FB+Eom2DuLMoK6CTKnO6/WRgtclzZhOzSw5GUcB98hZ1ACNTK63cgUA2Rm9L?=
 =?us-ascii?Q?wX1WreEYwh+F4Z8WIn4YB7C8oKIbwR2SaPOT/BYnxuyvm/gkZj3ogntF7Ydo?=
 =?us-ascii?Q?bwqZ8OuX6a3uUnLy6F8d+DRKq8TuCGS3WFVQKMl7QZWsUIDd1e4egldl9tWW?=
 =?us-ascii?Q?nc959B40B+2sxsdbRdkAQB5MLD8+USeihwU2Y3Rv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pIUTZ8ddPOF89Siit9vo6aJ6QxFIF0o0s9Xoe9AGLmSEwb+GoSRmMG7/wnWdPBYYK253k4nlaH0osn7oSFLO2N3WFgxM49FYy4vWrFoVA1CRJDYWJ5dSwcgbrj4SIgQZsvr/Vu2zI7oMfBxn31Rg7ZOZQPi6OYvNXg4E+VHJSU2nRpQbIN+Z59CERA4hyjwy5lda8wuChu0JGvfiKMABBwYGgF93KtmqBGFFafYuKc0tp6oTok549bp7Y04YLKNgqqpnjSspkFGLUKty54IsSogmC8K2U35uPIJpuFEfcwCBhru7qqbMRb8sW2snhobWTPFi4uuUg5FneisorI+GRJ3posX5N1Wjv+dZb+1Tk6ZaYYU2hnciKsT73M+ri8aGBz+MPd+C7/5cEduxKY2Zy4dw0iibxHN1TyCMjVbVOPQ3llDx0/utWHxI15ifCivDxxh/bDegx+jdhOxe8+yZHZjk3h5oN/FLsBY3fvnOfZO1XuP46RFXm5wy6aNuafb3/qdPxs8u3HdBtSfN6IWQ7d8PLQKrFNHOGLJmZZHOhcqlqbsVgeAV1MLFMdK26F8wEKr3FlIvpDebivTmnPZ4nltNR9f8dLXGaJ/PAl3leNRAm75XviFbChO6FCTCYQTtU4RSHzXkCvy/jsG9isyeDRBeYaGqAf2ZUgoWB9Q5BvTbCq/FpFgtmWTbRDwzEDzMIE+TGvwCYCb6kv7Q0akGgCrQ+KzRPSBgTUBfTKUJUOfOYSnOksrB6sRbvILViKr6CinPiUiZATvSNXD8PrYUtwMLociom1JOM6QyB3SClOB1tG6fCI3qeFMCWvRJdUlwDRJw/wh29mLviW1+kcbYWvOB9+m2jaCumNYcIY3hL6J2BUYnMKdk5+MQvk12mM+Y
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510c3bfa-c59d-4c95-c5ac-08db353a8631
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:29:28.0165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNVXSj6+a85Qp5gUDaVEWDMOmDzQGlttU1kQNcxEgIstWyXEn9IrqbqPSFojTPm2dGIOdnNmCEGOv7n/WwPikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_10,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040167
X-Proofpoint-ORIG-GUID: pCgr0Ucsdo0oew-x2fRO67ExGb1HtHk9
X-Proofpoint-GUID: pCgr0Ucsdo0oew-x2fRO67ExGb1HtHk9
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

This patch puts zero checking back in place.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
---
 kernel/sched/debug.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..cc6a0172a598 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -278,6 +278,48 @@ static const struct file_operations sched_dynamic_fops = {
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+#ifdef CONFIG_NUMA_BALANCING
+
+static ssize_t sched_numa_scan_write(struct file *filp, const char __user *ubuf,
+				     size_t cnt, loff_t *ppos)
+{
+	int err;
+	unsigned int scan_size;
+
+	err = kstrtouint_from_user(ubuf, cnt, 10, &scan_size);
+	if (err)
+		return err;
+
+	if (!scan_size)
+		return -EINVAL;
+
+	sysctl_numa_balancing_scan_size = scan_size;
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_numa_scan_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", sysctl_numa_balancing_scan_size);
+	return 0;
+}
+
+static int sched_numa_scan_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_numa_scan_show, NULL);
+}
+
+static const struct file_operations sched_numa_scan_fops = {
+	.open		= sched_numa_scan_open,
+	.write		= sched_numa_scan_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#endif /* CONFIG_NUMA_BALANCING */
+
 __read_mostly bool sched_debug_verbose;
 
 static const struct seq_operations sched_debug_sops;
@@ -332,7 +374,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_delay_ms", 0644, numa, &sysctl_numa_balancing_scan_delay);
 	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
 	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
-	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
+	debugfs_create_file("scan_size_mb", 0644, numa, NULL, &sched_numa_scan_fops);
 	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
 #endif
 
-- 
2.31.1

