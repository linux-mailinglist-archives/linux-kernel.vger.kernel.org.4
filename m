Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3125B4142
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiIIVGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiIIVG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:06:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86128110A88
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:06:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289KYvrq019026;
        Fri, 9 Sep 2022 21:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/zFXaSGCn1g9CIWQpRY6y5g7ufdbnmp27yWaj82WMzQ=;
 b=wLhwwNqQsDUFHc6r6lQMyJG5+d8JVwH1dCLIlgqpbXL7Ich5seID2PUEA4m4hSPolxFl
 IQ/1VZJEn48gYO889U6hoXOd4fQ/Sst+PdKJPUHJzwygRestfLanev1hmIWYCkRGZR07
 TjteJDn8b530O2QZLHUfSvs51BJ4V/pY/6G/FifVi7iP8v0JANqvaCKzgECsvWaeeyhr
 1ZBgAyqiVITPxP4ELbyVTZxiJtJrOWu0STqvW/qZmUzwLNn6X4sFWyHIQEFhAPhy1Nz0
 EHA8bkj0S3gq5KukEU4jiwrBFUoPRc2a4A9V/N+c7O+95x/OolXl3o52wuzjF/NbMfYU Fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbcfwbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289J8fu8029278;
        Fri, 9 Sep 2022 21:05:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcfa2e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqTYWP0aVcdnEjVpEo86rd6JXD38xECbqAEFAFVcOxth94FX+3YvJU7+QSNgSL2hQE39RdHrUK8QzBQdtnPtJG+fjpnBWJmHhKNXRHgtFY5O8ESHbu4V3U3pMD2M3ZVEBIrRDtFIePZq35c28cjDul5D8QT/CFWvALprh00YCVnQpBcTQrZlFTwC1Bor5h9McY8CB/aKbVXU4Kz3B5erw6bxXl7i9jJYcxmqTZUU7hMZ8isNrLLEvgarDxF9W5wBQP4VXKGX0bQWjJFh4DISzRQsmK3xO6omf7U0ZtKn+/FVkcc8V5FLlhnuKiKI3azfugedlcat1A6JokCkDv+lbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zFXaSGCn1g9CIWQpRY6y5g7ufdbnmp27yWaj82WMzQ=;
 b=MRlSk4C3ELAUSOkc9gKrNVL7f5RzPqjY4seYOALlv0MimJ77dpcepwBHMtsOnHG8DQAHRzGK5EH5QdJjbXsVYvYtoViSV0lTISmRHEZCecKoeZYNtxlLo4Asy4w3eAlVUn17Ncjrp3Dmp5HiFMfW34JQkackkvAFgupL3S9RFUV5VvhPuXICw6xEKso8wukf5n2e4uzPomX8HqIJABm1I8v4Kb9sjGDCFHlE+/xoZMpQalUbtYOKlaBnrusWflks3VAITp/lNP6kfxXBTjv+arlA7QlakDlGjeiDVtUGPZoDaIDZe6ZWsSSP/kuDHrA41MHoeoy4vlvkYDM+psdkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zFXaSGCn1g9CIWQpRY6y5g7ufdbnmp27yWaj82WMzQ=;
 b=NxVqZBrir+WHfGmoiBtcp/dEuMAOoAoojRtfgVussUXBoPtWgYIM75Sd4Cw5ieezl/YCTdyXGoYo4yFQD0i9hp1zkWy+UkUrH68RXXDx/OdQqLIEi+6KY+5zLSYNCTBunDB5m+YFlXKytym56eAynUPNsZIOuetPAsgzeWOwdPU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB6777.namprd10.prod.outlook.com (2603:10b6:930:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 21:05:19 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 21:05:19 +0000
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
Subject: [PATCH v12 2/7] crash: prototype change for crash_prepare_elf64_headers
Date:   Fri,  9 Sep 2022 17:05:04 -0400
Message-Id: <20220909210509.6286-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220909210509.6286-1-eric.devolder@oracle.com>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: b87dc5b9-4e76-4cc3-924a-08da92a7008c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6z5qbBspmNiiVnC+7IMngK/5oX1t9LiMMhUQckQhGMLV1kiCVKOpBwoTwUQMC9jw8OU+p/NQESrDlrTTWQ+itCecHZNnrsobtif0Gu0akCxjLJdzKjVDs/jt5p5S9vRaM55CRViKmjzNvBRfnbEdQKnijFKmJYGo88Xi5Wqw+WPqS1Wo8+nasQ6jHvkwwZVLS3ClUNrjf0B7MM4DHvpwrz23nhsWvlSTPNKnAeQ75Hhut+YcnrJIfrMZA7Q81GZG6sGTm252PARqBOQ7axF7PLgeJjo4AAcKSXhoNim/34QmaoMyb4xgu1H5z5JcPN/KdWGc71cfi/hRnWGKVUIlTxqCfR4z9JBzbIhE3yEkWQsY2/En05JRA48/wFfp2+ptCEMHbWtsEWdkoW+/W3JFjLs07T0aS3axLeGpgKSjkVpnuy3GMJbxM/7P4Ta0tZJeijhul/BkxX6xPbN9+cURsBiR5/sGi7VLELjiNkjvye8FRrQqnehsut/pbkwHl//uXe3FLhfs/fNN9DgWBCSpGbf3I8wapIwfSefMKE3PLd1vsTJAqR6jWqY9qAST0mHmPrV6JdkbgJuDXnQOWQ5vs08quO6Ew313TSBR2nFtMrVZqACZ0ZDZyxP4nAczUa59GCn7dT+H4/jOfjPdbqeAR/6xbLLBKCMDOKN+DcbkeImjQy6NLBpDfYcr3Ax23xdrRysHntQqr5ftFMQhtpUeuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(39860400002)(346002)(26005)(86362001)(6506007)(41300700001)(6512007)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(38100700002)(8676002)(66946007)(83380400001)(66476007)(4326008)(186003)(66556008)(2906002)(8936002)(5660300002)(36756003)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vf6941rQVdDaM3wBsF2HdG3TPjXw6C1G+0KqmsW4eo6/zemt7u60qLtes90T?=
 =?us-ascii?Q?nlWNE6nKVKs/r88SM7vQSKADkmie+8hsPSsVesj/GiNtt/TAIHwofS2aVqgV?=
 =?us-ascii?Q?AWlQqi/wljHi1yAPLfaxDCxcSkJVh7Idk68Ib/BpZswSowooeuHIvOfiZAS5?=
 =?us-ascii?Q?QRxOCQBFaUe5Oufg+C1hyreMJPCXZUh6UDWxr2sDt6WYhjou3OiiuGUsUkxj?=
 =?us-ascii?Q?aP7fNmR2zhtQj+H9kPi6CCVEmLquJG+oZfeD0FEroQvpfWAHkZjQnDl2BmDf?=
 =?us-ascii?Q?Lb86TQgrgxKkef+wCSa8n+S/ZQbcb6n4mp27j3HTEjSQJ58QsshHT3o0Ts3q?=
 =?us-ascii?Q?bguXlySN9CtjLT5Gte5TLyXZnmYFlm/Ss5uwZpTrGyqMMaN3RVGgojt+k6t0?=
 =?us-ascii?Q?9VHjNZJwEGor9hwtAEjkjpqnObhcm1ZRN7x0ISotHDeMXDe9Vw6dCi1qHrxm?=
 =?us-ascii?Q?O53s+lkQ4VX8YfPrKlLGUxMZrGd/rFlgFnZ7da1+DCsW6ZPpMQMfDmI/xlY7?=
 =?us-ascii?Q?zrQusvXmTsuOppZua2MOntPajGNOLJmCSh5QlXMMyjI8yUlVn//yIJgYRKa1?=
 =?us-ascii?Q?Vdhz3pwQEOHHXGgQddvLf0PcmyFxRj5hf/d2QHP8gZn2oQmHMBCBsgKPekbf?=
 =?us-ascii?Q?Ux0gOHEwRjwlq3YPVfG00fEWACMHr6FbCPnTjGJDEbBtSqiQKdZbjRjjeqJR?=
 =?us-ascii?Q?FCDqzGm9mWOv7OF/n9RU/fkcvoo6dIwPFvOgcoZv1+Swr36VXmfFC3PF6Qo7?=
 =?us-ascii?Q?oTJVRI9m2q0ukW6ctu5NtY6ej5ebFBSz24dcxJ9G7JUiQ/unwGV8nNJ8r03i?=
 =?us-ascii?Q?F0pcWL3amiT7f9zNJqvIOQPv3iwYKWbZ+RdBkT8JVz2Jfsglq3LABJMXIc6B?=
 =?us-ascii?Q?oPNl8PR5uV0FDNZkqAmMiREqkI6uKkpf0uFTOyQg74YXVanyqQ0L2CnWy96+?=
 =?us-ascii?Q?C8wjtge80/2n3G0RjEz98Es90l2S6zwh+C27kL02lE7t80KrfUy//IFz936K?=
 =?us-ascii?Q?LPa934266OP77OEg9WY1wEehNYy4wjsWg9jfl13VUOdfEWeLQ/uuwqMCZJuA?=
 =?us-ascii?Q?uiP4UaBq/PSfZlKpleFwaYMrqyL3DIjGWMGeiUB0sf6Ej0CSHn+rqr6UPqHU?=
 =?us-ascii?Q?PYeeXNj9FNpvDtWtoXtwGEgWOCJd9qadJOM4/xQdmYZt2xWcExPNLKJBfjeN?=
 =?us-ascii?Q?05Wz9a+hyQ10E5Twzb4AkDL9hoSadgPxHilwp/dhWpHyuhYwZyiqP/sfpgIR?=
 =?us-ascii?Q?V7jYhozYUSIIFk5BFUXXs2+aFwh363l1W3IFAdqpejwmhzQ50bTKcyK1/jKY?=
 =?us-ascii?Q?RR2GdbzkzmvYmCBRklydyETajdEtwSYXiTadPrqW9U9uvFGzzApv8gLZjqBK?=
 =?us-ascii?Q?I3H3oxN/Ocs0q4Jm+rF1Hy4nnfHRCpfnrakpGe+rWwcouIOZCox2/LdDnbPe?=
 =?us-ascii?Q?WnOYbN4xD+Gmx0YUAtgI/ZVLdmI4Kz1/IJVlZsfBAaOxklf9ks+YTzenxBtF?=
 =?us-ascii?Q?kazSvYjF/lxSVX1+mu/F7JLXzAYL/wWEu09f0AqBH7rIoXoACU5kfh/xVaV6?=
 =?us-ascii?Q?dagR78QHStvP5Q8w8SnubrOvCRqFj9tca01KRVIFMTCg4ZZvCXXh1GKMt4d0?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87dc5b9-4e76-4cc3-924a-08da92a7008c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 21:05:19.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzTg0YzhiOKSfIoW+WyUrHB8Wvzq1l7KrW36xlkzt3xX3S+bRBzJFgcCOF5xAJmJlALVnbYSsZGBSAVmwbsoG9X05l44WdfKu/pHK9tNIOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090074
X-Proofpoint-ORIG-GUID: sZmfk6hhM-k8nGCzslKv6fyohJpUWvz8
X-Proofpoint-GUID: sZmfk6hhM-k8nGCzslKv6fyohJpUWvz8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 13e6c4b58f07..4eefa631e0ae 100644
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

