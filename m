Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184A8666E93
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjALJqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbjALJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:45:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C7032EB9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:42:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e3so8267278wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQ/ZvoGlN8LNm1TDQttciwGvM6ENGTWfyYnICnRN+aE=;
        b=PIkKp7SoA5YeoXP97/Dbc5n5QtCbPU6+9yZyvT9VVy54xzAoXZCRRKrkkvvo39z3ll
         AWFz50in4V1b67RMv9omvJt7PVikDlcX8Q/6+hZuW+O+FHA2AyXbLneJFJJJPZQteg1J
         0B6YSKOm4sjN4OncxyHb6QJqxyn++1VyvYaOXjU3uOcVDrXplR4wlIBb6l4sC+XxMSeX
         5caPBajIabI1a2yANsp88lD8fzA8sSPhPhE6xtBk6k3bwtjpLrSq3wmzM1o6cEvkyDKR
         4e0tIu1fk8FxJ+OKvh517HOjTz5yOpuNIUjfkK4egrd6nf6atkop2foD/KJhHHEse+k/
         WipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQ/ZvoGlN8LNm1TDQttciwGvM6ENGTWfyYnICnRN+aE=;
        b=74KfEab0sJab0Nb1ixvc32R++tDf2zuzMi8ZZZP8wl55elEp3zzO2SDDlggNChTsSF
         rAMS6pOIh59rCuwlbXTB0iHAgrwTNO/N1sCSwoyvZRLQzRvJnoq1eCuXjXrZBsiV9xmh
         xq6kjlTrLw6lYpHPfLX4CEqCT1KVjavoHhmcsPoNaaVv66kRJ9uWpAGZSSGlkDGxnp4c
         tC8GeYkRZxxs6ofgIc0PYrCHQzJgIaAtqUKY14BMz/PXmt/eazTtlTmErJ4B8dwwGOwg
         3dKDcRPp30QJfnG1zwlB7ZRSu1acZqyDjrNsrYSgulAr+bygpLYPNlguDW87HjSXezRj
         rTiA==
X-Gm-Message-State: AFqh2kqVf0+ICfLcOXK7agdZ1YFWXnHiJKWsythlR0CHEVN58ef2IIpR
        Mqw8Fvsht8xM/9Xn63HmFAd0ww==
X-Google-Smtp-Source: AMrXdXswXLjkwOb6GruCploTB3L3WhL1c1nDzLXMud52Qm55piyOl75BWeDjHPkMlaojYgsDiIs6eQ==
X-Received: by 2002:a05:6000:78a:b0:26f:6bf:348f with SMTP id bu10-20020a056000078a00b0026f06bf348fmr45918050wrb.6.1673516569058;
        Thu, 12 Jan 2023 01:42:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003d96c811d6dsm28047649wmq.30.2023.01.12.01.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:42:48 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 12 Jan 2023 10:42:45 +0100
Subject: [PATCH v2 1/2] arm64: defconfig: enable SM8550 DISPCC clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-topic-sm8550-upstream-display-defconfig-v2-1-c29b9714c85f@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build the Qualcomm SM8550 Display Clock Controller driver as a module

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 851e8f9be06d..c9011e1438c0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1107,6 +1107,7 @@ CONFIG_SDM_GPUCC_845=y
 CONFIG_SDM_VIDEOCC_845=y
 CONFIG_SDM_DISPCC_845=y
 CONFIG_SM_DISPCC_8250=y
+CONFIG_SM_DISPCC_8550=m
 CONFIG_SM_GCC_6115=y
 CONFIG_SM_GCC_8350=y
 CONFIG_SM_GCC_8450=y

-- 
2.34.1
