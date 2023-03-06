Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8316C6AC1C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCFNsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCFNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:47:55 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B2010FF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:47:53 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cy23so38629549edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678110472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcK7h2xkUrxUohGfOB4HeHVOM4D/ccmRrqqf2D1YNtw=;
        b=fW7ieA2VtbQSXR/suVGVtqo7MTfevxllSiYiFW5Zk89Q7MScV0OjCFgu4+Em1fsi/O
         UzBw4m5Z992ZSVHDlW1lHBuKKeECpPTx05I5ov7UkY41H79F15Ao1YhlOr8DYaPsGKvg
         FxbOzXkO95eLDBoIhg1aJ2C8vCngB1jpMEMbwveEcrsiGfBq9HAUeHh5iSjMlK8v4NlI
         qDIyadEOSVjkmZTK1jim/teFzEiWGS6eRYYm2HI2+hcx2znmWEC5EBPKwxtgV9YfjSy0
         lvqnMXEUz8G9BgDdxZEaofZW2g8IDq4G8z0b5BGxztiapbuEhv8g2GiC+SK0bz6n2+jF
         ZQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678110472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcK7h2xkUrxUohGfOB4HeHVOM4D/ccmRrqqf2D1YNtw=;
        b=6acCwCwt4SQ9zZbBkZXOcGqGlB7E7YV0ARuhO9buqGQ+vbTwYZAw779mwoQucWVZQN
         uSZ0ceVOr1LFkQzFm1vybvrtbhi7LBfUqQUXI42XbPPBdMJF9wt1dqsQ6szkszX00vVr
         iWvrln9wazZ6rdcFakUUAKASWsvXeEcoDw0my+mSCmntgyjljVWpb4/xUWuM1t3AGYDh
         XYfAI6bb5KERxYlzn4onB1XNbEbKxAhGNcnXPPnpqC3WHxDNkgSiicZRBUmlB8fJQDwU
         +v4MIlxEM0gj0hypMxv1JoWFuX9IGsmPgGBKQa2hPxlLCbE9qUqgk0Kb3LAbfPI0wAsH
         Awtw==
X-Gm-Message-State: AO0yUKWjB8ir1NySnKFaOqRdj1tXORKzCkL3r43vVy2EzoFYtlBt0j9X
        vwVwWaWukFydHGCplrqZt5W4Tw==
X-Google-Smtp-Source: AK7set/niWTx+/FkDBG0ezz53/7cuKUc9uzQRtbJoXySOD5FBDqrF1VJRvaSp12rekQmppglmalcFQ==
X-Received: by 2002:a05:6402:31fb:b0:4ac:c3c0:24d7 with SMTP id dy27-20020a05640231fb00b004acc3c024d7mr11173837edb.42.1678110471955;
        Mon, 06 Mar 2023 05:47:51 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id y64-20020a50bb46000000b004bc2d1c0fadsm5193293ede.32.2023.03.06.05.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 05:47:51 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 06 Mar 2023 14:47:43 +0100
Subject: [PATCH v3 1/2] arm64: dts: mediatek: add i2c support for mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221122-mt8365-i2c-support-v3-1-ad9bb1076d7f@baylibre.com>
References: <20221122-mt8365-i2c-support-v3-0-ad9bb1076d7f@baylibre.com>
In-Reply-To: <20221122-mt8365-i2c-support-v3-0-ad9bb1076d7f@baylibre.com>
To:     Qii Wang <qii.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2644; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=t815h3bcisWjGhNlfDMBygPs+0iQIdrU/JE4wcgy8+c=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkBe8FtR5yhYovHKM8DPrMH2h8B0A5A/gAN/vk8uke
 XNWXTH6JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZAXvBQAKCRArRkmdfjHURdPIEA
 Cbr9uvKwbizgB2J5nELpOhPwwOvYiyG8u+jIMewk8MlWhE7q29GmhNFWiXs201CGEtZXhsSLyeMp5R
 Jd1HWGAdQBX+MvYQVccikUYnmhMOm+8ajzZvlj9LEAc4Glxe5GC2/OrQ0JJ1ejzvKzv78lpVgjGwOo
 85+6pMkCoA75p6w0FvojzGPFmjvApr6kMfn0CAxG5+3kP6XyHilKm4YfKLCTdAHYQmIo83bUcMAImp
 TVsgXSFavb2xB9YL/4EUHTbzxdKmhL4fLCx0dHJ665lP/tzzJt5CpnsS8W/mCHW8HI6+hMx5QEb9Db
 jBpI1jha2wSNVc2uEzGlswE9Tq3SIjHeWHGlLpOD5/kSDjf0y9dsYDcKh3P9Cn8na9sEb5YlzVQiie
 uAn/F7VNwN3qXQJch1n/qjYJRak9pdWTlRXRo5vL3PSH1+ZnictdH7Eb3UnJ+266qlD/5h/bmMLfOD
 EYvh8gTa32rYXyj1sol34fnLqx/fkkzqKtjpHuscpoICCEguHJhB7zf3ieZUcO1yDuNDASkdJMt4yM
 OO1fsd8OAXqu55KsT4f/WfAyYf1m/kJkmGgolObXM9MrBQ2dzuG6RdNXP4fiPEyVvMSdlkpmwWIGUl
 ODxAUEq6gNbvHEdnRu77Va3f2l9ts7mhC3/RKKtyfOE/KmEkDxHqea14IpoQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four I2C master channels in MT8365 with a same HW architecture.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 15ac4c1f0966..553c7516406a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -282,6 +282,45 @@ pwm: pwm@11006000 {
 			clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
 		};
 
+		i2c0: i2c@11007000 {
+			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg = <0 0x11007000 0 0xa0>, <0 0x11000080 0 0x80>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <1>;
+			clocks = <&infracfg CLK_IFR_I2C0_AXI>,
+				 <&infracfg CLK_IFR_AP_DMA>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@11008000 {
+			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg = <0 0x11008000 0 0xa0>, <0 0x11000100 0 0x80>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <1>;
+			clocks = <&infracfg CLK_IFR_I2C1_AXI>,
+				 <&infracfg CLK_IFR_AP_DMA>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@11009000 {
+			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg = <0 0x11009000 0 0xa0>, <0 0x11000180 0 0x80>;
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <1>;
+			clocks = <&infracfg CLK_IFR_I2C2_AXI>,
+				 <&infracfg CLK_IFR_AP_DMA>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		spi: spi@1100a000 {
 			compatible = "mediatek,mt8365-spi", "mediatek,mt7622-spi";
 			reg = <0 0x1100a000 0 0x100>;
@@ -295,6 +334,19 @@ spi: spi@1100a000 {
 			status = "disabled";
 		};
 
+		i2c3: i2c@1100f000 {
+			compatible = "mediatek,mt8365-i2c", "mediatek,mt8168-i2c";
+			reg = <0 0x1100f000 0 0xa0>, <0 0x11000200 0 0x80>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_LOW>;
+			clock-div = <1>;
+			clocks = <&infracfg CLK_IFR_I2C3_AXI>,
+				 <&infracfg CLK_IFR_AP_DMA>;
+			clock-names = "main", "dma";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		ssusb: usb@11201000 {
 			compatible = "mediatek,mt8365-mtu3", "mediatek,mtu3";
 			reg = <0 0x11201000 0 0x2e00>, <0 0x11203e00 0 0x0100>;

-- 
b4 0.10.1
