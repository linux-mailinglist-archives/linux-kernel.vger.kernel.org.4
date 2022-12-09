Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E026485AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiLIPhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiLIPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:37:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0694C31B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:37:38 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9EwtfM029265;
        Fri, 9 Dec 2022 15:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=3JgPCddJz4urtq6IAdyWD4LfDdxFMwmd1JJplr/8yZE=;
 b=UXngDCPhCr9uSk9hnyorewFpmXuqHkNUIiJd3oMSiqrhYGP8nDAaqrrHZ50OFoSKgz6r
 DpV4h8T6VKSccVD2OFt+Xz+IeQ8V4LcknoSAVVkvti5NayNpC30qF1YQF8E8z5Cau2AG
 KEElju8lAls67EkghArZpsM9qyEhM1zoyTAWXYN6cMvcn9gOSEvnyrqL4BKG9Ef7MyDD
 XWAFc7HMZlvv5oTpF+fVf0q6vXGAEa08pWJblZdFPCEryR3/mFc8S2yzG9ws1mQG6cpF
 CyXRWsJxHCvId3YelqgCKsswdfIrVC+W7mRdeBRJlbNsK3efpyhi3qoqJcSUNWvTiZzC xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mawj6vgfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9ECi3k019003;
        Fri, 9 Dec 2022 15:37:17 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa62ppc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTd/arZupn0ZUWvh/jDA/PUzkyfl7p26d7ile+fNG/apJ/dsZ6nySSE9CNl31DNhmcMNYm6abtfUnIC1SeaeYS53LICSJ6K3LcwoA7b8EWdBt9rapxnavdYDD5W/3OL2oIodw4joLWAHdRYMa2MNcJ/WoB8dHFcCh+XiSe696vBfbP24NH+MAho8OaMb/YWUA4vSPwC5LMjSnbx5fDlUicDfUDaFVbnVHPLtm2ST90Faj3j3FeHRKjpJ7cHIcUhySjryrQ/ZTk1O7kWF0cbamkm2dZZbDNKLWxzdRhcpe4BHBX8lHEXjGwTMxmopXZLF+bXUkG0ZgrT9ieKrEcfhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JgPCddJz4urtq6IAdyWD4LfDdxFMwmd1JJplr/8yZE=;
 b=Zdh5O042lXApvD4kt7nYk5vpwXOt7bUwSVynPbDKMz0TbIxyreejclTijHKnWkvq1MXqPF/1scPYiwy7jiWO1oc4uGvsEPy6P+g6tUmWGYQt9X7yfzTaQYka2jVK187WcPJeoLpmy85S5YYcUPC+CE5O9ln1BEkR9PTBdKbAR+J5yLn8H+bBYlOSgY3Vw8FauS5WCjLwcNBW5D8FXXolOS/tot0GPiG6bMo0hvFJLroZJ+yoXyV4qrm78VyvKEvbxEjd6nIR19rotvAt9UyPJiR8tp0aBwXuMjfNRrFsOYR0+2DjsdfUGqRFoHNPzRuVCzreYHF+TgCPiHzjexBu6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JgPCddJz4urtq6IAdyWD4LfDdxFMwmd1JJplr/8yZE=;
 b=ZQFnyqvZANkkN5xU11s1qc+p8GLuJlc5xGB3qFKzI/ToRdfmreCDm1ZKK+l3D1RXx48IH91Eigzanmnu1COykM+QWz7RmPKtot68rqTXUJ2/UL820Ya8/PqHSwBTlJVc30TPeD+Joq8TCPm7PsMTFy3ynMLc2gH8kVPFT7wuuAA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA2PR10MB4666.namprd10.prod.outlook.com (2603:10b6:806:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 15:37:13 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%9]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 15:37:13 +0000
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
Subject: [PATCH v15 3/7] crash: add generic infrastructure for crash hotplug support
Date:   Fri,  9 Dec 2022 10:36:52 -0500
Message-Id: <20221209153656.3284-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221209153656.3284-1-eric.devolder@oracle.com>
References: <20221209153656.3284-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:806:130::13) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA2PR10MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b047b1-930b-46bd-57b4-08dad9fb3e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ihu2KzhK9I0MP+CHxGs6vOkRaMuiFI//8K8KXSv6IjUJJI9RaUHCZCF5fhaaBP2EAjcR6UOPvBXUBGgrJgyVNloMtFNYUXoaXAV918h2V8U4V1+bGrpUpa7eCzrpcsZOBdhgYwchvRM4mFssKuyXGMzcoe82JeTVPACV8I7KkIa+W27YNmvVnM1eMgzMGIaUp3MeXjeP1+D/4OIRRLmlGxeiTs1WW96pqELVARGXoBMrtxYWTxqvcgQOM/vp11YLrzr2zo9EfwlbWhwcP9CNDJwXPrMgH8bQVntlpzydFSfimDf3hjGgJTTqbM0NOjiy05QnNoYwx4RdDYB0n1yITGbShJ10tAlzhVcgNW/JJEUGOcshOzMgjzRvX9fG2U6hpdJ3kdg2DiqVp5CEvyEqxw/pzByk80kDmwysghIOR68+lICFXuR+Fa0yhj8L++K6Fgs1sAFrinymKFAtGw8m/CsPlmXVkgVnl47Atnihe1gGIK/ugonSjsaSLDYg+cT/YCuCNiTNzdCJcDW08UfHLh8tLSe4gtOhAfGkywWkEYBEeAqucq6IOAFKEG+BjSIsmj5a7k0Df7Cedb2eZJu3R15ITpBGsXxz+Nqb/i7eYjJApScORNbgUoXTuV7lnFwr0mXBI/yaoW2Cz+mRCUjUBD66kyGUyVJesm+FKRokRqFvgWATV6inhzKOgj66hJBD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(107886003)(6486002)(66556008)(6512007)(6666004)(86362001)(66946007)(8676002)(478600001)(4326008)(26005)(316002)(66476007)(6506007)(2906002)(1076003)(2616005)(41300700001)(186003)(38100700002)(7416002)(8936002)(83380400001)(5660300002)(36756003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/NHpNqZQJTYIoDPYzJ6f8Im8+ddEsa8/N9HCT3lZc3bS05D1jhCweS+7EONP?=
 =?us-ascii?Q?3BBYvi0XTHX9f9yurNTNWUEyX9V50XGIF+gwzc0UjrspDe8pxOTvlQMpd8Oz?=
 =?us-ascii?Q?6lQ9jK9jyZPbnEx4PZBwKo5mH5IDQQeqZpDHD4WpVi/NIJ22vwHE0KstkSsM?=
 =?us-ascii?Q?1ODlauI3LyxO5kCHyagTqrat0Rf6lO2J2bvCPhMWleHtjimXp3XjGhS/Gcb3?=
 =?us-ascii?Q?tsWqf97Q43nG2/CgZo6yzDAEm8Ej4e1wH/Zm6RxQw+ou4hT1qMoHQLqppg4p?=
 =?us-ascii?Q?Iy64FdSE3koI1Xdo5Z8x3XZLrjBISRwBRWvTAeZUbQ1R58nXKtMPb4jVD70z?=
 =?us-ascii?Q?6ye5gxt5RR9fxdDDJ6C/V5DehVP9/dKYPdWYO4zJTKbxr/q54pjKyJKyjxgw?=
 =?us-ascii?Q?lluJZYB10JufTJW3X8roUJ0uowEd5qEBISTwh16NtwMJ857o3/8Z2DNEIhUW?=
 =?us-ascii?Q?10Wtk1UZ8qWMQIux1ETjad700GX8NviXHAfvDBLimvbpUPJen7gumuN+r4N9?=
 =?us-ascii?Q?gE/3UmqQ94M+RuqVHqY9Dd2CUioDtdjyUQaEVkSGRkIdnDWvzQg79v0oR+Ec?=
 =?us-ascii?Q?aPuJYIZjznC08MS90Hrv5x5xBirn1v9HMAG3935z5TMNRDUobg99Ep5fzjKX?=
 =?us-ascii?Q?WddKQwfU6EhgST7WSryc3VxpDDCAf7LVJVJVgH7v0wKujsg7S9Ke0q0pLeUr?=
 =?us-ascii?Q?RWO4/P4Wqn7yFoWun5UUnDXinzpNzEULgp08zQ1QM2mH9n2+HkfwNy+ISKYO?=
 =?us-ascii?Q?TP/oEYmVBBT1iX0a1gEkZonNx4FdseRRxNgknmwrXTaP4A3HTD5BAN8M9m7e?=
 =?us-ascii?Q?wzcKxyBgEP8XP8d/sORIA3dYJucYn1JTIU21wulVeBnXTVf8rHUq28tqtaQh?=
 =?us-ascii?Q?dIY7dOJnd65tCh3PFnMcG2ID4jPMfPpFlxzPE55AB2ekX0LGxun7rbPkPqJE?=
 =?us-ascii?Q?OuLrOL1eJGP81CKRgZXTPu8PuCVJOkXTX7S6eJ9wBqyZycESD0jjscgYHY8k?=
 =?us-ascii?Q?wj1oUbHc7Xb2S+F7Qdp2JrbfNyzCeEMGwvVXWG6nGYjARCY9Ke68hgtjJKjF?=
 =?us-ascii?Q?KGM4ShsxkrXydvl6EoUvNyUuXRxyiRW9mBOyRE+TMlzv8sA7jZpqCqTpOeY7?=
 =?us-ascii?Q?PzI+1gZg3yKn6ppLDCZ7YpdKlcN8GuGqOB7PiIRQZw/a57fgcLjdGaOc0s4X?=
 =?us-ascii?Q?tB+XoPkCimaZfB2zEtsobp7p04rEe6zkv0FIHONS8jrj84OPA7GJfECBZ8cn?=
 =?us-ascii?Q?wQZZ/zarbhTY08LHHAVTIwl5XQKL85adQxbKb6XhdVp3SmiFcNVF4r5yAVuu?=
 =?us-ascii?Q?bKK2GDHT34sFxoPC8fYcCIoi8rMRvcTw6eMIhR5rOHbeC8aPT6rGHFLW7X0A?=
 =?us-ascii?Q?BEzbJUHL7YJdQeD4rlz5HZ7QGlgipmpLZBgUD3DMPAQw1x0y8y5zbqAQ8UVM?=
 =?us-ascii?Q?qOqTNGkRwr1fcCxtw4jgMw8u+W08/vLw4D4Ubz7iksSf3kynGwIQlwtPUQ9x?=
 =?us-ascii?Q?fPvb7jvFp7xafUp77UciLfHWMw8uxqUtIezLgUvZzZZwssoKLFiTaDat0paH?=
 =?us-ascii?Q?PhA/yADQFz2kfT9TxTf1KLF2Axkj9XdULNTNc8zGhswk2faJAcd5XpY1qi78?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b047b1-930b-46bd-57b4-08dad9fb3e2c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 15:37:13.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6BNFVbP0wSf/5UIyfN5KaB9yCcWIynUOp5ZVFqw5CbMTBGz4krDvNKwmtFGrLlPPkgaK80Qn8cu5rqDdzmFV+imlyl6IPPKp+7+4SgUuf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090066
X-Proofpoint-GUID: 5EvUNP9hguAtvESuQkQ78JxuUl2fHbII
X-Proofpoint-ORIG-GUID: 5EvUNP9hguAtvESuQkQ78JxuUl2fHbII
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
 include/linux/kexec.h      |  12 ++++
 kernel/crash_core.c        | 138 +++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)

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
index ebf46c3b8f8b..389444cb03cc 100644
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
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	bool hotplug_event;
+	unsigned int offlinecpu;
+	bool elfcorehdr_index_valid;
+	int elfcorehdr_index;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -503,6 +511,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8c648fd5897a..fcb642a03d7b 100644
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
@@ -612,3 +615,138 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
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
+				unsigned long mem;
+				unsigned char *ptr;
+				unsigned int n;
+
+				for (n = 0; n < image->nr_segments; n++) {
+					mem = image->segment[n].mem;
+					ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+					if (ptr) {
+						/* The segment containing elfcorehdr */
+						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+							image->elfcorehdr_index = (int)n;
+							image->elfcorehdr_index_valid = true;
+						}
+						kunmap_local(ptr);
+					}
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
+			arch_crash_handle_hotplug_event(image);
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

