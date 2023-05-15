Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEB6702638
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbjEOHkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbjEOHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:40:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33701E68;
        Mon, 15 May 2023 00:40:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so66059585e9.0;
        Mon, 15 May 2023 00:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684136427; x=1686728427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uakoPy8ncdNAG3jrhtldU6DM7FPTdBqXspADcsRU/4=;
        b=WEU+jtPtGzQ65MZKQCMd+wV3T0FSyEUtCT2/trbX7mboW8hUnd6AMRewxkvBLoGzHR
         9yzwLQcc7qwAKaAQfcuS5egBbT86gcu3UM2fxHvXmvkbeE2YNBzpE6Gfk7v1oA6ZeyvJ
         KjAB1qwXdWnHLto8Dqk9lrH0qBnfjiEw1z/5Yu9H/UGH3VcOWDNF4lVYyAIV8cZibPOj
         tyOknNKI6EgxpSE6mqopdDuiteCiI1AWdf9An8VEWEhZrMt5upUz+eJVwt+ChfG9XKrX
         wfHkWxWoBAXcgOCOrzAQGkkCJts3EoxbsHdA6JFFBvVpOF7NFHnzRaP+A2ek6JKvVVRH
         QPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684136427; x=1686728427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uakoPy8ncdNAG3jrhtldU6DM7FPTdBqXspADcsRU/4=;
        b=BoY7Rp2q8Lw076hp5hmAafEFCKKdVkBtLStPJLiovqCm8DHpzcQKLk/Ir9ADfniGo9
         KmO2X+HtA2Pyn0Rwu8Fhz4JjMjbaju65hqd6Bfnkro3Joiy1pXQh3qF5DN4yEX4ASlzF
         arjcEDccddaqhiATw7lEwoX3BgbEAJnfAto3cV+H08USekGFYKglZho6wNBSu12fEfO3
         eIMwSriF7psqy8TFMEcPz+s+6FOCp5wNCUaLTco7rh7YugI0/Z6IyByHQwRcHBGDdn+1
         Ij53HAaroPphaKWAIvYQVkTM1mFspnMa+CmlAsa/BULAcDEkHydVqm7N+RMt2XE5V1Vz
         2zkA==
X-Gm-Message-State: AC+VfDwC86M/3G0GdSfBFBphyOGPkfykedR31vCMoGDAt5F/E0qmR4Oe
        4MTytv6g281yCASMpyX5lCY=
X-Google-Smtp-Source: ACHHUZ4IbMm393RoNlW4AS6UCYxFM2hMwl4BHXeLdoidtmp2qqej8FlJr2P+s/0cajaWsRLTu9VmtQ==
X-Received: by 2002:a05:6000:1c4:b0:2f5:ace2:8737 with SMTP id t4-20020a05600001c400b002f5ace28737mr20920372wrx.32.1684136427404;
        Mon, 15 May 2023 00:40:27 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q4-20020a5d61c4000000b003063772a55bsm31588277wrv.61.2023.05.15.00.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 00:40:26 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ASoC: dt-bindings: Add ESS ES9218P codec
Date:   Mon, 15 May 2023 08:40:21 +0100
Message-Id: <20230515074021.31257-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230515074021.31257-1-aidanmacdonald.0x0@gmail.com>
References: <20230515074021.31257-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree bindings for the ESS ES9218P codec, which uses an
I2C control interface.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---

Notes:
    v1->v2
    
    Address Krzysztof's review comments:
    
    - Add missing ref to dai-common.yaml
    - Simplify descriptions of supply properties
    - Remove unneeded clock names, the device has only one clock input
    - Use unevaluatedProperties instead of additionalProperties

 .../bindings/sound/ess,es9218p.yaml           | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ess,es9218p.yaml

diff --git a/Documentation/devicetree/bindings/sound/ess,es9218p.yaml b/Documentation/devicetree/bindings/sound/ess,es9218p.yaml
new file mode 100644
index 000000000000..53ca06539e0a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ess,es9218p.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ess,es9218p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESS ES9218P audio codec
+
+maintainers:
+  - Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: ess,es9218p
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  avdd-supply:
+    description:
+      Digital core power supply.
+
+  vcca-supply:
+    description:
+      Oscillator and DAC power supply.
+
+  avcc3v3-supply:
+    description:
+      3.3V regulator for amplifier, switch, and charge pumps.
+
+  avcc1v8-supply:
+    description:
+      1.8V regulator for amplifier, switch, and charge pumps.
+
+  clocks:
+    items:
+      - description: clock for master clock (MCLK)
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      Pin used for codec hardware reset, corresponds to the RESETB pin.
+
+  ess,max-clock-div:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Sets the maximum MCLK divider for generating the internal CLK.
+      CLK must be at least 20x the I2C bus speed or I2C transactions
+      will fail. The maximum divider should be chosen to ensure that
+      CLK will not fall below the limit.
+    enum:
+      - 1
+      - 2
+      - 4
+      - 8
+    default: 1
+
+  ess,oscillator-pad-bias:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Sets the oscillator pad drive bias. 0 - full bias, 15 - disabled.
+    minimum: 0
+    maximum: 15
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - avdd-supply
+  - vcca-supply
+  - avcc3v3-supply
+  - avcc1v8-supply
+  - clocks
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@48 {
+            compatible = "ess,es9218p";
+            reg = <0x48>;
+            #sound-dai-cells = <0>;
+            avdd-supply = <&avdd>;
+            vcca-supply = <&vcca>;
+            avcc3v3-supply = <&avcc3v3>;
+            avcc1v8-supply = <&avcc1v8>;
+            clocks = <&xtal_clock>;
+            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.39.2

