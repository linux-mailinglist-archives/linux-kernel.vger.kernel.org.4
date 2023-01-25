Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0E67BDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjAYVKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjAYVKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:10:24 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B04C5AA62
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:09:21 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id g16so15153554qtu.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUjI7H8s1MYo6Cc+S/e5j/o7dI4Q79O1EcwP8gpHRPk=;
        b=WmRJE2Mq3Y+K4158GTsOqdZvqf33NCVXb6of19VtyNo0PcicmQNERhsu7pw2PcRyMm
         Vz1utLmAmbd1YPUFxI8pDqWLvZqh8Rpe1qY5VMxVQb9rjYMgI7FGlHWwb5OwFCQUxtU9
         gu6GkH6MCUev7XYvuuPwgWfw3yYbBZ8wPe3KKpEmp2INlv+S5MxtUFVPluSh9Yehpeag
         lneKEXSp4XmuqFuwtRRRSQ3tDAivnOQDLNvK7BnK6XYRICC/GTej7dWLLc05kpFbk5KH
         WXiJxzmzgQ7fLEVaV4LSzo52layZX7CYhG/CEYGDr4J6GI8rIwa4ihRSPRq0LRgQbMLq
         q3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUjI7H8s1MYo6Cc+S/e5j/o7dI4Q79O1EcwP8gpHRPk=;
        b=xdpEnAtkRtdyoV3MaEL2Ef7uYm6M15ZxlVe5nrRB4QX7s/hDfvRhY2kqts2bpmy3uZ
         1Y35a41hWMCKRL80EPERNMB2SoXkI3D96jvWVrvsrL45v6RxSa8F7PNJqZ5k5evIhE3b
         hEWxjR3wyHpVs00ocH4qLkALC3HQoza2w00juPygft1KGgsxllBx8P2O6oz3DbEZlabw
         V4xT7FVhnVYoxfH2/i9P/OyhvngzLOLO0yb3fM3vj8+uaasIZ895Sh6UVWgNUEnaO44a
         lVXRFxPu6Musn2rHTnljEV1ADhvKVNaDCU/UI7mZKxwok0KKZu6dds7ZiHRcDXDPCw7m
         aXBw==
X-Gm-Message-State: AO0yUKX1dwWqUB3AUIWOqCvudS6eOgIETuo9uq+Fsv7FJcDhjPrlOEu1
        ak+wlWYmLRdfMCYuih6SrDzKgw==
X-Google-Smtp-Source: AK7set/LFwRd97nXfvUIMK9E+mfcx8BXRdqiOH5s3Omo2pLcZSQ1uH9j29+CP3CpGJkFx/IsNFZRpA==
X-Received: by 2002:a05:622a:494:b0:3b6:4249:bbca with SMTP id p20-20020a05622a049400b003b64249bbcamr7001049qtx.55.1674680958298;
        Wed, 25 Jan 2023 13:09:18 -0800 (PST)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id q196-20020a3743cd000000b0070736988c10sm4177090qka.110.2023.01.25.13.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:09:17 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
Date:   Wed, 25 Jan 2023 16:09:09 -0500
Subject: [PATCH 1/4] dt-bindings: display: bridge: tfp410: Add tfp410 i2c example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-tfp410_i2c-v1-1-66a4d4e390b7@criticallink.com>
References: <20230125-tfp410_i2c-v1-0-66a4d4e390b7@criticallink.com>
In-Reply-To: <20230125-tfp410_i2c-v1-0-66a4d4e390b7@criticallink.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.11.3-dev-d001f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=Ne8kM0iOMcS7U5BkEx6jIQptCk+Yyk87jfs/YUNCJd4=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBj0Zp7UF8IgNYOldWOmS1L7oYJE1M9wa/rtzY7bwpg
 As8z5cOJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCY9GaewAKCRDc1/0uCzbrqqg7EA
 C2dSK8WyTKgvw8F11qy4Z57FlvkXXc96GXak0aeWgH2SeRpR5VeUg//WoWgoLALeN+yr8Zer8VbHx9
 pYkAJzmmmSA3eym1PtscHMdHF6EY79tufpY5cBN7TZAtRI5TJ5aX8zLzKKeEzQ7DZfhCrUuNKnqoND
 FzpVO+M3yYubTnp1tqgWPQz3zhGVnTTlXkYcyXs50CBDXj7R/1sJlpgCvspkPXynYobaS6cGzv5D3Z
 TDStjQmbbYqb0x7jyiR0SjoHeLlNB+1rnzGJ16Ez857rqo/A8kibojKWUxFcytWROpT8kHrDOh8LIb
 LWFBy2WZMsvU0kxCD9bjy7TQ4g7CgSOeRa9effsX1yAMQiAOQ4TUUpDRdVwCGusV5DKnfNRn+xEVpl
 6cY4jSTz3SkG4GgX66jGvQv5xgrML5TV+cCRyQVx4TkiW9PB71nZkVn7STWc8dZRlNh+OMuhU0R/zU
 lCp3ZAoa1vwnPuHy5tKYxjgjEruwsMWN56zPS/J6SQz5nh4IAZzQL0DstS4g9r1LvGcnDFzX1Nlh6d
 mC1V41L9Om+BYLIQSv9pVWG1+GniW/s1W+jLE8JzWBJxeGnIwYwC7seD/IdE3VL5IVK6Hcez1jypOk
 1PEqO9BLxE1tU6fzFaddvLptinwdYV3oJ/GuSZc2zaLglaY7AUgCyNn2tAjw==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a i2c example with HDMI connector

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 .../bindings/display/bridge/ti,tfp410.yaml         | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
index 4c5dd8ec2951..456214f14b47 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
@@ -116,4 +116,46 @@ examples:
         };
     };
 
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hdmi_encoder: tfp410@38 {
+        compatible = "ti,tfp410";
+        reg = <0x38>;
+
+        ports {
+          address-cells = <1>;
+          size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+            tfp410_in: endpoint {
+              remote-endpoint = <&dpi1_out>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+            tfp410_out: endpoint {
+              remote-endpoint = <&hdmi_connector_in>;
+            };
+          };
+        };
+      };
+    };
+
+    hdmi: hdmi_connector {
+      compatible = "hdmi-connector";
+      label = "hdmi";
+      type = "a";
+      ddc-i2c-bus = <&i2c1>;
+      port {
+        hdmi_connector_in: endpoint {
+          remote-endpoint = <&tfp410_out>;
+        };
+      };
+    };
+
 ...

-- 
2.25.1
