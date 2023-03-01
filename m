Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A416A6A44
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCAJ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCAJzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:55:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A443B3F4;
        Wed,  1 Mar 2023 01:55:39 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 833FC6602126;
        Wed,  1 Mar 2023 09:55:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677664538;
        bh=mY4hfSUTwSHqh4eiis9sq5UHYdSJwKcNza4C9t+I8c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtO9PRfSN0kIoXXl1gTXx2bnYG9+nSCiHkjmLShKx0sMNLpLhig0ayN/SGKNI9Hl0
         v2HUBw6vvyOtyazIXL27MqkHiv+sTGOqEZHxaRJDQhYbB0P0fLF8+/e/MKzC7rQrvD
         CGegsyzWXJkl7P8sv8jyGrq9AU/rVPEYCK+4dUl0JMJl5NSfD4fF7pe29jIjeGC08W
         Dw3+bEDs5bUP6aGfMLAnGoPVId6DcHiq2NA5onKi6gVceuQg/qiZj9YdD8Awew+kR/
         rkEeXj/+6tuf94gqPgsfQkc342hP/IVId6Ew6pFeeEG9vuBNQQJ8LwlEaUdDS5ghy7
         UThANP0zQ08Bw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Subject: [PATCH v4 13/19] arm64: dts: mediatek: mt8192-asurada: Enable GPU
Date:   Wed,  1 Mar 2023 10:55:17 +0100
Message-Id: <20230301095523.428461-14-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Enable the GPU with its power supplies described.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
[wenst@: patch split out from MT8192 GPU node patch]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
[Angelo: Minor commit title fix]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index f858eca219d7..5a440504d4f9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -275,6 +275,11 @@ &dsi_out {
 	remote-endpoint = <&anx7625_in>;
 };
 
+&gpu {
+	mali-supply = <&mt6315_7_vbuck1>;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.39.2

