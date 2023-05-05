Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD8F6F8412
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjEENaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjEENau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:30:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC6F1C0DA;
        Fri,  5 May 2023 06:30:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aaf21bb42bso12088745ad.2;
        Fri, 05 May 2023 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683293449; x=1685885449;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7jCr7W/FI3aFXYPnC0hqNFeny2rAOk/VL+jdI5ieBk=;
        b=FdSmeTr1tdaMdcTKYwHAy5czhxIDodmH++ULQd8fwCqvjhBDJV4nzDqgE4wkIS5VQY
         1GuvqsSIQoiPf9ANBdpotVCgefREYblbUczW8PJIePj74iUQc7lCkgdXFt5z2wcW0HrM
         /TRh+go4t6Ji/XeEqPMSLbGKMEmqKz3LIeGR8cQKslcY10u+PK3pZu2/tCFfhPUNRQDP
         4AQNGVpw6KSvATSIe3h1U0khbhg0gLIvD9iZFwA1vxfeRoHPn/+wCg+6ezx0NxSCZA78
         lc70OpH05PXKtTFOLFj4YQzlZB09LkMz1g1nlgWZCu+84QR0WCziCFrR6AmR7qJQ2Hm+
         StGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683293449; x=1685885449;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7jCr7W/FI3aFXYPnC0hqNFeny2rAOk/VL+jdI5ieBk=;
        b=jfroXHJEq4JyAwO4hAe3oQZmTDG52ccDL+EoCM4U/2MNbTrWC/eV7N3uQGAn1QKFeh
         6EflLmrN992l253MIvKG0U1iiU77Yp9Wg1tB3y96pEjp/MlYGfZT+kMBk45OTgUrB1kM
         hevbdOHYOvLcRhryRQ83PgPVjA9hwdwKlSK4Yi++jVweziEQdc2VbhFHXc0y/yNJ/zym
         I/JN4OSP58SWSnwq8wlSVJQ+Lr1d4IZSklxUequQ0I31ANHm6smVz/cmv2ek43f7dCPi
         kjDww00SXj8WgKJsYvnfP2ZDZ2BpeqBl09TPimbxCRemOF693Q8opkcbrR5b3br5aSQf
         Jptg==
X-Gm-Message-State: AC+VfDxRbVVCT+H7S//rclGtTN9nsAQLcNdM3cATSE86EUrkTmEujBAu
        JGjS71vxEzBKvftT9GnZIxODqX4U9o7M9ibD
X-Google-Smtp-Source: ACHHUZ6YTKLwPCN7D+WAoHB+acEnPplFDn5bF7gYSisfHLgidWRPNl9QzYULSdm4gLahQ3+1dHO7Ew==
X-Received: by 2002:a17:90a:128e:b0:24d:eb30:daa6 with SMTP id g14-20020a17090a128e00b0024deb30daa6mr1369608pja.40.1683293448677;
        Fri, 05 May 2023 06:30:48 -0700 (PDT)
Received: from yoga ([202.131.133.155])
        by smtp.gmail.com with ESMTPSA id iq14-20020a17090afb4e00b0024df400a9e6sm9771850pjb.37.2023.05.05.06.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 06:30:48 -0700 (PDT)
Date:   Fri, 5 May 2023 19:00:42 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: rt1016: Convert to dtschema
Message-ID: <ZFUFAmBJXvkQAG7m@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the RT1016 Stereo Audio Amplifier bindings to DT schema

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../bindings/sound/realtek,rt1016.yaml        | 40 +++++++++++++++++++
 .../devicetree/bindings/sound/rt1016.txt      | 17 --------
 2 files changed, 40 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt1016.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt1016.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt1016.yaml b/Documentation/devicetree/bindings/sound/realtek,rt1016.yaml
new file mode 100644
index 000000000000..5287e9c9197e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt1016.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt1016.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Reaktek RT1016 Stereo Class D Audio Amplifier
+
+maintainers:
+  - oder_chiou@realtek.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: realtek,rt1016
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
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
+        codec@1a {
+            compatible = "realtek,rt1016";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt1016.txt b/Documentation/devicetree/bindings/sound/rt1016.txt
deleted file mode 100644
index 2310f8ff259b..000000000000
--- a/Documentation/devicetree/bindings/sound/rt1016.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-RT1016 Stereo Class D Audio Amplifier
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : "realtek,rt1016".
-
-- reg : The I2C address of the device.
-
-
-Example:
-
-rt1016: codec@1a {
-	compatible = "realtek,rt1016";
-	reg = <0x1a>;
-};
-- 
2.34.1

