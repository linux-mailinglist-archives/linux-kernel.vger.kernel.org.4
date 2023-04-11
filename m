Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0506DE1B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDKRAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjDKRAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:00:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86B061B1;
        Tue, 11 Apr 2023 09:59:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kt17so9901323ejb.11;
        Tue, 11 Apr 2023 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681232394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=grPBE8/AW9duwaajeZP7b+dDjiUP9gDZ3cyS7x0Oihs=;
        b=pWToz4U61+BWTGI5jLpq8P1+fo6sLD5Mc/Gm+nUGDHeZB85cL9TEcmjA71LiSsFhWM
         /LE6IZuzJQVl5jhgetzdMZH0EU1tw1CcVSH16vrzAH+2koLWvj3uQDowXRoNcslhclGR
         zIiSC3z5m208ODU+CkmFwNhve/hRTfUQVFsc4b4D2C7wst4Og4uuCwfntHCIgvznFWWi
         NcAiRG0zJDETKSze5g2tJ8GH0IxnRjGSRy84eHTCIQ+0CI+NeUECNUfTF4L5JdBlf6FD
         sF9R2Cz8dpCc8byPfs9qG8vfK8RMARjxOpIVSvoZAEQ7ejIsDlDajiG12WHq4wV1smGf
         jLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grPBE8/AW9duwaajeZP7b+dDjiUP9gDZ3cyS7x0Oihs=;
        b=bjU6KwLx70L9Dow0F5+Dljr8NukrSG4+1pfgDWOAEeI5zxFSkKVelMgB3mUZEuk45W
         hdSpnJtv0t8LWfSv88Rlg0Dalz3N83cvlj1S84EmJHfSf4gK2GCPlxAmwJLhrwYAbG3C
         I2CNMP08YcvTzpqN4CL+QywUw0Yy3RYCU+EY1AXD8nHvyKE3Xod52l79leHxZkSOtzaH
         jfnjnriT+Endp2w+M0anTe9+g8iCkvpPpJW6GlE/jHo7tH48nPS8xGFZmsFFmYJgf0mo
         Jm4VNC5WmV4wURoUNjnL9/zdYQTJN5GC9meqAxfDmsYoCedxkDwtsy89A0DQ3FgYWo+C
         mZiw==
X-Gm-Message-State: AAQBX9fU+jkE8Fpa5PvY3MjaSclowvMqxj2egRL72FQBnTD3Izxy++wD
        bFPSlSRpjMJ+VgD4/X3KCX1gX7cbPUwZgg==
X-Google-Smtp-Source: AKy350YDB905MTox0+gR/vwMshE99CJuQWK4JRRs7QS7l3CVsR5xDfIoYdMawlatVJnqlwj601ICVA==
X-Received: by 2002:a17:906:3093:b0:932:20a5:5b with SMTP id 19-20020a170906309300b0093220a5005bmr8752336ejv.23.1681232394200;
        Tue, 11 Apr 2023 09:59:54 -0700 (PDT)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id m9-20020a170906848900b00947a97a42f2sm6337870ejx.103.2023.04.11.09.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 09:59:53 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH v3 1/2] dt-bindings: sound: ep93xx: Add I2S description
Date:   Tue, 11 Apr 2023 18:59:50 +0200
Message-Id: <20230411165951.2335899-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Cirrus Logic EP93xx internal SoCs' I2S
controller.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v3:
- rebased onto
 https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
v2:
 - Incorporated most of the suggestions from Krzysztof Kozlowski [1]
 - Dropped AC97 (deleted from the tree)

[1]. https://lore.kernel.org/lkml/46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org/

 .../bindings/sound/cirrus,ep9301-i2s.yaml     | 66 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
new file mode 100644
index 000000000000..453d493c941f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,ep9301-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus EP93xx I2S Controller
+
+description: |
+  The I2S controller is used to stream serial audio data between the external
+  I2S CODECs’, ADCs/DACs, and the ARM Core. The controller supports I2S, Left-
+  and Right-Justified DSP formats.
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: cirrus,ep9301-i2s
+
+  '#sound-dai-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: sclk
+      - const: lrclk
+
+required:
+  - compatible
+  - '#sound-dai-cells'
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    i2s: i2s@80820000 {
+        compatible = "cirrus,ep9301-i2s";
+        #sound-dai-cells = <0>;
+        reg = <0x80820000 0x100>;
+        interrupt-parent = <&vic1>;
+        interrupts = <28>;
+        clocks = <&syscon 29>,
+                 <&syscon 30>,
+                 <&syscon 31>;
+        clock-names = "mclk", "sclk", "lrclk";
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e52938f962b5..b39ec6dbcdc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2072,6 +2072,7 @@ M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/cirrus,ep9301-adc.yaml
+F:	Documentation/devicetree/bindings/sound/cirrus,ep9301-*
 F:	arch/arm/boot/compressed/misc-ep93xx.h
 F:	arch/arm/mach-ep93xx/
 F:	drivers/iio/adc/ep93xx_adc.c
-- 
2.40.0

