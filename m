Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F35B413E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiIIVGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiIIVF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:05:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571E8FA6B6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:05:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289KYtfK002789;
        Fri, 9 Sep 2022 21:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=gf3LTSfUVQWThDTHLnop4gvpogicO05cZePqIdhqHe8=;
 b=i8GHRo96+y9s8LfgyCreMbn0E83LK41IDJ8w+mMJbfkwcgH0HM7Fhl+4xAyr14wsq//W
 gedC5OpVS6G2BkfepWcv+LWLtypnmEq657Hm/3o//I+uRD2ezy8dR30wc1Os2l5WAmBk
 wFWV+KxRbHCV0TpdNYCtLkMIFRtvJelX9GvGcKeVDP80NorDWvupWLmdIGtrbjFmLasL
 bv95jq+NYXWjWG1FSDqu393j6H/0VFdoSKasHu64UQZ9If5vGVIxZWKaPs1/J1iS/6HN
 6kVoAA8ZaofUAmuU0/YrdYFZJ8b4hn+GUEh8Y66+fBRaapW3KikkKmPAMvsxHi4borvD 4A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2rgp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289Idxwq036006;
        Fri, 9 Sep 2022 21:05:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9116w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3pYeb3BJiozsqV/Kl94MpnLaZR8fVCm/F38ReiB05X/9htFHyX7W2jd0qqRHgaENAyaKNlmhudbYjqGTCmszH4WbtaTq3+jp8MCs4jMBdZ7sdY4yaiNIFKsjQpfSBaG9s/1jNTT2dqqkxHmEEAR7KflsCtb/Nvwt/g/rOqIzBeq2QYtktuJ9jz3BI1E1myqJVfQ7iDKvBNyqoKhSVtCrW3+P+LV9EecyezYzaAtTX+7W6UFVSlYoHNr+B5PnWL6kV8LXF5ML25G4Jewr4/p95J2hQgTVH7iiwtvLgD+8uBpgC6xn97ftVCJSBIFY5/aaGSntxKwGpmr/xLNii3R3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf3LTSfUVQWThDTHLnop4gvpogicO05cZePqIdhqHe8=;
 b=gU4NG8byg9vjGse1nWYYywZQ0NVJSPKItkIAt96y3gHatMnXPX4y6gYH/1FaHSJNgd11i1YgpeNNb9rMxTAiev49r9zicgwcZ30pWPs2i/9LBNYOw5tZO+0J29wE9gQpgGG1xagk2ZvXuCO8lbfQsziLO1uamjq5SWhC2WPKObIqvlz0okjlrk8kjlVqkO9EX32c9mzhIIh2lyu3sxktyA9UMxRhkY/SjT5Y1RHwP8gV9W8f+aK6jD4vwzlGau42IJlHFxN8NldnCYDETCoM83IWmHIfbaCSvAyKNytY8xSZCzrCtsNQCkWQchybxbIjjbN49i59Hwtk+WlabYtBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf3LTSfUVQWThDTHLnop4gvpogicO05cZePqIdhqHe8=;
 b=GcvIsomNjI9fxhGOOjBU9cOnAxF4HqUtP+qrgdehT6h8aD34hAZ2vPZE9FhuQUF4IGijNSKVrZqAJjD3ZKrDKT4Z6BzTIpowPHjmS+hUeQd5PKMNTz4r9+gnqerHhXrZWI0EJ1z5BNSC7kc/F3Dofp0Mq6LduIVEhuebd1hKNd0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB6777.namprd10.prod.outlook.com (2603:10b6:930:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 21:05:29 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 21:05:29 +0000
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
Subject: [PATCH v12 6/7] crash: memory and cpu hotplug sysfs attributes
Date:   Fri,  9 Sep 2022 17:05:08 -0400
Message-Id: <20220909210509.6286-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220909210509.6286-1-eric.devolder@oracle.com>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR06CA0091.namprd06.prod.outlook.com (2603:10b6:3:4::29)
 To CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f1021d-20b1-4ab5-536f-08da92a706a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34ik9Wu5Mj++W8vNcbsIxXyhm0hdfJ2erc+p2u6B5mild+HgBjMvkPWHmxE+TZM0S39MSCJuzz+AOSqHstpgeKqPdFSRlO5i+jq76XRQKq5bPvtJq+eT/a4Ou81gPoEzt8p9lsTlCleuMBubQhom9oLEHN99cSBIMrGqUnmDZ3EmxdxUW1rqg83Ik+GQxbfi3C8YlNZQje5FapY5evrYGE5Uap0Vb9Tyluq1ZaBAb+wlXcCS7UBJ8TJgYTLGJEdot6Z3LxurY4uSU266Yu6mq23L0lcBjZWN8N2++Vj22eKaCjN0cxCU7ym9oa99FpcT7HA6y7uESijui+u5rUc5BcRx8RroXhcA+oeHbk3xkk8N0msm35FpzJTCHqtF5TItjqahZqgEwxqIqMcrMEfVjQLqxSXnAbgfZ3v67TTcPOXI8UwugsB5Y2ygk5Qifmx4w8BmGEQ8GB5dcN1pPItiKRImBptUX14YDc40gobJRv2DM7MZ40N1pEA00KH4j5mJCMlVYZF4FKJxrtIPKzqOXzbwPULvrIQiecqUs2jaGV1Xg012olVCuzs9FHcns3n0kZ2XMLqfMuB9pQLWITcDtCg6hYF+PvMMTqAHmSsx4ubuH7g6yFX6o9Oq/sQiMqfY+w+6VxGVp201rNx4zu0+Aix35JkD1yxPkksVre0XytjWm4MpqEdhhCNZh4IulB8s8vok4ykRjUaKZnjsYwRSsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(376002)(39860400002)(346002)(26005)(86362001)(6506007)(41300700001)(6512007)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(38100700002)(8676002)(66946007)(83380400001)(66476007)(4326008)(186003)(66556008)(2906002)(8936002)(5660300002)(36756003)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WYv4xoqv/LjAmtGmG7n2J8PzO1almIQ9nt8KIQ7fNkChRLsP6ltkUbNZpl7I?=
 =?us-ascii?Q?xiEyTXbOpJXwNXwy1I0TKlIejAfLkJ7KNSIXSfDFJQT8Mu4gM51CmdbXZSj4?=
 =?us-ascii?Q?pRrtjzLpeZqZ0ErZml2aL/7TazHgZ4nDL+VrX0oZwE8f5mVJp38vt0s4t6oH?=
 =?us-ascii?Q?wjQT1zo7QQPGo+2j03TYxdMCuT3fn5AZvK554/Cpot+cYtV0oXlpooNSwld/?=
 =?us-ascii?Q?7eImfgyR9VtJdLCDZqYWzN4yeF29ePUJul03O9MdBus2KceBm4bI7yyEdGm5?=
 =?us-ascii?Q?OXFBXrZFMl9fmFaj+fvYZZHYmqZZNQc6nlEdSvwJtr/jRkk1CrAMj4/MKblj?=
 =?us-ascii?Q?JjNDJbwvBLUMZXUYmasFJSUxSsh0vTylk16SRRGIM/AitUfBjTlB4FHmk8ci?=
 =?us-ascii?Q?jX8LqvQA9ZuZXCcvSZIVVszJCXZbJ+DSh1r7oAqjMqXsB/lLJERIhsMGTctF?=
 =?us-ascii?Q?1LIqfGpoMtiK3iqf6RQ3D6rvQS8s6T2WKxGdToI3q42rLeisBnGwm9Pcoxxv?=
 =?us-ascii?Q?4ttgfheKW+tfqi22818PVkbeGwa1pcZrwVFhGoyEhu112xipMTsoD8hHboxe?=
 =?us-ascii?Q?WYB0fayUaQsv/0P1YMc/iol7T+Q4W0ef56f2xj7GjnxtibZXd/sA/mNCSdjl?=
 =?us-ascii?Q?PqezXhmIB9697VBDboNtxq0XTDkWw1GWfz50Y4ryX3HjPDm4OEWL+t/rKXvX?=
 =?us-ascii?Q?5Pg7ZztjEwN1gp3U+yhqCRgttLqFm8pXv2/28Eh898fnDQxT5Lqs/FPWaJwJ?=
 =?us-ascii?Q?axXCDFuDNRinGqB/jwtQPeIRZdhDCoC1AT0WmXp1o260fPkOXbUNlQgpCd8v?=
 =?us-ascii?Q?WdfHGgqcRnOpXXsgTqOGStLrX4ycbYZI/5N55NcuhyRK2ypTsA7XsAMovTX2?=
 =?us-ascii?Q?I8KIzaWOHHNI3hLK+az3gptfo+iC+Zc+t9x9or6VYy9SfgGE9CoTWMqqgZhG?=
 =?us-ascii?Q?ZolQ/qwcxizmTxCs6x3IBT0eZSiyyvdl+RFUDhrbCSiEqP7H30C0rn/LLA5i?=
 =?us-ascii?Q?kP77ptodNpomKkj0RaLqFp3Jpy05IJ4kkK2FSYMDBi0GmAWIzhBJ2pS+fPAk?=
 =?us-ascii?Q?JMZzwKvgAReBg7dzqhOzFbocbmvXpsRfNWLdqJSwt/h70Vtzilz8yVu6x9EL?=
 =?us-ascii?Q?4Eu5xKARYXCOaeK7/ptfeBSehydHCau61vvP0bP+ISnpK79aUYA7qDF382FC?=
 =?us-ascii?Q?WPq9F5LPYUpoHR+IIzVwK+YeYvcqh8LqDOzU/AXfhA4ggc6jIurCrksDIV9l?=
 =?us-ascii?Q?iw2pDo/MYtnY4LuzkMTRBl52xGDlejhbQOyDX5qTnkYA7ToC3NVxzdYmlmt5?=
 =?us-ascii?Q?zJHDFdrGmveHOcqZG4OZwbI+gzDt39lriK3KdbTgi+A8sFcUGUiTX+aQ4bp4?=
 =?us-ascii?Q?ESB48w8mRuPgbVA03hDAVflnGze6y0VyBYcYflCtecjLFJBYMReNyKg21XwL?=
 =?us-ascii?Q?Zw4VN0739R8MvhV2eMuJOBcrssO7gukvGoLkMdF0EclKNkWa3LnAP0EXjvcR?=
 =?us-ascii?Q?1vHwwEpPyjhHtvvdOVFhcAz2GvfsDyl12GWTFOuYixT6J6FSSzxI8y0oQ5g0?=
 =?us-ascii?Q?flI2DSpz0fi1bTh1j53dQFeB8DrKNx+6bHyLEmlNueChxvP7pJAAqJhoqsaH?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f1021d-20b1-4ab5-536f-08da92a706a1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 21:05:29.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbFACv0xRLgPIwOl+/W+QVhv/Kkoz7orZXd46WhoFwUT7L9dNCpGOOpMyuCB/6WWfJt/MrXW6n64W2g6BGmWR//SQB3ZoiMljylsvz83y44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090074
X-Proofpoint-GUID: b3-uJdmjRqH1xPxqyEOZ9cm31cSGMKLn
X-Proofpoint-ORIG-GUID: b3-uJdmjRqH1xPxqyEOZ9cm31cSGMKLn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index c6f4ba2fb32d..13e33d098645 100644
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
index bc60c9cd3230..b754918c3dac 100644
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
@@ -887,6 +897,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_MEMORY_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9597b41136ec..a48577a36fb8 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -529,6 +529,14 @@ static inline void arch_crash_handle_hotplug_event(struct kimage *image,
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

