Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143DE658B36
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiL2Jt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiL2JrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:47:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16F713CC6;
        Thu, 29 Dec 2022 01:45:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g1so11816505edj.8;
        Thu, 29 Dec 2022 01:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0cpfrQrCcKnzaVIJpPos2V3z+c3X6E+K3Dy1Hme0IGc=;
        b=bgTGDGl+BrixW/GRVJOepBvDeQGJgJl0spl3smoeAQhKAOtEVSZ8auWuMTaYprBQf9
         EW3OSYdPofHkUlis0qABqDvHYwQYvLsIh7qmLemIV7DnLNphROwbjIuz3qJXjyynfu2/
         41uxQ3FMbS5076Ic3DKuwdl3B15ZVDsjPkJndHOTB6UAvDtu0Qb5I6rX426rYKQ/6sLX
         P0Yph0fU0NGRLlJWZZ2aMvfUCDmcl9H9skEGjiZ+AvtkdT+A7hDyzgha9RC0JeF78pWl
         YkgUW+ctTUEy8HSL+YVqRx7jyPGGfDxbWQaHhzOYIgftUtJWkSVIuKgAxlL1iFRir6P+
         Zcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cpfrQrCcKnzaVIJpPos2V3z+c3X6E+K3Dy1Hme0IGc=;
        b=UGGJZcMDS7nm9AdOnD/nPkMrb3RsCap6si10qO6Pzvl1n1RHMDMFE+F1EQGSkmXv+u
         dkw2dbL+0hQpUAT5aSQvRdgML/AZpjYaKtJkSkSI9mc/og5gAg7cPLI7ek9tkvPKXvxa
         ckqcNWeLQ0YILWW+KDgw7fFQqn+bfkVye1spd4bW792VMA5YoNJ8rGLzRJq87OGUupHW
         pBgB/rT6b065UaOjb4LdMVK1vpXvGK+N2ccS1ouTUYGWZuMtLneHn8tdswKVuYxroHvy
         DqsQkRAPm0l8QNW7ORdaTy11l6yMjzMChWNYo+kJ6gW6Z49cYRRQvdSCe48GirOEKvtc
         RQHw==
X-Gm-Message-State: AFqh2koNbZz8cyW/VFDvIxzd4iOl8/oBWjW3RsMzVQOhlVt7a0GBELHf
        ANr7kPjbkPq+zcg57JPD7GY=
X-Google-Smtp-Source: AMrXdXvDNY0hTnxgzXYxlRZ5nuTWqtRuO9Vf+bIy6BtI6hHCS2hyZFrD7MqhMYOw0ACyN7ts1vIeYQ==
X-Received: by 2002:a05:6402:f04:b0:46d:ca42:2e59 with SMTP id i4-20020a0564020f0400b0046dca422e59mr26446335eda.11.1672307118304;
        Thu, 29 Dec 2022 01:45:18 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f9-20020a056402004900b0046c7c3755a7sm8091016edu.17.2022.12.29.01.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 01:45:18 -0800 (PST)
Message-ID: <5759c6e1-9c89-4cb2-dd57-83a8db09f547@gmail.com>
Date:   Thu, 29 Dec 2022 10:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: soc: rockchip: grf: add
 rockchip,rk3288-dp-phy.yaml
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        vkoul@kernel.org, kishon@kernel.org
References: <aa6fe473-71f2-edba-f009-994a3dbc9802@gmail.com>
Content-Language: en-US
In-Reply-To: <aa6fe473-71f2-edba-f009-994a3dbc9802@gmail.com>
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

Add new converted rockchip,rk3288-dp-phy.yaml to grf.yaml file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Apply after:
  dt-bindings: soc: rockchip: grf: add rockchip,lvds.yaml

Changed V2:
  Use the compatible as filename.
  Drop blank lines.
---
 .../devicetree/bindings/soc/rockchip/grf.yaml | 21 +++----------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 7ac9aa5fa..8dc141410 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -82,9 +82,7 @@ allOf:
       properties:
         lvds:
           type: object
-
           $ref: /schemas/display/rockchip/rockchip,lvds.yaml#
-
           unevaluatedProperties: false

   - if:
@@ -96,8 +94,9 @@ allOf:
     then:
       properties:
         edp-phy:
-          description:
-            Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
+          type: object
+          $ref: /schemas/phy/rockchip,rk3288-dp-phy.yaml#
+          unevaluatedProperties: false

   - if:
       properties:
@@ -112,9 +111,7 @@ allOf:
       properties:
         usbphy:
           type: object
-
           $ref: /schemas/phy/rockchip-usb-phy.yaml#
-
           unevaluatedProperties: false

   - if:
@@ -127,16 +124,12 @@ allOf:
       properties:
         gpio:
           type: object
-
           $ref: /schemas/gpio/rockchip,rk3328-grf-gpio.yaml#
-
           unevaluatedProperties: false

         power-controller:
           type: object
-
           $ref: /schemas/power/rockchip,power-controller.yaml#
-
           unevaluatedProperties: false

   - if:
@@ -149,9 +142,7 @@ allOf:
       properties:
         mipi-dphy-rx0:
           type: object
-
           $ref: /schemas/phy/rockchip-mipi-dphy-rx0.yaml#
-
           unevaluatedProperties: false

         pcie-phy:
@@ -177,9 +168,7 @@ allOf:
       properties:
         reboot-mode:
           type: object
-
           $ref: /schemas/power/reset/syscon-reboot-mode.yaml#
-
           unevaluatedProperties: false

   - if:
@@ -203,9 +192,7 @@ allOf:
       patternProperties:
         "usb2phy@[0-9a-f]+$":
           type: object
-
           $ref: /schemas/phy/phy-rockchip-inno-usb2.yaml#
-
           unevaluatedProperties: false

   - if:
@@ -231,9 +218,7 @@ allOf:
       properties:
         io-domains:
           type: object
-
           $ref: /schemas/power/rockchip-io-domain.yaml#
-
           unevaluatedProperties: false

 examples:
--
2.20.1

