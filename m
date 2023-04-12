Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CC76DF481
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjDLL5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjDLL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:57:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE94EC5;
        Wed, 12 Apr 2023 04:57:07 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:c2e:89bd:4b8e:9e98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 75B94660324E;
        Wed, 12 Apr 2023 12:57:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681300625;
        bh=ThzgQpKn29rOpETnugQG/WgUrNNyt3wLkGRzsVZaa9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILwyPit8XOKQ9ERJy88qtRmWP+/RJIKmx+ArGsVax6EYRGtYzB7dDxEYw1utxPkMY
         SBq+v0xixFoiknzoMVHax/S6rXGlRTi3oK7HXNEee1y0zmGMbmzXZhDAiEqzQtK3Ql
         Fgoo26/UXj2XLQUGJcVFtXZAboZ2CAUUC/GVxcxLjDmHoCcfI2HrLbIfse/UxgKXYS
         M2ebiIs8/5KnIRS8j38ghFe2xC73PzkoHyD/L/nIhdEuDDZwzU/74j+O93hl5vJ+hE
         hhq8C9YdQtCNOle3s5oLJAY40mp95FeO0hI9C5l+gLIy7EXFbqjtyUCRD0VaeaXFjU
         IPHWcv97HdxWA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v6 04/13] media: Add NV15_4L4 pixel format
Date:   Wed, 12 Apr 2023 13:56:43 +0200
Message-Id: <20230412115652.403949-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412115652.403949-1-benjamin.gaignard@collabora.com>
References: <20230412115652.403949-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NV15_4L4 is the 10-bits per component 4x4 tiled format.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
Changes in v6:
- Rename NV12_10LE40_4L4 pixel format into NV15_4L4.

 .../media/v4l/pixfmt-yuv-planar.rst              | 16 ++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c            |  2 ++
 drivers/media/v4l2-core/v4l2-ioctl.c             |  1 +
 include/uapi/linux/videodev2.h                   |  1 +
 4 files changed, 20 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index f1d5bb7b806d..ebf29243032b 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -123,6 +123,13 @@ All components are stored with the same number of bits per component.
       - Cb, Cr
       - Yes
       - 4x4 tiles
+    * - V4L2_PIX_FMT_NV15_4L4
+      - 'VT15'
+      - 15
+      - 4:2:0
+      - Cb, Cr
+      - Yes
+      - 4x4 tiles
     * - V4L2_PIX_FMT_NV16
       - 'NV16'
       - 8
@@ -364,6 +371,15 @@ two non-contiguous planes.
 
     Example V4L2_PIX_FMT_NV12MT memory layout of tiles
 
+.. _V4L2-PIX-FMT-NV15-4L4:
+
+Tiled NV15
+----------
+
+Semi-planar 10-bit YUV 4:2:0 formats, using 4x4 tiling.
+All components are packed without any padding between each other.
+As a side-effect, each group of 4 components are stored over 5 bytes 
+(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes).
 
 .. _V4L2-PIX-FMT-NV16:
 .. _V4L2-PIX-FMT-NV61:
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 9cb0895dea1c..0df2848b57e8 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -278,6 +278,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 
 		/* Tiled YUV formats */
 		{ .format = V4L2_PIX_FMT_NV12_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_NV15_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 10, 0, 0 }, .bpp_div = { 4, 4, 1, 1 }, .hdiv = 2, .vdiv = 2, 
+		  .block_w = { 4, 2, 0, 0 }, .block_h = { 1, 1, 0, 0 }},
 		{ .format = V4L2_PIX_FMT_P010_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 2, .vdiv = 2 },
 
 		/* YUV planar formats, non contiguous variant */
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index d2b905ba5240..9fe2df16f1e7 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1351,6 +1351,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/UV 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/UV 4:2:0 (16x16 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/UV 4:2:0 (32x32 Linear)"; break;
+	case V4L2_PIX_FMT_NV15_4L4:	descr = "10-bit Y/UV 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_P010_4L4:	descr = "10-bit Y/UV 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M:	descr = "Y/UV 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_NV21M:	descr = "Y/VU 4:2:0 (N-C)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 8cdc7967cdea..6210b14d4ddc 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -664,6 +664,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_NV12_4L4 v4l2_fourcc('V', 'T', '1', '2')   /* 12  Y/CbCr 4:2:0  4x4 tiles */
 #define V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
 #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S', 'T', '1', '2') /* 12  Y/CbCr 4:2:0 32x32 tiles */
+#define V4L2_PIX_FMT_NV15_4L4 v4l2_fourcc('V', 'T', '1', '5') /* 15 Y/CbCr 4:2:0 10-bit 4x4 tiles */
 #define V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y/CbCr 4:2:0 10-bit 4x4 macroblocks */
 #define V4L2_PIX_FMT_NV12_8L128       v4l2_fourcc('A', 'T', '1', '2') /* Y/CbCr 4:2:0 8x128 tiles */
 #define V4L2_PIX_FMT_NV12_10BE_8L128  v4l2_fourcc_be('A', 'X', '1', '2') /* Y/CbCr 4:2:0 10-bit 8x128 tiles */
-- 
2.34.1

