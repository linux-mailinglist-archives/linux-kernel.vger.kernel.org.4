Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06556D0A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjC3Plc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjC3Pk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:40:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9F046AF;
        Thu, 30 Mar 2023 08:40:54 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:792c:96d5:14:366a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BD01B660318C;
        Thu, 30 Mar 2023 16:40:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680190853;
        bh=HGOVOLXmfpmKtiuLPM9Hh5Ta2f/pWPBmoi6igAOE0bY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lq3YSFaZYjdFEfn4UrvKGCP6RpBPvuFCSpaCypvJzoqxMLZOpEQKF84ORtA9VoQVQ
         Ulx+KgLTKusNyHU/aKhRT24atszHUa3S68f4r84fOlTZxxiAulfvejACsNMd8n0aR1
         JRUV1gO5yBgsRHlYefM+t/li+ReuazvFnVfjlOCke4yWPM+/O6fvqWFWWdgQKAzExF
         5AFg5dUowVGxdKuarnDnjM0nsIyCnvYCcyHrX0IXLDrwuuglWCo8aIYnVvDmIesFbt
         A9Jh1uH0R1Fwsl9y7hRgET9LrfGxm5P2lUp7z9QT3Avad2bSAATQwDWy13GewrO2g9
         lUFDlIzIvZzUg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v5 03/13] media: Add NV12_10LE40_4L4 pixel format
Date:   Thu, 30 Mar 2023 17:40:33 +0200
Message-Id: <20230330154043.1250736-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
References: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NV12_10LE40_4L4 is the 10-bits per component version of
NV12_4L4 pixel format.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst | 4 ++++
 drivers/media/v4l2-core/v4l2-common.c                       | 1 +
 drivers/media/v4l2-core/v4l2-ioctl.c                        | 1 +
 include/uapi/linux/videodev2.h                              | 1 +
 4 files changed, 7 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index f1d5bb7b806d..8805213a75f8 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -270,6 +270,7 @@ of the luma plane.
 .. _V4L2-PIX-FMT-NV12MT:
 .. _V4L2-PIX-FMT-NV12MT-16X16:
 .. _V4L2-PIX-FMT-NV12-4L4:
+.. _V4L2-PIX-FMT-NV12-10LE40-4L4:
 .. _V4L2-PIX-FMT-NV12-16L16:
 .. _V4L2-PIX-FMT-NV12-32L32:
 .. _V4L2-PIX-FMT-NV12M-8L128:
@@ -306,6 +307,9 @@ tiles linearly in memory. The line stride and image height must be
 aligned to a multiple of 4. The layouts of the luma and chroma planes are
 identical.
 
+``V4L2_PIX_FMT_NV12_10LE40_4L4`` is similar to ``V4L2_PIX_FMT_NV12_4L4``
+and stores 10 bits pixels in 4x4 tiles.
+
 ``V4L2_PIX_FMT_NV12_16L16`` stores pixels in 16x16 tiles, and stores
 tiles linearly in memory. The line stride and image height must be
 aligned to a multiple of 16. The layouts of the luma and chroma planes are
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 9cb0895dea1c..7f46c45982d6 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -278,6 +278,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 
 		/* Tiled YUV formats */
 		{ .format = V4L2_PIX_FMT_NV12_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_NV12_10LE40_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 10, 0, 0 }, .bpp_div = { 4, 4, 1, 1 }, .hdiv = 2, .vdiv = 2 },
 		{ .format = V4L2_PIX_FMT_P010_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 2, .vdiv = 2 },
 
 		/* YUV planar formats, non contiguous variant */
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index d2b905ba5240..5a0c5b3a6b0f 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1351,6 +1351,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/UV 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/UV 4:2:0 (16x16 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/UV 4:2:0 (32x32 Linear)"; break;
+	case V4L2_PIX_FMT_NV12_10LE40_4L4: descr = "10-bit YUV 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_P010_4L4:	descr = "10-bit Y/UV 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M:	descr = "Y/UV 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_NV21M:	descr = "Y/VU 4:2:0 (N-C)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 8cdc7967cdea..93e300111ca1 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -664,6 +664,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_NV12_4L4 v4l2_fourcc('V', 'T', '1', '2')   /* 12  Y/CbCr 4:2:0  4x4 tiles */
 #define V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
 #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S', 'T', '1', '2') /* 12  Y/CbCr 4:2:0 32x32 tiles */
+#define V4L2_PIX_FMT_NV12_10LE40_4L4 v4l2_fourcc('V', 'T', '1', '5')
 #define V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y/CbCr 4:2:0 10-bit 4x4 macroblocks */
 #define V4L2_PIX_FMT_NV12_8L128       v4l2_fourcc('A', 'T', '1', '2') /* Y/CbCr 4:2:0 8x128 tiles */
 #define V4L2_PIX_FMT_NV12_10BE_8L128  v4l2_fourcc_be('A', 'X', '1', '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
-- 
2.34.1

