Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC4D62EE2C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 08:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiKRHTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 02:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241002AbiKRHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:18:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3D872098
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:18:57 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d9so7855398wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 23:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFo0v4KNc4REjP1ZSh0NPt20T7LaZ0hO2WW0XyMGjCg=;
        b=KmXkPxIl/R8/F5oT/7mZUORqHKj+sPJXa6wgeXYfzNCuIV3LmB7HVmcOkGGU/c0cRD
         3fIcb1nlL7aSReeophpnLQ7Jf9GQuIi+pqe30bdcJd3958HEL7rc00d1aplmHfOZY+ap
         Mrf2+Ctb23p2TPN4djwVuN2895OKzbemmvUNtZCrV7og7Gdiu67etBGb/GP6hsTgXn9I
         YC1tbNpZwwXvopbmtmC9+Kq9uuSGXtwngoPN62HXj5pQyHzy2UIw8K0X6nb9otZa6/xS
         obOyxsMXkQuCwjyyCBakPosvCrQsJz5Ko+4gHrMMrMWxykn0s7YKclL7nkLdS1WfbFvx
         Qr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFo0v4KNc4REjP1ZSh0NPt20T7LaZ0hO2WW0XyMGjCg=;
        b=kWKPDl/JKB/0QerXsPTVWgtt66eKLYzH5+yE5eMOZABSnZduOlSp8sBz1bf0ZiZUR8
         QXrhKdwow+90HeJiu0V5oVhIFhyMj5sVGW3v5ceZbiV1gv0Lt1JlkzBPBu2RCCcuCBXf
         TcLnRiZYGxMI0WtDkzBvTa8NcJwq/8eA1rZerz+gACzEoLta3G44dVmeWYcFW5uOpH+q
         uOUpXbRGeZH3nDarmTowRFfFXJU2wnbqOo74dBvI1AGBI5ZRGSZ2stdbc1C4BDLCwtq1
         mQpBKOdixkCsrAIeTw39r0Paskffjypw/3vtTOy+rLgNjINPg7NFEJCvYMQ4e5EwCrYm
         7FwA==
X-Gm-Message-State: ANoB5pl2g+jpyAmcU46h90DRIRAxysvQa6FBVohF2BqzcXm8Q4Ru8lmO
        db3unDVkN4zddi2uD6xW7mJoKw==
X-Google-Smtp-Source: AA0mqf5zFz7PnrSQFfguNBbj0H3t7AhE02V4UlfSsryCTAVwFxwhryqUZGaaREdA9buZL/wnfwEhXg==
X-Received: by 2002:a05:6000:1c4:b0:241:792f:a914 with SMTP id t4-20020a05600001c400b00241792fa914mr3478420wrx.117.1668755935610;
        Thu, 17 Nov 2022 23:18:55 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j16-20020adff010000000b002302dc43d77sm2754349wro.115.2022.11.17.23.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:18:55 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/2] ASoC: dt-bindings: lpass-va: add npl clock for new VA macro
Date:   Fri, 18 Nov 2022 07:18:48 +0000
Message-Id: <20221118071849.25506-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118071849.25506-1-srinivas.kandagatla@linaro.org>
References: <20221118071849.25506-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPASS VA Macro now has soundwire master to deal with access to
analog mic in low power island use cases. This also means that VA macro
now needs to get hold of the npl clock too. Add clock bindings required
for this.

As part of adding this bindings, also update bindings to be able to
specific and associate the clock names specific to the SoC.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,lpass-va-macro.yaml   | 63 ++++++++++++++++---
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index c36caf90b837..288a1d5ad585 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -27,16 +27,12 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 3
+    minItems: 1
+    maxItems: 4
 
   clock-names:
-    oneOf:
-      - items:   #for ADSP based platforms
-          - const: mclk
-          - const: core
-          - const: dcodec
-      - items:   #for ADSP bypass based platforms
-          - const: mclk
+    minItems: 1
+    maxItems: 4
 
   clock-output-names:
     maxItems: 1
@@ -60,6 +56,57 @@ required:
   - compatible
   - reg
   - "#sound-dai-cells"
+  - clock-names
+  - clocks
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sc7280-lpass-va-macro
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          items:
+            - const: mclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm8250-lpass-va-macro
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: mclk
+            - const: core
+            - const: dcodec
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-lpass-va-macro
+              - qcom,sm8450-lpass-va-macro
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: mclk
+            - const: core
+            - const: dcodec
+            - const: npl
 
 additionalProperties: false
 
-- 
2.25.1

