Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321DB726A99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjFGURI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjFGUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:16:57 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C681C1FDB;
        Wed,  7 Jun 2023 13:16:55 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 36D085FD71;
        Wed,  7 Jun 2023 23:16:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686169014;
        bh=g3y8T0WTlJ3jzmj8lOKHVsw9Ja/UPAZJGv18YRUKJy0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=g69kBCUVxKU3MeagzwSZlDYO6xykarWKd7igIzWqgS20j/Bs79FFQ1SVKXIYnI0LH
         WS2LldPlX7FVQ4rb3Y9f9NYxx5kPFORDK6Wnyit67hiJd6gqpJSLld7O+jH5eN/lyw
         GPu37RYc/MAE9h7rvCl+0jJIqlhYTdupCDFrgVQF2iPRZajSGiAxqeVVNmD6TY5CfX
         zfADPI1oM0/QSBhc8GlcjrQytSpuUtyNG5SuvzTsmMATBd1Sj+IrZpo8k34Q1Q9/wU
         0wLXig6YO2nFXfoJTS7yZZm/F1QZyGy1hLBu95gQo8htt++tYStJxbHILNoZvYGuO2
         5a1ndu8qzrOMg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  7 Jun 2023 23:16:54 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor+dt@kernel.org>
CC:     <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1 4/6] arm64: dts: meson: a1: introduce SPI Flash Controller
Date:   Wed, 7 Jun 2023 23:16:39 +0300
Message-ID: <20230607201641.20982-5-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/07 16:55:00 #21454472
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Kurbanov <mmkurbanov@sberdevices.ru>

This controller can be used for spinand flash connection.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 63faccfc1134..0efd922ca7e1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -199,6 +199,16 @@ gic: interrupt-controller@ff901000 {
 			#address-cells = <0>;
 		};
 
+		spifc: spi@fd000400 {
+			compatible = "amlogic,a1-spifc";
+			reg = <0x0 0xfd000400 0x0 0x290>;
+			clocks = <&clkc_periphs CLKID_SPIFC>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			power-domains = <&pwrc PWRC_SPIFC_ID>;
+			status = "disabled";
+		};
+
 		usb: usb@fe004400 {
 			status = "disabled";
 			compatible = "amlogic,meson-a1-usb-ctrl";
-- 
2.36.0

