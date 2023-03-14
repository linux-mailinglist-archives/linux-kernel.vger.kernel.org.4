Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8B46B9916
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCNP27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjCNP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:28:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165773B222
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id i20so16399622lja.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678807723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RO255zxGak2RBrs2vsC3RJabBdwukiR9Uly/c7vQ0CM=;
        b=XMdGMEyjB8dFRiheqepFSBLS1yBnSgwVDtYG0k25vKhV2B+dlbK+4rqhOZR/f5eQUf
         spakIlGLGNtFd5/rU+56vYuo0KrIzAVAuZfTqyDlOOsZ94AlFUIgu98hLV8FaJ3dE4Zk
         9yqi8FZwAgT80An6knPij1UpD7EYrELJs1ohiVkGfnSHcjC/XD+fqxOtqlcRm9nA5K04
         wNeALyWefwCNWEWqAQrUBfJVbC4jXMB3cfLAAKdrnJ2L9mKHd1rclALn8mQ/wlEvKdRm
         EM/HM7vX91H/yLn2pdaaUSOBQMAou+HKElwt5VEFWDomjsDkdpj47nS849HBUCJSnmnU
         95Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO255zxGak2RBrs2vsC3RJabBdwukiR9Uly/c7vQ0CM=;
        b=4VIeSbJEZEW5WCNUfk12gNZNZiMuz7/fs966EzszWrinofT9iYcS4lgROWLv9QCcoX
         k3pfK9VoG0LNVcqMZSxeoAmnAkOWVuanZqr1suYX2cRwHsxUKi9KFlB8E8ILaWdX3R9y
         MohA6/PyTQdqGyJ5bsOuK+PdEamn0fBSvtagWKsRSrpIo972Jg6ajWj/nXrYUM3pr9yW
         ngNgC/guT0l0u8iTIoOe9IRSDo7+4/AhjapTMkSSPP62JOEoBMdQWh+V6L2m4BUtCUMP
         D4snWCdPuCtEgfAI8aIyHe26iu8+rJDFQOSJ8xCCf3dhG7Z9G6xOw4y50OUdKQsPoAsR
         BzPA==
X-Gm-Message-State: AO0yUKWmiqwqnTfjYIXcUDqM4jYwx1aiCP2qffTDmDVa7GnqOEzmJ7sX
        AbKCaF/5DSbdGBvrvM1AMXm+sQ==
X-Google-Smtp-Source: AK7set8z7+8/svx5o/nFtcPzqW1CxxLQ3CLdXsRgxJg10+9EiutFeGRPRVlrw3NXYINxFmwBl3CyYw==
X-Received: by 2002:a2e:9946:0:b0:295:a8cc:f15a with SMTP id r6-20020a2e9946000000b00295a8ccf15amr10470723ljj.29.1678807723306;
        Tue, 14 Mar 2023 08:28:43 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id 27-20020a2e165b000000b002986a977bf2sm491529ljw.90.2023.03.14.08.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:28:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 16:28:34 +0100
Subject: [PATCH v4 03/14] drm/msm/a6xx: Remove static keyword from sptprac
 en/disable functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v4-3-e987eb79d03f@linaro.org>
References: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678807716; l=1711;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7a+b5UGAg3EywTm3Uz73qntLItaZJqfx37WBN0HlPAs=;
 b=nGHMAsiP7jw60z7u0RxD1MZvX6xpxMT/U4RR1/OORWCr6Gmp5pj7vlJSu7Jgx9C5U0bGHsMdGnx7
 8M/TtP8aCXwuBmw8476mylKRj9+t1k+V1KQ2ahR0JZW3s8YcaOQu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two will be reused by at least A619_holi in the non-gmu
paths. Turn them non-static them to make it possible.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 4 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 7f5bc73b2040..229a54ec82b4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -354,7 +354,7 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
 }
 
 /* Enable CPU control of SPTP power power collapse */
-static int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
+int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
 {
 	int ret;
 	u32 val;
@@ -376,7 +376,7 @@ static int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
 }
 
 /* Disable CPU control of SPTP power power collapse */
-static void a6xx_sptprac_disable(struct a6xx_gmu *gmu)
+void a6xx_sptprac_disable(struct a6xx_gmu *gmu)
 {
 	u32 val;
 	int ret;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index e034935b3986..ec28abdd327b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -186,5 +186,7 @@ int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int index);
 
 bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu);
 bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
+void a6xx_sptprac_disable(struct a6xx_gmu *gmu);
+int a6xx_sptprac_enable(struct a6xx_gmu *gmu);
 
 #endif

-- 
2.39.2

