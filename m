Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A36A82CF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCBMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCBMxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:53:25 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71E124486;
        Thu,  2 Mar 2023 04:53:09 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id y19so9713648pgk.5;
        Thu, 02 Mar 2023 04:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRnL8PP+Em3R8alqzrLZeyCQtoaYlrzX+Ww0tSnTWvw=;
        b=HRxqlQI8jw+d7AibX67FSXxvDalEP5+I4pP1ZMSjEq2DVqvror5lK7aAyFwwVqZHa+
         UPpdpX75C/7U0nun4DU3bHMY5GxVUAYEoF3EM6ZCxTKyrV89xUwPL5n5mN+G+lAiTiBr
         JOqraCHOMcCZti2hJG/hL7Bp6NiliGLDeOHbiWlhDo7SpYUp4uWf4wjT7pobeyOHS4l4
         MDESAWsb4r8/JuPg7Bl7+AZFrz0vTV66+TRcVUB746ZyYYC43mNzdM2CgRJFUBpwTLAd
         8cwXSOL1Z6Q9nQ1P6T2O6aDTOKcXJT9MAREFmlgNtVOdCi3fflkCCHN4izR+2+Nr1cHd
         iC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRnL8PP+Em3R8alqzrLZeyCQtoaYlrzX+Ww0tSnTWvw=;
        b=qoIrntgEJGSXU0ZuHEpAbpdWxhleIU4BzZx08+5KzBoTMkeiYBb7RWefQOzcEXatIP
         8eS8NqQlOSxY98EsFXU0B6PZSTmbCF6TZ9Se2ngd1P5MScCwS+YMywfxFtkOTG6glMD2
         OMBev79/2LZpSKwrX5RyV/h+k34PVROtlwM4zmAnd1wy/Psf9dNVyfo1UC0yutzocefJ
         ui1bBtcNgvroLJ+fh0gtcOH30ocsQ8UyRcApM8bWQXmbZmnxbJ9VDHkjCRvjlFmogD6X
         dDCY9QhccMc+87e06cIGEiPgX1xzLrH03ilRXPUHo1b/k83aeQasseCuK04KqGgjLAMk
         MEcw==
X-Gm-Message-State: AO0yUKVDSqE/J1U8dt7I0i8XhyBKiTESSYXlFTTGmlbEAT81+0LWAoJ0
        FzrKoCShKRpiaelpFiIFekVN/1QUP36Zcw==
X-Google-Smtp-Source: AK7set8MyVjJedvYNIycLjfa21tODlFFN4KW7G1+4wjFrLDCe0m/LuM8cdyZ4ZVbNE/AOPzM8YzKMA==
X-Received: by 2002:aa7:9466:0:b0:5a8:5424:d138 with SMTP id t6-20020aa79466000000b005a85424d138mr7263122pfq.16.1677761588857;
        Thu, 02 Mar 2023 04:53:08 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([223.85.203.147])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b005aa60d8545esm9791955pfh.61.2023.03.02.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:53:08 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 5/5] dt-bindings: gpio: Add Loongson-1 GPIO
Date:   Thu,  2 Mar 2023 20:52:15 +0800
Message-Id: <20230302125215.214014-6-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302125215.214014-1-keguang.zhang@gmail.com>
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
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

Add devicetree binding document for Loongson-1 GPIO.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Use the same consistent quotes
          Delete superfluous examples
---
 .../bindings/gpio/loongson,ls1x-gpio.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml
new file mode 100644
index 000000000000..1a472c05697c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/loongson,ls1x-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson-1 GPIO controller
+
+maintainers:
+  - Keguang Zhang <keguang.zhang@gmail.com>
+
+properties:
+  compatible:
+    const: loongson,ls1x-gpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  ngpios:
+    minimum: 1
+    maximum: 32
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+  - ngpios
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio0: gpio@1fd010c0 {
+        compatible = "loongson,ls1x-gpio";
+        reg = <0x1fd010c0 0x4>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+
+        ngpios = <32>;
+    };
+
+...
-- 
2.34.1

