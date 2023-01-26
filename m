Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3CD67D8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjAZWky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAZWkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:40:51 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D6035A1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:40:49 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v19so2621872qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Z26JUx2ATLd/dkCoCkg+wifXJDNOjObbIUvuO+srwM=;
        b=K1hD81eySQ0tWy7XUcrWjImwQF9mnNjKUmmrAZjds3Aw4ZZ0JJx1WUEymQu1gI3EiD
         F9JiVInwc0C1Asm4Fo8dhs36pYCCYedqYQcPvmdv0rYCKou/AC7GGS3sDs5ivEbY2BiW
         TiR/RsSLlX4IPWE4/HRQNg/Qe0EuhlGdcRPSDIcF3sXXlr6xIH8rrdjdU7XJQlWa1pKp
         Vp3ooiqAZxpv3WXDD46BAXxJwrXRG0Tby/MWtPj82lRh11aOJArCDTjk0RLrKXHL7cEs
         rOeGv2NPwUeDNKFIsHGcqpD4D5MO/2bKCH/UXnb1sDOSKkYnFzAN74+XZ6v9VJaN9xVu
         EtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z26JUx2ATLd/dkCoCkg+wifXJDNOjObbIUvuO+srwM=;
        b=MGPC/mQNFJ802iCcRFOAJvuwwkl90QvoAkV9liK0CayoXpJfgSfl84TjdURjTEXNPt
         IaPvymNFzkf81f/PwcT2D4GuVKr3I0k+Z3RfQYfwVzigYY5xREAwkebuKoLwPaFek4b+
         akNIi15dbztYIoWcT3R4SFHvPbxQjLMh/iV2rHizGKArB3/7FC7po7A1B2fYv39SlbAX
         l9ZwzWbXcK76CQJw040lSoaDQkhhMejtWVld22cpbVQJAng2V1s3mQaPOfTedtC1WhIc
         TiY+BLejP6PKsGSyeh/K1txqEZOOAV0TP06UkI68dxDb1KZ0B3Di9hRd3lsolKrzMkJ/
         WVsQ==
X-Gm-Message-State: AFqh2kpa2nGLaDuuKtqcE/exmIieyVO42hcU/sPWIPJFbgqqx7Jrxxf8
        0RenP9sZ+tPTBnu2WIsJbWGA0w==
X-Google-Smtp-Source: AMrXdXsUfPXyBdUOaoFYOcJfrln3A3RCdHVL43+dK/IM1vZZMlbUOM98q/vo9MEsr4B51Er7NsSKAg==
X-Received: by 2002:ac8:6f09:0:b0:3b6:309e:dfde with SMTP id bs9-20020ac86f09000000b003b6309edfdemr64396988qtb.27.1674772848366;
        Thu, 26 Jan 2023 14:40:48 -0800 (PST)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id ek3-20020a05622a4fc300b003b68ea3d5c8sm1505678qtb.41.2023.01.26.14.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:40:47 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
Date:   Thu, 26 Jan 2023 17:40:42 -0500
Subject: [PATCH v2 1/4] dt-bindings: display: bridge: tfp410: Add tfp410
 i2c example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-tfp410_i2c-v2-1-bf22f4dcbcea@criticallink.com>
References: <20230125-tfp410_i2c-v2-0-bf22f4dcbcea@criticallink.com>
In-Reply-To: <20230125-tfp410_i2c-v2-0-bf22f4dcbcea@criticallink.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=ChyX0+O3QNta/wRqgPEb2AoAlselOk6fdkUsmDhZY9g=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBj0wFuFMqR89pfGZmdPhF+pwtHpym61u5iPDoVFk0N
 dKFZPvmJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCY9MBbgAKCRDc1/0uCzbrqpJhD/
 9lIdfkA8tiGvRTw7bZMK7o+oglBip9uQzPZ+wnANjsROcumDlucu9WujrWGavlRGW7ShilWBD9dgLx
 Wv4KYkIKDUSCzeBvTCt8sAmg7GKFjClTZUQTQzEmzAiHOFNYm7GZmvDFXQ1EPATRr4rmO+U2Xni88g
 pw/rGTlrgWc42vPYiuY8mfRdNNQjb6ritUdxPk1d8TeHSkihkVCwfcSW0zfNZ7+an+62dT+gBaHsD5
 /9aSW62LPR88px6ekim0UWQa8z3RxE0jQGenXZMt4/NCtqUV82eowNG6ysDJrWNwKo61BOJf3smom1
 bttnNHU3mYf6QwkHsExVC9JWJtlUr+Vch/VFUYJJJs73vxMRUOUjpk0CUK8njorLvAejGeZeBUJyyc
 IEHm/YpFC+Nttg/h5TELh1YF+QVOcCR4NA8nCz1m4bYQCnCs22AuaoBgjjvRri2TvnDXZ/cTxjBSyN
 cMd04FLx3gpLiBzHJ2E6czOJW+NQmWMFNuSqQes9+QLY7QmpCaRBaYobxsPNsJ0kWfuzY5cX4dLv0l
 ox9x4w4OgkAXH15aLhdCkK2f2jiNqAlOycDDlZtfCbbgSwihRhFGR1XxvShf+gx7gww9IRzIGB4ai4
 Z3SMI56RB6TO9TuB3zIm3UULujGRZIcq5RmI4EY4ut9UCDzLcCRJZw5gpgxw==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a i2c example with HDMI connector

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 .../bindings/display/bridge/ti,tfp410.yaml         | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
index 4c5dd8ec2951..1f3d29259f22 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
@@ -116,4 +116,34 @@ examples:
         };
     };
 
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tfp410_i2c: encoder@38 {
+            compatible = "ti,tfp410";
+            reg = <0x38>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    tfp410_in_1: endpoint {
+                        remote-endpoint = <&dpi1_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    tfp410_out_1: endpoint {
+                        remote-endpoint = <&hdmi_connector_in>;
+                    };
+                };
+            };
+        };
+    };
+
 ...

-- 
2.25.1

