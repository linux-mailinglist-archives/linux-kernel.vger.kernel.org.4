Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3FC616BC5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiKBSJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKBSIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:08:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CB9E087;
        Wed,  2 Nov 2022 11:08:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f7so22045628edc.6;
        Wed, 02 Nov 2022 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTX/CJSb7MB7yBzrjB/XPnpPEfJPqcJy2sRni4DNHhc=;
        b=BWwH0PLp6JQ9eYWdTML13I1KDHGFTpJL2HjwEIHw81SznXWlFHTHSGWOlc7rSeX503
         9wqgaJhi0gATwz9JUOCOVIlEvlOcAAxSSw4jpkKHc1XQj8MYdzptxvQQa10K74lJnjKO
         jYsqyFNonzO42fSV0aDTHyZcLt48Xwneh3+krvC2SQV75tXrTQ6zEY8ieSrftyVNXarC
         FxZCPMocPoPCtGFhYjDdZjDakeFDyxbJUOA5ueFmLMmXM7e5+tsZ8JllrRhSr7gjS0Tj
         QXKdq4b+3GH/aCvfMgDMokftvmjIQP3LAxTJP355QlPNg/lpS8lip99Qg0Ha4m7/3OA1
         daRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTX/CJSb7MB7yBzrjB/XPnpPEfJPqcJy2sRni4DNHhc=;
        b=lqSTp2lxC4v8RpL9dswpddQguHcIva2fa9pGM+t/4V5j+TBpCYMd1W1zbahApcvGyp
         qr2I7WDVFVelnE0WI77lM4vC2KxZjkYG9/MAbUSTD8GvNtMBYX05Hy552kjQVmI5hE4H
         t3OaggQHwxDTsanL15QSzgtKSjo++ba4rf9VaGpAVaIT+CBct8RwPIF6w8BW9YYIgFSU
         UqsTM0KpW6BZ4pgq7AnWRWUCWMMxWx1Y52+mpKJPf5QpnEheCWTfPibmy98aXwRn8Ikr
         usJhO2YTC70JYfsVksW08NH94KnkIodo70ruBNG9rl9HH3tfQ2plQadLl7QEnzmh9KUr
         LH6g==
X-Gm-Message-State: ACrzQf2iSMm2z284WjB0TIJxNfr5bqzwouRwfkryKbUSxXNc89clxFqo
        rHRf5ZgqX8y/CQyMU41xk2I=
X-Google-Smtp-Source: AMsMyM7IKKboWbODn0dEZMDDWaIh2XhF9lJrzZnIHY8gQG+UF2lAOeAb//oR918UqPONo5aKDRZFjg==
X-Received: by 2002:a05:6402:528a:b0:454:8613:6560 with SMTP id en10-20020a056402528a00b0045486136560mr26656883edb.252.1667412508810;
        Wed, 02 Nov 2022 11:08:28 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b007317f017e64sm5677460ejb.134.2022.11.02.11.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:08:28 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 10/11] media: cedrus: Adjust buffer size based on control values
Date:   Wed,  2 Nov 2022 19:08:09 +0100
Message-Id: <20221102180810.267252-11-jernej.skrabec@gmail.com>
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

In some cases decoding engine needs extra space in capture buffers. This
is the case for decoding 10-bit HEVC frames into 8-bit capture format.
This commit only adds infrastructure for such cases.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c       | 14 ++++++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus.h       |  2 ++
 drivers/staging/media/sunxi/cedrus/cedrus_video.c |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 6a2c08928613..c36999e47591 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -68,8 +68,22 @@ static int cedrus_try_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int cedrus_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct cedrus_ctx *ctx = container_of(ctrl->handler,
+					      struct cedrus_ctx, hdl);
+	struct vb2_queue *vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+					       V4L2_BUF_TYPE_VIDEO_CAPTURE);
+
+	if (!vb2_is_busy(vq) && !vb2_is_streaming(vq))
+		cedrus_reset_cap_format(ctx);
+
+	return 0;
+}
+
 static const struct v4l2_ctrl_ops cedrus_ctrl_ops = {
 	.try_ctrl = cedrus_try_ctrl,
+	.s_ctrl = cedrus_s_ctrl,
 };
 
 static const struct cedrus_control cedrus_controls[] = {
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 5904294f3108..774fe8048ce3 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -162,6 +162,8 @@ struct cedrus_dec_ops {
 	int (*start)(struct cedrus_ctx *ctx);
 	void (*stop)(struct cedrus_ctx *ctx);
 	void (*trigger)(struct cedrus_ctx *ctx);
+	unsigned int (*extra_cap_size)(struct cedrus_ctx *ctx,
+				       struct v4l2_pix_format *pix_fmt);
 };
 
 struct cedrus_variant {
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index dec5d3ae4871..dc67940f1ade 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -250,6 +250,10 @@ static int cedrus_try_fmt_vid_cap_p(struct cedrus_ctx *ctx,
 	pix_fmt->height = ctx->src_fmt.height;
 	cedrus_prepare_format(pix_fmt);
 
+	if (ctx->current_codec->extra_cap_size)
+		pix_fmt->sizeimage +=
+			ctx->current_codec->extra_cap_size(ctx, pix_fmt);
+
 	return 0;
 }
 
-- 
2.38.1

