Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0DE5BB075
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiIPPly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiIPPld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:41:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F5AB07C5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:41:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y3so50364133ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=i1s44syzFEYnr0eNDyLT85KmbD8ohRjyNiKZIDjm3/o=;
        b=c3HQ5Ugb/LUNiXlZYL/qejNXQ2xsNsnG7rPz7B1k67AOWbTZUztIVb+j3O0A1ZMzgN
         YBXD4/9PK23WtMmlELuGmXD2+3UMXu+Kzif2qcxQbq7Ka/xvIH3McYljYTAjxSsXyT6n
         rQAq4pGEZEVHasSGwI1zjTFOIlD8TuZ3RYD9PViGC72085vqoMuBoltunJpOWXn/l4eP
         qD9OAz1FsD7frLp5dNHbvkwv7/ab8M8hWMVNNvJyJXa2WwAXC4ZAaqLziOxD6bLHgXvk
         OMQeiZjRzg47gQdoi9g9excYhVXFD4g34/xENJSPudlS4aRDeH5xVumgrtCQTz5XUMh8
         ufYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=i1s44syzFEYnr0eNDyLT85KmbD8ohRjyNiKZIDjm3/o=;
        b=U75AprXnXrDDdr387dDR8gkOpko2kPpVE4E7pFDuLPT1bwg0Jd2FpR2FGZYAMOs/Ud
         /qBRXJ24ywIhvhLaDS0q1c49qmNB/E1b2rjr3JmEMVJBG6G0eO7wbrukSSRriJVAvY6i
         ze+d1larKzN0djPCk6CfPfPFy6ImIO3lzLspuJAmNX28lDi8vQylUk/MIr73h7fqhqLa
         QZMwGqwMUvJoJzwHBsDVWSqgQBXqNqdneMlw9Jyu2p5FGluVprnDHPNSZdJtBxzgm7St
         Yh+tyMACnAEBF/j6YL9nfMDFW4mFPtuHZtCTs27aeL8rs11IdH20EyPMaSlPiKR9iWup
         oIxg==
X-Gm-Message-State: ACrzQf2FI/F6OLTttut4tq495isJWhb0PzZRoYo2zxY+2+WfFIMykXx7
        yD32Odkg6W6FvBUN0dIMDCFhhA==
X-Google-Smtp-Source: AMsMyM7I7AU8B33k9c3fSGSpbC1fQvriVGAIFnwscUKk4paQ8FqKb/I9zZXG3YG23nVptTglV/Qung==
X-Received: by 2002:a17:907:c15:b0:775:df03:3f06 with SMTP id ga21-20020a1709070c1500b00775df033f06mr3887524ejc.89.1663342886049;
        Fri, 16 Sep 2022 08:41:26 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e10-20020a1709062c0a00b0073d638a7a89sm10567707ejh.99.2022.09.16.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:41:25 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 7/9] misc: fastrpc: Safekeep mmaps on interrupted invoke
Date:   Fri, 16 Sep 2022 18:41:00 +0300
Message-Id: <20220916154102.1768088-8-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916154102.1768088-1-abel.vesa@linaro.org>
References: <20220916154102.1768088-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the userspace daemon is killed in the middle of an invoke (e.g.
audiopd listerner invoke), we need to skip the unmapping on device
release, otherwise the DSP will crash. So lets safekeep all the maps
only if there is in invoke interrupted, by attaching them to the channel
context (which is resident until RPMSG driver is removed), and free them
on RPMSG driver remove.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index b123b6783920..971d4fc697fa 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -275,6 +275,7 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
 	struct fastrpc_buf *remote_heap;
+	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
 };
@@ -1119,6 +1120,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   struct fastrpc_invoke_args *args)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
+	struct fastrpc_buf *buf, *b;
 	int err = 0;
 
 	if (!fl->sctx)
@@ -1182,6 +1184,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		fastrpc_context_put(ctx);
 	}
 
+	if (err == -ERESTARTSYS) {
+		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
+			list_del(&buf->node);
+			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
+		}
+	}
+
 	if (err)
 		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
 
@@ -2281,6 +2290,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	dev_set_drvdata(&rpdev->dev, data);
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
+	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
@@ -2305,6 +2315,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
 
@@ -2319,6 +2330,11 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
+	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node) {
+		list_del(&buf->node);
+		fastrpc_buf_free(buf);
+	}
+
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
 
-- 
2.34.1

