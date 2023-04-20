Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0026E8756
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjDTBPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjDTBPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:15:07 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731804ECD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:14:59 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z38so966033ljq.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681953298; x=1684545298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YAPLxEQHRkQtBPUWYsNYhJFpEVLFDywj/VUg1ddWyo=;
        b=UQsX0S6zrCg0bjka1ONQctLRZ4D8xxZav7b5lB137sSxCBmvsLC4347g0VTNeAipY/
         kt3eYv3W3ziLtPXUgQCnRnIYnZvHGDzoPdJzeGNdqSocgE0SPNuR2YnCirCRO0gobidl
         HI62bd07kuLAb5BUNnz/4IZ1gVB1z2fmlCBmUsxmbQpRbNs1qcb1v2VeJdctfXpT1NMB
         I2lKbiFQmL1QC7/KxFq793KaUCnD7W70aGySPxDMBFEMMjN3wbJGar/GWOjfqwpZ5+N2
         N/AGHt2R1c5iWXNoSBySJmDklbpAXCbuojeaiacaDWkDOnZn4GLXG2YuxYOpfBHVFJ4J
         E7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681953298; x=1684545298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YAPLxEQHRkQtBPUWYsNYhJFpEVLFDywj/VUg1ddWyo=;
        b=AGi5F4YTNqzKAsjgmRaXg2IXnJOM9vBNYYJV6+CA0enkDMwJGR2S2e8IBavlokd4rR
         FxoKtJHjX7CCjKflQy71VvYIIm+Iv3hm8MMkhHH0zpIskWH65RpHQDzsXoZQ/WwxUFSr
         wKQjKmOvxeJm7dlzDgmxbtwYKXixMoczbT3OuTwjiTHKQ2fdydkExMsoA1CPofXLvgl3
         SV7lSPbEd9gZiYrea+9ZS7zgssNDkRK8HSjyXmWpW9QzvJv8OIudoNNDHrGPAzIF1OsG
         kfx8OgyFYjrHx2WSgk2g9h8ZYnGQqwL6sCOJqaNCWIXjfJmOzSKkpfqMMufr1AfEO2vQ
         EfJQ==
X-Gm-Message-State: AAQBX9dyQsikqfcDWdJbcxvv53jR5z5sPSaoP1ndx6VHL0JSaZuOw3P/
        bNQ85PTWoCdAYw9eBVZmSaQImw==
X-Google-Smtp-Source: AKy350Y/tkNGSH9BHgOL6svxTMyN0azMc9APjE8LKh0JBxi5ocA3CHn/stNeNLStSUyux7sGsC0ljA==
X-Received: by 2002:a2e:9595:0:b0:2a9:b6fe:18c2 with SMTP id w21-20020a2e9595000000b002a9b6fe18c2mr1168848ljh.29.1681953297695;
        Wed, 19 Apr 2023 18:14:57 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id k25-20020a2e2419000000b002a8dce82cf6sm28853ljk.32.2023.04.19.18.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 18:14:57 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 20 Apr 2023 03:14:54 +0200
Subject: [PATCH 1/2] drm/msm/dpu1: Rename sm8150_dspp_blk to
 sdm845_dspp_blk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230420-topic-dpu_gc-v1-1-d9d1a5e40917@linaro.org>
References: <20230420-topic-dpu_gc-v1-0-d9d1a5e40917@linaro.org>
In-Reply-To: <20230420-topic-dpu_gc-v1-0-d9d1a5e40917@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681953295; l=8333;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Hv4Y+/OyENonA4D9WD0Atvk2X0RWlZqmSfSPeIcfQbA=;
 b=T14hv8IeHuKO46xglmGsqcs8p+2X5l5YCGnQE8/gsMEYDBDiRoCgy+ALP29JpTGlB/9vGa2HQeoF
 3jaHxr3hDzJPUU2EPJNZ6FnzxLHsa2/GxxPZKjqsqtBqVHhF2czU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 was the first SoC to include both PCC v4 and GC v1.8.
We don't currently support any other blocks but the common config
for these two can be reused for a large amount of SoCs.

Rename it to indicate the origin of that combo.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h   | 8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h   | 8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h   | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h  | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h   | 8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h   | 8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h   | 8 ++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c           | 2 +-
 9 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
index 282d410269ff..c555d43ef0e0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
@@ -118,13 +118,13 @@ static const struct dpu_lm_cfg sm8150_lm[] = {
 
 static const struct dpu_dspp_cfg sm8150_dspp[] = {
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_1", DSPP_1, 0x56000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_2", DSPP_2, 0x58000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_3", DSPP_3, 0x5a000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 };
 
 static const struct dpu_pingpong_cfg sm8150_pp[] = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
index 2c40229ea515..c8a174352ede 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
@@ -119,13 +119,13 @@ static const struct dpu_lm_cfg sm8250_lm[] = {
 
 static const struct dpu_dspp_cfg sm8250_dspp[] = {
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_1", DSPP_1, 0x56000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_2", DSPP_2, 0x58000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_3", DSPP_3, 0x5a000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 };
 
 static const struct dpu_pingpong_cfg sm8250_pp[] = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
index 6f04d8f85c92..00f82b2c18ff 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
@@ -56,7 +56,7 @@ static const struct dpu_lm_cfg sm6115_lm[] = {
 
 static const struct dpu_dspp_cfg sm6115_dspp[] = {
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 };
 
 static const struct dpu_pingpong_cfg sm6115_pp[] = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
index 303492d62a5c..5f103140abc7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
@@ -53,7 +53,7 @@ static const struct dpu_lm_cfg qcm2290_lm[] = {
 
 static const struct dpu_dspp_cfg qcm2290_dspp[] = {
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 };
 
 static const struct dpu_pingpong_cfg qcm2290_pp[] = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
index ca107ca8de46..257e898fea18 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
@@ -117,13 +117,13 @@ static const struct dpu_lm_cfg sm8350_lm[] = {
 
 static const struct dpu_dspp_cfg sm8350_dspp[] = {
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_1", DSPP_1, 0x56000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_2", DSPP_2, 0x58000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_3", DSPP_3, 0x5a000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 };
 
 static const struct dpu_pingpong_cfg sm8350_pp[] = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
index 9aab110b8c44..e4d4e47418fe 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
@@ -111,13 +111,13 @@ static const struct dpu_lm_cfg sc8280xp_lm[] = {
 
 static const struct dpu_dspp_cfg sc8280xp_dspp[] = {
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_1", DSPP_1, 0x56000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_2", DSPP_2, 0x58000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_3", DSPP_3, 0x5a000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 };
 
 static const struct dpu_pingpong_cfg sc8280xp_pp[] = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
index 02a259b6b426..88ad81e03622 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
@@ -118,13 +118,13 @@ static const struct dpu_lm_cfg sm8450_lm[] = {
 
 static const struct dpu_dspp_cfg sm8450_dspp[] = {
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_1", DSPP_1, 0x56000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_2", DSPP_2, 0x58000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_3", DSPP_3, 0x5a000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 };
 /* FIXME: interrupts */
 static const struct dpu_pingpong_cfg sm8450_pp[] = {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
index 9e403034093f..ecc034f76441 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
@@ -123,13 +123,13 @@ static const struct dpu_lm_cfg sm8550_lm[] = {
 
 static const struct dpu_dspp_cfg sm8550_dspp[] = {
 	DSPP_BLK("dspp_0", DSPP_0, 0x54000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_1", DSPP_1, 0x56000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_2", DSPP_2, 0x58000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 	DSPP_BLK("dspp_3", DSPP_3, 0x5a000, DSPP_SC7180_MASK,
-		 &sm8150_dspp_sblk),
+		 &sdm845_dspp_sblk),
 };
 static const struct dpu_pingpong_cfg sm8550_pp[] = {
 	PP_BLK_DIPHER("pingpong_0", PINGPONG_0, 0x69000, MERGE_3D_0, sc7280_pp_sblk,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 03f162af1a50..69af786b66a0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -458,7 +458,7 @@ static const struct dpu_dspp_sub_blks sc7180_dspp_sblk = {
 		.len = 0x90, .version = 0x10000},
 };
 
-static const struct dpu_dspp_sub_blks sm8150_dspp_sblk = {
+static const struct dpu_dspp_sub_blks sdm845_dspp_sblk = {
 	.pcc = {.id = DPU_DSPP_PCC, .base = 0x1700,
 		.len = 0x90, .version = 0x40000},
 };

-- 
2.40.0

