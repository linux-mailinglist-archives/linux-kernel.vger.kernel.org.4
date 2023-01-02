Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C965AF37
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjABKC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjABKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:02:07 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8088F16
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:02:05 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id f20so28648860lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUvNSUQPHRgkJykKaq60wHpn/k1eJNyp+U1eUmaZ3RQ=;
        b=iCYYVJ9YOn2urXXQ5oAg/nIvLhmW16eVFVswPtvi7YU1Ol8ahihnipPCpixMxuwB5k
         Dib96+ylAQwD5TvlJjvjfGBrCvwuoG/tH7K7xfLL226pY21IRFTjZYkeP0qhm/idmdz0
         +rAuYkYaIFdtYC2JFVRITVbmbsRbmWbbUlKqzZMqmY27YRwKjRIqGIeQX7IwnX7FG+Gk
         UMfVAzA9ju+x1Ow+GuL/CGvt7dEIGsPXQzuEzrMktBdJ/xgFBfMhFfKuB/wGz/NqB7zH
         fWRRpJc0W8j3jVUa8kC0BUJg1kpQ3QR/KgAh9QfmAELdtaOkRNQJlO3/zRAoLFTedp72
         jq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUvNSUQPHRgkJykKaq60wHpn/k1eJNyp+U1eUmaZ3RQ=;
        b=io93Ec8tx39jfKkwrhYB5aHrCcbwdfyo12zC0HErb9ku+MBANkk3y/6o35lJ6anE7L
         WCFFbVh4uzmkpf1PTL9Gh3TI2mDGnFMla9jvxJS91fqXhohXF+c3XChItpJOmckJj4fc
         3QMJ2mFr31V1dxnE1cuGk+4spXp3VflmHUlbSza3rr/Emh5YmdrPufVS7rCtHzORYzzR
         9jFX+QWHpRrmJBu2bT75tekhDY1g3viNOH2DZVjYyQUJiX/eLTD43mQca91eFEqAKlGy
         mu/iOuo/xkmlbjO1B9gUgfG4xXOVg4EywCEH5AyybwIWYMZhIJ/c24NI9dM3abUJ8VyT
         0u2g==
X-Gm-Message-State: AFqh2kqlwXqP5FCDi+o5m2SPMqQoYU+8U7csBpSOzNZkbIQOxtN+JKuZ
        jhBAkAqMdawmaYoLNsSo3bu3DA==
X-Google-Smtp-Source: AMrXdXvfLsZkvxPPh8PFHQUMvkJ0H+nafczyfPXnm02C8MEAtMKQUqjKxuCdl2/VXh4468x7Y+mGOQ==
X-Received: by 2002:a2e:b011:0:b0:27f:e512:f2ef with SMTP id y17-20020a2eb011000000b0027fe512f2efmr2463676ljk.44.1672653724222;
        Mon, 02 Jan 2023 02:02:04 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id p21-20020a2e9a95000000b0027fc14cdfa5sm2132001lji.42.2023.01.02.02.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 02:02:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/msm/adreno: Make adreno quirks not overwrite each other
Date:   Mon,  2 Jan 2023 11:02:00 +0100
Message-Id: <20230102100201.77286-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
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

So far the adreno quirks have all been assigned with an OR operator,
which is problematic, because they were assigned consecutive integer
values, which makes checking them with an AND operator kind of no bueno..

Switch to using BIT(n) so that only the quirks that the programmer chose
are taken into account when evaluating info->quirks & ADRENO_QUIRK_...

Fixes: 370063ee427a ("drm/msm/adreno: Add A540 support")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
- pick up tags
- correct the Fixes: tag

 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index c85857c0a228..5eb254c9832a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -29,11 +29,9 @@ enum {
 	ADRENO_FW_MAX,
 };
 
-enum adreno_quirks {
-	ADRENO_QUIRK_TWO_PASS_USE_WFI = 1,
-	ADRENO_QUIRK_FAULT_DETECT_MASK = 2,
-	ADRENO_QUIRK_LMLOADKILL_DISABLE = 3,
-};
+#define ADRENO_QUIRK_TWO_PASS_USE_WFI		BIT(0)
+#define ADRENO_QUIRK_FAULT_DETECT_MASK		BIT(1)
+#define ADRENO_QUIRK_LMLOADKILL_DISABLE		BIT(2)
 
 struct adreno_rev {
 	uint8_t  core;
@@ -65,7 +63,7 @@ struct adreno_info {
 	const char *name;
 	const char *fw[ADRENO_FW_MAX];
 	uint32_t gmem;
-	enum adreno_quirks quirks;
+	u64 quirks;
 	struct msm_gpu *(*init)(struct drm_device *dev);
 	const char *zapfw;
 	u32 inactive_period;
-- 
2.39.0

