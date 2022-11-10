Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B7D62466F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKJP7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKJP7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:59:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7D8D2EE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:59:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAFrrSj003418;
        Thu, 10 Nov 2022 15:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=wZFvsrRB7UNO2B1spkvO0RBbeIn9H9kWVvu50sJTlhs=;
 b=nulYF1SUAnJWiz0c83e/ikz/CXMeTL3MgM8JxksfMC9nmE5Wwp520a3xwbahxRtuiSZO
 FSMQtsuINe4fRczqsdWPmX/+mo6ktxL1YTzrmuGXfWOoOGgQdRMGUBWlzlXmQgym2yaB
 9FremrctABd92xkB3fHyijuMy+JkquduLyIY1lxi+BwPOHE2hEQYlWRVcMOMTP+wLeU1
 rWgZD+OUHCT3NUD1vyvE5T47E5pSWNvAwewVME0VkqwXDl8Khg+uxFCpu8qNq6aW5Ef+
 Nt7ApG/Ks41ji6EfZakL3EaY1AxmRul/9ktG8l5oIrTvwJ/VOwolr5DcHuXSXXCVkWW9 /g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ks3ndr46x-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 15:58:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAFVLgj035688;
        Thu, 10 Nov 2022 15:45:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsgp7jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 15:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lks1p6tGiIq/IY9oyPussSnaO5hEdwScGy+XgTZkqCRtGAB0nsOnWe8hVZ73NY6jLgHg3FkBGBQ6YCvtJI7wDiauGIRf5lH4YZOJ8FEqJDkv4sYfswy3ZRkPasFBaGkEo6GywAYmvJ8ugtq8WbjaWF4WdUlkmnDPuwTMtPyYAkYXiAOQ7g1M2Mr8RxR4/dixlSrIWolZxC8PQg1nwX1DG+M7FKpi5yZqcE2UqiFjakpVFttgXI+dSLd9mcf3GGV4Saif1Ut9vRi43cqtHnqJUqWexcULpw2jf1yrS0j2nsewELlSx5k4vguheCkG/cBYmN2zuRhJxGRE6w+PYv6nzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZFvsrRB7UNO2B1spkvO0RBbeIn9H9kWVvu50sJTlhs=;
 b=W2lURc9F9xAuFOOYvnGNYbmCTwKk7Gmrf8MNUvnet3FzdwZXqsiZYzgfZu/LlxE4N+d4DVutc+JDZA74rpB5NKkimGTqiLlAZj9OqZaQV4AW3F1PD1l9J1T6pV2RQxUVYnld6ALrQcGlGydnxYjfO4M2MZIu+MUv6Wq44HVxfFai103LFIMZcd0PG45FB3X9TuB3YIK/BxLYtw66DKD1g6AZDPywDjChB/uePn2vbSLndJFTk+6zunO5/tFg//cp7jq2eFRgu0kiH3NOm0aXC1RJKbmweYZUGefElOl417f3y4BZdYjtMEy/0uXMpiVLsF8FQpTjGRJNfDnplnCWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZFvsrRB7UNO2B1spkvO0RBbeIn9H9kWVvu50sJTlhs=;
 b=ZRbW9/tHcVpAzs03rdFxRScD+KWMZimQPfSGyYVX7/DJbc9WR7siE3TB+PRjDlLZ6Z13eVJyAHiZCNqce2LuRVMbS20emo3Ky/t8q9WR97K6P4h4S59d4Enzgo0ampCN3/ISM6WG6PnyrjrMkyhaLhnoXqtFbXzqvuMuiXq3Owk=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BN0PR10MB5286.namprd10.prod.outlook.com (2603:10b6:408:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 15:45:25 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::72b3:f74a:9e7c:680a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::72b3:f74a:9e7c:680a%4]) with mapi id 15.20.5813.012; Thu, 10 Nov 2022
 15:45:25 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, dave.hansen@linux.intel.com,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
        jailhouse-dev@googlegroups.com, jan.kiszka@siemens.com,
        xen-devel@lists.xenproject.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, andrew.cooper3@citrix.com
Subject: [PATCH v2 1/2] x86: Check return values from early_memremap calls
Date:   Thu, 10 Nov 2022 15:45:20 +0000
Message-Id: <20221110154521.613472-2-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221110154521.613472-1-ross.philipson@oracle.com>
References: <20221110154521.613472-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::24) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|BN0PR10MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d00032-e387-404d-0381-08dac33295b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXcIu01lm0/OTsHR/2fIJkaPiGWQ8F3bMHs2s32R9YNAK0lXMEggqysGY0rIUVf6GSy8W5hFQCXvtCSQN3jKlbNmfZvtP6YWvLgN6VjhesLH2Deqgrpix1XQuzFCCbMM0nSFToPmzZ/5XXNc8Pkju+t6YvOGmFsUdoUVsjCyV7r9u7YKm4PwO/TMt/p6ohZ1Pv040A1YswWR0nG75TATyZ4+0XLE9wGAEwKvdfJ05obPX2PZvZphspPhp6S40mMyEwUaTJt5Bfe5VcZ9XhgLeJ+YYwvtscdWwjOxEhwxFKF7l69mNjDBMJt0IAaEh15miCLeFkXiORNkNwmFkCDl5kHGn/ocVrTDERC+KzBJyjHDoAz50yZXYPNMpzvYr3BoRW+7wS0uIXgQvgtEBfNrNVQVCqI3y8QQdSz+e5VPMo4bgm3/5zdsCAAiMtGJnzU9fUl3Q8fvmjC6uP6Tv3sJPVW8YJF2w9shM4AN1KBY4dO+YV/B4jKnDRmCGzL4MvW4KZmal8vbKdfKiGaGkerWpEt3LPWO60sx9fjYkcFE1+H5EZqVzezMdjUnqNWAwrIwsHcmudnFG83hNiGPqwd0cpQHYDeWiGN1l2b3agVWQG9qsahIl2oRty9IcntXtgfH/ooCrMJLHiW9wmXKwhePD7cBCiX64Pq8aTVm3ttLvsfOwNp6wxsrAJZSIFXNj53QPDODnqfjNnLBRdP8QbQCiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(86362001)(7416002)(44832011)(8936002)(41300700001)(6666004)(6506007)(66946007)(2906002)(4326008)(8676002)(66556008)(1076003)(5660300002)(66476007)(30864003)(83380400001)(6486002)(316002)(478600001)(2616005)(186003)(36756003)(38100700002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J75jdnPVdJxr87+fS6V7+LEzCJZq/KeQDo/uphxDxzClxaxw/AyHzbfyyYmR?=
 =?us-ascii?Q?JrsF1qqYGSQ42x+SMOVepM7zeSonhYcO14HS8JGJsddKdsQ3gWqnr9kMpru4?=
 =?us-ascii?Q?YGy2/aN96QKHgLQHk2qw3Tf1s2SEtur/M510+a+mJQUJkRclnOdtUW60cjpM?=
 =?us-ascii?Q?RBZllUc+uvVJaowg133yDHq+I4WE2Fs2REfC/gh7sFmzEBvbcXvuM/q2G3GZ?=
 =?us-ascii?Q?4DpXXLNVhUU//O1iCYu7yYmK7gM4lKoLOZnSfpinVI4vDKWrvVuzjD1Gccru?=
 =?us-ascii?Q?Cs3ATdjE14K6XJxgS4XuHNPRdi/YGHK2DE3H/bIm0B51ElXfAVts9HnSbyMp?=
 =?us-ascii?Q?ijsNgWttJkW/G69EgPuTOciGUdqgFdGjY7IX7MNpnGvCTrdVcMFxvqho0cbs?=
 =?us-ascii?Q?sEaBsorEoHc83gLWGKGf96qiq1498Ly4oFJL22u/zYxAWALR6oQ3yBYq9ES+?=
 =?us-ascii?Q?fkleLM+zfCZRzrSpiqTODfLgNcfxC1/ISGKmAiHWIdLBPPYwct+bv2gcvFZ7?=
 =?us-ascii?Q?4qIVMAUxXvgc0+7yoLyYZp5xYB6E3iFBOv8DQmL8w5G16ockTR7sR+tSlccO?=
 =?us-ascii?Q?ujLwcXFklqu3U9VHdqJM+o2xVzmgXE+j0y9Cto+iVyqu1ngDjE99XG0tR7TD?=
 =?us-ascii?Q?zJaiQOGNSMAjiXxwP0mFgOHe+yqnUvZT98a2J+78AmjrznfeOl+dnl2z7oqU?=
 =?us-ascii?Q?eVaMs4w+mAISH4akrQSfHV3ullHSGV6ixNpb2p3G50WhASHHuP+HenCCpzUt?=
 =?us-ascii?Q?Z6HPMsFACuVgLYWyRZNr3R4bfS1nvSq1ElXsz/UiBAEc4xEA6jTZLtNY94+n?=
 =?us-ascii?Q?3Hq2ykeCj9MhMzJk7PmNzOHxafi0V2lHIo3WiiKC2g1H4iGi5vCKVgPeSuBe?=
 =?us-ascii?Q?rPPVqA/0LxAGQtwbtK5Rr5dbdTGlMsMXUhkKBMwt6iQp1hmPaR4/68uYJVSK?=
 =?us-ascii?Q?PdSDW3Wdb1Gk/ww+3NBXjCkud33EBHr3rzXsgesh2ifX0H1qG9Ri5wAp7qA+?=
 =?us-ascii?Q?8UMp0gNd/btSPURXzYkNjx4Z/UC3Y8xRW8CReObbPnBzKMHJ46IN86Y43epd?=
 =?us-ascii?Q?JAcU0OKvo1KgCFo6K4TsC6Q4UOX0Enleg6xIIQ3NFXgMMlaKx2FJahBYNiEI?=
 =?us-ascii?Q?RqPmw+aU8kZ1P4HkNL5nbp0Q+8YKtRDMzHpkz1JPLbwrenmOEGhIJErzIMKb?=
 =?us-ascii?Q?JRD/41C2n76s82h2DRBY5juirGRf4yL27P66e7GNNPgkq64B54wQbWNGr46D?=
 =?us-ascii?Q?LJaG5y5vqF7UlA9GGcm3LcvUWoL5JXh4hzDGj1mMvVxEoO0qhZotnJg65hlR?=
 =?us-ascii?Q?8BIRCO5N8ID6i+eGuK65OpdNLjO1oKePVALCzKUMe9BzhqZQzkEAr5ngIjaN?=
 =?us-ascii?Q?R3yJCuRMnwnfLEKGENmsi/paX7YHUNaz3qHmYgz+XAgt+UuCvrKgLSzVAvcr?=
 =?us-ascii?Q?pWZbj5xGQw4vojG02Bgn+LQwPTH76U6yA1t/4j0Hzv6Ff0bqWSDeYiLo5O0J?=
 =?us-ascii?Q?lDiVISAfyaWnt5NScjNiZUGxt1rdYWvvbiShbolk1o7tf0IrO25LsWeoeO9w?=
 =?us-ascii?Q?26Of4wwNSFdrWKpuJ/elEWxwwECnD6dJzIgDds1jvCVWn2Q/io5Bh3QXYAil?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d00032-e387-404d-0381-08dac33295b0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 15:45:25.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1l9V2oP5i6p+CKuRRH8gJ12/pMdBQ4oFpIGVVw/jJ99Vb1mW/vanLfbvb6WfNh334D3D9u5Rvd4BpSBdVdMyoHHrfQpTZzeQ9Jo80chpMpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_10,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211100111
X-Proofpoint-GUID: f6bqTGryMEv8ezWQccwpVqLkZLbSi357
X-Proofpoint-ORIG-GUID: f6bqTGryMEv8ezWQccwpVqLkZLbSi357
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places where early_memremap is called
but the return pointer is not checked for NULL. The call
can result in a NULL being returned so the checks must
be added.

Note that the maintainers for both the Jailhouse and Xen code
approved of using panic() to handle allocation failures.

In addition to checking the return values, a bit of extra
cleanup of pr_* usages was done since the pr_fmt macro was
introduced in the modules touched by this patch.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/devicetree.c | 13 +++++++++++
 arch/x86/kernel/e820.c       | 12 +++++++++--
 arch/x86/kernel/jailhouse.c  |  6 ++++++
 arch/x86/kernel/mpparse.c    | 51 +++++++++++++++++++++++++++++++++-----------
 arch/x86/kernel/setup.c      | 19 ++++++++++++++---
 arch/x86/xen/enlighten_hvm.c |  2 ++
 arch/x86/xen/mmu_pv.c        |  8 +++++++
 arch/x86/xen/setup.c         |  2 ++
 8 files changed, 95 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd51f2..4a5ca9a 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -2,6 +2,9 @@
 /*
  * Architecture specific OF callbacks.
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
@@ -292,10 +295,20 @@ static void __init x86_flattree_get_config(void)
 	map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
 
 	dt = early_memremap(initial_dtb, map_len);
+	if (!dt) {
+		pr_warn("failed to memremap initial dtb\n");
+		return;
+	}
+
 	size = fdt_totalsize(dt);
 	if (map_len < size) {
 		early_memunmap(dt, map_len);
 		dt = early_memremap(initial_dtb, size);
+		if (!dt) {
+			pr_warn("failed to memremap initial dtb\n");
+			return;
+		}
+
 		map_len = size;
 	}
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 9dac246..9cbc724 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -9,6 +9,9 @@
  * quirks and other tweaks, and feeds that into the generic Linux memory
  * allocation code routines via a platform independent interface (memblock, etc.).
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/crash_dump.h>
 #include <linux/memblock.h>
 #include <linux/suspend.h>
@@ -728,6 +731,11 @@ void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
 	struct setup_data *sdata;
 
 	sdata = early_memremap(phys_addr, data_len);
+	if (!sdata) {
+		pr_warn("failed to memremap extended\n");
+		return;
+	}
+
 	entries = sdata->len / sizeof(*extmap);
 	extmap = (struct boot_e820_entry *)(sdata->data);
 
@@ -1007,7 +1015,7 @@ void __init e820__reserve_setup_data(void)
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
 		if (!data) {
-			pr_warn("e820: failed to memremap setup_data entry\n");
+			pr_warn("failed to memremap setup_data entry\n");
 			return;
 		}
 
@@ -1030,7 +1038,7 @@ void __init e820__reserve_setup_data(void)
 			early_memunmap(data, sizeof(*data));
 			data = early_memremap(pa_data, len);
 			if (!data) {
-				pr_warn("e820: failed to memremap indirect setup_data\n");
+				pr_warn("failed to memremap indirect setup_data\n");
 				return;
 			}
 
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 4eb8f2d..80db0c2 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -221,6 +221,9 @@ static void __init jailhouse_init_platform(void)
 
 	while (pa_data) {
 		mapping = early_memremap(pa_data, sizeof(header));
+		if (!mapping)
+			panic("Jailhouse: failed to memremap setup_data header\n");
+
 		memcpy(&header, mapping, sizeof(header));
 		early_memunmap(mapping, sizeof(header));
 
@@ -241,6 +244,9 @@ static void __init jailhouse_init_platform(void)
 	setup_data_len = min_t(unsigned long, sizeof(setup_data),
 			       (unsigned long)header.len);
 	mapping = early_memremap(pa_data, setup_data_len);
+	if (!mapping)
+		panic("Jailhouse: failed to memremap setup_data\n");
+
 	memcpy(&setup_data, mapping, setup_data_len);
 	early_memunmap(mapping, setup_data_len);
 
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index fed721f..4254163 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -8,6 +8,8 @@
  *      (c) 2008 Alexey Starikovskiy <astarikovskiy@suse.de>
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -145,33 +147,33 @@ static int __init smp_check_mpc(struct mpc_table *mpc, char *oem, char *str)
 {
 
 	if (memcmp(mpc->signature, MPC_SIGNATURE, 4)) {
-		pr_err("MPTABLE: bad signature [%c%c%c%c]!\n",
+		pr_err("bad signature [%c%c%c%c]!\n",
 		       mpc->signature[0], mpc->signature[1],
 		       mpc->signature[2], mpc->signature[3]);
 		return 0;
 	}
 	if (mpf_checksum((unsigned char *)mpc, mpc->length)) {
-		pr_err("MPTABLE: checksum error!\n");
+		pr_err("checksum error!\n");
 		return 0;
 	}
 	if (mpc->spec != 0x01 && mpc->spec != 0x04) {
-		pr_err("MPTABLE: bad table version (%d)!!\n", mpc->spec);
+		pr_err("bad table version (%d)!!\n", mpc->spec);
 		return 0;
 	}
 	if (!mpc->lapic) {
-		pr_err("MPTABLE: null local APIC address!\n");
+		pr_err("null local APIC address!\n");
 		return 0;
 	}
 	memcpy(oem, mpc->oem, 8);
 	oem[8] = 0;
-	pr_info("MPTABLE: OEM ID: %s\n", oem);
+	pr_info("OEM ID: %s\n", oem);
 
 	memcpy(str, mpc->productid, 12);
 	str[12] = 0;
 
-	pr_info("MPTABLE: Product ID: %s\n", str);
+	pr_info("Product ID: %s\n", str);
 
-	pr_info("MPTABLE: APIC at: 0x%X\n", mpc->lapic);
+	pr_info("APIC at: 0x%X\n", mpc->lapic);
 
 	return 1;
 }
@@ -242,7 +244,7 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 	}
 
 	if (!num_processors)
-		pr_err("MPTABLE: no processors registered!\n");
+		pr_err("no processors registered!\n");
 	return num_processors;
 }
 
@@ -424,6 +426,9 @@ static unsigned long __init get_mpc_size(unsigned long physptr)
 	unsigned long size;
 
 	mpc = early_memremap(physptr, PAGE_SIZE);
+	if (!mpc)
+		return 0;
+
 	size = mpc->length;
 	early_memunmap(mpc, PAGE_SIZE);
 	apic_printk(APIC_VERBOSE, "  mpc: %lx-%lx\n", physptr, physptr + size);
@@ -437,7 +442,16 @@ static int __init check_physptr(struct mpf_intel *mpf, unsigned int early)
 	unsigned long size;
 
 	size = get_mpc_size(mpf->physptr);
+	if (!size) {
+		pr_err("error getting MP table size\n");
+		return -1;
+	}
+
 	mpc = early_memremap(mpf->physptr, size);
+	if (!mpc) {
+		pr_err("error mapping MP table physptr\n");
+		return -1;
+	}
 
 	/*
 	 * Read the physical hardware table.  Anything here will
@@ -505,7 +519,7 @@ void __init default_get_smp_config(unsigned int early)
 
 	mpf = early_memremap(mpf_base, sizeof(*mpf));
 	if (!mpf) {
-		pr_err("MPTABLE: error mapping MP table\n");
+		pr_err("error mapping MP table\n");
 		return;
 	}
 
@@ -552,6 +566,7 @@ void __init default_get_smp_config(unsigned int early)
 
 static void __init smp_reserve_memory(struct mpf_intel *mpf)
 {
+	/* If get_mpc_size() is 0, memblock_reserve() will just do nothing */
 	memblock_reserve(mpf->physptr, get_mpc_size(mpf->physptr));
 }
 
@@ -567,6 +582,11 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
 
 	while (length > 0) {
 		bp = early_memremap(base, length);
+		if (!bp) {
+			pr_err("error mapping SMP config\n");
+			return 0;
+		}
+
 		mpf = (struct mpf_intel *)bp;
 		if ((*bp == SMP_MAGIC_IDENT) &&
 		    (mpf->length == 1) &&
@@ -850,7 +870,7 @@ static int __init update_mp_table(void)
 
 	mpf = early_memremap(mpf_base, sizeof(*mpf));
 	if (!mpf) {
-		pr_err("MPTABLE: mpf early_memremap() failed\n");
+		pr_err("mpf early_memremap() failed\n");
 		return 0;
 	}
 
@@ -864,9 +884,14 @@ static int __init update_mp_table(void)
 		goto do_unmap_mpf;
 
 	size = get_mpc_size(mpf->physptr);
+	if (!size) {
+		pr_err("error getting MP table size\n");
+		goto do_unmap_mpf;
+	}
+
 	mpc = early_memremap(mpf->physptr, size);
 	if (!mpc) {
-		pr_err("MPTABLE: mpc early_memremap() failed\n");
+		pr_err("mpc early_memremap() failed\n");
 		goto do_unmap_mpf;
 	}
 
@@ -897,7 +922,7 @@ static int __init update_mp_table(void)
 	} else {
 		mpc_new = early_memremap(mpc_new_phys, mpc_new_length);
 		if (!mpc_new) {
-			pr_err("MPTABLE: new mpc early_memremap() failed\n");
+			pr_err("new mpc early_memremap() failed\n");
 			goto do_unmap_mpc;
 		}
 		mpf->physptr = mpc_new_phys;
@@ -911,7 +936,7 @@ static int __init update_mp_table(void)
 			/* steal 16 bytes from [0, 1k) */
 			mpf_new = early_memremap(0x400 - 16, sizeof(*mpf_new));
 			if (!mpf_new) {
-				pr_err("MPTABLE: new mpf early_memremap() failed\n");
+				pr_err("new mpf early_memremap() failed\n");
 				goto do_unmap_mpc;
 			}
 			pr_info("mpf new: %x\n", 0x400 - 16);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 216fee7..621fc3e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -5,6 +5,9 @@
  * This file contains the setup_arch() code, which handles the architecture-dependent
  * parts of early kernel initialization.
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/acpi.h>
 #include <linux/console.h>
 #include <linux/crash_dump.h>
@@ -344,7 +347,7 @@ static void __init add_early_ima_buffer(u64 phys_addr)
 
 	data = early_memremap(phys_addr + sizeof(struct setup_data), sizeof(*data));
 	if (!data) {
-		pr_warn("setup: failed to memremap ima_setup_data entry\n");
+		pr_warn("failed to memremap ima_setup_data entry\n");
 		return;
 	}
 
@@ -401,6 +404,11 @@ static void __init parse_setup_data(void)
 		u32 data_len, data_type;
 
 		data = early_memremap(pa_data, sizeof(*data));
+		if (!data) {
+			pr_warn("failed to memremap in parse_setup_data\n");
+			return;
+		}
+
 		data_len = data->len + sizeof(struct setup_data);
 		data_type = data->type;
 		pa_next = data->next;
@@ -421,6 +429,11 @@ static void __init parse_setup_data(void)
 			break;
 		case SETUP_RNG_SEED:
 			data = early_memremap(pa_data, data_len);
+			if (!data) {
+				pr_warn("failed to memremap RNG seed data\n");
+				return;
+			}
+
 			add_bootloader_randomness(data->data, data->len);
 			/* Zero seed for forward secrecy. */
 			memzero_explicit(data->data, data->len);
@@ -446,7 +459,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
 		if (!data) {
-			pr_warn("setup: failed to memremap setup_data entry\n");
+			pr_warn("failed to memremap setup_data entry\n");
 			return;
 		}
 
@@ -460,7 +473,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 			early_memunmap(data, sizeof(*data));
 			data = early_memremap(pa_data, len);
 			if (!data) {
-				pr_warn("setup: failed to memremap indirect setup_data\n");
+				pr_warn("failed to memremap indirect setup_data\n");
 				return;
 			}
 
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index c1cd28e..2135bfe 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -70,6 +70,8 @@ static void __init reserve_shared_info(void)
 
 	memblock_reserve(pa, PAGE_SIZE);
 	HYPERVISOR_shared_info = early_memremap(pa, PAGE_SIZE);
+	if (!HYPERVISOR_shared_info)
+		panic("xen: failed to memmap hypervisor shared page: 0x%llx\n", pa);
 }
 
 static void __init xen_hvm_init_mem_mapping(void)
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index ee29fb5..b164d8f 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1824,6 +1824,8 @@ static unsigned long __init xen_read_phys_ulong(phys_addr_t addr)
 	unsigned long val;
 
 	vaddr = early_memremap_ro(addr, sizeof(val));
+	if (!vaddr)
+		panic("xen: failed to memmap physical address: 0x%llx\n", addr);
 	val = *vaddr;
 	early_memunmap(vaddr, sizeof(val));
 	return val;
@@ -1919,14 +1921,20 @@ void __init xen_relocate_p2m(void)
 	new_p2m = (unsigned long *)(2 * PGDIR_SIZE);
 	for (idx_pud = 0; idx_pud < n_pud; idx_pud++) {
 		pud = early_memremap(pud_phys, PAGE_SIZE);
+		if (!pud)
+			panic("xen: failed to memmap PUD physical address: 0x%llx\n", pud_phys);
 		clear_page(pud);
 		for (idx_pmd = 0; idx_pmd < min(n_pmd, PTRS_PER_PUD);
 				idx_pmd++) {
 			pmd = early_memremap(pmd_phys, PAGE_SIZE);
+			if (!pmd)
+				panic("xen: failed to memmap PMD physical address: 0x%llx\n", pmd_phys);
 			clear_page(pmd);
 			for (idx_pt = 0; idx_pt < min(n_pt, PTRS_PER_PMD);
 					idx_pt++) {
 				pt = early_memremap(pt_phys, PAGE_SIZE);
+				if (!pt)
+					panic("xen: failed to memmap PT physical address: 0x%llx\n", pt_phys);
 				clear_page(pt);
 				for (idx_pte = 0;
 				     idx_pte < min(n_pte, PTRS_PER_PTE);
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 4f43095..2f3cf6c 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -685,6 +685,8 @@ static void __init xen_phys_memcpy(phys_addr_t dest, phys_addr_t src,
 		len = min(dest_len, src_len);
 		to = early_memremap(dest - dest_off, dest_len + dest_off);
 		from = early_memremap(src - src_off, src_len + src_off);
+		if (!to || !from)
+			panic("xen: failed to memmap for physical address memcpy\n");
 		memcpy(to, from, len);
 		early_memunmap(to, dest_len + dest_off);
 		early_memunmap(from, src_len + src_off);
-- 
1.8.3.1

