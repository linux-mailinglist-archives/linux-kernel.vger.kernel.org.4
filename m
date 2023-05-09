Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6085E6FCF22
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjEIUKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEIUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:10:01 -0400
X-Greylist: delayed 560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 13:10:00 PDT
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 841CACF;
        Tue,  9 May 2023 13:10:00 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 03D5741D13BF;
        Tue,  9 May 2023 21:00:38 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Tue, 09 May 2023 21:00:38 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Liviu Dudau <liviu@dudau.co.uk>
Subject: [PATCH] mips: dts: ralink: Clarify usage of MT7621 ethernet phy arguments
Date:   Tue,  9 May 2023 21:00:32 +0100
Message-Id: <20230509200032.308934-1-liviu@dudau.co.uk>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree uses numbers as arguments to the phys property that are
confusing for newcomers. Define names for the values and use them in the
device tree.

Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 7caed0d14f11a..1c584b6d0e1fa 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -4,6 +4,9 @@
 #include <dt-bindings/clock/mt7621-clk.h>
 #include <dt-bindings/reset/mt7621-reset.h>
 
+#define DUAL_PORT   1
+#define SINGLE_PORT 0
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -455,7 +458,7 @@ pcie@0,0 {
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&sysc MT7621_RST_PCIE0>;
 			clocks = <&sysc MT7621_CLK_PCIE0>;
-			phys = <&pcie0_phy 1>;
+			phys = <&pcie0_phy DUAL_PORT>;
 			phy-names = "pcie-phy0";
 			ranges;
 		};
@@ -470,7 +473,7 @@ pcie@1,0 {
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&sysc MT7621_RST_PCIE1>;
 			clocks = <&sysc MT7621_CLK_PCIE1>;
-			phys = <&pcie0_phy 1>;
+			phys = <&pcie0_phy DUAL_PORT>;
 			phy-names = "pcie-phy1";
 			ranges;
 		};
@@ -485,7 +488,7 @@ pcie@2,0 {
 			interrupt-map = <0 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&sysc MT7621_RST_PCIE2>;
 			clocks = <&sysc MT7621_CLK_PCIE2>;
-			phys = <&pcie2_phy 0>;
+			phys = <&pcie2_phy SINGLE_PORT>;
 			phy-names = "pcie-phy2";
 			ranges;
 		};
-- 
2.40.0

