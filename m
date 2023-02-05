Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FB968B123
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBERsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 12:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBERst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 12:48:49 -0500
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182B11CAD2;
        Sun,  5 Feb 2023 09:48:48 -0800 (PST)
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
        by mxout3.routing.net (Postfix) with ESMTP id 3F6AE6047F;
        Sun,  5 Feb 2023 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1675619326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5x5jw/lnJazoXzv3c6IXoN93KLrXvZK0c1wXgqRmz8M=;
        b=rObJxyrwiG/VjAXWpqAbF9wqNgBjSp4W15IbrZ/S7aC2UDQVE97stsmFgHga+4Av7PnzRo
        Hv30INctB+bt/WDFDRAGkROzCmYrzelJgvoHsS8euQtEEK6MJU0OjsSm9EaWugDHnSsC/a
        ufuh4S4aVjzBXYQnQwRAHIP0aYqzJGs=
Received: from frank-G5.. (fttx-pool-80.245.77.40.bambit.de [80.245.77.40])
        by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 0936B1226B0;
        Sun,  5 Feb 2023 17:48:46 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: mt7986: set Wifi Leds low-active for BPI-R3
Date:   Sun,  5 Feb 2023 18:48:33 +0100
Message-Id: <20230205174833.107050-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Leds for Wifi are low-active, so add property to devicetree.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index 33bd6febc160..2b028141f1f7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -446,5 +446,9 @@ &wifi {
 	pinctrl-names = "default", "dbdc";
 	pinctrl-0 = <&wf_2g_5g_pins>, <&wf_led_pins>;
 	pinctrl-1 = <&wf_dbdc_pins>, <&wf_led_pins>;
+
+	led {
+		led-active-low;
+	};
 };
 
-- 
2.34.1

