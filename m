Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012A6608FD3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 23:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJVVqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 17:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJVVql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 17:46:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66C3EA9FF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 14:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC0F60ABB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 21:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C717EC43470;
        Sat, 22 Oct 2022 21:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666475198;
        bh=TdjCoZ4FJ+aLY/5yyYbGnM3YqwZ2I6wju2Ck5ByPiJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3jw+Cpr368TcCfXa/pufj2ilReVLWCc5TiGVbKmjg1H1mcarij7qaognVkhfK7vb
         n04AYuwGT2QgCVU6YKmgraxLWr6yNXYBRUOAT5yGTZWzcpQT5DRmxN/YVgyxiRdJn6
         EXy2dUEFqXZBIA3tVsfqv11iVD3P/snbTfBqqQQ7Amy+cT7Sh/dgv514azaLuG0Vvr
         FL/6Lf00FFYQ0aHp6GR6JoisQyLKDUbI/mAivE9qlNgsnO1dmJk7MDZjXudAcQJdBS
         U7YmJtj+7IQbeWjGEx1tVZu3bMyanaQHbs/ITHLOiBt1V0+3L1Xxp/UAztS/IUBiDb
         BCeO8JNaJ5IdQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Subject: [RFC PATCH 1/3] drivers/accel: add new kconfig and update MAINTAINERS
Date:   Sun, 23 Oct 2022 00:46:20 +0300
Message-Id: <20221022214622.18042-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022214622.18042-1-ogabbay@kernel.org>
References: <20221022214622.18042-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new Kconfig for the accel subsystem. The Kconfig currently
contains only the basic CONFIG_ACCEL option that will be used to
decide whether to compile the accel registration code as part of the
drm core functionality.

I have taken the liberty to appropriate the dri-devel mailing list and
the dri-devel IRC channel for the accel subsystem.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 MAINTAINERS           |  8 ++++++++
 drivers/Kconfig       |  2 ++
 drivers/accel/Kconfig | 24 ++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 drivers/accel/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..790d472801d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6820,6 +6820,14 @@ F:	include/drm/drm*
 F:	include/linux/vga*
 F:	include/uapi/drm/drm*
 
+DRM COMPUTE ACCELERATORS DRIVERS AND FRAMEWORK
+M:	Oded Gabbay <ogabbay@kernel.org>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+C:	irc://irc.oftc.net/dri-devel
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git
+F:	drivers/accel/
+
 DRM DRIVERS FOR ALLWINNER A10
 M:	Maxime Ripard <mripard@kernel.org>
 M:	Chen-Yu Tsai <wens@csie.org>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 19ee995bd0ae..968bd0a6fd78 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -99,6 +99,8 @@ source "drivers/media/Kconfig"
 
 source "drivers/video/Kconfig"
 
+source "drivers/accel/Kconfig"
+
 source "sound/Kconfig"
 
 source "drivers/hid/Kconfig"
diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
new file mode 100644
index 000000000000..282ea24f90c5
--- /dev/null
+++ b/drivers/accel/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Compute Acceleration device configuration
+#
+# This framework provides support for compute acceleration devices, such
+# as, but not limited to, Machine-Learning and Deep-Learning acceleration
+# devices
+#
+menuconfig ACCEL
+	tristate "Compute Acceleration Framework"
+	depends on DRM
+	help
+	  Framework for device drivers of compute acceleration devices, such
+	  as, but not limited to, Machine-Learning and Deep-Learning
+	  acceleration devices.
+	  If you say Y here, you need to select the module that's right for
+	  your acceleration device from the list below.
+	  This framework is integrated with the DRM subsystem as compute
+	  accelerators and GPUs share a lot in common and can use almost the
+	  same infrastructure code.
+	  Having said that, acceleration devices will have a different
+	  major number than GPUs, and will be exposed to user-space using
+	  different device files, called accel/accel* (in /dev, sysfs
+	  and debugfs)
-- 
2.34.1

