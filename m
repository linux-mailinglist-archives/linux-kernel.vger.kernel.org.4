Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B3962468F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiKJQGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiKJQGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:06:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD1E3C6F4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:06:17 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAFtNeT004497;
        Thu, 10 Nov 2022 16:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=FZ/LmP2GHXCQVdjees4T+utybli0PrM7N5WDJIbg/ec=;
 b=SBC/BqplCMsO3McO4soPq+t3WgdqC8Jg0T2htbJeZ0CK0YL+x6/FcCGNyt+jg0NxASW1
 6Ixvzyx0204bQ6rkf1eHOUQXVzfdf4lJLH20bbp9zd7QhMtsCpJjSSwPNGmj30/BnYii
 4dEICE03/Cn8TEKrkT1nCx7LNBwz6lwM194E4VaMVK/v1E662UHsikkZsKXQdJpWZKPt
 HOwrzuRfSyDqoTA4P2Mh/1cClx4di4r+/SGZrOoWmclytXWf9PyEljCWM/m4LaaDy2MC
 oiZYzle4uOdd9bioUNBKvbfDncgrzcjUgML4X4XQXsF59xjdv4V/nmb3zPyiAipAFYId 7w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks3w583na-50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 16:00:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAFVLgk035688;
        Thu, 10 Nov 2022 15:45:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsgp7jt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 15:45:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksdvWPaRLnvHizAVfGikYehb+YJW8RwuQ7SeeH96Pbor12ms2BhKg1ZgBLoaLE5GI0tt888LZtyhqAfLiRwZHsHENDXNkDT05dDtqdDXv294JjTplDNLAPMhtogSkgWcwaLjX6iKSm7+wroDEQKBRVdbZGYD0GWGy0c1jBxD0zJhnkX0MTHd14kYXSyRKYJ2GSGoKstB9/bVG0ArDqd9EdM++WK259p63Y0BPt5hQBE9e+UeNHt0qSfsXInpLNb/xnqn6skV1QjHcfsKPbC7PMdhOPAwEypMKaKud+Z4wOuzwAOLoX6R91/H/aTPm+e1qf2PBsT+F0i42+VXF1yjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZ/LmP2GHXCQVdjees4T+utybli0PrM7N5WDJIbg/ec=;
 b=VpzN6faisB/jWsXwXoQ0tK+C3guublIBIp6nv10tSpScrdpbMbi8Jk8S14nZuuaHkHmREpVxnj2+otp1CTPT3yeRUDayFpARmzX0Pc6gGBdoxmYN0SX53tKDbwgpBcynZDxtOU6nGNVV15nZUYivhiBIKo/RYBGBiHHA6TuKJq+3MYRR1g4R3/VLRyMT9oKeiAPWN7N8Qfb8T2J6HkwG5HGmqQPjNJQxkPFr9Qyid0Q7byJwmBOC6+sUtKJLM7f2T+YqSiacIvBE66LbtP8xZSxC5a/sTfWBQh51bcA+hcEtRa4RwurDxj8GlNocQWTY/hEIztv6MTfrppUTH9FALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ/LmP2GHXCQVdjees4T+utybli0PrM7N5WDJIbg/ec=;
 b=cOkQ2RmH2lnvge0RY24jWI4J5kVyf8DUgqfvPBQJW9mIpk/N2yJ6jpPXEvUGOf7uESMN7t6JaTllF60NnaWYzyBtb/JqkH1VqzKVNMQXF0IE27gEZLOathUayWbb/ZTB3mz0qGK+inRxRGI8QW7FxukoNBMg+Szu90dsxbIAlNY=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BN0PR10MB5286.namprd10.prod.outlook.com (2603:10b6:408:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 15:45:27 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::72b3:f74a:9e7c:680a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::72b3:f74a:9e7c:680a%4]) with mapi id 15.20.5813.012; Thu, 10 Nov 2022
 15:45:27 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
        jailhouse-dev@googlegroups.com, jan.kiszka@siemens.com,
        xen-devel@lists.xenproject.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, andrew.cooper3@citrix.com
Subject: [PATCH v2 2/2] x86: Check return values from early_ioremap calls
Date:   Thu, 10 Nov 2022 15:45:21 +0000
Message-Id: <20221110154521.613472-3-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221110154521.613472-1-ross.philipson@oracle.com>
References: <20221110154521.613472-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0044.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::9) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|BN0PR10MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebc7c4a-2dcf-43ac-dcd7-08dac33296d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMu/rr0Pal3xuw6SVZSRZFzQ7IVSHKqErBhuZnuIFMwjnvn7Axnw4NvVnXn6a7OoMC54wUQQ+d0XVzOaWpA4wlk7Dw05YsH5KbClSUOcb6gU+8ikneSUuigzSHl5eIiVD9lzn5IoFCDCNe5mRJWMmJe8tA9hMyI0WLQr3yZDSalL6roP8Sw0inhTqrXC5G7jr/OPTkaBOKGF9AmvCdKlqf9E954ExVIAR8o2r7ZYCL+A+et/NE1kHWFNWwNs4kS3IrSVk315FmMfu6I8BHWTTCEIl4wg0ofm+DUHF6SfhhewGFBraOWiP/mDBeamaqklMJIxG4pAPnQ2ddgRoLtYuOg5oo8bKIPg926KdU67mwDjgxtaKuv31H6DRd4pcDgDxemW0wAgSUx197d5X4DxgxLlf6syCVxfCSmA6JCzr/jANhU+IJY853Gc0HiPixLhP9q2Rsv8ATerCZItvkPRo7PUVq+t8VWzhPAAh/wsBArMHWIiFw39yWtZJjjIR09mA+AhEztFVLamex5iJc0t27nM25nxs0qydaeHISiLcZ7DTJ3lYhpz30K818UrjnQkaOR1/vUCksogkVOHGidwj3y+zZxFqj1qxvVcx3dtOpJ3cj+X1AB3NAq8TvS1zjk/0CIglhf0xvBWN8796vuTzch56sYlNUeOHFQDXBouEo46iWWkMIOTseSyAdYE+gvCF+wsLuEYvSSopyUsfsbIpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(86362001)(7416002)(44832011)(8936002)(41300700001)(6666004)(6506007)(66946007)(2906002)(4326008)(8676002)(66556008)(1076003)(5660300002)(66476007)(83380400001)(6486002)(316002)(478600001)(2616005)(186003)(36756003)(38100700002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PdEuHQoYy2GgDaKQTjt1WE0sclKzu2/U5dXhgifaZr8m+jHw6MjUWOoLrD4p?=
 =?us-ascii?Q?HtqOQ8oBBue/PPEL2Th289ZZH6qPgkZdaUsx/UKf4aeVIjMxDwrT/KhyO6YF?=
 =?us-ascii?Q?5RuTPoiF3u4HHalpXCBOtn6+KzU5Cy23ToTzoGTh8o9yEdcfu8kmG6Rg87lE?=
 =?us-ascii?Q?5mFc2P9tFIVfTxAAqMaXClFCePyLC3dJt+jFSr76e5B92GzCdvow4yVYqZBn?=
 =?us-ascii?Q?vyMjk4M+HcxtcKH4qpMB0hxTc0CQ3tBWUK0/Sy8EXhl66YdkZcSZ69VQO5mp?=
 =?us-ascii?Q?75KSG6R3Y2C9/tFg51B5EejVSp1lABWnAAQ46QJ9je5Q0zkoPkLKAAdGTG8F?=
 =?us-ascii?Q?Yr/Q7ff/33tLwHUrcN4BD9FqskkQpfV6XuxnyYqWo5Q6PPUglHgXwciJLRrp?=
 =?us-ascii?Q?r6GhOudd+9+M6opBiZcD4yLiycTQ6htEs2XFC/GrfYPf5LNJW0vLllmg5vDx?=
 =?us-ascii?Q?FvpHPTWnYX9wM91xq3lxxibbU8g9rvpYIRI1bim6qXBmukAtiHWzL3KW13xg?=
 =?us-ascii?Q?Zb/Lsi55ECPmHeAK8gaY13xavtoS1rjf1bDTD0dFVqYNNTO6i9Gf7W47GRZd?=
 =?us-ascii?Q?tCCsc3/eAQK/fCdrEud2WEpNW04LUX32n4fDR7M44lEPUW/DWYNLfGrIy74Q?=
 =?us-ascii?Q?fQORNg4rUPN/EQOYRHMNiDWY1aFL/4r5VxwmQhRvpvE6KpW/0vgQ8/ONQdrj?=
 =?us-ascii?Q?5TidIHPHbOkvQZIKHTjPQ384KdLHw9nPdcE6L7vz5pcA9ZiBqZTlPJJVPXJl?=
 =?us-ascii?Q?xW5nE841IbrsfLUPb/yavi8dDHT0CgnQ2aT23V8rBWcD7RTq4RhANzY6Oy0U?=
 =?us-ascii?Q?LASMfLN2tsyCy6XKM+lKNXT4wFDQonszQk9KagRgDWgRdi1q2v6vqJ6hOmIc?=
 =?us-ascii?Q?K0NDrkrt6f77zzVMJwmWbkRsPjcFH1a9uAI5b7b+1Mdv8mKBVegjDf20Prm9?=
 =?us-ascii?Q?62jdhhx4ZUw0oXMv4o48mNuxGPgf9knx7k5UmSsYwimlTKQAmeGKAgmkO+9o?=
 =?us-ascii?Q?3MLEE8Ff5DpVAA1+nfUi8cGuWRJjjEi2EIyZvl2Q9pbQEw1GYzKnZmQTNO71?=
 =?us-ascii?Q?uvTMPHKnDZ9hKZA7rjYsJt/+6L6lGcnVEA9vDzxmFw9xo0Dy8V/Ug0+gt5nV?=
 =?us-ascii?Q?BnoOYGYvqx7bKcc9gtEcu3+EknegWtI7cCBzd7qpJgZpIXZvMy9c5PQqcXTU?=
 =?us-ascii?Q?msgkthPumGDt2aerrg6Dp0GDj3ZMAsOFQ0lAV7ReTzzfSQfqVyfYpmPbaezK?=
 =?us-ascii?Q?uJABOSKwvJ5woRJPSa+PSm+HCZp9qnPG+/61njDGfSlgn3JUHoKaj0g+9XJ4?=
 =?us-ascii?Q?sYuucnP5ALmF7fz1C5yg1unjzS6UYzl3Ry2SegBLDaZuc6rI3SjqSIkF27VI?=
 =?us-ascii?Q?ic/2Ns68jrcj+i4+aQirHA/wrm/WH2CaiVJHZE9Ax+4Sqd762c9SaJN9Rv6z?=
 =?us-ascii?Q?BnSRfPazNGi82HUovfuPrH+Rjd3wztAw9k5B547HXk9OdrbBS9wljLCxqSrP?=
 =?us-ascii?Q?dFMcA/4WkyDXao5LiXUpQdtLHpvTg3CKdXbvpLyX+M70C5ryHn51zt733m8e?=
 =?us-ascii?Q?pRBi62D3ElSFVPRuBw7lhMiL10Za/77cFDZAQGjPzZmKMaUBRkjRBZP7jjDk?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebc7c4a-2dcf-43ac-dcd7-08dac33296d2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 15:45:27.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xh82Ny6Rc3B4MKUkb7ldQ/T1LLyRH1jfLAr5AfOKZ9HUq87Y92c9VD6oEuIJBFHtYJ3xGLYMRbJMykVZ6mnqsdy4fdEvtEOwIcdCVch1DeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_10,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100111
X-Proofpoint-GUID: MhanIWHAGLZ17MoaZ1IsEFFLUsnZMsVY
X-Proofpoint-ORIG-GUID: MhanIWHAGLZ17MoaZ1IsEFFLUsnZMsVY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places where early_ioremap is called
but the return pointer is not checked for NULL. The call
can result in a NULL being returned so the checks must
be added.

On allocation failures, panic() was used since this seemed
to be the action taken on other failures in the modules
touched by this patch.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 2 ++
 arch/x86/kernel/early_printk.c     | 2 ++
 arch/x86/kernel/vsmp_64.c          | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 4828552..4ffdc27 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -75,6 +75,8 @@ static unsigned long __init uv_early_read_mmr(unsigned long addr)
 	unsigned long val, *mmr;
 
 	mmr = early_ioremap(UV_LOCAL_MMR_BASE | addr, sizeof(*mmr));
+	if (!mmr)
+		panic("UV: error: failed to ioremap MMR\n");
 	val = *mmr;
 	early_iounmap(mmr, sizeof(*mmr));
 
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 44f9370..1fe590d 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -290,6 +290,8 @@ static __init void early_pci_serial_init(char *s)
 		/* WARNING! assuming the address is always in the first 4G */
 		early_serial_base =
 			(unsigned long)early_ioremap(bar0 & PCI_BASE_ADDRESS_MEM_MASK, 0x10);
+		if (!early_serial_base)
+			panic("early_serial: failed to ioremap MMIO BAR\n");
 		write_pci_config(bus, slot, func, PCI_COMMAND,
 				 cmdreg|PCI_COMMAND_MEMORY);
 	}
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 796cfaa..39769f4 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -32,6 +32,9 @@ static void __init set_vsmp_ctl(void)
 	/* set vSMP magic bits to indicate vSMP capable kernel */
 	cfg = read_pci_config(0, 0x1f, 0, PCI_BASE_ADDRESS_0);
 	address = early_ioremap(cfg, 8);
+	if (WARN_ON(!address))
+		return;
+
 	cap = readl(address);
 	ctl = readl(address + 4);
 	printk(KERN_INFO "vSMP CTL: capabilities:0x%08x  control:0x%08x\n",
-- 
1.8.3.1

