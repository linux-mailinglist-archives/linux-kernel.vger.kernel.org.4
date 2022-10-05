Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DDF5F53F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJELrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiJELrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:47:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2121225C5C;
        Wed,  5 Oct 2022 04:45:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id b5so15036548pgb.6;
        Wed, 05 Oct 2022 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=CG94Zo2W31qd1uuT/LO/cTuqQ3x/Uc6a0fPRmlx72wBTAzOnQUU/b4l3CvIGBZkWJ1
         IxdQBWeov6BkXdonw+seOfJ1qLLJPygp8lKofjrj9eVlNOiMCa9J0+mt9LwtJBH6cpSg
         KytMrOK2OHPkYfpUABaHXOMXGswwRno6ClQ2POc0TOZqxYCVx3kaetNxt1qhxp0eRpug
         9cvahLuDjTZ5ahFePWoOV/0SBVEXSmzU237nWxMK520KutEQuIMWf+SIZSf4iDdRiLNy
         wRM0sSzrhj9EPbQIPZr0YT0nwG6m8CdK0uC3UofxNQust/dF1IpAdKobH+2PG5QpdHcD
         fHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=p+rA+l4imONKlCznteINTIlJji0MdJx1JaDsXqr+fMm44Qv4SCU5Thq/NTHD8usetq
         y2NZ+6CIlfYAma2q8CyLIY4E9nNFkkXfYvuRmNcm7i2ZK5zA3jQYa73fffNDMxMCpOv9
         Bl0YpCa3NRfBHd5TRzbJ6A+lTTRBkuUf/0A02lYCZ7jtYEVx749slSvPhLFyaIp0wdJI
         xCKMCVp09OfqmZst+NE//8zgEpDOKq81hKe2cIkyIpsT2mLSgC5GKyX+grSFfLV1d6wO
         A2JmgQK4MO8MnHoJEngW1Z49S+/1U2ssCxrBxOd0+D3+b5V78giNA3k2MF2I1NRkxD5h
         aSsg==
X-Gm-Message-State: ACrzQf0u6x70ctFrbsJsbZsq1l21FEsvf28eux1NC/nxYT0RgeV9Oe9Z
        zZB1gHVhXWKD+cU4nMUf5G8=
X-Google-Smtp-Source: AMsMyM4CWVTFfBMi+tu1SyhPlOdgJq5al1FRad3mezBpCzOjOXdMnj60RgHoDo3muf4wAym6ASIAMA==
X-Received: by 2002:a63:fa17:0:b0:43c:3f26:48e3 with SMTP id y23-20020a63fa17000000b0043c3f2648e3mr27437883pgh.66.1664970304121;
        Wed, 05 Oct 2022 04:45:04 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-126-108.emome-ip.hinet.net. [42.73.126.108])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b00176e2fa216csm10477447pli.52.2022.10.05.04.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:45:03 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jic23@kernel.org, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v13 2/5] dt-bindings: leds: Add MediaTek MT6370 flashlight
Date:   Wed,  5 Oct 2022 19:43:55 +0800
Message-Id: <9397c7dc2f598aaf715090905518c9d7d8a8ba40.1664991040.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664991040.git.chiaen_wu@richtek.com>
References: <cover.1664991040.git.chiaen_wu@richtek.com>
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

From: Alice Chen <alice_chen@richtek.com>

Add MediaTek MT6370 flashlight binding documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alice Chen <alice_chen@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../bindings/leds/mediatek,mt6370-flashlight.yaml  | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
new file mode 100644
index 0000000..e9d02ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/mediatek,mt6370-flashlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Alice Chen <alice_chen@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  Add MT6370 flash LED driver include 2-channel flash LED support Torch/Strobe Mode.
+
+properties:
+  compatible:
+    const: mediatek,mt6370-flashlight
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-1]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [0, 1]
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
-- 
2.7.4

