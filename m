Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9696485B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiLIPiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiLIPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:37:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FB5140EA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:37:46 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9Ewr2m021181;
        Fri, 9 Dec 2022 15:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Ugc6eAW9gHnQP1ugSbWdSdUvLYZ3p45fjsMLpuNz84E=;
 b=votmXyCC6NUWZ5mNjHqzzl24QrOpUyKCJ3wtEYWol3IdhDbN6LKoZcOT4jTBIvNmuFzH
 Tvc7FYhF+Ba3LfUTMkNGnftliFPD+3UQIGPPsBBTv8a8mVH7IEI879+a40VBT/d9kk8A
 enBIvyX12h2TwDoP81gcdCjeMw2/hcuZbxNJEZ6rPF3DxlVn4KGKd/jlrV0EG5zjXNuo
 fxc6ST5R6DV43MIj4jjjdQ2sox+852/t9jfnxAskCyO+Ljqf+hwICNGcEHdIbcFPqGDD
 apW8W7m4GWA9BBSwY4FrJE/1d0PFVxhKeIIxINHivBvjHdue7WDJrZNtAX9XL0Ksdzpw 7g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maujkn93a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9EIGGn006770;
        Fri, 9 Dec 2022 15:37:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa81gh86-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i14AXsqYY2RADfdYglDbobJoLsdTFwVROmK3wNCOaKy+03M/AP21UG0ROPht/ZERgZrHylBwSyv+YuJtGoX1ktnlj1sJRgdnODwtPnvn+r8I3JdaiJfAbaFC02MlHmz6GHDtn2YeeCps81qBSjQLJWjqcPHO2NPuiny+OTz4OEQC3Rp7c6jJe4Ys0StfU8XKQX90XZla+cEo8uwh0oM/icbEzDGWYBNB3XHMPWIiZlNQcggXkaFHaBukrMuLHA3IZHFlro8x8r7RMmTa0/ECl17Y8M9EYsgJVe8rXyvuejjDvvcVPk1Cjs/pOV2DVYB/+0CrvIJ1mL705WmO8uwtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ugc6eAW9gHnQP1ugSbWdSdUvLYZ3p45fjsMLpuNz84E=;
 b=mNO5hHRORpolsobR3LlyXeKuhJHHByRGTYWNR9rbnzs4QJl2vE+S0KURKp5xXZ5ebLgnCcvWa/1sUa/1ixiXlAybxSM9JfWWUkOcpq0rP1/pM2sDW5PuZYeEUlKrwvEGF8+UKYNzDmO0SV5OVYiatGaXIrFhMudTd+w2kt69++PKJOoXaBOPoQI+SAsvrodDhqB/UtwiKhngubdx35fZL/qaj90SiKGKBIORHpqfj/DAIJz6PTIpRBOCgbYzvUE4aUJc/Bmt02ZVsYg+9asLvl6bAHQHWe4nh36f8m6fUa0cN+MHrTatu3YTOGdcjGKA3vxbfwJ+0R4PxK5MfF4EDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugc6eAW9gHnQP1ugSbWdSdUvLYZ3p45fjsMLpuNz84E=;
 b=zSFdkvP1GRodUk8N0FSQIa7hpOJ6sR6vI3iIPpMg5RWKEMlkKkdiQhNCTdEksa9C3EqytvZ8/7GWBKdctxLGnQWiUG+96sSLItXUYns16tvTnO7KTJR9fEKnojuxQZNMf1OkNGB0GqE5CHYYN/iw8je/qkxoAf3Nm68Q7imuuxQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 15:37:24 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%9]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 15:37:24 +0000
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
Subject: [PATCH v15 7/7] x86/crash: add x86 crash hotplug support
Date:   Fri,  9 Dec 2022 10:36:56 -0500
Message-Id: <20221209153656.3284-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221209153656.3284-1-eric.devolder@oracle.com>
References: <20221209153656.3284-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcefd9f-d6a0-430d-bcbc-08dad9fb448d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKkd7LlcmH6L9R89+D7GN9Zj2Tfn1ipeZwY+Eqq9pE2BO9P9nHWL7dCsaW7eVAx6Lre51mTzmWS2e6qtniPivLV7YI0/nkLquhQhL787oo2FvTBNu+AkpNwEK5D9OKGFVcflj2x+Ey+l7yBvYe510v0NJnD4V5ruBKaBeVRVzNCGbGMnVW/Fk6ZEDRCcrTBvF0IG+IXjUK0y6tiFMkMj+tMmrdKIvDhfe5r+coMAXwA1bAc2UgTXQ3msa2PKH+kFe84rbxAje7LDOxCN/QyQzYIKK1tKqOesoJx8vjXsTFS9s+uvulYuPDc+g8fQ7vJPRTaT0JjN+wSf9FVkgHo70owAXj6U7FOnLh7fPzYPww5amIXxmzyD7oGt7OCzWgikabkMo/utHILYxgIIlgdbCc+LgGdbACNtGy/L83qGJyRsgYT2IHEqda35HOMxOd8pSn3fluLpWQIP4G2wEge8mvZHRs0kf67nxROuVJP4FtLanC408xIE2Q70DWRcBp5xl0O59SfnkiT21nRlYMoTzadYfunzRyH9hfXGV3YwG8Dc/Slhejgns6P5eJ2jfqJ3RxSuqiIwd0XfdRbb091fpLHdNgWpl+3gsfr+qi3S0L+TLGwPioVJk2vBgNu81oIKh5DpeMSqIP3/ap2UJBxBWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(8936002)(2906002)(26005)(83380400001)(6506007)(7416002)(5660300002)(6486002)(186003)(38100700002)(1076003)(6512007)(316002)(66476007)(2616005)(66946007)(66556008)(36756003)(41300700001)(86362001)(8676002)(4326008)(6666004)(107886003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2W0l1/YIpx9ZXJhvZTjo70QObJTOT1/VTeE0MJVJwwO+sRjBAfz2NnjRO+Bc?=
 =?us-ascii?Q?5bZWOYdmQ9bcQClJWydyEoDC0ToVS0mmLY29klLh8o7m42hOJiKgiz7N1uv+?=
 =?us-ascii?Q?hyVxP/8aZgn3OjZ8P4Pxe8Kq8+IbmsjpF9ZZL49+NnkIaQx/IQCYSWGOChZ8?=
 =?us-ascii?Q?tCQSA6pfTKV0Ul7ydyVtJrssMjdX746egi21YEPSkaqAVOa6sntFbuIEOzp4?=
 =?us-ascii?Q?zXXCku2vaiWhA7/7swel+Z5S7w6e/YTYlHTxcHM8GinP19b1fZfGRrRfmfMx?=
 =?us-ascii?Q?HTes0L4ZpSZbpaBDh4DlmzbLAJwvLfGvTmLPmpbm4YYhViWJEpfkAgtyL17m?=
 =?us-ascii?Q?zKmGhSEQ37tv5H/VDHLMURVSfDBnwwf68m/KgRGfKOp/MKiui+gKKho0Sshl?=
 =?us-ascii?Q?tDSGFmu0WTqeWm9OQe9n8o9W8YP1YbI3shLixHcVsiNfYD5NptcYN7i9sWyY?=
 =?us-ascii?Q?plbAeoaAUfQ1/teuW2+D/aBJOZlZ8HtEeWnVVBEzkD2xF1j5uGR8lZbaMKq0?=
 =?us-ascii?Q?BgYKxyIhl0+r7YBmdiPv2C7QvxhmHKY8RpoJgCBUbOnK60Gu7HfrFVUnpoY0?=
 =?us-ascii?Q?TvG03dJGZw8u83n7h6LYB77OxrNvsGt+m9OPgJu/pWhWu+RTPfWy8u/NyB5U?=
 =?us-ascii?Q?NEO/G0sI92IHC2HWsRertmoF8+azQSdNxOwTt+YFaYZttyRmABrMvRhX6DUn?=
 =?us-ascii?Q?9FaSoxUl/xjYCMoUxQ2orGDjJJNZaqfFs1xbrI39lzzW/eA7NazOY3dnD5J4?=
 =?us-ascii?Q?c165nlxqQ7nzXKgoJO821bT/Z3bUwEJK7RArWb2dQmRj0/UtrY7+a/cvAjHD?=
 =?us-ascii?Q?msrLqB4SXa5gOeuX3RW1gRnfsjdZFkcQcEr2kUAESZu3LuqXt/lwv5lVkUrb?=
 =?us-ascii?Q?LEo0/SPROSbECvblW+Ll2kYEjZhydkEQT3R5VwPBhMWvOEkjqSyxCMMVR/yz?=
 =?us-ascii?Q?rFNLLCek9YamEcR7x8nhgnWcCAMYZy6Sbs4IhHhiDU/lsycpKbUOq3saz1Xe?=
 =?us-ascii?Q?Rsnq8t2pEV3/ujOrANIsE+79uwykOhv32Lu2DSiFsrYFvQ2nik9ZcML3TZtD?=
 =?us-ascii?Q?OyEq80t3Q+LhKcy4rNw8vCJLw0h1K9q6gQaSkA9vbwfEtiTooqR4ge8s74yr?=
 =?us-ascii?Q?IcWZ7JPCu6+8ydoG8bCtFakjxIvSQzDsx4qJFaDD1SfCQkMgr0Ues3UvAOEJ?=
 =?us-ascii?Q?Z2Wlh1Y/NsCCehhs3BDjQ/T+USmtCcZMu1RGyx/vWw3SAgPxvaSkldnCuByR?=
 =?us-ascii?Q?wwUFO3A+2p85kadlg7mA85+ux/2uELUFTAZyqvZz3TFuQ+4SaM7JfZNi0kgV?=
 =?us-ascii?Q?4KjrstoeqbbPdE9DCxVktZyYbhpzk/yf94Y6nR7t8rotqQlsA1oKImSvAUPa?=
 =?us-ascii?Q?Lk89nx9e9VyEA35Jc+XXrWHUWCvW6eBnKMwu+8IXSXPnlzdAKolV0jWOIWsq?=
 =?us-ascii?Q?517dValEOWou0FnA/oYwfwY6vQ/toIFibfpg1rPKhfHcec2GkhqHL6Ulz913?=
 =?us-ascii?Q?I2TkryAEWyjCRj+pxMkkAMEvbQFoVYHVZqfUepE5YQUPzamKk70gotTCJiJP?=
 =?us-ascii?Q?9z5aBqu8kFYoHhVhRVjquPjREsl4QLUll5WAmO+y6bvHSfemK7pKACmw85hi?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcefd9f-d6a0-430d-bcbc-08dad9fb448d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 15:37:23.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2dNhcYwNVfUTY/TESgn4cgu+x6ZtlW5M9GT2ycPR2wa41q9g4h097v3BRhbc2f1/nAI9Zvcy163AOuwFhoUEGN1kfgafoaUJngHH9sppwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212090066
X-Proofpoint-ORIG-GUID: ykkaNgAgma_I5NzJdUmS_XQTBUgqOJ9P
X-Proofpoint-GUID: ykkaNgAgma_I5NzJdUmS_XQTBUgqOJ9P
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
 arch/x86/Kconfig             |  12 ++++
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 114 ++++++++++++++++++++++++++++++++++-
 3 files changed, 138 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..d1990a83e8f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2072,6 +2072,18 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default n
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug of CPUs or memory. This is a much
+	  more advanced approach than userspace attempting that.
+
+	  If unsure, say Y.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..1bc852ce347d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -212,6 +212,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
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
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9ceb93c176a6..5186df48ce6c 100644
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
@@ -394,10 +409,39 @@ int crash_load_segments(struct kimage *image)
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		/*
+		 * Ensure the elfcorehdr segment large enough for hotplug changes.
+		 * Start with VMCOREINFO and kernel_map.
+		 */
+		unsigned long pnum = 2;
+
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+			pnum += CONFIG_NR_CPUS_DEFAULT;
+
+		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+			pnum += CRASH_MAX_MEMORY_RANGES;
+
+		if (pnum < (unsigned long)PN_XNUM) {
+			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+			kbuf.memsz += sizeof(Elf64_Ehdr);
+
+			image->elfcorehdr_index = image->nr_segments;
+			image->elfcorehdr_index_valid = true;
+
+			/* Mark as usable to crash kernel, else crash kernel fails on boot */
+			image->elf_headers_sz = kbuf.memsz;
+		} else {
+			pr_err("number of Phdrs %lu exceeds max\n", pnum);
+		}
+	}
+#endif
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -412,3 +456,67 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ *
+ * To accurately reflect hot un/plug changes, the new elfcorehdr
+ * is prepared in a kernel buffer, and then it is written on top
+ * of the existing/old elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
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
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (old_elfcorehdr) {
+		pr_err("updating elfcorehdr failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

