Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6283B733204
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345575AbjFPNSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345495AbjFPNSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:18:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B0C2D76;
        Fri, 16 Jun 2023 06:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A05DC617C2;
        Fri, 16 Jun 2023 13:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577A2C433CC;
        Fri, 16 Jun 2023 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686921527;
        bh=ky7P3RtqcOUivRrABeRZDfxDG7HLEb0fst/3IVa0vkk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=G9wMzkPR/PSyqmXP/c9CA1bVeChhXCXnNWwj6MLfNF8LbMm/dqACsJo6eemmQ4hNs
         4cX58CyC5X6WTQ/YUG5zbB3dmqB5/7oI/lsElDnImMID9EavDoNJBp248Dtw3dOdGu
         0QTh7zPyZCoK7IdVA3SyT8WZKzgiGGOa1dWzzMcGk8gw9KtpdalKBRFB4386XbhNA3
         hXVIO8TYEp7boV0w8rfTsm6bBqM29gJDMO1RNB97zUUUBmZ91fpe3zKJYNsY0pdj9U
         kWMPiAkTLJPOVMLrBz1VPAJNpKDDJRAdgwVFWBJ+UCc6HMja+6p5R7Anj5b82GOysx
         GUy0nF+MCsnwA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 16 Jun 2023 15:18:40 +0200
Subject: [PATCH 2/3] ARM: dts: lan966x: kontron-d10: fix SPI CS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230616-feature-d10-dt-cleanups-v1-2-50dd0452b8fe@kernel.org>
References: <20230616-feature-d10-dt-cleanups-v1-0-50dd0452b8fe@kernel.org>
In-Reply-To: <20230616-feature-d10-dt-cleanups-v1-0-50dd0452b8fe@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl node was missing which change the pin mux to GPIO mode.
Add it so we don't have to rely on the bootloader to set the correct
mode.

Fixes: 79d83b3a458e ("ARM: dts: lan966x: add basic Kontron KSwitch D10 support")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
index f86e2e751403..2e16217ac88e 100644
--- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
@@ -41,7 +41,7 @@ &flx3 {
 	status = "okay";
 
 	spi3: spi@400 {
-		pinctrl-0 = <&fc3_b_pins>;
+		pinctrl-0 = <&fc3_b_pins>, <&spi3_cs_pins>;
 		pinctrl-names = "default";
 		status = "okay";
 		cs-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
@@ -79,6 +79,12 @@ sgpio_b_pins: sgpio-b-pins {
 		function = "sgpio_b";
 	};
 
+	spi3_cs_pins: spi3-cs-pins {
+		/* CS# */
+		pins = "GPIO_46";
+		function = "gpio";
+	};
+
 	usart0_pins: usart0-pins {
 		/* RXD, TXD */
 		pins = "GPIO_25", "GPIO_26";

-- 
2.30.2

