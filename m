Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8180E6082A5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJVAHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJVAGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:06:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75E8298221;
        Fri, 21 Oct 2022 17:06:02 -0700 (PDT)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 58CE7660237E;
        Sat, 22 Oct 2022 01:05:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666397112;
        bh=WX42UbRvhWW+T6eeBIcTxHMTmQHOlCr/w9dQBRM9Sbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geQ+/02SNv/LYOif/AjLbHTsJB9XKDsQAlw1G3Lsjj5nqXvVLn6dDXmtZZolv0cgU
         DgCfEOmwdDf3SviUmGDyevfHeJzj5NTIA6E6Q48j6+T5YCuBtSjQrvoJYMathTJvJ7
         AxpNiBOciLm/kTFp7a5rvWMR5aXKVjqlWvtjanu9DIr6TUEGiP5tUKU1D1OWcVKqVU
         TgNDLf+6o0fDfyKww6tiCHVUW9OlVg8ixivfX39Oc0JjOvYs55cCGVoC5DPtpzxjcy
         sZm3MEi0nupxr2riWHXa3KJpUddMTqnBZhgoKUaMtpZP9Qg0z8b+G8+JL2bTX7OEfP
         qQYpvu3IncVdQ==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     kernel@collabora.com, nas.chung@chipsnmedia.com,
        hverkuil@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        linux-kernel@vger.kernel.org, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, dafna@fastmail.com
Subject: [PATCH v10 1/7] media: platform: chips-media: Move Coda to separate folder
Date:   Sat, 22 Oct 2022 02:05:00 +0200
Message-Id: <20221022000506.221933-2-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221022000506.221933-1-sebastian.fricke@collabora.com>
References: <20221022000506.221933-1-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the folder structure for a second Chips&Media driver.
Move the Coda driver to a sub-directory.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 MAINTAINERS                                    |  2 +-
 drivers/media/platform/chips-media/Kconfig     | 17 +----------------
 drivers/media/platform/chips-media/Makefile    |  5 +----
 .../media/platform/chips-media/coda/Kconfig    | 18 ++++++++++++++++++
 .../media/platform/chips-media/coda/Makefile   |  6 ++++++
 .../platform/chips-media/{ => coda}/coda-bit.c |  0
 .../chips-media/{ => coda}/coda-common.c       |  0
 .../platform/chips-media/{ => coda}/coda-gdi.c |  0
 .../chips-media/{ => coda}/coda-h264.c         |  0
 .../chips-media/{ => coda}/coda-jpeg.c         |  0
 .../chips-media/{ => coda}/coda-mpeg2.c        |  0
 .../chips-media/{ => coda}/coda-mpeg4.c        |  0
 .../platform/chips-media/{ => coda}/coda.h     |  0
 .../chips-media/{ => coda}/coda_regs.h         |  0
 .../platform/chips-media/{ => coda}/imx-vdoa.c |  0
 .../platform/chips-media/{ => coda}/imx-vdoa.h |  0
 .../platform/chips-media/{ => coda}/trace.h    |  0
 17 files changed, 27 insertions(+), 21 deletions(-)
 create mode 100644 drivers/media/platform/chips-media/coda/Kconfig
 create mode 100644 drivers/media/platform/chips-media/coda/Makefile
 rename drivers/media/platform/chips-media/{ => coda}/coda-bit.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-common.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-gdi.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-h264.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-jpeg.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-mpeg2.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-mpeg4.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda.h (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda_regs.h (100%)
 rename drivers/media/platform/chips-media/{ => coda}/imx-vdoa.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/imx-vdoa.h (100%)
 rename drivers/media/platform/chips-media/{ => coda}/trace.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..618fd1a490f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5135,7 +5135,7 @@ M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/coda.yaml
-F:	drivers/media/platform/chips-media/
+F:	drivers/media/platform/chips-media/coda
 
 CODE OF CONDUCT
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/drivers/media/platform/chips-media/Kconfig b/drivers/media/platform/chips-media/Kconfig
index 57f8f8a22df8..f87a0d693df7 100644
--- a/drivers/media/platform/chips-media/Kconfig
+++ b/drivers/media/platform/chips-media/Kconfig
@@ -2,19 +2,4 @@
 
 comment "Chips&Media media platform drivers"
 
-config VIDEO_CODA
-	tristate "Chips&Media Coda multi-standard codec IP"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && OF && (ARCH_MXC || COMPILE_TEST)
-	select SRAM
-	select VIDEOBUF2_DMA_CONTIG
-	select VIDEOBUF2_VMALLOC
-	select V4L2_JPEG_HELPER
-	select V4L2_MEM2MEM_DEV
-	select GENERIC_ALLOCATOR
-	help
-	   Coda is a range of video codec IPs that supports
-	   H.264, MPEG-4, and other video formats.
-
-config VIDEO_IMX_VDOA
-	def_tristate VIDEO_CODA if SOC_IMX6Q || COMPILE_TEST
+source "drivers/media/platform/chips-media/coda/Kconfig"
diff --git a/drivers/media/platform/chips-media/Makefile b/drivers/media/platform/chips-media/Makefile
index bbb16425a875..5ee693f651c1 100644
--- a/drivers/media/platform/chips-media/Makefile
+++ b/drivers/media/platform/chips-media/Makefile
@@ -1,6 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-coda-vpu-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
-
-obj-$(CONFIG_VIDEO_CODA) += coda-vpu.o
-obj-$(CONFIG_VIDEO_IMX_VDOA) += imx-vdoa.o
+obj-y += coda/
diff --git a/drivers/media/platform/chips-media/coda/Kconfig b/drivers/media/platform/chips-media/coda/Kconfig
new file mode 100644
index 000000000000..cb7b66c71380
--- /dev/null
+++ b/drivers/media/platform/chips-media/coda/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config VIDEO_CODA
+	tristate "Chips&Media Coda multi-standard codec IP"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && OF && (ARCH_MXC || COMPILE_TEST)
+	select SRAM
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	select V4L2_JPEG_HELPER
+	select V4L2_MEM2MEM_DEV
+	select GENERIC_ALLOCATOR
+	help
+	   Coda is a range of video codec IPs that supports
+	   H.264, MPEG-4, and other video formats.
+
+config VIDEO_IMX_VDOA
+	def_tristate VIDEO_CODA if SOC_IMX6Q || COMPILE_TEST
diff --git a/drivers/media/platform/chips-media/coda/Makefile b/drivers/media/platform/chips-media/coda/Makefile
new file mode 100644
index 000000000000..bbb16425a875
--- /dev/null
+++ b/drivers/media/platform/chips-media/coda/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+coda-vpu-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
+
+obj-$(CONFIG_VIDEO_CODA) += coda-vpu.o
+obj-$(CONFIG_VIDEO_IMX_VDOA) += imx-vdoa.o
diff --git a/drivers/media/platform/chips-media/coda-bit.c b/drivers/media/platform/chips-media/coda/coda-bit.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-bit.c
rename to drivers/media/platform/chips-media/coda/coda-bit.c
diff --git a/drivers/media/platform/chips-media/coda-common.c b/drivers/media/platform/chips-media/coda/coda-common.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-common.c
rename to drivers/media/platform/chips-media/coda/coda-common.c
diff --git a/drivers/media/platform/chips-media/coda-gdi.c b/drivers/media/platform/chips-media/coda/coda-gdi.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-gdi.c
rename to drivers/media/platform/chips-media/coda/coda-gdi.c
diff --git a/drivers/media/platform/chips-media/coda-h264.c b/drivers/media/platform/chips-media/coda/coda-h264.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-h264.c
rename to drivers/media/platform/chips-media/coda/coda-h264.c
diff --git a/drivers/media/platform/chips-media/coda-jpeg.c b/drivers/media/platform/chips-media/coda/coda-jpeg.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-jpeg.c
rename to drivers/media/platform/chips-media/coda/coda-jpeg.c
diff --git a/drivers/media/platform/chips-media/coda-mpeg2.c b/drivers/media/platform/chips-media/coda/coda-mpeg2.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-mpeg2.c
rename to drivers/media/platform/chips-media/coda/coda-mpeg2.c
diff --git a/drivers/media/platform/chips-media/coda-mpeg4.c b/drivers/media/platform/chips-media/coda/coda-mpeg4.c
similarity index 100%
rename from drivers/media/platform/chips-media/coda-mpeg4.c
rename to drivers/media/platform/chips-media/coda/coda-mpeg4.c
diff --git a/drivers/media/platform/chips-media/coda.h b/drivers/media/platform/chips-media/coda/coda.h
similarity index 100%
rename from drivers/media/platform/chips-media/coda.h
rename to drivers/media/platform/chips-media/coda/coda.h
diff --git a/drivers/media/platform/chips-media/coda_regs.h b/drivers/media/platform/chips-media/coda/coda_regs.h
similarity index 100%
rename from drivers/media/platform/chips-media/coda_regs.h
rename to drivers/media/platform/chips-media/coda/coda_regs.h
diff --git a/drivers/media/platform/chips-media/imx-vdoa.c b/drivers/media/platform/chips-media/coda/imx-vdoa.c
similarity index 100%
rename from drivers/media/platform/chips-media/imx-vdoa.c
rename to drivers/media/platform/chips-media/coda/imx-vdoa.c
diff --git a/drivers/media/platform/chips-media/imx-vdoa.h b/drivers/media/platform/chips-media/coda/imx-vdoa.h
similarity index 100%
rename from drivers/media/platform/chips-media/imx-vdoa.h
rename to drivers/media/platform/chips-media/coda/imx-vdoa.h
diff --git a/drivers/media/platform/chips-media/trace.h b/drivers/media/platform/chips-media/coda/trace.h
similarity index 100%
rename from drivers/media/platform/chips-media/trace.h
rename to drivers/media/platform/chips-media/coda/trace.h
-- 
2.25.1

