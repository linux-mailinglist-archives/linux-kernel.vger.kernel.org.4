Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54946FF757
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbjEKQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238549AbjEKQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:30:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545077EEB
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965d2749e2eso1283179366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683822607; x=1686414607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7/CYIBH/pHsTfzDssN9nwq/nPPFsyiz7BrFyXp1Ut8=;
        b=GhJKDtTHvxfZLhn8dTuoKKjYYnoggNINpc4vG7TVWfidbQ67nB8eWT99wBAxKkwcfz
         VS2OvoFRypOCuKQz1x9o4+t2p1BxZV9RqL0we5aVvSzjkdtCiQmfO/NwiP5vyKUAY9rV
         67dzyTNT6eBAqB0+LAaK7uVmuLTDSdYpZPUWmZ3g/SPwuhWDNxir6dLtiQzAxxmDJnDC
         d/AGLwdOhJejRpgtTvevv0yQ4HdVefB5jcen7RNlgUPtnLIcOPJ0IiJt8pKHtFoj1EVI
         Y06TBx46Dv7zwLBnJbSBYvZiwTRiYTgbIEOuOKhU9KgFfa7+amT6uqHshOnOADsUUzAZ
         uw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822607; x=1686414607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7/CYIBH/pHsTfzDssN9nwq/nPPFsyiz7BrFyXp1Ut8=;
        b=lj1wBuppgUTI9tMr4RvRSc5m96apIeBFebhobZdqxNlIYXQlxrqcurTOm9LdWubhDE
         z6ymoWN34a/WBuz0LjDnKIFF87DjNT24gsCTLmUnZr820U8mZ86c6xaclPscUDW2wKrp
         WtAtUlglXpY3CfD/Bt277hEh7IVxl8rrKzTIto8wZ2dTjg1G/2samzt/oBrUFpzPkCQ9
         GREmf39C0Xp56QKXGHmco3+xQNB6FAwhs1JnRlTJ3Sno0uos279cdvncGP5aM39yF55v
         OU0BIrYlQJcC6WeLqlLQMS/ER3l9BwH7THR5zRm0R0cS3HpD0wp25wwAoxgW5FMSHY61
         zY6A==
X-Gm-Message-State: AC+VfDxPQIemXH+VIaIuANuaBKtpllxDdXuiM9/bh7z8K7KntGViG3jF
        rnnLgGhMW7hjXlR74EIxcQV2tTXXlwvBeaICHIQ=
X-Google-Smtp-Source: ACHHUZ48kDKdegEZk8cV/FApfJ0AGakPGUCGESAhYk6jGxd451PT3jIuODPVv9AXlPcva/FrRKXs/Q==
X-Received: by 2002:a17:906:da88:b0:93a:353d:e38b with SMTP id xh8-20020a170906da8800b0093a353de38bmr20433926ejb.37.1683822607591;
        Thu, 11 May 2023 09:30:07 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v9-20020a170906338900b0094ee99eeb01sm4209935eja.150.2023.05.11.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:30:07 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 11 May 2023 18:29:28 +0200
Subject: [PATCH v7 08/11] arm64: dts: mediatek: add ethernet support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v7-8-98cbdfac656e@baylibre.com>
References: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=DjSelAdOZMPlRnOCXsPOw3j7Znol7iZuqfSQhuv0e3s=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkXRgEuL8tv3XPLNCTsvVZGVz70gDf4DdWTusQ0f+3
 BOJz1S2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZF0YBAAKCRArRkmdfjHUReCTEA
 CVmdX4q5lT6YXJzs7Qovo3u+IuaMF0ggKWFjpMDAFkBMXStBzEHV/8fBa3nnqVa7pgBHUiBC/3QbVi
 VV293B6g1r7bwPzN8mWb8R1YoBGz07J/rqY11LN4ERJ3UOBixaluzeMm7m6Y16uQowwl6/zCo3Uwrj
 kXomWO6tBUhZf20vFizrvtCfyhwZV26FANwI4P24Euk7AVFMHnjEosrwuOonrnZbbwx7O2oeKJJ+w1
 XGH9HMvNXZRbIdhGQvNHuCDTlvd3pmS/uteI+dSKLki7K4wO5Gj2oOCHKN0vSRn4TCNzMQEckuHaZE
 jknzCGG2D98waFluNfPRw2EY+yMFLgFXmp7UCWKzjOdrVOWAcqEm0XM8SZqBgQZ7RI0T8PHwTjf+iu
 8LTrJlLYmN+SShm70bGm21ElMzRete1jFfu33/JGE3S9yWzO8MedI5GMdB0bfVilPoQ40sk8NwlILs
 Q41DeTb2YIm0ocLdj3+eiIj2RJRFJlfuS9kOdn8jBbT7UQQYF5nSZwqWFbc6XVZz5Y1l3WsxEI3ycm
 zsbiABuo/3Fc2v+nuSiDJNYV+E886U9tvBLYdGHFXWisVkLPKSZMzmXrNHhbZd7bblD/AkXNwPPtFH
 9D3/i8xpOWb5GLcaqs53ryDDye4bIwk2Hf9/uNANKshVaNDy5O5jjTdpvM9Q==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Enable "vibr" and "vsim2" regulators to power the ethernet chip.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 57 +++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 3a472f620ac0..cf81dace466a 100644
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
 /* Needed by MSDC IP */
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

