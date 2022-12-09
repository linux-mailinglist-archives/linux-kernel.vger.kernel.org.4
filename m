Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133266485AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiLIPhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiLIPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:37:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3391012
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:37:35 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9ExSsD009234;
        Fri, 9 Dec 2022 15:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=yO1Bb8EkmaYNrUwXwWRdRFTo+nQ8wWUK08fUE02PIV8=;
 b=g7pP+qd8D9gbPLOcUA9eTBoYD5z9k1Bds2/Y7V7QpR9zvLU2YqNk9O7nI0HAkUUCqQzs
 JG268KsnAeni9CMCffElOJGnWDLqKLC+kpZT62/3v4TEAhmboTZcu43C5H5QfAiIjJCS
 v69nbbHzt5w9j44cckMvTrRGlWAXrjCaYe8Ea5R0tA0/W2fNWUgjDgV4GV3RLR0Z9win
 +pf/RCfl6om3zEc1mJ2JYNhKEFJH77tIyATxvw2W2BSA39+qIdVOLjG629T9FKkH56je
 ch0ug4Plajc8i+9H32ySVxnWebKxitU6T1f79GHArGpAB2Y2Izuz+AlfVrlO6C2AGhIy rA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maudkdg0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9EASNB006731;
        Fri, 9 Dec 2022 15:37:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa81ggu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sengmk9FmPMs5j3O25NjLZzyCDZ1R4VmGnJZZ5fa6Bu/PtmQwrZXfoScPCKydkQ86cbF6HUetCtcMLqVeqEPqODh2VS05ef7iypigzJs85GJ1rYJ9LvlM2sXgQizBX7FAp5nezXOq5/IjnySWr3fTbhDS3QPS8KgX84OfK2YgNHAbEoqpguykxRW8aJgrmkQF4CYkwmNMXFh4rp8daK/tz2RI05acoj+P+7lOqGM6yb/GqXD/QeuXztWajOM1mPtZCRj0VMDx9GMIeq7+12nO7xcE5tfnnUDKbqA4ybdsj0m/cSh5z+ILhjwShKwfnAGkdq6YIk0LaYR75Xh7bIsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO1Bb8EkmaYNrUwXwWRdRFTo+nQ8wWUK08fUE02PIV8=;
 b=YoOBdlNSG94qa1ebJboz0Ok76baWX8/fhMHIwQXQQiwi/KO3xvOPesO2LlJVj8COw/vNX6wiA1yKa+9WMxHtBGl80YQIm0mrWOZL6cbB+LWLsvH1uIZjZT+tFN7htYJItl8MibObdfQYT70VLATuc8OBT7fRRvnoBOBhOx0Is0js8s50P8wJ5MrGJ4LUcAOuLJdiFSHnYC6U7MxJPCiK6NCnmeUsNIUQb3pStTT5WVObDwnEMN0uJerHyx5ODuAf0UIOiI82RhLZ+7v/KZynS0ILpKK03NCQHqYpmFBNAKCmgUpWkC7/ojbvAknBhY3fBZ8ZuqmUagdrQfaupn1grA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO1Bb8EkmaYNrUwXwWRdRFTo+nQ8wWUK08fUE02PIV8=;
 b=ANdfiQgiwNGwoE4iY3/lUCL+Kom/0fDeksOfd9y9AcUcJuAgQFt2PdVq0zIlt0Xt3NUya4NDnlQ23/19Pu45D0yEWNfJ4jN/vrX7ysa24BIUIj5qeR4BTJTuXHh6LWiXiTTxwsLN2EFL1tCl8Ru98zdJvks91DvfyZK47VOSsxs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA2PR10MB4666.namprd10.prod.outlook.com (2603:10b6:806:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 15:37:10 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%9]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 15:37:10 +0000
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
Subject: [PATCH v15 2/7] crash: prototype change for crash_prepare_elf64_headers()
Date:   Fri,  9 Dec 2022 10:36:51 -0500
Message-Id: <20221209153656.3284-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221209153656.3284-1-eric.devolder@oracle.com>
References: <20221209153656.3284-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:806:a7::10) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA2PR10MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: cb520380-ac98-4b9d-1c40-08dad9fb3c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GdGT+WobPAJJFkeZA+3qlAMUgyiRs0YyEIFrQ9zBs/Y9imGvAQYevTkQkEM7OfTb1OdnLbZbeeCnqw2+E/OG/pC5YW/m80/Pow1zL1SSI8Vs05obBOAWe/+rVVAGgYiTgOdBzO9rRhNb8fA4v0WnXJQYM7VB2vrVpRUzI+8XLuJtTgipk3WY4KwG4OIWvAZ2rFIdCHTuWVeqjxV+ADO0+2T/b/xsIcCuW6uklQOkIlSkIe15NY9Jf5SxGJo2wnIxoL+j6LUexKUMM93wxEEOAp8IZ3kNCUW8oZ9PdEQ7jnzZCILKQZTQW/hgAmeAcX11QhMehACIZEaqA9AgCHypTP28Z9D0Qecm+/HH2kGj5o1s/ZJuHCb/H79TFx3YWja7lGhElkqHVhorwFJuXlkK4Hr6AlTF66rnjuZ3yCOLCUy2DJJxNGG7ZcGqmlszdU8/VIoNNcUG6nL84fBCQCWv/qcU3bVqTSRMqZn837fnUnvbG1lqqmpqwf9Mcr6LdidI+QY8YqyAYeIzEBUDWpYacYdAlgjAD9ZoDlTEo5PYUrmnXhzTtcltFL7QpzlyvDCR44JEp5Xd3PyMVSp7dpUY9gBTEVSX+2KdP84OgHZfcT0d3Uts5rfxWrjfw0uHtsxlYDtGvdD9qB8PeNseavQA1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(107886003)(6486002)(66556008)(6512007)(6666004)(86362001)(66946007)(8676002)(478600001)(4326008)(26005)(316002)(66476007)(6506007)(2906002)(1076003)(2616005)(41300700001)(186003)(38100700002)(7416002)(8936002)(83380400001)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4YAeUxyJHZ4DjD+947a3VY+Sm5Rc9vsL6o7IMUymn7FcZiBJh+6shiomKm+J?=
 =?us-ascii?Q?EnZOeRx6VV3Au5DKc5Vf2ZGKdc3Rq40paHrKXCFFkMNW1HPEEYPKhH/cL4VC?=
 =?us-ascii?Q?8iZ1lrVMyJzwyRQRy/ikNo3b3LwZGNwwXcNGVmFHJsLV5TXifwyqstnyK3E+?=
 =?us-ascii?Q?eTEmeFgHqI/fUxjwvlQp0EFtT00E7Ive4DM9kOC+3C8kXVbbQHp9QZRcTTeS?=
 =?us-ascii?Q?LCdxb6rkWyZCE5lU03lyG1fLzQOr6uBp6urORHrii2n2HBjTqzsTtGtn8qSJ?=
 =?us-ascii?Q?GAsXGlRUjhBNdKGsdMrgQYAYe82HVYcQVUv/jqb5OJrX+ZcIjxQ5NiadEKra?=
 =?us-ascii?Q?W67ECJiptPAPwDZu+vgWU9FiWdN4pxdELI6QaAYuxaR0X91Hi55hoWeM73In?=
 =?us-ascii?Q?K12YwUrNI1Z51xrD/uM9wBmM46Navwt9qUdK9FbyMInEKypA9quM4z9ewYhU?=
 =?us-ascii?Q?/MTeUiXqQebO80RN1D+RBNnMJSl8vx3+nImOQnAR5pf0D14ufDQR5fP13qyT?=
 =?us-ascii?Q?wyNBHxsj2mIMVX4KyavB0WtsP7e5/Ohga5ILRiUKQYQRU1w+6y/FLgUvPHx3?=
 =?us-ascii?Q?vikbcA/f5BrIDReB46breiGGBMvZJ/YmR+8BgVmlwDyTsR6cJtBJJ/pf7iPo?=
 =?us-ascii?Q?BY7HeoFVfSRIwAeCWBEASdZSFtqnoyKHR5VUS0tTdXE/tM/ZVJns8D8t9blO?=
 =?us-ascii?Q?i/Wl3hA0rHYiNmRVZVE7WL7Je2MoO02SdV/VYuQehasaz9QdFLcRjx4jN8fX?=
 =?us-ascii?Q?0Nu0TV4wRvBXdLdrPIcBLiujYhhyTrnvb2gxaUvfsUkOvPJp2R9o20EigsIK?=
 =?us-ascii?Q?XNaeeJCMCSp+k6gSDH2DBcoZzliIvvN0iLcpxH/GP1I6o2xh46wPK7OXuarY?=
 =?us-ascii?Q?KRi9KHQdpGJ7JqHx06VPGsaKfgzoTveh6hIcec0D/V78O7H0Ckpro9L1Goyp?=
 =?us-ascii?Q?Mh3gmsC2xYkfsKmWbbRdQuNwQkf8G0zuiTEMITrLKulrFwQGAbSk35BZ57qq?=
 =?us-ascii?Q?rQF0XvFiosSuBoXOGyXdggIkVMbfNP6pJw8+ylSNYNe2w/EwvXQ553l4n0c0?=
 =?us-ascii?Q?nrBH1pC/041fUU2DPx+r9toU1AkBGHmFdflqbRw6WaCWijM8uLj6p7fk2ZrR?=
 =?us-ascii?Q?DmebTVWoLe0fMtgBCZ2DJzCPjHroQWHbPwNnSv8IaQ4sh/uBqDpcOZH8DVK4?=
 =?us-ascii?Q?zVnBaMsVvewvTBpsNcqwIiB9E+wDtJKIPq0GMx2g+tO0dkIKIO+xV/Ba8M//?=
 =?us-ascii?Q?QjnxgfZMnsu1pp9wgxikXkibWvsYb/GYy+67bDjAp8XxA1jvBYweAloMoPan?=
 =?us-ascii?Q?Yh2OXQZ6VJm2ikblW/1wDtuB4KKNaAmyqpZ8cnX2y7QXFm34ACTJuEstEbii?=
 =?us-ascii?Q?FvbtonoEnmvazkUWeslPZPo1u3DJw9xkYlhGazbmVI9sh5L3mzYRF+jwhvYD?=
 =?us-ascii?Q?qKAvh3/WrnX2OaS+hqj2zgcTX7A/Xk9aF1C7uASAk9LiTjxu5NvJH0LevwCV?=
 =?us-ascii?Q?94TgYWoPlqaS2JX4MDI0k212BlaI18fArDZCmPeUdsVeBm49xxdW7GSc22sr?=
 =?us-ascii?Q?6U4f9+rkkWK/hs6mLAnQjUiFO6vdZhKJiNgedQKMy9SlVTWTu2P8jORhmnTV?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb520380-ac98-4b9d-1c40-08dad9fb3c7a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 15:37:10.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+rIOzJQIcbsccTycOAYONuRbBajnGYjs79Ny7Q6Q2kx9okwj0PHZvaDYnGepVSgxxqyxR50MUFRyuQCuqr9CzHBca+DaVWixGee782xmn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212090066
X-Proofpoint-GUID: lGLKKh8MszDRzrsCY_bYSmD3Dajk3Hs7
X-Proofpoint-ORIG-GUID: lGLKKh8MszDRzrsCY_bYSmD3Dajk3Hs7
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

