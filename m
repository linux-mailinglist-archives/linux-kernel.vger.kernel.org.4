Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C9658BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiL2KYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiL2KX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:23:28 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F8614012
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:18:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j17so17426539lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucgqquCovQOcSuajKJPtQVfMmU0XBO42PG2kCTctk5M=;
        b=TbZugUpEkLxAfOyP5+EeaNu0hxlMrj25oKmLbJ8aucvMgIrR4dj5LnZivExVcEeuOy
         fby8y3gGuhWyWH1GxaoLiY8DTC3QNTISKwiQz86VKG92WBNk6vcOGAjGy9xW3CbpkIyI
         6e91hXgdqLRQifyK2O7Ut1IlRGPm0HFnpJL7QCrBM3kOXFTHJEPZIoEZYS8zraePEMuN
         3G/H3JkHmBXlA1uqqzycNTCRyUmTZsCFIiaJbTuO9vAJAQwRqlmWrScx0mXYSSaT+nff
         UaJ8ge6FtF59eROruuVDvugw0py6+PTnUBUGv0P+yv5wzWc2gFGdwuaztFgR0RqaM4vB
         h2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucgqquCovQOcSuajKJPtQVfMmU0XBO42PG2kCTctk5M=;
        b=soCDPSIzogokf+MWU4xHvDW4vJAgLL96Gc7rBI5fDi/uwGOQXRQmVoWIIyv/9Vi5B7
         dsmbwtpfAhtPJgEB56CFwL3R7GZP32J2ZsQAZa3BiLPLjgLcqFw+qdA6Yar3SrNBwrqZ
         cgnGd8UNW8DEmlp0Psrr1GTbEQrUD1+jmod9YbMaTWUltzF9HuOXYCyFeGwj5ahvyOy0
         I8Luxlw3cHP7QZMVrnEA/Uy+7NLR7BQoCgXS2DbtMbLJmOaKLP9pz7BX6gFWvFZ+ai3q
         6DcAfbX3N1eGZ/Atio1TdfUQ0hEW1m2PfLH4hkdw4Q6t6ETG2F9qeGT70YoVZTUq9+uj
         vtJg==
X-Gm-Message-State: AFqh2kqBQa2BRroINeaihx3udxcUwxAvOXZqrlF0SAfjuXn9ro1B1bh0
        sxkN8OXIdLhq/aeCgxInOnWJzw==
X-Google-Smtp-Source: AMrXdXsLyx6ZbcjsygWtSNi8M6/Y+8+EahJS3C0JFdhbUJ0XUuGJE7bRXOQagTHU/MybUoJNsQ9ppw==
X-Received: by 2002:ac2:43cf:0:b0:4b5:8298:5867 with SMTP id u15-20020ac243cf000000b004b582985867mr9082838lfl.66.1672309129698;
        Thu, 29 Dec 2022 02:18:49 -0800 (PST)
Received: from localhost.localdomain (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id j18-20020a056512109200b00498f67cbfa9sm3028632lfg.22.2022.12.29.02.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 02:18:49 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Emma Anholt <emma@anholt.net>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/adreno: Make adreno quirks not overwrite each other
Date:   Thu, 29 Dec 2022 11:18:45 +0100
Message-Id: <20221229101846.981223-1-konrad.dybcio@linaro.org>
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

Fixes: b5f103ab98c7 ("drm/msm: gpu: Add A5XX target support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
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

