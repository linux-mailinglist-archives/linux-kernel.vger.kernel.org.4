Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522065EDD97
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiI1NU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiI1NUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:20:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7146578585
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:20:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a8so20303467lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=U36NjhsAwog7/X0GNMxs2kFxhhnbeKSocGnUpytYWXI=;
        b=fOYSihQMzyuZDyv4JUnGdl/v+/+kIk2FAZPwNqiSy2uDxtAaQzoYXK8MbFTp9pJyvt
         p/sBRodRkv7xYW58vhqAkdZUkP02VVZjJ8QzNhhxfWBXrG3kBMtGQkaE+vI+lYjd3gSV
         B/a5PqZPVllsDJwdAcv89FE88sFQc8VXV0DGMAwdiMm3L80vyHUDn/aadd4xAJoxAdJr
         EPjNLMDaaRm1wDdy+PC/zVY0FtzOHZKuX/UksYVHjKBH0r52ZBifs4DCviYmRG6Fq0NO
         97CCzK56A3Si7MgXcyGHP613wwSCQfYVtkVUk23zD40sc77RAbRlIYcYTssZOUIbQYEA
         woCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=U36NjhsAwog7/X0GNMxs2kFxhhnbeKSocGnUpytYWXI=;
        b=PKAu1jw72wQ1eH8TatVWHSffMhwe4A3uv8QNoHp2RDeV7/ks+E0FLQd06GQ3H4wwi6
         jOcKvWNomApX8DrYjAGfjpKHY85Iu10MzukUVeosYYHa7EAHoEU9qxXiuMIrVYkQYThK
         cInQaJP6HXQf4wf84c49yxbACKU9H+KtTeTA9CrB30oHYN3ceqOHIQhnsXGxOGkGpz6l
         fxDFLpbDnbJLGVntg5pnfYB2I77f2ADn1aXCSGxO4VapblJND9Z81lQPQoKadsOuXWMi
         kL2vDLhwTa/rJRkX05bnMoVaDFw8EyHm7NFxuAP6AqQsh/9ujopJWaUUqMcyvsWjRBH3
         OLrg==
X-Gm-Message-State: ACrzQf2pjZ1PHxcOpcOQi98rYl2Aeyq4v0LcevWltBqV9W6cjC3oIQl9
        ClSin/WgYkeqXF99Bm+5L89jYQ==
X-Google-Smtp-Source: AMsMyM7MhlrItXEwdt3Vv00VMHy5nJueDqpMgvsGytSWYaxV1mPq5Uux6Ggg9crZH7sLVRMRe8mroQ==
X-Received: by 2002:a05:6512:3052:b0:49e:fcb2:c1e9 with SMTP id b18-20020a056512305200b0049efcb2c1e9mr12355824lfb.260.1664371220823;
        Wed, 28 Sep 2022 06:20:20 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p11-20020ac246cb000000b00497ad9ae486sm478484lfo.62.2022.09.28.06.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:20:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] slimbus: qcom-ngd-ctrl: drop PM runtime counter on transfer error paths
Date:   Wed, 28 Sep 2022 15:20:11 +0200
Message-Id: <20220928132011.455347-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928132011.455347-1-krzysztof.kozlowski@linaro.org>
References: <20220928132011.455347-1-krzysztof.kozlowski@linaro.org>
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

If transfer in qcom_slim_ngd_xfer_msg_sync() fails, we need to drop the
PM runtime usage counter to have it balanced.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ba36eb5c0de3..ac84fdc2822f 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -919,21 +919,29 @@ static int qcom_slim_ngd_xfer_msg_sync(struct slim_controller *ctrl,
 	DECLARE_COMPLETION_ONSTACK(done);
 	int ret, timeout;
 
-	pm_runtime_get_sync(ctrl->dev);
+	ret = pm_runtime_get_sync(ctrl->dev);
+	if (ret < 0)
+		goto pm_put;
 
 	txn->comp = &done;
 
 	ret = qcom_slim_ngd_xfer_msg(ctrl, txn);
 	if (ret)
-		return ret;
+		goto pm_put;
 
 	timeout = wait_for_completion_timeout(&done, HZ);
 	if (!timeout) {
 		dev_err(ctrl->dev, "TX timed out:MC:0x%x,mt:0x%x", txn->mc,
 				txn->mt);
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
+		goto pm_put;
 	}
 	return 0;
+
+pm_put:
+	pm_runtime_put(ctrl->dev);
+
+	return ret;
 }
 
 static int qcom_slim_ngd_enable_stream(struct slim_stream_runtime *rt)
-- 
2.34.1

