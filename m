Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68A16655B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjAKIEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjAKID1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:03:27 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F6E87
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:03:04 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vm8so34804142ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKlqJr8rxgngLJH6pqdTtSMxFqepSX+OLChFw1pfl0U=;
        b=blHHl0EYlvw4R9xi6a9b4tjVJ9lf81N3J1kYhMT9oBSK0Xk//e/pyIvK3VQbsnLag9
         tY0aktQb0V42doBIH8mHFK18/oW+HbQ+uvZgOqV9yIbLLiwbHDYSGKeyym2P5pH2IE+b
         Q6IGT6YUO1d3EpQLWOK2LcJUWijPt/CSGfgiKEOxjvpKY9lFBzp++YBRVJifiKWaP8d0
         F0m+J8D/HI1J+LrJnsKsY6jec/FpbSVUvy9g6JqhunljFzAvIr0Ca490Knsq155WRhhe
         7WR2/A1iHTmdLffzTmG/mq9HLKY87RUboLj4F+Qjr5CA7hzBAa87nO76rbA3hWMTCXKG
         kQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKlqJr8rxgngLJH6pqdTtSMxFqepSX+OLChFw1pfl0U=;
        b=pCsK5emUoxATMlqlv+wDsWDr4UL5ynjNJbmURp7a4Mg3RggOSmY0H8oKpVugKpzAIv
         E1NTI2SXHsG0o09pvkZg815GOWeRDYflCpuZAU0xiIqJPZEzeTF5nt981mBKF0ngCvXv
         rRaRR3Hyrn9RFpLB+ugG5WHM99p+0uhofrzrOKXAV3wqBgz7sWgjzcDKxqnN/Ltp0nG9
         Soe4H+FLIMMhCX0U6SuyzC8IF7xA3seyu1H9N+oIargZSrYJf8inZ2/C3+SRT5bKblwf
         RQEY1eUK0WUP0SP6R/aLPYNGoGQF++g1LorSPROcRFxn7QV0GZ6ePjN4ZBohWkH6NLS7
         u+eQ==
X-Gm-Message-State: AFqh2ko9I3Ktdm2npVq7kQRADWKG4gJ8X5L4YVHm83gziobIwOHHyX9U
        C+61CgIyb20cF6NBodybJ3Hx4A==
X-Google-Smtp-Source: AMrXdXt+2nJWMOvqwxVyelsYWGLeubGj6/701M/dwq7OgNEENmB3vGAspsD5YiGlJ9GyVdc1kd7CBg==
X-Received: by 2002:a17:907:a481:b0:7c0:c1cc:c68 with SMTP id vp1-20020a170907a48100b007c0c1cc0c68mr60357776ejc.6.1673424182728;
        Wed, 11 Jan 2023 00:03:02 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k23-20020a17090632d700b00837ac146a53sm5876522ejk.23.2023.01.11.00.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 00:03:02 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: defconfig: Enable GCC, TCSRCC, pinctrl and interconnect for SM8550
Date:   Wed, 11 Jan 2023 10:02:54 +0200
Message-Id: <20230111080254.1181325-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add the SM8550 GCC, TCSRCC, interconnect and pinctrl drivers as built-in.
All of these are necessary for the Qualcomm SM8550 platform to boot
to shell.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4aeba64e9034..2793b5420a14 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -565,6 +565,7 @@ CONFIG_PINCTRL_SM8150=y
 CONFIG_PINCTRL_SM8250=y
 CONFIG_PINCTRL_SM8350=y
 CONFIG_PINCTRL_SM8450=y
+CONFIG_PINCTRL_SM8550=y
 CONFIG_PINCTRL_LPASS_LPI=m
 CONFIG_GPIO_ALTERA=m
 CONFIG_GPIO_DAVINCI=y
@@ -1114,6 +1115,8 @@ CONFIG_SM_DISPCC_8250=y
 CONFIG_SM_GCC_6115=y
 CONFIG_SM_GCC_8350=y
 CONFIG_SM_GCC_8450=y
+CONFIG_SM_GCC_8550=y
+CONFIG_SM_TCSRCC_8550=y
 CONFIG_SM_GPUCC_8150=y
 CONFIG_SM_GPUCC_8250=y
 CONFIG_SM_VIDEOCC_8250=y
@@ -1344,6 +1347,7 @@ CONFIG_INTERCONNECT_QCOM_SM8150=m
 CONFIG_INTERCONNECT_QCOM_SM8250=m
 CONFIG_INTERCONNECT_QCOM_SM8350=m
 CONFIG_INTERCONNECT_QCOM_SM8450=y
+CONFIG_INTERCONNECT_QCOM_SM8550=y
 CONFIG_HTE=y
 CONFIG_HTE_TEGRA194=y
 CONFIG_HTE_TEGRA194_TEST=m
-- 
2.34.1

