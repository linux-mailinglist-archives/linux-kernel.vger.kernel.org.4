Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DB165EFFE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjAEPXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjAEPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:23:31 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104BB3B8;
        Thu,  5 Jan 2023 07:23:28 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 9E266E000F;
        Thu,  5 Jan 2023 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672932207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XZGzN6U94HSP89ZNNAnrWGSBdM0wzp3qncg9eLddvc=;
        b=amAWC3T9BuhRJoO5ih+I6nAecTLOQfdf5mntC2V7L2lV6DoIMU65HcIy/QtLAVcf9A/gpO
        tJoOU8nxDaTs4RhSbmtamxOKEev8gR+FfBb/MYsUCKOVIm48yUUyiC+AJut7XgU+Jc61/K
        i8j/dSthr0JkUngXAIqyba3zc+RqkE22LddISLSInghX1sGgsWu+FCW+QuIAp9offw7r2a
        kKNRgWOndxrlxCkg6FDrUjppoA07hMCj0urTOT2ZdL/SqNxBrHNdDpQs3+d2/a8BS7KVqy
        zcF1cNNWaPBV7WgzQ6A5cVTsnW0I9KKygJDvEiCKDOQs6AHU2k7+UAZr+tm+1g==
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
Subject: [PATCH v5 4/5] ARM: dts: r9a06g032: Add the USBF controller node
Date:   Thu,  5 Jan 2023 16:22:56 +0100
Message-Id: <20230105152257.310642-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230105152257.310642-1-herve.codina@bootlin.com>
References: <20230105152257.310642-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USBF controller available in the r9a06g032 SoC.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 41e19c0986ce..0fa565a1c3ad 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -117,6 +117,18 @@ dmamux: dma-router@a0 {
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
+			status = "disabled";
+		};
+
 		pci_usb: pci@40030000 {
 			compatible = "renesas,pci-r9a06g032", "renesas,pci-rzn1";
 			device_type = "pci";
-- 
2.38.1

