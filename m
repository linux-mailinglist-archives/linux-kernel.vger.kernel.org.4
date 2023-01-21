Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC966767DE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjAUR6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjAUR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:58:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CCD1353A;
        Sat, 21 Jan 2023 09:57:41 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so11043592pjq.0;
        Sat, 21 Jan 2023 09:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upFXHM11fb8yyn8//u4LSFSs+SLvgplDwfC/Z4GzEYs=;
        b=G/niI8tNgy0IBZ45FMpgN9Cg0vU6UMRJC+qgcOkXOl2tZnhL2C1yqOW4EcWnazNiJh
         iZBus2mj8G0dZKDV100wor82NE05Yi4TpBAmomdVAR8rcz8BS+0QqY6oJ0LJ5Ax2vq/a
         /hswCL1e6YO2wuNB5uIr+pk7kNbO2Ff2CDQZr0G9JMA5NbaKXRvb8ca2YFRvnrlhR4qr
         bdDKCqSV78mFdGGHR/qMn2NolU9zfn2YkbApyXVX72Tcur77K7AZ2JW40Jheg0njvbYm
         ekIXvKsdgiJ68buXJ99N2cwPMUtXr6+AeQDygBNCyXkVVhtQyD/kSrnWEYLmjT9hB4lz
         CEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upFXHM11fb8yyn8//u4LSFSs+SLvgplDwfC/Z4GzEYs=;
        b=OcyHIFCW1x4Civ7uLRGLb5sk9uvmd58aZxRTWk+PmIbjA5RGgyPtmzldt38QuFdIbt
         aSdHR4OwboI3shKSIJ1KQyi5NRD888lOrpL++3GmK5sZR4fS1W856hMJgslsdqpXcL+W
         4nyng9Y2gINvLTvipDLtUYC/MxMZIYdfLKJgNLBsYh+fFfoEbvFFsdObHyRqBOTmTX+K
         W/EqepIolIUNv+vfL1vIfmUP9+sWhldobTcBIRxX5ISOgMPg+I6YvKmP+Wx+bpEdX/o8
         4HJohFqoZSabPtuGHv/ZyyDL8f8/NMW2Uc6Rxr5QXJvqPUslmAgBfo2i3cw8bS6Pw0n6
         PJTA==
X-Gm-Message-State: AFqh2koDxcwFvFbCPjBComL1SOuBQS3uWhcet68x/tXBRhUFVuuHyRu4
        HVYeLFng9/f/46iHXdL1NRQWHUL9Lh8=
X-Google-Smtp-Source: AMrXdXuo12QaVYDgvO1xmkU+zpACLfQxEe1cvQTovdbHbEVM3OfIwnNKEqoK0HGMEIyZk6bK+Ppktw==
X-Received: by 2002:a05:6a20:2a15:b0:ac:f68:d0f8 with SMTP id e21-20020a056a202a1500b000ac0f68d0f8mr15681592pzh.23.1674323860897;
        Sat, 21 Jan 2023 09:57:40 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id r3-20020a632b03000000b00478e14e6e76sm24857374pgr.32.2023.01.21.09.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 09:57:40 -0800 (PST)
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
Subject: [PATCH v3 7/9] arm64: dts: amlogic: Used onboard usb hub reset on odroid c4
Date:   Sat, 21 Jan 2023 17:56:35 +0000
Message-Id: <20230121175639.12818-8-linux.amoon@gmail.com>
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

On Odroid c4 previously use gpio-hog to reset the usb hub,
switch to used on-board usb hub reset to enable the usb hub
and enable power to hub.

USB hub is combination of USB 2.0 and USB 3.0 root hub so
use peer-hub node to link then.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: - move the usb hub under dwc3 node.
      dropped dr_mode
v2: - fix the compatible string.
    - Fix the hub node to use peer-hub to link the usb 2.0 and usb 3.0.
---
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 33 ++++++++++++-------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
index 8c30ce63686e..a988015dd2d5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
@@ -28,18 +28,27 @@ sound {
 	};
 };
 
-&gpio {
-	/*
-	 * WARNING: The USB Hub on the Odroid-C4 needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	hog-0 {
-		gpio-hog;
-		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
+&dwc3 {
+	/* USB hub supports both USB 2.0 and USB 3.0 root hub */
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	hub_2_0: hub@1 {
+		compatible = "usb2109,2817";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&vcc_5v>;
+	};
+
+	/* 3.1 hub on port 4 */
+	hub_3_0: hub@2 {
+		compatible = "usb2109,817";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&vcc_5v>;
 	};
 };
 
-- 
2.38.1

