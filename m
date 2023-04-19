Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B76E7D23
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjDSOmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjDSOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:42:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78AC448F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:41:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id iw7-20020a05600c54c700b003f16fce55b5so1579603wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20221208.gappssmtp.com; s=20221208; t=1681915317; x=1684507317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjVkI26ktyzhtjOsKUbgQ/T3RC2e+nJ5jKr99N5QLxk=;
        b=AeZ5wZNOUYoYPs5fgNoP8PdwWIcNz4Z/e3ZezkcapR7aowdJKgC1qzudkN5BlBXNRI
         dvsMRSK+RjjjukorQ5FGHQ/nxHuIWTzMLeDaRyNTze7Mw1cgDimNjpUWTHZxx468qJ8p
         +HlqpUhaLh2QK5ocROi74En0/O2DuxlO3Yv947RUystfy6A9BtHP4gVqBA5KBslBf4D9
         tNJ+ynn2NSpGUIw6agSyBfBTTReLOSo5hQiNAb38dyAp195SYbMc6JP2z/bxEYBOldeH
         5e4kKFeEpXtuT+a+GQGJekQErc0IIouDbFt4BZR8kG7kVpz14DT6cbwv2Q6tcyUac0BL
         aSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915317; x=1684507317;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjVkI26ktyzhtjOsKUbgQ/T3RC2e+nJ5jKr99N5QLxk=;
        b=CQi0PT4FcM4lPvgMb0N1RlwVhiS8smSLMlIjsyTACv9jx1gpTKeb59L1lfhMqEgDKb
         Dr1KkZ5J/zpcVrghP/IMrGtrEhc1a8lHQ4k4DRaUyW9lsO87mpYdwV/Qrvt/2QL8B9kv
         vldCOq/LXCBPQeFZUJ73qpCkm9ONJT84l5vJSTjY/Ogkc71TyNfGRJR1XOacRNEYQ1cb
         4QT/qJ8uJOxHYdV+wOeAjmSMeUOx2Hy33KxaxUo3XSbHtusoXHwqONWy6cw/BOXOnwr+
         WPLoLjnmjJ+1cz8xW1Z7JbLa/Dk8JW1ij0YL/vLlUZ9VDAr1N0mx6z6Xxo9KD0IBwFnQ
         jQbQ==
X-Gm-Message-State: AAQBX9dycn3BqOgb95lZY/fDDiSh+w9+zVRVn1iBH2Krp0MKBSVMkfoL
        Ex9X7ebpTt4XUaw200RsYepw
X-Google-Smtp-Source: AKy350ZcNupwHGBZjEI280w1ioDt5z0GPVDCdkjsvwcMlHTWQs+YYZUMYCf0fMhNz23gUlPPug9FnA==
X-Received: by 2002:a05:600c:29a:b0:3f1:812d:1da3 with SMTP id 26-20020a05600c029a00b003f1812d1da3mr1940451wmk.0.1681915317020;
        Wed, 19 Apr 2023 07:41:57 -0700 (PDT)
Received: from [127.0.1.1] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003f17131952fsm2388519wmi.29.2023.04.19.07.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:41:56 -0700 (PDT)
From:   Arnaud Vrac <avrac@freebox.fr>
Date:   Wed, 19 Apr 2023 16:41:08 +0200
Subject: [PATCH 01/11] drm/msm/dpu: tweak msm8998 hw catalog values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dpu-tweaks-v1-1-d1bac46db075@freebox.fr>
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
In-Reply-To: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnaud Vrac <avrac@freebox.fr>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3140; i=avrac@freebox.fr;
 h=from:subject:message-id; bh=gB8ZsOHFL4x3EB7vXs6RfTwFIPJcSDxcT/siRq2GA3s=;
 b=owEBbQKS/ZANAwAIAXED/9m7NDSrAcsmYgBkP/2VddP7RU1bYLLmSl4kfr77zabyBkRunXdwq
 411aLLBpT6JAjMEAAEIAB0WIQSUwb/ndwkXHdZ/QQZxA//ZuzQ0qwUCZD/9lQAKCRBxA//ZuzQ0
 q7qmD/4xx2UzzY0W4NeutA+GaKEnyyJOCkKSCp5jUU39iHLToHX6skayzh4bj2cOBt7IuQV3IgH
 MIbn9IgrxGTW/GfBVldzbonxWBanXM1IeX4ZTYXFWZJVlXuVkxi898FXJQOzK7+ZXbgx5C4O3tw
 cxayJxCxkYtgW0WR8ytc0+HvkzhoJbC83tnD/xhG0YTx+NwKmD6pNoLt65On7QbT0SnVJGGJ+jb
 5rWpuBHh44X3519ybO4oJ4oq0zuONvtCgwEgCabZe/yXD5/OnOEAdJKiNKDxkLk2cX//5p5n5dr
 +oB9QxeYN4ukP0iXTkZDpdn+oNBeiHsf4m/yh6iyJEl3zKm9XeYPuhWFLlPxqSGbxuuRprX6AHk
 21YtohQZyXdzFTFAgT6xc5t679yIrlVzOZWbrbOdCt2x7xgiokHqPs4gzzdZ81TxYsqI2etM+wk
 2PyJOJ62QDbx6Q97OYaQ2xri0hPbaheYqGIjInLVYIoqwfA5+8sWPTWxBU1xAgxFo/ALvgCizdZ
 o4p18KSQXKSHpzp1MYanVWOTJ7x1DnfY4umwkjgcg7JVrrln1xJUyWgvxq7qcNv2cdeL5C4Ejxx
 YeF1EWh27ZjnL1cUvyH1PLw/Y6ftvbQZCOWFYeMSr028jkehmfYnAFtXyFu5hC3TpqQ6lL/2QQs
 GGqHs4YNJ94GSEw==
X-Developer-Key: i=avrac@freebox.fr; a=openpgp;
 fpr=6225092072BB58E3CEEC091E75392A176D952DB4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match the values found in the downstream msm-4.4 kernel sde driver.

Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h |  8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c          | 15 +++++----------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index 2b3ae84057dfe..b07e8a9941f79 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -134,10 +134,10 @@ static const struct dpu_dspp_cfg msm8998_dspp[] = {
 };
 
 static const struct dpu_intf_cfg msm8998_intf[] = {
-	INTF_BLK("intf_0", INTF_0, 0x6a000, 0x280, INTF_DP, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
-	INTF_BLK("intf_1", INTF_1, 0x6a800, 0x280, INTF_DSI, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
-	INTF_BLK("intf_2", INTF_2, 0x6b000, 0x280, INTF_DSI, 1, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
-	INTF_BLK("intf_3", INTF_3, 0x6b800, 0x280, INTF_HDMI, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
+	INTF_BLK("intf_0", INTF_0, 0x6a000, 0x280, INTF_DP, 0, 21, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
+	INTF_BLK("intf_1", INTF_1, 0x6a800, 0x280, INTF_DSI, 0, 21, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
+	INTF_BLK("intf_2", INTF_2, 0x6b000, 0x280, INTF_DSI, 1, 21, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
+	INTF_BLK("intf_3", INTF_3, 0x6b800, 0x280, INTF_HDMI, 0, 21, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
 };
 
 static const struct dpu_perf_cfg msm8998_perf_data = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 03f162af1a50b..8d5d782a43398 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -587,12 +587,12 @@ static const u32 sdm845_nrt_pri_lvl[] = {3, 3, 3, 3, 3, 3, 3, 3};
 
 static const struct dpu_vbif_dynamic_ot_cfg msm8998_ot_rdwr_cfg[] = {
 	{
-		.pps = 1088 * 1920 * 30,
+		.pps = 1920 * 1080 * 30,
 		.ot_limit = 2,
 	},
 	{
-		.pps = 1088 * 1920 * 60,
-		.ot_limit = 6,
+		.pps = 1920 * 1080 * 60,
+		.ot_limit = 4,
 	},
 	{
 		.pps = 3840 * 2160 * 30,
@@ -705,10 +705,7 @@ static const struct dpu_qos_lut_entry msm8998_qos_linear[] = {
 	{.fl = 10, .lut = 0x1555b},
 	{.fl = 11, .lut = 0x5555b},
 	{.fl = 12, .lut = 0x15555b},
-	{.fl = 13, .lut = 0x55555b},
-	{.fl = 14, .lut = 0},
-	{.fl = 1,  .lut = 0x1b},
-	{.fl = 0,  .lut = 0}
+	{.fl = 0,  .lut = 0x55555b}
 };
 
 static const struct dpu_qos_lut_entry sdm845_qos_linear[] = {
@@ -730,9 +727,7 @@ static const struct dpu_qos_lut_entry msm8998_qos_macrotile[] = {
 	{.fl = 10, .lut = 0x1aaff},
 	{.fl = 11, .lut = 0x5aaff},
 	{.fl = 12, .lut = 0x15aaff},
-	{.fl = 13, .lut = 0x55aaff},
-	{.fl = 1,  .lut = 0x1aaff},
-	{.fl = 0,  .lut = 0},
+	{.fl = 0,  .lut = 0x55aaff},
 };
 
 static const struct dpu_qos_lut_entry sc7180_qos_linear[] = {

-- 
2.40.0

