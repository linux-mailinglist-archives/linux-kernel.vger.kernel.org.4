Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B795B413D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiIIVGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiIIVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:05:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640A0FB8DC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:05:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289KYtfL002789;
        Fri, 9 Sep 2022 21:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=NQ4OQGeKBWA3OVSm34P3apUfsfrRvSi/TVuc/5GgpBQ=;
 b=AS+SjOAUoBmG1lLxWlZGtxyp/1TokN7nx7dzrRXiNom4PpN7T7WZebrkhWThzXUhhmZg
 Rf6M18mvMZIy4Rexdm+DA2+qQEpYmXcjFAXR+0ohyEO8KKhtDUooHtqgqcFzgQGOfQjo
 fZlp+PBQTvEQcvqCJGfvm8IL3axCVHYen3pfNbdCn5WCJ8ECcuTTouqbwTGH/1GWnqbX
 Jm7tl3pkwgcWXHxiyS6sb3XDGwQe9A24ZHVUdmgXBCDRuZMSxESOzAZifE8xSX17tuhQ
 qdwb9NChIOvCccmb7wCxulnRwKqwBZ3O04i2RM5aqC9w3HKfhrNe8lfyLdLRiNbkc1t7 Cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2rgpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289IOj9f036211;
        Fri, 9 Sep 2022 21:05:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9119g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5K2l8g3iGXip5PiraVFoTlfvrccSEvMCEnYxQSv4WvgQi8yMbk58hM5Fg9HRT8vbLK3pXLOha9TFjLg5lJiqoOrN88dJwXa/SlcQco+k7SHQbuLaq4Q3nEtpNNYNn5nFW317BKNc9452CuJrEnPItN48cf5JMYctKJ5kQb3g0LW/VyTdI2iIEgfpt65MmWfsio/Ra5C8x/o7duwqyFvoOR0YxPHq18BvNeIcnnRZH4xYFi96qnFDKYJJRkO6xdjuoLr5VayxrdNBYflClvr9zMPVOEsfaic66U6yZXLPAgS00dvn8njo+oHrc6PBqEpkfXWWnuRomG2ZfsZ7HzMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ4OQGeKBWA3OVSm34P3apUfsfrRvSi/TVuc/5GgpBQ=;
 b=BKjO3SbgCVkVHtvg7piaMiJy64UT/L2Flcty1c4bWWP5tR81/Y1J5v0qjrng2o+dIuJJc25AgJj9zckclpQkw+vDinmZZp0swnkxIBfHZvs5hvoP8crgTCaLLBX/mj5vcntvtNevNV5r1ia4JOvAJUoK3yjR1DbS+rtADKGVaXESiwiN5E8AlFtc6AahXj6BT1SlDTPXnRiyT1Wwf3gKXZOW6HG2TeXAUabFASOvLSGllQzqFpeWlqOMJGSdH3bs10tIHoZ/7mGdHMypVa1osemdv1efJ3sVyq4eehHHIjVcKKGPyAWOChPi/r3tiDekvWSsm/kvHthS+FQapfL+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ4OQGeKBWA3OVSm34P3apUfsfrRvSi/TVuc/5GgpBQ=;
 b=rVkrXa1TVP95ABXRMBP6zyTEAn4dPc0A2zcR2Yp4ARnHYneXG4hJL9cprM9MPci1gy33BXolirvctFiQ0v/uhuxE4y20u7KEl4DSLj62npNyU2pcnFzruhXKCu5B6gqh93/rdwLdxIMglgwk3wVL6yzIzzloe2crijj4Y/7GZr4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB6777.namprd10.prod.outlook.com (2603:10b6:930:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 21:05:32 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 21:05:32 +0000
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
Subject: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Date:   Fri,  9 Sep 2022 17:05:09 -0400
Message-Id: <20220909210509.6286-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220909210509.6286-1-eric.devolder@oracle.com>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:4:60::47) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: e70029a0-fbe9-4f0c-588a-08da92a7080c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +k8E0ogjlSDef5lBhrWIdLqZ0KjFZBBbb2H5oS/LGHbbGqXG8D8TOq4ZiSjbuSTymAFH56AKJ0jHt/uhc3W5Eh9BgS5MtUx1El0cMcrjYsZ8t1+9HYK8O12G7eupt7m6Mz++3PVJQhrrN8mBK1o74bNl8dq2Bz2uOsMyaYEDZctvUiLBONqt8NkUR18tbR1IrkMFLPpRgOUjIH6p8abvq9+waJmOgiL4qZMzgjq6WJTzAXMejw0+ZoPQJ8ZQR5pcRaP1dIMNGoeEbT6+lROthhFIRZqOPfFjJCHE1aAkqHIbt7jfUxaTlrVlv7eOf6u9Mmml3CXap8ubmg678E+Sssmu4tasQ6ALff4Z510AoLJtQxEtDpw/UPBoj2YT/0uFsPagNnpx98R73ZdwXPfQ9OsUSaOwRDB+HWyj7AgpnV36Msnh2Khng57xK1ka+x2AmeOhIPLdn/d+sL5ipgg7VB2hgcyxlHqBTnF1FTJYGoPChcoySpe8LuJkiXs+fmS0W2EkdMpc6V6HX5xXk7N/sVi8yvzLmtalcDY1LSW9W7x0bgq2jdoBh6V+FEg3xmDI88KYHafgq/S2If9nA9k4Tl0ekPp4NGELa1dzdUqt1hcGwDnB3FeLeVslzkrTbUbGy+desoRe6+4FjlOmzpT8sOqnqeAmHH+o0cmRVTuF13W6Cx472B3AxwNhQdFwYLpifEeCqI5+E9MLfXi+K6Y9nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(39860400002)(346002)(26005)(86362001)(6506007)(41300700001)(6512007)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(38100700002)(8676002)(66946007)(83380400001)(66476007)(4326008)(186003)(66556008)(2906002)(8936002)(5660300002)(36756003)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xHUoGaM0pmWskM8bEAuivDdpdTSReylllywxg9CKElokIwHa3BC/Kpd7YhPo?=
 =?us-ascii?Q?jCGRRk5yGY2y3xYR0sf5hFuR5D6iUbnFl1drC8F/0KOgrcgmJr+C60YIERvq?=
 =?us-ascii?Q?U3VZfhMjQDHLHZlOsDQHJ40GlF6568RJ829t31hKuECoCPz8cen7cFKch+ad?=
 =?us-ascii?Q?PtWVWEdPoQ6y0jHhuZtIWOu1vdbTdnDua9r+diRtVZHbZq9g6Tq8KFJIpw3G?=
 =?us-ascii?Q?ZtgxqunWm9/V5jR78rt+xkRSRMsaZzksFPrSJc9mhuKfhG/R21tHwO7YFoiN?=
 =?us-ascii?Q?j07QpnJy3uWaou9uzs8jmNBqFP0YVEN3GAHIm1Bf5UkdpuuYA1d651VVAMaF?=
 =?us-ascii?Q?e3YlFITdPhP+0JFA/+O6ycQ+2ouj+8rHh17Yo7kZdBS0BgCS7T4JJDtFhqzd?=
 =?us-ascii?Q?KczZO+MNjrGeJMjuAnAmqdIbjBqGxKXp6rLMW/Y4q31DrJMqD/T1Miq1aun8?=
 =?us-ascii?Q?saH43gdqjtwtRk2mBoJlvzwEAXkMrKwdfNxo9P5yzksgADn7i7rgJStbetkl?=
 =?us-ascii?Q?dk1dsfDEFxr1mXe8OZFbWh6XqS7bzyIU7glQuxWH8EpY6tfWrhCiAH5jpC+C?=
 =?us-ascii?Q?YSm/oRkAlzJMEFdV7vwDrggFzjYDzkL/HWcEFoCqhOVqm7d/b+I6nkCCcCuF?=
 =?us-ascii?Q?lqdDZDq/BsbDoEIv5u3ajqA0T/1s1GmDFEUI7lH3d2QqkNsBpviWdwUSlRXm?=
 =?us-ascii?Q?PC42329vil9y1DyI0rABgv5yW6HRmYMFvuybWE5Fi4qD2D8DkFH77rw7trUM?=
 =?us-ascii?Q?YrrpyI6B0MbXiqzIQRJS2lEDXP0jNYTQWm4f5WeLuaTi1xk8JlAb5RCFlLZy?=
 =?us-ascii?Q?kYFYQFjZV7oFlfxc3NaZJ+VnFbiH2XZse1XSLcV+6wb38vznmtKtWk3/hu2c?=
 =?us-ascii?Q?MgWbJRfdEKLHyVyXteslF7019lJgFBTcy9wtF6GDlf3My3AdHwEv0Qp1RHNn?=
 =?us-ascii?Q?vITS4HLc4ttvMTMLqEXmt1vZGoBduz5l0wAdq1jFszTutT6cULJU4fngV3Bk?=
 =?us-ascii?Q?f3CJtN6Pu4wJ8MduNfZaV6l+7MbBimIyFSqiCTgklC4Q8qZN5eQDnKEMccz1?=
 =?us-ascii?Q?4qQJJJF+WadwxQd6a43Gu8hE+vZuOXKjJ6S2MDfE0YM6DEpqRorQoEEDYH7x?=
 =?us-ascii?Q?206L/tmZvOK1F0cXC2I8Ey5WOUKZv5dnT0frysGq9tWn/+4HNpugs5JFHnm5?=
 =?us-ascii?Q?zlm7EIslIeXxa9iJ8oKtqQJxBXgj5v0xPOsBOzsAlhoB9aou1HLGSvbaY+sW?=
 =?us-ascii?Q?pb28EDbS88AsMolVaKfZF/QML54dlqXwbsLdZboAfqzqBfX4dV8vhsu/9LGo?=
 =?us-ascii?Q?WqtCh9H7rkNwCkfSqxAW1sL5Ur+nDVqrzc0c/PobVrWgmbwyWotfBEXolEzk?=
 =?us-ascii?Q?zsd2X25giD+a7orS/akjYhX/LxEZFa2Q3jjHshRTIOgAtyvfDfAm1kgVx+tg?=
 =?us-ascii?Q?yNAklG/uccVZA2Ffru0aEucrXxv1buwasNOzgm7pubnktZkZXDoOrtaUbARG?=
 =?us-ascii?Q?ZqvACwYQmvWFEz1afBi2eXEWDaCH470CzFNDjXX7gWrAjNVr/TxUgtyA05II?=
 =?us-ascii?Q?xxOeK8UsCRiCC5hMhN8oGRC9i75QxBAZ80zLtLstXV1RTDzSHDQnH3Qy4qOd?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70029a0-fbe9-4f0c-588a-08da92a7080c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 21:05:32.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKskvmAbvMHwcTt8yZYER4AerGe1KiOsFPsd6gPrjC0BGUWnpfb8Ipgzx1Z61FHHqfMcDUJTCNMpqkFcrmu9smbFcKaOjarUlvy6hiJVNNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090074
X-Proofpoint-GUID: aAzhNCNoXsDA9boqLQSjQZtlaLT3pj3D
X-Proofpoint-ORIG-GUID: aAzhNCNoXsDA9boqLQSjQZtlaLT3pj3D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86_64, when CPU or memory is hot un/plugged, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

When loading the crash kernel via kexec_load or kexec_file_load,
the elfcorehdr is identified at run time in
crash_core:handle_hotplug_event().

To update the elfcorehdr for x86_64, a new elfcorehdr must be
generated from the available CPUs and memory. The new elfcorehdr
is prepared into a buffer, and then installed over the top of
the existing elfcorehdr.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_MAX_MEMORY_RANGES configure item.

With this change, crash hotplug for kexec_file_load syscall
is supported. The kexec_load is also supported, but also
requires a corresponding change to userspace kexec-tools.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/Kconfig             |  11 ++++
 arch/x86/include/asm/kexec.h |  20 +++++++
 arch/x86/kernel/crash.c      | 102 +++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..cdfc9b2fdf98 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2056,6 +2056,17 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_MAX_MEMORY_RANGES
+	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	int
+	default 32768
+	help
+	  For the kexec_file_load path, specify the maximum number of
+	  memory regions, eg. as represented by the 'System RAM' entries
+	  in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
+	  This value is combined with NR_CPUS and multiplied by Elf64_Phdr
+	  size to determine the final buffer size.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index a3760ca796aa..432073385b2d 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -212,6 +212,26 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
+#define arch_map_crash_pages arch_map_crash_pages
+
+void arch_unmap_crash_pages(void **ptr);
+#define arch_unmap_crash_pages arch_unmap_crash_pages
+
+void arch_crash_handle_hotplug_event(struct kimage *image,
+		unsigned int hp_action);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9ceb93c176a6..8fc7d678ac72 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/highmem.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -397,7 +398,18 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers = kbuf.buffer;
 	image->elf_headers_sz = kbuf.bufsz;
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+	/* Ensure elfcorehdr segment large enough for hotplug changes */
+	kbuf.memsz =
+		(CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
+			sizeof(Elf64_Phdr);
+	/* Mark as usable to crash kernel, else crash kernel fails on boot */
+	image->elf_headers_sz = kbuf.memsz;
+	image->elfcorehdr_index = image->nr_segments;
+	image->elfcorehdr_index_valid = true;
+#else
 	kbuf.memsz = kbuf.bufsz;
+#endif
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -412,3 +424,93 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+/*
+ * NOTE: The addresses and sizes passed to this routine have
+ * already been fully aligned on page boundaries. There is no
+ * need for massaging the address or size.
+ */
+void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
+{
+	void *ptr = NULL;
+
+	if (size > 0) {
+		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+
+		ptr = kmap_local_page(page);
+	}
+
+	return ptr;
+}
+
+void arch_unmap_crash_pages(void **ptr)
+{
+	if (ptr) {
+		if (*ptr)
+			kunmap_local(*ptr);
+		*ptr = NULL;
+	}
+}
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ * @hp_action: the hot un/plug action being handled
+ *
+ * To accurately reflect hot un/plug changes, the new elfcorehdr
+ * is prepared in a kernel buffer, and then it is written on top
+ * of the existing/old elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image,
+	unsigned int hp_action)
+{
+	struct kexec_segment *ksegment;
+	unsigned char *ptr = NULL;
+	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	unsigned long mem, memsz;
+
+	/*
+	 * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
+	 */
+	ksegment = &image->segment[image->elfcorehdr_index];
+	mem = ksegment->mem;
+	memsz = ksegment->memsz;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("crash hp: unable to prepare elfcore headers");
+		goto out;
+	}
+	if (elfsz > memsz) {
+		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * At this point, we are all but assured of success.
+	 * Copy new elfcorehdr into destination.
+	 */
+	ptr = arch_map_crash_pages(mem, memsz);
+	if (ptr) {
+		/*
+		 * Temporarily invalidate the crash image while the
+		 * elfcorehdr is updated.
+		 */
+		xchg(&kexec_crash_image, NULL);
+		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
+		xchg(&kexec_crash_image, image);
+	}
+	arch_unmap_crash_pages((void **)&ptr);
+	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
+
+out:
+	if (elfbuf)
+		vfree(elfbuf);
+}
+#endif
-- 
2.31.1

