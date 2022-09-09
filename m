Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EE85B4141
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiIIVGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiIIVGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:06:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB62FA6B8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:06:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289KYPfs024029;
        Fri, 9 Sep 2022 21:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=6sX57zMlfVQd5esi94BIoHPKWCtyU4ZJiQ4IbJb9ETU=;
 b=1L5TJ7DRGHAFK9qO4y+yTW4EBZjJwO2btGaEtbGpXusK2Ka8bsPcWKxHyPii9B6iT0XU
 Ty8FYIW1Yaxlzr4bQPI5GTPjxGcIrj81LCGMaiFY/sPJA+trGxmA+Vdb3czW8FQqw/r1
 oZutu+bBLY/hrHJ2KTVOPcOnBd8uCQ8zMskkm2rwnnGRxjdb6gEox9YXRLzzcP1SkVgS
 WjH5HODEomBktD2/OQ1WOS6VdEDHe8sCfNFeT2EFahFr0PLkTUyNcs4O/NaWjW11BHQY
 R+lEDf8gQ6ZjdxnxkPc2pLbZMChSStj/Jvu3oWfyHbmMBwPYVnf+X2qiZzEd6A7WAQvr aA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtar3ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289J8fu9029278;
        Fri, 9 Sep 2022 21:05:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcfa2e7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3p5siGu9ptFY4YTmE/D22PQ894W7s9fMawDm808sgqCPjIOcKG2uAcZVBoRiTfxWKD/ZTMPB7CZazY3jKd5fwFhJl+9cyLRTyRYaFha1TV9qyHEuWHnhJaPm/Rx0b++gzKPGXKCbYG+09FdoUtirOwKPHXQTBrEXFhz4DROybpdoFUs2uC09b1/q9P/dkYzpki6C1Vxpt38Z2tP9C3cqLxrNdl5Vcy2KGs0eUzq5reN9VEf3VBE96nSwBm1xw3xlg+DqWfIqZvwK7LAVGVAWxuuUBxr7dmfu8LfUWeq7a96IXbnkCcg9QmpYVgRwIZV2h4OUmgLSx0Ym0HJpeXvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sX57zMlfVQd5esi94BIoHPKWCtyU4ZJiQ4IbJb9ETU=;
 b=SpxF8qQR5BDrKN8PnOE8tvjGROp6YliU70cmLqpye0zN1hLIK724789DtfRuvz3prLuIItPPA/sx/Aobrj879WwoJaxJk3zwdcnvzhtxqWh4MYESzTl/SXTrwtkWgc9uOjjHXqC5XSrr7w/TkVkMDTI+EmVXy3ddFyCQIpYPI96wda7/z0f/HiSvoR8AMiYqZA3FkV91UIAfH3CNprLWfGc4mnDDR6k1kfA565Zc3qSEm9Gn33rAmCK0z8EvhGLmwwSiil9ft9Q+NaCB7ddT/8/HNLWNnzRtAZHYqwNcoYanuHnWByAv5ABSA3zRPhoSiJVbsHEvuTBUfXFoVavmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sX57zMlfVQd5esi94BIoHPKWCtyU4ZJiQ4IbJb9ETU=;
 b=xtXgbvCarW3NqlaAUQSxgd4UwiF3iNtWHI5b1zCMW69xq0WRX+QHVevz/WQN6NMpQyw0H/3UCrSU3OzpDIioiRXDjDRPUQGTyJ2jYKVVlvOwTxIy4SnE5cBULYFTC406LZ2yesg7KtbwrKd4dDyj4wTa33AFaafuSaF2ABED0Vk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB6777.namprd10.prod.outlook.com (2603:10b6:930:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 21:05:22 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 21:05:22 +0000
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
Subject: [PATCH v12 3/7] crash: add generic infrastructure for crash hotplug support
Date:   Fri,  9 Sep 2022 17:05:05 -0400
Message-Id: <20220909210509.6286-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220909210509.6286-1-eric.devolder@oracle.com>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:5:54::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ad04f2-881e-4bee-abc4-08da92a7021a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcnJgEbhtG73E3cV+S062itOyFQk5FMZvAToZU85z757fqogPZK3NZBmpw2KK3ei8yHX37LpSO90Kgz3j5pIjJU6oQ8An+mdFmXX4o+UN511S8UpBAFveZXN9TbPz2L/tzKbudkPjmEurSx885l422OLPh8zJo9THDz5zQKLDnAuB/VCf2Bu9oUDUMS5mVsFPL+i7RBbYUSq+9aqEdVYCPTOe27gtDQi82UyWN34By36vKeURMURZWRct8O7oHHClUJqJ3wmUfLrv/3uqJBK25CwyI7dSmZfDutyP4YyZoGzskP3RQ9XOItWEBgFcrC0ZxWQGp4mlVlgLPfERYZWR1O8CMaTYqTurDG+4eVlKQCXoq7F5RRq0hyAmBRydqn+qh+FfdxblchqwYilggu+Vz7MJNLpqLLYrqHwiWJUmWvsRQBBuJjfNnMZ4golBFBPUPZVY8jD7+sI10x30uS7IpzfhppAhLdJUlnN1VyFdeON5bLBgtkf+l6VmB9bRezzPFaqIjb9xTVoqhpAvA7RZ/mqNwUj2IIgp2LnQcyRRxJhLYnUjXu6ufYonyzJvQtogC9q0rXvfh6tCCsR59O7JxmImZU6X8uRcc56oPJ6MSa0/hiYY4U6pABUXoo8svC+9ieTqITatx/DB/bZs/2uu8BfOm5iTr8s7agajZB0OC3sOvNTy5SLbudO0FNk+sNgucNPL+0OUlC7fc2SNGKf4giLt4eTphxJaMFyhiCO7EyROUrSh5gc+WPj/zOMDPEsNujcCWQTBjuzIH0gcf08RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(39860400002)(346002)(26005)(86362001)(6506007)(41300700001)(6512007)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(38100700002)(8676002)(66946007)(83380400001)(66476007)(4326008)(186003)(66556008)(2906002)(8936002)(5660300002)(36756003)(7416002)(316002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2ixkRXUZbdwnVtIVwx28tAY0oA1oRZmdBAdvWm4P3c1J06XO5I9HciX27eQ?=
 =?us-ascii?Q?OICbwrGq8qTkOpG69oxdvvCLbafEmn7dvzRnO2IKBA4bBS/AdxfbRFZbpOkz?=
 =?us-ascii?Q?YbsCrAowFeZCy37Rnh2VRx+LIRNhPkQYj5ygOBUz73ALSRnzOEtj7ECci/92?=
 =?us-ascii?Q?y6uihTckEiXMzfh7vhG8b4EiB2AurmevAnSKapXDi3cnr8eszlwR4GwVmsgE?=
 =?us-ascii?Q?+EY6Ez3mbq7pZbWaeo+laU+XA2g6mbKa5FA+6Wk95Thy3Dh9xMUj/q9cLd8i?=
 =?us-ascii?Q?bRKXYWIRX/z/zm2GQIEKpP4cQrLgc1Tc3GjdvhWJJzCjYI6gDH+sIcVxxclO?=
 =?us-ascii?Q?g/F8xcDhoCdMICgE+PfAP/PG3CObb4Nt92OGlorWA4pN3CS8R7qEVzoHTeqJ?=
 =?us-ascii?Q?dSgeYzSawkjOV5CW949ixfSe6/efc6ZrG8MM8yMgG/3wtDRVQICNLrZYxeUT?=
 =?us-ascii?Q?01/nYQvJG/DmS2wnENs8DzlJe9vb17x5u02bvwv216AWjKzJe5UqR9jrDZxO?=
 =?us-ascii?Q?HgQiZbBvWbN83S/Iv3ZkXfck53sfSrcBBkRi+EyB9ETLNfqKkAD53eWo5ORr?=
 =?us-ascii?Q?GOhiIYCsxDvaHUXV0iLiONqLN+UZiZ1evfSXIp6hN12IJjorWGT8jGac7yq+?=
 =?us-ascii?Q?7zP97a/Xtfc694SPwtv2KkDMpVHy3QQE9ShOuTZQHngLlcURYAh4w02sqzct?=
 =?us-ascii?Q?lM/NOv/KRFE8LpRIgmb8ECZIkbj1mpcyGenpcAmzSVrZ2ID7KVLdPQq8kXyz?=
 =?us-ascii?Q?B0ORUUjRQL69SsrLsVCgQ6e+oW08KW/zTD0WC5yxnoUKHQzmOWlme7fdt9Wk?=
 =?us-ascii?Q?Uy60HJGOJMu+CuXELUUW/oRcIhFBdoHUiOy9FjDsNshRulYtp9U8AXNGaTw+?=
 =?us-ascii?Q?Eslndtv5+GpWvkFJ17NIR78Ty5jWogWLTn2eZOFpoIpiuWr9rmjJf7fqLHOR?=
 =?us-ascii?Q?ygFIkFieVfG3BzWOdS0gh7qKvo15HBW2pLpRu3WeyctE0P9Qgm71fJS/eEzw?=
 =?us-ascii?Q?QiFUMcQhdPyqzMx1p09dt8/Zls27/neVecCYe/Vj4Xd2Dhuwx2zrlMkFPFnh?=
 =?us-ascii?Q?YfIQi2zQy53D/i2lzVT2691gttsvUZHQXusFAuAUyPAtuq7SniSow9Eki/ce?=
 =?us-ascii?Q?TExTIhkCxTBJWzUAuQNx3RqblLSjKzIfCXN2HD6zK2KVvRLULBvYa9zHewB1?=
 =?us-ascii?Q?OHkjD/9vbM5Lly5cfwH3XUN4c8B6zrtGCZTUeXRQzyLo0GLc45glRikJpm6A?=
 =?us-ascii?Q?E89oHqky/VRqYjzp2ge1o6NUEYFx6cwflPgR5QbrK1pCLbWFns672Xz8Jv+f?=
 =?us-ascii?Q?oONc8Zvdj9XKKsOuoVff3IYvsTBHsb3UFpDw7TWvjr5a367l2Jc69mcNRHkW?=
 =?us-ascii?Q?BNKP4bBQ1NK5YcX5wQGMPp2JceDEDJAP2Vy4Mlb18w29+hlj8TTYF0Z5SgLW?=
 =?us-ascii?Q?XmrpdXgIJr8A7SqswsGTvAad5BmOiNrMBqI1wqWEW7rtJp9hNTeCv8K6SCy+?=
 =?us-ascii?Q?u8h8Qv+UO5UQihHN/0WyYBXVBySrvjpVgph68DlT8VpR5g4xymgQUB83fdii?=
 =?us-ascii?Q?4+1FkDual5DePjM/KruxyKkGSeeCyMFCpzmvsKPkaEphW6Afs10B9dbJuPC9?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ad04f2-881e-4bee-abc4-08da92a7021a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 21:05:22.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RT3VfrlqvvIp8SYSeLi4HVsIS+AQPe1OU0I9PT4mI6idhegk4V63xOw68AHvNGW88IormF5wH+F3PmTKKCRYTCpbRbMeb9rH6Ibvi6ZbDMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090074
X-Proofpoint-ORIG-GUID: HoVzPPw4kh_Q3WsH5OVj7-OjIoypXSw6
X-Proofpoint-GUID: HoVzPPw4kh_Q3WsH5OVj7-OjIoypXSw6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
process, the kexec_mutex is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |   8 +++
 include/linux/kexec.h      |  26 +++++++
 kernel/crash_core.c        | 134 +++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)

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
index 4eefa631e0ae..9597b41136ec 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -374,6 +374,13 @@ struct kimage {
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
@@ -503,6 +510,25 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_map_crash_pages
+static inline void *arch_map_crash_pages(unsigned long paddr,
+		unsigned long size)
+{
+	return NULL;
+}
+#endif
+
+#ifndef arch_unmap_crash_pages
+static inline void arch_unmap_crash_pages(void **ptr) { }
+#endif
+
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image,
+		unsigned int hp_action)
+{
+}
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8c648fd5897a..4b15d91f0b21 100644
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
@@ -612,3 +615,134 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+/*
+ * To accurately reflect hot un/plug changes, the elfcorehdr (which
+ * is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources. The elfcorehdr memory is
+ * typically based on CONFIG_NR_CPUS and CONFIG_CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	/* Obtain lock while changing crash information */
+	mutex_lock(&kexec_mutex);
+
+	/* Check kdump is loaded */
+	if (kexec_crash_image) {
+		struct kimage *image = kexec_crash_image;
+
+		if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+			hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+			pr_debug("crash hp: hp_action %u, cpu %u\n", hp_action, cpu);
+		else
+			pr_debug("crash hp: hp_action %u\n", hp_action);
+
+		/*
+		 * When the struct kimage is allocated, it is wiped to zero, so
+		 * the elfcorehdr_index_valid defaults to false. Find the
+		 * segment containing the elfcorehdr, if not already found.
+		 * This works for both the kexec_load and kexec_file_load paths.
+		 */
+		if (!image->elfcorehdr_index_valid) {
+			unsigned char *ptr;
+			unsigned long mem, memsz;
+			unsigned int n;
+
+			for (n = 0; n < image->nr_segments; n++) {
+				mem = image->segment[n].mem;
+				memsz = image->segment[n].memsz;
+				ptr = arch_map_crash_pages(mem, memsz);
+				if (ptr) {
+					/* The segment containing elfcorehdr */
+					if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+						image->elfcorehdr_index = (int)n;
+						image->elfcorehdr_index_valid = true;
+					}
+				}
+				arch_unmap_crash_pages((void **)&ptr);
+			}
+		}
+
+		if (!image->elfcorehdr_index_valid) {
+			pr_err("crash hp: unable to locate elfcorehdr segment");
+			goto out;
+		}
+
+		/* Needed in order for the segments to be updated */
+		arch_kexec_unprotect_crashkres();
+
+		/* Flag to differentiate between normal load and hotplug */
+		image->hotplug_event = true;
+
+		/* Now invoke arch-specific update handler */
+		arch_crash_handle_hotplug_event(image, hp_action);
+
+		/* No longer handling a hotplug event */
+		image->hotplug_event = false;
+
+		/* Change back to read-only */
+		arch_kexec_protect_crashkres();
+	}
+
+out:
+	/* Release lock now that update complete */
+	mutex_unlock(&kexec_mutex);
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
+		break;
+
+	case MEM_OFFLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
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

