Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD95BBB61
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIRDo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIRDof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:44:35 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574D7BF3;
        Sat, 17 Sep 2022 20:44:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 60F8C320099B;
        Sat, 17 Sep 2022 23:44:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 17 Sep 2022 23:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxfierke.com;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663472668; x=
        1663559068; bh=KClnUgpSB5TTDjqxQM0igKzyFFsjQyuOhd5Znxb2oQc=; b=5
        AHwV8xCT3AtMlwVBkCBKbtuRe+uPVBroMMGW/H+/sHC0PFAxay6usum2JG2zg8CH
        bIultPUSE9Dc2pRRGbw7L4rX8VZumQpgRWGWLCAdQZPMMkXg7LJB4zUbnyj4Emvn
        vpa/8q9S5+qcVOfj6nuodVZ3WjakDfLcVwqIZRNhi9dGBzc91Ms9NdonGTJFkQ7h
        qiLuWkxrVeSJ4nLGMIk+5YircM5YXy91wta7rwB0E9RPJtV9kmFqlMuSo5nnmyRc
        UO54qin1KF91yN8N0+2TFqPK0jWUGii1KXLqCkqcP9sFxQOGJ78Mg5OS9C4HseMn
        4nqlNKb5tNu8Ye/Zi+oeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1663472668; x=1663559068; bh=KClnUgpSB5TTD
        jqxQM0igKzyFFsjQyuOhd5Znxb2oQc=; b=CyyZgH/wwo1TgobORPSNOhxT1R6pg
        9wcNKvaT3kVcsAgAc1sLkcKHQVZCCNfsJFRzp8g+yxNKb51aVjj0F21YvrJPi9j4
        psmUMPCQmZErhq99zdji34DETTMivk2XPpXvD4jar2lCOLeuK3QFMZ1AZ9OwJkDR
        +IbmI93zNuIEVt1khwr/ZUYZtKeWhSYrBMlHHMzBe5MkTSiYyNnekZericBnHJBX
        vKTzCvGS5+eYPlQ/7ok/vKtISzYrCn2g9JnuPvpkVdVjA0fB45b6J6GxD1QNJNIk
        qmGsWiCaTs1X+mvz1VtT9ERiHdQ5r/IlqFJ6VZ4oh2iDO5lbxJB7lFJgg==
X-ME-Sender: <xms:HJQmY_QSDfnc33FewSdO7hdPhaqN8G82qgt5bc5eJh67n538KaMRCg>
    <xme:HJQmYwxmfiJSBupvQzUUq-d8D8hLgsFDPWUvyKoVfnBQDnv43KM9LgAEl3ow0yBE5
    vCgCz4wKiA865e4LQs>
X-ME-Received: <xmr:HJQmY02T8LHfTSbaqGN9W6hodFqOOAgxlZBmD6Fib3GKG3QGN930PTQfBU78zmIYAtdQbsarlfUDLlBZyBRQ7wFzIKvLRXrxUzrNIN7BghDFsNOIoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvfedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgicu
    hfhivghrkhgvuceomhgrgiesmhgrgihfihgvrhhkvgdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeeugffhgfejkeefhfeugeelgfegteeijeehheffhfektdeuffehheelvddvkeef
    necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigsehmrgigfhhivghrkhgvrdgt
    ohhm
X-ME-Proxy: <xmx:HJQmY_BRpb0jSjUHm5RAgDxo-Y5Zt7ykHcsUQgcmirCwelyz6HBwnw>
    <xmx:HJQmY4hHhSzgMhqg6midXmCEcvhBS5Ptk1B7_jbUVhl3ZgqfIhbKkw>
    <xmx:HJQmYzpBShUFULHj3FklZoaoTANDZkwQAdgaSQbvDd_FAH22mlJqzg>
    <xmx:HJQmY3Tc7dtSsfyxYRD2WnLJZfROyRvNjaWRjTE85kmCZ9VTiOrhtg>
Feedback-ID: idee9475d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Sep 2022 23:44:27 -0400 (EDT)
From:   Max Fierke <max@maxfierke.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Fierke <max@maxfierke.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/4] dt-bindings: display: Add ClockworkPi CWD686 panel
Date:   Sat, 17 Sep 2022 22:44:13 -0500
Message-Id: <20220918034415.74641-3-max@maxfierke.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220918034415.74641-1-max@maxfierke.com>
References: <20220918034415.74641-1-max@maxfierke.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CWD686 is a 6.86" IPS LCD panel used as the primary
display in the ClockworkPi DevTerm portable (all cores)

Signed-off-by: Max Fierke <max@maxfierke.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3 (Krzysztof Kozlowski's Suggestions)
 - add missing lines for spacing

Changes in v2 (Krzysztof Kozlowski and Rob Herring's Suggestions)
 - remove redundant backlight example
 - add missing regulators

 .../display/panel/clockworkpi,cwd686.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml b/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml
new file mode 100644
index 000000000000..936e353f25e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/clockworkpi,cwd686.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ClockworkPi CWD686 6.86" IPS LCD panel
+
+maintainers:
+  - Max Fierke <max@maxfierke.com>
+
+description: |
+  The ClockworkPi CWD686 is a 6.86" ICNL9707-based IPS LCD panel used within the
+  ClockworkPi DevTerm series of portable devices. The panel has a 480x1280
+  resolution and uses 24 bit RGB per pixel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: clockworkpi,cwd686
+
+  reg:
+    description: DSI virtual channel used by that screen
+    maxItems: 1
+
+  iovcc-supply:
+    description: regulator that supplies the iovcc voltage
+
+  vci-supply:
+    description: regulator that supplies the vci voltage
+
+  reset-gpios: true
+  rotation: true
+  backlight: true
+
+required:
+  - compatible
+  - reg
+  - backlight
+  - reset-gpios
+  - iovcc-supply
+  - vci-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "clockworkpi,cwd686";
+            reg = <0>;
+            backlight = <&backlight>;
+            reset-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
+            rotation = <90>;
+            iovcc-supply = <&vcc_1v8>;
+            vci-supply = <&vcc3v3_sys>;
+        };
+    };
-- 
2.37.2
