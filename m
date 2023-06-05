Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDC87228AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjFEOUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjFEOPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:15:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC51C10F9;
        Mon,  5 Jun 2023 07:14:43 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:14:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDsnAbFl/koTE0Dl0BN3mQjS+9ciwBGJ3f8Zlh4UZLQ=;
        b=qK5R6FrY9BZwV5VW7Zo4ZQD2/2RSZ3xMrI3pvRI/CL3mbJ8jQ2yu/iQhz9J5xsDP06D6aN
        n67lXeM7aHSqGV3tCc15bxAFSSkMdiovK5Tj6pIGRxbifi7uVm02YWfqslOQNZe/qdKYom
        Pn3YSrH4/UBUQzCr3hUgk35HxCIX+w7AgimXdt+XEAr5ibvrcKpjwsuV3uimoQLLHPan4V
        GPgAUEhqwbnp8Vjd2gkJRyST6qN19k+WW6+5mv78/oEOalEMrfkypqqgq+WGrWxfzHiGUJ
        p/2C29Gy/ILNHXreYvMuSmGXR02064sa0Hc/aB1ebe4EG029k/RrlnpYbCAXSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDsnAbFl/koTE0Dl0BN3mQjS+9ciwBGJ3f8Zlh4UZLQ=;
        b=OMuRKr3/W8bytphTE1gaGXa63Er0Z+TuyB4b+e2Ifh0fDyNhdJwbjRZC+ZcrRJrnD6GkYn
        Zocc6eAsmBJyQuAQ==
From:   "tip-bot2 for Muralidhara M K" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/amd64: Document heterogeneous system enumeration
Cc:     Muralidhara M K <muralidhara.mk@amd.com>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515113537.1052146-4-muralimk@amd.com>
References: <20230515113537.1052146-4-muralimk@amd.com>
MIME-Version: 1.0
Message-ID: <168597448189.404.1787278187429193729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     4f3fa571a48feb56e7ed1978a27983b89dd2107a
Gitweb:        https://git.kernel.org/tip/4f3fa571a48feb56e7ed1978a27983b89dd=
2107a
Author:        Muralidhara M K <muralidhara.mk@amd.com>
AuthorDate:    Mon, 15 May 2023 11:35:35=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jun 2023 12:27:15 +02:00

EDAC/amd64: Document heterogeneous system enumeration

Document High Bandwidth Memory (HBM) and AMD heterogeneous system
topology and enumeration.

  [ bp: Simplify and de-marketize, unify, massage. ]

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230515113537.1052146-4-muralimk@amd.com
---
 Documentation/driver-api/edac.rst | 120 +++++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+)

diff --git a/Documentation/driver-api/edac.rst b/Documentation/driver-api/eda=
c.rst
index b8c742a..f4f044b 100644
--- a/Documentation/driver-api/edac.rst
+++ b/Documentation/driver-api/edac.rst
@@ -106,6 +106,16 @@ will occupy those chip-select rows.
 This term is avoided because it is unclear when needing to distinguish
 between chip-select rows and socket sets.
=20
+* High Bandwidth Memory (HBM)
+
+HBM is a new memory type with low power consumption and ultra-wide
+communication lanes. It uses vertically stacked memory chips (DRAM dies)
+interconnected by microscopic wires called "through-silicon vias," or
+TSVs.
+
+Several stacks of HBM chips connect to the CPU or GPU through an ultra-fast
+interconnect called the "interposer". Therefore, HBM's characteristics
+are nearly indistinguishable from on-chip integrated RAM.
=20
 Memory Controllers
 ------------------
@@ -176,3 +186,113 @@ nodes::
 	the L1 and L2 directories would be "edac_device_block's"
=20
 .. kernel-doc:: drivers/edac/edac_device.h
+
+
+Heterogeneous system support
+----------------------------
+
+An AMD heterogeneous system is built by connecting the data fabrics of
+both CPUs and GPUs via custom xGMI links. Thus, the data fabric on the
+GPU nodes can be accessed the same way as the data fabric on CPU nodes.
+
+The MI200 accelerators are data center GPUs. They have 2 data fabrics,
+and each GPU data fabric contains four Unified Memory Controllers (UMC).
+Each UMC contains eight channels. Each UMC channel controls one 128-bit
+HBM2e (2GB) channel (equivalent to 8 X 2GB ranks).  This creates a total
+of 4096-bits of DRAM data bus.
+
+While the UMC is interfacing a 16GB (8high X 2GB DRAM) HBM stack, each UMC
+channel is interfacing 2GB of DRAM (represented as rank).
+
+Memory controllers on AMD GPU nodes can be represented in EDAC thusly:
+
+	GPU DF / GPU Node -> EDAC MC
+	GPU UMC           -> EDAC CSROW
+	GPU UMC channel   -> EDAC CHANNEL
+
+For example: a heterogeneous system with 1 AMD CPU is connected to
+4 MI200 (Aldebaran) GPUs using xGMI.
+
+Some more heterogeneous hardware details:
+
+- The CPU UMC (Unified Memory Controller) is mostly the same as the GPU UMC.
+  They have chip selects (csrows) and channels. However, the layouts are dif=
ferent
+  for performance, physical layout, or other reasons.
+- CPU UMCs use 1 channel, In this case UMC =3D EDAC channel. This follows the
+  marketing speak. CPU has X memory channels, etc.
+- CPU UMCs use up to 4 chip selects, So UMC chip select =3D EDAC CSROW.
+- GPU UMCs use 1 chip select, So UMC =3D EDAC CSROW.
+- GPU UMCs use 8 channels, So UMC channel =3D EDAC channel.
+
+The EDAC subsystem provides a mechanism to handle AMD heterogeneous
+systems by calling system specific ops for both CPUs and GPUs.
+
+AMD GPU nodes are enumerated in sequential order based on the PCI
+hierarchy, and the first GPU node is assumed to have a Node ID value
+following those of the CPU nodes after latter are fully populated::
+
+	$ ls /sys/devices/system/edac/mc/
+		mc0   - CPU MC node 0
+		mc1  |
+		mc2  |- GPU card[0] =3D> node 0(mc1), node 1(mc2)
+		mc3  |
+		mc4  |- GPU card[1] =3D> node 0(mc3), node 1(mc4)
+		mc5  |
+		mc6  |- GPU card[2] =3D> node 0(mc5), node 1(mc6)
+		mc7  |
+		mc8  |- GPU card[3] =3D> node 0(mc7), node 1(mc8)
+
+For example, a heterogeneous system with one AMD CPU is connected to
+four MI200 (Aldebaran) GPUs using xGMI. This topology can be represented
+via the following sysfs entries::
+
+	/sys/devices/system/edac/mc/..
+
+	CPU			# CPU node
+	=E2=94=9C=E2=94=80=E2=94=80 mc 0
+
+	GPU Nodes are enumerated sequentially after CPU nodes have been populated
+	GPU card 1		# Each MI200 GPU has 2 nodes/mcs
+	=E2=94=9C=E2=94=80=E2=94=80 mc 1		# GPU node 0 =3D=3D mc1, Each MC node has=
 4 UMCs/CSROWs
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 csrow 0		# UMC 0
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 0	# Each UMC has 8 channels
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 1   # size of each channel is 2 GB, so each UMC has 16 GB
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 2
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 3
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 4
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 5
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 6
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 7
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 csrow 1		# UMC 1
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 0
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ..
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 7
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ..		..
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 csrow 3		# UMC 3
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 0
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ..
+	=E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cha=
nnel 7
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rank 0
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ..		..
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rank 31		# total 32 ranks=
/dimms from 4 UMCs
+	=E2=94=9C
+	=E2=94=9C=E2=94=80=E2=94=80 mc 2		# GPU node 1 =3D=3D mc2
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ..		# each GPU has total =
64 GB
+
+	GPU card 2
+	=E2=94=9C=E2=94=80=E2=94=80 mc 3
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ..
+	=E2=94=9C=E2=94=80=E2=94=80 mc 4
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ..
+
+	GPU card 3
+	=E2=94=9C=E2=94=80=E2=94=80 mc 5
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ..
+	=E2=94=9C=E2=94=80=E2=94=80 mc 6
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ..
+
+	GPU card 4
+	=E2=94=9C=E2=94=80=E2=94=80 mc 7
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ..
+	=E2=94=9C=E2=94=80=E2=94=80 mc 8
+	=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ..
