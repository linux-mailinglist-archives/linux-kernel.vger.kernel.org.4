Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5FD613E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJaThD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJaTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:36:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6387D13E2F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:36:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VGx08m014808;
        Mon, 31 Oct 2022 19:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=yMEg29W3sMLUXgMiy8fBRbgWQt1x97oMT+MMk1QNbdw=;
 b=Wr/p11WNfzIlLNdia6i4gN+IVMKMrEhV3u49gUR214YY49kB49bnUDv4wL5ev/PwlG2/
 DYmX/WDs/rAQkDJIJg0wt76wpD6qx8a27D8qGLgnKcWigBhebYNN45A7UVPfC6vuWJKR
 sz0qhLk49cLd1RtYDyPnf0BuJBoH2bnvIvSCLgu+sqiuHM+oqidgP/uvN/3efCYNam+N
 c9iBmJ3liS0ZztmgqH3vEfiLVMbpxiDpBGtQYR5c2QeVX0I41ASd4EHE0BMW/llCv/AN
 luWCE5a3cAijoJzXFDOqaTHEYzwdcMYImcr/gRzN+zTP07qSUTx0GHAFHkBQRKptbPJy Ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2acn79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJYPkm033096;
        Mon, 31 Oct 2022 19:36:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3nkaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWlZRHVybm64yul1dMd20iWrsyJERDkfsMvFPgotv/yNEbfGkgZL+uNzSCTGCGi64HRNp2+OJmYjDv69fhBWLQI6Hm3WdW6doDy6zmimjJ/dPYAXNfn4GV+oDv1fZYFe4ODSPwAuvd1Vx039xevp9L6ufyGfPPYlsLl9xaeAy5WDNV/hFKNiHHmpczf8ikdfaBSxQRVb0VsGTMNiNWL0Db1GPzFK/yKi5tGQ1KVAy9WM75PckifEmLy7VRydX07nvjYokWnueIbKFpihQQmqmszQXxhkKFGl/juWYsrjGJw4uRx8ZR2bLKswNvcIa4cePryKFl09ZKzST70Y7KGm+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMEg29W3sMLUXgMiy8fBRbgWQt1x97oMT+MMk1QNbdw=;
 b=INmot3dNzDF9xUs9sv/qepfDYUE2UQ3OwRZXMSsoZGnPx38bprk6FDvO3FRCQQh7FGV1PRMnQRo0ANaCpKFc81IP6wED8/Wv3ISjUf3kRFHrSxaKaLahdprRj42tMy1TaSJph04D9wApZP0HadkcfIHbuvsLwZ00lJBN8MJ3p1zPl/u4zFYotRjPxABpGrsJSnR3RmArNHJjGnrsoYbUTbHY2dODiFzStmBs+NlKsJG5Uz4Qa/Uh2hCAIHzMSNIsdj1WPoyoodDzKADj33taUH5XYYA6RhUPnLWfrKF9j+r04Of2RlGLc8hQQa/YgHGuf2v30V+04AYyKgR45EGZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMEg29W3sMLUXgMiy8fBRbgWQt1x97oMT+MMk1QNbdw=;
 b=TtlImhyr41FNmMCln7cVA/vC7QDefiu+6rzPKAhf7dyPgvl3bKWeAmMIsHl4LHx05vE3jniy19GdgFxrM4GxkPYxZ361TQ1obemBdtyYsV2nrQaz4AKEmDhd6KLnkZLsu+52aLjdKNPVaqVSSPEA2c51RBI1Vt/NpOKhwVDQMrM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4228.namprd10.prod.outlook.com (2603:10b6:a03:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 19:36:15 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 19:36:15 +0000
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
Subject: [PATCH v13 1/7] crash: move crash_prepare_elf64_headers()
Date:   Mon, 31 Oct 2022 15:35:58 -0400
Message-Id: <20221031193604.28779-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221031193604.28779-1-eric.devolder@oracle.com>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:806:125::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bcf738-43c9-4c92-1d15-08dabb772cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaUHiE2VLHqOnYX/fBXYxomln15I53EJMS7qwIntNnUsccbfi7iAl9w51CZabaq3yWP47NFsjoafWL/45LBhLMK2DWM5SDCz1SyGPaGR+/2WKzrQPDwATp2VCgrAMdWACn4SbBfr72f26dcMkw1dntTZXxCAd8DK4QSNz+gA2qlS587921PJWs5p8Rb10rppiEuobM9vcKoBi3CIngf6v8Eki7nEyOC5bGjnohBY+HY/nPqhHQMXNGvkeOfMamkwXuVCwFyA8ZN8Ragxgo5cbI1tdgrlQcCkSyoacAi+7b162cO4hsEYYkudjkEl/MjeBifA87k8kEFduCcJ196eIqaBJC4c+4Cx5m9qoSXJs4nYHNxKE+HlW0pp1ALSVQwKiUnekEc/wqY+aX4aUgoMx+cYICeDFXZXaD5W+f+igDp8sZcYu5GszMRoljNjU6Sr1Tq7tgd+Mml5l8R2dhN0Ay/RyD60t7cKe475c5eEDxlcXG23S9BRH9ugG36+Een318n7LAeRbvmq4ZJcLDJKUiHrT9GZqpLO/xbK3SzaD0qcvSCy50iW4YyNowLM4y8VBQlR1H6DiyDeD4dm75h35eztdpPHcVedBcfPlqexiqQ7NA6MZmy7ar9wf6XcDb69TmHDSkyGJW86u3LPeKK0VD5BDUJQoWKNadj8wtRmNBpH6KgGGSjX51y+1UHLVuQV0GwlQieqgRuzvjfP4Q++5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(36756003)(2906002)(86362001)(83380400001)(6486002)(8936002)(41300700001)(7416002)(5660300002)(4326008)(8676002)(66946007)(66556008)(66476007)(316002)(6666004)(107886003)(478600001)(2616005)(1076003)(6506007)(38100700002)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JRM4fvx1NS6Pg1S8K86mw0FmEHxxgq2UCbX9/vTQbzM+4AsU3av3A5cAK909?=
 =?us-ascii?Q?FXhIQV3SuDAPqWbvmvceS4tFdy7J87eMTf8nVykGkVJTKq8xkdMBdzVVfLKd?=
 =?us-ascii?Q?WjR5FBKrnRBqzJBtomyNXb/uWyLKdfYAIa8vZ5ctm95Ga6brWA7gdBb/apf9?=
 =?us-ascii?Q?DNHB5JMhF4VM7u0Zo0SP3OSVIFuoGXm2JePFPG+frSByHPyYqxwVTxVY9UDO?=
 =?us-ascii?Q?ywzR+VCWd2KUMtXKyEZEcCzg9qA6L8MYaHav+u6HgYG4ku9XN4iovEs5zQJ2?=
 =?us-ascii?Q?5A4dQOFFol+8JvoGhZMaNCGfr8UdI7S+bVmHHQ3x/agVbOhlmiF+gn//lwFX?=
 =?us-ascii?Q?t5Vj1ALhG9KLCOnHQ1VmDjt558av9wrpdz5BwOHLLpCZCPj9nSHAMradtRdV?=
 =?us-ascii?Q?70MSA+XP6NtG8evCzYMfuym1fMjHbdG1XsYae7S/tw2rfo9yj+mdcrjNAgds?=
 =?us-ascii?Q?+qNSMfJtbMS+95P02rh+MnvfX/ipv8UDPMUY2f+TezzLrqDMzG/yH+CiIden?=
 =?us-ascii?Q?8hEqI93LKJy4EVdB6CFXfVOAfgswf6kFAW47KPfyLezi1x8a9pBl2r4sR06k?=
 =?us-ascii?Q?EpsqBjAQOsHgDvF7A2dVoC2D82mwi6lm+qkZcwrgsZa75ZPpJ+Kj1LDRXCae?=
 =?us-ascii?Q?FsT4sLPrYVJ/Bg4RBhXU8xmylpGnI5bCZgeigKePwKfe3TLQ9zG48FMEcvlO?=
 =?us-ascii?Q?L9/+ZUJQ8dEwrSmbpTqmziojaGBtjPZp9X3nCxFgaLo/DRRZW1Nh0zOrPP3n?=
 =?us-ascii?Q?AmN+XHROG0iJVzNDuTYIgwGhtFd8RHXKPVp/c1egMW0ZvoT3gB/q4cUxvXXp?=
 =?us-ascii?Q?V39c3TuiMTsHGh4BRczEoWLYzJJGYV+01iNDkP13JAbXuKbkIGVieO59eT2u?=
 =?us-ascii?Q?t+mVKZlW/T4cjPtr3WdA3mNnmVuppDZAarkx2TGPeotyiPcKk4c9jyBfgDOC?=
 =?us-ascii?Q?rmYVKoFoggdckeJuaBusaUMJV330qdTQ6OJsN+jHqsxHTh5IFIimc+XKBTrN?=
 =?us-ascii?Q?ksWpFk1Rkt5zBTo+DEVuHpYVGRtPebQ7+JOjJqPvGm1nfUA9boaAwi3x4oHL?=
 =?us-ascii?Q?l3tgY3Jj2atNCL+O7a0D4pfFxlICdP09FmDx79eL2q9KHtiBzhC0R6cNxK5H?=
 =?us-ascii?Q?IDzoTVEU/y/1neR8DUnzDFGhBO7G3jN/lZtnvi26hv5UK6yBdRM0za32Erej?=
 =?us-ascii?Q?M3ijmR+VfrY8poXdIHG68ytBndOELPM1QOo3AkP9DHCHVi6NqbVB45htOhHj?=
 =?us-ascii?Q?MY7NiPV1s2iaGTxZNlCQeakLiT5E5Bf2TVBV3uwgVtwXIDc56CcPC6t7vF4n?=
 =?us-ascii?Q?f47+GmIrNdSQhGwrXqk5NdQ1GGofHEPX8NVlX6CptGDrhYF3MXQV32u6TWSb?=
 =?us-ascii?Q?DYXtGviXmbe4s0jTwdNu9nEre3NYTSP1eslu8A7KFfY0RSF9xKe/07KSe2MX?=
 =?us-ascii?Q?deYGCe1kwXye35cTDWjBMtJ7WTGBUOZ2kWUuo1cJNP5XvRSeUdoOZh28QWS+?=
 =?us-ascii?Q?igK6eVRXildnumFY7UZfBFmgrnhi3Lo+Jb09aMkrd5EpjywSl3a7vBj40Uat?=
 =?us-ascii?Q?Erf3Gr6azHYYqApia5cbDgRFxHMGGK+ZNIQGso/xEcBYtoQF0fr+RwuZd1jH?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bcf738-43c9-4c92-1d15-08dabb772cb3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:36:15.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g067JIt6c+CP+7PeAQlaorJJJyIKwgnbk06p8oBtFURhjjXd29i8CsSqEST/0arIdEvnO7TXEnuzMSQBKH9X8QigExPR4OvQfl+tv37ilJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310121
X-Proofpoint-ORIG-GUID: lH8G63eDG7QIKhlo7ymJq2z5uHSK3DRa
X-Proofpoint-GUID: lH8G63eDG7QIKhlo7ymJq2z5uHSK3DRa
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

