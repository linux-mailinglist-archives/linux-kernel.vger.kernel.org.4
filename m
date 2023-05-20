Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1F070A756
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjETKxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjETKxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:53:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7BABA;
        Sat, 20 May 2023 03:53:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-255401f977dso92773a91.2;
        Sat, 20 May 2023 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684579996; x=1687171996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2Flc+umkv9dYlbkZdtlsTRHK8tgRPIuGdGuQOdfjXU=;
        b=sUUQJQLqDmz00Y+NpimGaI39GTznVVNmQDSiJlmQ05z/VXRK+XEZc7MxvTFClGAN4Y
         W1dUgcJtIuQata/23+gTWYlMqECMPcFvF2TuCsnxoEjNBZFnCz6Z2Mel4OX0tCnL86qo
         n/lbCYg9RzFKaiAX3HztHaQv1zI/lHHEQIk9ilJZkROXmZLTPV04z9U557Avuq9KB4jE
         3KQEs5Pj2TTBGw0BYKOBpnHdEoyulHo/oH4F2raEwO3vfqNZjYzbuoWJ3j/ELV7lwqt4
         5Bipamk5h/pSJHJ9QwvFIIR2MaW+PpizYxFDZmyZWApkXX29roTCuxaUTJU5kFdJMu/q
         n8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684579996; x=1687171996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2Flc+umkv9dYlbkZdtlsTRHK8tgRPIuGdGuQOdfjXU=;
        b=D2Ip/2gFIrbKE88xCaNPD3tv6gCF9tJwnkoqsvVmBFWGMUrruXcqSRuu0EUIxXzdPT
         8k/PelLrxQDcyaFetKU2Lgoggg/AjvhzhJdo626r26DwRjMU+SJNqF5iK7AfKYkhG05T
         es04yR6BjIVFClYM1C/b9/jGalwaLlrhna7uyRlYlG57iKbXN+5LXNwT32ocZvHuzLGv
         k53+Zz/OnFCYaapdPxawvSqem7+fIJatKsiZLz+0EzKEH96E3pJFDGD2QnlODsENUqeL
         0/1pYq63ennZ/Jarj1upVpvqhLnS5Co50TCq/5BXjsgeFcGHMAXkKPClnj7Wmwi1/Q2o
         gMWg==
X-Gm-Message-State: AC+VfDwE0CbK3E6vbAYLsQzjDQkKF+RalUR13KIFkzwW/mMWDnkZ3KAr
        m83C+wT4kHHd6WEpHDFXVZ/0EYmB9otrSHSE
X-Google-Smtp-Source: ACHHUZ6eD45MgvcMJzfKIezETpCJsw9UiLAKMt3UDX18u0vEk9m/Eh12lKnBMtX1sZN/C+IRbZbSlw==
X-Received: by 2002:a17:90b:3847:b0:250:ca46:dfe1 with SMTP id nl7-20020a17090b384700b00250ca46dfe1mr4343224pjb.48.1684579995680;
        Sat, 20 May 2023 03:53:15 -0700 (PDT)
Received: from yoga ([2400:1f00:13:245c:9b1a:1a9d:79c2:5b3b])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090ac25700b0024e07ae2cfesm988687pjx.38.2023.05.20.03.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 03:53:15 -0700 (PDT)
Date:   Sat, 20 May 2023 16:23:07 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        u.kleine-koenig@pengutronix.de, andriy.shevchenko@linux.intel.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: temperature: Add support for tmp006
Message-ID: <3bbda3b1402a26cdafc95c7685679f2311365cad.1684579603.git.anupnewsmail@gmail.com>
References: <cover.1684579603.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684579603.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for TMP006, IR thermopile sensor.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
Changes:
V1 -> V2: Removed redundant dt-binding from subject.
          Added supply information.
          Adhere to the generic node name.
	  Adding missing semicolon to fix syntax error detected
	  using dt_binding_check
---
 .../bindings/iio/temperature/ti,tmp006.yaml   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
new file mode 100644
index 000000000000..d43002b9bfdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/ti,tmp006.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TMP006 IR thermopile sensor
+
+maintainers:
+  - Peter Meerwald <pmeerw@pmeerw.net>
+
+description: |
+  TI TMP006 - Infrared Thermopile Sensor in Chip-Scale Package.
+  https://cdn.sparkfun.com/datasheets/Sensors/Temp/tmp006.pdf
+
+properties:
+  compatible:
+    const: ti,tmp006
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: provide VDD power to the sensor.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        temperature-sensor@40 {
+            compatible = "ti,tmp006";
+            reg = <0x40>;
+            vdd-supply = <&ldo4_reg>;
+        };
+    };
-- 
2.34.1

