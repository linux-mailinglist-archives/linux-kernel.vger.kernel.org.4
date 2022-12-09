Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871DF6485AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiLIPhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiLIPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:37:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937261DF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:37:32 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9Ex97l028889;
        Fri, 9 Dec 2022 15:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=yMEg29W3sMLUXgMiy8fBRbgWQt1x97oMT+MMk1QNbdw=;
 b=trwqcHbvVJZKRwNAQm34BHXwuslhim6i1nbVVC1W0th6T6AoCmbj7QGMOQpHyELq/WP9
 dT2OCwcSNFzhkFdqcMnN57UklipFzbtU1n1XSu/rIu2irRFMjMXG2a0XOf+pw2GOoogd
 Z2H1g4ycAw6pL7grZZHCqq1fe/Vf0SCvi2iNRgp7/mZeZ6ryx7uteCVsF0nOpUw7N3IG
 8wDeqOUNX89NN9T3lNV6qTFl2yyPtRdO0kpqK4mkyjCuJJsFGbV8nKkHWWNvqy8430sP
 PNUeknxCMALVp4TVVRZ3RCRRpbu/peg+EZ33vZ8fSurRFDVf4STWrVNh5oYFtG7M6wjc +Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maud75fvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9EJjO5006769;
        Fri, 9 Dec 2022 15:37:10 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa81ggs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csUg0iVDEDM80mB6D1fCfJtSe4NxzZ3rBkw4VzIt+d9hwF2rc2DXoA4FXadlnys47Wj7CjrF5PIAilPAOGAjkhFeUh1UAQGovRjqK5eMNCp3EcIsPwo18Pz2Xm3J/5k+yWjFZnpuoz6MyqjZDORJb3moFusKbg0N3Y3Kdi6ofZUwF9UABsI6qPZoHDWrgIvwwZRyacbhaWk/x4REjugnJ3EdvM+l0Y/ICzSB8ZMBoo7t43Sn6QbX0nGTE0afusyQEcfb8CfGHrVmwGMjOWrVxK8+jGV9gc+BNhYQM86GLkB9NBRwED417nILDXXUxgxSeCOLZ/rHiymjeI0fL9/vFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMEg29W3sMLUXgMiy8fBRbgWQt1x97oMT+MMk1QNbdw=;
 b=kT7FOLrwPF9OFNKu3UsjXDB5AS1mzqlUae6OQZM/Om8XP6rTLF3qOcja4Knnj0fb9rR8pJMJMdMHC9xlIOGPuAeLDQiwEwVu3/kgFAR6LEkw5/m4zUXorvNivatkTnCN5GuBVYxDXoX9z8KODgMREvgvE8dbr26temFNk2xYu/2sggExUXPikfntgsn3g0GAjrlNRrmV21pf0w5LAqyXNYrXGPHITuhBRzsEE+s/1gte6kZVeiMN4oHDO03Oi3MTx+r/q8rGOPZBiirpseZofSxSXPrMzlLho4R6A+HrVKbfn16sAS9jeL3XnNXP/Dar30mfJ5Sgb7S7/WgM2Zqlbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMEg29W3sMLUXgMiy8fBRbgWQt1x97oMT+MMk1QNbdw=;
 b=OcUn3Oe1WveL8SORz6ru/c4fDREf90Xin9pD7DIqxUgYrOQLviSn6JtApbsPODiygdgWTB2Pseb/xVLiXlVn7IBHmYxtb7dxJxnwEXV3xgk/ZxgZ5M2sDjlYlCCMPYl8gX+pN+dliyE1/WHtypkQAQkv6AZapSBQbgMaeDKoEH4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA2PR10MB4666.namprd10.prod.outlook.com (2603:10b6:806:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 15:37:07 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%9]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 15:37:07 +0000
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
Subject: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
Date:   Fri,  9 Dec 2022 10:36:50 -0500
Message-Id: <20221209153656.3284-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221209153656.3284-1-eric.devolder@oracle.com>
References: <20221209153656.3284-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:806:a7::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA2PR10MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7c04ce-b548-4932-9a33-08dad9fb3ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bu8Y/2vnVTFxvKyuZZFVIqE5C/fQlkFMj1meLG61DIrghsTHkx8PSV3xlOrlLR/ilb664IMUR5FszaqKVrHJ6B0xonsDT2VSapBFE5e6GKYldKTIv/+1IUgeA55eOy+v4lpeqSZeWaSMj3Cge+seZJbx5FFNfvwiikV0D1h0ThF75ZkiOpTz+fevhPwn+gRyUyx17bYRE5IX454r7RsCN1gjdJOmZMe7+sD69ZpbY6yvi1++ZUSyuCh/31bOD90KY+8vcJC1SsuzsqrlCKT/5eUDAzJ76siTwHAT6l3/u3CpcE6GTfkPtkIZ7Szp25Jxj0hiLuE/gSSnyDY3PDgNgqtmZXzZVne8AUCo8I587pHV/g4qF7IkXfuC6CmAd4x90zpaHTuW+7BQ05eVqxvkG30n346/tucaT/mIxJ9JSaqwlFjLkAOPq8Bp14RsGR/iHskR8uW/IOPMps7gwHsFZx8D5WvCxxFEvOxtC0JEkECqpO/YMTG+i5ISsaXsLrZMEldsbd41h5xiQs2U0h3Tm9tKREZiXcKVQG4eFB5WJOQoHYtGqTADwpHpMk3F9+wVX062jHO5AYe8/2rFTrLlvPP+NrAl3rRVrMpJRDlpWyfX7GIAyF2fA1tAQjyfZca1AiMaNr3B7AqruMXuTZeHtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(107886003)(6486002)(66556008)(6512007)(6666004)(86362001)(66946007)(8676002)(478600001)(4326008)(26005)(316002)(66476007)(6506007)(2906002)(1076003)(2616005)(41300700001)(186003)(38100700002)(7416002)(8936002)(83380400001)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4TPLQnAZ1jgP41oajE0EnReghiGf8Ba709lSHp2LSt5uq/iYWbQ0UyuakeKQ?=
 =?us-ascii?Q?p+3XFEdZ5JdDNBTiq+EZjDK6E2r/PElPqxun0ZWav2PZYzN1rRYrCfJHmYf2?=
 =?us-ascii?Q?8Gmdt/DJTLB2pp1YagHm9lyhexhG9MOqHVRaIGOD7cZgZqbLp4iTr9S0m7Yl?=
 =?us-ascii?Q?/yruuV0iH5ChWYnMtXARVo7ZvktEwvCNFBngD/kBhQ0RcgpGbfuYUeATXIo0?=
 =?us-ascii?Q?AnEsVBBjpJ3p7HFqxpeqfAQZ4uxhnRiOIDO+k2YCf067/6QNGLPLClsMSyyX?=
 =?us-ascii?Q?TuiC4cS9BPe4pFwFGRAMyqr4F376LiFNmoyg+QNJW6UoP8XOYiPZ7CrJms5o?=
 =?us-ascii?Q?C8Qes1US+Qo0tjXpBrvMKcBybYWvtF0bpbd3oHoZCxpbDVfgsrEWX/K2A2gN?=
 =?us-ascii?Q?vIq9ywNhih75MVN86kGPLodLlftfO1rTurR9L/N3a0vWiKs7fWiw/Ujk5ZH2?=
 =?us-ascii?Q?FCAg4VPI0AJOYc6rpVsYe6tERidl2JfnfLpPDUxnj8fjwUDSN9pmwSbzC21R?=
 =?us-ascii?Q?FVf5dkyTHu7QdufEDU5cYQP3lAKvGm0R9lN5qIQneKtnUNawDQBYM2OiyWeq?=
 =?us-ascii?Q?1+ReCnVCnCTR1iAUH5ZflzG2NUsvls6Py1ZtQwarjq+mBYaUTYg91av774dL?=
 =?us-ascii?Q?Vl5KLyQ0xgMVYh+5DEQUbagHEwln/RTqy3gUXMmZiT7OgqB8paKvkRxfPH3S?=
 =?us-ascii?Q?TILVOEcd95Z42bC9kvciD5vTdrShKPPJ+zz+Ls+HTFHjLmPgqcDrsU2X0D0s?=
 =?us-ascii?Q?/XjJmxe0corQ3vT1xLVIP/yWIryGhC+j8ZtbMwEo3BlwtgooIEzdY6dPuO2w?=
 =?us-ascii?Q?lHyYzsEfzestT4hjynUDf/zVsc5Lf+HqXS7lMOgtOrFdJil6Qt3raVRH7Pb7?=
 =?us-ascii?Q?HtwlYkv21NaMo/B7jyZGT651l2CArgp08iXbIS2IJAcFhwM4VIEhPDOsVF7V?=
 =?us-ascii?Q?2UCU34k07x9rb2MiupBZBDvxfvgEZo27/ulm1YZrzTBJ472cpBnBOZxBPScg?=
 =?us-ascii?Q?KsI2ado6BVJ3CAE440paQRHKLSYnLqwswMG3GyeZSeHvr6z/44fAhY/ns59J?=
 =?us-ascii?Q?dl7T2aeC/YuMFS7cFJi4nsOAj6G0O50m/NFuq8EyIR5VfZPhOsuejzSPpDEy?=
 =?us-ascii?Q?ddanDzHwSx23hVYDoMhhLz/pXyKgqrU5O22PnY+l4JLNte5Y1E4muU10WeFT?=
 =?us-ascii?Q?IUDBjDVnQmPiNCgUvDAzGbiKRS2MoMpapP95gm/uCPYJsfWKtY2x8joD88IB?=
 =?us-ascii?Q?pOpiaob4g+e4Lbh7A4xvsyFXeG+nJQmvcMn0eOER60ahv0syY3BLQiBMtdsg?=
 =?us-ascii?Q?ABEeoS70DZs+xoWF/GdaAsORKLsKndPzMg7gbxwkubGInFp++opUICSoWRfZ?=
 =?us-ascii?Q?MTyHIaBnd/pyfW6/vY69p0Ulth1A9LT58FsGtrYGiLS6yqJawy9Ve4jwSyBE?=
 =?us-ascii?Q?4wNCyYH63OJsyiNM/l5cClIaVikLPzaZnxJ50dnIaendYKu0v7J5RLqjaCLL?=
 =?us-ascii?Q?KuiV4mqzDk4Z8pV61jUEH/X7tFlIj98XHTeApx4Qf62D5Hn2e2uru4lr5K9Z?=
 =?us-ascii?Q?H7MFBXkoBmpjhvNfqlZV5GbBsA1rf1RV3chqAnKFlDP2wdKxJHv9BQVEC873?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7c04ce-b548-4932-9a33-08dad9fb3ad6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 15:37:07.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKGFPSQqfve/YG0Y+DmZoSBfEBg4iXCmgWs8FoCj4otNPj0nupyaNhFnliTfi6xogGftYhQjlGNpaMKLRaJ3VyKKHIckrbqQgEJrrsLaeDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212090066
X-Proofpoint-GUID: 9FU1u1Rt2visGNIIS6QMfof3u-I62MJK
X-Proofpoint-ORIG-GUID: 9FU1u1Rt2visGNIIS6QMfof3u-I62MJK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the outcome of this patch set, the crash_prepare_elf64_headers()
is utilized on both the kexec_file_load() and kexec_load() paths. As
such, need to move this function out of kexec_file.c and into a
common location crash_core.c.

No functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c |  99 -------------------------------------------
 2 files changed, 100 insertions(+), 99 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a0eb4d5cf557..46c160d14045 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,105 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 45637511e0de..f98d1742872b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1217,102 +1217,3 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	mem->nr_ranges++;
 	return 0;
 }
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

