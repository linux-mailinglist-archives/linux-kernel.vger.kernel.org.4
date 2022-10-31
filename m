Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1F613E63
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJaTiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJaTiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:38:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D8413F2B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:37:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VJZ74f001187;
        Mon, 31 Oct 2022 19:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=yO1Bb8EkmaYNrUwXwWRdRFTo+nQ8wWUK08fUE02PIV8=;
 b=23obFGanWIf1ZiC2x0/nFA6E08sZJ6pf90MzEB6KJ5ES00000/NRINOsU6EfTiM0iXbY
 AWk+P+UhDOR27EaRRy+WUXW15k+ianjY31sa/S9nFi6Ul/JHWXFu1vP4iTXFA3kU2jiR
 Z632MAYm4mJ6G00yrW7w1FcVjz8zA6VbIiPv3KbVUtR3U3D2EzXmSBpuq+JWzYaVpd3O
 9EYL0mJ/knhZMeIfNi+IeD4f+xOrLipWTywm5zxPDB6kAa0H9uobQgoLl3/jnxPrCCZm
 xHkfiD5pSzlT0gOacIGp5j2uz6EXZ430yHjNtIcbpfiTfOndmXR+xcre0R/0orv5VV+k bA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtcqu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VHTitl032833;
        Mon, 31 Oct 2022 19:36:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3mptu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+coDbCC6a13hFzRj96hzwHZImcpgNl9/e1tOdaMDwzHxNYxAn8AiSQWKcmXVTX2uc88EKlFFNEAnOwH4T/POhg7lrywTllzW4QyTwwsOQc8/ZdqpphjIUf9zL2871yKILOPusaMhtMGzceHaR8/nxNcZykn2/ZTwe7QEV9QwRlWyyTnr47DWbxSSpHkoB6A9cMS9lvUCTDtQtKmo1u9pKnL214MI39eEZHEOsjTwd0bDFEdaP2cC9qw0HktIBTec1l8ElQ8R4iXbO0LXvO1Fle7FD5THCUCLmn6PbANou2/Bx+t8cQbKaehr4f7lXuPvTW03AWNRVQzBZm8vfkOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO1Bb8EkmaYNrUwXwWRdRFTo+nQ8wWUK08fUE02PIV8=;
 b=DwI6qSuJ4s8U78WBvTJb0Q0zkvAcdiZrr+Vuf29qx/v43lFkbh7sjXVBdPTXkGia4PzvCP+tiOrIR35+SolMRc8c9gm1GsdarU1sQGWFrTz/jO/2LLc5+e8HUZzwPfcUHUB/X3ftogjhiiWrDCrm12HDt6kO7k5evBc5VNMf/ucwMcdQWgcWXrPkb5rS4SZf2ETCL5f3clldq8ViYNanfFpXB+Swgx87Y3O2PROJ+IzEeErrO4YNZAFVZl8fzWVytsBUvXWMRPHLH18E4MCcMvpIVo3rojaX1hFraG26BXw2Vhb0w0THirK1I5INF+vjUbYF/aM6X+/PxoevngmxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO1Bb8EkmaYNrUwXwWRdRFTo+nQ8wWUK08fUE02PIV8=;
 b=YG+RLC8I4SyKreKRaemiiwj22NHUgbXrOPveg6t8tZYj2F/VfvgZ25PrVPX4fQYEHiMsQGyGZxmzlZhAEL0rdhuWye2ueAGDaMvocYPBCkCTjoIBcSD5MaJE+aatjWEMvDtZJ+wL4bTXY7AxkJ7kNvjgItsIiL3r1yPMsupVGJE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4228.namprd10.prod.outlook.com (2603:10b6:a03:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 19:36:18 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 19:36:18 +0000
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
Subject: [PATCH v13 2/7] crash: prototype change for crash_prepare_elf64_headers()
Date:   Mon, 31 Oct 2022 15:35:59 -0400
Message-Id: <20221031193604.28779-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221031193604.28779-1-eric.devolder@oracle.com>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 917ebe1a-f296-46b2-b772-08dabb772e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pa3OMbucjo5Hxez5ym+MOpKLddQ+LMgJCTgSb1FcrXjACs9Nam33TwXBYg8jfZb+KXDgp2Xh5gj+MTlZVTNC7crRruu9L5C9mSIOKJooUwnqWXK4z/RyVE6BSp/a7FPFSRrmxx2OJbWozWVg1ps+zMgyUFHFXYkAIT20Gje8GNn7eg4n5uJjzXfDU5jP8nFRRuIq7D02BvqUGG9QubgxhC4XjgLmy1R0F0GycKRW2D5JyEV158UTVsMY1Sb5ODYEBcJ4dtkWN2pSY7OrNAtv/KsWDRaXoO6j4XCXtDZXaph0Zt7bUiW1z45OKXxUi9ZAATSYdXoC1glbCLBqxOI2hDlcjlLRaSHM1SjhR87ZfsAYRKmLRBrolqebZ/UXjum7m/6cL8THVTB9Rp9d7zykH5LYRiMyrd5me/NGSpIrLGmRVo4adGzkH5BDkFlhXxPXRvC0EsdXYqqIIi0IewbwQI69HvfuidAmhqYoHavNP1xXLozsZdK5GigtrTCCOuLOdVPBhxhPsLTZxZQgBHRgzGJeuKX/Zp+KXCGH6F+wOgJvamlXQ2FloayZVFXN4FX7BVToyxiSqzw0bOWNk0SBq2TnLOytHToHOFpom1iAAdcvomVuh/Sg+/QWQs6xPNkS6KPc71z8f6eDNVU5fXdLFVxWtZC6gofDfTrE80HnC9LztQOPWmuww8BAsbbjx6VP8mM2OR8eA1rkaoI6iijkiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(36756003)(2906002)(86362001)(83380400001)(6486002)(8936002)(41300700001)(7416002)(5660300002)(4326008)(8676002)(66946007)(66556008)(66476007)(316002)(6666004)(107886003)(478600001)(2616005)(1076003)(6506007)(38100700002)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6LQbwsjRXFbbyo8ON5SmZ6B9KkuEC8dNeYQQbsa2C2NqoYje7p5ESOoI9t9C?=
 =?us-ascii?Q?q7IzrEN49jqxDQVEBmTBWr7uu05jvk6Qo+mJakGhkHFEM+jifo23xjYFNHXB?=
 =?us-ascii?Q?7tipI5T2NnDgI2gAVhsT9r9JLBdlR4TtqNYiTUkRkZm+kWZqtilivrpjvWKp?=
 =?us-ascii?Q?MVzT2tt3j0MI4iLywtM/RYRUxJD8GfMSIIovsl7Jl/7rjPaR9ATlGOQ0wznG?=
 =?us-ascii?Q?BD+IxJY8bWtEwhK3FNIIHO5hrRJV73z8ZQv5hU/pZPMXboROExSwQZSgZ7nI?=
 =?us-ascii?Q?Jfl8mYqe+Cldi/Ox6bXlU06y+X/R7qJalLVpNaPp3jzSNAdwIvgg+2Q0AdLS?=
 =?us-ascii?Q?yi7/4++trgn0gkuKjYViaxTjTHBya1edhgnVX4KHUS/sv1xJVajJRqO01aY3?=
 =?us-ascii?Q?39qPUTXNDWGOT3IrDDqz6dGj84YY3Y746iNiEiaJJw/c7DL+Gpry0OfhRcAY?=
 =?us-ascii?Q?Cri8+AuyPnOVzEro16RilI7aXDYWWnmPTdnDkxLGeeGSeqj9dOPwpyq80BQL?=
 =?us-ascii?Q?s56Rgz85dg7wtDvVEKdBxn9FFVxEvCrUwXwtBIBiu4sQD1MJdDqIFJSlt+Gs?=
 =?us-ascii?Q?Q4no1fWTrWdCG7ZCsly+fKXNjT+dU/7jkidBIae6YAQHnCe1Jhgxt/rN/eJD?=
 =?us-ascii?Q?PjTr1mpFFaV3yEIoHR/CdmRITY7rQlwOgUbgz2o0Lwr4j1vfRvrJDWxav8/e?=
 =?us-ascii?Q?66mWvAvzIO+yTyLB7G2wEJOYlQ6i/vAvZXvW9KlnhSl8maRkD7gWUiZ50Uy9?=
 =?us-ascii?Q?SCXDDtFIYH+0CkDxFxzQHppnHbc043zO7fQmjzk2a7D7hnnkup7O9XmsQB+/?=
 =?us-ascii?Q?rkJrMLZZHssQiRg8aA7DtymlheE0eb/8CkIh2DCATDDydO5vyHhnO9AwoqMn?=
 =?us-ascii?Q?RY59XC+H83wytfJTZWSG9SYEozgfeHX3QRl5lrLnT0NfxuQKs/rI80Q6PZMA?=
 =?us-ascii?Q?RYv4DXmvsNHndLOWcgrB8LrhPLYwvDGwpPL5OHgHuIUMjbDiXt3HlRWij85S?=
 =?us-ascii?Q?pn+rVUNv8a8TxP+6EbCiSMZfSskPGOl9+hc4Tj05rm9H3Y9oJXHsQ+TojgzF?=
 =?us-ascii?Q?yx07j6l4QSaD51HnIjgwxOxPd26sDzoskGSUrKJI8BH7n/nDz7PD3kSOkNbv?=
 =?us-ascii?Q?TV2uW/wbuMcq3ZTO3zzW7AxoLp6nvmYjtqdNshhatdpuv+jAzjh3U/cgkBbr?=
 =?us-ascii?Q?dNvCl+BWsyHtflhMfRlLwt6E9vRGbysfwZW29pxU7rKXNKR/sKdUq8Q/oIrv?=
 =?us-ascii?Q?lmLJUijHL4gUOi86BJU7bk/Kuc2BipdlJhF8AbJohn7F0fXy4rB5AVIJeKYU?=
 =?us-ascii?Q?/gXIywPjLAc0pHduXs/uNlo+wLeTFbG2sYK9Q9FL6v8tMTERjFYyHoLV6TmR?=
 =?us-ascii?Q?rvrSZilBqQc16iFYDkOUE9/KGZWpFqwgLr303ZGGPeHmcPMtYioQ6RQOc75n?=
 =?us-ascii?Q?3Ze7rQrz4LdF7D7uEpXmXhgMiL9lfbu95cfEhu4aDGOTetWLFSKDLAtUTvrc?=
 =?us-ascii?Q?OWIAoRHnAbCPE5hibVg2YkoU1XvJyv7KcfjYUwo31JzKZ60WGUm3v86eFuMb?=
 =?us-ascii?Q?9DEs5pBrmUkGHHpjfb+MFDmmwW4z7pm/BDNUtnqs2bGZkxsekfAsuk1Ci4PG?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917ebe1a-f296-46b2-b772-08dabb772e56
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:36:18.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGP0WBtnsc3YmvkVBO36QM2EYY+Pl6zPr8j2sqjxP1WFbqIeY0x/qEw49oxr2Te5OpuW5AhcnIEHDFzdmhqFehDt90HZpGjsXm1zCpBiqmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310121
X-Proofpoint-GUID: xDLo5f19KfEkRHxxD1Q_EuYP6ZAltvik
X-Proofpoint-ORIG-GUID: xDLo5f19KfEkRHxxD1Q_EuYP6ZAltvik
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From within crash_prepare_elf64_headers() there is a need to
reference the struct kimage hotplug members. As such, this
change passes the struct kimage as a parameter to the
crash_prepare_elf64_headers(). The hotplug members are added
in "crash: add generic infrastructure for crash hotplug support".

This is preparation for later patch, no functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/powerpc/kexec/file_load_64.c      | 2 +-
 arch/riscv/kernel/elf_kexec.c          | 7 ++++---
 arch/x86/kernel/crash.c                | 2 +-
 include/linux/kexec.h                  | 7 +++++--
 kernel/crash_core.c                    | 4 ++--
 6 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index a11a6e14ba89..2f7b773a83bb 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -64,7 +64,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	}
 
 	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	ret = crash_exclude_mem_range(image, cmem, crashk_res.start, crashk_res.end);
 	if (ret)
 		goto out;
 
@@ -74,7 +74,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 			goto out;
 	}
 
-	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+	ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 349a781cea0b..a0af9966a8f0 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -798,7 +798,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 0cb94992c15b..ffde73228108 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -118,7 +118,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 	return 0;
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image,
+	void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -140,7 +141,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 	if (!ret)
-		ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
+		ret = crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 out:
 	kfree(cmem);
@@ -212,7 +213,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 
 	/* Add elfcorehdr */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..9ceb93c176a6 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 41a686996aaa..ebf46c3b8f8b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -253,8 +253,11 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+				   struct crash_mem *mem,
+				   int need_kernel_map,
+				   void **addr,
+				   unsigned long *sz);
 
 #ifndef arch_kexec_apply_relocations_add
 /*
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 46c160d14045..8c648fd5897a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -315,8 +315,8 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+			  int need_kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.31.1

