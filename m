Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0BA622047
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiKHXXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiKHXXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:23:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62193657C9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:23:05 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EADED66029AD;
        Tue,  8 Nov 2022 23:23:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667949784;
        bh=1n3gwJfbpljVTlnML0SsXXRgj+OF/6Kj8llwUXo7RRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEf571FrajLNvmO2iaZgrsYDrLPyJUwtPiDf1O+6aDrIKuycuOzaRCRx/ydn+dMk4
         wYxrzfk7yZT469AIEZuGfOIch3n37D2bryyEdOVce9HbyARgM9iT0svCkq5+6Wf+hW
         NvOxe9slc8xOBzyi6jJ5SOgpdnw1CngWevylMngTsjuHwp5sgjRnHAHPBKPbAeO+lY
         esZQl3j8+T94pMwoV4lQa8tw5LRXdg3EzZrSsesI4jcPvEVJa0vYtIP2XtcaCaBGyv
         uAoGeG7sy1F8U/CBMCsxQvzS0CgFMAd/HQOkbtMxIy+6oJxjWuilvJxkdClLOA5idT
         7+WpUJ+NVtN1w==
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
Subject: [PATCH 11/13] arm64: defconfig: Enable ARM_MEDIATEK_CCI_DEVFREQ
Date:   Tue,  8 Nov 2022 18:22:26 -0500
Message-Id: <20221108232228.1177199-12-nfraprado@collabora.com>
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

Enable support for frequency and voltage scaling of the MediaTek Cache
Coherent Interconnect (CCI), which is present on some MediaTek SoCs like
mt8183 and mt8186.

By enabling this on the defconfig we make it effortless to test the
relevant hardware on CI systems like KernelCI.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c0f2068c69b5..0a2b76f7a997 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1197,6 +1197,7 @@ CONFIG_ARCH_TEGRA_234_SOC=y
 CONFIG_TI_SCI_PM_DOMAINS=y
 CONFIG_ARM_IMX_BUS_DEVFREQ=m
 CONFIG_ARM_IMX8M_DDRC_DEVFREQ=m
+CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=m
 CONFIG_EXTCON_PTN5150=m
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
-- 
2.38.1

