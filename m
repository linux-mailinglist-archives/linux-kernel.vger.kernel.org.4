Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED56802E4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbjA2XMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjA2XMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:12:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C6E1ABF4;
        Sun, 29 Jan 2023 15:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=p1JHfxL2Hp0hAVhM60onR/hxbaqp3NJBLYWgv29llTw=; b=B9vd1HBpCHGTA2DyH9UL2IdYvL
        dZQGdWpuK9MVndysL/b68XmSo1uYTweaw9Vy6bQsA5C9WdQd8CqVibz75WSk4FX4gtql1RsSZHs33
        k4wK+HpBbDQqQaU4nN8TxhVNl5CKHbKA25AApPlZRCXwrslGpvb4no37NHooc7VMLIefwbimY8sbn
        iUHWG1ojqn6qKigB9aTSioWgKTq9GIjseNKpsB0tiyNvzfK11hiVd3ofLhbJ00Q1u+mkQ+Hl6PTAu
        owsGkbsUQLnQMzqgoqrTQTC2xu98a/lmzgoaI1CZpuXYtZ63XKdgvFc4LsRbzvSjPh/BfXsRvWxqh
        omtShmAA==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMGpR-0020M2-8M; Sun, 29 Jan 2023 23:11:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 9/9] Documentation: userspace-api: correct spelling
Date:   Sun, 29 Jan 2023 15:10:53 -0800
Message-Id: <20230129231053.20863-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129231053.20863-1-rdunlap@infradead.org>
References: <20230129231053.20863-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/userspace-api/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/userspace-api/iommufd.rst                             |    2 +-
 Documentation/userspace-api/media/drivers/st-vgxy61.rst             |    2 +-
 Documentation/userspace-api/media/rc/lirc-set-wideband-receiver.rst |    2 +-
 Documentation/userspace-api/media/rc/rc-protos.rst                  |    2 +-
 Documentation/userspace-api/media/rc/rc-tables.rst                  |    2 +-
 Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst            |    2 +-
 Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst |    2 +-
 Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst            |    2 +-
 Documentation/userspace-api/media/v4l/hist-v4l2.rst                 |    4 ++--
 Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst           |    2 +-
 Documentation/userspace-api/media/v4l/vidioc-cropcap.rst            |    2 +-
 Documentation/userspace-api/seccomp_filter.rst                      |    2 +-
 Documentation/userspace-api/sysfs-platform_profile.rst              |    2 +-
 13 files changed, 14 insertions(+), 14 deletions(-)

diff -- a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -165,7 +165,7 @@ Multiple io_pagetable-s, through their i
 iopt_pages which avoids multi-pinning and double accounting of page
 consumption.
 
-iommufd_ioas is sharable between subsystems, e.g. VFIO and VDPA, as long as
+iommufd_ioas is shareable between subsystems, e.g. VFIO and VDPA, as long as
 devices managed by different subsystems are bound to a same iommufd.
 
 IOMMUFD User API
diff -- a/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst b/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst
--- a/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst
+++ b/Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst
@@ -490,7 +490,7 @@ struct v4l2_mpeg_vbi_fmt_ivtv
       - An alternate form of the sliced VBI data payload used when 36
 	lines of sliced VBI data are present. No line masks are provided
 	in this form of the payload; all valid line mask bits are
-	implcitly set.
+	implicitly set.
     * - }
       -
 
diff -- a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -274,7 +274,7 @@ value will be the injected file descript
 The notifying process can be preempted, resulting in the notification being
 aborted. This can be problematic when trying to take actions on behalf of the
 notifying process that are long-running and typically retryable (mounting a
-filesytem). Alternatively, at filter installation time, the
+filesystem). Alternatively, at filter installation time, the
 ``SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV`` flag can be set. This flag makes it
 such that when a user notification is received by the supervisor, the notifying
 process will ignore non-fatal signals until the response is sent. Signals that
diff -- a/Documentation/userspace-api/media/v4l/hist-v4l2.rst b/Documentation/userspace-api/media/v4l/hist-v4l2.rst
--- a/Documentation/userspace-api/media/v4l/hist-v4l2.rst
+++ b/Documentation/userspace-api/media/v4l/hist-v4l2.rst
@@ -47,7 +47,7 @@ Codec API was released.
 1998-11-08: Many minor changes. Most symbols have been renamed. Some
 material changes to struct v4l2_capability.
 
-1998-11-12: The read/write directon of some ioctls was misdefined.
+1998-11-12: The read/write direction of some ioctls was misdefined.
 
 1998-11-14: ``V4L2_PIX_FMT_RGB24`` changed to ``V4L2_PIX_FMT_BGR24``,
 and ``V4L2_PIX_FMT_RGB32`` changed to ``V4L2_PIX_FMT_BGR32``. Audio
@@ -145,7 +145,7 @@ common Linux driver API conventions.
    ``VIDIOC_G_INFMT``, ``VIDIOC_S_OUTFMT``, ``VIDIOC_G_OUTFMT``,
    ``VIDIOC_S_VBIFMT`` and ``VIDIOC_G_VBIFMT``. The image format
    struct v4l2_format was renamed to struct v4l2_pix_format, while
-   struct v4l2_format is now the envelopping structure
+   struct v4l2_format is now the enveloping structure
    for all format negotiations.
 
 5. Similar to the changes above, the ``VIDIOC_G_PARM`` and
diff -- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
@@ -1213,7 +1213,7 @@ FWHT Flags
       - Luma AC coefficient table index.
     * - __s8
       - ``y_dc_delta``
-      - Luma DC delta vaue.
+      - Luma DC delta value.
     * - __s8
       - ``y2_dc_delta``
       - Y2 block DC delta value.
diff -- a/Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst
@@ -8,7 +8,7 @@ JPEG Control Reference
 
 The JPEG class includes controls for common features of JPEG encoders
 and decoders. Currently it includes features for codecs implementing
-progressive baseline DCT compression process with Huffman entrophy
+progressive baseline DCT compression process with Huffman entropy
 coding.
 
 
diff -- a/Documentation/userspace-api/media/v4l/vidioc-cropcap.rst b/Documentation/userspace-api/media/v4l/vidioc-cropcap.rst
--- a/Documentation/userspace-api/media/v4l/vidioc-cropcap.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-cropcap.rst
@@ -71,7 +71,7 @@ overlay devices.
       - Default cropping rectangle, it shall cover the "whole picture".
 	Assuming pixel aspect 1/1 this could be for example a 640 × 480
 	rectangle for NTSC, a 768 × 576 rectangle for PAL and SECAM
-	centered over the active picture area. The same co-ordinate system
+	centered over the active picture area. The same coordinate system
 	as for ``bounds`` is used.
     * - struct :c:type:`v4l2_fract`
       - ``pixelaspect``
diff -- a/Documentation/userspace-api/media/rc/lirc-set-wideband-receiver.rst b/Documentation/userspace-api/media/rc/lirc-set-wideband-receiver.rst
--- a/Documentation/userspace-api/media/rc/lirc-set-wideband-receiver.rst
+++ b/Documentation/userspace-api/media/rc/lirc-set-wideband-receiver.rst
@@ -43,7 +43,7 @@ reduced range of reception.
 
 .. note::
 
-    Wide band receiver might be implictly enabled if you enable
+    Wide band receiver might be implicitly enabled if you enable
     carrier reports. In that case it will be disabled as soon as you disable
     carrier reports. Trying to disable wide band receiver while carrier
     reports are active will do nothing.
diff -- a/Documentation/userspace-api/media/rc/rc-protos.rst b/Documentation/userspace-api/media/rc/rc-protos.rst
--- a/Documentation/userspace-api/media/rc/rc-protos.rst
+++ b/Documentation/userspace-api/media/rc/rc-protos.rst
@@ -75,7 +75,7 @@ protocol, or the manchester BPF decoder.
      - Command
 
 There is a variant of rc5 called either rc5x or extended rc5
-where there the second stop bit is the 6th commmand bit, but inverted.
+where there the second stop bit is the 6th command bit, but inverted.
 This is done so it the scancodes and encoding is compatible with existing
 schemes. This bit is stored in bit 6 of the scancode, inverted. This is
 done to keep it compatible with plain rc-5 where there are two start bits.
diff -- a/Documentation/userspace-api/media/rc/rc-tables.rst b/Documentation/userspace-api/media/rc/rc-tables.rst
--- a/Documentation/userspace-api/media/rc/rc-tables.rst
+++ b/Documentation/userspace-api/media/rc/rc-tables.rst
@@ -628,7 +628,7 @@ the remote via /dev/input/event devices.
 
        -  Put device into zoom/full screen mode
 
-       -  ZOOM / FULL SCREEN / ZOOM+ / HIDE PANNEL / SWITCH
+       -  ZOOM / FULL SCREEN / ZOOM+ / HIDE PANEL / SWITCH
 
     -  .. row 80
 
diff -- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
@@ -14,7 +14,7 @@ are often referred to as greyscale forma
    - In all the tables that follow, bit 7 is the most significant bit in a byte.
    - Formats are described with the minimum number of pixels needed to create a
      byte-aligned repeating pattern. `...` indicates repetition of the pattern.
-   - Y'\ :sub:`x`\ [9:2] denotes bits 9 to 2 of the Y' value for pixel at colum
+   - Y'\ :sub:`x`\ [9:2] denotes bits 9 to 2 of the Y' value for pixel at column
      `x`.
    - `0` denotes padding bits set to 0.
 
diff -- a/Documentation/userspace-api/media/drivers/st-vgxy61.rst b/Documentation/userspace-api/media/drivers/st-vgxy61.rst
--- a/Documentation/userspace-api/media/drivers/st-vgxy61.rst
+++ b/Documentation/userspace-api/media/drivers/st-vgxy61.rst
@@ -18,7 +18,7 @@ The ST VGXY61 driver implements the foll
     * - HDR linearize
       - The merger outputs a long exposure capture as long as it is not
         saturated.
-    * - HDR substraction
+    * - HDR subtraction
       - This involves subtracting the short exposure frame from the long
         exposure frame.
     * - No HDR
diff -- a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
--- a/Documentation/userspace-api/sysfs-platform_profile.rst
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -37,6 +37,6 @@ representation onto this fixed set.
 If there is no good match when mapping then a new profile name may be
 added. Drivers which wish to introduce new profile names must:
 
- 1. Explain why the existing profile names canot be used.
+ 1. Explain why the existing profile names cannot be used.
  2. Add the new profile name, along with a clear description of the
     expected behaviour, to the sysfs-platform_profile ABI documentation.
