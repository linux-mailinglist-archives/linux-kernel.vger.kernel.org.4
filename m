Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD35B4146
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiIIVHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiIIVHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:07:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E209149955
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:06:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289KZD8S002947;
        Fri, 9 Sep 2022 21:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=BUOeF5GBMKa9jFjQ73a5qks8l+Amq1zI4BKRWRXBeHw=;
 b=d656RKGo1a1gjqTakR9/682GO/XiECVDz5u6LenAerlCmW+WJrAYFDjiWQKLtoKaO9cO
 nI4dRl9ADV4TvKEZsUabUvM1edGgUXUu8Oyyz0d88NrtdFy0smmhCLnJw0VWA+yYruMA
 WxTB3WmxlCAtb8JKZ51gI7wXf5/WN7Gf/ENXxDIu7GRcNFNsRD8E5gXdIX1q1r/rsFX0
 FsGAyZRvgh6u9lsEaZM54iu4kfsN8tG+GBvHTOMJOxmbrDG93MAvl1Tvoia16tgC+/S/
 DM46IzfZ5Q5TRUur/+OzSpW1k1LN+xC3fSshJ0cq8y7ThfljafI44oYG6xyhqz686aWf 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2rgnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289IxwNH024591;
        Fri, 9 Sep 2022 21:05:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jf7v9ya3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAi2ndbi9PB37abvwmODwaBYU6VL4QxDOqDsBHOBjY/5hhvywq4mbgx+M39BmDscrWWm6iufJppWQ8IMZ20kPEJPX3aF2xX/X3vDPWHFzMEr7F91LYbkfHzjvJG3TW2wmDIT6qx5qIlIs1rJn4XoowFy4cyY27FjX2u1Hl386V8/1EE9/XLgyypNYFN+yp9WPnUx0y1G5K0s8kCvae7jUjxDkks1Me/TC9S6y351JNtaPoOGXDiOt3XYETS8t4ZmhxhuukGnE1AcUrUE6LIrf02SSC14P1jTFlzONSet24fewOPhpV3JyftbDoQGi8F5kQvoCH/YQVzPlgX5Melfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUOeF5GBMKa9jFjQ73a5qks8l+Amq1zI4BKRWRXBeHw=;
 b=VtThSWDa14l7CtUOBuh7psLsFMxLkevevBliMqZaDJrwMzWUopGgVpsTiUwV75kB1O8uHM+pRePUmYVDXnHOB1OV/8MxYc/jdaP5ytqIo9516jKdC8XfwrOVnaS0DiTIc2bIjAjxghNowyC27JhzJ05lDC7gdyYTHbqDclyyGqTw/ozcnCpbFRc7bSac9GOHfQpf1DpEGJNwyxk2VjAnaXPR5w8lP9ZhfRN16sWc9qljIXKLUOO0YZSpiqSxU5AfA9qnayaFLvVbUdGCHXrPa7XD+JW4PgJ1DlxYVqU3K3L+EH/gfMWeLPfIx5HomlvId34H+oWrzwFoUvCf7+EiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUOeF5GBMKa9jFjQ73a5qks8l+Amq1zI4BKRWRXBeHw=;
 b=AefDSNgHfyenMBvNyw0a0l3SVPN5DtZZ2sC5r7oWA6p9Ixk0LQA4GS+SuNlSyZXlWJO4xr3Jp1vHATlhvgXGvoEKL8tsB8rIAuo9gOenjRs295D5zWgBf3f0WUJyKAtcjjCZXCAjmPeovvQOpPoW+Tpc3mJYdiN29LaWS+oLjCs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB6777.namprd10.prod.outlook.com (2603:10b6:930:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 21:05:17 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 21:05:17 +0000
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
Subject: [PATCH v12 1/7] crash: move crash_prepare_elf64_headers
Date:   Fri,  9 Sep 2022 17:05:03 -0400
Message-Id: <20220909210509.6286-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220909210509.6286-1-eric.devolder@oracle.com>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:5:333::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d8037a-4615-41df-12bf-08da92a6ff1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CroE+rBh2ZUzi2bOsi625rMv/H9J61T+5LCt0kD2j4uQUyLXLUJ2Lgc0FdLXlaZ2eLBxHbA0pzvL9kl8o/x4+elJ3S7WyhxaVBGVeqDMCNbX3pU+4sfPXzUBqj+OzVYN2DEphHu0qeO8P5TCixVZd/dLdRg5WgmMHmyIoCoNEGK9mkJ0hp7IYquvlF8c/J/xJiA49N6J+h+ZSMa9rC7Mdc/QEJ4QUhryIjeMEv6YgCKdT1dOTEZmKfFbiMFHIoUOlNAuniLJGjlafcvdx9zU8gymmCLGgviQ7vVg7k/JjbyFMHxQe4qkAR/oeTIvp2AuUTlFS6I62rnJTfL6oLLtwsHQeVm5RTxwUlWgUWMl9Z0gQemqUSh3TljZfIliyK6XCBiuR9P4CPb/elWXkJpy2jmYa5X9L67eF7F6om74geTSNySCvZHBrC7eIZfm+7GV/oAVNq1Ofet4oqdMNhFL6pOnx3D68TT+QesyhthT6DT8iX3kNREn+Zcayw56TiHEG7KxXyPsvElYp2PwmGtKUioVEYrQ/W7StmqNJubWhXGwIYn4Cr4zTK3iKBPmENY7i3PNDPX3pfSlDJUB3MOtpO9sg71+Tl0A6PiZkLIAyfW7ZGvgA+l5N8x+lL/7GmIsimIMw7wXAftqaqIyMPpo5TV4HrKXId7XvjsXk6Xp1PNaxQCSFkaAvzG6ND4IDV+6q9JI8irh+eggRwI03ys7tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(39860400002)(346002)(26005)(86362001)(6506007)(41300700001)(6512007)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(38100700002)(8676002)(66946007)(83380400001)(66476007)(4326008)(186003)(66556008)(2906002)(8936002)(5660300002)(36756003)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i9WVuoirlwG6AJQ7PRQCooARF1Urd0iR+c/l1COaLD8LJ2A0W82Xn8JgjiNC?=
 =?us-ascii?Q?nwUTo9LANxO+2Ctxq/uoK9tV902heVm10w2kp6mmpwXn/xAH6ZWJKiCkE0TU?=
 =?us-ascii?Q?s3J2lvPCfkLmgKvelt8BB9o4G4a0g3me07A+WwogJW041nk+NyhxgFXr58t/?=
 =?us-ascii?Q?NLlgfTllXvxaVsA4qtK9Tn9gjWo7x28KtdvMIvau9v8sulwu42zua1FoEdu5?=
 =?us-ascii?Q?H/q8sVbkUbcpT3nxGul6jDLOoVvHSNSw8zQO+43YX83CIRPXhfFbGzXVE+O3?=
 =?us-ascii?Q?XtOWPzigfnBJSQshn3V45I99mXD6oIu4uwH+N7rpR4N3byJU6mY+2dPvZ46Y?=
 =?us-ascii?Q?QRIfa/qYsTWCXu4Xkqc9vkef/iwGfs5TRtcUUB9Yjgo0DNL/vefHc+44urnq?=
 =?us-ascii?Q?Mec1owiMAGQI8M7zZzVVv11j2LvnhROaG/KpfxNZDvdC//neDGW4XPIU73KP?=
 =?us-ascii?Q?jbbavD729uXZ4C8bc0rZ4U0ybZPCeTsRBJoVW1z6cKXOivf8JthxXqrdGUM3?=
 =?us-ascii?Q?Hqxu/rfjFg0VV0nJUobx9qsQ8MOE66qr4wsXxAcXtQv2+FCeYZ0C5inhQ4Pt?=
 =?us-ascii?Q?lqxNfbecF+sPRQMZrR4UA2cW31rxkpP62tvFWteAYBkb3ILio372Hjyx5UaP?=
 =?us-ascii?Q?OqADSJjGnSiNIo8stgX1FiRuAk2cHVXpRu06SYYd1lfkHmngotzkp1B1QJhL?=
 =?us-ascii?Q?AqArmcvamP2dEaXoGB55A7fvSxH0HgMifHoIcf5+4tk5/yqDCN8NiOQyVQoV?=
 =?us-ascii?Q?aZkIT63Jg9D7udZD/CTgvGWGY6tv+L4aAx6+RvGGQ/0Ar8hhdgHGVTIKFn88?=
 =?us-ascii?Q?U5A7WDv/6ANgTtrA5wUt95K2nmDA3mnEr53+m0swoTOGouXPAUEf2wi2JH+3?=
 =?us-ascii?Q?WNqxZYrjM3/FVTIPhYwD2piqhVHKiONBbY/QtBJ5OhEgCJcA8s5KkmlArqPQ?=
 =?us-ascii?Q?9/vZ7t2BJqoIPIWVD+LK5ZM6bs/Csvzn2cktHV0MWJasECME0Vcwy4ctzfsw?=
 =?us-ascii?Q?ob9OlIrqC6e+qVnfT9xIiIf5ea7cxUF6Q0NLtDbWUgEUPUY1uU78lzyIidZL?=
 =?us-ascii?Q?30SYBEwNiI1IsrIp5oHhXlIVBJ35KpB3JeAcIQBl3sdTuCo6vBo2UZ5v/lq3?=
 =?us-ascii?Q?2F/kXZh7YOoOtJBo5ByR2julbpzx/JVYZnQOfW07agm96jqW4ul6mdPeER3w?=
 =?us-ascii?Q?fR8wSlOLwcprhMiIrhWc4Mz849Xj546v7i98E5hUrWTmjqujTNWVZciQt01A?=
 =?us-ascii?Q?R5yovW9RTXrrdxiH8wLCBaKLM/juTGvtqbWiTV587BZB8XgOlHBte0juKsxf?=
 =?us-ascii?Q?PI6T+bUZzoYWLHjOpwRmp0fzzZhyTm71JUDErABegF4NlxpSkOeoiRB5oJvO?=
 =?us-ascii?Q?e+Qzdpqqm+Y+7T2nWPRo5moAfukLiE9pSyZKYCIFJqREDCXnvWflSpYF7UzW?=
 =?us-ascii?Q?ZmQe/7XsKZXB9eE3JxMS9PT8GpGXtA3rtlHte6E3dEabfAWWKuivxddxJ6QZ?=
 =?us-ascii?Q?Yp3kA9zR+O+NbnhlIinoQwOmZGNT8ZNYOWjdgEV27rRY2gM9IPH8EUPnC1A2?=
 =?us-ascii?Q?xThn0R+ZD6MuzkLf17PCPBhrDMBCM9b6PO73fxfF3dQVpQPA5tWlVPu9aI24?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d8037a-4615-41df-12bf-08da92a6ff1d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 21:05:17.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+m5kXsJQ+UXUSNX2A4GEJ6iLzk6P0EHFywmbFrmt3wtsXW/AiodYPhiuwkrUXyKoP+yr//c5HInFCpQ93rdhO6yp4XnqEV478kkqs4jty8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090074
X-Proofpoint-GUID: lrJbgcHQ3t_nrH9TVvT0h-IDzvNVUcBn
X-Proofpoint-ORIG-GUID: lrJbgcHQ3t_nrH9TVvT0h-IDzvNVUcBn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the outcome of this patch set, the crash_prepare_elf64_headers()
is utilized on both the kexec_file_load and kexec_load paths. As
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
index 1d546dc97c50..8017eeb43036 100644
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

