Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F46542D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiLVOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiLVOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:24:19 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D435BCBB;
        Thu, 22 Dec 2022 06:24:18 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id tz12so5233223ejc.9;
        Thu, 22 Dec 2022 06:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LnWhFDszNMI8+kb0kwDjwW0IO0VieHrS+DBjt8KEoSM=;
        b=cuFW0RTjiVDBdjiwgwJQVjfjjPxXLiH9SW6vNyZZT/0l+q7G1n/JB0x7gqXcaCVi/f
         eXG+dJt+DxN8IhfYygw5ufplocdh64KCshIotuIEHdVVvXRRkXNa10xNVnDpMQwBuznZ
         fs32PWrIK/UMzp1U5b+ytjdj7IFjCyNc5eRXWmBMGc5iOp6U6J8vNBNDiYGwusCCR/iG
         ktcB8G4hUnc50wXJHYkUEcgjZBaImBefO7nZ2HCrzsqBpTem/B/vOvoz711Yov98rc5J
         7luzBlQT9wZWUkdFuJ+W6cNtXAow2S3dMuhVHdYF48zu25TdAV9utgAXuVasjk7HJvIK
         v6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnWhFDszNMI8+kb0kwDjwW0IO0VieHrS+DBjt8KEoSM=;
        b=YJ5axAe4S3TvjXYhA3IroHDRivssk8cdsBk12p977XPKnmoqeM2y4Cj7m23dIN9Y0s
         510VhZ9lCRM0TQ8lX6otKbXq72+ERP981sZx7lmfr7tQWuZ8dLKo8h3yPaIV6RMqyMCj
         R3ztdtqO5SlF5AQP2oJ6mcE22l8/BJw37MwOA5Nm932zv5l8XnpKeJ8qv2duMlx75t3W
         V5OvbQnEiZGF6Lp1outU4wK7ScKna7ojsAfWgz/MYGcLiBOrl+SppqKabnfBwIHepjVz
         D4xFFtnyxxV/Ay6iyNK0/DACLwy7ZHt9L4oW4mEFTc6genveDg3DgPwWmLWp5+fyzH+L
         yahA==
X-Gm-Message-State: AFqh2kqM4mjd2CHvAq5Gd6gnSwxjGj8ks1iA6tNrzAj0a3JIGVm4C748
        2pHbaagypWwtrl/9Fohuzn4=
X-Google-Smtp-Source: AMrXdXvroVpUBN7+mAP+hqeudjOkt5RRg2uy5FfYK2PWzHmdu0pl+Jqa8DrSEN30FJFKNCbQJOqIPg==
X-Received: by 2002:a17:906:6dd4:b0:836:e6f7:8138 with SMTP id j20-20020a1709066dd400b00836e6f78138mr5338891ejt.13.1671719057163;
        Thu, 22 Dec 2022 06:24:17 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id y3-20020a056402134300b0047f5f5bb5fasm415838edw.62.2022.12.22.06.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:24:16 -0800 (PST)
Message-ID: <ff3644da-e5ae-f795-c7d9-454b8c8bdfe8@gmail.com>
Date:   Thu, 22 Dec 2022 15:24:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 02/17] dt-bindings: soc: rockchip: grf: add
 rockchip,lvds.yaml
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
Content-Language: en-US
In-Reply-To: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
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

Add new converted rockchip,lvds.yaml to grf.yaml file.
Prepare for more SoCs with lvds output.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changed V5:
  Drop the quotes
---
 .../devicetree/bindings/soc/rockchip/grf.yaml | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 2ed8cca79..7ac9aa5fa 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -75,13 +75,17 @@ allOf:
       properties:
         compatible:
           contains:
-            const: rockchip,px30-grf
+            enum:
+              - rockchip,px30-grf

     then:
       properties:
         lvds:
-          description:
-            Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
+          type: object
+
+          $ref: /schemas/display/rockchip/rockchip,lvds.yaml#
+
+          unevaluatedProperties: false

   - if:
       properties:
@@ -109,7 +113,7 @@ allOf:
         usbphy:
           type: object

-          $ref: "/schemas/phy/rockchip-usb-phy.yaml#"
+          $ref: /schemas/phy/rockchip-usb-phy.yaml#

           unevaluatedProperties: false

@@ -124,14 +128,14 @@ allOf:
         gpio:
           type: object

-          $ref: "/schemas/gpio/rockchip,rk3328-grf-gpio.yaml#"
+          $ref: /schemas/gpio/rockchip,rk3328-grf-gpio.yaml#

           unevaluatedProperties: false

         power-controller:
           type: object

-          $ref: "/schemas/power/rockchip,power-controller.yaml#"
+          $ref: /schemas/power/rockchip,power-controller.yaml#

           unevaluatedProperties: false

@@ -146,7 +150,7 @@ allOf:
         mipi-dphy-rx0:
           type: object

-          $ref: "/schemas/phy/rockchip-mipi-dphy-rx0.yaml#"
+          $ref: /schemas/phy/rockchip-mipi-dphy-rx0.yaml#

           unevaluatedProperties: false

@@ -174,7 +178,7 @@ allOf:
         reboot-mode:
           type: object

-          $ref: "/schemas/power/reset/syscon-reboot-mode.yaml#"
+          $ref: /schemas/power/reset/syscon-reboot-mode.yaml#

           unevaluatedProperties: false

@@ -200,7 +204,7 @@ allOf:
         "usb2phy@[0-9a-f]+$":
           type: object

-          $ref: "/schemas/phy/phy-rockchip-inno-usb2.yaml#"
+          $ref: /schemas/phy/phy-rockchip-inno-usb2.yaml#

           unevaluatedProperties: false

@@ -228,7 +232,7 @@ allOf:
         io-domains:
           type: object

-          $ref: "/schemas/power/rockchip-io-domain.yaml#"
+          $ref: /schemas/power/rockchip-io-domain.yaml#

           unevaluatedProperties: false

--
2.20.1

