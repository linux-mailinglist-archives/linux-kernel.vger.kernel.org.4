Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70C26D10C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjC3VW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjC3VWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:22:52 -0400
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75106EC65
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:22:33 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 16376 invoked from network); 30 Mar 2023 23:22:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1680211350; bh=g79xrgthvXz8TMVzNGmKJWY+SfQKcMDZEm7G845GCSs=;
          h=From:To:Cc:Subject;
          b=tKUuYOJ4uTF3QEtkkjklmSkFfjQAwCbQld0iozVXIgU2AKL4tmcymwbXeATDKnB9j
           ukKJL+KxZCZwrFT2SGiqPQ/XnV2EZOe6OproNgwQSN1yOQW/D32KpnIB1xiXp5qo1y
           NJnHRDqnhuxMqKQBkHhNKbR7XOHlZ50kGYB05Eu8=
Received: from 79.184.247.17.ipv4.supernova.orange.pl (HELO LAPTOP-OLEK.home) (olek2@wp.pl@[79.184.247.17])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linus.walleij@linaro.org>; 30 Mar 2023 23:22:30 +0200
From:   Aleksander Jan Bajkowski <olek2@wp.pl>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH 2/2] dt-bindings: pinctrl: xway: drop the deprecated compatible strings
Date:   Thu, 30 Mar 2023 23:22:25 +0200
Message-Id: <20230330212225.10214-2-olek2@wp.pl>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230330212225.10214-1-olek2@wp.pl>
References: <20230330212225.10214-1-olek2@wp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: 541786faf83a8cda9f91d4ae700c2945
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [gZNE]                               
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code are marked as deprecated since kernel 4.5[1]. Downstream OpenWRT
and upstream switched to the new string compatible 7 years ago. The old
compatible strings can safely be dropped.

[1] commit be14811c03cf ("pinctrl/lantiq: introduce new dedicated devicetree bindings")

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 .../bindings/pinctrl/lantiq,pinctrl-xway.txt  | 35 +------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt b/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
index 4658f105fa09..6bd9bc61becb 100644
--- a/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
+++ b/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
@@ -1,11 +1,7 @@
 Lantiq XWAY pinmux controller
 
 Required properties:
-- compatible: "lantiq,pinctrl-xway", (DEPRECATED: Use "lantiq,pinctrl-danube")
-	      "lantiq,pinctrl-xr9", (DEPRECATED: Use "lantiq,xrx100-pinctrl" or
-					"lantiq,xrx200-pinctrl")
-	      "lantiq,pinctrl-ase", (DEPRECATED: Use "lantiq,ase-pinctrl")
-	      "lantiq,<chip>-pinctrl", where <chip> is:
+- compatible:	"lantiq,<chip>-pinctrl", where <chip> is:
 		"ase" (XWAY AMAZON Family)
 		"danube" (XWAY DANUBE Family)
 		"xrx100" (XWAY xRX100 Family)
@@ -45,29 +41,6 @@ Required subnode-properties:
 
 Valid values for group and function names:
 
-XWAY: (DEPRECATED: Use DANUBE)
-  mux groups:
-    exin0, exin1, exin2, jtag, ebu a23, ebu a24, ebu a25, ebu clk, ebu cs1,
-    ebu wait, nand ale, nand cs1, nand cle, spi, spi_cs1, spi_cs2, spi_cs3,
-    spi_cs4, spi_cs5, spi_cs6, asc0, asc0 cts rts, stp, nmi, gpt1, gpt2,
-    gpt3, clkout0, clkout1, clkout2, clkout3, gnt1, gnt2, gnt3, req1, req2,
-    req3
-
-  functions:
-    spi, asc, cgu, jtag, exin, stp, gpt, nmi, pci, ebu
-
-XR9: ( DEPRECATED: Use xRX100/xRX200)
-  mux groups:
-    exin0, exin1, exin2, exin3, exin4, jtag, ebu a23, ebu a24, ebu a25,
-    ebu clk, ebu cs1, ebu wait, nand ale, nand cs1, nand cle, nand rdy,
-    nand rd, spi, spi_cs1, spi_cs2, spi_cs3, spi_cs4, spi_cs5, spi_cs6,
-    asc0, asc0 cts rts, stp, nmi, gpt1, gpt2, gpt3, clkout0, clkout1,
-    clkout2, clkout3, gnt1, gnt2, gnt3, gnt4, req1, req2, req3, req4, mdio,
-    gphy0 led0, gphy0 led1, gphy0 led2, gphy1 led0, gphy1 led1, gphy1 led2
-
-  functions:
-    spi, asc, cgu, jtag, exin, stp, gpt, nmi, pci, ebu, mdio, gphy
-
 AMAZON:
   mux groups:
     exin0, exin1, exin2, jtag, spi_di, spi_do, spi_clk, spi_cs1, spi_cs2,
@@ -139,12 +112,6 @@ Optional subnode-properties:
     0: none, 1: down, 2: up.
 - lantiq,open-drain: Boolean, enables open-drain on the defined pin.
 
-Valid values for XWAY pin names: (DEPRECATED: Use DANUBE)
-  Pinconf pins can be referenced via the names io0-io31.
-
-Valid values for XR9 pin names: (DEPRECATED: Use xrX100/xRX200)
-  Pinconf pins can be referenced via the names io0-io55.
-
 Valid values for AMAZON pin names:
   Pinconf pins can be referenced via the names io0-io31.
 
-- 
2.30.2

