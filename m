Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E427692BF8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjBKA06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBKA0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:26:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0CE821BE;
        Fri, 10 Feb 2023 16:26:45 -0800 (PST)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 539A06602117;
        Sat, 11 Feb 2023 00:26:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676075204;
        bh=Gm+Fv0Lf5OBMJRwMwPwUnakOGkSawtiyv5gR5vwnHEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dq1zENlbIU6e5lYwBFr4/UN5m6eTJ6Xmij+S8+cTBbYx3YRotjypGtFE+qcRiNPOY
         8IGNecyKb1bejqcOdieI54NjCuXJujo+/Op2iqKYadboKbzIOTnVbd81dQBVIXARGN
         w34HSdKjWDUhTUyOuNBFZ5hNbLhiM4jZs1YFboziejhhWUzI5mJFLUpLfFafUxHisR
         EYDjJaNjEe+fyqfscxdPrqpQ9aFmKLBqXNt3YM/UOSxBGl6kIlQP9jIp/zzh4Tm6rb
         +aVEFDMS7dCivivaZ7bv8b1GWQRyuSdTGjNYstwabTqWZZhlBc9R5ZQZuntRcwRe4i
         OOowiptXPcDvQ==
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
Subject: [PATCH 3/5] arm64: dts: mediatek: Add dtsi files to use rt5682s on mt8192
Date:   Fri, 10 Feb 2023 19:26:24 -0500
Message-Id: <20230211002626.454844-4-nfraprado@collabora.com>
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

Add a dtsi file for the rt5682s audio codec and another to wire it to be
used by mt8192's sound card.

These dtsi files will be used by Spherion rev4 and Hayato rev5-sku2,
which make use of the rt5682s codec instead of the rt5682 used in
previous revisions.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 .../mt8192-asurada-audio-rt1015p-rt5682s.dtsi | 18 ++++++++++++++++++
 .../mt8192-asurada-audio-rt5682s.dtsi         | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682s.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682s.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682s.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682s.dtsi
new file mode 100644
index 000000000000..8921f5e38586
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682s.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+#include "mt8192-asurada-audio-rt5682s.dtsi"
+#include "mt8192-asurada-audio-rt1015p.dtsi"
+
+&sound {
+	compatible = "mediatek,mt8192_mt6359_rt1015p_rt5682s";
+
+	speaker-codecs {
+		sound-dai = <&rt1015p>;
+	};
+
+	headset-codec {
+		sound-dai = <&rt5682s 0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682s.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682s.dtsi
new file mode 100644
index 000000000000..919035245b6e
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682s.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+&i2c1 {
+	rt5682s: audio-codec@1a {
+		compatible = "realtek,rt5682s";
+		reg = <0x1a>;
+		interrupts-extended = <&pio 18 IRQ_TYPE_LEVEL_LOW>;
+		realtek,jd-src = <1>;
+		#sound-dai-cells = <1>;
+
+		AVDD-supply = <&mt6359_vio18_ldo_reg>;
+		DBVDD-supply = <&mt6359_vio18_ldo_reg>;
+		LDO1-IN-supply = <&mt6359_vio18_ldo_reg>;
+		MICVDD-supply = <&pp3300_g>;
+	};
+};
-- 
2.39.1

