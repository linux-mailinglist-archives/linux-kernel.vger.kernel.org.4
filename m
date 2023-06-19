Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418FA735C55
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjFSQo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjFSQo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:44:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232E0E6F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:44:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f63ab1ac4aso4681608e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687193064; x=1689785064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pcV9E1iN83IBiQg5BKxpEX8oFts9Rn27YMXaYwhFEM=;
        b=n1CSS1+06UxW1/uOewIxrTneP1/A109VpVq+Vm1KN4fyQZElho6dv2s2D1hNhZ1SBO
         KfzIDwC/tSKdJVD11RnQguHsAw4ZOKKlYQB2rZr4IMA0xHSvomcutOElBqr/SpvPwiYu
         lFAwUTPZulqWoZ5cq/NiO24hGiwe0FRXUnaAg03Jb6ckJm7UBrO/2JKVAbBwExZfTWVG
         Ipnx2LiDpXA8ejCf1f/Yfqu9zYWwqB7hd8lPn8q8Ldcs6wcnJi6AnOi1xuY53pZZ0w60
         i0MGb8V7gvuGDcAMKT9As5npYmJJ6LoJLZ9M83PIe98f2baVD2lxZhZJDtYZuDwbKXWq
         zIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193064; x=1689785064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pcV9E1iN83IBiQg5BKxpEX8oFts9Rn27YMXaYwhFEM=;
        b=f/uiKVsYHXU8vhvsh5Pj/SB296O+rozHz/8l53ozbKyXByJ68UqtVgvejieQtVQvZf
         YhNojfherPekZfexuhCHpIccau6mzAm+XTl2SnNbsoxTSZoeWXKM77g+Qw3y2cgJm0WZ
         dB1M5ynlV9gGLA1xyqXuA6ijlqYMePfEsVEtwVOftQe3AOcy1eLkf+vb90BmgWly84Ec
         X5jqZhOvUr1qSNj9kTe+Lfd1bSW4USUM+nZsA/MpLfFGT6dcr0HwwpjNpiY78TfAy5fB
         jTVLomlVI8ub4OGnIGq3Aq7hkcevbFNgsWvDAnfMcu1bWqpremNCIYNtl1Jy74p+Wy1F
         ejwg==
X-Gm-Message-State: AC+VfDzSFnSm7/bd3MqdwhzsSzgZTJa0uOXbSpciVMiI4ZhAC0P698Ad
        lpMcvRiQzByZGiD2OGdOact5bQ==
X-Google-Smtp-Source: ACHHUZ72WspRm12rkQzBAeerpWr89BdZJweMRQovX1XISr6hSnEyuLua8B5dnDUMZIQJ4P6M/KX4ng==
X-Received: by 2002:a19:790e:0:b0:4f8:6e16:fca3 with SMTP id u14-20020a19790e000000b004f86e16fca3mr2241138lfc.28.1687193064311;
        Mon, 19 Jun 2023 09:44:24 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id d9-20020ac24c89000000b004f849605be7sm1774293lfl.292.2023.06.19.09.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:44:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 18:44:21 +0200
Subject: [PATCH v3 1/6] drm/msm/a6xx: Add some missing header definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-a7xx_prep-v3-1-a3ce3725385b@linaro.org>
References: <20230517-topic-a7xx_prep-v3-0-a3ce3725385b@linaro.org>
In-Reply-To: <20230517-topic-a7xx_prep-v3-0-a3ce3725385b@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687193061; l=862;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Kx6hGtFYbXC4+ZQmgSeqx9B48/cy4Oq5xhedcSdiIJ8=;
 b=OnXw3WN+NCUhzBUBk3dafn715zvedUkrCV0q0HBvZG8z537Nbfe7aX+wb40HJYP1gmD3mYT2h
 74m/RiNDbQrCxoj1bxzaAKptoNt9xBoRY99JxQq6laKep3DHmP1LQPv
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

Add a definition of the GMU_AHB_FENCE_STATUS_CLR reg and CP_PROTECT_CNTL
bitfields.

This may be substituted with a mesa header sync.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
index 9ab15d91aced..fcd9eb53baf8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h
@@ -425,6 +425,8 @@ static inline uint32_t A6XX_GMU_GPU_NAP_CTRL_SID(uint32_t val)
 
 #define REG_A6XX_GMU_AHB_FENCE_STATUS				0x00009313
 
+#define REG_A6XX_GMU_AHB_FENCE_STATUS_CLR			0x00009314
+
 #define REG_A6XX_GMU_RBBM_INT_UNMASKED_STATUS			0x00009315
 
 #define REG_A6XX_GMU_AO_SPARE_CNTL				0x00009316

-- 
2.41.0

