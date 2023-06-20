Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B16736419
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjFTHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFTHMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:12:03 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A844BCC;
        Tue, 20 Jun 2023 00:11:22 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Tue, 20 Jun 2023
 15:11:09 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH] dt-bindings: interrupt-controller: New binding for Meson-C3 SoCs
Date:   Tue, 20 Jun 2023 15:08:49 +0800
Message-ID: <20230620070849.2059451-1-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update dt-binding document for GPIO interrupt controller of Meson-C3 SoCs

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
---
 .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index bde63f8f090e..fdea0488a98c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -19,6 +19,7 @@ Required properties:
     "amlogic,meson-sm1-gpio-intc" for SM1 SoCs (S905D3, S905X3, S905Y3)
     "amlogic,meson-a1-gpio-intc" for A1 SoCs (A113L)
     "amlogic,meson-s4-gpio-intc" for S4 SoCs (S802X2, S905Y4, S805X2G, S905W2)
+    "amlogic,meson-c3-gpio-intc" for C3 SoCs (C308L, C302X)
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.37.1

