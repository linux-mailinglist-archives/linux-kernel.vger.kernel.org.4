Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781836AE075
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCGN1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjCGN0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:26:49 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3432FCF8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:26:35 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id x6so13164628ljq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678195593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/83GeW+k79u272pQGTACZ8P8QoN5s3z+qgGSys7KadQ=;
        b=eLHscYxdeTg0PAfjF3EYyc6US60bNrQVoEaNdN8SHJaMy1dQ0sqIuUtn57/gpd9Huc
         iQLE9HNHssAD6k/mFF9oyzToCvJomuxsC9vFPhJ1z7vQ369Tc8Pz+nV69MIma51mT1Hm
         TExMJ8qOU3KDTCEahwWQJrSK4grIYmOAy6Obld5y9SN66pc+IltBVl4ikHUia+HW4z/z
         bWQb8V50oGLxdbRYOKKoshDFuDg6q0HCYczARapfFurQn9ZbJFXzGKOPc6xJlH2kaJVL
         u4xlNvW5v2Owuxd/cCrck9s6bqEFOHhkPWxdYKOPV06Wzhp5Yhf/N0lwLqf5XWwGgQux
         1mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678195593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/83GeW+k79u272pQGTACZ8P8QoN5s3z+qgGSys7KadQ=;
        b=jMROmeJeoGvQojOPNp5ztsNZBSYp05K0Pp4LXkpP5Lq3Hjae8paGnjCGEZxNQmESSq
         kc/lLleeflMmj7pShP3ukmNS5OiARMpWCuP0AsjRlw/DOhGqiBe3XueDJTSbVhdmr6VO
         bEdPc1zOqan9VlRs+1wX4BUMRdb6ox2Cq621l4KtF54uy6T/raZ/E8p+lO717ZczQwhi
         ZsQUS6LZocigd0zn5lQT+L8yeZSgKTKoXv0Mz5K5xAxRcxm+JMcq24WW3KB9TvhmQlJ7
         QFEXv412MUUBh5vliacWcfNtxKOBvToVBqoa8wy6K7MSVEBD4bNmzKNzud6YQo9wDJ2h
         ntBg==
X-Gm-Message-State: AO0yUKVbM1MQfE+11xGFaAIfOsjh8x8WtXlNhZSYM0pvG8ORRFEKu7V+
        v5P0BpemuLEFZxIY1pfVoL5hburbND9jWMV6ogQ=
X-Google-Smtp-Source: AK7set+m4xPGkwvcjxrsa0xqJiCBCyDCtSpTuDesw6kI58ORRZqHfRWaqwjvJMMJC9W1NNYa9+Momg==
X-Received: by 2002:a05:651c:112:b0:290:8289:8cba with SMTP id a18-20020a05651c011200b0029082898cbamr4799799ljb.8.1678195593555;
        Tue, 07 Mar 2023 05:26:33 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id m22-20020ac24256000000b004dc53353d15sm2016169lfl.281.2023.03.07.05.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:26:33 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 07 Mar 2023 14:26:27 +0100
Subject: [PATCH v2 1/2] dt-bindings: display/panel: Add Lenovo NT36523W BOE
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-lenovo-panel-v2-1-2e2c64729330@linaro.org>
References: <20230217-topic-lenovo-panel-v2-0-2e2c64729330@linaro.org>
In-Reply-To: <20230217-topic-lenovo-panel-v2-0-2e2c64729330@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678195591; l=1971;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BL6PgSWTw3k5Fir1Htah32UMjqvFC7StjU4GIG0OqbM=;
 b=rJQlwZtqp7lJNd9CtmzwgYa0SBSj0oonaAuJF9ITro8esekS7gxHnLDRqJ+Ou/NdexWOeXwAppaX
 q0NtCAiFDrC0eTEGaxL9o8xmirics2OUrimDr8L4geKq2E+krbVl
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the 2000x1200px IPS panel found on Lenovo Tab P11/
XiaoXin Pad devices.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../display/panel/lenovo,nt36523w-boe-j606.yaml    | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/lenovo,nt36523w-boe-j606.yaml b/Documentation/devicetree/bindings/display/panel/lenovo,nt36523w-boe-j606.yaml
new file mode 100644
index 000000000000..43dcbe3f9f30
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lenovo,nt36523w-boe-j606.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lenovo,nt36523w-boe-j606.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NT36523W BOE panel found on Lenovo J606 devices
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: lenovo,nt36523w-boe-j606
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  vddio-supply: true
+  reset-gpios: true
+  rotation: true
+  port: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - reset-gpios
+  - port
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "lenovo,nt36523w-boe-j606";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 82 GPIO_ACTIVE_LOW>;
+            vddio-supply = <&pm6125_l9>;
+
+            rotation = <180>;
+
+            port {
+                panel0_in: endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
+...

-- 
2.39.2

