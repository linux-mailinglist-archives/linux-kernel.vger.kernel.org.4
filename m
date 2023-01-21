Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371296767D5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAUR5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:57:21 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28B52685B;
        Sat, 21 Jan 2023 09:57:14 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso3789318pju.0;
        Sat, 21 Jan 2023 09:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeFLuKFYHtqMsL9Q04zNeAzUIoUCJnJf6k6CUesWfq4=;
        b=pDY7lwMY986ChQ8HScW2+zLReDVZwRRACA7C62xlDbgz4uTsE/iTgjsoNINU9aQDcI
         bS1flQbH1VDhkxrhfrCkA4QgN/rETQ7idnalXvyfXFcFm6jZNTLiNbCa1OGTOrqWfb4t
         1UhZEUaU70wCJ3ae9bYW8+E9bk4L63i+nJV/lvg8Rj4+B7ZYmCnpE5uSWsPSIo3XwD5r
         qeZOprVfCVnuN7ElJKcEr6jwDpCX/RoCc8rFMakOy9TeGAUX7sgS/cAHt3QoNDOkG8r0
         Q5TRtfIDSly/1V7UzlpzogAeEA/ifBAOAEss0G1fP17o1EverbouZIIQwDwmoH0vAkWR
         go+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeFLuKFYHtqMsL9Q04zNeAzUIoUCJnJf6k6CUesWfq4=;
        b=ArJZNHsUiQZ+fPckPel/K9w7lpytJczckS/CdFTu/Y/OLli+XFj6gNFEvRqWSmfuJv
         5EQZXDhzYZz+Ebb/C44Iq+0zNdhHcto2XN/yP1KW2Mq2WbmQJ/ZT/6QzCH6RFhFTeMoV
         Y1KwTVobr7PyiMetoefM0hLQDuUlUiiepAycIzOSgnTJOgfsSJ1TMGl1TehDdbiGUIdw
         uCiYlxmQLp7RssZyC5aANB1NLkxteJnrJ+A3AbVcEjXfPhsi0bSp+WhO3LdxSxO2IZJa
         XJ+oqGIF8HHxm0SCwYqqqca3L2/oxJDyX6pNf+gN+vLyhug2yOCPmR4Nb6uuBHhb2aZS
         D+uA==
X-Gm-Message-State: AFqh2kq3sTCqtOAxJYUBtMRWIxg6JDa9F8o2q55JMvFWcPlcDquYI/mV
        qjvaMd5OR3HLSyScjHOqWiE=
X-Google-Smtp-Source: AMrXdXvhKACefD0Rs3Ee7VDiXlFCw3qo0/2fF51ymAE0AMqX52lzeqxWKVPWjOdDMIjMbBD+t1Ra5g==
X-Received: by 2002:a05:6a21:6d8c:b0:b1:e8da:d5bc with SMTP id wl12-20020a056a216d8c00b000b1e8dad5bcmr25436775pzb.56.1674323834267;
        Sat, 21 Jan 2023 09:57:14 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id r3-20020a632b03000000b00478e14e6e76sm24857374pgr.32.2023.01.21.09.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 09:57:13 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] arm64: dts: amlogic: Used onboard usb hub reset on odroid c2
Date:   Sat, 21 Jan 2023 17:56:31 +0000
Message-Id: <20230121175639.12818-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121175639.12818-1-linux.amoon@gmail.com>
References: <20230121175639.12818-1-linux.amoon@gmail.com>
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

On Odroid c2 previously use gpio-hog to reset the usb hub,
switch to used on-board usb hub reset to enable the usb hub
and enable power to hub.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3 - Add rev by Neil.
     droped dr_mode
v2 - drop the vendor name from compatible string.
   - move the hub node to USB controller node.
   - drop the usb_otg_pwr since it only liked to OTG port
         and link p5v0 to the vdd-supply.
---
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 201596247fd9..70b10934a811 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -250,21 +250,6 @@ eth_phy0: ethernet-phy@0 {
 	};
 };
 
-&gpio_ao {
-	/*
-	 * WARNING: The USB Hub on the Odroid-C2 needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	hog-0 {
-		gpio-hog;
-		gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
-	};
-};
-
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
@@ -414,5 +399,15 @@ &usb0 {
 };
 
 &usb1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
+
+	hub@1 {
+		/* Genesys Logic GL852G USB 2.0 hub */
+		compatible = "usb5e3,610";
+		reg = <1>;
+		vdd-supply = <&p5v0>;
+		reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+	};
 };
-- 
2.38.1

