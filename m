Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC85646291
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLGUno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiLGUnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:43:37 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AF927CD9;
        Wed,  7 Dec 2022 12:43:36 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so12037399otl.10;
        Wed, 07 Dec 2022 12:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEwpHty4elixafpE9VoyApenzrPDPlvITLCjJ/4fxLg=;
        b=Uq2lRDPsnii+efMkw4ZrCngFUWEOM5LJRcpYoPiG3y9n20Y9wT+pnNMw0lhpTBeIeR
         qZerx9FRM2jMBcvK9nq1SMAGLE1O+4STDkiVpceHR9NyCzlC6YIYBA9pXfjPnlsissFf
         Q9NUFaPcwJdl/7+zHjZQSm0lPaR0gtgK2Hx5iM4sHziH19uyWGvMaYG8ekX/mTXwxEcG
         dPkOeEt3xmEW6BF+BsV0p+gkmaIEvwT8VpWqObNBGS3KlhM3pnwIv0GQaLcmQfVEGP7R
         OI3wC/jKEovwezOtXa2EDL+hUxX2DTFqpr9Bh0hzmSLyAwJCWZG5lhrP8vCDSQsjc3xO
         /+7A==
X-Gm-Message-State: ANoB5pnDzVfPugdKNfFXzeE4hvFj4RVD5nCn/RF7qGgzskzZonWsPUnU
        ZBNQatLW6SABmXHQ27lBfA==
X-Google-Smtp-Source: AA0mqf45B3e2Qmlb+2p55qLWRUyHWXllC5gykTPV7GiGZ6Mr2MN0ZGFh41A6Kzg8pbyOimTIMeEgHQ==
X-Received: by 2002:a9d:1b10:0:b0:66e:6964:1f20 with SMTP id l16-20020a9d1b10000000b0066e69641f20mr16917173otl.296.1670445815581;
        Wed, 07 Dec 2022 12:43:35 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w18-20020a056871061200b00144bb1013e6sm3827191oan.4.2022.12.07.12.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:43:35 -0800 (PST)
Received: (nullmailer pid 2810197 invoked by uid 1000);
        Wed, 07 Dec 2022 20:43:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yi Xin <Yixin.zhu@intel.com>,
        Mallikarjuna reddy <mallikarjunax.reddy@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] dt-bindings: leds: Add missing references to common LED schema
Date:   Wed,  7 Dec 2022 14:43:27 -0600
Message-Id: <20221207204327.2810001-2-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207204327.2810001-1-robh@kernel.org>
References: <20221207204327.2810001-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'led' nodes should have a reference to LED common.yaml schema. Add it where
missing and drop any duplicate properties.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/leds/leds-lgm.yaml       |  3 ++-
 .../devicetree/bindings/leds/leds-max77650.yaml  |  9 ++-------
 .../bindings/leds/rohm,bd71828-leds.yaml         | 16 +++-------------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lgm.yaml b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
index 3f13db0dc915..8b3b3bf1eaf2 100644
--- a/Documentation/devicetree/bindings/leds/leds-lgm.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
@@ -56,7 +56,8 @@ properties:
 
     patternProperties:
       "^led@[0-2]$":
-        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
 
         properties:
           reg:
diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.yaml b/Documentation/devicetree/bindings/leds/leds-max77650.yaml
index c6f96cabd4d1..fdb08f44a45d 100644
--- a/Documentation/devicetree/bindings/leds/leds-max77650.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-max77650.yaml
@@ -30,9 +30,8 @@ properties:
 
 patternProperties:
   "^led@[0-2]$":
-    type: object
-    description: |
-      Properties for a single LED.
+    $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       reg:
@@ -41,10 +40,6 @@ patternProperties:
         minimum: 0
         maximum: 2
 
-      label: true
-
-      linux,default-trigger: true
-
 required:
   - compatible
   - "#address-cells"
diff --git a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
index 86a37c92b834..ca92cea56a6f 100644
--- a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
+++ b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
@@ -26,26 +26,16 @@ properties:
 
 patternProperties:
   "^led-[1-2]$":
-    type: object
-    description:
-      Properties for a single LED.
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
     properties:
-      #allOf:
-        #- $ref: "common.yaml#"
       rohm,led-compatible:
         description: LED identification string
         $ref: "/schemas/types.yaml#/definitions/string"
         enum:
           - bd71828-ambled
           - bd71828-grnled
-      function:
-        description:
-          Purpose of LED as defined in dt-bindings/leds/common.h
-        $ref: "/schemas/types.yaml#/definitions/string"
-      color:
-        description:
-          LED colour as defined in dt-bindings/leds/common.h
-        $ref: "/schemas/types.yaml#/definitions/uint32"
 
 required:
   - compatible
-- 
2.35.1

