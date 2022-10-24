Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04623609B72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJXHgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJXHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:36:43 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6404B53A44;
        Mon, 24 Oct 2022 00:36:42 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout4.routing.net (Postfix) with ESMTP id 96266100617;
        Mon, 24 Oct 2022 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666597000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ts+p85/BqXRyImfUTVqMY6V4o9A9GbTrAg9y9bk+otQ=;
        b=Bnzo/dMhZ3ru0VkT0cM0etoLr3plkBArLkdwePcVuOL7x6I4KeSfAl3yc/OiJghhc9NQlI
        wIugidlFkNMwYl9F5xj4W69mBS8FhI2kJn9MwzbUg6oGKau+XTi4PUIuamUf9fDEGki6/L
        zDrqGUMyAwGMLOesf6ueaMQku1QYuZo=
Received: from frank-G5.. (fttx-pool-80.245.75.40.bambit.de [80.245.75.40])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id A2D534069D;
        Mon, 24 Oct 2022 07:36:39 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: update uart/mmc bindings for MT7986 SoC
Date:   Mon, 24 Oct 2022 09:36:34 +0200
Message-Id: <20221024073634.6834-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 8d57070a-1742-43ea-bca5-77937089cb9f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add new splitted uart pins and emmc_51.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index 89b8f3dd67a1..d5ab5e08badc 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -87,6 +87,8 @@ patternProperties:
           "wifi_led"        "led"       1, 2
           "i2c"             "i2c"       3, 4
           "uart1_0"         "uart"      7, 8, 9, 10
+          "uart1_rx_tx"     "uart"      42, 43
+          "uart1_cts_rts"   "uart"      44, 45
           "pcie_clk"        "pcie"      9
           "pcie_wake"       "pcie"      10
           "spi1_0"          "spi"       11, 12, 13, 14
@@ -98,9 +100,11 @@ patternProperties:
           "emmc_45"         "emmc"      22, 23, 24, 25, 26, 27, 28, 29, 30,
                                         31, 32
           "spi1_1"          "spi"       23, 24, 25, 26
-          "uart1_2"         "uart"      29, 30, 31, 32
+          "uart1_2_rx_tx"   "uart"      29, 30
+          "uart1_2_cts_rts" "uart"      31, 32
           "uart1_1"         "uart"      23, 24, 25, 26
-          "uart2_0"         "uart"      29, 30, 31, 32
+          "uart2_0_rx_tx"   "uart"      29, 30
+          "uart2_0_cts_rts" "uart"      31, 32
           "spi0"            "spi"       33, 34, 35, 36
           "spi0_wp_hold"    "spi"       37, 38
           "uart1_3_rx_tx"   "uart"      35, 36
@@ -157,7 +161,7 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [emmc, emmc_rst]
+                  enum: [emmc, emmc_rst, emmc_51]
           - if:
               properties:
                 function:
@@ -221,8 +225,9 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [uart1_0, uart1_1, uart1_2, uart1_3_rx_tx,
-                         uart1_3_cts_rts, uart2_0, uart2_1, uart0, uart1, uart2]
+                  enum: [uart1_0, uart1_rx_tx, uart1_cts_rts, uart1_1, uart1_2_rx_tx, uart1_2_cts_rts,
+                         uart1_3_rx_tx, uart1_3_cts_rts, uart2_0_rx_tx, uart2_0_cts_rts, uart2_1, uart0,
+                         uart1, uart2]
           - if:
               properties:
                 function:
-- 
2.34.1

