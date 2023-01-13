Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8A66A5BD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjAMWLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjAMWLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:11:12 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16426B598;
        Fri, 13 Jan 2023 14:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Y/z2c+U+yZ8a6/4g+++TbaCiP4JUH3QavrzL1WFbDPM=; b=OxohLw1/XhLpArkAWBTSE68XvB
        h+yR5nTUA3+bPyupKM96EEM6Fb2Od6Al+oPG3a6BUhKZE2OJ7Qar+kZIgY/fu+gz2EaDxTGpBiENd
        IGUWpBMemkbLTGjlJRb2PcB89TayqHh58a45IFyqAjNCGSzI8yzBVVpAJ8mEkEt8HIWcmSwYPrsZ+
        VsY7kCAup3kngzMIX5tQjYE4tUzLmjc7Mo4TK9VJhM+enqrq2LQTEav2dp28u3IiNqO9kjMbitTOw
        iHIvkcDElFddCvmIR1tqUvxX9bU73kx9lfAU3snFGf2xmpJkvFNIBXqe3nrqZ3hg0sG6cyuXyDPwz
        w8juByMw==;
Received: from p200300ccff089e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:9e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pGSGM-0005ID-9Z; Fri, 13 Jan 2023 23:11:02 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pGSGL-009ssD-L9; Fri, 13 Jan 2023 23:11:01 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: omap: gta04: add BNO055 IMU chip
Date:   Fri, 13 Jan 2023 23:10:58 +0100
Message-Id: <20230113221058.2355840-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is finally a driver upstreamed, so add the
device.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index 0b5bd7388877..4f56f7fc0d1b 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -75,6 +75,11 @@ OMAP3_CORE1_IOPAD(0x2138, PIN_INPUT | MUX_MODE4) /* gpin114 */
 		>;
 	};
 
+	bno050_pins: pinmux-bno050-pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x2136, PIN_INPUT | MUX_MODE4) /* gpin113 */
+		>;
+	};
 };
 
 /*
@@ -136,4 +141,13 @@ bme280@76 {
 		vdda-supply = <&vio>;
 		vddd-supply = <&vio>;
 	};
+
+	bno055@29 {
+		compatible = "bosch,bno055";
+		reg = <0x29>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bno050_pins>;
+		/* interrupt at &gpio4 17 */
+	};
+
 };
-- 
2.30.2

