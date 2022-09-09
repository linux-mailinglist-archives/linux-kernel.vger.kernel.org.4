Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEFB5B413B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiIIVGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIIVF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:05:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B81CFDB95
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:05:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289KYxPN019052;
        Fri, 9 Sep 2022 21:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=J7/tDn0OlS4b05UakmotP+IsVVNdCUJpNwFI9ZC+DzU=;
 b=g5XPk1DT6lHtRcBBOI2Wq8kmOufnhPBUeu7UYXCdJE7UTH8RvQQFfOLthq3XS4qctDKH
 +lDgFoY0czA4SXJXfMYhjtU/eQAKXwlCB5f3PLBOnGGc1WarnQjXXpJgeEl738CHDQhU
 bI2RD9XXjmuBAmZ/NySy+W+vA0GNTRaJ12gS1x4gSjXviN6bFNdG/DSNW/y72na04S+4
 NA44j2ZUr8Wcyly2B9wE5sxMyCrVYTtfCYonHcOBtFoEKbrqwgVfjrpO9NEDNgM2NRC/
 tgeIL2Q/OLjj1o9q34G1XSA70KXt8hkkS08dzB8pVxCKNV4Kr9k2sKzsUsoj42XT10st aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbcfwbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289Io9Z4024590;
        Fri, 9 Sep 2022 21:05:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jf7v9yafh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGxxwk4q5xI1d8t6Jv7gqEYxCDZeFFDgZSPNXa6jtq6V342O3KpEzRmx+1Gw7lTiXJsXKR7nHSl770OeLH6R5NRI+RAk2HLbUrxuKXeC4UsxsQThRczNhGuqm4pH1nx4gP9hfa9znnvhcsTnpuUhXzKI8bxXAWiQjFz0AKoCECOlyttf8xnlKERIufFNh7TMaH6NQyi6VodNyiQmQbwDsQe1CFyKWZyB1lVW5BVyjYuIslA1XWi8OLJZU/ZIftMDMRjC7DD6KLSI7Co/1FmpXpCtsvM/Y0GKlS9mjHreTDx4uNZTeCYoo0lLXC7oKC8CN0liX40B/SnrjXw1mIBkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7/tDn0OlS4b05UakmotP+IsVVNdCUJpNwFI9ZC+DzU=;
 b=GokthqZGwkzhMbIWp28cssQO6oddRxe7wbLS0ZYgrEwQDPWqff/YUcfa1TxFXpFHaeqg2YfBrBSviIi7UBk9klHAiRuoNCWLfMb85RaKdnqpDKZ6+AwlYrYeRv9hBNJ47ISoluE7RoPvJaCAagM5eeh+6nmn78EmoPY0vCDeVZWDEehrPaAmyadVgssvvjSFl+5+8dyQyKvTYF87NQGGEa5GXP3HoPN0ySHyZSIC+xcN1MnABA34rW+PRegdvjDdbTxBZq2T3ZUworhVP3qf71a+BKt+Au5rTu21g9Va3pmXz28OfeNSuWMIt215BFVmkGccDF2p2OlswP8IwgVUYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7/tDn0OlS4b05UakmotP+IsVVNdCUJpNwFI9ZC+DzU=;
 b=nH50fs0Ew5dtublVtFTUYhBx/1Xjm3v3fEJvIvy+fHDYeqgBqbUUX6PEa2do9D8kRNSbObhwBiafPmIxHvqpxy4Kf3nih7ofwb5yRxasfI3vFyM1u3ZlXYOh3WPyUyh/EVjTLaUjNhk6XKkx15TaESY1oII/uAyu80COSeLL+vA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB6777.namprd10.prod.outlook.com (2603:10b6:930:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 21:05:27 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 21:05:27 +0000
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
Subject: [PATCH v12 5/7] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Fri,  9 Sep 2022 17:05:07 -0400
Message-Id: <20220909210509.6286-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220909210509.6286-1-eric.devolder@oracle.com>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:5:120::24) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1bb932-ea12-49fe-884a-08da92a7054a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mtL9JYNfYdlBfS43Ma5TBQFw32Sf0n/W8pA6tYSoM0UuWCJXcNV5zhVlBcuRtzLflODXPnfHQadVKslg4vI8IEEZQS7Nh6byA9pLVGWUuvDJe1CCaMDH4qtwtsVBcOYGFiPNkRmngelWhKAGS68rSj7PiOuVVzTVtPCh4/xRN3E6Z1sgs9sYDlEE7ml9SOuIi72H4istTrRlYW7lxguCtqtqr2uE9NdVmFklAiV85UNUvlWK2LpeNL8P3Dzv5Bg5GYNF1vStDdsYUxXWiEy/nhQLCHcQ9zdO1s1PnKwB5P+XyARiMKJzsUn2EFrDQ5KpZjfoJaS4C7wT6ILJjWvaMkvHZoC5DPHy9rfA2EZtjvTll+mTOXSzxVwrvUZ27L0/z+TiqbrqnjhUPV4Me8uZaBHkiviatEKtLXVWtlSvTRtg/sZccinrl6ne1i++wNeyA3aMpm7DUjjZRIqizoHyV1ELPG81EIS5Q5AeIVr3isqpI4KMnuA2VLR1TxOh9T1pZIij8En3tt+to1D8cYEJrlV/zaPE9/hjlUOh1WBoHkamF40F0rgW3P2+MyVLF2KE3nURPJqA4yfaSFYOxGTfJkT8I1dx2TEEDBScUc/RAM+41gdua2CQWb8gDE7TklfeTaCxGycb2V+9m+CweBekg5fGcK8Vxjje2dn7rACb1n/aHniXceVmGnBBFYoMdFhF3hIlVNERBaoyyOMLeFMdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(39860400002)(346002)(26005)(86362001)(6506007)(41300700001)(6512007)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(38100700002)(8676002)(66946007)(83380400001)(66476007)(4326008)(186003)(66556008)(2906002)(8936002)(5660300002)(36756003)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JocbFW/Oex/e9ilLvlVtWCKOU14KxV33V2FMGEn0afp6nHYxBl1xY6wpdoUw?=
 =?us-ascii?Q?ET60DLgl7qAqYh3J2SJBiY4/P7IGv42Awc6anil05sFBbdSJQiK5OKFvMrlt?=
 =?us-ascii?Q?d43PbjhmpKSYgHvOu91zN0dw3koQfqLI7MR4jbVO4V/u6KQIxe0gteNa4hvn?=
 =?us-ascii?Q?ShIE41CjtFVPxas99DguqvAwvKuFgQSTAOpqSaP9CdMxK4+C7jUXn/Beh26T?=
 =?us-ascii?Q?bwNBLLUkXVkMBb6RWojuQW5ZHc5b5A+z2Z2lLa/0EgEmHVxQWW9PFymvrI5I?=
 =?us-ascii?Q?hlplarnmpO3vSpqQeTB7/kC3Zu2V1v2RnK8eu7/E4hMm7E5NWqYAtKJfUxds?=
 =?us-ascii?Q?LRww/1qTjoF1C5s8EFS5nsJF49mEljaeJFD4RePHP5EEu1PY3rzjxskgceCc?=
 =?us-ascii?Q?zjN85nZFiQ9nysjVmfX5sVE5tbrkazTSaR1bU72FzFu7F9IGPHaweD6hSwq/?=
 =?us-ascii?Q?5dAfb7Bgk8vK0MnZHIGVjSg4743VDgbx8odPrANYoNmlFrvXBrx5D64wbW+B?=
 =?us-ascii?Q?7hnzdkMgj8A2fVdGFNCETIhpO68FyYMYSzNgPpd36/8+8r1guUgwtjjTLuR5?=
 =?us-ascii?Q?CUwzyteMbE+e2+jhF4RgaovZjO5uCvjYcrsLvg1NCqXWLAhizImUItjazbMY?=
 =?us-ascii?Q?32chQ/iiyouyCdP+7mlozzaze+hKJwoORSHkXUxw122LKI8c+6u8E8mi84n8?=
 =?us-ascii?Q?gDbO/iP5xv40tlbcFhHguCibhZEtlqNIx8HOGPtl5ZhveLY8AuYBXwkuJWPn?=
 =?us-ascii?Q?Z1P1rng/7wvTqtu9fVSiW8sz5iQQkkUws0QxDX+fpRNHgAqLzk7jslgdrKbu?=
 =?us-ascii?Q?Db6MJ++YYMimS8SgiR70CpHENRJl5shbO4kzaKLfEvn1d/prZW/WMT6Tmy6S?=
 =?us-ascii?Q?S+6wexdWmFiRql2yeJlPZbcaKzA7P2sK1JiUqgEWDrKEWtzkjhJ1Anv471Uq?=
 =?us-ascii?Q?FJj0cA1Pyq4nFNpYiIHxBaY/C3yLgXONjuDNS7lI0Jd8kWSqnJyO3gUV9sxk?=
 =?us-ascii?Q?w8ItGfWnsanmo1/j5lMeQ8zjTVRqitfsQN6xOS7llY9xMETLyWZHo0Z1J7Ih?=
 =?us-ascii?Q?HqVofV69K4c2S91n0WxuDFMTdXYPyESk0fvsQNloKT+FpZy6k7zxOH/AL7bt?=
 =?us-ascii?Q?RErFk81AV+ZQoDqJzfoO8ibdDsEgvHMF5p7w8d2AmAjdUp1AFTba7QrmLUh8?=
 =?us-ascii?Q?8LsCPVMnFeABh5l6MzpjL6XOxRleaupUUg5V8JRcQOk/MifFEAZ5c0Sn5+aE?=
 =?us-ascii?Q?T6qrpLpVbqnIzB2/533R5etIgGxad1L5uDJ/u6TFGfLlqfo1dT8UtAYwDehM?=
 =?us-ascii?Q?pWhtiJ8E+vPeZlUvjRmiHj6EI/AXSmlfy1JPeMKxujuF04+jHQSnjEKMmSFe?=
 =?us-ascii?Q?2Oz5wJ1gqWlwru4CeM1vtNN3TpA363vDKT8ymgA9qGK/hLVvanEOxwgXgY4n?=
 =?us-ascii?Q?TbFK0unO0TX3Jvl9ATjRTu3LJYQSeUkTnI3pj59MtAPYboQVNzwIJHCUpRaS?=
 =?us-ascii?Q?0mEYA0+w3U3ST4//P1ICV3+onCnyHaJiyEKEQLGzBVfTm2FEV/rARG6+T11U?=
 =?us-ascii?Q?x/nVsKQgt/W/nXZHKl67MEIkLghq5xk0egA25/ZcMHWPtqAZeMLUozcqDpjy?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1bb932-ea12-49fe-884a-08da92a7054a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 21:05:27.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EOFqXIOU95/OUdRoIB30kMjn5Wz6rxoyQCmzp9vwcnwtCZup0jPQewTBUZZXD4NDKFTlZpEFfOQgSB/grm66959NNd/H30S1G6mgK1PmzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090074
X-Proofpoint-ORIG-GUID: YE0WncJaGDnIACiD_Hj8MZ-EZ_eCFrzF
X-Proofpoint-GUID: YE0WncJaGDnIACiD_Hj8MZ-EZ_eCFrzF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/crash_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 4b15d91f0b21..5bc5159d9cb1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -366,6 +366,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
@@ -682,6 +687,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 		/* Flag to differentiate between normal load and hotplug */
 		image->hotplug_event = true;
 
+		/*
+		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+		 * this callback, the CPU is still in the for_each_present_cpu()
+		 * list. Must explicitly look to exclude this CPU when building
+		 * new list.
+		 */
+		image->offlinecpu =
+			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+				cpu : KEXEC_CRASH_HP_INVALID_CPU;
+
 		/* Now invoke arch-specific update handler */
 		arch_crash_handle_hotplug_event(image, hp_action);
 
-- 
2.31.1

