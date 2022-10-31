Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4D613E58
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJaTg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJaTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:36:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC9113E1F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:36:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VGx08p014808;
        Mon, 31 Oct 2022 19:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=hmA4GSvFTgTJJl/gPNh7nMMFy54MQfbhCnRP+0SL2a8=;
 b=avQK5e/LptV4Pp/HH/gnekAV/rGrpoRpCODeKbGcDV8ZZlGXl72iXtH1vfIgMLUEzZ4X
 0+MXvtL8dWjJnLiLkpqTyO1LMdpTEvxMmmNpTWnkoGELQAuKLdsRoflt8OukQxt6lBnc
 Ba6CracgFkq5+RSRe55s45K3KB8S7CpsC4p6G6wbsdoqOEq/G1/V9EYlrBBE3942/lUc
 epVQNlLWoDM/3OewMV/aKosGLU58PQA0Z+3oryrafnImZPV95GmV4mIPDpNaCEMZqy9r
 4MHtLuz97ckdA/sh8gHtW4VnzrnTPcCNSzAL8xJD2ZQSTmD3dGhsSNJCX+KolMyujYui Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2acn7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VHTkoA037354;
        Mon, 31 Oct 2022 19:36:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3nqbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLslLcAnKZsi4bn7VWwE64OqWaKh81lmtx4uw9hlkCG/f6souUEItznInRkAVqK+KQqrV4DQVDKY4MgocGV3xA4KGgOrr6qhaYzNyZykZU21mNNFjaqnxWB0LqQBzo+/suY3/P9ieiZIjnMZWiRO99uluTJCaHjR/u2cHr6n8ZF67T/fOmRm63YBMsEZA+61nRG+Xn9FfdsTu8hIAJGV+XAT8H31s/JMvmVwYYUSvV5xROlaiCLaHSwJTKcG1e9Q6P0aQOmOXS6ff2X7lpfd2Ow67o9BR+mx76yoQd+ddY5P6SLys66qrrbUYHTGNdF1kU1WoQF0ZLK/LgJrInunNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmA4GSvFTgTJJl/gPNh7nMMFy54MQfbhCnRP+0SL2a8=;
 b=VHPmWxl9fSydxVd0XEo6p0ZMioB2slWXcbZEE3OGWboZNd3GVouWuhGCK2LMAYk2uu+o7t0Na4wNUy9bmJhZkg4R92RXIwzPMd6rUpmFJ7xvwKzAsOnaXB6+pU+hZZ0gIKqyu2+0ICtaduJyr0Y7qWaHCv85o2e2u2jLU083sH623VkWtsj6hjdTObVSFqnsTjI2GKSLFqb5r7kXbk5NxAoRpuA9L8XunFUtI1t+2FHNigdGv/csf5OuovOCZ1oX1pbkFFGGUh8etyeERUveyT+WBzAjAk0BaAuiC3/oNKkB+Yhpqj5s4flkKXVkh/RGps0LL8zynuohSrhBMmL1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmA4GSvFTgTJJl/gPNh7nMMFy54MQfbhCnRP+0SL2a8=;
 b=f6XaAfO5yWrfvjc9k0ztLyPezUW9ENC6maL5Fs3CSV1Me0x96IWlDuLWveVEqB5Sh1MYCv87HMGRpwHaPevoKYQwuOgzS3Q51jj6ZGGsRsRd6zYkzeMEatGPGFsltheQoCZuFV5nthMGxlGu7dcHt9PnNI2ee0EgUkozPRddN7U=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4228.namprd10.prod.outlook.com (2603:10b6:a03:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 19:36:20 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 19:36:20 +0000
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
Subject: [PATCH v13 3/7] crash: add generic infrastructure for crash hotplug support
Date:   Mon, 31 Oct 2022 15:36:00 -0400
Message-Id: <20221031193604.28779-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221031193604.28779-1-eric.devolder@oracle.com>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:806:6e::32) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: a378924a-481e-4f71-6f3f-08dabb772fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18e6NO+Fm/eduTwW1l00MW/E4KpnZOjMxxZKeEwt2Bw4j+VfH88Q1HcMaDI2UbUPgVs6MdYJd5yG4KsKtEyJm0DJ3Wngi7JtWEoobtvlhuE8yQBRglL7c3n2drMwSCkBVU/+041s7kdQRzdUU3RFa5YzmBuvtPO7Bf73qQWjVhxTela34lwDxfw+THRK6Zaeqt/TSwrNZ1TNqEhv5CEUxxfCWqNemxCUc+8AGWfK3Rr9RSnwpaxNRGWLuvyjVKIuJ1sJpOqTdJCKK1ElfLKN2i4SPkckGEslbl0GruOB6u+SwhpqoxnRUv2yUi4oVZGsb8e075HgeKdDLK+/G0MGlDVf15pvqoFvRq6ggxbfom8TdzkYCKRE7NcytOkGUzh/8bRqelChfysv8a0fgnxUWkuSh05sVkRcnxW6z8AA481do5TbOfvwL1Zsk5hUWONkwZ7ucM5Yil5QK3lsKCenwp1g2PuYDfatzeJ1Qq3MkYqZB1B2vawFqPAbozacg+EcUXxj2LixZS5gDatD9eePW9r9asxYEoy1AyC6FyplspVeu9yeAZzLZAFB0ylxjE7W0ocDlZ6drqS8wsB5nEt4B8SNY6FpTNH7GZAaHigMqp7rWUYZG5AMhh69vb0mcgOZd1kqt7tTzCuT+zePRLgyan+9Ax/GAUr6kzEHjOevemUHN1m7oZi7sngZV7AmTLf5Vg+9PuLjcg8sqXVCUSil1HBOSgNSX5czAcOrdZrTAZ47Ztv823/GbsVoKajIBXzc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(36756003)(2906002)(86362001)(83380400001)(6486002)(8936002)(41300700001)(7416002)(5660300002)(4326008)(8676002)(66946007)(66556008)(66476007)(316002)(6666004)(107886003)(478600001)(2616005)(1076003)(6506007)(38100700002)(26005)(186003)(6512007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1qnBb+gcKiuwQawCOZIPN6jkq9N3ZqrWOvfhDl48/BHi57/dGYvYgswGt6q?=
 =?us-ascii?Q?e5Ioa4tCm7nsoa2Y7klKdjNhnZfi/L/8f0tQPO8JF9Irp3qucAKBh1tO8YiC?=
 =?us-ascii?Q?wOjKKl1hXEXV0dkD9DAfMv24MotRxanUSp36JF1lTnriXkX/VPCsbpGwo8jd?=
 =?us-ascii?Q?jzlX5v6YMwzjYLWNh5Y0z9d0vYbOBFkmQ5ROeTYOZKDJc9kFamx6kvLC9eSO?=
 =?us-ascii?Q?ZTyjlk/z+7+Jao7WsCZ8EpacB0aPfTR6t+YdCOjP03OP2twJWoAOapsoOtvq?=
 =?us-ascii?Q?SaZ+5oOTVCX5ERjKrVmLLtEDnZwG+k7YLPSUkBn7tDZrGf7M0/bfkqpj2n6g?=
 =?us-ascii?Q?zk97b2aWpctkGOgsD+M41EsuTh5ViXruQ1F761qN6tgtVKdLXKtAb7q2QthB?=
 =?us-ascii?Q?EPlr4m4IPARbJOnCU8PA0yeW6qqOZTBejCko/QpEA9aPQz4ZEDGVo7YZ8WLF?=
 =?us-ascii?Q?wXcUJyoYo9USJ1HaiNVjbBNVPbjR5uq/JDiuk5nTZmdvBrIYcSPAjWgCuUNL?=
 =?us-ascii?Q?+cnHXU2+bQcppsXXg6WacBOhODDXVy+icD4eBclo+5iBXMEUbTs8kQcLVnPF?=
 =?us-ascii?Q?FAgc6e+GaJq8z+awutqe9Pb4G2AelXDSzbixW6dYwyxdRk1i9VREEaCYX6ln?=
 =?us-ascii?Q?ChftAFARs/kuwdG1BTQpsmEeQrKKGme1xH7y/cylDIoF+S9zzQ9IiGwyF/OJ?=
 =?us-ascii?Q?xUlXm0GyuOyKEF/J4ddK9KX8YwzqiTwBIfLxPkw7+pNkmPsl+IvLsMtalxJl?=
 =?us-ascii?Q?g3AGU6T62P8Hl9kQnd/q3+M08rD7WXEDJmsgvOv2Pwu70xlHW+gGBVaexb7x?=
 =?us-ascii?Q?r9RABhSL92Hswv2v4muAI+Rq9/i62wlhHnCshbpl6V0X5qlqasHOfuWDANU0?=
 =?us-ascii?Q?BT/IDIq3JuzRF0SRjcSYbSG+ETQ9HsfX/tBCv/OKmh5N7CDMcbjkl5PSbtYG?=
 =?us-ascii?Q?OQZQXK2SlD3VGi10HHZZBVRIr17utIs/7GQjlGId2BY52rgPxQ8se9p6B3vn?=
 =?us-ascii?Q?q/dcNpPnSqWhVElJyUIchg2AJy2EBUh5CdjnjAxzsRYl3siKjUyPueubAbmT?=
 =?us-ascii?Q?vBrssWHwj2YJRUM0G3ohR3XvrDPfIuW5t8EpspBR1yhGgUSQTHUAN7hz9Iaf?=
 =?us-ascii?Q?w1F+qTAxsD47zFGEtBSJUr1aumuPfFp47pdE8fjVY6Xely58K4mKsS1WfDJ/?=
 =?us-ascii?Q?aPHBjL9hgDJJGwW8MSRMPgPJIBsVbFHl8FYcHvtiCPuDM3dN/+4Nujg2xpL1?=
 =?us-ascii?Q?CgZbAnwBxKrsBNkgvGRdwM98c4b0uNpXb0mR/FUWaiNkgVs/nU3XpiyJEYM3?=
 =?us-ascii?Q?FbwfuTwCYuiqqYF7fZ90/+HdDoxMcASfZgT9xLfwKGaEwTaCD/pjuBAk9mjy?=
 =?us-ascii?Q?mjS37unoJlGqW5IRlPq8xaUHUTUtohcXqCHoRxGiO+W7VKiCJcHPBpmVHYWW?=
 =?us-ascii?Q?0i7/mYUCA3KRGIelM11BmP2/gHjbwXzuk51B3QdXjoOOiwGO8ItEMnCe9IVU?=
 =?us-ascii?Q?h2yiPpy2mTijmlwOWTD2Wf5IUmIkjGLwAM4rMYAxQ9kscuRp1AtGQrmc0Bba?=
 =?us-ascii?Q?hDA+Se5Zq/mM12WqUs9LZL/nYhQjffGMiix5VPF3DDt/Ym5nFIsEjPuO2QQZ?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a378924a-481e-4f71-6f3f-08dabb772fa2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:36:20.3210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZV+n+Xcp473EU+PcHZMXrkdvNjWPD4lYtGBDF4Bc/+xTBFgbUo2flmt6M5YhG4TqGqfSSrYI1FETJkrEIav8RhuMuu0FDeQiMxeADwlLDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310121
X-Proofpoint-ORIG-GUID: GO1nygFXLPpWM64TGyEZ4ImdER3JqKyg
X-Proofpoint-GUID: GO1nygFXLPpWM64TGyEZ4ImdER3JqKyg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU and memory change notifications are received in order to
regenerate the elfcorehdr.

To support cpu hotplug, a callback is registered to capture the
CPUHP_AP_ONLINE_DYN online and offline events via
cpuhp_setup_state_nocalls().

To support memory hotplug, a notifier is registered to capture the
MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The cpu callback and memory notifiers call handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event(). During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/crash_core.h |   8 +++
 include/linux/kexec.h      |  39 +++++++++++
 kernel/crash_core.c        | 139 +++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..a270f8660538 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_REMOVE_CPU		0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ebf46c3b8f8b..04ef5172c4ba 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -32,6 +32,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -374,6 +375,13 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+	bool hotplug_event;
+	unsigned int offlinecpu;
+	bool elfcorehdr_index_valid;
+	int elfcorehdr_index;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -503,6 +511,37 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_map_crash_pages
+/*
+ * NOTE: The addresses and sizes passed to this routine have
+ * already been fully aligned on page boundaries. There is no
+ * need for massaging the address or size.
+ */
+static inline void *arch_map_crash_pages(unsigned long paddr,
+					unsigned long size)
+{
+	if (size > 0)
+		return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
+	else
+		return NULL;
+}
+#endif
+
+#ifndef arch_unmap_crash_pages
+static inline void arch_unmap_crash_pages(void *ptr)
+{
+	if (ptr)
+		kunmap_local(ptr);
+}
+#endif
+
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image,
+						  unsigned int hp_action)
+{
+}
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8c648fd5897a..3a0ed4168fcd 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -612,3 +615,139 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes, the elfcorehdr (which
+ * is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	/* Obtain lock while changing crash information */
+	if (kexec_trylock()) {
+
+		/* Check kdump is loaded */
+		if (kexec_crash_image) {
+			struct kimage *image = kexec_crash_image;
+
+			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+			else
+				pr_debug("hp_action %u\n", hp_action);
+
+			/*
+			 * When the struct kimage is allocated, it is wiped to zero, so
+			 * the elfcorehdr_index_valid defaults to false. Find the
+			 * segment containing the elfcorehdr, if not already found.
+			 * This works for both the kexec_load and kexec_file_load paths.
+			 */
+			if (!image->elfcorehdr_index_valid) {
+				unsigned long mem, memsz;
+				unsigned char *ptr;
+				unsigned int n;
+
+				for (n = 0; n < image->nr_segments; n++) {
+					mem = image->segment[n].mem;
+					memsz = image->segment[n].memsz;
+					ptr = arch_map_crash_pages(mem, memsz);
+					if (ptr) {
+						/* The segment containing elfcorehdr */
+						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+							image->elfcorehdr_index = (int)n;
+							image->elfcorehdr_index_valid = true;
+						}
+					}
+					arch_unmap_crash_pages((void *)ptr);
+				}
+			}
+
+			if (!image->elfcorehdr_index_valid) {
+				pr_err("unable to locate elfcorehdr segment");
+				goto out;
+			}
+
+			/* Needed in order for the segments to be updated */
+			arch_kexec_unprotect_crashkres();
+
+			/* Flag to differentiate between normal load and hotplug */
+			image->hotplug_event = true;
+
+			/* Now invoke arch-specific update handler */
+			arch_crash_handle_hotplug_event(image, hp_action);
+
+			/* No longer handling a hotplug event */
+			image->hotplug_event = false;
+
+			/* Change back to read-only */
+			arch_kexec_protect_crashkres();
+		}
+
+out:
+		/* Release lock now that update complete */
+		kexec_unlock();
+	}
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+						   "crash/cpuhp",
+						   crash_cpuhp_online,
+						   crash_cpuhp_offline);
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
-- 
2.31.1

