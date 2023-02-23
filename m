Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35C6A10AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBWTmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBWTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:42:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B859E41;
        Thu, 23 Feb 2023 11:42:28 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cy6so40823987edb.5;
        Thu, 23 Feb 2023 11:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BXWAwPXU4gL7NDBNH5IiDYMBbcpymX6jA+XKQ4A+7Y=;
        b=Z9qIIeH4K2XaOajUagHIDfr3qHg6UXZN8iDBhj6FFX0dIjfQCBvZnks9KcNGHHY19G
         ldGQ9mahmCf7kjx2w1OPaz4kn6RnIsQC2dYq6V3Pby6VVovYfUveaWaBMaYGGj90m54q
         xOe9VekczEw87U22eyuTextgD4lzevi8ETHyOkm3ySyTAl0OtGv4jfqzDRDtKIhOO0+S
         21Df/7kwahDs6AbQ2P3SP4JS8Ipm6YUYhZscMNwa7+WcNpkVz0xD9QxfkCrSbuJkPrDO
         dwKvak9Ck8GAKMCuwVgpk1sf63ERU9F9bxOzeBJvQs3DbJtG8mJMcd7+JDw9U/oMftjH
         j/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8BXWAwPXU4gL7NDBNH5IiDYMBbcpymX6jA+XKQ4A+7Y=;
        b=1SCEMBb6B5OoLlQeePZtSqN/hldSVzYx30y3aEUNhdCuiXmcZH7azdb9rzvK57JHqg
         X4K4APZMiPskteSCbF6RxJo5QUrMFY18ogbRhBLtmiakQZ2fJKpe3KGoylv42KcsPi0B
         bon8FYU+shaFHYlXECLkTFJJOaddQzGMlSVPgYqumIHaYFTMcq2LCr9h/fBoxQZbddOH
         cxOcQNWSjh5lz6QpKe2jLYEwjR596z5yrSXPA0tT5/TT2sODl+cBxzLnxSyIvCD0u0zj
         Bvvfvkb0EzMHFAlfIHXgAsmvG0Zn9zqHVFFP5pLJ6BJ+h9G+0z6XCoU/IGbhksvMBuie
         S2Dw==
X-Gm-Message-State: AO0yUKXfVUfnzmBOUcenyjGDOtx1Ee4rqsZDBj1nM2TCi9BbpKkHcSQh
        v8kC7G3uyO/AE+DTzsFe5FM=
X-Google-Smtp-Source: AK7set/x32vBkRksysZ8SuzBqjVeMXtXLVaQQBia6jjruTfaGG5eWsPI6iBac7ydZdrGPp4yl+5qcQ==
X-Received: by 2002:a17:906:9bc3:b0:8a5:3d1e:6302 with SMTP id de3-20020a1709069bc300b008a53d1e6302mr19527041ejc.56.1677181347149;
        Thu, 23 Feb 2023 11:42:27 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bk15-20020a170906b0cf00b008f398f25beesm19079ejb.189.2023.02.23.11.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:42:26 -0800 (PST)
Message-ID: <3eeaa940-9d40-5e33-bc36-c9b0449ded9f@gmail.com>
Date:   Thu, 23 Feb 2023 20:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 1/7] dt-bindings: gpio: rockchip,gpio-bank: add compatible
 string per SoC
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all Rockchip gpio nodes have the same compatible.
Compatible strings should be SoC related.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changed V3:
  Keep enum
---
 .../bindings/gpio/rockchip,gpio-bank.yaml     | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index affd823c8..2e9a5179c 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -11,9 +11,28 @@ maintainers:

 properties:
   compatible:
-    enum:
-      - rockchip,gpio-bank
-      - rockchip,rk3188-gpio-bank0
+    oneOf:
+      - enum:
+          - rockchip,gpio-bank
+          - rockchip,rk3188-gpio-bank0
+      - items:
+          - enum:
+              - rockchip,px30-gpio-bank
+              - rockchip,rk3036-gpio-bank
+              - rockchip,rk3066a-gpio-bank
+              - rockchip,rk3128-gpio-bank
+              - rockchip,rk3188-gpio-bank
+              - rockchip,rk3228-gpio-bank
+              - rockchip,rk3288-gpio-bank
+              - rockchip,rk3328-gpio-bank
+              - rockchip,rk3308-gpio-bank
+              - rockchip,rk3368-gpio-bank
+              - rockchip,rk3399-gpio-bank
+              - rockchip,rk3568-gpio-bank
+              - rockchip,rk3588-gpio-bank
+              - rockchip,rv1108-gpio-bank
+              - rockchip,rv1126-gpio-bank
+          - const: rockchip,gpio-bank

   reg:
     maxItems: 1
@@ -75,7 +94,7 @@ examples:
       };

       gpio1: gpio@2003c000 {
-        compatible = "rockchip,gpio-bank";
+        compatible = "rockchip,rk3188-gpio-bank", "rockchip,gpio-bank";
         reg = <0x2003c000 0x100>;
         interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&clk_gates8 10>;
--
2.20.1

