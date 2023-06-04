Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22307218CC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 19:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjFDRNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFDRNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 13:13:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A5B7
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 10:13:50 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B9356601F25;
        Sun,  4 Jun 2023 18:13:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685898829;
        bh=/UrdOsiu0BTagsy93+I89v+8FHLbrrLTy+GX8Y1i0Lo=;
        h=From:To:Cc:Subject:Date:From;
        b=Ltv//Ic0oU00qRfNZsspBro2ipD2RP+f6VlmjMZa2W7E9KCXFB4XsG2utLCvdNAW1
         2gtEXiopLMLLUJafNnNcQuDScSMDGObzBHWhzSbfk+xBjNwQ+DBjTxDTlK87ty/gjH
         FiePdyVXPWj9T9G4oltu1xaTs/WsORrY9B/bF5Qd3pBIwSawmbG+WIyXMG2OaB/0Cx
         K4YIIuyFzxVjr9JqILx5KPxbZrQfNxxsO6QsTr15ThZGQgZixjDkrt6VTAzi0lBTGk
         gCwvQ47YnOFAxZigT93Lll+f07muzZ18VFxbRjjgTDEdttPTvUtH0RQOIkz6+TwusU
         Dza+MSyieRyGQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [RESEND PATCH] arm64: defconfig: Enable Rockchip OTP memory driver
Date:   Sun,  4 Jun 2023 20:13:45 +0300
Message-Id: <20230604171345.1215276-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip one-time programmable memory driver provides access to
various SoC specific information, e.g. leakage currents of the
CPU/GPU/NPU components found on a RK3588 SoC.

Enable the driver as built-in to allow client device drivers (e.g.
cpufreq) to access the required data for proper settings adjustment.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a3112e2bf5ed..8cd4d06a8e7f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1399,6 +1399,7 @@ CONFIG_NVMEM_MTK_EFUSE=y
 CONFIG_NVMEM_QCOM_QFPROM=y
 CONFIG_NVMEM_RMEM=m
 CONFIG_NVMEM_ROCKCHIP_EFUSE=y
+CONFIG_NVMEM_ROCKCHIP_OTP=y
 CONFIG_NVMEM_SNVS_LPGPR=y
 CONFIG_NVMEM_SPMI_SDAM=m
 CONFIG_NVMEM_SUNXI_SID=y
-- 
2.40.1

