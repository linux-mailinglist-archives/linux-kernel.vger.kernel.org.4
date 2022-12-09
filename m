Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A73C6485AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiLIPhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLIPhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:37:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3541C7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:37:32 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9ExKkw008932;
        Fri, 9 Dec 2022 15:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=rsl8RcpfiOUgAuSWNK+zqn3p9dOeqyjYtVL0gEuZ4yc=;
 b=gSAdifrb/LOpR1fx7a/uA+MZo8nM+zYxehO/laTepM052LbP4yKct3AuXrUe3cugoBJH
 scr7mE4Dm0RzNy1AU9wHxJdfzzh/ZXMZARNsbSHdKujNJb3DD+QI7m78XoTipJboc9kS
 2Z0YRxvN5di920daeCAdqVm7Yt3pHyf1/tLHE/i0eLWBaYfiUi7mGwXGYPvOLTylJc8M
 wIcvyDgQWSXfUzxAdoUAAKE7/mF53Fbrajzg34x3897P5LMm3OJMu1DeJUs8o+caRt4e
 ikDCJ1qdTFMpVPRnlxzxs+kVSaUv7ui9mssrcQKGzGS5wdDd0qTI8YN9I7BTE/oIGEGM 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3maudkdg07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9EORAK039888;
        Fri, 9 Dec 2022 15:37:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8kkt3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZDOd5cyw/WNWCEyuwXojBWE1r9i5RtvDWUjXpfUx3wfcCWcjLzpAk0sAEBUJXztpf7qt65FsdgbFjDvssDuT+MvTrrM1MMlq9Odndh9XsuDRpO0GsImHyjA2yef8S6GkJW7sI8yLXXYib82HMu6JKdsxgzjfGx81ZYRUOOdna89hrzL8UVk4O6Qxh4hsTZsUMQHM5QwV/DzELpIBrGQtGB3NAOcBjwBmIc8oSqVSNutPEF6tkScfncGOTGYqZc8JLobkjVbgetfpWnS+Ep2L4PVWDV+Kktd702uFk2gRqVPsLt39PznyZfykByQd89euX+MHhICzqsSIQ8U0h56EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsl8RcpfiOUgAuSWNK+zqn3p9dOeqyjYtVL0gEuZ4yc=;
 b=dEM3HZYvip1Bqw1TgTarWqCADpkMrxSqVcCLx0JuZSpUjQ5mqfoYrkHP9j5AQMo+5t5OlzmJioBk3oceQhhh0t9u5ZJotgiI1E37OiVDG/1dLskSsERYZzzJKmEUkUnt+TV1lMOEo+bJGN7teAF4jckdF/TdaO2tJ/Kqmy4yeIcLkIZ9/MPUwLL8eUgFZEP6kncBmmAk+Z7ttXBF3RbQL9XHPcV3XQczelWGaR18mYILWsf0jwKLM49l83lCju94dv5IgIVbDVjGwD+S5yAM//VakT2d7Mw9uEei0rz2txErx4mvFi8HLS966/meoyHdyboyNYnGmKRZOP+Beh3hGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsl8RcpfiOUgAuSWNK+zqn3p9dOeqyjYtVL0gEuZ4yc=;
 b=sih7bIA14eSIYPYaB/d/m+SUKcfotVNF4dRRZ8lyR3JzbO8pAmpmhHyjX2CzUO7OubCovWkvP3TPhKSEfYK/OXG0EX9h0kwG/bUFlkzF9tuYXY/uQezBM4zUCcPr/zAirrjYvwALWif6E67ij/MoT8cNdZTYiJB8EiowU2T5O7Q=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA2PR10MB4666.namprd10.prod.outlook.com (2603:10b6:806:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 15:37:04 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%9]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 15:37:04 +0000
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
Subject: [PATCH v15 0/7] crash: Kernel handling of CPU and memory hot un/plug
Date:   Fri,  9 Dec 2022 10:36:49 -0500
Message-Id: <20221209153656.3284-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::23) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SA2PR10MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: 046c31fd-51b7-4b92-1384-08dad9fb38f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQc/GmwqH7S8dhWKU+3zsCEht3gkrx4Dlllyg6h/1r76GYeW0HQSiZoudxAblNT251xoRR5mMMF3YqaSa5X8asq85tmwLnfr7WBkNXspCqsRKc3WLP6m/uE147jTfEZqhpddNdFkHBo229aG8HsX+4dQfVY8s59O05RQZ4deAGE7x893m+KHak8E6MIQFckuWxmvBRYjTN325BnM/py5/reZoxUls8basz0AwVUHi+MDBF/8id1fES/+wHycDun9voqVLdMXuJ7paLO3A2LWjntHIHirPNTmIrDYx869RML9wl33MD9mBY5QmWVF6WyvKAHHBNE+4XEMYr+JqtxnIpleXotbNSLo04AfdVrUAcguYr/egFfxfPKQFeudltgerqbeRb7sHGpIXM6J18fVUBKuFxyULFufe4mtXNFF/VlqrDdijexgGE7p+qrvthwGHS5egMXQ+A/x/03+DolEY6eja9V8QEM/Ktfg4EhQtAiBWmo28Zd6OrWA0FO4JtDDmAMuM691O49rHmrElSiA5hIGki69ZaZyS6d6+vItO/iURxKBjYa9nu2N2HV6I4/7QTKRVJZ6atax4gi+vSZAiHvX77aTyu3o+l3dZfPp8jrjgTCpS84MHqMdxC74xhAqMFSfNnAZmwzua54ilOakoclOGVTe+H2dxW6ZV37IVG8mk0pluHTriydFzM7PDkU0kYpPUDTA4AaNoFKuQIIvCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(107886003)(6486002)(66556008)(6512007)(6666004)(86362001)(66946007)(8676002)(966005)(478600001)(4326008)(26005)(316002)(66476007)(6506007)(2906002)(1076003)(2616005)(41300700001)(186003)(38100700002)(7416002)(8936002)(83380400001)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v68417p4ZUbWKrUD6nd1ICBJeek7go9HPZIeZdzk0CD8QnJrIf4WsaOEKgbK?=
 =?us-ascii?Q?v0IbvY4iq+Ef2VDSjcS2y1SFZPmCXvR921yEbGmoXXZUVq6HQ69ciQiSfFxm?=
 =?us-ascii?Q?YVspimTmgR6JsCq5tB8FeugL65qUdRRZNU+zNKpJiM9A2+cJCeIRQsJ0QCg4?=
 =?us-ascii?Q?MCB+RpZhDjwOB8MdTTnJ0ybJ3Iv0LOWDZcP4Gwo8jpzL1XaeRWCwxqsNuGFj?=
 =?us-ascii?Q?khxkwlrYHmVr4P+ZAQqJw5cP27MRrA8KQGvffJ5AOaB9aZxd1a6nLxm9u3E1?=
 =?us-ascii?Q?B+Wx0bO1hmE3tkVLGDy6Y2EV302Su8qr6xxHyEaNz04bSQx6iaTkiCh5ofjw?=
 =?us-ascii?Q?XzRVlaXaQYwhSX1h2thuu1lDmVwzjbGxGPp4T8UMyxhE8WzoP8IK2TYxgKrD?=
 =?us-ascii?Q?GIh24bAL16CZgYfACl5rceFHhLNYlkyE+72juO/uHorPCkmx4bIxmZYC+UWz?=
 =?us-ascii?Q?sUVqFD5XyQHMmurWydWgvZe2SYZmjAjiakBGqJghTY6olqeQuFhdp/lkiY8N?=
 =?us-ascii?Q?YTyIJP9yr0vMKM2wmEvI2bRwr43oSYPOX80uPdDSNMuABkkiFeJl3dAZsB2u?=
 =?us-ascii?Q?TNmJS8v8o1VUBYUqXqJlLDLUwP9elOqnTyy0Alj3xm2Yf48qDtIdwVtnby2+?=
 =?us-ascii?Q?aABkEn2gngugrJJHPYiN2VVsipaq994YBfv2OyENPu34dvE1CPGdzXQXlW/Y?=
 =?us-ascii?Q?utsyU6L7X8bt3vRIGvmXBXE8tMyeZo5sSvr86zewbPzKds0veCcn7ipQt4RP?=
 =?us-ascii?Q?45Ad7kGpCYwEqcAuBrN6tNli7pE8rZh9jTjvJrOCQSAhXslWKGyzF6IT60Fn?=
 =?us-ascii?Q?rk0Xxg1xMsgiQ94hz4hLBGj5De7TV1pv5cTrtUux401a/d5DTedg8KBmx1kw?=
 =?us-ascii?Q?DfMoYjdg7wca4A0nCiX3xGHP6zSKD+hy4csJlwjhUIsuifWNsZwjKbn4TRcy?=
 =?us-ascii?Q?TjWBKB7nUtfK2PxCLj21qDsiGXp6QHEpx4Lfo/p6euTfs/LAaax5sURTyJfH?=
 =?us-ascii?Q?DFypIa9GOYzRSTSvu9uapkEy6Am3a/arueEDz6Ueh06VFCq//XpndjOLR5F/?=
 =?us-ascii?Q?YD5SEISrQtfnSDVv5VmieHnF5SKe6hUWSjMQwPmLeK1HhmZLkSFxy/dCiOyw?=
 =?us-ascii?Q?DqR0NHYT2N70soauBWVQpVJvJxGeu+6hpjwTCiZv77xcL2vF5orWsCsbFMYD?=
 =?us-ascii?Q?D3dJFPcmtWV2s+0tHGOPaXlXIonujP27+Gx+NNbhqOnEuO1Mr1QT4+D39SHa?=
 =?us-ascii?Q?amcugRaC0OTpelfozS089f7QrYci1jCTgtMf/0eSTtlwcFWIvVJRh0voEnKC?=
 =?us-ascii?Q?WfXI53vmS04bBXMnn9nLNxpcH9JcMw36LjoH5X93voFnrAnbkzm+wNnNG6sR?=
 =?us-ascii?Q?aq3JrdzJbg+w/7EdfoGwmMl7F6M7jpwyfc2CA+A+aNmT02sTbDMoZ3uLkg0i?=
 =?us-ascii?Q?iABfRJjoDYsEkOONJMRsg1bjgSz2g/qAxNA/on9SIlvn5OdmqGJsrRZtut0Y?=
 =?us-ascii?Q?EL75Q6noa6TOuBQniu53n83KcUxlrIDYAVSG4WMtQdxUx39pvPE3V7lSrvgj?=
 =?us-ascii?Q?Lq7Yg1M3RNwkRf6FWISvLPSZm7CzW5l93DVP1lFqFcuhrR3nxhU6ABfdilRj?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046c31fd-51b7-4b92-1384-08dad9fb38f9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 15:37:04.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adsvGO4RnGVyeXvtJqhc7nmVmzk3OX1LL4eb8UN36lbOPAt2bJ9hVwSmPUu5yECzp8HqrPqoJAPa2p9C8Y/2qpwHysHrdXCIcI4VPG2W58g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090066
X-Proofpoint-GUID: y3CnReKNl4chssmi2YkdsqlqAiaNqfCk
X-Proofpoint-ORIG-GUID: y3CnReKNl4chssmi2YkdsqlqAiaNqfCk
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
v15: 9dec2022
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
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
 arch/x86/Kconfig                              |  12 +
 arch/x86/include/asm/kexec.h                  |  15 ++
 arch/x86/kernel/crash.c                       | 116 +++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   8 +
 include/linux/kexec.h                         |  27 +-
 kernel/crash_core.c                           | 255 ++++++++++++++++++
 kernel/kexec_file.c                           | 105 +-------
 14 files changed, 494 insertions(+), 112 deletions(-)

-- 
2.31.1

