Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AECB73DC4A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjFZKcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjFZKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:32:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5BE56
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:32:13 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so4043185e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687775531; x=1690367531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6JtgnVPfaRDduEP2cAzMm1DanPSCZPJshpIYUQYupg=;
        b=Y1+pvc7t8Q9UC0vxWjn35nn9N6orZjatS1wn93XmWtMoDik49aMMex3Fw3xaeDQMK8
         xeaNaMNmtn7134qe5nchTNkSm3V1IS+C3Hi1yJARGHWyYqledAG6v9wsNDnSVWgBfJQM
         clx13egRjQKHYmEtWFOCzM3P88GMKM3Fa5R4ZyigTXpq++YGRCfj/6hN32tgyfXCZSNU
         X7fb65RWZx98tYOLNJ4adUxv+EL5HO3RIj/JsZXIbIQpc7NT/GdC8DAmJd1tkoOkHw0O
         Q8mMjIEZ+kcXlXzm8xV+vTaa7GOhmmKjYyl+m18fevfHlujhYDmVJX5DmJXbqlmv5FcU
         Uegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687775531; x=1690367531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6JtgnVPfaRDduEP2cAzMm1DanPSCZPJshpIYUQYupg=;
        b=E9WKiWCyuJdJokFDoJCGrYAT9qXkfKJxlOtrR/mSIkDHJSCB3gh1PlwfhYBS3iuF0c
         X02k14RgAn3ZxLJJClfE3RmlP47YAzo8tTjtqhkryVMMaofGDLCSqXAOBO6Kj9AB6SOs
         i40911v5tNSpie7zZOWXs1u814feQh8tXJ2QZwA65hhHoZabszYMJNg9+68uz1i1OgVI
         XlLgitqY0t/BRladHnY8NDtKEqrQgTuXYLJkSLIxde36SAeXXiH2DKRaxC0v7I328VK1
         HY7E4N1iU7X9QXwlbNRBg7eebgFGfBjYIgNPYOb1bra3YQd7kWb+9effD/78ht92OV17
         0m5A==
X-Gm-Message-State: AC+VfDxWvLO5zxbteaq8tD8CwVYl3YG8GlvTsUp7qLhNcNvjK30wL/4I
        wDINtzOoQ2YADxtVZMxji+WpEg==
X-Google-Smtp-Source: ACHHUZ4oQ099RycUF6mrTfJ09tkWckbnDIrMCbhBXjsuWrvVnxCOFt8GHX6b2CNnvFJPHmXeJwKc3Q==
X-Received: by 2002:a19:5f1c:0:b0:4f4:d83e:4141 with SMTP id t28-20020a195f1c000000b004f4d83e4141mr15523490lfb.50.1687775531502;
        Mon, 26 Jun 2023 03:32:11 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id c26-20020ac2531a000000b004f13ca69dc8sm1041655lfh.72.2023.06.26.03.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 03:32:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 26 Jun 2023 12:32:07 +0200
Subject: [PATCH v2 2/3] dt-bindings: power: supply: Document Mitsumi MM8013
 fuel gauge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v2-2-4be6223587ad@linaro.org>
References: <20230621-topic-mm8013-v2-0-4be6223587ad@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v2-0-4be6223587ad@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687775527; l=1459;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6NgCrA8TzKC0b1xLfjDslYNGxlWGJLejhI+Bt3kSWN8=;
 b=KSFiBW+Q3z06d4lYzhcpKuWsUva9LjcS7caRBGzhENfqL8BfsZ7xqpP36pCbILGYlt5YBAiAE
 Hf6S4p6aLsLDF81JYmjFtdpqsB8QKedo+SMgV+bDVl5RnpQEibA2KH+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mitsumi MM8013 is an I2C fuel gauge for Li-Ion cells. The partial
datasheet is available at [1]. Add bindings for this chip.

[1] https://www.mitsumi.co.jp/latest-M/Catalog/pdf/battery_mm_8013_e.pdf

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/power/supply/mitsumi,mm8013.yaml      | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
new file mode 100644
index 000000000000..080fd44083ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mitsumi,mm8013.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/mitsumi,mm8013.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mitsumi MM8013 fuel gauge
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+properties:
+  compatible:
+    const: mitsumi,mm8013
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@55 {
+        compatible = "mitsumi,mm8013";
+        reg = <0x55>;
+      };
+    };

-- 
2.41.0

