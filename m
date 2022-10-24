Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B860460BD01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiJXWDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiJXWDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:03:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9521B8980A;
        Mon, 24 Oct 2022 13:17:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t25so2108089ejb.8;
        Mon, 24 Oct 2022 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYPY8eOn0zkxqUP4mUno/SYzJ1DIlxFXrIT859K9TgU=;
        b=EJa3gJX9kpMHCgLySDmPpfU47pQabWL6PyiJcpU4NaqTOR7QqHeiCspctIO6x82Yl4
         N87S3YjLt3Z10rirNDAv7RISUFTpqlQN1+amxqjyzKrwG3OB26uEzso5FhIZMkkz73yG
         iXLo/0lKQ/Of/I6RilPU5vunfpHg3CweixhF9xKG+lUGyQ5UWrpI0LwxoIq1w93XipTd
         CyfotY3hUJHustjs43cbxZ+9lgOTBErByMtqy20tYIA+VntaDriOGDAc74ChF0qK0nrl
         Ch/swzSdOWk1udjpQQnJg+L5yd6g1xE7J0c4xWI56R0enWi31p6PdCvwmne9n1v+PwD4
         LhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYPY8eOn0zkxqUP4mUno/SYzJ1DIlxFXrIT859K9TgU=;
        b=kpsJmNFU3FjW7q3D3kY+Zedl08nJn7iE7htagAyno67KOnw423UFcxsjzljvD8r4z4
         WE6blWzvA368SFX2pi6Lf3dOnAn1uOIiBtqGskA/sTQLqRdA0+ljwA9vL6xo8sJqFiII
         t/rlU5GfJKYeMa4RGBoIFkhl41M9/I/rmomOTDJi9Qa2uQatoILSs/cp+XYYCXNuXga7
         70SznZ9jVOGVVezTIfa9CXOAH/lSPq3J7GafcoBoAVJ/ehfzImsqNFjuSXAYt22fedWK
         bNnmChzDns8pONI1bLwiCtlRlPyHmHC6CzNA0GnvNwzVItt8ex2AfvlZEqkqjxzaQMr/
         EMLw==
X-Gm-Message-State: ACrzQf2aLMvQvn0QvNRglUuyj3fIH1y/WsQ+RBfyPWhTuyCsjtcVXAgb
        3dSYMyCttViVMEHkJxT3cXI=
X-Google-Smtp-Source: AMsMyM4PvZf0jAyv0mttuEvx1QNQZNnkovUvS2t7IMk9if/3+tHnh6GVwn7xGI2X3dNHMUCCF/wmJQ==
X-Received: by 2002:a17:907:2712:b0:78d:a223:729b with SMTP id w18-20020a170907271200b0078da223729bmr29546597ejk.443.1666642537061;
        Mon, 24 Oct 2022 13:15:37 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:36 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 07/11] media: cedrus: Remove cedrus_codec enum
Date:   Mon, 24 Oct 2022 22:15:11 +0200
Message-Id: <20221024201515.34129-8-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024201515.34129-1-jernej.skrabec@gmail.com>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last user of cedrus_codec enum is cedrus_engine_enable() but this
argument is completely redundant. Same information can be obtained via
source pixel format. Let's remove this argument and enum.

No functional changes intended.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.h       |  8 --------
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c  |  2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c  |  2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c    | 12 ++++++------
 drivers/staging/media/sunxi/cedrus/cedrus_hw.h    |  2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c |  2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_vp8.c   |  2 +-
 7 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 0b082b1fae22..5904294f3108 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -35,14 +35,6 @@
 #define CEDRUS_CAPABILITY_VP8_DEC	BIT(4)
 #define CEDRUS_CAPABILITY_H265_10_DEC	BIT(5)
 
-enum cedrus_codec {
-	CEDRUS_CODEC_MPEG2,
-	CEDRUS_CODEC_H264,
-	CEDRUS_CODEC_H265,
-	CEDRUS_CODEC_VP8,
-	CEDRUS_CODEC_LAST,
-};
-
 enum cedrus_irq_status {
 	CEDRUS_IRQ_NONE,
 	CEDRUS_IRQ_ERROR,
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index c92dec21c1ac..dfb401df138a 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -518,7 +518,7 @@ static int cedrus_h264_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	struct cedrus_dev *dev = ctx->dev;
 	int ret;
 
-	cedrus_engine_enable(ctx, CEDRUS_CODEC_H264);
+	cedrus_engine_enable(ctx);
 
 	cedrus_write(dev, VE_H264_SDROT_CTRL, 0);
 	cedrus_write(dev, VE_H264_EXTRA_BUFFER1,
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 7a438cd22c34..5d3da50ce46a 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -471,7 +471,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	}
 
 	/* Activate H265 engine. */
-	cedrus_engine_enable(ctx, CEDRUS_CODEC_H265);
+	cedrus_engine_enable(ctx);
 
 	/* Source offset and length in bits. */
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index c3387cd1e80f..fa86a658fdc6 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -31,7 +31,7 @@
 #include "cedrus_hw.h"
 #include "cedrus_regs.h"
 
-int cedrus_engine_enable(struct cedrus_ctx *ctx, enum cedrus_codec codec)
+int cedrus_engine_enable(struct cedrus_ctx *ctx)
 {
 	u32 reg = 0;
 
@@ -42,18 +42,18 @@ int cedrus_engine_enable(struct cedrus_ctx *ctx, enum cedrus_codec codec)
 	reg |= VE_MODE_REC_WR_MODE_2MB;
 	reg |= VE_MODE_DDR_MODE_BW_128;
 
-	switch (codec) {
-	case CEDRUS_CODEC_MPEG2:
+	switch (ctx->src_fmt.pixelformat) {
+	case V4L2_PIX_FMT_MPEG2_SLICE:
 		reg |= VE_MODE_DEC_MPEG;
 		break;
 
 	/* H.264 and VP8 both use the same decoding mode bit. */
-	case CEDRUS_CODEC_H264:
-	case CEDRUS_CODEC_VP8:
+	case V4L2_PIX_FMT_H264_SLICE:
+	case V4L2_PIX_FMT_VP8_FRAME:
 		reg |= VE_MODE_DEC_H264;
 		break;
 
-	case CEDRUS_CODEC_H265:
+	case V4L2_PIX_FMT_HEVC_SLICE:
 		reg |= VE_MODE_DEC_H265;
 		break;
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
index 7c92f00e36da..6f1e701b1ea8 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.h
@@ -16,7 +16,7 @@
 #ifndef _CEDRUS_HW_H_
 #define _CEDRUS_HW_H_
 
-int cedrus_engine_enable(struct cedrus_ctx *ctx, enum cedrus_codec codec);
+int cedrus_engine_enable(struct cedrus_ctx *ctx);
 void cedrus_engine_disable(struct cedrus_dev *dev);
 
 void cedrus_dst_format_set(struct cedrus_dev *dev,
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
index c1128d2cd555..10e98f08aafc 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
@@ -66,7 +66,7 @@ static int cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	quantisation = run->mpeg2.quantisation;
 
 	/* Activate MPEG engine. */
-	cedrus_engine_enable(ctx, CEDRUS_CODEC_MPEG2);
+	cedrus_engine_enable(ctx);
 
 	/* Set intra quantisation matrix. */
 	matrix = quantisation->intra_quantiser_matrix;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
index f7714baae37d..969677a3bbf9 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
@@ -662,7 +662,7 @@ static int cedrus_vp8_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	int header_size;
 	u32 reg;
 
-	cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
+	cedrus_engine_enable(ctx);
 
 	cedrus_write(dev, VE_H264_CTRL, VE_H264_CTRL_VP8);
 
-- 
2.38.1

