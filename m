Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0D25B4140
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiIIVGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiIIVGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:06:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBB8FB8DC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:05:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289KZCHK019141;
        Fri, 9 Sep 2022 21:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=nDfhuNR8Bi325xS4LParTGWnLZO/UF7r52FLekK3jHo=;
 b=Enqpc35zuif7ySz3SfreCgUj1ShKsLgVapxRhAHVWNuehb5Xd2Him8lG5a+R0D3rm5hK
 xhSR5+1e6+u9RbX3Ho06MD1/nms+yqivrVRT8AaKJNiKPoIhXhTkX8Uc0HACLsEiQYFe
 rX6Z1QIX91kU7ryWI/IUQXWVO6RFg7l99yMJZhB4J2/eILXElY5ga3RMyJc2pS1Diwn4
 WMWbbEDVsbWUYqdl6zeKAgfOAfN64imsQY2ExKjH+zbWPkypJGX+Hc0p3wqT/CICcjvf
 mH4OlvHCu6N38LRUv9hpk4so4Nzzg1sZVIOuqX92z02cxkGQIhCpZNfdUKouMOPFLJ48 Iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbcfwba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289IhAaA036950;
        Fri, 9 Sep 2022 21:05:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc8p862-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5noRTXGGmkzkOa7Yp9QN0eebbkbIGgTHlZAFIM1QU+AhPkxEl58x8rV/6scwWwOXbonrohVuNZnDtLm5mqYNK7XTScjsN6Ra9H7yTRLasagseqtKV5GYtBbo0WufZE1GU2UO9lDTIELsJ8+Npxd35kEBFnvYMCx31itsOPxkdKPJlamKmwUTSOiqDg5ZBrewDz3Cv5X3mZ3TECDK6mytqcxa2vMgArFePjSb6S8HkQ3dVPayFUrTgwBik/n6msTCu8y/tYZ5lZUewnkuqESPABpRaFWduTyJOht9VsHWzrGtEeRO7BoZ/cTIuq0pwSYi9QViBot5OaxALBIXa2d7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDfhuNR8Bi325xS4LParTGWnLZO/UF7r52FLekK3jHo=;
 b=V/jfaLWupaZVewZEI2s8j0Jmb6wECDMfs7NlQN84maCGU4n4TNJNF4wiIEEI5duhfWHqz+gV30z5agZRf1ovrZ/zo7xYXsmAdWK82eL7btgW+rdPYsPaqKS2B6vXeUqrD+0K5fa88JfPgUokSV2lLKVChSIrqTDwLvUM1JylysXomlkRs5SjkeRe3LUgX0wxQPQdMNFOJFcYwIXGTpHsASax+Uv3WGr5RePS6TJsgFdaJsD5LMxbwpUdg9kWwxClXp6aFHPuoyE+eueRLkE+MDHpXcf6fH2I+VdP510RnE0jOPbG6/QVjGK+Co3qIHYOFGd8XTV4UuupAHBSsPcKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDfhuNR8Bi325xS4LParTGWnLZO/UF7r52FLekK3jHo=;
 b=y3NZo52PWJzDZkrnC0xHTDFCkvDUC3ulZMvhlljdHnKfKmVnre+RQSm2EHDEMf4DkMF7m23+jHGf+hlKqKwcLxTnqpWwNDf57hYdmkRJ1m0CEHe2pfKaOlTk5XI98geH4trVjm3JEfQRH6cKt/wXSjVdvtToRYNdpR8hdPvbi64=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB6777.namprd10.prod.outlook.com (2603:10b6:930:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 21:05:14 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 21:05:14 +0000
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
Subject: [PATCH v12 0/7] crash: Kernel handling of CPU and memory hot un/plug
Date:   Fri,  9 Sep 2022 17:05:02 -0400
Message-Id: <20220909210509.6286-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:208:120::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5aa4f7-d3a3-4c43-88f4-08da92a6fd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muRSnvuD7ZmofqCyBlOeIYYO0JijX/y/IB9u5vjfG30dpgoZyttpbvwUHY5IzCqKJRlmac7UItCE5uZUSb4os2FUC5RmCKrsoj9HPxLsHPTbg4zTSyJQ2QLVz5r+XLSTODpxeXe2PuxMIgRZEz3nCURdaacRImd12ukHseKPRXkMgGnl3zq432Xe8v9UoX9vwCPh3VfNmkMg65aAUZwzOTQoyku67kKsWlVSw/YJW4WQp4PkXRL5JlXqM3S4+MqW7BwMy7gY+9E+l0op5TXAjafWg+WBTRjfOb0j2romX4BgMOHLNROXH4tz20k+2oC8Z2guZmupOGivLJ8wyVtyOJbkzmADaJasRCPZwpAE6xOnRGdWxiNKRBNOO7Bd1SN8j+b1X01LiNL+0pJ2/wXiL38YjY+I3lkTxIOjnE72KnDV2X4JqjTgyG8A3JzWxFUxBduHvOlyQGJ/LoKZJTBvGnvvufFHFFRXIZ7Bk3xQOAAbt7sjrhtqgvclEIFuwS+F6HUBGBH0xL7SG36DepwlfdAc5F3W1qzrhu6KScUQm0wa2f6bLOFMZeIZqw1Yh0Rsz8uSqZYyBHKcAMPQNoRIh4avlzCoYFHRQVd9kYSmIjBmXGw1R2VzW6Sy9PPNr7bsl/u5MZ+Or4VpqoybO6DyLNvPD9gAdmgb6g85yUIJqRnqcDFvt+glhHjcwBO21qvjt6aD2DTaiu8qNsPmmm3DFGDYmGau7yNNa9CoNQwyaVWe42YsOCRycaYyrSlGccVPFqjO/xscSVF38W7WjWb0Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(39860400002)(346002)(966005)(26005)(86362001)(6506007)(41300700001)(6512007)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(38100700002)(8676002)(66946007)(83380400001)(66476007)(4326008)(186003)(66556008)(2906002)(8936002)(5660300002)(36756003)(7416002)(30864003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D01Q+3rTEkkWMe4EkrnE28osqb8mHIL1SKDk3sqzn1F2G4cSBC8W+5GfdR05?=
 =?us-ascii?Q?//6pkWWg2uCSwDioCF+JVKhNPNZ7KBfWa3AZqg8ZDOdeiXJd6DBQDLcCVmvI?=
 =?us-ascii?Q?YVZS2AKp3YTYyzZPZK6PrLXnMGDWYUA5XnObxcGk/J8sDqS0SRgS2GmFYvws?=
 =?us-ascii?Q?HuGC2kCDt4VyXeQklio6CQrrn5I1cpLu6nOPmtZfWgY2YgBcB9ul5ORtLTY7?=
 =?us-ascii?Q?1VjqkSfKrF4PQmmyaVLDY04drGtd/0xHC2P34xn6D8mZn6iZWddgmwk3eNJ8?=
 =?us-ascii?Q?VDqfhyicklqpHaZVQ3XqKjMPniuNpUvmaxxsnwGs8QmdICH38e5+J+Di4GKA?=
 =?us-ascii?Q?7VDvf2NH2JFljoZaQWBIVa8K+QGQBFLgmYpQONCKmn8rTELBEzAbHNDklQf2?=
 =?us-ascii?Q?A9rkDGCnhW+6Rymscd56qFa5V9HIKLnzq6g5SIgZnw1EATVmyt/ILQosOjmO?=
 =?us-ascii?Q?mxHwHYWjNtXr8kByIvG2IUZ6VFUFRUXRtxJLvFwd+p892169kEDNBsYqSvgH?=
 =?us-ascii?Q?e85OeBWPouJntwpnm2nHazGhvGwXsPiE9nkaBkxy9DzaqowDhGF5q6603ND5?=
 =?us-ascii?Q?FBiTjboYn9k8Jj9uIU4N6j/bs5dKUzAn5irwqKQJohXSDZGwt3TqVzYxBrB5?=
 =?us-ascii?Q?8PMmBUpD6yAMH9MKzVwGX6lfhKyVlaDS9ifAnaQBVlp9Dft7+7BCHdjRrIIw?=
 =?us-ascii?Q?s4zImIclBdAJDdHKOhnuGibKiTen4UW/5QWeL8GW0jA7z2XAbek2dxIsbny3?=
 =?us-ascii?Q?7wTXDJ7IEaRJ8drqars5NUKZxtaw8kwGYHsn30aBJofYftVKBqoa3MZQxa1M?=
 =?us-ascii?Q?BgmU9+FWVECLWGyqibpsr7qYR7CpJZ58mBhn6HO5/ynriyqtf97L79VrmQwK?=
 =?us-ascii?Q?EhxEUJ7OFqwSAgWfYN2+eunwUyYU7MPciOngvjxNKYQa4r3r1EZgeFBCZBqt?=
 =?us-ascii?Q?/vqxsvaSHJ5LyAmhgVADYSjU8ZGbB25iHsLBP9tOKjhe3Bo9VJKtvKXSkZts?=
 =?us-ascii?Q?+dTI4QmP7JeXd7RUCyby858VNZ7zDWXQ2FgCInCNfVj0JFFn3FrsNbCixPXH?=
 =?us-ascii?Q?ZvqwfCKxzZtaj8M6AgvwZt/bqKEbGlPf/GbOeDNV5+zPGLq4qJDhw0Ldgb2J?=
 =?us-ascii?Q?TFsn2ZpY248UB7bQ2VKYilCg+hK8RrmdFh66KQ90125k9oW6WC90VbS+3vav?=
 =?us-ascii?Q?W6HKYyLMJVBiJ+Ho8y6kVAJ4yOulUEadXm5p+oBIZybUkkLdYFL1HwS3cwpY?=
 =?us-ascii?Q?tsuLovoIII2UuASRlIr7rfhLizaGvYDHw9MWW1gJSlOu6/YgzB8Bxj/5tRgO?=
 =?us-ascii?Q?kz8sTjBON9e8W7jPvlxHWncMK41L6W4yxdrLyjo/Gus7XzgkyHDb7vMMk80b?=
 =?us-ascii?Q?ZNUsmo/LkIipjuFUHNuteWfl3GbrCAHjQaihKeIykckS/eLByJqDIl1xPGGB?=
 =?us-ascii?Q?vTSTQDxmPuWro5qMvHq9CDf7eSlO6kI6I/wIhbq81t6Kb80o3z6Be0RP91E3?=
 =?us-ascii?Q?n6Br84l4vJmmIZBRP1pFtJoyJhHLl5Z68T5pOFBEMhKLbqQau43KLAGL5/ZP?=
 =?us-ascii?Q?CJGAipBDcgChSoMxvAhobdqrfumnIEcZ1bFCe3Vhf7kHoYFCU81tiuo9JAA+?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5aa4f7-d3a3-4c43-88f4-08da92a6fd93
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 21:05:14.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxOtml15HesIzFx49dF6gD1Bj9VWPnCvQ/+hC8Pd/0Ts/cELyLBkj0D8L34y0NuGMI3/0qkzueObK85cSE+dcK4/856jq16cTDKHmamdEsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090074
X-Proofpoint-ORIG-GUID: agbOpGgVwuN7Af14yN2dDjLVTruTgEso
X-Proofpoint-GUID: agbOpGgVwuN7Af14yN2dDjLVTruTgEso
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
of the kdump image (e. kernel, initrd, boot_params, puratory and
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
elfcorehdr, and overwrites the old one in memory. No involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel handles updates to crash elfcorehdr for cpu and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   These lines will cause cpu and memory hot un/plug events to be
   skipped within this rule file, if the kernel has these changes
   enabled.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load syscall.

This patchset supports kexec_load with a modified kexec userspace
utility, and a working changeset to the kexec userspace utility
is provided here (and to use, the above change to standard_kexec_args
would be, for example, to append --hotplug instead of -s).

  diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
  index 9826f6d..4ed395a 100644
  --- a/kexec/arch/i386/crashdump-x86.c
  +++ b/kexec/arch/i386/crashdump-x86.c
  @@ -48,6 +48,7 @@
   #include <x86/x86-linux.h>
   
   extern struct arch_options_t arch_options;
  +extern int do_hotplug;
   
   static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
   				  struct crash_elf_info *elf_info)
  @@ -975,6 +976,14 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
   	} else {
   		memsz = bufsz;
   	}
  +
  +	/* If hotplug support enabled, use larger size to accomodate changes */
  +	if (do_hotplug) {
  +		long int nr_cpus = get_nr_cpus();
  +		memsz = (nr_cpus + CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
  +	}
  +
  +    info->elfcorehdr =
   	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
   							max_addr, -1);
   	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
  diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
  index b8bb686..5e29f7a 100644
  --- a/kexec/crashdump-elf.c
  +++ b/kexec/crashdump-elf.c
  @@ -43,11 +43,7 @@ int FUNC(struct kexec_info *info,
   	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
   	long int count_cpu;
   
  -	if (xen_present())
  -		nr_cpus = xen_get_nr_phys_cpus();
  -	else
  -		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
  -
  +	nr_cpus = get_nr_cpus();
   	if (nr_cpus < 0) {
   		return -1;
   	}
  diff --git a/kexec/crashdump.h b/kexec/crashdump.h
  index 18bd691..28d3278 100644
  --- a/kexec/crashdump.h
  +++ b/kexec/crashdump.h
  @@ -57,7 +57,6 @@ unsigned long phys_to_virt(struct crash_elf_info *elf_info,
   			   unsigned long long paddr);
   
   unsigned long xen_architecture(struct crash_elf_info *elf_info);
  -int xen_get_nr_phys_cpus(void);
   int xen_get_note(int cpu, uint64_t *addr, uint64_t *len);
   int xen_get_crashkernel_region(uint64_t *start, uint64_t *end);
   
  diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
  index 70fb576..f54a2dd 100644
  --- a/kexec/kexec-xen.h
  +++ b/kexec/kexec-xen.h
  @@ -83,5 +83,6 @@ extern int __xc_interface_close(xc_interface *xch);
   #endif
   
   int xen_get_kexec_range(int range, uint64_t *start, uint64_t *end);
  +int xen_get_nr_phys_cpus(void);
   
   #endif /* KEXEC_XEN_H */
  diff --git a/kexec/kexec.c b/kexec/kexec.c
  index 829a6ea..3668b73 100644
  --- a/kexec/kexec.c
  +++ b/kexec/kexec.c
  @@ -58,6 +58,7 @@
   
   unsigned long long mem_min = 0;
   unsigned long long mem_max = ULONG_MAX;
  +int do_hotplug = 0;
   static unsigned long kexec_flags = 0;
   /* Flags for kexec file (fd) based syscall */
   static unsigned long kexec_file_flags = 0;
  @@ -489,6 +490,17 @@ static int add_backup_segments(struct kexec_info *info,
   	return 0;
   }
   
  +long int get_nr_cpus(void)
  +{
  +    long int nr_cpus;
  +
  +	if (xen_present())
  +		nr_cpus = xen_get_nr_phys_cpus();
  +	else
  +		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
  +    return nr_cpus;
  +}
  +
   static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
   {
   	char *buf;
  @@ -672,6 +684,14 @@ static void update_purgatory(struct kexec_info *info)
   		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
   			continue;
   		}
  +
  +		/* Don't include elfcorehdr in the checksum, if hotplug
  +		 * support enabled.
  +		 */
  +		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
  +			continue;
  +		}
  +
   		sha256_update(&ctx, info->segment[i].buf,
   			      info->segment[i].bufsz);
   		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
  @@ -1565,6 +1585,9 @@ int main(int argc, char *argv[])
   		case OPT_PRINT_CKR_SIZE:
   			print_crashkernel_region_size();
   			return 0;
  +		case OPT_HOTPLUG:
  +			do_hotplug = 1;
  +			break;
   		default:
   			break;
   		}
  diff --git a/kexec/kexec.h b/kexec/kexec.h
  index 0f97a97..b0428cc 100644
  --- a/kexec/kexec.h
  +++ b/kexec/kexec.h
  @@ -169,6 +169,7 @@ struct kexec_info {
   	int command_line_len;
   
   	int skip_checks;
  +	unsigned long elfcorehdr;
   };
   
   struct arch_map_entry {
  @@ -231,7 +232,8 @@ extern int file_types;
   #define OPT_PRINT_CKR_SIZE	262
   #define OPT_LOAD_LIVE_UPDATE	263
   #define OPT_EXEC_LIVE_UPDATE	264
  -#define OPT_MAX			265
  +#define OPT_HOTPLUG		265
  +#define OPT_MAX		266
   #define KEXEC_OPTIONS \
   	{ "help",		0, 0, OPT_HELP }, \
   	{ "version",		0, 0, OPT_VERSION }, \
  @@ -258,6 +260,7 @@ extern int file_types;
   	{ "debug",		0, 0, OPT_DEBUG }, \
   	{ "status",		0, 0, OPT_STATUS }, \
   	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
  +	{ "hotplug",		0, 0, OPT_HOTPLUG }, \
   
   #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
   
  @@ -290,6 +293,8 @@ extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
   	int buf_end, int phys);
   extern void arch_reuse_initrd(void);
   
  +extern long int get_nr_cpus(void);
  +
   extern int ifdown(void);
   
   extern char purgatory[];

Regards,
eric
---
v12: 9sep2022
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
  crash: move crash_prepare_elf64_headers
  crash: prototype change for crash_prepare_elf64_headers
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  crash: memory and cpu hotplug sysfs attributes
  x86/crash: Add x86 crash hotplug support

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 ++
 arch/arm64/kernel/machine_kexec_file.c        |   6 +-
 arch/powerpc/kexec/file_load_64.c             |   2 +-
 arch/riscv/kernel/elf_kexec.c                 |   7 +-
 arch/x86/Kconfig                              |  11 +
 arch/x86/include/asm/kexec.h                  |  20 ++
 arch/x86/kernel/crash.c                       | 104 +++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   8 +
 include/linux/kexec.h                         |  41 ++-
 kernel/crash_core.c                           | 249 ++++++++++++++++++
 kernel/kexec_file.c                           | 105 +-------
 14 files changed, 497 insertions(+), 109 deletions(-)

-- 
2.31.1

