Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0C75B413C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiIIVGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiIIVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:05:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DE1102D64
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:05:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289KYvwH002820;
        Fri, 9 Sep 2022 21:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=sITWZr9vk46+wmOamn5lc0oiEdvj6F+xBRDcuSObS8k=;
 b=GreD7ZceALpHboIHC5xJmgfqV0DYUNr9aHs4w+Q5ltHE/8jnFT1eQtw33MYnC1CdVz52
 LNOcoLT41r5EBEav7ZidgZV8faiinm6nalD0D6EZ8fIR2uVM4Rzd+5n7d7FEPKvy2DZS
 kMXMmKJZSfZEo6nVNGw/w5NVe7ehB8XX3QfYe9+nZgHLHrWI497jpAsv5fbvnhBbnKNK
 f7lzbXIoTairg3pySAQ6CfC7lg9QyCF/HF7muOCl3dU5R+IoXPhB4rTlMzDV/GAVug0S
 xOHp9ndfnzcyTkviNqPrTp8B59DXqlQSYtOzFOAqdWKPDnkxPs98XKyBSQ+xKir7tnBy SA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2rgp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289J8fuA029278;
        Fri, 9 Sep 2022 21:05:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcfa2e7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fegZH7QufR/cYZ/Pt3JPbOFT/c/s5kPDI87XVy9ezlhlja8MiywW2sfaw7/+AZtRtT6TtmRKniKZeUjt4cIID9X3tVDlxcBQwHBcgwymPak1UKBZH8QJZxsT/45CGW8fUlyp3v9uKQnZmOt/6860//c4is3kq6Litfu5bAAzpnYgMiS//5v8F9mmFYC72fVPkEHxkkqrtM3G8PzzCngJ+/n3h7ejXERpY6bWLFj6WDdHd5H5AhWgYG4qLgaYAQUTnJ0sqmCAgBGgXviiTQDNOE40YDRawIPJtWQb7FgT507TbHiQ29Acaey39MTGUzCM+itH4iQjDvP//vzVvdbirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sITWZr9vk46+wmOamn5lc0oiEdvj6F+xBRDcuSObS8k=;
 b=IRRO8oSH5cWt0HUaanmmiq3DE7Z+mfhNBWxL/NIhPwh2CtLCLiTquxlEm3IKL931fSilFyUVYo1Cdgsn45eUY7LBw3ZJeVxqLWDpBHLXzXjM8Ud90VV+xV9TgIFjiS/A69RFBiy1g+PkD8MJymTb6fo7nV6CapwsyhCxmH1CQ0iL6lCmojiirfjJUQPLflrUGNTPLIi1oZvkTPSEy8jXIwakTuoRML2wgfl+qfaNNF/cCPjERoZlH8nPMPPiDxqbiAOZiA/z7FbkLtVaBD6J2vrV5IBOWTx8CcxGuHV1dCT8JYAEBPhX9VGr6+ucmy86NvrZBkQdJ0KYdEXsNZUjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sITWZr9vk46+wmOamn5lc0oiEdvj6F+xBRDcuSObS8k=;
 b=F/IQROeEudwal/V4d7YeMC6DruO1+AgpxHUN7nvt+lvUfvipC/KFSDWL3H2GuZOG1kL8Gd1qf1PhjBVQ2EwtlQxv+P52RMGU+Nq9qGQc4PtI/8k/4LIGbsHY2464dl3pHfWFP1q5b6f7GjPs2cmDjnePvcybMZofuU16o6rngBs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB6777.namprd10.prod.outlook.com (2603:10b6:930:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 21:05:24 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 21:05:24 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v12 4/7] kexec: exclude elfcorehdr from the segment digest
Date:   Fri,  9 Sep 2022 17:05:06 -0400
Message-Id: <20220909210509.6286-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220909210509.6286-1-eric.devolder@oracle.com>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:5:120::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4a8569-c7d9-4982-64c9-08da92a7039f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90baWqfqFKkxNoVq9YupdCIGpkEysHYEvXxa0aEAlV3FMNsZgM46DCxaI9aV73/FLHn6FW1wkSr9LhFtLAX81GcaGt2LilvOtdyPscn9lCfkucE5eDW9boqqJ80CD1EwYUaHlWn4pkIVXObJRAcRZt6CDWJmsl5hagJ1vpM6L++KLQdroUDGUk7L2pRs5y73Nn9NcNYkIECqkImbN6EL9H1loWY4qh+m2gGoqZkSyDPw+DvP7Rt1pQIPRpJSX7SqSMq0F+0aU8uKikJwlYcyQGUB6Fz76o7bFFCBMEM9zbeAJqxDjIk4zKa1oujGlKdsHlQfI2UcKLjcTquGuYtjrlMs9h3vQKDUzYF5MxO2sA9yYp/7Xf3cINT8OHMP39lN4spIxkNIHM/VfE1xyqChL/M+7abpjfNxuqv8bLkoCXxozFrGLxZDqgo+HbD2kSHGqIqCCPnJnzQRo59YJS73BATpJLUTcliCWuC6lcqGiCA4+qUklIiaiKe7qplgRj75D+fJZYe8O/97X4fAkAEGlURnwLGWW0QdlxD44SzzWhh9JZdpE3pjMCcFF2Vd0gi3lmz72UvF20eWYUlcpB3tqB1vpvOiMv9aTV+lg2s/TCTR85mzDuyzONjVKWxFtraHpdq2B5yL7ROnABOcOCibqA+92GPv/COB6h08mkxkPWs6gfBsqBa0gDARC1ke9wbhmar7E31Pu++N1cXHnk+5rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(39860400002)(346002)(26005)(86362001)(6506007)(41300700001)(6512007)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(38100700002)(8676002)(66946007)(66476007)(4326008)(186003)(66556008)(2906002)(8936002)(5660300002)(36756003)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zo7qwL6T8KuT5+fHSqh0n4XykLsXIDROiybpymAFgojRRfpMwIT/NznynG5H?=
 =?us-ascii?Q?hP+jZg+Al7qJipUOyG+SLF76SlXEDEa5mGn9H2TT72b6bOAT6RvW1/AAepuO?=
 =?us-ascii?Q?9oLGX3X7BfkhdHSoHtapBfaE0NZ9qMqWSoVy23VAjPedonAPopdfTXawGQfV?=
 =?us-ascii?Q?SjWUbfe0tQFpTN7/xOzYBONcgXhi8ccvY71E4vWGMQyEAPBuoa6/sF44uCfZ?=
 =?us-ascii?Q?MTSru47OD0FN3op5tdoOcX6/443CIwQCXduknspt5x+KUB64IJBzNQ7Xa4Z/?=
 =?us-ascii?Q?d+xNFgxmE3WBeiqyVw8esVEhhFank3A/CgnVyhHteSEw2fpmkxOeNM8FIVeB?=
 =?us-ascii?Q?hAeDSPY7mYoN+TB263KL5/ca4nMsgdxTHAXGDamK4+VCkkCxGoavgulIGcxX?=
 =?us-ascii?Q?2Og3L8XIcL92uaKyRRX9lqll0EVBWA42hde9v/9MOWS+m7XxNaeISiFIgp6E?=
 =?us-ascii?Q?n+wnmlFWT7AQYkA9/7ceIYrbyi88Qqy7cSLgWXfzaaUGqYQzpp9Y5UR1TzOc?=
 =?us-ascii?Q?OKIX/3IeK5neO/N01vhYTpx6ZjYxXRRsWAUgw/4Y1MNbgD5++JWS0Bo7iSJ9?=
 =?us-ascii?Q?xv7t75wqOdTjFCMASUeBaWTL8i4TP3a5q6wLieSWBNPPw7kgzSXgWXwWC6cR?=
 =?us-ascii?Q?UQzWlyTyKd3i5BZYwUMMx3RUs/QZxW7pDBtooVcCxtavpMSPl6oMqXrG/OdD?=
 =?us-ascii?Q?ZzsWDhhsC+NsPaqDQznfE+hwSjsXPDw3Xy4I/Q7UMORE7mQ5a+D0nRO+cqPU?=
 =?us-ascii?Q?IuONw4wxA6TuOrP6v7DToPjYK4B+lkfm04DDIqnBFj3LYshMwYw7ErNPyBiL?=
 =?us-ascii?Q?Gcvm2B73Ez9PEDQX4dZZx4o3tFDRHX/3jdW0TpkhlyPqu0IRxTdw8M9oCvfa?=
 =?us-ascii?Q?8KoF/ijCHEZzjFIvSZtPYDj8UvoZ+loR91aj4zVJgHEzeyI1zjmq7a4rqU0S?=
 =?us-ascii?Q?1YMLMalwRyGsW90Dc2R0gcSQV7Pk/m9I1E7Ros4pG3bwypZJ5q26mV7L73Bd?=
 =?us-ascii?Q?7UfKj4vgojt1LirNkZ8t3qcebwUABtjIDMz9CwyV79SBRFE4RWF7SchjlDny?=
 =?us-ascii?Q?DkX1V8BdUAYL7h7RYGoKqlRw2XfO1I6Y29jinNFa/Cfe4Nua9uIukh3qZ1R0?=
 =?us-ascii?Q?OCojywe5vhqBq6dhhPXMQcuIegMllI6yspgzIXSUNdY+lc0Y9hOZnlkVIM4/?=
 =?us-ascii?Q?LebvVRXua8y+TjxWgr7qSgKWyVh/hhhBwfIY0Ftnyxb6L8DFrZDIomPebFX4?=
 =?us-ascii?Q?RitbDy6k7sFroUzyJJ4gr6LG1+Hdb1nM85vc+MRAYIWkKfyYyzgqAzpguWdZ?=
 =?us-ascii?Q?EZYfFmWUa334d0jS5SMOEL/nBkb1BgwgJQVwbRjWdV9vB9wBxrWb0i5Leqph?=
 =?us-ascii?Q?3SQ9tSzHH4vCMEel3fCFpAjGIUurHCPKHNaGZOD2p8yrSxwh0wL72gb+Wh8W?=
 =?us-ascii?Q?kf1oyJc0F+5nAr/R/FEyoQCxndYJHBLz76EhVFpzM8P3YgGUtl3F66NaCFbX?=
 =?us-ascii?Q?NCZQWu4lYuDKsFtO21Wnmdwe/5KdoZL16f+38TJLGDVfZO+2mt9+EIB2snOr?=
 =?us-ascii?Q?LFziWOHIF0CRd2INQG7z+YBAvuXVXD8K/rOvu9GsBZWf2WtSvu0XIEnJH1O+?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4a8569-c7d9-4982-64c9-08da92a7039f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 21:05:24.6337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNaDtnBXlbvQLNR29ZxknyEqRt0KNleQhImUeckSAx8n2e62EPjN/ESIzVAY5ZI/vwNBJDLWXU34EtShanadsrKCmnYvBXH1ykB2JchkYRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090074
X-Proofpoint-GUID: 7xng_QJljW-OfrjSujmxQGtWqvI5bfrn
X-Proofpoint-ORIG-GUID: 7xng_QJljW-OfrjSujmxQGtWqvI5bfrn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

Since hotplug events cause changes to the elfcorehdr, purgatory
integrity checking fails (at crash time, and no kdump created).
As a result, this change explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits changes to the elfcorehdr in response to hotplug events,
without having to also reload purgatory due to the change to the
digest.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8017eeb43036..d0c2661b3509 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -723,6 +723,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

