Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F196F7767
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjEDUtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjEDUtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:49:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3F876A0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:48:28 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DE819660570C;
        Thu,  4 May 2023 21:19:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683231560;
        bh=NFAAtd6iAo3haXn25ityXtWEQXkPY86qr8yN5Xd3uMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=iYWxi0u/wtY2syvS9m0KGuqd9rVKtoapxxbnuuMOILhEgAh06qiu9Vc2+tFYq+3mB
         0akPSnn7ylrnR0KOcV1Ta/r9/xREh9wQLZ6+kwHEDevZo484CpdizRT063e2oqOI6r
         g1jAdgb0a5/Yxb84q8D9u2WQAo6HceOeTP7a/a+eO1jCUSraatieLtBnUIV88ojpXX
         o/V3gJ4WPTQGGDTu0HMGfVk9NWLbhfdLUGPcUr1lYt+8ZqhnJvyQMThZleBFFrcIZ/
         HAiOm5mgKPqA3FAL7eHHyfliGi6rXlqQbeA1CIiBYsEfNijZXgW6pQSlC8McUOA2O7
         z05aGS35HdjCg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH RESEND] arm64: defconfig: Enable Rockchip I2S TDM and ES8316 drivers
Date:   Thu,  4 May 2023 23:19:16 +0300
Message-Id: <20230504201916.1121243-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip I2S TDM driver and the Everest Semi ES8316 codec are used
to provide analog audio support on the RK3588 SoC based Rock 5B board.

Enable both of them as modules.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1e7021ead7f5..dff4c4296c08 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -867,6 +867,7 @@ CONFIG_SND_SOC_SM8250=m
 CONFIG_SND_SOC_SC7180=m
 CONFIG_SND_SOC_SC7280=m
 CONFIG_SND_SOC_ROCKCHIP=m
+CONFIG_SND_SOC_ROCKCHIP_I2S_TDM=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
 CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
@@ -897,6 +898,7 @@ CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_DA7213=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
+CONFIG_SND_SOC_ES8316=m
 CONFIG_SND_SOC_GTM601=m
 CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
 CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
-- 
2.40.0

