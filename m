Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A326B613E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJaThI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJaTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:36:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643313D2C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:36:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VGxIus001192;
        Mon, 31 Oct 2022 19:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=HjGyEC3EY1BLiDghbfvLGskatQA5K0dXMtWdnVdNgSo=;
 b=j4vbCtJ2fTVXPSZsXtxrfHAdxg9izY3VlU0raPxl2tn6dYQ/w07l3iz3a7EF988/ds06
 xkGczUohDzYXgKVBNDvgs2oni7gRme7E9v7wqXtPNG3JO7Nu7uaMVjJfuXMRKgaUnmIk
 MEa2eP1oKIe2sXzmncizygfYZx3Oe0WSiOcZIM11lC5yRGp+O9xQAPWPDwWVBKt1ndzH
 iBpYYasa7ueIV6HDw76k7ulNZjWhuHihqcT9mrfzlNjd8xXL1aWJNqzoPLt6ZIDWllvp
 hfMjzNL7fWDflmtkehSu40mGdB43Dgp6cGGrMBxCL9SImR+cGPwkbbH/VG3VK3e6GPtx hA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtcqty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29VHTkVj017099;
        Mon, 31 Oct 2022 19:36:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm9p3yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 19:36:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cciWdOizku11K0HeiNxSFmAarV0JT5448XI4oLxM2VBu43W72UPV0SAD+XjvREcGBI7KW5paJpG1tk0iR860RFsVzs61DMRcDOE2W0V401H1+n1nesapd2j+9xsSqCY/17gsZHt+ARsaZAWXPV+kWX7KgMYVxzJbYvZ276kvWYUztKbnLu1WNQSOJyH5dgwjSJEitA5wPPjaEKmbhPIq2LVaA0KZg/S5tLbLkxw7K1S1f0dssXbopPHHK+OdvbvZBCYZWqBGatA0aU4LodY+EaXzQsVtW3HHSt9GQPlQhJl7Lr9V7pcjlyluEZC6XjMMjT3vdTDSo2gFX6Z4eptv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjGyEC3EY1BLiDghbfvLGskatQA5K0dXMtWdnVdNgSo=;
 b=eqFIB15+KJwUvqPANujKK6hbLmSgu/FosDilBfveNky4r+GAPKMFVnoUf5SrbIDzyqE0zKGYSyKpp/iRYM0RQH2ylAwuHrR2trfE2od7ZXOsmsRgMv5jZYUoW0lx/WE0PWjT3Uuh49zbdizAZuaRkuIyvwwNouoTzOBH9WP0AJ21JLHnL+W3P8X0zP8XYi9ft14SuieesH3+66CaBfYwKTwYD0068EohQQ6wkX7v1fjeA3YaNxFcYHu0Tq4A5wt5raibhhwxzUUEaMjXYylCgdwOdfQ39DmqxinUHiMJ8IOlB90MAb9313L4Q0RGseDwLFf0NzYfEthDVGXbevwklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjGyEC3EY1BLiDghbfvLGskatQA5K0dXMtWdnVdNgSo=;
 b=imk5W3v0+WjHnB9llW0kcWWmbdAzL6mW5MNqqhDwdmeSYs0kxTOke8JZPwQ19VHasnxNUdZlLOUQ+X6zbxbtZchm03SNKSJR1VSfrUtpyZunOjuEJCROJWofjQ9y0hsAn1mNmcdYl5KckP/bDw71RVX3/YWtB86JE3RypwiHLf0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4228.namprd10.prod.outlook.com (2603:10b6:a03:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 19:36:13 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 19:36:13 +0000
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
Subject: [PATCH v13 0/7] crash: Kernel handling of CPU and memory hot un/plug
Date:   Mon, 31 Oct 2022 15:35:57 -0400
Message-Id: <20221031193604.28779-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:806:a7::17) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: cae7918c-b810-4439-b8ae-08dabb772b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaFmZCNe08L08gUgu33UFo/SauP5CX50SXfdt46yON8lwopq8Qse88MgBaHvkhAqhgxJPCECTRDzPthBgOSyROABT7sPCak40h4cd6t3dntSaKeVCV/OTEe+ScbtF9T0ukV3n/30R2g5B8cZHH0U1td5eyst3JEaXuIGvxd0+UB2VS0qvZLWdPS3V+1qjiX/roSSge9/VP/jo5qs3V8dVF6RRaOQ3YlGBCX/ktxHhyg5h2HnhiB0FrOZqytJk05bW+mBwO1t/iHgQCbzq3dSA6eyVoSpJO44QcJnSzXkrUwtQ2WxnCGH7vM4Uk8rhCc1HZSrNiIr9NnKS9qGkzMNBBWwVPKrwfTh8w1rFlgdBAMjHT3HzmHBqoQ7BtjxHML3HSXZ4GmlmLwv2Z+gYXXQJsAYSHEoSiMV4P07E4PoKgV3n1SBSdIpWkXw5wfmajgDwtYHiZk6fCxSx9LEOZpADU1280bGah32i4cPhlq7LsHU34iTM3k6WvP9LOkcke0frm9Mpefwdl0AoDUxi6CkN8pz2E92sc9isQoYDDXH0ZyLF5QTDJXKsTOcvBkgyVozxhinI74ZBs5AeyHwGR+CMrboQw7x3ydInH3usBHUyDGAy8Gi5J06pIf84Ab6tUSJugMn2af4ud1V4VLKzj7FTe6BTkFJIPUVLYBCvEXviiHlbe1I8NjE8B95x+Hem//WoZHuYUbdTmBjT7BwCRF0O2jdYkMKc8hEqW9LftFPQyysxW+/t0hgVPcOh1z0P8gu8zn2r8yCDV9MdlVEU6I24Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(36756003)(2906002)(86362001)(83380400001)(966005)(6486002)(8936002)(41300700001)(7416002)(5660300002)(4326008)(8676002)(66946007)(66556008)(66476007)(316002)(6666004)(107886003)(478600001)(2616005)(1076003)(6506007)(38100700002)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p9X3XnsrEvf9pQqGcPtTiyPEbKJSZsDTNAEelqvjRfJ64bkOjNEMpDA9gGJJ?=
 =?us-ascii?Q?/PMvtSBUGPN5qDqSmPX4CP8YbfmrsMo+nNm020HLi8ZOyS+H8dTAuDPydf2w?=
 =?us-ascii?Q?9Po6hwtc+R0ivfFBji19l/JNsBnjk3Olk3kml+/Oe2SDQJdBtRHEYSeMIELj?=
 =?us-ascii?Q?heq3Of60m4dnzrL9wiJ49CJ/ytpNnpu2MhCAcAD3NUXVDyBPrYXyxoU4vhm0?=
 =?us-ascii?Q?gJqrp5VFiHPDxgYWWYMS1FaZ3jhWWItktXIOnC1JD2pmRryCmnRBKPvX8UkO?=
 =?us-ascii?Q?HKaSk9VLjvsNs6NOQZf2UWhXotJr48ve5FDU8sOkXaT7zIz2jpnxKAqD7n5s?=
 =?us-ascii?Q?XdWeja6Jwmj/11WWaKtqKVFog1uy9nu0E2udtI0y+aNICQy2btArkH8kHRb5?=
 =?us-ascii?Q?f8HBq+TbiMBOxjqSSWkhRJUhvy0ramPUinJzwdQWyrxdKermFg1suQKVUWKK?=
 =?us-ascii?Q?JuO8btqVdO6BH+b7Fz4BCRiMLelkNnVdja1XDzGHK6RwcMBniae/NGI5rDwV?=
 =?us-ascii?Q?XmwPguEnyLkIbacVpjHrpM8fmapX2uE3GNhmi3rGi4fIwXP0kHy1yvSGA3IG?=
 =?us-ascii?Q?jgP/TJM18WhVfdvkssbXBIu6UXXwIYtmRePymXGF8ssPfZu6jVcrkEFhwQ3H?=
 =?us-ascii?Q?iTrxypTNFOvaEVhaV2wZKBMWBLT4IXWb9j/vqX/+d7AGfqCxyKx99wSjGSQv?=
 =?us-ascii?Q?Nw8VjYOoP4/98OzOtz52Kw6s2ttXyt3Gq61Zw2gOvhGi6jR5kWqqqjDche+N?=
 =?us-ascii?Q?aiX8PEFSW0xkO4DIOmJ6J0Ma/HIFrlMWPnsTtO2ismhfFwIyLMszR3HgxqU0?=
 =?us-ascii?Q?havUbUUWgy9cE9tHKwXPk1XeiUDdxc6Juv8+acZkFDp6wYw8TlTbkEt0r1Rj?=
 =?us-ascii?Q?20kgePQNGgMP/g/CpNbGnzGzYGxFymo1HoO1AEw39ucHTOOQQ+YK6Y6GXKFt?=
 =?us-ascii?Q?a1RqH7be5uMyeab0h3egFIULSMZWTLyYpKMqcapG0gC6NQXj1DHRq5pgkFmI?=
 =?us-ascii?Q?wtXcSL/ktMypF7JK3d9DiEJzAIoekPbHdWgSpugKUxV4kEs4oG3vfZoBLXWW?=
 =?us-ascii?Q?HquIFc3Q74sEYbV4uF6/sig9+V8VZ+tUeVtivdJCChy3nk6FdcEp5u/hv4xC?=
 =?us-ascii?Q?zxlBGqlEriIobA+1+mkoXDmfEHr7pXpkB+bjTVZofabzHjGRxeKno+EASFTI?=
 =?us-ascii?Q?nBxcd4gdGE8BOeVAIvSNP1SHKtZHUed/TjsSmfCf6cK+gylb12cbeDhFJHmS?=
 =?us-ascii?Q?tCk0o24YOR2p0tox7IxWqifd720V2kg2Dwwqv5hGtt34OTYuOBrpSAKnrYbu?=
 =?us-ascii?Q?arBKvuQIjtcD9FpxJ/HBAppaBUwbzW0y7MSSEyVBnpTtwbyEX3FURzV2n1VR?=
 =?us-ascii?Q?vwfOkdqNb6GojDE1Nm+3b9OD1I/kykTQo5Ie+hXscAaorDcvlh4Nf8ZW4V7W?=
 =?us-ascii?Q?NlDqc8TB2XXr3wKYNXffXX4v2b6Wn7ob5VeF48WV++NQBM13cilATnsGEUou?=
 =?us-ascii?Q?a9gknuO66ZfcH4ISTFmICB33kvOqsHFPmcr/Pi4iwaKlyfWAXGyNa+QmNbyI?=
 =?us-ascii?Q?Fyv/0FaWW/qvOx5aXGgIYg6PZiOs15rA766c4nB0N03RvzEfP8RqfkOHyQUv?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae7918c-b810-4439-b8ae-08dabb772b11
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 19:36:12.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhHYQBX0qaCcu1RV3g5jkqaoUF3ZV4hFdIUK59uDJGcU2lh73C3k4O8PA27/JTYhFLqMXdyWcq/H9UUg3Ztu+PT6sc/Si68K05X4c5OnVAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_20,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310121
X-Proofpoint-GUID: 7usC78fON-1bwIMDlireQMKqa4Pf52I4
X-Proofpoint-ORIG-GUID: 7usC78fON-1bwIMDlireQMKqa4Pf52I4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kdump service is loaded, if a CPU or memory is hot
un/plugged, the crash elfcorehdr, which describes the CPUs
and memory in the system, must also be updated, else the resulting
vmcore is inaccurate (eg. missing either CPU context or memory
regions).

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, puratory and
elfcorehdr) by the userspace kexec utility. In previous posts I have
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash hot un/plug handler that
registers with the CPU and memory notifiers. Upon CPU or memory
changes, this generic handler is invoked and performs important
housekeeping, for example obtaining the appropriate lock, and then
invokes an architecture specific handler to do the appropriate
updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no
involvement with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel handles updates to crash elfcorehdr for cpu and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   These lines will cause cpu and memory hot un/plug events to be
   skipped within this rule file, with this changset applied.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2022-October/026032.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v13: 31oct2022
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---

Eric DeVolder (7):
  crash: move crash_prepare_elf64_headers()
  crash: prototype change for crash_prepare_elf64_headers()
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  crash: memory and cpu hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 ++
 arch/arm64/kernel/machine_kexec_file.c        |   6 +-
 arch/powerpc/kexec/file_load_64.c             |   2 +-
 arch/riscv/kernel/elf_kexec.c                 |   7 +-
 arch/x86/include/asm/kexec.h                  |  14 +
 arch/x86/kernel/crash.c                       | 110 +++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   8 +
 include/linux/kexec.h                         |  54 +++-
 kernel/crash_core.c                           | 255 ++++++++++++++++++
 kernel/kexec_file.c                           | 105 +-------
 13 files changed, 502 insertions(+), 112 deletions(-)

-- 
2.31.1

