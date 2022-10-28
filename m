Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71736611E30
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJ1XhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJ1XhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:37:08 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A3A248CBB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:37:07 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z6so4467942qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qek8CJa1Lf5wEjUCizwM4dNQR7j2cqTQjO+0iv1r63c=;
        b=hk7vFQaNCWPnjqyN+pYrb5525vC9R4X7XMfyX7/BkSDIU5Tm3r/0v0+TWdK46WXvCl
         UY9Gm0ZlDLJtz3sF+mnLQNoELTfwY0ygkgYMVJioK4wjpvwXaT9IB4/yYR7WrtR4St+r
         2czE5TuDN0hWLaY6gZIvsywcxQAP3XfW9pH+0/+S6VZAaOPHu8MvLwidnj9dM+zuplfb
         uCEBNT4Nn6I9a9bywLgOZd2hTEVHPdLWvI5zwc4VCUfc9amEXsrHX2KUAqtjSxiN0sGw
         YoU+iu8Q13rzOnei8nCEQTCZn8hNKCuU3sCzbIIF4qMpnxIBmqC7+kPZCcJ79NovaIHU
         ioHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qek8CJa1Lf5wEjUCizwM4dNQR7j2cqTQjO+0iv1r63c=;
        b=W9ZFonT1vAutsinBmXrgXCUm9wucWMWyGnTVL5R1yXv925ZOCeNJlvO1aiHUXbVGzA
         QlNC8VPnUhGAToMK/nDeKYWqQroPa8H79mHOYIXhWgbAUvhQ50c20rkHFhyL1cYr14em
         tE+l20tuYx/PTGs6wnN9aXUVvAo/R1VHFJV1yRRb7VGAbpV1KEasxJ1bRtwlCCdnm7oF
         yJWsPp17GdovnJ5yInouaeZvxjE1hXBUFFrfv95hY8JdnBhdpxfKFlUIwlYIhN/azYWV
         MhvDig7oQNqfErHZX85yIJeX4U6qpjETQxdLpfDwEwNoRegkUnwJmolv9IC1jQGOCzm4
         bTzQ==
X-Gm-Message-State: ACrzQf3afNAgtcN36CEMHkI388KT4ot3AeCwQPeCiSaMmRky47gRnABI
        fXjjsMGwpxz9jfopn8ZbMjMu9g==
X-Google-Smtp-Source: AMsMyM4oGOVw8wPLrUx3Hh65mu5pC5F3uf+DHCFGbjcpaH8B5SW6WXAiEl3L2y3fsnOR9cr/2TIm9A==
X-Received: by 2002:a05:622a:284:b0:39c:cbec:e1f0 with SMTP id z4-20020a05622a028400b0039ccbece1f0mr1746595qtw.451.1667000226142;
        Fri, 28 Oct 2022 16:37:06 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id c23-20020a05620a269700b006f84ee3a4f3sm26580qkp.48.2022.10.28.16.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:37:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: examples: add a list of templates and solutions
Date:   Fri, 28 Oct 2022 19:37:01 -0400
Message-Id: <20221028233701.572280-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to start from existing bindings when writing new ones,
especially when one does not know that much DT schema.  However we have
several bindings which are not the best examples, so people tend to copy
their issues into new bindings.

Beginners also might not know how to achieve some more complex solutions
in DT schema, e.g. how one of two properties should be required by the
bindings.  Some of such solutions are already in example-schema.yaml,
but several other are missing.  Add reference with such re-usable
design-patterns.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/examples.rst          | 63 +++++++++++++++++++
 Documentation/devicetree/bindings/index.rst   |  1 +
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/examples.rst

diff --git a/Documentation/devicetree/bindings/examples.rst b/Documentation/devicetree/bindings/examples.rst
new file mode 100644
index 000000000000..710eea81d8b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/examples.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Examples of Devicetree Bindings to use a base
+=============================================
+
+Following Devicetree Bindings in DT Schema are a known good starting point when
+writing new bindings:
+
+1. Simple SPI device:
+   Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
+
+2. PMIC (MFD) with several sub-devices:
+   Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
+
+3. Battery charger (power supply):
+   Documentation/devicetree/bindings/power/supply/bq256xx.yaml
+   (but use vendor prefix in filename)
+
+4. Clock controller for several devices with different clock inputs:
+   Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
+
+5. GPIO controller:
+   Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
+
+
+Re-usable design patterns when writing your own bindings
+========================================================
+
+Following bindings show how to use common pattern of writing bindings:
+
+1. Property required and present only for one variant.  Property cannot appear
+   on other variants:
+   Documentation/devicetree/bindings/example-schema.yaml
+   Line: 212
+
+2. Excluding properties, but none are required:
+   Documentation/devicetree/bindings/mfd/samsung,s5m8767.yaml
+   Line: 155
+
+3. Excluding required properties, but one is required:
+   Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
+   Line: 91
+
+4. Array with numbers (items) from given range - min/max:
+   Documentation/devicetree/bindings/arm/l2c2x0.yaml
+   Line: 74
+
+5. Array with numbers (items) from given range - enum:
+   Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+   Line: 101
+
+6. Uint32 matrix, variable length of two-items:
+   Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
+   Line: 278
+
+7. Phandle to syscon with offset:
+   Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
+   Line: 42
+
+8. Variable length of array (e.g. clocks and clock-names) but narrowed to
+   specific variant:
+   Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
+   Lines: 33 and 71
diff --git a/Documentation/devicetree/bindings/index.rst b/Documentation/devicetree/bindings/index.rst
index d9002a3a0abb..fb8fab7217af 100644
--- a/Documentation/devicetree/bindings/index.rst
+++ b/Documentation/devicetree/bindings/index.rst
@@ -4,6 +4,7 @@
    :maxdepth: 1
 
    ABI
+   examples
    writing-bindings
    writing-schema
    submitting-patches
-- 
2.34.1

