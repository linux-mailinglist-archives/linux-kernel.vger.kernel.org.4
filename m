Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A0613E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJaThQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJaTgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:36:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74C613DFC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:36:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VGxI8G001214;
        Mon, 31 Oct 2022 19:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=4FuJFOdktghNoyHGaLWoA78CkTP8gKQRefEyDrRVWis=;
 b=k+1Id/uNZf92wKS+yrcxDa3Ro8rN9jq5NtMVkB1Ywc/Y6KIdKUMo2pSU4INW2qF9EW9K
 3UAoLzhC5Ej4OqBNLMa10wKacnaOWA8WvTLF1kMWP44jyn9dhkNTkyoC6y55KlsNAcTM
 Qfva0I4DtvgnAn1Ss+OqnevK8C+k0cPGBbCh38L6HosJ6nDtz9dGuIGfSBdN3NJ3lzp/
 6bhGcNCf71QXUoaPeiOYBry1zKXUXq6u6scNxiaf+OnIX0tTUlyBdYYSnRq43uIftE93
 InYhrKBnWlfRxVwX6nNpy8bb5hmuk2hnzBO5B8WMTL2Z2fNklhSvMG3+jsz0htu8B5Rw Ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtcqum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJXEkd033125;
        Mon, 31 Oct 2022 19:36:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3nkfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHxglbmK+mTVOZnUxaXIzgAIwZQqMVDEDL1HVKXC5viy0hupd/ATY+Gt2vIo6uBVAsnMYx1jG12dJFaDs0uWfYsiOmwE1XzZig0XQwnR5eFrZ1fs9mBEZULKyxjbrtxEglsw3dAZ2dnFIBP2KIxuguM7g6ieTL0lW/oXiwCqHj89TSCo83GweIG/H0R6CQqjDpalXR4DlTi1avGNJVlnTSSOMGADUbL482e/MpRwblSJp6ybqZITjLpMf7F8ShbPvCs5rwdBK4rhf0omu63FzQpEeD/YySMC6Y+MB11770mfmsPgZLwJ4mgTf+cDLc+LjnIDtR/6zWfzYwx0811SSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FuJFOdktghNoyHGaLWoA78CkTP8gKQRefEyDrRVWis=;
 b=SBtHW0kkJZF41D1sHr/AGcKQbFJXxzIpZ91U0E2sRdN+NffkmfYbuBJusu3L/muTIB/3D1gec3dOFO4boSPDLicLdxH3L50m+1Y1MbNAAKFv7rodIRkRCEuiI5nF/IOtHxbJHQDcI2pDRbSiR392f0GbDP/D58CgM2jibQDEBmNkc57xR80exJKK0Csjbe++SuOFeOUDqA4pAci2jtzvyI4b6Dq9NX8kly4/d1luVKbUKlAGTlR1RdC5Gbu6DE5OE0r2XGwIso6JToYjL7G4FJYsMvLSiMpj3CkqW4IhGpUhruvE+y0z13pFhnHkZNkzmAxtBAZMXdGdRWgHyj85YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FuJFOdktghNoyHGaLWoA78CkTP8gKQRefEyDrRVWis=;
 b=rvdiCCSYdsYG31eNkg7KXKlDbgl4cGiVNOFaWEHhRAX7KdtM5Au7bc70f8zYdaxLZBsCFOx9yolUCzUyNPUT8zvWwdL95cwiFFMKTO72mxyRaC9RVHJl5t6pDd8frgAlZchWzgay8E6pu1JTQaBNSLCVuZRB57we1kFi6esyLW8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA0PR10MB6793.namprd10.prod.outlook.com (2603:10b6:208:43b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Mon, 31 Oct
 2022 19:36:26 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 19:36:25 +0000
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
Subject: [PATCH v13 5/7] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Mon, 31 Oct 2022 15:36:02 -0400
Message-Id: <20221031193604.28779-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221031193604.28779-1-eric.devolder@oracle.com>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0194.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::19) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA0PR10MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e334e2-2239-44f6-91fb-08dabb7732e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Uy8IZSt817Bk+cOHtitjaY+BH0c9+h2diw0+aGHLwkPdmJ6tEDP9qZpvkqRTnoT8WlWmjm+6it8rSxcgGqkiX7IEvpLyO0vW4ZqCEJfl7+MHkdyGPNQwlpJSUWnTTe5BfnvPw6dl2MZ3sE9whn+eOcpLxL94pbrKC3pcRmfJi009kah/oSnWNfNPZEd1rh5sQLTNnNsG7Il4/Wd1Hqc6+/0FK4QgDl1SloMSaAvUVwMf/8ixIEYLVMRb9XlEaRYnWlWArisZawzBG8P2622Ccqmh9RBPdDgUZqzhYx2W0qoraeKL30EscHNAJKxIYHC4RTzhD0SPdP/fSmg+x0B8KnNkwjE2cGJM+bD7D32Ne4G32viOhOxi3YTQEQBqDIW7PvsgoEJYNF+1ssr4M7mFeruHAV22QB3SgNlBjIfIWolQUyOtgPR+aRd4lNj+YuhnH4Cfv45/TNpwc2lVmPROMYkz+tm3wShCrkGR4NVOJh+DgnozWhV73xyRCsgK/gobGZaCHf+eyxppnIpoQO7J7hrBrQ8jtOa9cqyg76aMqI1fscMM+RH5vQWO3f91hjYuAQamqSqrEpNcl2GFQOMHP+bsp9JLddZ6p8OKpmVnZPocu6w6X2i2p2kMMfPaXjoTTdiZyqAZkFGlpRYAU4W9IaAXL7gVM72DiJndTl8sKqo7X8v/LfuDPo3YVtUX5VAfXGQ2NtiKaLkG0ePWo/lew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(186003)(2906002)(1076003)(6512007)(6506007)(2616005)(6666004)(83380400001)(26005)(107886003)(7416002)(66556008)(66946007)(41300700001)(6486002)(38100700002)(5660300002)(478600001)(86362001)(4326008)(316002)(66476007)(8676002)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jrHVU+0zayFPw5PodpnqM2TMLnUTS14P5ecG4XMBzxiJ2Qtc+lPtnmFTJgiB?=
 =?us-ascii?Q?hsU+/E4vfnzOmY72aaAS04nBBMjjuKPGL8jLBFLaFFE0veYkS0aCQIHg8i7p?=
 =?us-ascii?Q?JX5rzP9c2Sz8zp0hl1rt0481lIN3iBitctjrUr83DHFJbwap5ko0bJJruLX1?=
 =?us-ascii?Q?IOjRA+CinY3tTmq+Dkv8InXYwYs3jt98PUYDwKjEZVm0ssarAMudJW+hcNLZ?=
 =?us-ascii?Q?nbVx0uEf6vYv/w+di2Q7LKcbu58X2bI6I/9lO0OgmplBionEbDHBY4vnuqMe?=
 =?us-ascii?Q?mo8iw6yTk5ZjZb79Ag1e22o0di7mIJ3dHF6TB8iAyzg9DBIEMY3QQSWuLVzN?=
 =?us-ascii?Q?tYZn0NcaYaTyHzJRjjJBzpPzVZPtXoPAHjvFvkZjzxX03bGdHco50zx16tJR?=
 =?us-ascii?Q?kDlcpk0hRj1Fa76ANjuHnym+AVi8zMBJGilvO4MjlOzpqCXQwDocMp2sTnss?=
 =?us-ascii?Q?FfmyfAwaipF2iLCopmiBRlieXCLbfIJTrqn3DdROM7yCUYLwcrsAFbPYGk9d?=
 =?us-ascii?Q?6StaFZeNCXSN6aCK9vsaD7SfTEgiOdnGZTUkWRaCeiX0CkbFPALPyc3a9uVN?=
 =?us-ascii?Q?kwywhvYrGrTWl4fbI7ZgSE3eyanhIEILAhld4Yzu9wQR1SgOOszybuaxBOSm?=
 =?us-ascii?Q?pPvgpk6CtjKrdEDp9f5vCkIBGMVZuuxmQKKyCakAJHh+5Fnq71Ez3x4vC40W?=
 =?us-ascii?Q?NGFREFA1+XvzNdWaY+MEDNSitBWVQRcNS/oBDGOXoCScYOvy14MSJBjKuTqF?=
 =?us-ascii?Q?TQAGEmDdmYCqzkb6jXT6uEOkBTJKNyFOsYxZjH0XD1NNKAV8kLpuJyBfVWxv?=
 =?us-ascii?Q?Bu4k3AZ5SqNmnNlsK5+HjWTQ39yFMMpB2BOi20Hs1sCWSUn/3jqJc4VUENHG?=
 =?us-ascii?Q?mW9EX39Fs+HCzb6Hzw2M6lNinXgw2t9yuR7JJpGMozF+TeJC8OkJ3nSWi60Z?=
 =?us-ascii?Q?dU3pg0nMf2OeNb88NrvxEVCRzIL3UF7VZM9tl3DsunI3Rmpc/LdulqaNpCW/?=
 =?us-ascii?Q?zEDFNz+Pc+pyv8KwALZj7tuW00S8mV/nt+hM2LjALbLSRLEblp4eFSeBOjc5?=
 =?us-ascii?Q?1T2lfYBS0PwS9F11b6O5AsKzHNQcwT38CeaIRex1jKAgQ6d/BJiF0SMzklRL?=
 =?us-ascii?Q?en9OlEyBPpTlG3+Vm15VGPvLXTNLEAw5iN3dAchdmCSC8lgiOMwmOp+7cH3t?=
 =?us-ascii?Q?3yAufCCbhq3cxvf+2fDIs0cXP4s4I7mHeSfzApIztHA1diBi10E4VE6r3o9M?=
 =?us-ascii?Q?fO9WROXAjVgy8JEaDm3tWs47MmPI5CY9WqyA99rRy9uFLUycUNEJPaxdFW/0?=
 =?us-ascii?Q?D6rrR5NZhdXUZE+FpdVhCz6D/qv4o9YMTWAR69RhGBnvOddS3t1e6+rM95e+?=
 =?us-ascii?Q?4swLAXvxfDwnFTWAWKQ21aolz6QQHB+QEkZLdKxojsiJ3kn/d7yw5wAVN6lz?=
 =?us-ascii?Q?dXAbTVF/SqwX3hdRigMTdVcC8lKL0YC47Tn3Tr6uM4dY/tiK78Hw+2ozWOet?=
 =?us-ascii?Q?XzwEGD1cAlmiwjYp9rfzBt0qiKn4jimNqSSBLm3lpUu0/dXL9eqXHae96mp6?=
 =?us-ascii?Q?lxfYzaJkELwvSq0KGf1nsv1VRWySiQOv3EsMQmScDtNwYKpQcj5/dgJe747y?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e334e2-2239-44f6-91fb-08dabb7732e7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:36:25.7916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80CKNwEbECAYYIzBT/A0AOtconFurazWrzzfmblwjTlZ3pmqCLWYqDn7c+fArXOcdaHZvrc7z36lftn7I8LdVtjlYGUZemxtGlVP2vnqWwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310121
X-Proofpoint-GUID: 1wypTOrUMJNi4lIKITGoEIEEdk2rWfwY
X-Proofpoint-ORIG-GUID: 1wypTOrUMJNi4lIKITGoEIEEdk2rWfwY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
handle_hotplug_event(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in handle_hotplug_event() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 3a0ed4168fcd..bca1b198d9e5 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -366,6 +366,12 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+			/* Skip the soon-to-be offlined cpu */
+			if (image->hotplug_event && (cpu == image->offlinecpu))
+				continue;
+		}
+
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
@@ -684,6 +690,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 			/* Flag to differentiate between normal load and hotplug */
 			image->hotplug_event = true;
 
+			/*
+			 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+			 * this callback, the CPU is still in the for_each_present_cpu()
+			 * list. Must explicitly look to exclude this CPU when building
+			 * new list.
+			 */
+			image->offlinecpu =
+				(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+					cpu : KEXEC_CRASH_HP_INVALID_CPU;
+
 			/* Now invoke arch-specific update handler */
 			arch_crash_handle_hotplug_event(image, hp_action);
 
-- 
2.31.1

