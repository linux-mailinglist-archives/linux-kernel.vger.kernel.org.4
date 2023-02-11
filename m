Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1A1692C01
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBKA1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBKA0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:26:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CC018154;
        Fri, 10 Feb 2023 16:26:50 -0800 (PST)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9608A660211D;
        Sat, 11 Feb 2023 00:26:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676075209;
        bh=4fj14O2ZqY7lhZc9uruNRVseKfOaZN5u91rDfmMZECs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deUF6tu06hDPmNRkLFWhShkbhZyGLxzHkof1s1fPKup+K+R9oXBWaNPiE0OaGw05L
         W55wTqEbR3/B898ljIBNABz7SNcg+NBgEaHuI859nXXwEsgYVo6QEeAQrdy5OLrYNr
         qR4RoXsbYt01Rk/4sjcBf/e7Xc1BT+EgLBlqS7Jwi1Opp14/msSnw3tZw/w5n2c7k9
         0YAP/EpynqedcHfgEJekcOpGSo/ZUQYNLdibwqL3dm+Bqh0H/kkeE5ncQmrFb2Mcye
         MmfIJw9vGcIL5pVlENKdpgSeGflbzVCHxrL0XOCLRY7wAGqJ4v8JtsW9lr+e2wZh2l
         5UfQ1lzvZlQXg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 5/5] arm64: dts: mediatek: Add spherion-rev4
Date:   Fri, 10 Feb 2023 19:26:26 -0500
Message-Id: <20230211002626.454844-6-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211002626.454844-1-nfraprado@collabora.com>
References: <20230211002626.454844-1-nfraprado@collabora.com>
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

Add a devicetree for rev4 of Spherion. It uses the rt5682s audio codec
instead of the rt5682 used in the previous revision.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../mediatek/mt8192-asurada-spherion-r4.dts   | 62 +++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index b349c4805e4c..8f35aa2406b2 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r4.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r2.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts
new file mode 100644
index 000000000000..3949a8f73e71
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2022 Google LLC
+ */
+/dts-v1/;
+#include "mt8192-asurada.dtsi"
+#include "mt8192-asurada-audio-rt1015p-rt5682s.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Google Spherion (rev4)";
+	compatible = "google,spherion-rev4", "google,spherion",
+		     "mediatek,mt8192";
+
+	pwmleds {
+		compatible = "pwm-leds";
+
+		led {
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			pwms = <&cros_ec_pwm 0>;
+			max-brightness = <1023>;
+		};
+	};
+};
+
+&cros_ec_pwm {
+	status = "okay";
+};
+
+&keyboard_controller {
+	function-row-physmap = <
+		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
+		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
+		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
+		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
+		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
+		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
+		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
+		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
+		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
+		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
+	>;
+	linux,keymap = <
+		MATRIX_KEY(0x00, 0x02, KEY_BACK)
+		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
+		MATRIX_KEY(0x02, 0x02, KEY_FULL_SCREEN)
+		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
+		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
+		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
+		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
+		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
+		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
+
+		CROS_STD_MAIN_KEYMAP
+	>;
+};
+
+&touchscreen {
+	compatible = "elan,ekth3500";
+};
-- 
2.39.1

