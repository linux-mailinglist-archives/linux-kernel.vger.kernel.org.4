Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93B2645EDA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiLGQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiLGQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:25:11 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A57866C9D;
        Wed,  7 Dec 2022 08:25:02 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 8174540005;
        Wed,  7 Dec 2022 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670430300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TihRoOIIlvWBr2aPxHY68KFlI34LyysIMIjsTZJBegk=;
        b=phliuoeEnzcMaOBgjmn0khKUXd4Djca6HtKn0flaBs1Z31VbhoSX3XyE6mTOmR/wMf6Or/
        a8p4cKEXfV5j/sVaLi3qWaZfPkLRQGT79MDKzBJ9mqwcNXaNKGZRKDvbRE3H4yaL1RBL+3
        00UTbiYc95oNwMbnAdPHvZzqLsVw25wkU2uWQKI6zIypiqcRHEQRGZiuif4jI0Ug6yI1Tq
        OYl6jO/Lv3LvrBXBh1Hdjdt+OValFF5qz2pp3v084/Dhq2MRj3C7LBV3aclBOILbv0iOFG
        bsHD4BQledwST/XCg4TktGIovxj7AHMrONeOmWNWWM7nr0igSwbYmw/plXsJzw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 8/9] ARM: dts: r9a06g032: Add the USBF controller node
Date:   Wed,  7 Dec 2022 17:24:34 +0100
Message-Id: <20221207162435.1001782-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207162435.1001782-1-herve.codina@bootlin.com>
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USBF controller available in the r9a06g032 SoC.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 401c88bcdd51..d3c459537dbb 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -117,6 +117,19 @@ dmamux: dma-router@a0 {
 			};
 		};
 
+		udc: usb@4001e000 {
+			compatible = "renesas,r9a06g032-usbf", "renesas,rzn1-usbf";
+			reg = <0x4001e000 0x2000>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysctrl R9A06G032_HCLK_USBF>,
+				 <&sysctrl R9A06G032_HCLK_USBPM>;
+			clock-names = "hclkf", "hclkpm";
+			power-domains = <&sysctrl>;
+			depends-on = <&sysctrl>;
+			status = "disabled";
+		};
+
 		pci_usb: pci@40030000 {
 			compatible = "renesas,pci-r9a06g032", "renesas,pci-rzn1";
 			device_type = "pci";
-- 
2.38.1

