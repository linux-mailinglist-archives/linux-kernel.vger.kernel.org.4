Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06F0611839
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJ1Qxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJ1Qxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:53:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE720FB2A;
        Fri, 28 Oct 2022 09:53:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z18so3721510edb.9;
        Fri, 28 Oct 2022 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C33seGVoVdC4qa6odCGMM1UoRMAEyPpQFpcRe9CmJUc=;
        b=ovzgyGUxkoVOneqlKtvwiYv658V+dDonx3OJ+SBev41qlLDg1NpzyH+GqBCCnE5/wv
         adSab9LjklbHjXr2q9nMNuRdXkNXuB2fnFCTEWPh+xrJVTgfyXf3s8qbhbhrf373AULi
         dnpRsp+VcGt8w0RhxPNVBx/ZjfqOBxgbXFuABBSweMNzZmHg5YBRtx4Rj+ozu4bJhiI3
         B1X9dmEuc1tqAar4mMczvCBeEQ4W/aQx2njMj4QB2SodIrSm7s9C6wtJ22KYRAtH/4Jk
         VHPMotD+KziMDnWeFqOY3ADQhN5TcxjbT712+cPKrZ1c0PujS0Yj8VgRasDErFjMrXCv
         PBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C33seGVoVdC4qa6odCGMM1UoRMAEyPpQFpcRe9CmJUc=;
        b=ONX7DpgGtF38DMEf7KTw/9jLHiLuLshgW9ZZwZGwPuHYnEg/TDVtuZ4KqgnWZ6nOa4
         Gm3K4p3fiIb+RKF0TT+F43eHlBs+ZP3unUBT3ToCVI+CPpQOTO6wxxSl9KJOHJPPh3kQ
         60bV6mlSrjJyfEI5uNXXoVcFputl+c7knIv4z8uu9kDl7IgKcyxIiiq2pGvPwj2HNoQk
         cVIccGB/rg6XzPUPBt+g0ZyiLyHc1ztNeQAX0CrsZZEbHZ9M3ozeyE94UzkGd2Ztvl/G
         Mb8HxCOC1Bjo1/41tQCo+ViOBKV8JRfQLB1Jg39B3krg7Zp4p1EoLLGzabksGYgC3OiG
         LbTw==
X-Gm-Message-State: ACrzQf0ixubwYylJxkJbo1NG2WAEirvFj5vvU9COiSHO0trpGVao951d
        x9bddcurifEyWx+91snATww=
X-Google-Smtp-Source: AMsMyM7qjQeg/XqtG5uytmvtDH96ok5pg9w6JiGjPO1p1bwA9dri1+cSZQDgCvElbmA68t7nLMDJIg==
X-Received: by 2002:a05:6402:5ca:b0:43b:6e01:482c with SMTP id n10-20020a05640205ca00b0043b6e01482cmr340391edx.189.1666976009647;
        Fri, 28 Oct 2022 09:53:29 -0700 (PDT)
Received: from localhost ([88.227.58.131])
        by smtp.gmail.com with UTF8SMTPSA id j22-20020a170906411600b0073d638a7a89sm2411522ejk.99.2022.10.28.09.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:53:29 -0700 (PDT)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH 1/4] dt-bindings: pwm: Add Apple PWM controller
Date:   Fri, 28 Oct 2022 19:52:13 +0300
Message-Id: <20221028165215.43662-2-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20221028165215.43662-1-fnkl.kernel@gmail.com>
References: <20221028165215.43662-1-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs such as the M1 contain a PWM controller used
among other things to control the keyboard backlight.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-apple.yaml    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-apple.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-apple.yaml b/Documentation/devicetree/bindings/pwm/pwm-apple.yaml
new file mode 100644
index 000000000000..39dc32e00a3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-apple.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-apple.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple FPWM controller
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description: |+
+  PWM controller used for keyboard backlight on ARM Macs
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-fpwm
+          - apple,t6000-fpwm
+          - apple,t8112-fpwm
+      - const: apple,s5l-fpwm
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm: fpwm@235044000 {
+      compatible = "apple,s5l-fpwm";
+      reg = <0x2 0x35044000 0x0 0x4000>;
+      power-domains = <&ps_fpwm1>;
+      clocks = <&clkref>;
+      #pwm-cells = <2>;
+    };
-- 
2.37.3

