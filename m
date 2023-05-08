Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A6E6FB107
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjEHNOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjEHNO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:14:29 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB89C86A2;
        Mon,  8 May 2023 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683551668;
  x=1715087668;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TtHpwat9GIEkB+1blW10QNVbCuv3L2YzA9AyRKP7Tts=;
  b=hYvACVQw1Ff2L+FCnhACMQ6eC3lf1rXy8ZqkrVeOXHDVOhZf7Q+PLwyD
   DQXbPRePuTsIZElypBJ9rQuLobWWAyfOl88+lw5Ijju0Xhu5T2f7JZo6c
   Rt4dYU9+pXFyQGkXE36vMK2Z8Z+p70lL2D5KlJSA5eEOrtNjN6H9yUhiw
   mvEnAo/K4lZ8wlLczpieRiSEqo2MH0Ck6UIU7NBvy/GDu7oMbHFTCDecS
   vdTSefXzvIZxiHz/auDqO1Ngoxybbh/3Y+w/cJoourzaUOWP5IAMFKzJp
   CLJ52EIIBYTAB/VAiDmusVa03BIeBOhMMuYSf0wvmQy/p6VGPifGxnapy
   w==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Mon, 8 May 2023 15:14:07 +0200
Subject: [PATCH v3 1/2] regulator: dt-bindings: Add bindings for TPS6287x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230502-tps6287x-driver-v3-1-e25140a023f5@axis.com>
References: <20230502-tps6287x-driver-v3-0-e25140a023f5@axis.com>
In-Reply-To: <20230502-tps6287x-driver-v3-0-e25140a023f5@axis.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683551664; l=1676;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=KARdrRBkfobsUPZuEvNegZELY7vBi0k9NmejXd4gaFw=;
 b=nyLrWgIMZg9mzlaoZyM0bh+lRW/6/OZxjEGHU1urwrHpvGEMIVsSJbSlT+POd41G1AbONnto2
 x3LDXeAXzndDGZzgkCnMOojZ0z8hwCykgBw6InCf1JV3R3EJlAwaQ7s
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the TPS62870/TPS62871/TPS62872/TPS62873 voltage
regulators.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 .../devicetree/bindings/regulator/ti,tps62870.yaml | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
new file mode 100644
index 000000000000..386989544dac
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/ti,tps62870.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TPS62870/TPS62871/TPS62872/TPS62873 voltage regulator
+
+maintainers:
+  - Mårten Lindahl <marten.lindahl@axis.com>
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,tps62870
+      - ti,tps62871
+      - ti,tps62872
+      - ti,tps62873
+
+  reg:
+    maxItems: 1
+
+  regulator-initial-mode:
+    enum: [ 1, 2 ]
+    description: 1 - Forced PWM mode, 2 - Low power mode
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulator@41 {
+        compatible = "ti,tps62873";
+        reg = <0x41>;
+        regulator-name = "+0.75V";
+        regulator-min-microvolt = <400000>;
+        regulator-max-microvolt = <1675000>;
+        regulator-initial-mode = <1>;
+      };
+    };
+
+...

-- 
2.30.2

