Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D926D9C42
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjDFP1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDFP1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:27:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571639012
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:26:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336FG2ws032007;
        Thu, 6 Apr 2023 15:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ubaVPPJeTdMnraRaPs2CLZ9GsF8LWsu6S691blB7BT0=;
 b=n1NCpAghDoGQg51zqpm5E8JioXm/D2zAJDUgijDTybkhPPv6mxTE69PrS9bZ+WgJgI6H
 SfkwfSSIcqRsq3AtqjB+9I/xGO+j0Rr1LO8SjeKwXPLrmNYX5Hr5Ls1VyoYogCWnqkQz
 0vdWeKZV+jGeXMruOqHXU2wTgiPW8imcJXQI9spaJ1P+ZGwsJc8D/RlCwEu0JUR/GAcB
 lr+eDBSLj3YoSnYfcVmflf8g2VqD2w4bQn1OztavLuLXHailqWxfUk6tzPLwSVOsjy+l
 /FSPbEGE2ejduFQF5ZMOgTuL3dgMeD2TjSFk4A9CasS0mQyCIQUkDgx1lyyKt21eC/WY tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbhc379q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 15:26:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336FIMnU027433;
        Thu, 6 Apr 2023 15:26:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptut5b3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 15:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiDQxZaJWRpYADr9IIwH163JL+HWO05pH4JBivq32HWfDDgHtOvK1NTsfws5RVVnFR6kpKm/0hhQi0Wyvu6Dj6XaWjG/NdR7NTkdfSKWnkb21IERTLUukA5vso39GMBbbuoFojrMQqu+cPeEQc2wiK+u81KNrpX0W9WUf9ZE4aS8ukOBNvY2Se8KtAXyjlESAcs7+FPcIWP/101PgqXqklS8/eNe41G6apNuLNZBEOapIGRFP0oTfJwrkHjNx8HJ74ApJuvLZRuOu72xiniEaK7q046EwKFd2fu2nlz4fwcX/MX+Awvb4InuZRGyiLU7mQyE90WTiPMJZZGYmNg8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubaVPPJeTdMnraRaPs2CLZ9GsF8LWsu6S691blB7BT0=;
 b=Fadw1N2+hyfx7x3EQfFRUiw+6duG3aZQGzuCGRvoXmpMrE/sUV3FifqUWC4GBMaGRgMBv/2RYZcMjXNgjQrwIRxORuCK8roRv/SeWzK2Etq8lixJ0rD6uud0bVdKcyuY0obz7oH+xJnSwomQPwBSWqpbbt4j+CUsgmuXiMZRK3jQI7yM+rjLhj9m9mX6qEBZc9zwkaQcmBzAwWqIwXEWVC1xzfm9TfqFvmHOBIwAgJRfUUmuBXXZf3kmGr5dW3Vo/T+fMhGgkUW9V784ko7BidkNuJWYwVeNn18Ckbb37R4P//vdSHYoNEn/FQobgkdNg7Qed50zITxH7hioWwsSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubaVPPJeTdMnraRaPs2CLZ9GsF8LWsu6S691blB7BT0=;
 b=y20X9Qw1ibKLkAB1HNUJc0vyirbDvyz45qMUBfVq/R2W6evw28uAux/WyrJSke47rAH8+nJkgvUBJymeBd1KXHYJdwMVuJ89SpKJC1EXbhR/eAhkdB1CqdGlqds/OzXF9TQos8bzPQKQAxDP8WMxiqiIGVubAhkHRWPE1GX5ZKA=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by DS0PR10MB6947.namprd10.prod.outlook.com (2603:10b6:8:145::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 15:26:35 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73%5]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 15:26:35 +0000
From:   chris hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, peterz@infradead.org,
        vincent.guittot@linaro.org, "Chen Yu" <yu.c.chen@intel.com>
Subject: [PATCH v4] sched/numa: Fix divide by zero for sysctl_numa_balancing_scan_size.
Date:   Thu,  6 Apr 2023 11:26:33 -0400
Message-Id: <20230406152633.3136708-1-chris.hyser@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:806:28::28) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|DS0PR10MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 33467e38-3d96-4f04-f04e-08db36b34ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //V2Q7xx2A7X8sz4j3KSA+khO2v6t1/x/jomYm3lqXcNmPpPchD+xRqtHbCWvCDh2OMsRvehFVXA4b73GOsQ+mB96tZXrj7xTIJQ+H5nTf5ova80MntlddDvmM+1q8Yo5SYNxJyrxtMOw/3v+p5qCAAcozN0HpgPXSrIjJkYrKwD+heFWNUFOtGLNnsJyf4swsPIv4u2eiMj/iGOk4Pnf9FLC3v65mUdc1gFi99zsvy9QBYdpWAkuBtYLlRpTGDr+sx/FbKU6EQE2IQ0pmWXH+kPU2s1EaOiejo+JJHezAL1ciwCWMe59YjAobYS2fkcETSwftTwHgqd7LufPL6hfLZg/YAB624SSD5ckrKYJWkOPmBZgxqdwRSiMFamU6JHxk/y7bPnbc0xlzr2nMxyYf7vcdWqn/DZDvru2Mprcq6z2n6kMtingqAooX5I4AAQzo8WkOXi3NolIqa6whZi4QajPZ6V7lo4wzKZX0FGNgRv1RhOS6mHWcBkixNraAzJbPgtEKoBip/aG3gJK9jzr7fBwioYQ7Hq8plvaEZy5kBt80wcAJ1x8VS1HNZwkJ7z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(38100700002)(5660300002)(2616005)(26005)(83380400001)(316002)(1076003)(86362001)(6486002)(36756003)(6506007)(186003)(6512007)(478600001)(66556008)(6916009)(8936002)(8676002)(66946007)(41300700001)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8Rs2rh1lSugFfjw+Ow7EVIhkb1rvMSKEPL2/PCQqNsrvd8fHaLW7UMdgnhz?=
 =?us-ascii?Q?uN3NoxarDGDcwkv/YMANP6boX8KuevU9kfrT6mNtcr5Z1GG1feTudUCBaMtj?=
 =?us-ascii?Q?WmmU5hW0Z62aUqfMpVe0X7rI0vKJsuq2DlgvOGqu/o9aQW/DjoWtpYj3FWv3?=
 =?us-ascii?Q?hSR7DPaorB8AEjSpjrO7f/e8um//DbH2+qH5bpcUID/GEBm7POdYDfTaBO+4?=
 =?us-ascii?Q?giJEve6c4Mk0Gy9iCFaD4vJusCgns/SErB2GRver2TkasTpJOQxCnbEXv1WX?=
 =?us-ascii?Q?zEOqUQUF21Yyh4AtUhHjJD+fUVyxjKd966zVioMonmtWHuJ9QoppmhsTXdtJ?=
 =?us-ascii?Q?YWWIbSW77tUE/sIJlpACNrW3HcJgBs7h3287NQNRjwiy1c4Z7v0fLzZnOAwy?=
 =?us-ascii?Q?XwsgcmZxfkJNbAzjuC85f4vQ8CTOSQIwMC+fOZ4Bgt2uxX4lEDofffSTzr6w?=
 =?us-ascii?Q?g2f7ACsb3WE5+dqHUnf8ooXb0SXzdZF10L01CgunuTaRkyHeBAomYWKr7PfC?=
 =?us-ascii?Q?4Cv8YHubcpU4WYTAufXNZIxbMNfIWcS4G/QzyCNJK4grJUUo8aYI//SM/rfB?=
 =?us-ascii?Q?/MmLzSJl2o/nzb2sOsWEWF2a8fYJVQmAGPTSMJ/gEvTujuAyUe0i536KDLbL?=
 =?us-ascii?Q?q6u278BWt8E9a44CsvxyMvrbCvhWl/nbFmMTbAI53WbgmON/9M43YcYv3EK/?=
 =?us-ascii?Q?4MtHlWcJEkWp+sJoiXrT8l9wqkcRwOxte1yuw2E3NH2FZy9U5vZ1O0VXWJE8?=
 =?us-ascii?Q?2fjTPjI3G7QIRw0w/AyWRtUeWBJafcX/sWJZCX+ZHxqhtyLetO77fVgoO9E6?=
 =?us-ascii?Q?+Di4KJkbaiEbksbzYTcdf8Qr43Z74YCmyrUJ3sgirZVL0Gsv1cXnFQVJiji4?=
 =?us-ascii?Q?KvmOHuuxa7EKhuqheBxqEbibSivWP9UHAQJFhMVlF5yPvY3ZBNFuL3cdWApU?=
 =?us-ascii?Q?8xrs4YS8wrFHJP5JJ1F2PeSRqsWfGO73euKODaK4+X3fz6EQSf3n4L3C0tU6?=
 =?us-ascii?Q?pSgFzinSy71c0GDfkQ58gQ3XuLA1AAMp5zh8g5YWdlMYV6jQcAK2ktNph1Uz?=
 =?us-ascii?Q?YgP1joEquJp5Eyi0wUumj2z+UWghz1Y31+xVa2yTr7lLsJYmc1LgR1/vyXNV?=
 =?us-ascii?Q?MQymhk62xM+qeLvnZ8IQ0z0XtiEgWefNuicJ5+AO01OcOUCjMJdb9j8xeoZq?=
 =?us-ascii?Q?3zv8WWdzYgssLNJrldVgkwYN/lx5uhZPiqaVJrGH6k1xu6uwGGQM9B8wwOrx?=
 =?us-ascii?Q?IsRPfFA7Kq5BnE3FiKyF/gbCpUX//UbQhvM9lFbRENaJUWlf/GAOBB9JSdNc?=
 =?us-ascii?Q?lm24G8SHyhhTpkXGtzs3b4GwBidmbip517byATmWpGT9OlAVBDwEUYhRrBAZ?=
 =?us-ascii?Q?6U5iBYIGKrdKXDgoQ4gxT2MdVWFengUKqn5AtYsDLE6inovIzY1tsbhuPUdY?=
 =?us-ascii?Q?ciFckCa8+Q9srVpmGqoNjbh4q3MHeUarzlrffmNqEGcF4heRU4RgNRkJL3Ae?=
 =?us-ascii?Q?bqLkxNf4NGng0hZrMuwCFGpYN0/JbqH/8oqqYnmDu1Ph+TRph41egEKSAzCD?=
 =?us-ascii?Q?5b177U8Pfj3rWYIYWctcZfVxrKsf3XavfkAXebKc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OyHn97oPTdEWaNbcqGWHp4vFNDCBQ0cs2RgIJCETAhar9gSHdgMBTYDtbvPOJYNPOrjqFHBs6pIix3pFeJZhufCL5PuOFwEfnSCQQfI0KjbZseq8WAKkSePLv9cJyicSdOCa5zlo7GBnBdQ42UrArnQV+s/YCO1okvdH9QXSrxqbyPWPSR1/3ks9pY7INL5hNkmMh+8lYLm1yf8zH4FJG5fzQmzmvPG34gOhRthe/MMW3jzW3FzuNz3H0jaTwR0UYTwg/2dzlMIhOBI8ULjzYrwmlITfGwjuaKMJR7/3QjxS/xmYIJsyGV14r4JcoGxKqtxV5KL445Ph6pUJgdWVGxSiERIhjBaL/fDW3NuwQM41x8uQKu3em2IuHiY4cqwsUwV5gtG2nC0TyQKEVTfuiM11Imif1oyBEdeDas7HH5ED/2pegDJ1RH9Oki40QeHNpEylMSz/DG8SCItpq3TJtckMPbB0ry/xSUl5B+SVgUNIJ87Yg/i8wT9eF/MSepF8LnEY1o0XYU6fGh4O21tDPBLHY9VL7Grih+S7+BjB2fqUKBf+QABs+UbcDWzqfdwZc0DrBWRitBsK1GYb8Es6Jgell7OFlJ2HYScJwFmRMs1yyaDhEjMIUyn9hDq5O17S/FSwS0jQzk3wfb9p75COImRnAj5mddzv72/qD3LeBWaJDRDohUNze3BGMZmKuFcsLtL/6fsHTBiiWxWkueGr3Dz0ZDBlhq4owZQf5QiSjqojBtW9FlIZldEonZbEcNhe7S3CNYAWVtZLD9/k4WjMd8N35bfEADAEeopyFURMC7+0ZnK3dHN64hoP0bHQ89QYv5w5EsdZyVL9bjSvPyg4EDc1rDox3drT/2ZN2xW/Bqt27lyxrk8oGvTRLRysPJQM
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33467e38-3d96-4f04-f04e-08db36b34ecd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 15:26:35.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRyYwkUVGNvOJMCAwLUNi06ODz0csPFP9yjDrSi3ZS02XLT6myEGRXOhDy2QvOP/tmkjweb3ER0ME2sEd+zU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_08,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060137
X-Proofpoint-GUID: pbyekKZAMkucGUmIzfHalor8wvFE78E0
X-Proofpoint-ORIG-GUID: pbyekKZAMkucGUmIzfHalor8wvFE78E0
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

Cc: stable@vger.kernel.org
Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
Tested-by: Chen Yu <yu.c.chen@intel.com>
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

