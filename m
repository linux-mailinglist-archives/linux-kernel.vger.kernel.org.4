Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AD164B64F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiLMNdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbiLMNdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:33:33 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AC11A80B;
        Tue, 13 Dec 2022 05:33:25 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 61B0B4000A;
        Tue, 13 Dec 2022 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670938404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzhTUTPRHyIacSgREWImoiDYM8NXVOZGD2z2nUMacwI=;
        b=Nj43dL5qObjhhCcvvSrEfXtbSr6tkdEvlE9FTrUvWzQVizHIROkvAu9JhrNYVE66aja/TO
        oagrqrxwfGxfzT1F2gRTeZKNR2M4RPOvaq/gsBamMpRW25pMtb9VLx7Zv/wLk5yPuNhODB
        9t1p32yIVE7hhtYoou5u5TyyAZ3s9guM7rYOFK+r+BGlikOEfYVKISxzZVAzKxLI++d8V+
        1x5JB7e/HL4lAyHG9U0ZGHDJkX39nLe+1KShlNdA1wkK/1QlqJWRu6i+g/1j1iJceTi3Np
        5nTvdZhXYxvn3XavYmSFyKLzlHSWT1yUZRLFSg29nYXA4TPFCK6MLvdi5OPTow==
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
Subject: [PATCH v4 4/5] ARM: dts: r9a06g032: Add the USBF controller node
Date:   Tue, 13 Dec 2022 14:33:01 +0100
Message-Id: <20221213133302.218955-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221213133302.218955-1-herve.codina@bootlin.com>
References: <20221213133302.218955-1-herve.codina@bootlin.com>
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
index 563024c9a4ae..a4bb069457a3 100644
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

