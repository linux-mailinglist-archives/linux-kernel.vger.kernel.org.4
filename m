Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4CE6050A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiJSTnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiJSTng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:43:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F431D555F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:43:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JIOL30020641;
        Wed, 19 Oct 2022 19:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2022-7-12; bh=rZBMhM4k8jqNKxEdOY2rYupT1BYq2CyvoHLZNXuoy7A=;
 b=R9Apbv0/OVSGU/k6PjweeLXOURfljTs7ITU4UWw3JzxEC31m0Cj+EV2GtvClMQvoK9+u
 CjoPMByetI04VUvBEh3PvxCwFucJXwKMY5SQkNxnpaNzGJ9vJ7UrdrTD9OtIeRO0tpVV
 PPen5bIeDqF1uqgI1I91BjeOuOBJ55nhfFuM9xKYDW9WxNyHv787eUULNchGjzfx1mVN
 fsijnPZBt1jas7FUJljK18ngCQY39M/21Z8E4UP2t+i4GEw3YJrkmxvB/FHv/GWmNql+
 WMNmwPMq8nj+B1Eb/KHhpUZghAHTDeY5uK3QtNjPnx+rzQSGEqXfbPhhZxhxx2UN5o5M +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu03adn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 19:42:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JHo5Mh016582;
        Wed, 19 Oct 2022 19:42:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrc4gdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 19:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au/OvIRBQqNPi4Mmevi7LqyXgQmNxL9rftkZyLO+FEkzhyKezechs5YcdrUW1imF9UEzPpeq5xSxcmQH1ItjajSImAaR4+7gBFc5YpCh4KWAu8vnj35gU1q+KRbDk4n7NXhD7y7MBza13284pMJMn1s1joH9zOp8+mFlaOkgqkbTF7YvIqxishjcchzmivohW7bBfBpmFwSN73KnQJRilGMnpotyPsAHd8ackL2pytoUlecdM13M1pWfcXl6dKwF9cf98+kWyZkGP1ev6eZQYikjF3xgnKx/+Y/x7Gfp1y9iwCPFZgLLsbf1fm+j6KscG99WDofxZRzrxsNik5re3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZBMhM4k8jqNKxEdOY2rYupT1BYq2CyvoHLZNXuoy7A=;
 b=nn9ivQtI9tGj6nZT4yWPo0i/d8YeQqaJTby0rGrldy8LmjgFe/7jwkNgskp0u9ooV/pAmVn8by2ja27Cg6QK+wbqxiZqynlUwhb40IwrG4hEmsp1hdt0CRynYNVUsI3ayUPNgcWkDS9EJnx8AX2YDeuJBSBr2PJ1L06AYxQ17wKLzABWTZISpiOLQVdzlJoB6HYwInOG4fJRQdj6vtO+/qfLI2iR0y97Y0nXmBGHEGDJH+UxGURLnMEd9XkWuPPJajkKAFsjWSQio60wYVjgCJpWzao0+uuV7Twd1nrOwqsNcoveXZlJXSANQ8oWyW4jzmEm5BS0Nze5uwcxOTP0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZBMhM4k8jqNKxEdOY2rYupT1BYq2CyvoHLZNXuoy7A=;
 b=C9O6qM1oNIR+coLOgsaq7ArRX4I2cbe1b3KDWo6JnaxYqHK62SoNh6oK6gzE8KZDEABHY0XIGejzHY+++o+5QtpmELKcaKRf4dt8aSCAAr/Caiz/NJZ2ysz16waCdRze5j7R1Q+ebo3NyhjmsHefP2to/ZA91POWnWSCbqXFq8I=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CO1PR10MB4403.namprd10.prod.outlook.com (2603:10b6:303:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 19:42:13 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 19:42:13 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     wangkefeng.wang@huawei.com, konrad.wilk@oracle.com,
        haakon.bugge@oracle.com, john.haxby@oracle.com, jane.chu@oracle.com
Subject: [PATCH v3 1/1] vsprintf: protect kernel from panic due to non-canonical pointer dereference
Date:   Wed, 19 Oct 2022 13:41:59 -0600
Message-Id: <20221019194159.2923873-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0167.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::22) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CO1PR10MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a19cf17-9d4a-47f0-970d-08dab20a0551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWb4RpmzWTS7giyf7ZC1MFyn6sYr9rJbBwHvgbQdfV8B2vezF2PXmj09l0h7Mygy1gFC1rsYT/GUvHZP1NFuObvUURgftt8FFpxkM9V6+TMWujj+CkUjXYzTdO2w4XXUxyBltBRVgsHKn7p6e+Wo16NFwDxh+BgtqG8DVJdDgT4qFQWoboqsGAubXFAHT0CDSOwSlshe+BL31IFp9A2y6M7awDho9QPiuVQkUhzEzxGxmVSkeWITnpKlsNkwlLlymBz0ePzWyWljoYrzHf6YsG51OOsKd+gzGZBi4N1H+MYKZLqqP2MNkmhc15yEjh4Av6GCsZr+J7c8/Hh3ogjEyjqIlTG2whf5QBSlGdE4IS9OTZh3Iqg9MRDf7nm0n53/uQse/zx/01eGOekCUlnkNFetIARinphTuhv/5rQYkPljTcp8VzJuWpdgwttptkWvT5UW9tDbHOYMD/kIOmjBZjk7RPRKW2gqvhfyDeAYeHL7W95P3cKe/4qbgxpE2s9FuMdXhMfCjJ07NuXXUShrEC+A8hR0kpzwM20wylQ795/Z1QWpLLzvz+IoYkOa3tAgWQOAbtTpd+qjK+NOcv5u4TxZsta/KdFJu8XtdrbDulySvldsEWrvkszu4DtKLjgSKnv5gbo1vbqGV3lbGgb4EvvtX0RQXPSWwGX9aNF/rsOvyqMCH1/vGZxrFJVHBHZ/iLcyjdGuwKPn+kzIBXHOIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199015)(1076003)(186003)(38100700002)(2906002)(2616005)(6486002)(478600001)(66476007)(86362001)(66946007)(4326008)(8676002)(66556008)(44832011)(8936002)(6666004)(107886003)(36756003)(6512007)(52116002)(83380400001)(41300700001)(6506007)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cLT/ujUNidxBeuWSewIrTDAnDIEL7Cd7R6hs7kFchKamfwVPDuzQLN1mamTc?=
 =?us-ascii?Q?fce0Ln346Ikr2v0+Jv5YdDFo5+rUuL9JRZe1lL1h8/GPtUcmyMgluLB2dBQY?=
 =?us-ascii?Q?VqYBpdOujwh8geLytXZ1SvzjXLV34o/iUGhqC28YVqHNZmaxLnb21xoTsnvf?=
 =?us-ascii?Q?HEVTLlqtp/xeI8P135kpsHDxfs4SKjVt9frNH9+8UiEDW6TeM8A3hTVqpa9K?=
 =?us-ascii?Q?s/nMb9tGUTDDgAGf3K3/HLH9L0uk7cfuHUdWuQ2vn3b7kWsbqkH9oppth79J?=
 =?us-ascii?Q?k2toKQvr64zOX+DK52Ke+59HJjF6sJ0AlP5fj458FzVE90iyPWuahiDDZcet?=
 =?us-ascii?Q?daOGqCVBFheNoLLDJ0gEIL+urp20jCXSdzxTC4Hun0Ti7yIe+xEWfw+pk4jW?=
 =?us-ascii?Q?bhBlIGmxyejmUrnwEqrxz9roDP5cik8k8h4Cr1DC7uFiA/KOmx4Wahy/gZKC?=
 =?us-ascii?Q?ATHtpdx6eRqbKWxRDO9PPIVeECJ+ia5fXkQkpW9lQZygZ1c6NnAEhhux1BkA?=
 =?us-ascii?Q?4RekZKKKR1RPPcfIGYs8EJx5IHcie+2n3LYxONHalmGOGTxHT6ERPNbLaL86?=
 =?us-ascii?Q?ce2MsNvsXcBGuvFAAAEBno0EBXdRbEUbofquXGVwZHfaXbozKCRzIfQUjsRF?=
 =?us-ascii?Q?dtAr70QWY8gwDAXR6m3YxZH512BQsSUDhnGvMm9exo8HmClD1x5vOYCJ/LML?=
 =?us-ascii?Q?w9DIdWlrnYwSnU4FmOnEa1+mJnyl50RAOrgwJiC21RBkJJUBd5TUeGFceAum?=
 =?us-ascii?Q?QfQ6bsTH1yjKh99xSSCCdjnvcTUx+MiF1h12pNhvptiKkzQTPYRLzHCaGU8q?=
 =?us-ascii?Q?aYzUmQ5+eSmZn4xdpSAsgu9rj4zWkEKO3NwhXhkPHE/l0GixpVuqTvHl9Xzi?=
 =?us-ascii?Q?D4y1Lko/fFC050bFKrDYZFn2DN4bko1P0/UsLKKSbfQJCYuBjd4bqGXFAxN8?=
 =?us-ascii?Q?4FjNGRe5Hj1lRKIUfKmg0sBtcYX4JttuAsJjv5sdBBwZnV/qekU1lwMJ9/uM?=
 =?us-ascii?Q?qee61NOuKRm9iP8lZ1o3tM9roS+b7ms+RAU75fJG9LQvlj9c6p2YpxIj/0+d?=
 =?us-ascii?Q?OPay7yr4IeaXaLxDHQPU6wKSNOF8JbqYUr/9cO6MadwHLgS1kHijKhAG0XQO?=
 =?us-ascii?Q?FfWQuNKIr+D78W4PXjAz+XFlgRSyOzfJRMaFU2zrlk6ZsVNiJZnmS1oED1un?=
 =?us-ascii?Q?I5WRU80363mj7sMLGUJJtzjOVOIMrCpxtU+Jy28pA713d26tPq1INw0YlIXj?=
 =?us-ascii?Q?drfKF377cPG9pPQe7ebmkOsGpqEKkS5X11bG8WAX/ZruBR9Vm4lmGOubRfxr?=
 =?us-ascii?Q?5hQIME8aTYpchAcbGwAxeBg8CqREepEGWZ4w1u2izDOoXtm8Zx5OEWZXjA69?=
 =?us-ascii?Q?Py9raYNGZWlshO/59MHbUu4EAKgWhBrbddWJCrgEC8pO6SqahRpYZqAm5X8Z?=
 =?us-ascii?Q?dbt8DDq+SeiHFQhBUxTlCrZWP/glPrN/qeZb8rW7umxpIaPHkzegr/6uAIrs?=
 =?us-ascii?Q?eM11ccWCqdM+lOcmw/rCzSslsXO3nMeizc/r3tB6hlz2561iBlQpYDSPxQuA?=
 =?us-ascii?Q?Ry7J2Jrn92/lS+knSg1g85H6OOsBympUUyVV0YCaHkGjPkSpJm0K9n8iCYW4?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a19cf17-9d4a-47f0-970d-08dab20a0551
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 19:42:13.6246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9ZOzQ7AfrxTXddZEbcYzM7KR/hkI6CpUtXBBFsTaPShR1IoHm9W8ZNX/hajzm9Tz0sPayZhj/pBQdf42a5pag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_11,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190110
X-Proofpoint-ORIG-GUID: if2cWKkDDXyUVOhr6OkWjVab0-zckgL6
X-Proofpoint-GUID: if2cWKkDDXyUVOhr6OkWjVab0-zckgL6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having stepped on a local kernel bug where reading sysfs has led to
out-of-bound pointer dereference by vsprintf() which led to GPF panic.
And the reason for GPF is that the OOB pointer was turned to a
non-canonical address such as 0x7665645f63616465.

vsprintf() already has this line of defense
	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
                return "(efault)";
Since a non-canonical pointer can be detected by kern_addr_valid()
on architectures that present VM holes as well as meaningful
implementation of kern_addr_valid() that detects the non-canonical
addresses, this patch adds a check on non-canonical string pointer by
kern_addr_valid() and "(efault)" to alert user that something
is wrong instead of unecessarily panic the server.

On the other hand, if the non-canonical string pointer is dereferenced
else where in the kernel, by virtue of being non-canonical, a crash
is expected to be immediate.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 lib/vsprintf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c414a8d9f1ea..b38c12ef1e45 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -698,6 +698,9 @@ static const char *check_pointer_msg(const void *ptr)
 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
 		return "(efault)";
 
+	if (!kern_addr_valid((unsigned long)ptr))
+		return "(efault)";
+
 	return NULL;
 }
 
-- 
2.18.4

