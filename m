Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E1E6DAD13
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbjDGNAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbjDGM7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:59:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389DE7ABA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:59:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o32so23992782wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680872391; x=1683464391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2q+psvx4yJ9KCnO3jUj6x64A5eBfyf7+pEcxfNP/wU=;
        b=kNGYBnFsOdRs0HvH6QMU8G1l3B0T7AHL9SUy1iK3nkJuMoKwxlHtN2lVcZHf26bMOy
         aXHKeN5ZBq72kUMviJrYdAg8HoUE28gONmpuTjv8wv1X8DLT+MnB6HwL1oKLtQC1iGtT
         wavO0gwbHW8jLM+kbysG1vRenhJ+uqA8HeGV4VFRMquO5p1slwmoRSNU852XVxtF81fp
         34F6haxTChyo9VRhQeG6YPy+YJQjl9j+3Ycg9H6V9prNF6pEo6V0enaWZp/LtbGn/UxC
         hm4dYxpUl9wGH1+lnswbzSjiChDwPOvkaR2GnE4HZ8WvDIjKRfg0FYA7aVNxD1/g0PK/
         BdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872391; x=1683464391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2q+psvx4yJ9KCnO3jUj6x64A5eBfyf7+pEcxfNP/wU=;
        b=WwhtqZKwyycI4yivBVmJC2Xe4WMC23B2JfDxneuXBUQu2zUqLDyPg3rp/RpmWzVh/w
         4MM/Y3YHma3wVPCL0cT8etC80beWUPM9g4dciwRV7N4gJdlPWJnsDE74l/2EGEsGKqnm
         6/IUiJXbPdtK9ugo+uqSseqEAtURlc7SEor5C4mwdXxQKYMCm2MY3KXSAxQ95b4m9nI4
         kO5HYExc5HrUwnZuY3fspGnIO30NgfGStUtgHW+2m6DrUi9bEeOZEcsI4tk+ESW4jzRK
         cFjB+icZi+bD0W4MCMmtvTgJJnIgw+DHonIeCqA1kUXZsHxdqIoQE3s7RHPGZ9uRIJxK
         mkOw==
X-Gm-Message-State: AAQBX9devpSf6N2JfzGzXzamS+m878yOUHKPXv5sGhvJDCA+kdnVQ4jP
        z7jZt/Cb9rYU41bRFo3tC7SiQw==
X-Google-Smtp-Source: AKy350ZzQ01WxViiySWC+n7lJRkZifZMbdCAMyJ2zRxaM8KaXiQ0RBOg3300pCnX0a8Lpnks6GPANA==
X-Received: by 2002:a05:600c:218d:b0:3ed:320a:3721 with SMTP id e13-20020a05600c218d00b003ed320a3721mr1418103wme.22.1680872391555;
        Fri, 07 Apr 2023 05:59:51 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t4-20020a5d6a44000000b002e558f1c45fsm4471446wrw.69.2023.04.07.05.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:59:51 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 14:59:28 +0200
Subject: [PATCH v5 09/12] arm64: dts: mediatek: add ethernet support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v5-9-1883c1b405ad@baylibre.com>
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2431; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=qis7u9dUHrWOnbhiX3GDPhugjgVXBkDPDVj5m9M4200=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkMBO6jGoMhPSC8/u2mSdWUkp0vvyJ26Nfy26JOIW8
 7jrUXZOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZDATugAKCRArRkmdfjHURckkD/
 4gFyqdOtBUpSZL/GjaJpSHnrJbsKxp5S2gg3Ij8KzH/+4zmxfuW00BnrrFqeKxrmzHhXO3yEWeNKFA
 8uJKCPQyNmRC+wKcr0tHSLsh5t+Ml7eDvJI0gSk/6RiXeM0+s0QG6n7U+tJ1+oHa6LZ6Jrc80XuUQv
 R8idXfjbx2V4qTu2G2FZnX0uyvzSJa84DHASgEH367zU47WRvPj5PTygyJkJnGHU8Adw+8aFdGcOx8
 jmASRrjwy98hILGvvfe4K3mNwSFzxuRzuqKgwBTQmA3Wd9v1zspW5FZhmOenzdOyciCtrKx9f6e0yT
 sr3cKu8zetW1EkekQ9F1cQO7+rIucwRo6rmAHfeenxRfYG4ZUp3qAP3LLG7LpJHJmfN46l8gtq1ybA
 bvAiL81lfKwC6Bb9Yu+GRrzCLpVZEJ9bZeA7mSlbC1MnE6vwiBKgjqKGzszEI1n7mLiRsfjdmL8sqs
 fE/54ecjpCCQucF4umTyW74hT/Q7idxLC6E+KtV8IkJ9GaIQpnldkmYsxTpnESEqvBcW5JohL6kQZP
 hCIBbtHPxZ1lN/Ksvpnrqg20USMvnASYdChrtZTnjsp+l8By4JXaDZsarpni//esIdHPAt7sC37Fwl
 I/tPV8tZ8E9YVW/Al8eTb16sfYi0ktIKOEdIKbZSF9gko4Us8M8Zz6/eMI3A==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Enable "vibr" and "vsim2" regulators to power the ethernet chip.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 57 +++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 9760f181eb34..431078f8670e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -88,6 +88,28 @@ optee_reserved: optee@43200000 {
 	};
 };
 
+&ethernet {
+	pinctrl-0 = <&ethernet_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&eth_phy>;
+	phy-mode = "rmii";
+	/*
+	 * Ethernet and HDMI (DSI0) are sharing pins.
+	 * Only one can be enabled at a time and require the physical switch
+	 * SW2101 to be set on LAN position
+	 */
+	status = "disabled";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
 &i2c0 {
 	clock-frequency = <100000>;
 	pinctrl-0 = <&i2c0_pins>;
@@ -137,12 +159,47 @@ &mt6357_pmic {
 	#interrupt-cells = <2>;
 };
 
+/* Needed by analog switch (multiplexer), HDMI and ethernet */
+&mt6357_vibr_reg {
+	regulator-always-on;
+};
+
 /* Needed by MSDC1 */
 &mt6357_vmc_reg {
 	regulator-always-on;
 };
 
+/* Needed by ethernet */
+&mt6357_vsim2_reg {
+	regulator-always-on;
+};
+
 &pio {
+	ethernet_pins: ethernet-pins {
+		phy_reset_pins {
+			pinmux = <MT8365_PIN_133_TDM_TX_DATA1__FUNC_GPIO133>;
+		};
+
+		rmii_pins {
+			pinmux = <MT8365_PIN_0_GPIO0__FUNC_EXT_TXD0>,
+				 <MT8365_PIN_1_GPIO1__FUNC_EXT_TXD1>,
+				 <MT8365_PIN_2_GPIO2__FUNC_EXT_TXD2>,
+				 <MT8365_PIN_3_GPIO3__FUNC_EXT_TXD3>,
+				 <MT8365_PIN_4_GPIO4__FUNC_EXT_TXC>,
+				 <MT8365_PIN_5_GPIO5__FUNC_EXT_RXER>,
+				 <MT8365_PIN_6_GPIO6__FUNC_EXT_RXC>,
+				 <MT8365_PIN_7_GPIO7__FUNC_EXT_RXDV>,
+				 <MT8365_PIN_8_GPIO8__FUNC_EXT_RXD0>,
+				 <MT8365_PIN_9_GPIO9__FUNC_EXT_RXD1>,
+				 <MT8365_PIN_10_GPIO10__FUNC_EXT_RXD2>,
+				 <MT8365_PIN_11_GPIO11__FUNC_EXT_RXD3>,
+				 <MT8365_PIN_12_GPIO12__FUNC_EXT_TXEN>,
+				 <MT8365_PIN_13_GPIO13__FUNC_EXT_COL>,
+				 <MT8365_PIN_14_GPIO14__FUNC_EXT_MDIO>,
+				 <MT8365_PIN_15_GPIO15__FUNC_EXT_MDC>;
+		};
+	};
+
 	gpio_keys: gpio-keys-pins {
 		pins {
 			pinmux = <MT8365_PIN_24_KPCOL0__FUNC_KPCOL0>;

-- 
2.25.1

