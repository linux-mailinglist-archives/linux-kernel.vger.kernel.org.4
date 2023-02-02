Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01399687FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBBOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBBOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:15:36 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB46E3A7;
        Thu,  2 Feb 2023 06:15:32 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 3A07D5FD02;
        Thu,  2 Feb 2023 17:15:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1675347329;
        bh=x+mS3XduZ3+b7heAKDTw6F4UI2ioHdw4aSRUeHVmiWA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=bEwIf/urHTx8gra33bGPcLFTDkqa2q49MKxqfvDDN7+xRuSYh8mH2xq57OlWffiv3
         qr6+wfGcLWULLuhbAHfW7G5/A3KbgZ3nfz2iEkn1AseOStKl9DrYtIyyKGYqoVHLE7
         EF7did1CWKLCvsVvbzsZkuZLZ56ciKlq0fQfTriFVVQLaohxBZ8adV75IIOOIR6ycr
         QGm1SKanRrirlH31vQWmC3yyr7FVHzF93g0CmXwsAY4hBj1oaCNjjDJWNS87rItvW0
         iRzWTqEKfZXeKhB43BAgjlOn/+oK2hNaXJ13qeh90C1PbAzYMKmu1fjw7ML0d3/CO9
         MOtgsOHO+Y6xQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  2 Feb 2023 17:15:28 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 1/2] arm64: dts: meson-a1: add gpio_intc node
Date:   Thu, 2 Feb 2023 17:15:20 +0300
Message-ID: <20230202141520.40003-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/02 10:55:00 #20831577
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio interrupt controller node.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 6268c323a810..a04ddf0f4cd3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -158,6 +158,16 @@ clkc_pll: pll-clock-controller@7c80 {
 					 <&clkc_periphs CLKID_XTAL_HIFIPLL>;
 				clock-names = "xtal_fixpll", "xtal_hifipll";
 			};
+
+			gpio_intc: interrupt-controller@0440 {
+				compatible = "amlogic,meson-a1-gpio-intc",
+					     "amlogic,meson-gpio-intc";
+				reg = <0x0 0x0440 0x0 0x14>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				amlogic,channel-interrupts =
+					<49 50 51 52 53 54 55 56>;
+			};
 		};
 
 		gic: interrupt-controller@ff901000 {
-- 
2.38.1

