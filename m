Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE917107A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbjEYIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbjEYIer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:34:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8073D1A4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:34:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so2143735e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685003641; x=1687595641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21sgxyywgbmhgk/Ve+LU4uP54gwzQ24rV+EZbQmdloE=;
        b=oSbo7Tg1JHYrJqvIZp66F5Ub8DggOo4HbscgWfKT0Ui997PWVUKszbKsZXW59fdjFq
         WxU8PnTQuEcBMi6s4HC9IFjvqZ4EzZCqz2HSeWw/8IzcVUuhVbX5zQS5kszG6AknD3sD
         fRLnweyOb7mApmqPJIEKfv80JGg3XHvH37ogoRzzP5Ik/Wuq87yki4ljYJ+zl0Aj4jm9
         hwD8pVCXer93cL54d7WbnhpvU2+W7CN5gm8wwO5A3v5X8uSphTcupw0Mj974Z437LTzx
         PmUYTEPsLImZMexhdNjLBqgPgWrwaitXZPe+4rNXqrMNUwbJMz95CnnkKir1Uw7cI1c7
         In6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685003641; x=1687595641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21sgxyywgbmhgk/Ve+LU4uP54gwzQ24rV+EZbQmdloE=;
        b=i2iPZ5+zaWrAB2tYNdU/GCjdhKeRv2PSS6x1X0fuF5UoH9bTKPllyRCC2uaQZoz0wz
         XZRSBCa9wCA28slbNzc8OUhCuldrTcPuOtbtI41tMxbO/aim30ar8gB30OS9yU+atRki
         jTMoWUAw+1S+zIR9CdfiQfB9xQmPQKTHiCoeGvXYMwhrcneL5zjWVYLH1gKiHJl+MAfd
         OidQpNldW0EWkReq3gWR7by1DzhvsOD9AYnKXHWjEaK057KXc1SIig8ovJuCDKlbnPeN
         aue12U/7PKomLoyL4txnMQpfr8bArO/wpbwOwKa5HO7nVXizEd+nXIS0uWH0jGg02bYs
         v+0Q==
X-Gm-Message-State: AC+VfDzR5Fkq4ARgvwQWr6AGmFUlGhSU19wySiTioN5Ciu4T8rqHpnBY
        nJdfheuckz7K5SbdXuUcXk3LfkhktC3Mj4ZwCCk=
X-Google-Smtp-Source: ACHHUZ60vZmppbo1C69IRWqcbhZqc1t8qjPj+2xpbwp4QzkZPSmbOesqmgUpvqXUK9vJq3VRpD9brg==
X-Received: by 2002:a05:600c:2304:b0:3f4:2bb3:a5c9 with SMTP id 4-20020a05600c230400b003f42bb3a5c9mr1906034wmo.8.1685003641741;
        Thu, 25 May 2023 01:34:01 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o3-20020a5d6843000000b003095a329e90sm945809wrw.97.2023.05.25.01.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:34:01 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 25 May 2023 10:33:16 +0200
Subject: [PATCH v8 07/10] arm64: dts: mediatek: add ethernet support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v8-7-7019f3fd0adf@baylibre.com>
References: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=U+Xs+VxtYFwUGhR18YiqTjcMEMzYJRNse3ci95tZvgA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkbx1vMkOP5L8x//cPNHtpPDsMNnba4MKariCWnjnC
 vFJk/COJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZG8dbwAKCRArRkmdfjHURSTIEA
 CnP+Sp9PCcyYKQpGswvuSybT/Qu8Ldh8ib2w+5v/Fg2qP3mNArkJ4dKp3xkQ18OFAaC9tD4Mg2+JRp
 tN6kVnrVQXzOaYLAdLU84jZ/c2+/QKWklrvL3L3tWx+RaCQPzulHag0DnOByHmI4wDLRCYxHhpFKQM
 GPEhXcf4rcqWPqDx7mk5552FDu2YHLIkIajwh//clAKRFU/KixwanPXGooo253UVaHSgKFssZ+onro
 4vvzA15OFWR6YvK7H7G5J3buTpMyMUgM6nNK+sZMAYBB7rmnKlDPkjWUmSk0QPq/93AHB9Bw04Dxgl
 71xi9vsNEm0bLA9rnmg/SnsY84PJ7JyyYK4yUiBSDlVpT25J9n8pY+usn3e4Kjm8OXW8tp/VILWDVL
 4eiUaZ17+eGfxQ+G8drgeY0zySuTzBTBiYOzWsh1JauL02zjs9xMqSB7LAK+OObR7jzw09pF4ggFek
 bSD7MrHt5le9WKbs6SDOC1NNb3DbFQJRgQfj1p+mVTz0PDoEDV0N0BLL3/w80RtXTfvjq53qa3//7q
 ZISN8IzDUKu+TxO8/ikTSaoEfT6E+Ni4y6TtnIbdB23vtTIrVyFPgt4QhtuaXS0P1F/kzs2NE5WKnT
 b5DhDcy34NN1+b1Jr5ESIteKC8eATq/40dGIet6Pr+cuDuePJnv97wA6zy1A==
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
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 48 +++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 1a5769c397c2..86524cbf4354 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -88,6 +88,29 @@ optee_reserved: optee@43200000 {
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
+	 * mt6357_vibr_reg and mt6357_vsim2_reg are needed to supply ethernet
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
@@ -138,6 +161,31 @@ &mt6357_pmic {
 };
 
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

