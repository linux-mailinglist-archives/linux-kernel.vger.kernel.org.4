Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5F26765D3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjAULGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAULGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:06:09 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576D017CF7;
        Sat, 21 Jan 2023 03:06:08 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z11so9524148ede.1;
        Sat, 21 Jan 2023 03:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvNu880SAopwZN/Uilrm2/QZdBFEkhvyjIQe2m9+fR4=;
        b=e41Zml06w7B1Xy0dM/gOBKmeCbDwoz2YD9cIVcSegHug6a8ffVdGIEQPFK1XgHGQUs
         P3KSUQU488BghvPWu9Usvn5xxaGIl2F1RSVYgh30//CUmuWEGiLrU/yMRGdtrlb20aKB
         R77lyRIm/lJrJVvG4YUqc/7VJgLZP66u4pt7D+qmKWZAvQA2X1iZDu0yEXkGbjuEfvEY
         ubghBvhKGw6yhLorEnI9o+WctKYwiePinIQ7hE3G3VkJIJP68uEiGpoYreivzVo0O6pr
         LY80NzQBrOFm6QSQqQzXlh6dVOTem5jH3KrmDaG49LXaHk5rxQUGnyjI07AdE3/jztID
         hSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IvNu880SAopwZN/Uilrm2/QZdBFEkhvyjIQe2m9+fR4=;
        b=fNqJvslIkQS6yR3G+4GsReg8WWJpzoj+0PlHmecqnM8ajOh27YPxf/KCCD0IcndAxS
         l1/35r1xeLSrED38YwEAufWu4DKwII6jkcvVzT0huoJ4cmUoqdBzziqUiWBLPVwuVD/g
         SgXzSNOIRdnvgXl2GIMyrz3WrRIzwiU3N3tyye3eMFfdyD0d/Q/uIMm33LHwq+mILDOX
         NT9InVwEaAWz9Fv0nPQ2VJHbnpfqR0Kj8VueWl25d47MrrOOasLlbqdSjWagcg4RXcb6
         pfy532ZZ3F7HqwJqnHdfnCB4COKEmb83vRIjqzY2OU7LfQDy2fQFRDNTtT8OUj4SidrA
         7anA==
X-Gm-Message-State: AFqh2kqkypvfi38F5Vf9yVAh504+1oHVQf3x8CosRlsn4L6C/FXQPiVQ
        +2dIyJJs0JuEsAvbB+geFX0=
X-Google-Smtp-Source: AMrXdXua+DR3rkmgNcViz9hiLP0+kXC9d63lfRVOVCce6mKXWnxfQ03XstrdP0euQfN61nXWfge3og==
X-Received: by 2002:a50:fa94:0:b0:493:597e:2193 with SMTP id w20-20020a50fa94000000b00493597e2193mr19117800edr.37.1674299166834;
        Sat, 21 Jan 2023 03:06:06 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id hp24-20020a1709073e1800b008720c458bd4sm7666851ejc.3.2023.01.21.03.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 03:06:06 -0800 (PST)
Message-ID: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
Date:   Sat, 21 Jan 2023 12:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 1/8] dt-bindings: gpio: rockchip,gpio-bank: add compatible
 string per SoC
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
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
---
 .../bindings/gpio/rockchip,gpio-bank.yaml     | 26 ++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index affd823c8..a604c3638 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -11,9 +11,27 @@ maintainers:

 properties:
   compatible:
-    enum:
-      - rockchip,gpio-bank
-      - rockchip,rk3188-gpio-bank0
+    oneOf:
+      - const: rockchip,gpio-bank
+      - const: rockchip,rk3188-gpio-bank0
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
@@ -75,7 +93,7 @@ examples:
       };

       gpio1: gpio@2003c000 {
-        compatible = "rockchip,gpio-bank";
+        compatible = "rockchip,rk3188-gpio-bank", "rockchip,gpio-bank";
         reg = <0x2003c000 0x100>;
         interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&clk_gates8 10>;
--
2.20.1

