Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9656485B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiLIPiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiLIPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:37:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412EA15FC6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:37:46 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9EwtSQ029286;
        Fri, 9 Dec 2022 15:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=d23r4n2Btep+R5WHICPBqORV09vcN9s/Nkv2eSfUn2o=;
 b=EKq1dRmyuXYb6H8HvT2Q39QKgKUwOaAF3oXZN+/ldMQPThWlg8vpcKqyDDZTYtiRYIOW
 JGmlqTESAE1rujqR7qr97LOl9A+SkYpWZwqpoJtFGyCBaICN4UOzWgCvymYaJN/c7rIb
 MGFagtkkQYoV35L/ax0Xixek/9isWstOdI/A2L/ij1cY1LN4BOtlcOXnFWqygec4iHsr
 do6Dll9huJ2y05mQyZgwLYYMxIPfc6n1apssANmVlAPHvG96UeeEjFFqQBpKrM1f3ujH
 cPhfCRoAh+4zFU/SqEcFWsDDtUJsro2yife/wwxs9CV4rtjaioWF17estzHJGqLRsQMr Lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mawj6vgg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B9EIGGm006770;
        Fri, 9 Dec 2022 15:37:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa81gh86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Dec 2022 15:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0vRNuY4MfLE3+tyc5oSuLcTDdgAxd8vA9oYmIjLHs2jDSwgRyhRMaXXTv2cCWZn1HWfXLtmESFQmekYUZxx1TWbi8CtennTdP4n3QB/AHYaVOEQ8CvEkxGSJWYbKfvsXuWytRdWBPqbFbRMbhSCPqeAK9zbQvFD3K/WifzjTF8fbUX4vfInb1sUdrnK4ARfheIDLva9mtNom7vCd2XX85xcKbLdyfK10uzFrddEriJSDMWtoJUTG9iAKCT2uq5tydgqU9tbVWDRg0bQj0yBWAuQuIz3Zy3OQfbu77Sr1DD1p+u/a31RCSk0JtEvw1oxNyXOGcU8SB7AXAv7tczicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d23r4n2Btep+R5WHICPBqORV09vcN9s/Nkv2eSfUn2o=;
 b=KxoRRjnRC7gI2gGq63snLMqqu69dqh+UwhqHXNTFxAXZwamZyyXSu/xn3eeYv6aJ1MZDTDu7ubEp3RsqMaVdva37+Wa4yMT7sdVATVeDpZL+JSb1sIYLOO/gRitJkQgh7drxMhmozYBsY6HtPvWaLHu22oN5c+bBvBnuk2BigX37iAbtU5UoJm622Kj74GRxARPfHluZ6TxRPLs8R+xamaF7c2m+8535cRkL1ll704rsvc6mpksPRo/hgLEdsEr7sen5mzVW39nyNbqsmNdqVpCHFV8tPMTQihKTVmAVBqX85OYDXIPu2UiPfGy7AaA8ohowtjsR0E9VQKpM6yquvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d23r4n2Btep+R5WHICPBqORV09vcN9s/Nkv2eSfUn2o=;
 b=QZG55ahRn9Kj1fkpTVargm6gYYEM0BFS6cCIVNfSfab5VAM0o8THHacYuoUdSKv525mHeJ3IyrQKA2hBrZWEwY8Wq/c9FgqBDaIzOzuHd2TSsMihiZFCoy10cawiy3gMTtrs5b8X8p0Xp4Z3lvwPf5DqoVgsp++9yObhAei0bYM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 15:37:23 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%9]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 15:37:21 +0000
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
Subject: [PATCH v15 6/7] crash: memory and cpu hotplug sysfs attributes
Date:   Fri,  9 Dec 2022 10:36:55 -0500
Message-Id: <20221209153656.3284-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221209153656.3284-1-eric.devolder@oracle.com>
References: <20221209153656.3284-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0097.namprd11.prod.outlook.com
 (2603:10b6:806:d1::12) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e3c043-cda5-4aa7-73d9-08dad9fb431e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7QZW/GAHC0DQxDG7cIAkIooDeglLX6VsMWbfCbuLtgoWIJVQ71dmjGTdUDd6MqRXnDuY2i06WZfgDop2QDH5kPg3XA/81K5A8P4JfD8AlSEGA51+Jjpzj1E12sBlNKJy6NTt29sWk1oofPeAjl3gTYsHg9AIGeRO6P7Ua6Eqz8kN6SqS0AFRJY/+nGMZQVvoVIM+hAm2QNndphwuTBD6lWhK7jvAl7g1lcsoO1kB3NoXcUxw8SqEwn/7Zf/MaJmBMxuFeJw+HnXJVznuM5cBlWgxLWcdjw5SmQRFvEZK6v3B4PhZuloNh3gulNPsnBxZmDb/p/MwllFdUVtZu2HpiGpW5BhaasZMHQ6RZdO4Gnqj6KiuL/5f5zm2aYt8G0B7CheX38TrqSX5WcRTuy8g3WOYbro1/VaQ+pCaccaUhYwNtNti79LeTgwUrZ34Xxw7RkOlU1hrq09gmLpDODophCdtDad30mURLuM1NLBSXQz4/R9p+LPzFpjewgr07RdQ7DUu2PzI6RPA7Z14mWYiSYhJjd+gO9g6bGW5GW485C7GGgIi4QvaGRdGInw/cqGGvrxnY8msum191zYwPIlNS0QlP9VJ4g+dk6icaEDnuZRbgK0aNeQH2oXqEkgGcgumM1GfUIW998Q3BJeyR52LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(8936002)(2906002)(26005)(83380400001)(6506007)(7416002)(5660300002)(6486002)(186003)(38100700002)(1076003)(6512007)(316002)(66476007)(2616005)(66946007)(66556008)(36756003)(41300700001)(86362001)(8676002)(4326008)(6666004)(107886003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BLBlXG6BLpqPXmjWzsTEv1nEyhISd65LA2DvIRFjFyLAWpuo9aEkfyl7567R?=
 =?us-ascii?Q?pAPbbyIhXKcOAx3AWctMtmSryMzdxrADuqAOZ/UOUU0v6kB8yaGyW9IFEyTf?=
 =?us-ascii?Q?1MRDmGWeVsrKnOq1LetcM8iMvO+Q3Kp0uw9+zMukZUICXJXVuwTDiNdbWmOn?=
 =?us-ascii?Q?kIwIQ3/wwHd1JDsY6ZaNaaiywBnJeRgrg3iFwp30U6tfa3C0T1dRnOOfWa8Z?=
 =?us-ascii?Q?JjBEUWYJf0qGHmam2kHhJPKwR5FK9vqApZCCYYHsR50sIu1QOdxt5O00tFNH?=
 =?us-ascii?Q?rxxmJpY1buRveYztEFUQ2M2waSoRuGJWbr1JrBs9X33voTnwotDtT8ctisDZ?=
 =?us-ascii?Q?HZwrkfbIic9zH1d/DOrd5iAS1WFgsJe+dFdCwQyxaQKbqO8Bp4i/1P2qSua0?=
 =?us-ascii?Q?LcA8ZH/JdZgUol6/7AiVGx0FfIP3zyT+xdX7wlhAwfHBpWo68jSLAMSG8vXl?=
 =?us-ascii?Q?yI0JQk2Yjx1GgyOtwHu4XOLDRSE7jPKpo4WS9hv9XNY64Mtmum1PS0UKTSuN?=
 =?us-ascii?Q?hPyio5SMTyVHZCRLEnn0SJ02U50PZMF4VNy1ow70EwppCT16sHTUEYWtxDR5?=
 =?us-ascii?Q?d96lfxVXiGDYTBDlz+zWQ9gYpbn+V+f6jR3LwSH6N791zxTRNvAWaNahO9ay?=
 =?us-ascii?Q?PbkzMhLc2yWpREhocDI6hA1XZi2N/BOKfeZpE3w/X+hjriT2ELsIxhhl4aRV?=
 =?us-ascii?Q?2oyfHo7Sq6mRWfa0qdvU4CThI6BZmdbrTgYru5QHsctzkwnvDqXKuvPdtXR/?=
 =?us-ascii?Q?0mkYoJU7lVmKWL0nmfaREjBbXlZjAJ2sn+rOypGO4G3tctXfISS4/JRAouz6?=
 =?us-ascii?Q?BCIj/KZMIm8Ip/Ey6UY2LF1eDPm9RWf3LdNWH5PNtV2DaMgRdlWpGzVtrzro?=
 =?us-ascii?Q?C0E2t9VzscoQsm+o/5fxJ4yBMK/dv1zfKu/o4VEh1TFrsjIkcV5MGWWgt3Rh?=
 =?us-ascii?Q?vDZZsqg94srKmXS7WGk1WG3w7hhGUCgyRpEyOJWPDjwtl0CYiCQB+0MLxq/G?=
 =?us-ascii?Q?G3LlAITQeHg+8QmlQPSxUep9R3AYvec15dqTQw/iZC+5Y+uBRA0pyB80hFkm?=
 =?us-ascii?Q?KTNh2O0r0WCntvRt9Nh8l6wGRCiwBZJV1dnJoeMohENblMT+etYqHSMBCOG5?=
 =?us-ascii?Q?EK/3zFrizKXluQM39p+kMYayWdW96L2jjJ2w5RwgurFwN6IxdltCW+5n38/f?=
 =?us-ascii?Q?LG/TK9o1s+U6WojlJkXW7LJq0TmHl3mn2LkP0c7LCuol61Ku0Jm2mIiGDo9q?=
 =?us-ascii?Q?J1ytAcu/j1ii1vVRGwa6vEHP8OhgiaAUjRDk9M7Jb6AuXTeLZ2VD+uYpyGKd?=
 =?us-ascii?Q?BUipoqrmZXaJT+fVnalWr0YCgTxTiL+4Wt+LXp9nyyMhmt8eAMJ+dilzVuL6?=
 =?us-ascii?Q?hYHfIlzajthqjE3bVXQsRH/AA5xas1j99dqAjBzj5WS9o8pa/doBz72gd7m2?=
 =?us-ascii?Q?IfaGiMtKtPOWggOiLGyHY2XuOKKuCpIEAKgNoHjH72w6YvLg1pqtiP2+MCwd?=
 =?us-ascii?Q?smKz01aI93VbeEf9oRZvplRNvrl/CBSdXx81DR/z6iFaNV9+Fr49RE3SR4OX?=
 =?us-ascii?Q?Yc32Rc1iwrtrcT68k+pzSvtv8VIEmGToG6o23/aZr7nT1fkQLrWSHCJakQvz?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e3c043-cda5-4aa7-73d9-08dad9fb431e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 15:37:21.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FaXDNthPPaiQ7oq9imSrcpUt35UC+69ZZiAusE1874MuUGSOfBEYRd1kZtYmo2CK5vbxeNS2iqx/1wcc40qlA3r7Y4+WkjkEbt1oE3iQOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212090066
X-Proofpoint-GUID: DR6szevIhxLDDNdfKKwQMqyixoxdKt0B
X-Proofpoint-ORIG-GUID: DR6szevIhxLDDNdfKKwQMqyixoxdKt0B
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
index 389444cb03cc..4d096bc97597 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -515,6 +515,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
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

