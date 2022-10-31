Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA78B613E59
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiJaTg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJaTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:36:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B56F13E21
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:36:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VGwxLq014793;
        Mon, 31 Oct 2022 19:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=qpHNkl7oKOlGdHK/zehSz7eT7IweqVljWH+57bbI55A=;
 b=Qje6cT2KyBHx1I6IhlTHC00obnhk7XaED5PUkw2tfZKtwEx7cS0AB5ovvpFFFwLsa0BU
 u+9MT/hVy9tQdE+voUM3MKwbRspxRtOhrhzUKIVJxyW13JINPK9hmHWmS5YPSII50WCG
 14D1fO+2LCLpLJvALdsmZqxOF0LoJAxFipNiaKrh/sxoPr+xuH9q3pmE7mz9a9nbJLBh
 8gw+fHOwj0t8HSv8vPKXezduX9M+PfoPO4gwAZTpSAtwr9TPh5sHv8xZ5s6NMtUXf2NL
 5br8iznn7DCRKM97CsjMTc+8bJcs/tix7XHu7jW0j8xTd8Bvf8Jn/x+oZXm7OGXn6ZxS UA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2acn7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VHTkAj037528;
        Mon, 31 Oct 2022 19:36:32 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm3nqek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KM/UzlNfFSnXgfvJ1v7rw0XmP2r5tWmIwEUhq7CDf44qzLTPKTVhPStEzknpRCqtjrDdWhhHgkU9dpd9r8624UHLAv+gM2ew+JynFSlV0FAbNnRcOnAetmHECZ2yGTAiLh7gY4VFkkfU7ckxALPQ7sIizglrhU/L/2X+ktJ3XpLzPxBPBh2GOU/wvjuLN002Qp3IVPVPcM2rl4PW0zRa/qCHgKLUUfEesnoZNRX7YQVxZw/FytEqmoQfXL1iIm6rWs6XlpJCW6/NJIrhm2MOflOGFGnlcudApiuTJLaf/unbInIzksv7jCb6lqz3oVl0MwONA4uknAYlSZY1FeE08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpHNkl7oKOlGdHK/zehSz7eT7IweqVljWH+57bbI55A=;
 b=QcZXpoH38dSnE1KTvS3LlLXBxJuK7ooEx9zJNHsmcRa1hTmTlYjeUuXl1nb7B5l7ZGLo1Px1GEk9+NSNebY7LoJAhqNzCGudZ1OnLGDMqmpkKlqtOhyjOEh5O+vR+dZ5UfKQHQGf/wI8siQsms4E/pWcXiarHj/i/lI4lCbEiCb+1MrzVaTkjP7n27U6H7qWBV9VFGiZauSQA0GRdBWaZFmAW0sFh9hG5Keg36awjyy5gP1t4wryrOYynGmNJgGT06pgY3gUMtJnA3LP38Ca7EK1qFFmUkgzMWTjxexTSUG8/P/9AI6dOp6jMiT3RjFOyxulpYYdGyCk5zfljtbweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpHNkl7oKOlGdHK/zehSz7eT7IweqVljWH+57bbI55A=;
 b=mbLVpqtCRzi26pZxaufEqjp6XaIZt2aS0teo1SNER2YH+kYEPbif8HJ94+ensfbvbEEFHJYNWyQ/Jm+dK3QHUkGEyjWDkrnzMo3hJnm9e6dyiU1gZi2fm8PmGZuDsCDpRAMdjGZ6l8DUYWyMn8AFLl0xqRm4TCkT4he1MBzmH2k=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 19:36:29 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 19:36:29 +0000
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
Subject: [PATCH v13 6/7] crash: memory and cpu hotplug sysfs attributes
Date:   Mon, 31 Oct 2022 15:36:03 -0400
Message-Id: <20221031193604.28779-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221031193604.28779-1-eric.devolder@oracle.com>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:806:d0::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8d6f90-f7c7-4fd3-3613-08dabb7734f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ga1DccLzHCY6MtZiilaOaPg8GnoEdjMYwe/CDtcqJBUCKtJQ1JSmmtCS+Y0XvErbLszjUVXo8AgW1l8NbYGYjDLdFCBnoscgeAOehAzbmFNZpHXRnOqWNDPF9QwihyqmFmEHtR2FQQkhcIXtA6POTLxJeYIT7ZyQozw1rGIO2cFPuqkIhrY5JyA0xaRhczLrgdCgAuhPICA7KrAe/7tuGA1fKuy8c2AttyOJTLhk40ekNFdZS4bLXGN/9NPU/2BJQvIPs0W0RGZPZ9w0T1vXCsbEg51k8zp9t1z0Ietexw4a7k0gC3V85Fuo3jUIetszNyWDMkw1hbRzh90hGNOFstYqnmNfqW+A0js7Wr4fx25EIuYCq0qV58gPfQY6jRaP5E2ZFaHyFdE4UMl2U7rgo6BvjJM6eiT3IFhKI60mL54hwvETjdLQzqbzd9VD1eD51jgSOM6H6PThkm7bxeVsd032mzcuAC0gifgChePAux9f/FkiX2GSskuadAN11UMRvpU30l0RGT0AKDQInDpA1viWoh7Js4Md9h60kFqOAaZfBQt0Y0dyzeep+QROJ/6HT+OTfKNjcPU4skx/OgAK17fvO+TNxAr7lMPvZFKJHJ/infeJ9zUBxDZMLa5EVB88R3Th9d+3aTiedjcQfTTTT9S3SUoSCGqW5umHQwupBNtHXn4FN7dJZ2yp9Qm8fsFLDEPoL97gsGs8EipSYBnLmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36756003)(86362001)(38100700002)(83380400001)(2906002)(6512007)(186003)(26005)(478600001)(107886003)(6666004)(2616005)(6506007)(1076003)(6486002)(316002)(7416002)(66556008)(66476007)(8676002)(5660300002)(41300700001)(4326008)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vl40RPAR3SzedBEHqw4jfIvJzQQyYGhqILFaCsUelDOTtEVuq2oJJ/XXO2i3?=
 =?us-ascii?Q?do+xoUvFtP+17tBlb0Ms3hAbIQxuPzNy1qrHntXADexjzVi1uvSmHx4ghNsg?=
 =?us-ascii?Q?9tMGMNU4joHBnhNkShMBJR6LM5b8BBl/+uXZUNGF9v1EvTwa1DkW7/o/XuO5?=
 =?us-ascii?Q?h1o9cnYOmz19vtcFTo18U43Ckbn+J4b/3iJkfaQT7C52EgZzkkW5034XxhTQ?=
 =?us-ascii?Q?D+plb6iUqXBH+JYjbKqU1PmcbSSLmnmqtSs3b/EM5pNVkv4CyLHrvOTapgdI?=
 =?us-ascii?Q?JDlkoKTNnzEk67GSjRgE/OFOf3cAKy0ooGJYpV1n9nzWVqOmnvQ8dYKOfTSx?=
 =?us-ascii?Q?uyO8B+onV1LpPhyf0782BJ1Mp5lXCd6CoFyAyqnqgGVVrwJMQFyFf6m953qV?=
 =?us-ascii?Q?XQc4Herl+JhJCruylg2ONrDnMuARlful7QSSfCiGYG+XXAmTQLtrOtwlITpr?=
 =?us-ascii?Q?HxKZQhSNStwyiuCiEpTkK/hp3O0ZmAVGlpgScOvyMqFfm5CiEFCWtUcoj/hJ?=
 =?us-ascii?Q?JiCujidO3sBOZL9hV1qbtSuFZQ+4eKn4VR5bpwOeiJ4JMhj5dJCfHr6ovrhM?=
 =?us-ascii?Q?Vbch7XHnxJ2XfCEJ5bWTfkPxbt8Sh9WR5ghRSy/C9TXbMktsKVWwzO2Ba3gk?=
 =?us-ascii?Q?g9ziWQVJpBKsZn7DDE3/11Y1XS2hnnOeCYtj5CMWAVvoRt+bik892gGYJK3/?=
 =?us-ascii?Q?J3ezM/Ps0byHI2xdFM2JWQlagNG6cMl93yhExCcaFuSnzVICmTk4YFeaNaKL?=
 =?us-ascii?Q?ErcNpGEXzXI6T9j3xDdQ2tr07dh2WKJ7O1XVmDfdTRyt5NwY8dYxHXNSseeF?=
 =?us-ascii?Q?bQROei8ueu6aA0DLuP7C7V5z8Hl1OMSDp3DfSFfajHduIJEV0HsBDHSNp1Jv?=
 =?us-ascii?Q?LvD0ab/Pt2Baa2DSxXRCQpcthFj/2aODowha5ScjP1EQbCMGkF2DZqsWpGDK?=
 =?us-ascii?Q?bGj8go7pYPAtj40o8uu8IApG8g68PMP3tvtVADnro8/lA0SnWVvlWQUgblAc?=
 =?us-ascii?Q?2I8UTDLR6ZnfXufHBaKCZkKm008c1NCjE8pTy+K3HHsDVMtyUXpNfP4+qmrI?=
 =?us-ascii?Q?g5ch2x2A05c6qaA04V7LG5eCqmSmBNxInwKyHJ2W4H00XINlVsbvISCDAqqI?=
 =?us-ascii?Q?YLJuLP5ATEVUhnLShWLRRYdWDEubr1EssOuP4uz/J1/NfhNl9aOWe3IN8Doq?=
 =?us-ascii?Q?E6KopInDLZL5+syd3r7QxIMtJmDgEgPFx3ndQDIRhU8KGOhft5uwZgPWyFQL?=
 =?us-ascii?Q?yP3b4jjHLed7m0RDgZWImHdZkeNP4WhrgEDUBootlvKXnkuM/lq1brJDqkZo?=
 =?us-ascii?Q?5+uP1M0owM46brnPryZLePHJ750DR92cbBptavT5Q2lBH5iEsVGQLHikpwKR?=
 =?us-ascii?Q?FuXqWT28wtVbrVq/z+xwoxKjLIsU4CDMj/4T1FC4o0Kx7Hx37w3lEb2Q91QW?=
 =?us-ascii?Q?d4yYSqaalDfJ70YbP70wmGBcsbMfKcKa9rW4qJSc6N0gGD2sKwcBh5OpgJX5?=
 =?us-ascii?Q?OJ37FuVY4EmLy1FdEFbMCupy9mhqGiWXmVyy2f3ZkeoXEg3AAgdrraMOJzDG?=
 =?us-ascii?Q?bZskBdVmtGCIIdEQkocQ6mG7iHhZIafYCW6s10P9e/NriaSraL3s8NTzdQr0?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8d6f90-f7c7-4fd3-3613-08dabb7734f9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:36:29.3095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mEEO+oV/a1I9lRdXBUZsYWyK48Obe9E/p5xOEGa1OBNWjew7KEqvM2r7CwKjarbSTurC919C1HWYGY6FhLGLG3jlXmcpUq36LMLZZvdJh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310121
X-Proofpoint-ORIG-GUID: FFcZNLO1OhCnBGK0_XpvRpmyRehwqI0X
X-Proofpoint-GUID: FFcZNLO1OhCnBGK0_XpvRpmyRehwqI0X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the crash_hotplug attribute for memory and CPUs
for use by userspace.  This change directly facilitates the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/memory directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/memory/memory81
  looking at device '/devices/system/memory/memory81':
    KERNEL=="memory81"
    SUBSYSTEM=="memory"
    DRIVER==""
    ATTR{online}=="1"
    ATTR{phys_device}=="0"
    ATTR{phys_index}=="00000051"
    ATTR{removable}=="1"
    ATTR{state}=="online"
    ATTR{valid_zones}=="Movable"

  looking at parent device '/devices/system/memory':
    KERNELS=="memory"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{auto_online_blocks}=="offline"
    ATTRS{block_size_bytes}=="8000000"
    ATTRS{crash_hotplug}=="1"

For CPUs, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/cpu directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
  looking at device '/devices/system/cpu/cpu0':
    KERNEL=="cpu0"
    SUBSYSTEM=="cpu"
    DRIVER=="processor"
    ATTR{crash_notes}=="277c38600"
    ATTR{crash_notes_size}=="368"
    ATTR{online}=="1"

  looking at parent device '/devices/system/cpu':
    KERNELS=="cpu"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{crash_hotplug}=="1"
    ATTRS{isolated}==""
    ATTRS{kernel_max}=="8191"
    ATTRS{nohz_full}=="  (null)"
    ATTRS{offline}=="4-7"
    ATTRS{online}=="0-3"
    ATTRS{possible}=="0-7"
    ATTRS{present}=="0-3"

With these sysfs attributes in place, it is possible to efficiently
instruct the udev rule to skip crash kernel reloading.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel handles updates to crash elfcorehdr for cpu and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above change
tests if crash_hotplug is set, and if so, it skips the userspace
initiated unload-then-reload of the crash kernel.

Cpu and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule will skip
userspace processing of memory hot un/plug events, but the udev
rule will fail for CPU events, thus allowing userspace to process
cpu hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 14 ++++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 5 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index a3c9e8ad8fa0..15fd1751a63c 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -293,6 +293,14 @@ The following files are currently defined:
 		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
 		       kernel configuration option.
 ``uevent``	       read-write: generic udev file for device subsystems.
+``crash_hotplug``      read-only: when changes to the system memory map
+		       occur due to hot un/plug of memory, this file contains
+		       '1' if the kernel updates the kdump capture kernel memory
+		       map itself (via elfcorehdr), or '0' if userspace must update
+		       the kdump capture kernel memory map.
+
+		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
+		       configuration option.
 ====================== =========================================================
 
 .. note::
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index f75778d37488..0c8dc3fe5f94 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -750,6 +750,24 @@ will receive all events. A script like::
 
 can process the event further.
 
+When changes to the CPUs in the system occur, the sysfs file
+/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
+or '0' if userspace must update the kdump capture kernel list of CPUs.
+
+The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
+option.
+
+To skip userspace processing of CPU hot un/plug events for kdump
+(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
+file can be used in a udev rule as follows:
+
+ SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
+
+For a cpu hot un/plug event, if the architecture supports kernel updates
+of the elfcorehdr (which contains the list of CPUs), then the rule skips
+the unload-then-reload of the kdump capture kernel.
+
 Kernel Inline Documentations Reference
 ======================================
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c98849577d4..fedbf87f9d13 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -293,6 +293,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+#endif
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	&dev_attr_crash_hotplug.attr,
+#endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
 #endif
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 9aa0da991cfb..226be3134ffe 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -483,6 +483,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+#endif
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -881,6 +891,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_MEMORY_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 04ef5172c4ba..e2dbbcbf37dc 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -542,6 +542,14 @@ static inline void arch_crash_handle_hotplug_event(struct kimage *image,
 }
 #endif
 
+#ifndef crash_hotplug_cpu_support
+static inline int crash_hotplug_cpu_support(void) { return 0; }
+#endif
+
+#ifndef crash_hotplug_memory_support
+static inline int crash_hotplug_memory_support(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
-- 
2.31.1

