Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41FA5BDBA4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiITE0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiITE0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:26:23 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6929558F9;
        Mon, 19 Sep 2022 21:26:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c198so1562644pfc.13;
        Mon, 19 Sep 2022 21:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uVqkXrKh/BOL72z7RBz/jXCRaf0wbeq1TN40XiN2ST0=;
        b=H7mdcLBDJJDfrxDeMtiv1gAHhc5Y2zNKH7rxB7L+cveN7GFkfxN8M2aNCkirA8GhXW
         Ld3PRMtg4mssDLcXHoQuSbuy6is2/3kYaa9XOZUu1cH244uF5CRW1y0L7m9B0BSevky0
         DQBGpm2omE6vdTc60XiHsonxzCyL3VYzjKgeAZsEgcWsXk/wmT4t3OOUBF2gWF9HjykU
         FWCfho+uCzumfXk0mlQNO4NstAZWFG/sgbtt61dye+6EkRe8I3GfZHZzpCg66i3ykxZX
         6dXf5PNzXHUA1M+65bNIijKbc+NL3oahfccTZt+30DNUyywpcj2KC12r317P+3Oyb8fk
         yK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uVqkXrKh/BOL72z7RBz/jXCRaf0wbeq1TN40XiN2ST0=;
        b=TOnAEWI8l4Bs3pNq3lepS+jdYQXgiseAOqgxUa/d5QH368xcobbXpwytFmb09WAluu
         3A9yfrhJF1SsjlHzXaHznLy8mp2uQzckjhgCNZzsI2zpTRZUPSqGP0M9b7oVfEUTH0Oq
         oOUUISq9wLcpBQ2F5c6GmYUKEa89ls29MYHW8+kym0fngZPQUTU05sgdXaUifeRK8+dT
         F/nD8jZaWKNIf5yAanPw48r5WTU+E2p28ltwG6jUqI9Hshaa6Sqn9jJ6DBT09fpoangr
         XuH7tJq/lJjgDaPSDa23PR2NH24zG55+Nm6s4gaFaMGsk0dLvUHzOeVbJB1VtsKQCDg/
         VMow==
X-Gm-Message-State: ACrzQf2AyFiH8+79bJh918voHsOfLl+j4fUbSWyPcBivS2sZrh2n1vyF
        4nf4luLjsPlskwU4b0rNsgo=
X-Google-Smtp-Source: AMsMyM6weMjGDsVYFkcghzfNlMx4UQ6aeMIYIS6GGO8IPN7xgqg7/XhpJJz54LI2DSqMInhnpw23wA==
X-Received: by 2002:a63:9041:0:b0:438:8ed0:8470 with SMTP id a62-20020a639041000000b004388ed08470mr17979059pge.25.1663647972762;
        Mon, 19 Sep 2022 21:26:12 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:b095:5d5d:4c28:8088])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a024f00b001fab208523esm337518pje.3.2022.09.19.21.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 21:26:12 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-input@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: dts: imx6qdl-sabre*: fix Egalax touchscreen properties
Date:   Mon, 19 Sep 2022 21:26:05 -0700
Message-Id: <20220920042608.1865560-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes interrupt trigger (should be level low as that is what the
driver is always using), the GPIO that is the interrupt source that is also
used to wake up chip by driving the line low.

The proper polarity is be needed for converting the driver to gpiod API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++--
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 1368a4762037..1883350d004e 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -451,8 +451,8 @@ touchscreen@4 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_egalax_int>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
-		wakeup-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
+		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 37482a9023fc..09f4c2fa3ad6 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -311,8 +311,8 @@ touchscreen@4 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2c2_egalax_int>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
-		wakeup-gpios = <&gpio6 8 GPIO_ACTIVE_HIGH>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-gpios = <&gpio6 8 GPIO_ACTIVE_LOW>;
 	};
 
 	ov5640: camera@3c {
@@ -450,8 +450,8 @@ egalax_ts@4 {
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <7 2>;
-		wakeup-gpios = <&gpio6 7 0>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-gpios = <&gpio6 7 GPIO_ACTIVE_LOW>;
 	};
 
 	magnetometer@e {
-- 
2.37.3.968.ga6b4b080e4-goog

