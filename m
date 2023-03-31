Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53026D1579
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 04:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCaCKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 22:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCaCI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:08:28 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4A0191FC;
        Thu, 30 Mar 2023 19:06:50 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17786581fe1so21771975fac.10;
        Thu, 30 Mar 2023 19:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680228410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pvM334uaDN62u5CXBwDPRhi1Ml5Rc/k9LOkZNPsfO9U=;
        b=OUha1buX9Iya3CjbsVobPGHSOMWmpDrZzKS4TD3RmS+O87YOx/sthAzdlI6Mpq6c2x
         uSD9IFLRH4VFtCWCAxURoqL0IG4NSpM4EueoLgGiZTipQjByWnk4Qo/h02rFOlYOzGsM
         HSviKdKTOdMu8KOcJV4AD4hZJS4OPmpsBKvppGrEIYPVUu0b3QX5IoLc4OzGLkHSwBx5
         rT2xr3XB3hifVhNdNG0LwszasFVR9vR7eO/1p+cHFUJwYkK7XNnRsDcsn/WFhbO959yU
         O5C8Uf+LWjM4gkF1CM4NBLcbFgJPAWMudClmTTablSrajbt1Bc3O7TLUL7Z9qyEmrDTy
         fyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680228410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvM334uaDN62u5CXBwDPRhi1Ml5Rc/k9LOkZNPsfO9U=;
        b=ePyoJ+/rt0DdLust3fJWH77JtSzlyrxWCZekCtxBReL7hVv3NQLqMNKESc7m8laNIS
         RQhVHZ9i2t2jegzkAqZV/RDV4uXFG8igWoWUlMmm3E2klFPzl5H2kVSyKSZK9i9irLCU
         wW0B28hvR7WhBROiyJnYuW7JPv6hFrDF6IO8Vpbur06bo2jLv4ZokqUomhb4q3276am4
         fdOv+TgRGkqvAUyuQqL0rRnkMs4SfO45447MA5VELOvZeZaWFCws4z5c8OlCom4Gb/2K
         qR/ySoVpLb3xCa5A05zlp9smXIAnHkHfuP072eL30iPkxU7ORaqHzn7RRXwUX+ZWNO0h
         2plg==
X-Gm-Message-State: AO0yUKWL65QAfPmSuCLEdTp08rA5y5/1MOumC3qWIVh3gaynWItQBh07
        fR775FKbMO6KLZ4otXLtSjY=
X-Google-Smtp-Source: AK7set9SVdoBv4Z6z/5U2LbxssB3wFAqZk8t0GCibw/+1rXEmQsRBHijgZAq1yj9AKxTzVChxWYNVA==
X-Received: by 2002:a05:6870:3396:b0:177:c4c1:db8a with SMTP id w22-20020a056870339600b00177c4c1db8amr15470422oae.0.1680228409807;
        Thu, 30 Mar 2023 19:06:49 -0700 (PDT)
Received: from heimdal.localdomain ([2804:431:cfec:20b3:d050:3c82:2c34:f704])
        by smtp.gmail.com with ESMTPSA id yv2-20020a05687c228200b0016e8726f0d4sm548177oab.3.2023.03.30.19.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 19:06:49 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Morishita?= <andremorishita@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        anish kumar <yesanishhere@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        daniel.baluta@nxp.com,
        =?UTF-8?q?Andr=C3=A9=20Morishita?= <andremorishita@gmail.com>
Subject: [PATCH] dt-bindings: maxim,max98371: Convert to DT schema
Date:   Thu, 30 Mar 2023 23:05:25 -0300
Message-Id: <20230331020527.482991-1-andremorishita@gmail.com>
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

Convert the Maxim Integrated MAX98371 audio codec bindings to DT schema.

Signed-off-by: André Morishita <andremorishita@gmail.com>
---
 .../devicetree/bindings/sound/max98371.txt    | 17 --------
 .../bindings/sound/maxim,max98371.yaml        | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/max98371.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98371.yaml

diff --git a/Documentation/devicetree/bindings/sound/max98371.txt b/Documentation/devicetree/bindings/sound/max98371.txt
deleted file mode 100644
index 8b2b2704b574..000000000000
--- a/Documentation/devicetree/bindings/sound/max98371.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-max98371 codec
-
-This device supports I2C mode only.
-
-Required properties:
-
-- compatible : "maxim,max98371"
-- reg : The chip select number on the I2C bus
-
-Example:
-
-&i2c {
-	max98371: max98371@31 {
-		compatible = "maxim,max98371";
-		reg = <0x31>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98371.yaml b/Documentation/devicetree/bindings/sound/maxim,max98371.yaml
new file mode 100644
index 000000000000..df0262473399
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98371.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98371.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX98371 audio codec
+
+maintainers:
+  - anish kumar <yesanishhere@gmail.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: maxim,max98371
+
+  '#sound-dai-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        max98371: max98371@31 {
+            compatible = "maxim,max98371";
+            reg = <0x31>;
+        };
+    };
-- 
2.40.0

