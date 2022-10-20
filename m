Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB60605A08
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJTIjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiJTIjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:39:06 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF249A222C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:39:05 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E7721410DB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666255139;
        bh=1Kfa+smO/072OiY7RMhUCYjDWimk98jjl4qxZmAFPfQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=coFcX/WF+vF370oJ4m++4XtBJT7JnNLCatERUGs/TNaXLSuWKXY6v5nfDsDruQr8p
         0qdhxh+2MzDl+uefpHTkAxWiBfO9wClgocsH57v1HzVdJo8VRtlpns4mCxW31PCMhf
         hM6/E+KVRaiQRtHeMhxgXLb2ghUahkydp1ApSPoH7Ia5LHg9QesQ9eF5lWkAS8WN0u
         aTXqaOt0dEHTGfS02KPA3klU85yh+lFBjRqYZsiNtDnBqux2gv9rNtbopjr4/RUkpL
         GF4XgUxBBLOJamj40P94obaTQ6tqYrohsSjK1igLrjOEdteA1WB5hi+k+Ns6dLMvsT
         VDnYLvSYrDTHA==
Received: by mail-qt1-f198.google.com with SMTP id a19-20020a05622a02d300b0039a3711179dso14470944qtx.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Kfa+smO/072OiY7RMhUCYjDWimk98jjl4qxZmAFPfQ=;
        b=oGlbUqOHgN7nsjcTvJGoy2WFLlPa80omWg3VQMVY279Ka+22A6hdouoOA6044kRiT9
         XotXqLYIA/52RIKDQT65VGTgdZBb9Ob0aUFjqPxK/C5612EXyRFBWS5xTsTho9JFpAC0
         IIih1OwTfxUU0mAAmZdT6uyvyAA6LYKwXbbiJA+tEB9pJIAKWZwGG7w5fmUHkS7Twu88
         6CuQH6Wh5hnpcAQ692Hc2skj7ssSps6bw8z0nGmfHF8/lhu52IieLaEJ0AXK9HOCf1k6
         oMdTbv7r5wB7NfBCeDXkV0JtsLCTLTJlFjdnh0yt4eq1ZWj7lmjIj1+GM2Q6pftAu07P
         HsCg==
X-Gm-Message-State: ACrzQf3O8+EsW9gUnpzKh3Ux8yd5J3q2ufE0yBrufovdjxFNcA4c+Up0
        JfI5UcCt3LcOaqkOqilht0qn9SXLsIfKjLZpgakW6HQw9eIMrWVQoBWNIDcHinNtjouPa+cH52f
        5mzcxgIRz6PDsnkxdCTcUXXG/VoE9tNQlXHagfO/dmg==
X-Received: by 2002:a05:622a:14d4:b0:39c:fe54:1cc6 with SMTP id u20-20020a05622a14d400b0039cfe541cc6mr5290224qtx.88.1666255139049;
        Thu, 20 Oct 2022 01:38:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5yISX1K+NROiNXKggPZO0oyltRGu4SNeg/ZNORfA01oA/O6xEKKposra24ZeKHoPZE0T7Caw==
X-Received: by 2002:a05:622a:14d4:b0:39c:fe54:1cc6 with SMTP id u20-20020a05622a14d400b0039cfe541cc6mr5290217qtx.88.1666255138842;
        Thu, 20 Oct 2022 01:38:58 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id h14-20020ac8568e000000b0039913d588fbsm5733905qta.48.2022.10.20.01.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 01:38:58 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] riscv: dts: icicle: Add GPIO controlled LEDs
Date:   Thu, 20 Oct 2022 10:38:54 +0200
Message-Id: <20221020083854.1127643-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the 4 GPIO controlled LEDs to the Microchip PolarFire-SoC
Icicle Kit device tree. The schematic doesn't specify any special
function for the LEDs, so they're added here without any default
triggers and named led1, led2, led3 and led4 just like in the schematic.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../boot/dts/microchip/mpfs-icicle-kit.dts    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index ec7b7c2a3ce2..11ba4417f11a 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -5,6 +5,8 @@
 
 #include "mpfs.dtsi"
 #include "mpfs-icicle-kit-fabric.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 /* Clock frequency (in Hz) of the rtcclk */
 #define RTCCLK_FREQ		1000000
@@ -31,6 +33,34 @@ cpus {
 		timebase-frequency = <RTCCLK_FREQ>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led-1 {
+			gpios = <&gpio2 16 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led1";
+		};
+
+		led-2 {
+			gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led2";
+		};
+
+		led-3 {
+			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led3";
+		};
+
+		led-4 {
+			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led4";
+		};
+	};
+
 	ddrc_cache_lo: memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x40000000>;
-- 
2.37.2

