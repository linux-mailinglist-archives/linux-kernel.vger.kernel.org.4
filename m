Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FD86485B1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLIPiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiLIPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:37:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E0A1274F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:37:44 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9EwuRh012939;
        Fri, 9 Dec 2022 15:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8fn0OgLdafqrbEqTBykFAXsK60pu+nR4QoWYtl0oVEg=;
 b=gPX479diGK5pY/7YKnM5K650H28xz/rEsRGpfEJS+RVztewdT9khI8s+ArJmymlscElw
 1etIIbO1BAlwYqj+ZZJlxuSMc6+EH5TPc+fh2DQOTdx++VUBYrkk7bxhoy5ECG6yRswL
 6+/1zeKy6o3hXQ0XEwwBISOuRI0/ANIw+TXI7HcRGqb4nJWOZkd203wK405lHCld/J+m
 vvmJhZ2t3nzH5O98liQhMmarRo5s83L21Bh7buJM8CqrO9smyHw732uCZRbaq2q1Ki4c
 YSniGXFxAC4C06FNgnTS+UdiLtp5oR3PaJ4qFWAtbog3J8R3jHk2cUHVJcSyzX/Tj0UA +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mauduwaae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9E6Bjn001744;
        Fri, 9 Dec 2022 15:37:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa6cw07w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktlDoL+jStk1HHNYyBXTJ++YkBdxsWeL8V7bn18OG3KLXjELm8iFXFU+L/SMXFfjTm/zOf45/JhsZk3Xd8NjFqjqR9IVvUOhbUYuS80pWftu6wnGg4WmAXJ4dJiiFvVPaQ2abiJyHUw5kVzcv8Ji8g6o6UnFYUm+8muvbBu7c24Dk7cU0SQOTvDeQ22Fx8u3T4Dh+PJj3USTqWq/PjSCpb1sEUpr6dWM+6hYBmx2C7NidmMpjT/mPi/NvA1oQtqiyuEs8vgkk2xmuA3c4lgbK+QcIkPLhctRTcf4VcAUMSCzEyXV1/GsvMKUl0e6n9GehQ4tb7zzRvR7oW7iVMqm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fn0OgLdafqrbEqTBykFAXsK60pu+nR4QoWYtl0oVEg=;
 b=Jm2GuQMvBx+kBO+jk8+HG952NB+ln1Id8DWd+QR5AJZ+FDHeP9XFLGelcGg2DYKECNjg4IB7bYKyOB0mgIHTbpkbMcJWZ3bEz9H5RIG9b47xmTs5GBuRrKpssx/wwWE/YhK1KNptskGQSZATp2vFTyUmDr/y1Giqz6eXNXqH/vmC6M3c8v1FJdZRU+X0pP6csilOmZ+rGNNcsP5eDqwMjaX95DYDt6IsUxxzzpzvhNw+bvEEprf1hA999oTnxUbaaPeTzPwqz/HTIMBhW4gOaWIU2PtT3ijF4HwUTKHQ/WxMgr1TgMmJA8HEoTpVDmj9MTgfCaAZItScqBatA98f0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fn0OgLdafqrbEqTBykFAXsK60pu+nR4QoWYtl0oVEg=;
 b=WLz54XybSUMJjO5a6b8i5MZBroDKsY6BfQkvj8J5Ty++irGRm1j2581Sn6Kr1322OYIjBpCiIMhVV2weq4BcNnzI/o1iGJJZ0uagqnDK7BYWpk59G7uHt66sa7WyShFZhkshoZ+MXb7UjfhPaJ7PV9LRFYwQCyHM0gRmj7cretk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA2PR10MB4666.namprd10.prod.outlook.com (2603:10b6:806:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 15:37:19 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%9]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 15:37:18 +0000
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
Subject: [PATCH v15 5/7] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Fri,  9 Dec 2022 10:36:54 -0500
Message-Id: <20221209153656.3284-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221209153656.3284-1-eric.devolder@oracle.com>
References: <20221209153656.3284-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:806:130::21) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA2PR10MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f5889e-0726-4507-cb5c-08dad9fb417f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVLSKRMyaV6Wiw6BsH4lklOk4j8Rr9kBUpJbmxw3wrEbMZUBdXoFUiOzCr+y87uNlCdPx4RyO9nyqu+pzFgpDuwaJO0MHolip/ePHnOXLRHeLwwj6ldZ0LGKy1T3MEeetbxmaO15utPl8LlrZSRh9i9yAlQG7NUir1gXKWi4MKksbo4GxXyot9A5UE2rtniCBynma1GzMcg09WY163N0ZPQpZhE+jvOo+4wksiKQr43Q+oA/awH+pkrPxYkZnP2uH7GfEhzVsB/LZPJCHEjhdqm8ZYHsD6cahhD4Pwl5PP4TjWLZUH604y/kJR4ZlLga6Fz6mtQujJJL3VxQAakxyNLY7Yiy7YyK/JbPvRNy37baM00Jpa2oPAy3GceLhrHW41zIyZL/MgCijUYCdFVyGdo1/2uZRnQ5Mkkw4mrH7gXpmsxLgkuLKZWvNzzOHKiyyT2c80n4vvH8+pZ6cZ3l2iIwAQWL8qxuYeIJUSfo+mrFcRiutzNXH14AhiAnXs/Suja468s2fZ5urg+2UXqFlZU0eo+qdYghhze7qZqqQnX0jSRJKVb3Q+zKVoY968FkMi28t03fQboKvQChwDoDWhX5EiUDa59EUvP6u1WpoB7WuU7QIwPJO97sGf7dWEOr9CGIWTcjWtQuliztODM+EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(107886003)(6486002)(66556008)(6512007)(6666004)(86362001)(66946007)(8676002)(478600001)(4326008)(26005)(316002)(66476007)(6506007)(2906002)(1076003)(2616005)(41300700001)(186003)(38100700002)(7416002)(8936002)(83380400001)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2R5i36JxyR7ZGCroteYlISO/nWbd2mymlgAiiZjuZx5LIzIxnh3vsHPolN9F?=
 =?us-ascii?Q?PIU05+oi04jKhVEt9FJuU68/FRlXDWekJuraip9jh+vji6n8/H+y2z5s3sx2?=
 =?us-ascii?Q?5AoqGjXKcac6p7Ktri8huNG1cIWON9gafDw0uqSFLH9G76Yw523VjqGuiKKw?=
 =?us-ascii?Q?ebqqPZpqc14QBlPQrHUy1eiVDd1e+vc3U+/GSQFhddj8wNNPWVEhZzTC4u8S?=
 =?us-ascii?Q?MTwKKxaEkU3ou7E9ajo8IZzCzty2Yf5Oe7pSZ8K+lPAu2QG92/+aVq2rt9uY?=
 =?us-ascii?Q?pHoCHpladW/rcn4ilcD2ziouFzxY/n/jpPYaUoREXCVlM5qGBSPDddFRMhAA?=
 =?us-ascii?Q?6frU4SysFUb/0HKx966VG1N1eWhl+69MrKfhqyD6LEqB5vXsrOzGTyjUEtaa?=
 =?us-ascii?Q?p21pifvPipxh2W7x9Na4g1H9644JztZ3ePmcRUyLrqvbfyXWJhrROEg1d4PJ?=
 =?us-ascii?Q?gUvi4aAoA8BxkSCT8re6z0/r2JDUGcl7dYHXncmX1QdlC++IunwWyGsDmuWg?=
 =?us-ascii?Q?AVG0qknfDJ5npYvhEM+ucpKvBOaqAgxHMfZZvjFcnRRkZRPnIcWag44rSw7W?=
 =?us-ascii?Q?zI/P1sLUhXFGv6kuRo2nroJRt8qelLdDJXvwzl5BSDGRKH4f53o81y2f09zJ?=
 =?us-ascii?Q?5IsSHmBQS2bSNGgd7wls3yOcD0IajSmHzS+tPLBgT+H2DhPv9A2WikoSp+FA?=
 =?us-ascii?Q?Izamo/sDxz/gYiQmgvs/3O53mVhL1wjMQMbMtiiYEu3ffxRt5Wf0ARKUdj4/?=
 =?us-ascii?Q?XEWo6ZF0pYaEO0pKykZqqRBnzVdZF3CCDpvHzXYAY5bMP9+ABD5pPvuzkHhj?=
 =?us-ascii?Q?ake/z4PD5Zq2IKXrbS0boiVneGKM3hzUfgIkgj3YijjcaXlYOBfbJ0v/51dm?=
 =?us-ascii?Q?MwTs5ray9r/9vQCWBosalUu7GMytwiS2XGfDQJtU2jVn5Mx2qYLEhUxdEQZU?=
 =?us-ascii?Q?P715Td9oph4+XxG5mNOjSYI9fMjg7JjNXMLidxbIR82i+WogN1+kfeRFy57q?=
 =?us-ascii?Q?Q/xQ+r/6LuAeQykW/5Sywrh6Ey8Jxze1zsz0SgnPVf343zsx9kjHbqsAa9yd?=
 =?us-ascii?Q?rleNMceEGGENnKPjSvmXZr5M3gR0HbEzA8iu5zZTAO+ZmgYE8srVKw2RJbc2?=
 =?us-ascii?Q?7DdsnKb7bO3h66gfJ2Ff0IInB75ZbHcXDj6XyC8E84rnBnUlk1S7Yu1QbLK0?=
 =?us-ascii?Q?ZoIbV75G678FtXcka6aD3W+VtTJa6dnn4pA7gOYVgMWpztwNpDxcYUsEqNxU?=
 =?us-ascii?Q?OWdkWLbECKv0e0LJPUOlVK11zPjsLwSUBEfNZvZ0j9EuLvj+scCipQkinwbd?=
 =?us-ascii?Q?ifgS12ftq7hI3DLaEBFMcy3wSEQLtOX8lUScrpZt5JmEuuLRNRPe9nolrmhI?=
 =?us-ascii?Q?WrkmmH0Sey1P2j/dVakHnqPJk6a6MFgK3RQw22AgOj1ud9PyvIniOp8TiTbf?=
 =?us-ascii?Q?TcQQj+jQXx617hqF5KlVCl6uwcmy4wGvI//8DYYDNHtkTa/blWGM58Pa7fTg?=
 =?us-ascii?Q?bkRP1ZCrLpPkJsmDXhL0weCTLBIo8x8tROmQD35E9m7jvIbCJf9QW/bmfW+c?=
 =?us-ascii?Q?GXFSoEQJDLE3bqcXsn5gtYjQT+O+e+2kOUemKQ4iEA+EKULgt+n7eEB3EMJH?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f5889e-0726-4507-cb5c-08dad9fb417f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 15:37:18.8227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUUo0xDGPDZEfd8AjDHP6TOVqHDYgmey3D+1lk7O0da+1X/iEvtNN7XusYpOpGjFozZGtfs6Re7cfpEI9/e2AW1diMKGvApnCw/Ja0NTT7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090066
X-Proofpoint-ORIG-GUID: iH4Eudp6XglexdE29Nw8PTPYYXpDtBmr
X-Proofpoint-GUID: iH4Eudp6XglexdE29Nw8PTPYYXpDtBmr
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
 kernel/crash_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index fcb642a03d7b..189065afd04f 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -366,6 +366,13 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+			/* Skip the soon-to-be offlined cpu */
+			if (image->hotplug_event && (cpu == image->offlinecpu))
+				continue;
+		}
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
@@ -683,6 +690,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
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
 			arch_crash_handle_hotplug_event(image);
 
-- 
2.31.1

