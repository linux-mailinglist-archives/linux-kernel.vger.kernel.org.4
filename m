Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1806CF213
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjC2SXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2SXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:23:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222434EC1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:23:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TEUFZl024692;
        Wed, 29 Mar 2023 18:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=MCka7TBnNmc34huvczEwvWJAPgHGy+InfiEMqu+JRYQ=;
 b=RBFqd9fQILNhh6w1j7T1kTyQ/VZQhfZmkJnQ7/Xqc1WJ1Pka5ZYwhjkU5IyF9LRpwGbC
 NUkYxvXoBSIuXF0jLuiBgkyly8P5yEnRs0QU/uP4qlMcd+YG8QC3rGcpPH0DGWaTyb6O
 hpelpx344RqVcQAgCjQwLQksYf8+tINe9YPVMfsgs0+QOI0AVQFze2THY87J+a+4/PR4
 cWPxintlCbJZpc8qMzL0gO4tESNbsKWKfsiZICBrjAheIeDdIDJ+oTRjElRGyru+RVbg
 +9w19n92a8UFmOZdRC70xaBHJ/TdO8R4PrANAfX0JGHtjZuVdi/+2tlgn5t0aBc34T2a 3Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmq56rpmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 18:22:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32THSPWJ030076;
        Wed, 29 Mar 2023 18:22:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdeqk1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 18:22:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ad4uCW+iVraL3I+Ca6R+53cmk2hL4bEG9RpBfOBSZl1QCD4heXaSHxBeGky4boY7OiczUA/FtkzkIqB+9sY4Hqh4eXAB3WwEnK1Aa9p8SzR3be99gRhnoPE2pj1zhQOJw2tE5sGD4aa4F6Bo/DbNIXdJB3iZL5UJD594zembPv3MHOhCOfPlWfIaGy3G44rxNk96/exUwaIJzZ7P0oiUKOtz6E/H4I3A4PzZi09jO+2JSE5KW+T5KRVdFy2WiOO+3roQKuaoRIGnYffNz1zOC5LgYRs4OXw5veKbh/d28qwFZE3ZWFXje+HB6A8ESGa03vzKv523w1OZORxS0bnrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCka7TBnNmc34huvczEwvWJAPgHGy+InfiEMqu+JRYQ=;
 b=ThSCmOVQaElLjxwkV3IxUgA2sjC3xQNC9kx2IA+6Pf4ITZnhbTRDHelF2OmW7xG2IhKcBvLW1LjZbBygICqnGEUd1q4yrn7r44ePvSds28AiY/z6K5tsb/Fi1qbXKe4dhylCyFE/TjFrdu9Q2KTQ3uAQRpGyFvOnmjv4O9SoKdALuhSKZT0gMmG1hpElW5NNWMxViOf5tzR2pKfoRWjP8O6lZ8qqhZqGnALTDt59uxzxY+QyNE9L3rgTEKiL/OzNY89n3B7JXXUnRH/uDt9DtZvzIlaUh4W/HHkbzZCKzfLjF7RZU9AzovJX+Tr48Ho1WafWFFO3xq/pWQj+iuDs6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCka7TBnNmc34huvczEwvWJAPgHGy+InfiEMqu+JRYQ=;
 b=Hb3X0BUmwXUuRGbOZZtqLPE9ZgiJgUzvmmtFsNfiRQDRwrMy5ObQ4j3JZEd722kWbrHWke8Rmnd4mOtguNyCyGfFawu4log1ct/h/0vLfw0h1YgAjO+H9f/rAfYVXXNwnn1SYlTCKYAc6QML1hpbCdFslXKrVIUSH23yW1rmhRc=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SN7PR10MB6330.namprd10.prod.outlook.com (2603:10b6:806:272::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 18:22:50 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73%6]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 18:22:50 +0000
From:   chris hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Subject: [PATCH v1] sched/numa: Fix divide by zero for sysctl_numa_balancing_scan_size.
Date:   Wed, 29 Mar 2023 14:22:48 -0400
Message-Id: <20230329182248.4155546-1-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|SN7PR10MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: fab12366-f9bc-45d5-5186-08db30829a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnq1XDprY9/qxhtoytGWPfxoEABsd1wpkg2totOuXDtbNRRKrqkHotYNfrp13YOZ3bkstg72HlUc3VkNPs/nqJ4VWEPuX3N07CsugXTXHsnzMaX7NgnIzdV/QXhksNgObM7YJ3Fni7egwp7jChA51A0azujC1qGC4wL6ks0OidoSxR9h1LvhdSFkbguS8xNsr5w4+NHdYr6qRvvNy7aoL8bNC+pzVCnQngn5+lhY2sEoQz+Iw+YDTO6sfK8BCTWeKRETTrIhmOrKXUZPqB7xsF2PPdABryfs7cWnOrjue9MTYoz2fCULlPXyLK5VM3Oi1NBoNwt/jyGvJMlo3tBtfFoe/UnNbQxaUArLVw4zRoDt7LREfdBUUT52mbPk4mwb5QotKArYlfagKtvAjDCBzTkD+m5yiZVRtN0w1Prt8ngEG7g6zsN5l77T13MFt/va876kcc70ii2361vhTeJq3gJ9wJVhiJomsur+HNhprBx7/Rax215+T4/IwtKvOUdmj0TEHb7piYxrKG95B24QRyIK3jiO3C5Llsgcy9CKNJ4bxvowQ37M2i4xmMF4KrTg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199021)(86362001)(36756003)(66946007)(66556008)(66476007)(41300700001)(316002)(6486002)(478600001)(5660300002)(2616005)(8676002)(8936002)(2906002)(38100700002)(1076003)(186003)(6506007)(6512007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4JDKkCsd9dl982cu8WiseVFB6Pl/8IQvZ58+UorddvsgH2tz3v1y7Zl4vT7i?=
 =?us-ascii?Q?X03271LIMHJHPXW0DkHuxnEGLwutuZgU7WyxyWdPytwRO4/Y4x4h7KCkHuE6?=
 =?us-ascii?Q?1bAZ6OeaI8vq6rz+4vh9tLBUxMdU5PubtI4QAasDsh6oxzrXtB1dIrWBeauZ?=
 =?us-ascii?Q?RtiWmDaNztDMBtKstKISMYY7y0eto4YU6Mrvwz9+3K3j7ZGHtZPfoO9kFLOk?=
 =?us-ascii?Q?AAXpDfe1B7Y7EYjUNXMWLX1XXbPQ/sctIzpzld8SeYsvGRWCqZIzbhIszsd/?=
 =?us-ascii?Q?1swJM3i8PcWl3rvHeK61DtCZFQQRPQoRCOC9W67BSiCAu6qV/LZg5quBpx9w?=
 =?us-ascii?Q?YGzPHBM7yVACPMqtmVwpQ+Z2CRZA96zdLVWWtFHSZFBgbZsvjg8MQgemOP/8?=
 =?us-ascii?Q?nUNEdD3SYjHA+KPVJVwmZYOjwvOpNg+txBUktcABOq9JOEAfm7plUpT4bocp?=
 =?us-ascii?Q?NGZekryQB2sOQwmWdWmWEPWQ4lYt9vf3C0Bp4zqMmXMwWUKsWSIHeVCZXKUK?=
 =?us-ascii?Q?kdtNx+jjF9SSszte1CJpbf1kYHOimZOPEE4ysMSKvnHfquLIKX0b7RO8TMWC?=
 =?us-ascii?Q?kf8wUZM0xZgwAo/tWrIgNSmprfjPmYyd9apIDnB4b4jeIgFgFN/jhLqBt7IM?=
 =?us-ascii?Q?Z9idktQnP+82mZMAgwCMZtz6tOCK68mmmlLkQ1dfBT9uNSeLdsJiktoPc22j?=
 =?us-ascii?Q?236Or3vPyJ6eGs+kZ2nfvMgFeu8O8OWPi6zIvmVXyQomyBlISq/jK1BDdt2T?=
 =?us-ascii?Q?X3ZrhmPZDxbXnAg+zxM0OwkpM/+jaRMejot0C/dp4r4yySc1f5xgNke93Q12?=
 =?us-ascii?Q?vkvE7Izbi2NW+edsbTc4XSNzYFtgH9USQ2p18joufRWn4epEZGQOQ8vIP6NE?=
 =?us-ascii?Q?ajGhwmh69SBxHWfiNj+hZaduTcmdtDTRWWmQbO7vO1makMmH6qP1ZFML8YrZ?=
 =?us-ascii?Q?BgTC+nEOub+4hNCzD36m5nKbGFUyPi9syCHQJ8RxJz91mbxB/F0cR8SjUwaN?=
 =?us-ascii?Q?MJhft+AjM/iCvkPCPItkMK/Qefuu7UZpz9NSt2bkmsDuUi9sP25DLgMUL52/?=
 =?us-ascii?Q?KZAVtN1tc5PQYYBXoI45zlDQnXpuDxs67qqKgt9ZtqfKqSVA0H1b9GUR8wY0?=
 =?us-ascii?Q?lS5Ur+Lc5PNKK0X9b7cPOWVZMXK25pvYIr7ZTU2OwKFTlcksaO2uP/uBt6zI?=
 =?us-ascii?Q?rncv8UxlWc5vXWfGmknXV6NWX6TbZhE6aKQfk789yITfxmw9F4tnxTa2RTiR?=
 =?us-ascii?Q?g3vW+MwIV1O0ZmMP0s5l/cxZNdUpKkYbStz7IA7GaiKBabasc9sYwKnPeV/R?=
 =?us-ascii?Q?tSfnXy17KKDEqq1yaBRbKfWRy+FTGGAKZh5noOSjkZyNvYB9c+EEq4lNQP76?=
 =?us-ascii?Q?Up0xIcYwKpy0fwO96Bx2F1rZ9B9Eh+RTZZC5EUWH6FHsos+J2sTuPrU8zFqz?=
 =?us-ascii?Q?kTulin+4a6B3uOuzFoBJjY6x+Y2DAAZGKll4cEzBcPrH2H0DizTvcLHiR9M9?=
 =?us-ascii?Q?v/0E9pC1ZeOFXMw36/ldXByKYHmRjTvW7OaNvn7jFcHmpKfeFLTKjXELgzng?=
 =?us-ascii?Q?08EVOjZOuC9G0D8kZLcWkCjA6+mPO13iwCxEslAU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sNLJ0z4cwV1ivdLDaJYB/JznYuB68BxpjEeF/sOl9wyLUXdgvDLZ9aDLGeWoEb9HQFqlgDlsojpz+cPlOPh2OmWeOPk6VuGRVupPdSuol9OTsy1he4KqtRwLBDSuhmoKFnBpKf0wSFRb0lQ5+uqVEm+e60QCOoD+LojzoICANBKxcg8ByyUL9OYKtuGn9m7msUCNA2fK/8g/CgX1AgpC1ha5HduH2l0LIRTUxF22IImRzUkeqkbY3yOHoA9QIL9hdlbtHK+bzarNr7MoF/4twrdZkGWhP70yzQHj9ASFHM5dygqn1p5rbW9Ze8ZUIgSd7ReH3fh/qDtMSFj/Dz8r6EiiWlHDXmP/i+oz164eq0HHr7MWPREARzKGWFlOODck2o0p33bqmHsm77sdtBi62GhAXaDKoZJ75ajINzngiJAuO4LU7eXMwzFL73AqdqvIx5ZNa/UH7kDTUs8Y8v6KV0tsZFTLVL1IlVbzyETjP7rFUERW2pd3ZIpAvQFqcGcFsIRbSKoSezSvnyGWodltAT0WiLrczWICE5Vpn4O7hxzEduTY+uGRVT72JqSsLBw/Cfldbj5C+OrbXfpjGND/o/wBhC+QkodDH6JvwX+YY9eK4pdz/9Xf3AL3iJ7sxGZ6KT6/j4/M6q3Ddm8U5Nro0xvghl7LCbjM+t5Bjk0h3R68emzsmGiA19t7Mzq45bysCPmLblpt9/mkqNXa3mMPpkkaBN2oiWgcwAPr5InXyVEoyfz9VDjHAgFHkjCBS9UHqXSNXnCFs9xvtSX6ngR7qrywrmH1gDdwawkng0CCJfVhP8A0MSkreEajfDfP1ypP6sI786pNYRv8/ssmuKkhaIiZKq/FUlj1XgEUPfQVPwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab12366-f9bc-45d5-5186-08db30829a95
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 18:22:50.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gj2BA8J2GXLLlqMJ+sUeuXRlwVD0xMwvOuqtXOJ+ICg4nCdMfLFT/QkaeAEiZFtPm4c1uSprqj2kQe3S7tBW3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_12,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290141
X-Proofpoint-GUID: Y_IK79m5B_JISEAUWMjhsItN1tEOZ1lz
X-Proofpoint-ORIG-GUID: Y_IK79m5B_JISEAUWMjhsItN1tEOZ1lz
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
 kernel/sched/debug.c | 50 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1637b65ba07a..dfd0fe6123ec 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -278,6 +278,54 @@ static const struct file_operations sched_dynamic_fops = {
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+#ifdef CONFIG_NUMA_BALANCING
+
+static ssize_t sched_numa_scan_write(struct file *filp, const char __user *ubuf,
+				     size_t cnt, loff_t *ppos)
+{
+	char buf[16];
+	unsigned int scan_size;
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+	buf[cnt] = '\0';
+
+	if (kstrtouint(buf, 10, &scan_size))
+		return -EINVAL;
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
@@ -332,7 +380,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_delay_ms", 0644, numa, &sysctl_numa_balancing_scan_delay);
 	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
 	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
-	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
+	debugfs_create_file("scan_size_mb", 0644, numa, NULL, &sched_numa_scan_fops);
 	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
 #endif
 
-- 
2.31.1

