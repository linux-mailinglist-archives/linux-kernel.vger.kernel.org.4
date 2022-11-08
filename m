Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9462203F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKHXWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKHXWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:22:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F14727FC4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:22:46 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF66966029AD;
        Tue,  8 Nov 2022 23:22:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667949765;
        bh=7cV2+MmqB1k7KTMWZf+b4wmOk7VBSQnRJP1YgnfehOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POUIyfpPiu0qjFU85Xfd0Yczt5PcJccPOWn8v10HmxdrW9N3+ZoA3GsQLZMbyc0LX
         k/QB+i8hKuWAERAi0it92CjNvqHIl235o54ZLKNuA6+JmWF+6GKUjl1O0Gh1FbddUx
         Io/M+fsn88SCXZyPMxOLolpMkfPFsHSWMYS4nUzbvwe1nseVrlbDYbEvg3jumV1oZy
         PTog6gclHELhl5FNavvVGQEQVkC+9x+1YaBN6AN66K5wjLfOcWNgKQDY48rv4aOFjA
         CXYRmnP0wMI989JewjJWtNsq4y1QgTHuGJj9onNVtq8CExKSXhu8wTKGlh5bkTsc8q
         jVv4PPSRM+hfg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] arm64: defconfig: Enable sound support for MT8183 based machines
Date:   Tue,  8 Nov 2022 18:22:19 -0500
Message-Id: <20221108232228.1177199-5-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108232228.1177199-1-nfraprado@collabora.com>
References: <20221108232228.1177199-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sound support for the MT8183 platform and for its two sound card
variants.

By enabling this on the defconfig we make it effortless to test the
relevant hardware on CI systems like KernelCI.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c6bd2f7cd1b8..3c1351609134 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -808,6 +808,9 @@ CONFIG_SND_SOC_IMX_SGTL5000=m
 CONFIG_SND_SOC_IMX_SPDIF=m
 CONFIG_SND_SOC_FSL_ASOC_CARD=m
 CONFIG_SND_SOC_IMX_AUDMIX=m
+CONFIG_SND_SOC_MT8183=m
+CONFIG_SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=m
+CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m
-- 
2.38.1

