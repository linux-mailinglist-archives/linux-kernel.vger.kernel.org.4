Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090FA652D20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiLUHCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUHCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:02:42 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CE81F60D;
        Tue, 20 Dec 2022 23:02:41 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so1281853pjj.2;
        Tue, 20 Dec 2022 23:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iLhpvJLe8wUwjMWhjGdcbiLSvV4O6C2uFJ++EfmUmG8=;
        b=ZWhyIykfGczTmN7iY79uBrF+cj5WfVjL/MKp0+3TaG2jXVOlJvJ9e92gGZ4MWjw6of
         l9dpblwzn3TABsiiuhvmhoU3UlbaT9+l6LkP7UdpMxtWPzbr8QOMYjDbrD+U943p3lHi
         VqF/NCLdFt0peRCyMJSqQKFotKsMQxwTUHFndN4f3Y7RojjP9Z8mKTVXec/K995fzOzR
         CqgzaaN5qxydD+A/doTMb+RyoxvQhVpfYbb74Y+xBZSN34kzZDc0QmhKXaPlvI98Izax
         yYu1kI4AS5AX+AlPteOCp2AAZDyDO1Vo1QHkONUOSINTR2ndBL+rokF+KMg1N9tky34C
         8MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLhpvJLe8wUwjMWhjGdcbiLSvV4O6C2uFJ++EfmUmG8=;
        b=UYU3i9n8uTlrYHBMjps4ApTYN/9l/11hyIRf8rtpjwXzzu79GL3Uds2DNVHwOAhdFA
         H6RjHiqoo7WIeDC9X+LyyJVvjZsuHRXJP4vFZn8/yBopztIRtQcPu6T75VIWOcxSB8Mb
         JJ2ARUwzI4MV96+7YdppX0EztKPo09zdAHeHKnfjTDfm/XDe3QEfO7RAnUAg7rxiYlc0
         tPJIZmJN4IFHOkWWc0sMycHrbE1e0Rpju6NuUk48mD85nAaw7P2WUAKUrOGaKf1BLDYI
         DGwJtkHRNdqboqiVf6f0NW5g3+QI/1YYufcXxvCTGe3Vq/rKOKrOJBtXnw+aFm5g6oDW
         zv1g==
X-Gm-Message-State: AFqh2krSucJ/9GureOOjkf/bgduUhPn5KI4L9fXHoufIYTCYfcCLsQq2
        3ib5UfzbNnZrBmto5txABwbbLqzBN4Iz0zkt
X-Google-Smtp-Source: AMrXdXtuhzounO8Sea7pU0k8a4F9jEl+j9/DmNWNDZTp4WEhskn10OkAmn5yVWLpiVhqsY8RSI3iww==
X-Received: by 2002:a05:6a20:12ca:b0:ab:e8a7:6137 with SMTP id v10-20020a056a2012ca00b000abe8a76137mr1634889pzg.3.1671606161142;
        Tue, 20 Dec 2022 23:02:41 -0800 (PST)
Received: from localhost.localdomain ([117.189.239.185])
        by smtp.gmail.com with ESMTPSA id q20-20020a631f54000000b00476c2180dbcsm9134146pgm.29.2022.12.20.23.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 23:02:40 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH 2/2] dt-bindings: leds: backlight: add binding for Kinetic KTZ8866 backlight
Date:   Wed, 21 Dec 2022 15:02:16 +0800
Message-Id: <20221221070216.17850-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the Kinetic KTZ8866 backlight driver.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 .../leds/backlight/kinetic,ktz8866.yaml       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
new file mode 100644
index 000000000000..7286c3fc7f5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic Technologies KTZ8866 backlight
+
+maintainers:
+  - Jianhua Lu <lujianhua000@gmail.com>
+
+description: |
+  The Kinetic Technologies KTZ8866 is a high efficiency 6-sinks led backlight
+  with dual lcd bias power.
+  https://www.kinet-ic.com/ktz8866/
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    items:
+      const: kinetic,ktz8866
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    backlight {
+        compatible = "kinetic,ktz8866";
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&bl_en_default>;
+    };
-- 
2.38.2

