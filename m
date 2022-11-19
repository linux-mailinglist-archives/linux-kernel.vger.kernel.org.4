Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C46310EC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiKSUp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiKSUpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:45:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978421A38D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 12:45:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B48CB801BA
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 20:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A10C433B5;
        Sat, 19 Nov 2022 20:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668890709;
        bh=CBD8OmSr5rPgSjZyuyDPRILXCnJ2vLZOKnkTF8abduY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTlKETCBlC50W1bvIe0y4agSrAnfuz4DL+MDlTFJ4+4EqNgd8uPqna8IjWw0CYK1V
         Rdtwfu8CFpacTMPvonQD20+USLFQVW2WW2AYtUeVFCNwej/ry6MOIgo2Zd98+36bpX
         hLJGbz1X9Nke7pc5a4Z7d1J7kJ1tau+B3MRnnlo4aVa3N5RrWJcCaNo0H9MzpPuUWZ
         1Z3p1Y3n/Faekbmm4ZLRYSVsMFXHFWKeZc/1olwYCVmBHkcataTpwakiPtwFSAupnp
         2LtKKyciT8BytNUi8MDg3QuJnd8A1oUppwKFIrbWBRDhCpf7EZWFZi0hSGIPNtZx9v
         rAtVePdAyFk/g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Christopher Friedt <chrisfriedt@gmail.com>
Subject: [PATCH v4 4/4] doc: add documentation for accel subsystem
Date:   Sat, 19 Nov 2022 22:44:35 +0200
Message-Id: <20221119204435.97113-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119204435.97113-1-ogabbay@kernel.org>
References: <20221119204435.97113-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an introduction section for the accel subsystem. Most of the
relevant data is in the DRM documentation, so the introduction only
presents the why of the new subsystem, how are the compute accelerators
exposed to user-space and what changes need to be done in a standard
DRM driver to register it to the new accel subsystem.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Documentation/accel/index.rst        |  17 +++++
 Documentation/accel/introduction.rst | 109 +++++++++++++++++++++++++++
 Documentation/subsystem-apis.rst     |   1 +
 MAINTAINERS                          |   1 +
 4 files changed, 128 insertions(+)
 create mode 100644 Documentation/accel/index.rst
 create mode 100644 Documentation/accel/introduction.rst

diff --git a/Documentation/accel/index.rst b/Documentation/accel/index.rst
new file mode 100644
index 000000000000..2b43c9a7f67b
--- /dev/null
+++ b/Documentation/accel/index.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Compute Accelerators
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   introduction
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/accel/introduction.rst b/Documentation/accel/introduction.rst
new file mode 100644
index 000000000000..5a3963eae973
--- /dev/null
+++ b/Documentation/accel/introduction.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+Introduction
+============
+
+The Linux compute accelerators subsystem is designed to expose compute
+accelerators in a common way to user-space and provide a common set of
+functionality.
+
+These devices can be either stand-alone ASICs or IP blocks inside an SoC/GPU.
+Although these devices are typically designed to accelerate Machine-Learning
+and/or Deep-Learning computations, the accel layer is not limited to handling
+these types of accelerators.
+
+typically, a compute accelerator will belong to one of the following
+categories:
+
+- Edge AI - doing inference at an edge device. It can be an embedded ASIC/FPGA,
+  or an IP inside a SoC (e.g. laptop web camera). These devices
+  are typically configured using registers and can work with or without DMA.
+
+- Inference data-center - single/multi user devices in a large server. This
+  type of device can be stand-alone or an IP inside a SoC or a GPU. It will
+  have on-board DRAM (to hold the DL topology), DMA engines and
+  command submission queues (either kernel or user-space queues).
+  It might also have an MMU to manage multiple users and might also enable
+  virtualization (SR-IOV) to support multiple VMs on the same device. In
+  addition, these devices will usually have some tools, such as profiler and
+  debugger.
+
+- Training data-center - Similar to Inference data-center cards, but typically
+  have more computational power and memory b/w (e.g. HBM) and will likely have
+  a method of scaling-up/out, i.e. connecting to other training cards inside
+  the server or in other servers, respectively.
+
+All these devices typically have different runtime user-space software stacks,
+that are tailored-made to their h/w. In addition, they will also probably
+include a compiler to generate programs to their custom-made computational
+engines. Typically, the common layer in user-space will be the DL frameworks,
+such as PyTorch and TensorFlow.
+
+Sharing code with DRM
+=====================
+
+Because this type of devices can be an IP inside GPUs or have similar
+characteristics as those of GPUs, the accel subsystem will use the
+DRM subsystem's code and functionality. i.e. the accel core code will
+be part of the DRM subsystem and an accel device will be a new type of DRM
+device.
+
+This will allow us to leverage the extensive DRM code-base and
+collaborate with DRM developers that have experience with this type of
+devices. In addition, new features that will be added for the accelerator
+drivers can be of use to GPU drivers as well.
+
+Differentiation from GPUs
+=========================
+
+Because we want to prevent the extensive user-space graphic software stack
+from trying to use an accelerator as a GPU, the compute accelerators will be
+differentiated from GPUs by using a new major number and new device char files.
+
+Furthermore, the drivers will be located in a separate place in the kernel
+tree - drivers/accel/.
+
+The accelerator devices will be exposed to the user space with the dedicated
+261 major number and will have the following convention:
+
+- device char files - /dev/accel/accel*
+- sysfs             - /sys/class/accel/accel*/
+- debugfs           - /sys/kernel/debug/accel/accel*/
+
+Getting Started
+===============
+
+First, read the DRM documentation. Not only it will explain how to write a new
+DRM driver but it will also contain all the information on how to contribute,
+the Code Of Conduct and what is the coding style/documentation. All of that
+is the same for the accel subsystem.
+
+Second, make sure the kernel is configured with CONFIG_DRM_ACCEL.
+
+To expose your device as an accelerator, two changes are needed to
+be done in your driver (as opposed to a standard DRM driver):
+
+- Add the DRIVER_COMPUTE_ACCEL feature flag in your drm_driver's
+  driver_features field. It is important to note that this driver feature is
+  mutually exclusive with DRIVER_RENDER and DRIVER_MODESET. Devices that want
+  to expose both graphics and compute device char files should be handled by
+  two drivers that are connected using the auxiliary bus framework.
+
+- Change the open callback in your driver fops structure to accel_open().
+  Alternatively, your driver can use DEFINE_DRM_ACCEL_FOPS macro to easily
+  set the correct function operations pointers structure.
+
+External References
+===================
+
+email threads
+-------------
+
+* `Initial discussion on the New subsystem for acceleration devices <https://lkml.org/lkml/2022/7/31/83>`_ - Oded Gabbay (2022)
+* `patch-set to add the new subsystem <https://lkml.org/lkml/2022/10/22/544>`_ - Oded Gabbay (2022)
+
+Conference talks
+----------------
+
+* `LPC 2022 Accelerators BOF outcomes summary <https://airlied.blogspot.com/2022/09/accelerators-bof-outcomes-summary.html>`_ - Dave Airlie (2022)
diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index af65004a80aa..b51f38527e14 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -43,6 +43,7 @@ needed).
    input/index
    hwmon/index
    gpu/index
+   accel/index
    security/index
    sound/index
    crypto/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 4d752aac3ec0..6ba7bb35208a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6837,6 +6837,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 C:	irc://irc.oftc.net/dri-devel
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git
+F:	Documentation/accel/
 F:	drivers/accel/
 
 DRM DRIVERS FOR ALLWINNER A10
-- 
2.25.1

