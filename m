Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C91613E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJaThL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJaTgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:36:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A413E1F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:36:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VGx8pO026899;
        Mon, 31 Oct 2022 19:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=wlaWK8/IuhSMqnWWytUFpDjlT4v6bStGWHIlG7FPo7U=;
 b=3F8TrM66wGCBhWxIiqnYwOb1xcwT0moDus40i3nJr4SGisTFmU8uGQffAww//30QCmeG
 DyhRtfCBdvxu/z+vhRbm/RPFDUTEvracHSsJBmOVV4XO5FpzcT9w7XNrf60nGmgHxsZW
 ZjZZf2fJWbqg5l5zXcu9xhGB6sQS2SiEZc+Lrlhkkh03OlDaiSCBp2NcLFShDUF06Ep4
 iptqzqfWpvjAmh+rMIaPQF+FOLSxE6NHeNjO+DKJSnYz7yklFNPS2V0BIfuq9Dx9TXna
 Dgv8VOU6gIpV7iIUhL+QHR1FgNFx24WjUgpRPPwbHcAOaisLt47K8z/fonnuRtR9JoMG uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts14sxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJLgOH019196;
        Mon, 31 Oct 2022 19:36:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9phh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PohFv556A5IVWUEfRqov6SKNZh2t2IDnNzwyJg1AHvcSs2hM0MisQv1pUpTEd5oHl+ZRS7go+EFHlOpSxvTeAVYAs0ObWYdprqj5nuoPWq2TYfaezIrWJP8szS/wDrTJtSFq7rdjRONAOEVvZSEc17O82KMhgugccgDv4i8STUhuiNbNLyqzno73jGPkhsO91lQenbGNsqVfhM3eV1SKrLaP+i5NRSyq05Vq29NVwm39FfhBupTPScIyk11ZTzqLOZsGOuj8YRqk4MyraKxT7Yrx5ERN7eD+OKAACWpbyYUZp5GQgtuuTO6knoaoEYox6AWocDWHHX7HOa7TB0GS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlaWK8/IuhSMqnWWytUFpDjlT4v6bStGWHIlG7FPo7U=;
 b=ocQrQSNW0Sk2AZyEJy7DaPVvC5iZ2iKoqWmQpBAIVBp+uBqyuZdPVhXIGDu+LUuivfFKCg1xHG2nOkD1IUpDCBL+VXAAbe24ahZGzSxyE7TaVXQjoz+B2vAqg5S5pTw7inZipb3dk4pVhZX6gtCBuej/xH40Tb0YG+uHPuGJZMOhzOLZqPNDFs+KV6N4pf7eft4lPh0FKWDgCNIFXVY6zlHrfFrPNZj8xEr4TmWCUXn+10ReGBAuxEFODiraERQZn1dp1Y++Rn/zJ1RaXZJlLNNUqiTYmxsc5ZZ8Bfn9Dem64j3cxLSQJZFDjCx9R+BqhS0Maw8qmNEpMfwC5c7iqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlaWK8/IuhSMqnWWytUFpDjlT4v6bStGWHIlG7FPo7U=;
 b=fEOm6aYQHmPnr4D89CoYwb2uuSFLf3Q7LRLifburMZdwcX7KtKzsIMNApTEk49wYE1XDXpARR4fxePpKbuD2cJYFooWju+mH8oDNWcxTfU+qCk5OVfDDDREGpdGVm59JHCksZq5xPTW/axhHGiY4lyDhbTlwm7f9PBAd/mhzCcA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 19:36:33 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 19:36:32 +0000
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
Subject: [PATCH v13 7/7] x86/crash: add x86 crash hotplug support
Date:   Mon, 31 Oct 2022 15:36:04 -0400
Message-Id: <20221031193604.28779-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221031193604.28779-1-eric.devolder@oracle.com>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0108.namprd12.prod.outlook.com
 (2603:10b6:802:21::43) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 3388f6bf-4288-471e-43c3-08dabb7736ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U913ytYhkRhBaQYilV3ZVviUNgi7h/ej74g9xMBxg7PGLTokI7jPo8RnjNUmtO0FO1THbTBnbFgDJ4XzefyNW210pPpqtpDQoQhGwmcQEmfv8Pqu7SmpJLzODr58Qhqyp1ZtVl7GmipF0PSctFrU7a5ns0uxnXb7s/Nrf3DjL7665wFjXrwbpjxQlGbifJrsa/X6YJT2CrghLixELi4bfhJ+zbpr41ghz87nbvLbaAt7qTVPRBNw4yh7bbOBAmSr6lvO7FZeH+oIEy3jnG5oL2v1juaIyaXDH5IHWjp8OiAAIqQuoBrE2XqbylJdz9QsAGsRH9ax1ZAS8AWmJ/b3SXp7ZV1qTiLoqsTWkyf2NOUGUTCfKCZ5bPOoeh1ZyWqmkLXfdOVFy4Gmc1ct+vw/CLvpFqNchBYpULkDWaUDQgDDSEE9p6O3oBJV993oQcLkxwuZFXuhSMOduZfH2xycyNEBNQX7PaDi3HQCEzGSXGKZEOeRnprjY4oaYAAgsJXgwDiYCeHQmxpZ9WobhxlQFTcADJFBYrZJ3j0e1R488v2gKVSAnXomv523c3Ej12rfBFPr/ioT8Jifj07vX8SXm6mWmhNnIRo/JINiq5VqeRXAHEuy85SQxyhxZv9Lcc0yPxPTsFuIxfuIgrnrH39VtOKyIXBko762QWDCNfy4jw/LgmjP1timSTFO8V++lURuns9VFAIGSCt56zrJE39Ijw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36756003)(86362001)(38100700002)(83380400001)(2906002)(6512007)(186003)(26005)(478600001)(107886003)(6666004)(2616005)(6506007)(1076003)(6486002)(316002)(7416002)(66556008)(66476007)(8676002)(5660300002)(41300700001)(4326008)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XZg9j3FVGnqF2FiXHpCKvkeGHEYYt9axDC3W3fSuHGy2wrEjOAFAik66VEs4?=
 =?us-ascii?Q?90saLs7CA9EKJMLCYhR1KnKrN6cX5QD13nAICYF4aVMbNtwLm3JSZe4xAdKc?=
 =?us-ascii?Q?de5r4o5OgOO/WUiNZC1NhpmCk+eb9ih4cVJ2d3Q/kjWE7H0TdbVgDfUZ7HOm?=
 =?us-ascii?Q?nSuvLyjSbfm7QiTZyo0FI1JThofxPO7W5a/Cozn1pLwihNIAB/+aZyqeOwtN?=
 =?us-ascii?Q?vNlZ4ffjOp6B6zVVGAcxDtg1LJnDKAKr1EeFZB4ubtTZrchb1igIqSKCp3Ue?=
 =?us-ascii?Q?jn22sNWSKydty6nboPu5Tg7Mbpm8TUVXvUW9cDYNU4mAnqakteOBvy6tcgrv?=
 =?us-ascii?Q?tOa6bvVVXN68rG1lvwkQczPkdnkKcrKTgF8H9LBFnwbet5syVxOgTSSpNFMC?=
 =?us-ascii?Q?dO82sYxHcTgv3GDpTuY7w5EWikvS82AH/pSq4v+KPd+woVtmZdzXRuR91WL3?=
 =?us-ascii?Q?OEweITEDXd74sUGG1A3+Vs+XhiPM6awGdXeBJOPyAYK5ek7DqupK4HqXfZU4?=
 =?us-ascii?Q?on/w6dcK+qUIWRtlcBxxnMh6XMHNH7jI0wdl49WhO+nRSWdpG3fb9NT1hw3M?=
 =?us-ascii?Q?lo3i1cbbpSbqkJg6c6ashuZJXiFefxB1p6mXhLRYusc20P1Nil2YsuseCTSe?=
 =?us-ascii?Q?LNRVm6sWTkk0GPXTwouIswaThLECNNiLMgcDi3nteWj8IuT9TWJmhUyTr6GA?=
 =?us-ascii?Q?tzgd1tS6kMUhutf3AY/+5jKytv6j8gx4GOtrftcrRBWTr97KeYYvF4uLnkCw?=
 =?us-ascii?Q?NbLO4vF+YVHC9wb/ExHYtSjzoyV9U2Rr1L4lSL98MNB3vOoJzklxbz+0klfL?=
 =?us-ascii?Q?GxfF0AoOBalhatlu1k68HRRRD9XyCGz2rKTY1D4UT1ZuDJSwv6QFd9shK2h4?=
 =?us-ascii?Q?dC8QmSDvG/1/A1pVvgs0r9BCjKsD8LufPydP2MdK6T6yUEQkHSaQJQJUsFQX?=
 =?us-ascii?Q?G72djASPkmAPFww21DvtjCmuAQZaabngHxykOq7Bso54dHHoOEpgo7ioS2Ns?=
 =?us-ascii?Q?vwxs1G1baBUGDWs0Bv+ahSuwdQHFwzDron+Bs36OrhPVpgwWSSNznLyewPvC?=
 =?us-ascii?Q?mdWdIAR3GeA9qBJ/vWdcsIO/DH/o4Y9BlCZdPs6CKiwNPL5schLnZAEga7qf?=
 =?us-ascii?Q?U8uQzhErpYzdS+TPnCC2nnNsmOXFXmZQWUifrBCbmLF9fPIs448qTqdiAOUG?=
 =?us-ascii?Q?jOdgaOfYkIWDJmSRHl0ek2KBkTNNjR4XxFlmkNllfDQp+ShLLslmV3jJSxZp?=
 =?us-ascii?Q?5cLQ1O7knWu2IOmCK4xvypdiaTXcRJL+4b6nQc7m5PQTNieHqA0U4bZktwDp?=
 =?us-ascii?Q?ALCE+fLYCeF8TLG2vMMXG5I321QtCGBc9Kx9ghAqIX1H4u8LJWhtoy19WGj9?=
 =?us-ascii?Q?UJ6jU5wIwiXjDqsQs6SnM5VSiLmt6e7NOFsKVbvEfifPi8Z1HYRuGOugQCau?=
 =?us-ascii?Q?SudatggUSVz1a3IitfJ7e0w0M5C5uLfu6JRRUwuWPDfY1xkdO3Hun2IPmhx0?=
 =?us-ascii?Q?4ol3hvac95+5pRMBfhlR5tjgy2PbR1Gs8kXtpI4hR8q0nEl+RUfiNCji+l4o?=
 =?us-ascii?Q?jRP4WFSdXKLscR15ptatfWNDD8ulpsRBN3Zh+kDmN4LbI5HJ9mxi9g+DKcNv?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3388f6bf-4288-471e-43c3-08dabb7736ab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:36:32.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLmKs2gN6t921bvV0HEpcrnajtbR/Dte/Pos9MoeY9dIydtf09RsgbhIUWoWCNDQ6IbVCOTdee+fOnk2O+9PZnu5o79V6pO4jenYqR1wxZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310121
X-Proofpoint-GUID: xALIcaWDmzoExBYW6t6GhN0fvztX8hTl
X-Proofpoint-ORIG-GUID: xALIcaWDmzoExBYW6t6GhN0fvztX8hTl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, the crash elfcorehdr, which
describes the CPUs and memory in the system, must also be updated.

A new elfcorehdr is generated from the available CPUs and memory
into a buffer, and then installed over the top of the existing
elfcorehdr. The segment containing the elfcorehdr is identified
at run time in crash_core:handle_hotplug_event(), which works for
both the kexec_load() and kexec_file_load() syscalls.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_MAX_MEMORY_RANGES description.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/include/asm/kexec.h |  14 +++++
 arch/x86/kernel/crash.c      | 108 ++++++++++++++++++++++++++++++++++-
 2 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..d72d347bd1d3 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -212,6 +212,20 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+void arch_crash_handle_hotplug_event(struct kimage *image,
+				    unsigned int hp_action);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9ceb93c176a6..2687acf28977 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -42,6 +42,21 @@
 #include <asm/crash.h>
 #include <asm/cmdline.h>
 
+/*
+ * For the kexec_file_load() syscall path, specify the maximum number of
+ * memory regions that the elfcorehdr buffer/segment can accommodate.
+ * These regions are obtained via walk_system_ram_res(); eg. the
+ * 'System RAM' entries in /proc/iomem.
+ * This value is combined with NR_CPUS_DEFAULT and multiplied by
+ * sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+ * segment size.
+ * The value 8192, for example, covers a (sparsely populated) 1TiB system
+ * consisting of 128MiB memblocks, while resulting in an elfcorehdr
+ * memory buffer/segment size under 1MiB. This represents a sane choice
+ * to accommodate both baremetal and virtual machine configurations.
+ */
+#define CRASH_MAX_MEMORY_RANGES 8192
+
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
 	struct boot_params *params;
@@ -394,10 +409,30 @@ int crash_load_segments(struct kimage *image)
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU) || IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
+		/* Ensure elfcorehdr segment large enough for hotplug changes */
+		unsigned long pnum = 2; /* VMCOREINFO and kernel_map */
+
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+			pnum += CONFIG_NR_CPUS_DEFAULT;
+		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+			pnum += CRASH_MAX_MEMORY_RANGES;
+		if (pnum < (unsigned long)PN_XNUM) {
+			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+			kbuf.memsz += sizeof(Elf64_Ehdr);
+			image->elfcorehdr_index = image->nr_segments;
+			image->elfcorehdr_index_valid = true;
+			/* Mark as usable to crash kernel, else crash kernel fails on boot */
+			image->elf_headers_sz = kbuf.memsz;
+		} else {
+			pr_err("number of Phdrs %lu exceeds max\n", pnum);
+		}
+	}
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -412,3 +447,70 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ * @hp_action: the hot un/plug action being handled
+ *
+ * To accurately reflect hot un/plug changes, the new elfcorehdr
+ * is prepared in a kernel buffer, and then it is written on top
+ * of the existing/old elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image,
+				    unsigned int hp_action)
+{
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	void *ptr;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("unable to prepare elfcore headers");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	ptr = arch_map_crash_pages(mem, memsz);
+	if (ptr) {
+		/*
+		 * Temporarily invalidate the crash image while the
+		 * elfcorehdr is updated.
+		 */
+		xchg(&kexec_crash_image, NULL);
+		memcpy_flushcache(ptr, elfbuf, elfsz);
+		xchg(&kexec_crash_image, image);
+		arch_unmap_crash_pages(ptr);
+		pr_debug("updated elfcorehdr\n");
+	} else {
+		pr_err("updating elfcorehdr failed\n");
+	}
+
+out:
+	if (elfbuf)
+		vfree(elfbuf);
+}
+#endif
-- 
2.31.1

