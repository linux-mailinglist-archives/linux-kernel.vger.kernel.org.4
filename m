Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E06616BC4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKBSJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiKBSIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:08:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2613EDE87;
        Wed,  2 Nov 2022 11:08:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a5so27694262edb.11;
        Wed, 02 Nov 2022 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOVecSCg58WLAt5MFbBf+7umb5iX32HjizH1LHXmtzY=;
        b=c4sCG5TAZ2UUoS2lgWb76UO1do1+DNv9lhf4f4V7zz8ljX4X5EhvcAsgEefuVLOg+q
         gaywl+w/4OLpyHt3F/9Bwyiwk5P2gVSKETjqXN25CxxveeMkl1P02LTapxNRpEbc4ncS
         y0DtjSpEZpoo2aYks0chPXEMt1SraV5egn74lh0bqLCfULmWstsxoJQzoNKJwcM24qu5
         exgx3cKeSyDCHntD25R80Aed0dN9MnlXk9pnJP8nJ5srwQ3D4KTDuWMqgQDoOgnlpd23
         V9+2EcH2DuN9nLi3yQK1rC1Vva6WPZ/ddX8HBC+0qQqm0AeUMYHozRY7sbi8QTnZCa4A
         ZmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOVecSCg58WLAt5MFbBf+7umb5iX32HjizH1LHXmtzY=;
        b=iVBIUEsbDfcNNWMdmXzJoWo0KUCkXwwcFBtn/W2OKN4dMdX+CMuUrFc5/ppccJN7LM
         qippLe6N9H+Und5iZKapWjFu76Ga6rAR4WfABg1x4PIFgYM9EEvdcfWsnYdcyJL5Uvi8
         Due5jsQ2Ephea+eViC8b5GhZtsopUImoBV2Dw3T7Ttocf/PfwwMRnL5530D13vwDpeXV
         p0GjEoFEIzbUAwrYErl9SWVy91ktV1wv0KpAOizKrU3knaTb4OB9ZILXeBR8kU1Kom2+
         DHHUaHIZ9xZoO2NFT9Do5AwvS1KUEErUeirLkkJEUNNEX4XMz+Cg3Oc01RMctE9DhFwW
         QLwg==
X-Gm-Message-State: ACrzQf0hCdZwJbA1/xGctILHLtoKNf5LNVtrdsz1gEEKUIqSO7EtyQ7I
        6/fimpJ7PJbm1oi5u1BpjhM=
X-Google-Smtp-Source: AMsMyM6muLY2M00Knxi/o8lVph4GJlPIjeZVu+nV5Y9ZTqSo+P6497kNAnSyQ3n27WFCtlCImp3mvg==
X-Received: by 2002:a05:6402:249b:b0:460:cb11:27d4 with SMTP id q27-20020a056402249b00b00460cb1127d4mr25895603eda.410.1667412507718;
        Wed, 02 Nov 2022 11:08:27 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b007317f017e64sm5677460ejb.134.2022.11.02.11.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:08:27 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 09/11] media: cedrus: initialize controls a bit later
Date:   Wed,  2 Nov 2022 19:08:08 +0100
Message-Id: <20221102180810.267252-10-jernej.skrabec@gmail.com>
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

While it doesn't matter if controls are initialized before or after
queues and formats from open handler standpoint, initializing them last
helps keeping s_ctrl handler simpler, since everything has already valid
values.

This is just preparation for follow up changes. No functional change is
intended.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 37b1df9a9d6a..6a2c08928613 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -355,27 +355,27 @@ static int cedrus_open(struct file *file)
 	file->private_data = &ctx->fh;
 	ctx->dev = dev;
 
-	ret = cedrus_init_ctrls(dev, ctx);
-	if (ret)
-		goto err_free;
-
 	ctx->fh.m2m_ctx = v4l2_m2m_ctx_init(dev->m2m_dev, ctx,
 					    &cedrus_queue_init);
 	if (IS_ERR(ctx->fh.m2m_ctx)) {
 		ret = PTR_ERR(ctx->fh.m2m_ctx);
-		goto err_ctrls;
+		goto err_free;
 	}
 
 	cedrus_reset_out_format(ctx);
 
+	ret = cedrus_init_ctrls(dev, ctx);
+	if (ret)
+		goto err_m2m_release;
+
 	v4l2_fh_add(&ctx->fh);
 
 	mutex_unlock(&dev->dev_mutex);
 
 	return 0;
 
-err_ctrls:
-	v4l2_ctrl_handler_free(&ctx->hdl);
+err_m2m_release:
+	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
 err_free:
 	kfree(ctx);
 	mutex_unlock(&dev->dev_mutex);
-- 
2.38.1

