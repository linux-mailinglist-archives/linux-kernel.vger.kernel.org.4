Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658EF5B5829
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiILKWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiILKWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:22:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1334B1D0E2;
        Mon, 12 Sep 2022 03:22:36 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:15b7:c21a:ebde:697f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A810B6601FD9;
        Mon, 12 Sep 2022 11:22:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1662978154;
        bh=4t/XUuL71nfnkxkqLTpBpCc+gWpno7guyXSI4xSqhog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgAczKwaVkGAXA5QBZNK9w+1P59t7XnxlQpsHjoIV+CRbwNtg9xDGYwfgnjzOIn8B
         xZZhd2/03vXfnNMSheUY6puOF9WpsxKeiu5gTncqENrolNkEgRNE3q6Fmtk362j4DG
         yL9+uhtgmCdj10Dr7lYrKGx/MkmWxioMy2jwTff9Jhq+mDfz6pYH4YayR408d55rbm
         Ey8eGegGbpx8SNN5SBpHn8k6ocr1xPUwfGzX229jUkiJdy4YV4KbGHod0owk8g3vGI
         hNiWyB5trNqvda8rrDegyS99wfEBPLlFCitXZRsKxlTq37rnvRG3gmqyFygpTVdin2
         qBqzyG90zwcIw==
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] dt-bindings: gpio: pca95xx: add entry for pcal6534 and PI4IOE5V6534Q
Date:   Mon, 12 Sep 2022 11:22:19 +0100
Message-Id: <20220912102223.1050418-2-martyn.welch@collabora.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220912102223.1050418-1-martyn.welch@collabora.co.uk>
References: <20220912102223.1050418-1-martyn.welch@collabora.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martyn Welch <martyn.welch@collabora.com>

The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the PCAL6524. The
Diodes PI4IOE5V6534Q is a functionally identical chip provided by Diodes
Inc.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

Changes in v2:
 - Enumerate pi4ioe5v6534q as requiring pcal6534 fallback

Changes in v3:
 - Corrected indentation

 .../bindings/gpio/gpio-pca95xx.yaml           | 98 ++++++++++---------
 1 file changed, 52 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
index 977b14db09b0..3f7139bca50c 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
@@ -15,52 +15,58 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - exar,xra1202
-      - maxim,max7310
-      - maxim,max7312
-      - maxim,max7313
-      - maxim,max7315
-      - maxim,max7319
-      - maxim,max7320
-      - maxim,max7321
-      - maxim,max7322
-      - maxim,max7323
-      - maxim,max7324
-      - maxim,max7325
-      - maxim,max7326
-      - maxim,max7327
-      - nxp,pca6408
-      - nxp,pca6416
-      - nxp,pca9505
-      - nxp,pca9506
-      - nxp,pca9534
-      - nxp,pca9535
-      - nxp,pca9536
-      - nxp,pca9537
-      - nxp,pca9538
-      - nxp,pca9539
-      - nxp,pca9554
-      - nxp,pca9555
-      - nxp,pca9556
-      - nxp,pca9557
-      - nxp,pca9574
-      - nxp,pca9575
-      - nxp,pca9698
-      - nxp,pcal6416
-      - nxp,pcal6524
-      - nxp,pcal9535
-      - nxp,pcal9554b
-      - nxp,pcal9555a
-      - onnn,cat9554
-      - onnn,pca9654
-      - ti,pca6107
-      - ti,pca9536
-      - ti,tca6408
-      - ti,tca6416
-      - ti,tca6424
-      - ti,tca9539
-      - ti,tca9554
+    oneOf:
+      - items:
+          - const: diodes,pi4ioe5v6534q
+          - const: nxp,pcal6534
+      - items:
+          - enum:
+            - exar,xra1202
+            - maxim,max7310
+            - maxim,max7312
+            - maxim,max7313
+            - maxim,max7315
+            - maxim,max7319
+            - maxim,max7320
+            - maxim,max7321
+            - maxim,max7322
+            - maxim,max7323
+            - maxim,max7324
+            - maxim,max7325
+            - maxim,max7326
+            - maxim,max7327
+            - nxp,pca6408
+            - nxp,pca6416
+            - nxp,pca9505
+            - nxp,pca9506
+            - nxp,pca9534
+            - nxp,pca9535
+            - nxp,pca9536
+            - nxp,pca9537
+            - nxp,pca9538
+            - nxp,pca9539
+            - nxp,pca9554
+            - nxp,pca9555
+            - nxp,pca9556
+            - nxp,pca9557
+            - nxp,pca9574
+            - nxp,pca9575
+            - nxp,pca9698
+            - nxp,pcal6416
+            - nxp,pcal6524
+            - nxp,pcal6534
+            - nxp,pcal9535
+            - nxp,pcal9554b
+            - nxp,pcal9555a
+            - onnn,cat9554
+            - onnn,pca9654
+            - ti,pca6107
+            - ti,pca9536
+            - ti,tca6408
+            - ti,tca6416
+            - ti,tca6424
+            - ti,tca9539
+            - ti,tca9554
 
   reg:
     maxItems: 1
-- 
2.35.1

