Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E82653611
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiLUSV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiLUSVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:21:50 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFCFE0E0;
        Wed, 21 Dec 2022 10:21:49 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vv4so38854325ejc.2;
        Wed, 21 Dec 2022 10:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LnWhFDszNMI8+kb0kwDjwW0IO0VieHrS+DBjt8KEoSM=;
        b=e4QXwP2bOGr70buxskh5jSIRLAz2fiCw6a7TkqnVMqf6kQc8erSqQoBaELH2aH2bGX
         +OhWrtWxvzzLnS4EB1Z/WItKht8rqJDCaWex1meDWrYXa+Rf8K27ungyyTEdfZdQGr0/
         TZ+GcobpkVXE+RRBF5vSnCiQM2VR3LlrIu8ezR3P99wcT79A6f6OxtpIiQecSh66Em5m
         /y+c7mQFXe4qETizgKgslXpVumXoWgFysiRxzVdA+7G5bKOyDfpvFFhsRI26ZfqeBWeK
         2NeZhumocnv5e9v9/P1kVF9Bw3OmtPJflSyrRz+e7GHe7amNV/B8NYXMQSZTkY2RPuyi
         0l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnWhFDszNMI8+kb0kwDjwW0IO0VieHrS+DBjt8KEoSM=;
        b=gtQk+qrTusm57gFE2gID832SGVFCeTOfp1ner15e90aVFU34HJAJ24zMibjcPNl8qf
         2YjCFRsQvtv3an21ycpgfSIwsWEtJw/zIb7yGoc1fAhTVvv4km1CdW35BvfvzvsbXGg8
         BsQWoFrH+orz9tT7dnhwnV4+j8Mh+0zGxTtv/mUjbJGQeFwDo2w+49SRW3fZAfqCyCRc
         DSlZR9imgpYwyn0OkpQQExcUUgdqASERhCggDLWy37h3QnI38Y5GzikuFnCm2V9Rcyif
         o3TcnEtTaXPjAUFlH/xVoFdIXYA4E6a2Zx4XDv1JWAR/jYxtfHIbDTKckG4jgoAQJmB/
         AS0A==
X-Gm-Message-State: AFqh2kqEq0rWb8flRJ/0OdpzccqJPTz7cktwBiX2arTx9wskhrlB3mTj
        VzHY2eI+x7SS61Z0IEwbFIA=
X-Google-Smtp-Source: AMrXdXvErNmURo35q8fo78e8suJHy6UEA0KsAxDbpARLlpS4MeoU//sFxO9B6BpmqIFm1jNcxrASHg==
X-Received: by 2002:a17:907:a0d0:b0:7c1:55aa:2e84 with SMTP id hw16-20020a170907a0d000b007c155aa2e84mr2166799ejc.1.1671646908172;
        Wed, 21 Dec 2022 10:21:48 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id e22-20020a17090681d600b007c0d0dad9c6sm7424130ejx.108.2022.12.21.10.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:21:47 -0800 (PST)
Message-ID: <e5e782d0-5255-518a-af4b-f103eeac2014@gmail.com>
Date:   Wed, 21 Dec 2022 19:21:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 02/12] dt-bindings: soc: rockchip: grf: add
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
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org
References: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
Content-Language: en-US
In-Reply-To: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
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

