Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0C75B84DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiINJWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiINJVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:21:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01982742;
        Wed, 14 Sep 2022 02:11:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so33120030ejb.13;
        Wed, 14 Sep 2022 02:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FG85OJtSMqVkntZUzAMmCxoRInDwAAoB7LIdaCx+6jo=;
        b=kDgeSKN3Va30caiOyYiFGW/Ma0vOsc5SVTxE6kBNMOxsqdks41a3IGw3gxsb77i3mK
         s6QeMVljIfyzsa/o8nwa+phA8JR3Fi7IQgbmd6P6Hw4M5ehz5+SDOEQVAt2aYDfz2s61
         KYXfVVNNCHMix8lKgwSQkgCQvQ71hJgEG33GhBLhBWMlCPZKI/DMhR7GZtvN8cXn3Wcs
         TvIyK/DRsPT2fGHPUC1SPa3UTHF4xMOPv3q+LcdWiYSo4GAhRYPiq0/3xBM+fem8L/TM
         YgFZ2xNyBoD4QHcc0qLrDHFDtpmZxdTFBg7GBFIDlQqt1Pxs4Dj8lJPeytuErjPN3V2Q
         uC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FG85OJtSMqVkntZUzAMmCxoRInDwAAoB7LIdaCx+6jo=;
        b=ElZfZJirfaGC/K41hfsV6tLxXoXY7hA3e6s4BlIIEADqDmOKckViP5Jeve0vJiBHDp
         ZlIzjghb6bpSx3qf12NLywfUBSdXHRJEPKpj3r7cqfzdKXKYZfmP2wtELESnzYdt887N
         Vd1sWrX51D6wi8eSls3qDBbpPxOQlpjaCx8BikpXgRLx5Y/vGNaPmov0ddSdOogo/m7H
         q8upQSnCt6d2rSjo80+zYBP0qKmsfYwbiHwXE1ZSZyWeQDChpR6lSGwSkDomhSYIBKIg
         jg35D4GOdX6+fOzEWSHBcXZDnNCTzMlZ+xMwhirukvvPpP8/+VFVamDg+edq+cffajs0
         LaSw==
X-Gm-Message-State: ACgBeo0aiI2erbPvs7E+MnSQKqQHxz4KCJbC+jfcB/z5mQaVDEX6flAR
        OOs3DaLyjjcOqFbShIwerFc=
X-Google-Smtp-Source: AA6agR513nM0QW+iAtMw730fZTdzlHDjx+lEHPAs117mk9weM+KJz0wmmcjnMU/yPMS3imNNcF3IOQ==
X-Received: by 2002:a17:906:a0d3:b0:73d:be5b:2b52 with SMTP id bh19-20020a170906a0d300b0073dbe5b2b52mr25534262ejb.727.1663146650125;
        Wed, 14 Sep 2022 02:10:50 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906314800b0077c52b512bcsm5475702eje.86.2022.09.14.02.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 02:10:49 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] mips: bmips: bcm63268: add TWD block binding
Date:   Wed, 14 Sep 2022 11:10:45 +0200
Message-Id: <20220914091045.29488-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

TWD is an MFD block that contains timers, watchdog & some clocks / reset
controller.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
It's the same patch as in the
[PATCH RFC RFT] mips: bmips: bcm63268: add TWD block binding
(sent back in January)
---
 arch/mips/boot/dts/brcm/bcm63268.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm63268.dtsi b/arch/mips/boot/dts/brcm/bcm63268.dtsi
index c3ce49ec675f..8926417a8fbc 100644
--- a/arch/mips/boot/dts/brcm/bcm63268.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm63268.dtsi
@@ -105,14 +105,20 @@ periph_intc: interrupt-controller@10000020 {
 			interrupts = <2>, <3>;
 		};
 
-		wdt: watchdog@1000009c {
-			compatible = "brcm,bcm7038-wdt";
-			reg = <0x1000009c 0xc>;
+		timer-mfd@10000080 {
+			compatible = "brcm,bcm7038-twd", "simple-mfd", "syscon";
+			reg = <0x10000080 0x30>;
+			ranges = <0x0 0x10000080 0x30>;
 
-			clocks = <&periph_osc>;
-			clock-names = "refclk";
+			wdt: watchdog@1c {
+				compatible = "brcm,bcm7038-wdt";
+				reg = <0x1c 0xc>;
 
-			timeout-sec = <30>;
+				clocks = <&periph_osc>;
+				clock-names = "refclk";
+
+				timeout-sec = <30>;
+			};
 		};
 
 		uart0: serial@10000180 {
-- 
2.34.1

