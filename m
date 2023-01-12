Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497F5666E94
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjALJqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbjALJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:45:15 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AA53DBD9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:42:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so11309526wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKI1e/olZBE0WNap4KRNex2ej5kGh0U21AghWA1HZZY=;
        b=mhI4jZF2UWjIt5yn0A46WNh3DSj7ZLdq1/IQEf+JYT6eDplIwKZgWI5uwkJG87y4J0
         vfIAu4WMX7HCYcvuGNjYWE6d3tfDUtT3MILGfpx2K5jFfLmSZugT6Ruu20QlDMnMWste
         FVuUU13M6t24rxMkszhFtY7lwZoFZF1ANvD3c5c+dZeQNSZcvGHl18oIx4R0cJvFYa+j
         TFOKtJtH8hhiA07zERYZXteQByvutOE/Gpv77PTyRCI17UKiBrItEMnb+//02sIjWB75
         lNRLml8tVdC7aLGJxjCF+aZz2FaBUUPdBW8rlcc85jWT7fHT+YmFO4+NKXxCEkgTJfhE
         ykIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKI1e/olZBE0WNap4KRNex2ej5kGh0U21AghWA1HZZY=;
        b=tyojIbhYQ5Z8xtFrMAj3uLY4NdnMxaKEF1P+2twZ64MmCcQMrGPAXEwEJO7qbT2Hlr
         5dW2bex+l+AbltV3OscfuQIGbwhrX66jCu6KGCRZG8Pb1EnZ/2Od85pouXRhz3Qif6ee
         dUmDZMYvyXqszPVDASepqyUa/yW1Ojwzv+5h14op3GRsRjz9PgIg+qCmOhBMujyskTUy
         TbKz41zKZaeOlmlunFLnf5Xnd9J3sHlOJJJw66ldyYUW8VwKyjtRT/Ha+If4hkenDcAE
         53mh1GnnaZ4ZKvWh2W3O2Q+9PK6/4ubnZ2TvCoz21cY/rkQUdtptiNl2Q5ITxvDMOT4M
         X1sw==
X-Gm-Message-State: AFqh2kptp0WvQZ7UWjK8LPn+7hbQonYhyjxPfLkKaH0YjKMx5bxSmucb
        7vv2il3Jje67LwHHHlusyQDTfg==
X-Google-Smtp-Source: AMrXdXvTSEtuIufSTAXNipVi8Ox6she5RGRw851IDFVjB/ccbB+Imd6hG4OKVbX2sQZldpGwb9HcXA==
X-Received: by 2002:a05:600c:4f02:b0:3d9:f217:6f6b with SMTP id l2-20020a05600c4f0200b003d9f2176f6bmr10421251wmq.33.1673516569772;
        Thu, 12 Jan 2023 01:42:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003d96c811d6dsm28047649wmq.30.2023.01.12.01.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:42:49 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 12 Jan 2023 10:42:46 +0100
Subject: [PATCH v2 2/2] arm64: defconfig: enable Visionox VTDR6130 DSI Panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-topic-sm8550-upstream-display-defconfig-v2-2-c29b9714c85f@linaro.org>
References: =?utf-8?q?=3C20230110-topic-sm8550-upstream-display-defconfig-v2?=
 =?utf-8?q?-0-c29b9714c85f=40linaro=2Eorg=3E?=
In-Reply-To: =?utf-8?q?=3C20230110-topic-sm8550-upstream-display-defconfig-v?=
 =?utf-8?q?2-0-c29b9714c85f=40linaro=2Eorg=3E?=
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build the Visionox VTDR6130 DSI Panel driver as module

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9011e1438c0..7bbf628ab80c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -765,6 +765,7 @@ CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
+CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_LONTIUM_LT9611UXC=m

-- 
2.34.1
