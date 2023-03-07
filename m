Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179616AF8A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjCGW2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCGW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:27:46 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F21968C2;
        Tue,  7 Mar 2023 14:27:06 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u9so58597337edd.2;
        Tue, 07 Mar 2023 14:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678228024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExpR60rlK67/XKPCeTgOHd008brYtjClGvCmbWSFbwI=;
        b=Zb/ggaaQyv+CkyxjYqpj/Dy3WUdP/IdFF0xtREUhsz/4gu2BR3xwDR29s1j2lq5Nr3
         gMibyzTFlzcEArZliny/JoXY2WWrfPF3m74+XGzSLtzdixRjF0OTfvjpdSeL8pb5b7iy
         tfIKXizsoEbEjJImbsAkw7ejDSKfzuh2BlS7uxXsNNlUmSh45ITD8m2l3mTgbznGBSXV
         1N/3mG9zXst+s2dhcQXG57D9G9NobHu15G5IcDiiDgS9tJwsbWcRU+O7BCzwmWJcAcqt
         uMZ+QqJ1VbozXtBKmC/I4AWnTRW3jXGxyVCZAqKOKrOhgIDrM6mO1ckkt5xNjBWLKER8
         sQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExpR60rlK67/XKPCeTgOHd008brYtjClGvCmbWSFbwI=;
        b=skvoPiVoVrNYfs7uO1o+7ftVPzQ7WMDoziCQ8J/DuSg6ZdMplre9P1gaEG+yEUXhgt
         RTlTSwilVclWt6zo0C7R5OAjANYUZtR8H7NeBjtZT7yXMlKeNV4p1PSTe137eE+rvufJ
         95cTGaNdP9VcGf/ddC12NyXjTsdrTCqTqK6x5LdMnZs2ZQ516trUa6noNaJXcE4mW7hB
         P2hylZkZ3mjcgkembKifI2ahWgg/8iYDQr/1JqWzvzzXxo7c5LC4Id3Gm35ez6Kc9eEj
         ZZ79CC610HZZT44aN+dw5J3y8F8Zt/KWlc93ZltWTEITZ2rkduoUUKZDW7FXRtOaY0gk
         PDsg==
X-Gm-Message-State: AO0yUKXGekgdhkpLe5rIIuYlYRxMBQ+rT8Ok0JNEupSFaKpdA2sER3Wv
        IHWkrMGQzY62UVEKNqnVVzE=
X-Google-Smtp-Source: AK7set/o0PL2VR+sAsODNx7yzEKziGZhE38Th2SLl9L8Pm3Fk4SOFX1CvOJbUItRhB8Vx6c43w6oPg==
X-Received: by 2002:a17:906:c9c2:b0:8a0:7158:15dc with SMTP id hk2-20020a170906c9c200b008a0715815dcmr13158932ejb.74.1678228024215;
        Tue, 07 Mar 2023 14:27:04 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c485-ef00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c485:ef00::e63])
        by smtp.googlemail.com with ESMTPSA id t19-20020a170906065300b008be996c1630sm6669412ejb.39.2023.03.07.14.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:27:03 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 3/3] arm64: dts: meson-g12-common: Use the G12A UART compatible string
Date:   Tue,  7 Mar 2023 23:26:51 +0100
Message-Id: <20230307222651.2106615-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222651.2106615-1-martin.blumenstingl@googlemail.com>
References: <20230307222651.2106615-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch meson-12-common.dtsi to use the Meson G12A specific UART
compatible string. This enables the "divide XTAL by 2" divider which
improves support for UART attached Bluetooth modules (for example
RTL8822CS) running at a baud rate of 1500000. Without dividing XTAL
(24MHz) by 2 a baud rate of 1500000 cannot be generated cleanly and the
resulting jitter breaks communication with the module.

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Greg, please don't take this through your tree. I included this patch
to show the overall goal of this series. If Neil won't take this as
part of another series then I'll send it separately.

Changes from v1 -> v2:
- keep meson-gx-uart as fallback compatible string

Changes from v2 -> v3:
- none


 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 123a56f7f818..904bcd4d2acf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2046,7 +2046,8 @@ pwm_AO_cd: pwm@2000 {
 			};
 
 			uart_AO: serial@3000 {
-				compatible = "amlogic,meson-gx-uart",
+				compatible = "amlogic,meson-g12a-uart",
+					     "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
@@ -2056,7 +2057,8 @@ uart_AO: serial@3000 {
 			};
 
 			uart_AO_B: serial@4000 {
-				compatible = "amlogic,meson-gx-uart",
+				compatible = "amlogic,meson-g12a-uart",
+					     "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x4000 0x0 0x18>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
@@ -2293,7 +2295,8 @@ clk_msr: clock-measure@18000 {
 			};
 
 			uart_C: serial@22000 {
-				compatible = "amlogic,meson-gx-uart";
+				compatible = "amlogic,meson-g12a-uart",
+					     "amlogic,meson-gx-uart";
 				reg = <0x0 0x22000 0x0 0x18>;
 				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
@@ -2302,7 +2305,8 @@ uart_C: serial@22000 {
 			};
 
 			uart_B: serial@23000 {
-				compatible = "amlogic,meson-gx-uart";
+				compatible = "amlogic,meson-g12a-uart",
+					     "amlogic,meson-gx-uart";
 				reg = <0x0 0x23000 0x0 0x18>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
@@ -2311,7 +2315,8 @@ uart_B: serial@23000 {
 			};
 
 			uart_A: serial@24000 {
-				compatible = "amlogic,meson-gx-uart";
+				compatible = "amlogic,meson-g12a-uart",
+					     "amlogic,meson-gx-uart";
 				reg = <0x0 0x24000 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
-- 
2.39.2

