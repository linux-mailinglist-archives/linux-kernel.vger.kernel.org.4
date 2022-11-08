Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D2D622048
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiKHXX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiKHXXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:23:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26628657EE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:23:08 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A171F66029BF;
        Tue,  8 Nov 2022 23:23:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667949787;
        bh=WVGgYTL2bBhf6hPTgupzPt3PkRQ85FviTt7YgqhbfBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G1WYWsseaHlMsYT7RxBJZ1XKfvBG6TVevJ7E9dH37u3ys00uFXNny0WOZPf3m2Y19
         vL5W9v4D0T5bt+BHbXkNnoBPMuPdVYKGSdme3JoeEXk02JaVteM4jO4LvEpf05Qg8/
         fqbVYyLB1yeGsWnwW/47cueP18tYgJIktIaL1T2pRCJobzk/R9ZCxabIJvyNcOf1W8
         5+gInYvHfqJKTwHHbTaHoxhIBfRoA2tOOZdwYtdzJvyFZ8TlErJW3dK8s27nudWvdE
         s1OWIQrEQfWjVKHAQNUCs0hu4fplfZ7fFZ+fu2MAUv4z+zeb/pgoCC+WAW16E7gscU
         yQaI5lrMKF+/g==
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
Subject: [PATCH 12/13] arm64: defconfig: Enable GENERIC_ADC_THERMAL
Date:   Tue,  8 Nov 2022 18:22:27 -0500
Message-Id: <20221108232228.1177199-13-nfraprado@collabora.com>
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

Enable support for generic ADC based thermal sensors. It is used by some
imx6dl based boards as well as mt8183-kukui.

By enabling this on the defconfig we make it effortless to test the
relevant hardware on CI systems like KernelCI.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0a2b76f7a997..caa95c908430 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -624,6 +624,7 @@ CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_TEGRA_SOCTHERM=m
 CONFIG_TEGRA_BPMP_THERMAL=m
+CONFIG_GENERIC_ADC_THERMAL=m
 CONFIG_QCOM_TSENS=y
 CONFIG_QCOM_SPMI_ADC_TM5=m
 CONFIG_QCOM_SPMI_TEMP_ALARM=m
-- 
2.38.1

