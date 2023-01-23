Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A4D678BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjAWXLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjAWXLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:11:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630532F78B;
        Mon, 23 Jan 2023 15:11:02 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id az20so34693716ejc.1;
        Mon, 23 Jan 2023 15:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX3QH1ZOcQvF+gQ1gLNMqKF7PvJfNfpG3/++e3twGu8=;
        b=U057nvsz/datauyVaPlYhXmqIrYcDdunLpibOlSZwOmpGY2vCNIhh5i7ZQ74fSE1/S
         adGgRGbb0m6CfE4+XkcxKdNGMITCvgy6wcYFoh8k1agtdGRADo3YGx0K5QcloFcnkGpe
         x956svw6kH1wyaTl3W4JgejYiAI+cNnVfHs3vjL+tnJcPxAeJMOmizFBhDVb5qQunnkj
         9xZh3crSnifdGJNc7GnJbJcWeVRkDlvJlWaSaOMSlBlKZi0OGPPSWaI5SFpjhiKI01tp
         OrSVM/kgFeu4lfDRptEMkFD2mUP7YxI27J6hXZQHImUP3cOUCd7gRnYhxDleTKRPun8Y
         X+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fX3QH1ZOcQvF+gQ1gLNMqKF7PvJfNfpG3/++e3twGu8=;
        b=uYYJuwaIChgN/yIvd+UeAd6gURtrCzrREMeLRlNBWMurRnb22LzFohjDHW1WRRj9pG
         S7paln3US9kk7ySEAwmRndxfzI2/UYJuBo9S+2DJDjEd9gU+EHitMeghD65ZY5jFfUGg
         Ot1CjTqTMc5TMdGZu2MIVSiEN/g3UZThAOerVOWMrBQk43jg0DUrLaBNLxpg2RTwG4jT
         4xQDQZCqmC9JtxrWLV3NGQPFgg2KxXiDxGE2n2ECoK6PW8OX/UwHzbXEUyTEXUFF5vRV
         3drbHz0UIHFpOOgMrgIdjYTHZ83/f7dvR+Ao8+MJogPMBqnhvAKG47f6G//dHL6RMmCm
         y0Zg==
X-Gm-Message-State: AFqh2kqIuoRvEN88cXldajWsuPGGrFuRlX6WqhAnWJd2LVi8m3vSeO1i
        0yERNCFnbw7qgwg9xFKZ2LphMuyNw/o=
X-Google-Smtp-Source: AMrXdXsSZkXHBsadaCu/VPMcCQEnQj5D6f0BpuMCmvrCjbyyGvcuFW+0v5yRXBZ+GoLTkiWdGHFAwg==
X-Received: by 2002:a17:906:f299:b0:7c0:fd1a:79ee with SMTP id gu25-20020a170906f29900b007c0fd1a79eemr27533477ejb.63.1674515460602;
        Mon, 23 Jan 2023 15:11:00 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906709500b0084d43e23436sm72601ejk.38.2023.01.23.15.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:11:00 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: tcs3490: Add bindings for AMS TCS3490 light sensor
Date:   Tue, 24 Jan 2023 01:10:24 +0200
Message-Id: <20230123231028.26073-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123231028.26073-1-markuss.broks@gmail.com>
References: <20230123231028.26073-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree bindings for the AMS TCS3490 Color ALS.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../bindings/iio/light/ams,tcs3490.yaml       | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,tcs3490.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ams,tcs3490.yaml b/Documentation/devicetree/bindings/iio/light/ams,tcs3490.yaml
new file mode 100644
index 000000000000..0938d5edd791
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,tcs3490.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ams,tcs3490.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS TCS3490 Color Light-to-Digital Converter
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+description: |
+  This color and IR light sensor is typically used to adjust the backlight
+  intensity and correct the display color gamut. Additionally can be used
+  for light source type detection as it reports the IR content of the light.
+  It can sense four channels of visible light (red, green, blue, clear) and
+  IR light.
+
+properties:
+  compatible:
+    enum:
+      - ams,tcs3490
+
+  reg:
+    description:
+      I2C address of the device (typically 0x39).
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light@39 {
+            compatible = "ams,tcs3490";
+            reg = <0x39>;
+            vdd-supply = <&cam_vio_vreg>;
+        };
+    };
+...
-- 
2.39.0

