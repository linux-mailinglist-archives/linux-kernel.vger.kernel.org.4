Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635B5617D5E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiKCNCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiKCNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:02:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE79140B3;
        Thu,  3 Nov 2022 06:01:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y69so2870761ede.5;
        Thu, 03 Nov 2022 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZWrkx//J0EsJcOiPtQ2AzCqMEINB9X17hPf/F/cMpo=;
        b=qqI83zYHLBlYxE6D3VsxMCkiYu4kqRLp5lrdMH2UNv85xZbjcVE3jb3tvfPnLH9+QT
         WA3jox4ILcz2Mgzd4F7UdwKE7oHK219VgnA0/IRn2hbxtdf73UIYdQ1om7iUBJCzPoXy
         SX/+z4hVjd3ub6AQXv4D3BJZYsZL0uR92Waw49MdRzNxJXj0B+VPUx81cpVXgXoToHvx
         AOwFqW9NiUi0t7aQ3d9QR50sAN6/jMVvYDOqJ/qVd9NNU6D97yeAj1r27meQGqMews72
         6N6U+lvg8oHY/mpw662HtyzXT1POJoA6zWMpE8VAPj7/APyuw+JkvVDVRto0GpQJh9Ii
         O+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZWrkx//J0EsJcOiPtQ2AzCqMEINB9X17hPf/F/cMpo=;
        b=AMDIFQ3rZ+6ZRTvkQ9aYPFlV7TwLtNFCeFDVj/Y6BW7Q20Fn7MhyT4UMoBsCn4d/ce
         cbBI1Fw1Hr4piFko8yXfD3uc8SbNga239LFiicGUmeMzQv5zvL8TZYCosS7loWWvhz5D
         VJClEAoPWIkyOe7TR/TWxl7S6zS426h2nfzglF7kvCCoFnCZ9kgDpuo9KgzPvOlDmfLQ
         R27codKUvChvgi/cLNp6zl8y4tWLBOr2MGLtsugNQRqFTruzk4Ui2y37kSiHor1NHlDh
         2mfM2tA+ym5pUQ2uBDyBCOn4pyAhKf9N8Y1jM8bfKMusskumUzviKfOluCiFEh/SV5Dl
         stAA==
X-Gm-Message-State: ACrzQf3Tc9V73+YUXW3krncXQq+eztcKjWBaH2tbThbRD/pv8mo5W4Jl
        Pen5cU35D6TPZIdnmEG/g9o=
X-Google-Smtp-Source: AMsMyM6m6YVsfZa6PSWykA5X/tB7/u42jhsxSh0gNWTLK+s6BEjsWwxY8qdWV+BdG07uuadScN5EuA==
X-Received: by 2002:aa7:cc13:0:b0:453:52dc:1bbf with SMTP id q19-20020aa7cc13000000b0045352dc1bbfmr30403160edt.30.1667480497446;
        Thu, 03 Nov 2022 06:01:37 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:37 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 12/13] dt-bindings: iio: temperature: ltc2983: support more parts
Date:   Thu,  3 Nov 2022 15:00:40 +0200
Message-Id: <20221103130041.2153295-13-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103130041.2153295-1-demonsingur@gmail.com>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

Add support for the following parts:
 * LTC2984
 * LTC2986
 * LTM2985

The LTC2984 is a variant of the LTC2983 with EEPROM.
The LTC2986 is a variant of the LTC2983 with only 10 channels,
EEPROM and support for active analog temperature sensors.
The LTM2985 is software-compatible with the LTC2986.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml | 60 +++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index bd357ff28e65..ccab94b20b24 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -4,19 +4,30 @@
 $id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices LTC2983 Multi-sensor Temperature system
+title: Analog Devices LTC2983, LTC2986, LTM2985 Multi-sensor Temperature system
 
 maintainers:
   - Nuno Sá <nuno.sa@analog.com>
 
 description: |
-  Analog Devices LTC2983 Multi-Sensor Digital Temperature Measurement System
+  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985 Multi-Sensor Digital
+  Temperature Measurement Systems
+
   https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/2984fb.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/29861fa.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ltm2985.pdf
 
 properties:
   compatible:
-    enum:
-      - adi,ltc2983
+    oneOf:
+      - enum:
+          - adi,ltc2983
+          - adi,ltc2986
+          - adi,ltm2985
+      - items:
+          - const: adi,ltc2984
+          - const: adi,ltc2983
 
   reg:
     maxItems: 1
@@ -386,6 +397,35 @@ patternProperties:
         description: Whether the sensor is single-ended.
         type: boolean
 
+  "^temp@":
+    type: object
+    description: Active analog temperature sensor.
+
+    properties:
+      adi,sensor-type:
+        description: Sensor type for active analog temperature sensors.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        const: 31
+
+      adi,single-ended:
+        description: Whether the sensor is single-ended.
+        type: boolean
+
+      adi,custom-temp:
+        description:
+          Used for digitizing active analog temperature sensors.
+          See Page 67 of the LTM2985 datasheet.
+        $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        minItems: 3
+        maxItems: 64
+        items:
+          items:
+            - description: Voltage point in nV, signed.
+            - description: Temperature point in uK.
+
+    required:
+      - adi,custom-temp
+
   "^rsense@":
     type: object
     description: Sense resistor sensor.
@@ -413,6 +453,18 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ltc2983
+              - adi,ltc2984
+    then:
+      patternProperties:
+        "^temp@": false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.38.1

