Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8487E627C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiKNLTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiKNLRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:17:43 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA77642F;
        Mon, 14 Nov 2022 03:15:46 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 5B6656000C;
        Mon, 14 Nov 2022 11:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668424545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYstxmdNtV0DeBo1GgQhNnu+wwgOyx92wB5h3OanKjQ=;
        b=iYfs0GspcSL/oZR9hBwKvjRL/aofXnsZv0D8tL9PKvBAkedd3BP2tipjpYKZ8ZcqedIfPS
        ubAh2ow1hxzDi5bnQc9fAQefWcc/15okuV0tAlB86OUXSA8kjWdzoVHLQof8n15sMwNg/r
        aLqXwaBBop+rZYyOMeGtIqayHtOoMLQlcdQPznloln0Sur0EPS/oWNUZgOT8ahlwn7PHTl
        Kv+5CvNo4nAyhnfyUJu8UYyRlCWsQP/82TJiqmv00/TI8R7sr2EP8A2P0DZ2iISqn1VhEK
        51hZnSwM/CCdp/DTkonmbXtTbmciCSA1SBxjNXIBaCXg8Bi8N+qiMHNGFsXBCg==
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
Subject: [PATCH v2 6/7] ARM: dts: r9a06g032: Add the USBF controller node
Date:   Mon, 14 Nov 2022 12:15:12 +0100
Message-Id: <20221114111513.1436165-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114111513.1436165-1-herve.codina@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
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

