Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68F3637DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKXRDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKXRCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:02:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E35828E30;
        Thu, 24 Nov 2022 09:02:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyxiBnuGKhUW94Kowowl24GGVb1wO7F25fGFGgmX+OBx6pnkXMom9DovGFZH9lQL0X1/SJt28nLDxTMtkTdvzJUpGOpzdkS1LXzjJXlqe7WQeniAEmHGo5UYQff2Ss+o4/rRdLUvUsPjOCwwHVa/gvE2QJNwAH+6g43A1RnXOf1NMjgiKfwOjgO/CwWkbybq1b6Itb6qzSC489RlQF/BUdHkVYMgFD23u0yKQ5Zx8r9koSiVLcj2fLRd8EZD6vLu5kkCKf6ZF6qoin9+27QNnlSzH62tRK/jsTOEHL3K263w1/GPwo5TYmFoeHsJQSn0NNSftXe7PIn8220+Jkn5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9E5jl5WbHOb0/upQL3rnlHQsW50EnCihMxYedW5nKM=;
 b=X5M6S7GL8I/eLeLVkl2aVmKzLMmCPHQvp8SK6ndc1MiaMuJxieo4uZSddnQUgOpNOt4g1tAYqj31nXQRq3o/zdzUN+5tBqQzlPq7wiiN50M4Un2YC+g1Ufrgj6d3Yxu7IF0R2PDjsQT63UH9Rr65VOAlzn7yynGoCrQgBEqjcC6QACKT0BqL7JhwNdsJi359PuomR7hzuiPB8spSTY+VuKhQQxmU1GaWfbuRg6stps2b6iV1tCfaIROW6nAl41F2Bb7Ap4ft4X/09aVGCFxvph1vXnabB4DvQqWd0Ip3rtipddhlxVqYB1LGTU1hwb7itiW8aUq/l+N68xcEoiw5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9E5jl5WbHOb0/upQL3rnlHQsW50EnCihMxYedW5nKM=;
 b=rUQ94M5iKGGUyjVpawC+cT5Zv9MIieylkZm8lC8LBEIQB7lZhJvNMXdmxjyysNiroJaKV04iRNhwlaDBe65UtzxeKilCkLMscLvkGAiuVEbHSYCy11yy+NZZWrcYnzy8be6u9+Gz4t1wr4TMfdAHhPJ7cg7HUmGhBymDaMoH6wE=
Received: from DM5PR07CA0069.namprd07.prod.outlook.com (2603:10b6:4:ad::34) by
 DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.19; Thu, 24 Nov 2022 17:02:46 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::95) by DM5PR07CA0069.outlook.office365.com
 (2603:10b6:4:ad::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18 via Frontend
 Transport; Thu, 24 Nov 2022 17:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 24 Nov 2022 17:02:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:44 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 11:02:44 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <lukas.bulwahn@gmail.com>, <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 2/6] docs: Retire old resources from kernel-docs.rst
Date:   Thu, 24 Nov 2022 11:02:38 -0600
Message-ID: <20221124170242.1892751-3-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124170242.1892751-1-carlos.bilbao@amd.com>
References: <20221124170242.1892751-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdde30f-50f4-4066-d44c-08dace3db57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8AE/xMPcxF9VgUCl7im4afWJ6epD5/2Gp5/H5kqYTTGbM6isWFKhWmolFC3qF7viilYqrva9du8nLXqm4KxByuOvcW86gTmKwGnM11RIhokr8movtWZ6v+7wgOK39Wi6JNLP+0Up4+Bn1yhi3eve6fKyeXoKx2MVocKORtHjfyYVXwU2gD4IiB5OIkfmXVLqP2MrImk57/VKbv9qSsKHmYnYgckU6MOZpattOIBNhyX4shi0FndsRFAixQ3CKx84G79ZFRqSKfMjo5wvDYqpcB1fLYLXtdvRbrXfo/LC1Sj+bSBualmMO2xo1lMGqTVo+G+gNKYj+UcAdA7jE0KZgoZ92a99UTdyLvnOrI/ZeEoaNpbkuC46lnIJQs9C/VZjJJzC5Kv4bFpYBIGact9qmUMU9aFU80K4TpsONH4yWnoM91TRbHt8uCX1IwI2vc/aeTuBANTJ/OwtlcmK2mmbrzsfiezDzuf7kd1ZWgLzr0ag98YjBRElJo3KPjt4jkMuGyTIoYpbMXjOW+L15wrRqz+ZNespHDobiRRRyIuK6ytkAVXHP0kkUGKccjOH+MY85V3+YxUAxT1TOr5E/WOVGd2Mbhde0zMo8Wy5qMwqm7mkn4aWatzsWNAEEVt2/NEAg+oC7Bi1mHR3VQS/IxfG19NqyShHhdhmXVR/+UHV1A3pH1kb112QU3/5wtljwSgGo2qg7GgDDwp0REl9iV8zlESH/bPN0stO8ps6rzEWPeJ6ycSf/h3ZFk6FOvCxovHupyXK2rctA3IW5sUCeEbi1Egp4/3+9X9OoxGTRFhY0SSVegYNvpcr8vl/MqWKN2pmvxoGj+tGhm04mnLwzKFkCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(66899015)(66574015)(47076005)(83380400001)(336012)(426003)(40460700003)(86362001)(7696005)(54906003)(110136005)(966005)(6666004)(40480700001)(81166007)(356005)(15188155005)(36756003)(16799955002)(82740400003)(82310400005)(36860700001)(1076003)(2616005)(186003)(30864003)(44832011)(5660300002)(26005)(478600001)(70206006)(8676002)(316002)(70586007)(2906002)(41300700001)(4326008)(8936002)(36900700001)(19623215001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 17:02:45.8618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdde30f-50f4-4066-d44c-08dace3db57a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove outdated or obsolete resources from process/kernel-docs.rst, with
the exception of foundational material. Update information regarding
LWN.net. See Link below for further context.

Link: https://lore.kernel.org/lkml/093907af-2e4e-d232-1eb0-7331ff2b9320@amd.com/
Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/process/kernel-docs.rst | 465 +-------------------------
 1 file changed, 7 insertions(+), 458 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 5e533c827cef..d66ac26e2f27 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -28,7 +28,9 @@ All documents are cataloged with the following fields: the document's
 .. note::
 
    The documents on each section of this document are ordered by its
-   published date, from the newest to the oldest.
+   published date, from the newest to the oldest. The maintainer(s) should
+   periodically retire resources as they become obsolte or outdated; with
+   the exception of foundational books.
 
 Docs at the Linux Kernel tree
 -----------------------------
@@ -58,24 +60,6 @@ On-line docs
         a brief description of some of the acronyms and terms you may hear
         during discussion of the Linux kernel".
 
-    * Title: **Tracing the Way of Data in a TCP Connection through the Linux Kernel**
-
-      :Author: Richard Sailer
-      :URL: https://archive.org/details/linux_kernel_data_flow_short_paper
-      :Date: 2016
-      :Keywords: Linux Kernel Networking, TCP, tracing, ftrace
-      :Description: A seminar paper explaining ftrace and how to use it for
-        understanding linux kernel internals,
-        illustrated at tracing the way of a TCP packet through the kernel.
-      :Abstract: *This short paper outlines the usage of ftrace a tracing framework
-        as a tool to understand a running Linux system.
-        Having obtained a trace-log a kernel hacker can read and understand
-        source code more determined and with context.
-        In a detailed example this approach is demonstrated in tracing
-        and the way of data in a TCP Connection through the kernel.
-        Finally this trace-log is used as base for more a exact conceptual
-        exploration and description of the Linux TCP/IP implementation.*
-
     * Title: **The Linux Kernel Module Programming Guide**
 
       :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
@@ -88,380 +72,9 @@ On-line docs
         programming. Lots of examples. Currently the new version is being
         actively maintained at https://github.com/sysprog21/lkmpg.
 
-    * Title: **On submitting kernel Patches**
-
-      :Author: Andi Kleen
-      :URL: http://halobates.de/on-submitting-kernel-patches.pdf
-      :Date: 2008
-      :Keywords: patches, review process, types of submissions, basic rules, case studies
-      :Description: This paper gives several experience values on what types of patches
-        there are and how likely they get merged.
-      :Abstract:
-        [...]. This paper examines some common problems for
-        submitting larger changes and some strategies to avoid problems.
-
-    * Title: **Linux Device Drivers, Third Edition**
-
-      :Author: Jonathan Corbet, Alessandro Rubini, Greg Kroah-Hartman
-      :URL: https://lwn.net/Kernel/LDD3/
-      :Date: 2005
-      :Description: A 600-page book covering the (2.6.10) driver
-        programming API and kernel hacking in general.  Available under the
-        Creative Commons Attribution-ShareAlike 2.0 license.
-      :note: You can also :ref:`purchase a copy from O'Reilly or elsewhere  <ldd3_published>`.
-
-    * Title: **Writing an ALSA Driver**
-
-      :Author: Takashi Iwai <tiwai@suse.de>
-      :URL: https://www.kernel.org/doc/html/latest/sound/kernel-api/writing-an-alsa-driver.html
-      :Date: 2005
-      :Keywords: ALSA, sound, soundcard, driver, lowlevel, hardware.
-      :Description: Advanced Linux Sound Architecture for developers,
-        both at kernel and user-level sides. ALSA is the Linux kernel
-        sound architecture in the 2.6 kernel version.
-
-    * Title: **Linux PCMCIA Programmer's Guide**
-
-      :Author: David Hinds.
-      :URL: http://pcmcia-cs.sourceforge.net/ftp/doc/PCMCIA-PROG.html
-      :Date: 2003
-      :Keywords: PCMCIA.
-      :Description: "This document describes how to write kernel device
-        drivers for the Linux PCMCIA Card Services interface. It also
-        describes how to write user-mode utilities for communicating with
-        Card Services.
-
-    * Title: **How NOT to write kernel drivers**
-
-      :Author: Arjan van de Ven.
-      :URL: https://landley.net/kdocs/ols/2002/ols2002-pages-545-555.pdf
-      :Date: 2002
-      :Keywords: driver.
-      :Description: Programming bugs and Do-nots in kernel driver development
-      :Abstract: *Quit a few tutorials, articles and books give an introduction
-        on how to write Linux kernel drivers. Unfortunately the things one
-        should NOT do in Linux kernel code is either only a minor appendix
-        or, more commonly, completely absent. This paper tries to briefly touch
-        the areas in which the most common and serious bugs and do-nots are
-        encountered.*
-
-    * Title: **Global spinlock list and usage**
-
-      :Author: Rick Lindsley.
-      :URL: http://lse.sourceforge.net/lockhier/global-spin-lock
-      :Date: 2001
-      :Keywords: spinlock.
-      :Description: This is an attempt to document both the existence and
-        usage of the spinlocks in the Linux 2.4.5 kernel. Comprehensive
-        list of spinlocks showing when they are used, which functions
-        access them, how each lock is acquired, under what conditions it
-        is held, whether interrupts can occur or not while it is held...
-
-    * Title: **A Linux vm README**
-
-      :Author: Kanoj Sarcar.
-      :URL: http://kos.enix.org/pub/linux-vmm.html
-      :Date: 2001
-      :Keywords: virtual memory, mm, pgd, vma, page, page flags, page
-        cache, swap cache, kswapd.
-      :Description: Telegraphic, short descriptions and definitions
-        relating the Linux virtual memory implementation.
-
-    * Title: **Video4linux Drivers, Part 1: Video-Capture Device**
-
-      :Author: Alan Cox.
-      :URL: http://www.linux-mag.com/id/406
-      :Date: 2000
-      :Keywords: video4linux, driver, video capture, capture devices,
-        camera driver.
-      :Description: The title says it all.
-
-    * Title: **Video4linux Drivers, Part 2: Video-capture Devices**
-
-      :Author: Alan Cox.
-      :URL: http://www.linux-mag.com/id/429
-      :Date: 2000
-      :Keywords: video4linux, driver, video capture, capture devices,
-        camera driver, control, query capabilities, capability, facility.
-      :Description: The title says it all.
-
-    * Title: **Linux IP Networking. A Guide to the Implementation and Modification of the Linux Protocol Stack.**
-
-      :Author: Glenn Herrin.
-      :URL: http://www.cs.unh.edu/cnrg/gherrin
-      :Date: 2000
-      :Keywords: network, networking, protocol, IP, UDP, TCP, connection,
-        socket, receiving, transmitting, forwarding, routing, packets,
-        modules, /proc, sk_buff, FIB, tags.
-      :Description: Excellent paper devoted to the Linux IP Networking,
-        explaining anything from the kernel's to the user space
-        configuration tools' code. Very good to get a general overview of
-        the kernel networking implementation and understand all steps
-        packets follow from the time they are received at the network
-        device till they are delivered to applications. The studied kernel
-        code is from 2.2.14 version. Provides code for a working packet
-        dropper example.
-
-    * Title: **How To Make Sure Your Driver Will Work On The Power Macintosh**
-
-      :Author: Paul Mackerras.
-      :URL: http://www.linux-mag.com/id/261
-      :Date: 1999
-      :Keywords: Mac, Power Macintosh, porting, drivers, compatibility.
-      :Description: The title says it all.
-
-    * Title: **An Introduction to SCSI Drivers**
-
-      :Author: Alan Cox.
-      :URL: http://www.linux-mag.com/id/284
-      :Date: 1999
-      :Keywords: SCSI, device, driver.
-      :Description: The title says it all.
-
-    * Title: **Advanced SCSI Drivers And Other Tales**
-
-      :Author: Alan Cox.
-      :URL: http://www.linux-mag.com/id/307
-      :Date: 1999
-      :Keywords: SCSI, device, driver, advanced.
-      :Description: The title says it all.
-
-    * Title: **Writing Linux Mouse Drivers**
-
-      :Author: Alan Cox.
-      :URL: http://www.linux-mag.com/id/330
-      :Date: 1999
-      :Keywords: mouse, driver, gpm.
-      :Description: The title says it all.
-
-    * Title: **More on Mouse Drivers**
-
-      :Author: Alan Cox.
-      :URL: http://www.linux-mag.com/id/356
-      :Date: 1999
-      :Keywords: mouse, driver, gpm, races, asynchronous I/O.
-      :Description: The title still says it all.
-
-    * Title: **Writing Video4linux Radio Driver**
-
-      :Author: Alan Cox.
-      :URL: http://www.linux-mag.com/id/381
-      :Date: 1999
-      :Keywords: video4linux, driver, radio, radio devices.
-      :Description: The title says it all.
-
-    * Title: **I/O Event Handling Under Linux**
-
-      :Author: Richard Gooch.
-      :URL: https://web.mit.edu/~yandros/doc/io-events.html
-      :Date: 1999
-      :Keywords: IO, I/O, select(2), poll(2), FDs, aio_read(2), readiness
-        event queues.
-      :Description: From the Introduction: "I/O Event handling is about
-        how your Operating System allows you to manage a large number of
-        open files (file descriptors in UNIX/POSIX, or FDs) in your
-        application. You want the OS to notify you when FDs become active
-        (have data ready to be read or are ready for writing). Ideally you
-        want a mechanism that is scalable. This means a large number of
-        inactive FDs cost very little in memory and CPU time to manage".
-
-    * Title: **(nearly) Complete Linux Loadable Kernel Modules. The definitive guide for hackers, virus coders and system administrators.**
-
-      :Author: pragmatic/THC.
-      :URL: http://packetstormsecurity.org/docs/hack/LKM_HACKING.html
-      :Date: 1999
-      :Keywords: syscalls, intercept, hide, abuse, symbol table.
-      :Description: Interesting paper on how to abuse the Linux kernel in
-        order to intercept and modify syscalls, make
-        files/directories/processes invisible, become root, hijack ttys,
-        write kernel modules based virus... and solutions for admins to
-        avoid all those abuses.
-      :Notes: For 2.0.x kernels. Gives guidances to port it to 2.2.x
-        kernels.
-
-    * Name: **Linux Virtual File System**
-
-      :Author: Peter J. Braam.
-      :URL: http://www.coda.cs.cmu.edu/doc/talks/linuxvfs/
-      :Date: 1998
-      :Keywords: slides, VFS, inode, superblock, dentry, dcache.
-      :Description: Set of slides, presumably from a presentation on the
-        Linux VFS layer. Covers version 2.1.x, with dentries and the
-        dcache.
-
-    * Title: **The Venus kernel interface**
-
-      :Author: Peter J. Braam.
-      :URL: http://www.coda.cs.cmu.edu/doc/html/kernel-venus-protocol.html
-      :Date: 1998
-      :Keywords: coda, filesystem, venus, cache manager.
-      :Description: "This document describes the communication between
-        Venus and kernel level file system code needed for the operation
-        of the Coda filesystem. This version document is meant to describe
-        the current interface (version 1.0) as well as improvements we
-        envisage".
-
-    * Title: **Design and Implementation of the Second Extended Filesystem**
-
-      :Author: Rémy Card, Theodore Ts'o, Stephen Tweedie.
-      :URL: https://web.mit.edu/tytso/www/linux/ext2intro.html
-      :Date: 1998
-      :Keywords: ext2, linux fs history, inode, directory, link, devices,
-        VFS, physical structure, performance, benchmarks, ext2fs library,
-        ext2fs tools, e2fsck.
-      :Description: Paper written by three of the top ext2 hackers.
-        Covers Linux filesystems history, ext2 motivation, ext2 features,
-        design, physical structure on disk, performance, benchmarks,
-        e2fsck's passes description... A must read!
-      :Notes: This paper was first published in the Proceedings of the
-        First Dutch International Symposium on Linux, ISBN 90-367-0385-9.
-
-    * Title: **The Linux RAID-1, 4, 5 Code**
-
-      :Author: Ingo Molnar, Gadi Oxman and Miguel de Icaza.
-      :URL: http://www.linuxjournal.com/article.php?sid=2391
-      :Date: 1997
-      :Keywords: RAID, MD driver.
-      :Description: Linux Journal Kernel Korner article.
-      :Abstract: *A description of the implementation of the RAID-1,
-        RAID-4 and RAID-5 personalities of the MD device driver in the
-        Linux kernel, providing users with high performance and reliable,
-        secondary-storage capability using software*.
-
-    * Title: **Linux Kernel Hackers' Guide**
-
-      :Author: Michael K. Johnson.
-      :URL: https://www.tldp.org/LDP/khg/HyperNews/get/khg.html
-      :Date: 1997
-      :Keywords: device drivers, files, VFS, kernel interface, character vs
-        block devices, hardware interrupts, scsi, DMA, access to user memory,
-        memory allocation, timers.
-      :Description: A guide designed to help you get up to speed on the
-        concepts that are not intuitively obvious, and to document the internal
-        structures of Linux.
-
-    * Title: **Dynamic Kernels: Modularized Device Drivers**
-
-      :Author: Alessandro Rubini.
-      :URL: http://www.linuxjournal.com/article.php?sid=1219
-      :Date: 1996
-      :Keywords: device driver, module, loading/unloading modules,
-        allocating resources.
-      :Description: Linux Journal Kernel Korner article.
-      :Abstract: *This is the first of a series of four articles
-        co-authored by Alessandro Rubini and Georg Zezchwitz which present
-        a practical approach to writing Linux device drivers as kernel
-        loadable modules. This installment presents an introduction to the
-        topic, preparing the reader to understand next month's
-        installment*.
-
-    * Title: **Dynamic Kernels: Discovery**
-
-      :Author: Alessandro Rubini.
-      :URL: http://www.linuxjournal.com/article.php?sid=1220
-      :Date: 1996
-      :Keywords: character driver, init_module, clean_up module,
-        autodetection, mayor number, minor number, file operations,
-        open(), close().
-      :Description: Linux Journal Kernel Korner article.
-      :Abstract: *This article, the second of four, introduces part of
-        the actual code to create custom module implementing a character
-        device driver. It describes the code for module initialization and
-        cleanup, as well as the open() and close() system calls*.
-
-    * Title: **The Devil's in the Details**
-
-      :Author: Georg v. Zezschwitz and Alessandro Rubini.
-      :URL: http://www.linuxjournal.com/article.php?sid=1221
-      :Date: 1996
-      :Keywords: read(), write(), select(), ioctl(), blocking/non
-        blocking mode, interrupt handler.
-      :Description: Linux Journal Kernel Korner article.
-      :Abstract: *This article, the third of four on writing character
-        device drivers, introduces concepts of reading, writing, and using
-        ioctl-calls*.
-
-    * Title: **Dissecting Interrupts and Browsing DMA**
-
-      :Author: Alessandro Rubini and Georg v. Zezschwitz.
-      :URL: https://www.linuxjournal.com/article.php?sid=1222
-      :Date: 1996
-      :Keywords: interrupts, irqs, DMA, bottom halves, task queues.
-      :Description: Linux Journal Kernel Korner article.
-      :Abstract: *This is the fourth in a series of articles about
-        writing character device drivers as loadable kernel modules. This
-        month, we further investigate the field of interrupt handling.
-        Though it is conceptually simple, practical limitations and
-        constraints make this an ''interesting'' part of device driver
-        writing, and several different facilities have been provided for
-        different situations. We also investigate the complex topic of
-        DMA*.
-
-    * Title: **Device Drivers Concluded**
-
-      :Author: Georg v. Zezschwitz.
-      :URL: https://www.linuxjournal.com/article.php?sid=1287
-      :Date: 1996
-      :Keywords: address spaces, pages, pagination, page management,
-        demand loading, swapping, memory protection, memory mapping, mmap,
-        virtual memory areas (VMAs), vremap, PCI.
-      :Description: Finally, the above turned out into a five articles
-        series. This latest one's introduction reads: "This is the last of
-        five articles about character device drivers. In this final
-        section, Georg deals with memory mapping devices, beginning with
-        an overall description of the Linux memory management concepts".
-
-    * Title: **Network Buffers And Memory Management**
-
-      :Author: Alan Cox.
-      :URL: https://www.linuxjournal.com/article.php?sid=1312
-      :Date: 1996
-      :Keywords: sk_buffs, network devices, protocol/link layer
-        variables, network devices flags, transmit, receive,
-        configuration, multicast.
-      :Description: Linux Journal Kernel Korner.
-      :Abstract: *Writing a network device driver for Linux is fundamentally
-        simple---most of the complexity (other than talking to the
-        hardware) involves managing network packets in memory*.
-
-    * Title: **Analysis of the Ext2fs structure**
-
-      :Author: Louis-Dominique Dubeau.
-      :URL: https://teaching.csse.uwa.edu.au/units/CITS2002/fs-ext2/
-      :Date: 1994
-      :Keywords: ext2, filesystem, ext2fs.
-      :Description: Description of ext2's blocks, directories, inodes,
-        bitmaps, invariants...
-
 Published books
 ---------------
 
-    * Title: **Linux Treiber entwickeln**
-
-      :Author: Jürgen Quade, Eva-Katharina Kunst
-      :Publisher: dpunkt.verlag
-      :Date: Oct 2015 (4th edition)
-      :Pages: 688
-      :ISBN: 978-3-86490-288-8
-      :Note: German. The third edition from 2011 is
-         much cheaper and still quite up-to-date.
-
-    * Title: **Linux Kernel Networking: Implementation and Theory**
-
-      :Author: Rami Rosen
-      :Publisher: Apress
-      :Date: December 22, 2013
-      :Pages: 648
-      :ISBN: 978-1430261964
-
-    * Title: **Embedded Linux Primer: A practical Real-World Approach, 2nd Edition**
-
-      :Author: Christopher Hallinan
-      :Publisher: Pearson
-      :Date: November, 2010
-      :Pages: 656
-      :ISBN: 978-0137017836
-
     * Title: **Linux Kernel Development, 3rd Edition**
 
       :Author: Robert Love
@@ -469,14 +82,7 @@ Published books
       :Date: July, 2010
       :Pages: 440
       :ISBN: 978-0672329463
-
-    * Title: **Essential Linux Device Drivers**
-
-      :Author: Sreekrishnan Venkateswaran
-      :Published: Prentice Hall
-      :Date: April, 2008
-      :Pages: 744
-      :ISBN: 978-0132396554
+      :Notes: Foundational book
 
 .. _ldd3_published:
 
@@ -487,68 +93,10 @@ Published books
       :Date: 2005
       :Pages: 636
       :ISBN: 0-596-00590-3
-      :Notes: Further information in
+      :Notes: Foundational book. Further information in
         http://www.oreilly.com/catalog/linuxdrive3/
         PDF format, URL: https://lwn.net/Kernel/LDD3/
 
-    * Title: **Linux Kernel Internals**
-
-      :Author: Michael Beck
-      :Publisher: Addison-Wesley
-      :Date: 1997
-      :ISBN: 0-201-33143-8 (second edition)
-
-    * Title: **Programmation Linux 2.0 API systeme et fonctionnement du noyau**
-
-      :Author: Remy Card, Eric Dumas, Franck Mevel
-      :Publisher: Eyrolles
-      :Date: 1997
-      :Pages: 520
-      :ISBN: 2-212-08932-5
-      :Notes: French
-
-    * Title: **The Design and Implementation of the 4.4 BSD UNIX Operating System**
-
-      :Author: Marshall Kirk McKusick, Keith Bostic, Michael J. Karels,
-        John S. Quarterman
-      :Publisher: Addison-Wesley
-      :Date: 1996
-      :ISBN: 0-201-54979-4
-
-    * Title: **Unix internals -- the new frontiers**
-
-      :Author: Uresh Vahalia
-      :Publisher: Prentice Hall
-      :Date: 1996
-      :Pages: 600
-      :ISBN: 0-13-101908-2
-
-    * Title: **Programming for the real world - POSIX.4**
-
-      :Author: Bill O. Gallmeister
-      :Publisher: O'Reilly & Associates, Inc
-      :Date: 1995
-      :Pages: 552
-      :ISBN: I-56592-074-0
-      :Notes: Though not being directly about Linux, Linux aims to be
-        POSIX. Good reference.
-
-    * Title:  **UNIX  Systems  for  Modern Architectures: Symmetric Multiprocessing and Caching for Kernel Programmers**
-
-      :Author: Curt Schimmel
-      :Publisher: Addison Wesley
-      :Date: June, 1994
-      :Pages: 432
-      :ISBN: 0-201-63338-8
-
-    * Title: **The Design and Implementation of the 4.3 BSD UNIX Operating System**
-
-      :Author: Samuel J. Leffler, Marshall Kirk McKusick, Michael J
-        Karels, John S. Quarterman
-      :Publisher: Addison-Wesley
-      :Date: 1989 (reprinted with corrections on October, 1990)
-      :ISBN: 0-201-06196-1
-
     * Title: **The Design of the UNIX Operating System**
 
       :Author: Maurice J. Bach
@@ -556,6 +104,7 @@ Published books
       :Date: 1986
       :Pages: 471
       :ISBN: 0-13-201757-1
+      :Notes: Foundational book
 
 Miscellaneous
 -------------
@@ -574,7 +123,7 @@ Miscellaneous
       :Keywords: latest kernel news.
       :Description: The title says it all. There's a fixed kernel section
         summarizing developers' work, bug fixes, new features and versions
-        produced during the week. Published every Thursday.
+        produced during the week.
 
     * Name: **The home page of Linux-MM**
 
-- 
2.34.1

