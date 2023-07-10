Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C710474DDB0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGJTBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGJTBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:01:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A971B106
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:01:14 -0700 (PDT)
Received: from localhost (unknown [86.121.239.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B575E66020F5;
        Mon, 10 Jul 2023 20:01:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689015672;
        bh=/UrdOsiu0BTagsy93+I89v+8FHLbrrLTy+GX8Y1i0Lo=;
        h=From:To:Cc:Subject:Date:From;
        b=Eh1alHiAd/5UcEG/AZBaocn4wyZf9MmnhgGCERyNpFbzn72qaA+Iq4VIDGqLvYly8
         NNHzwXfZJBDcrOwmAd3to9hSDW8hIOanaaQwCi6UPo+Vsdkf+bzc5f9R0w5hSDI1bl
         X36bYhLKamsAjgfMdq2olGkB9Cx2qFS0joGm6C5QGS4/dSmAeSlR1UF59tNy8o/gWj
         WgAMF0P++ABiCmFED3avRAx6OOrtNJ9qQU6byllem19tfwm3qTGSTBTSKfd0Gb692r
         z9VPAfMdCjGtPuUl9Rmf7ydmAahTVRYTwcZqA9XIAgNRk9rhsAXKm9O5s1w27kB1Af
         fO2hRcBxDq3Vg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH RESEND] arm64: defconfig: Enable Rockchip OTP memory driver
Date:   Mon, 10 Jul 2023 22:01:07 +0300
Message-ID: <20230710190107.32451-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

