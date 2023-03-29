Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907156CD59A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjC2I4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjC2Iza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:55:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB0549DA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so5513365wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680080108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tc0tvFfRXISHKnCDd1o9x7ZirUcZ+kLbNssiFkvaiEo=;
        b=0w7dcK8QqyDtRT/8IraSXznp84ASDFAs2r/m2hfTxe5wFTfAuYv6Xc4GZftHGgSvtd
         oXjSgNWQthqlmrv9ortHiRrpdZ4N3d7HERiDn+JyqLeomP9jASoTAH6xp+QTHR/X/XzJ
         EGOs9rUjrSGwfBkWpRIBShcD4k0mta8Hx6XOigof9yUEO3Th3H/0kc8OgoP/lnD77Bjw
         OwQ2yVz9z9ffyfMMfZTqbrjpLXM9qkI1L2W8pmeYsNMQe3QNWJPGRZd9g1vhzkNqWmlz
         CVQnsW5VblH7U0tO5dqQbgKFK+vWzgKL6tH1sitDxML61JTsebhNOWTGtRFHziTD8ozC
         Ts9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tc0tvFfRXISHKnCDd1o9x7ZirUcZ+kLbNssiFkvaiEo=;
        b=3e23qaWUjkPgmRvqDa1lE8Qxem2WPyQINWIWNV8NQpHCaphdIql9qvgxTGRB36HWih
         M/9VpJC3YEmA7xJ4ZONbmyhjAYxRf/MGbX0641DUUkV57gd2hnbcZjOfLk+2l4pLgiBL
         q7Q50ontsLbg5TBLzQ6MW/K3FdStV8N0vQjSCc42y5Xq786qW55G3p31YtAlhnnTaNKG
         wtXPrJQ/OCSdhIizyl5Jsrllocipp9dpUXU+iwx5xYrWKCATrFsG5GjRbCScoLabZQrK
         bYa1ry1kIr/R7uX43TfB4/S+wzEi51+x3vpWTO413v4I/0eQN8wyFtiUBP6/1gUGKZke
         3G4Q==
X-Gm-Message-State: AO0yUKXKPCN6udScBnNcM13e55RuJwcx3mK2syGsiKwklHEBBNC0Q0lB
        0O4TbnHuS2VjHVhjK5uQdOtU6A==
X-Google-Smtp-Source: AK7set9iLPnqzlkJP27bD71VhJuqsetDy3oUBZyGG+iJbiqKddZU/Sc+nQfuu8h42LeKmA7Ib+1bxA==
X-Received: by 2002:a7b:c3c7:0:b0:3ea:f75d:4626 with SMTP id t7-20020a7bc3c7000000b003eaf75d4626mr14067428wmj.38.1680080107999;
        Wed, 29 Mar 2023 01:55:07 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm29571964wrr.69.2023.03.29.01.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:55:07 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 10:54:34 +0200
Subject: [PATCH v3 13/17] arm64: dts: mediatek: add ethernet support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v3-13-0003e80e0095@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=/sWnZn5I2Q2gVnzorBAXHY3JwcCKjkzGjd4XBmHmgDY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkI/zcNeBQfaPCLdrn1gPlj5P0kizCnmtupqihg/t+
 +Z4ADtyJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCP83AAKCRArRkmdfjHURUWwD/
 41cgFLnCf6V+fkBD6PXpyBrWc6crMUZVp6jIndN/sOnPmLI03fFu1jnsk6iFGXJHkaeQ1C1YrW7Khr
 4gDEzInZuDj+PIQASI8R441Z526VbUoByRUGhRFwjhFEOD1NagoPltEEpR0xphX+4DuR4rxKA2GRhd
 V0+tx8cE4GNMMbmOcJ3crFuMgnnIKsEVTOo8AxxUxuvQ+6E3t4BiIS8zOb35aPdlkYbPF6AC18kP9R
 vDCKMaDMpmj9QZZhUxVmFC3gb/mLJOdISqQkPP02cjFC24vxfCovTtVxBoUtJdRcM6/mYeP+WNG9Z9
 nvwWnvR8gWqGgYtK1G/ZKXUvcOr73OSHDrT5DafHEUCpkVetP79eaJTqLduDXOk76KbFRa2JtoFlG+
 /VfNpP+VvNx+IuxlHv6MvaVyBRYUINoHWfjaGuwRI/NndPZ+1YbjWYw5FQKyrmBtAyV3Hk+UMGv9/C
 +IM8dR0EcQUW5vxHJrk0jCuBDLlDqgPuZjOqlzgDZKiGrNvx/LrcmTuwls2QBZYsWrv2jY8pyaM26Z
 fsMfuOdhQqc0wsVTntL1Dl959Evc8iEQROx9EKyQAG75GPu1cjTU0LxkQ01F3ynfFrt8cjVAqkN5hV
 gR3wFfp3eD7B6/e9u2fGQGTRSbmuNV1tBEp589EvTN0RBQ0cWFmFz4POyjiQ==
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
index 868ee0d160e4..1820daad6da3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -88,6 +88,28 @@ optee_reserved: optee@43200000 {
 	};
 };
 
+&ethernet {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_pins>;
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
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
@@ -140,12 +162,47 @@ &mt6357_pmic {
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

