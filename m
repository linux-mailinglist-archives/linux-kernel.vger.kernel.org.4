Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2CE616BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiKBSI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiKBSI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:08:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936311126;
        Wed,  2 Nov 2022 11:08:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v27so27760537eda.1;
        Wed, 02 Nov 2022 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVKfgkXw7e+yGEdB6RQuZns0t64mr7WUnbO0yn+HdgQ=;
        b=h0ZEtU6rkOV3RkAUCGI0Fk2gczGbecEoQDwS54mZnmgWbS418dzY/BBixEIAYxLXip
         V2i73anwzm0aP9ZIdwDRbp5Dqywu05koRpckLiGHut8CbAOUTyrVCEb87/kLn4TmykGe
         EiYjuHCJtZP6iE+fOUi987R2orS9BkboheUR2EkqIVgVM+VGMe3i2RVc9tn3Nf0lvwTo
         7ZWlhY3JBpxQTtSBOJk9EV7oCM87mezibz6MO9KFpAm945gv1ntdzyDMuhAqxt9F2deQ
         sSTpS6tIrK4xK0OtP5SrSXDd8riQGZdfrG8pldzpGMuSeUhHqGpNJaSyvOSZwRXLQnms
         wvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVKfgkXw7e+yGEdB6RQuZns0t64mr7WUnbO0yn+HdgQ=;
        b=klMJtpXlKh9NwuAXbi8RRuqKacr6Ml0VzPQpoIPLzmPtyTlv6xb5+HohKf3Bh6Qe4y
         lYtM0POqvY5ghMS1nctsOxuzUGZ9m1LxkX2fWvZMHroascMO98neCjeYL/uM8GEgSmh9
         taYKdhwf19bSy4zcctwYCAmIi97dUCf97NH8IRKNC4EPzVY6+iQtrbm7OfzCkGVc7pid
         JLIcxJE3LlpmXZAaYwVCTi2vf3P/2l8zy38hUUpsHpOWwbMPugaIOOnaAh9H2QHGBcPi
         b+MKFTobd0ef/MNxhRNWmah+5OXiPPmhBNJFr6DbLU4EnSF2zu1GtCaqHTbYmoOxpenN
         IIlA==
X-Gm-Message-State: ACrzQf16LbKMhj27MhSGH/48mwzA671BooJAbGqS9ExHQTCrrlKxj6/9
        jpLp8KlyL/IzEu4PU3kNbUk=
X-Google-Smtp-Source: AMsMyM6yN9v4qUAXFe84vP1aXzMgt9F7FiiaE+8tvPrHZQY3FKfJU12X0d+8n8gzfKPQuxDAlfeh/Q==
X-Received: by 2002:a05:6402:5107:b0:462:3014:3d73 with SMTP id m7-20020a056402510700b0046230143d73mr26136541edd.177.1667412503108;
        Wed, 02 Nov 2022 11:08:23 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b007317f017e64sm5677460ejb.134.2022.11.02.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:08:22 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 05/11] media: cedrus: Filter controls based on capability
Date:   Wed,  2 Nov 2022 19:08:04 +0100
Message-Id: <20221102180810.267252-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102180810.267252-1-jernej.skrabec@gmail.com>
References: <20221102180810.267252-1-jernej.skrabec@gmail.com>
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

Because not all Cedrus variants supports all codecs, controls should be
registered only if codec related to individual control is supported by
Cedrus.

Replace codec enum, which is not used at all, with capabilities flags
and register control only if capabilities are met. We have to be careful
though, controls have to be tightly packed in ctx->ctrls array.
Otherwise functions cedrus_find_control_data() and
cedrus_get_num_of_controls() won't work properly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 50 +++++++++++----------
 drivers/staging/media/sunxi/cedrus/cedrus.h |  2 +-
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 2f284a58d787..a88ca89d966d 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -77,56 +77,56 @@ static const struct cedrus_control cedrus_controls[] = {
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_MPEG2_SEQUENCE,
 		},
-		.codec		= CEDRUS_CODEC_MPEG2,
+		.capabilities	= CEDRUS_CAPABILITY_MPEG2_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_MPEG2_PICTURE,
 		},
-		.codec		= CEDRUS_CODEC_MPEG2,
+		.capabilities	= CEDRUS_CAPABILITY_MPEG2_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_MPEG2_QUANTISATION,
 		},
-		.codec		= CEDRUS_CODEC_MPEG2,
+		.capabilities	= CEDRUS_CAPABILITY_MPEG2_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_DECODE_PARAMS,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_SLICE_PARAMS,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_SPS,
 			.ops	= &cedrus_ctrl_ops,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_PPS,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_SCALING_MATRIX,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_PRED_WEIGHTS,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
@@ -134,7 +134,7 @@ static const struct cedrus_control cedrus_controls[] = {
 			.max	= V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
 			.def	= V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
@@ -142,7 +142,7 @@ static const struct cedrus_control cedrus_controls[] = {
 			.max	= V4L2_STATELESS_H264_START_CODE_NONE,
 			.def	= V4L2_STATELESS_H264_START_CODE_NONE,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	/*
 	 * We only expose supported profiles information,
@@ -160,20 +160,20 @@ static const struct cedrus_control cedrus_controls[] = {
 			.menu_skip_mask =
 				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_HEVC_SPS,
 			.ops	= &cedrus_ctrl_ops,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_HEVC_PPS,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
@@ -181,13 +181,13 @@ static const struct cedrus_control cedrus_controls[] = {
 			/* The driver can only handle 1 entry per slice for now */
 			.dims   = { 1 },
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
@@ -197,7 +197,7 @@ static const struct cedrus_control cedrus_controls[] = {
 			.max = 0xffffffff,
 			.step = 1,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
@@ -205,7 +205,7 @@ static const struct cedrus_control cedrus_controls[] = {
 			.max	= V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
 			.def	= V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
@@ -213,19 +213,19 @@ static const struct cedrus_control cedrus_controls[] = {
 			.max	= V4L2_STATELESS_HEVC_START_CODE_NONE,
 			.def	= V4L2_STATELESS_HEVC_START_CODE_NONE,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_VP8_FRAME,
 		},
-		.codec		= CEDRUS_CODEC_VP8,
+		.capabilities	= CEDRUS_CAPABILITY_VP8_DEC,
 	},
 	{
 		.cfg = {
 			.id = V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 };
 
@@ -258,7 +258,7 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
 	struct v4l2_ctrl_handler *hdl = &ctx->hdl;
 	struct v4l2_ctrl *ctrl;
 	unsigned int ctrl_size;
-	unsigned int i;
+	unsigned int i, j;
 
 	v4l2_ctrl_handler_init(hdl, CEDRUS_CONTROLS_COUNT);
 	if (hdl->error) {
@@ -274,7 +274,11 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
 	if (!ctx->ctrls)
 		return -ENOMEM;
 
+	j = 0;
 	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
+		if (!cedrus_is_capable(ctx, cedrus_controls[i].capabilities))
+			continue;
+
 		ctrl = v4l2_ctrl_new_custom(hdl, &cedrus_controls[i].cfg,
 					    NULL);
 		if (hdl->error) {
@@ -289,7 +293,7 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
 			return hdl->error;
 		}
 
-		ctx->ctrls[i] = ctrl;
+		ctx->ctrls[j++] = ctrl;
 	}
 
 	ctx->fh.ctrl_handler = hdl;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 1a98790a99af..7a1619967513 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -57,7 +57,7 @@ enum cedrus_h264_pic_type {
 
 struct cedrus_control {
 	struct v4l2_ctrl_config cfg;
-	enum cedrus_codec	codec;
+	unsigned int		capabilities;
 };
 
 struct cedrus_h264_run {
-- 
2.38.1

