Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F023F701F21
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 21:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjENTCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 15:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjENTCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 15:02:10 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C8CD;
        Sun, 14 May 2023 12:02:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-528cdc9576cso8145340a12.0;
        Sun, 14 May 2023 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684090927; x=1686682927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cOjIRnG8wmEToHayU3XgMgym1bL26GaRPo7R/UVI/gs=;
        b=sT/X3upFbCPtoaj3bQjokRlmpo9zJ+csG2R+j8fiCsIeh2uZLkiu+PpmL1reZDCw0z
         TSjVziEfL49DU/JKlWXP0GcGtNdYPbuXdD9ZyK9RjEU1V8/06NvgxLiKXNolOo1r+Sx4
         r0tHWPePfuvzkgMtTjQe+H1sLEq1vYLcpAytaE98FdAm4nD8c4SH0VvQWlBrAT2RczgG
         +abxXpEf3x14OmUdbOtip+vaMVQCYZ3vNWNzS6nyLZuKv4cWoK78XavNbT8UjtyIOV1d
         ljrQUi0XBVQ50rRSPK5GCMp/MAk2cxBN2W9S7XBAAXwZksyZLTqnJo3JO0D6LNyAeJVg
         3WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684090927; x=1686682927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOjIRnG8wmEToHayU3XgMgym1bL26GaRPo7R/UVI/gs=;
        b=hdL9hLtl6fIxu0ODGoKSMxSqOH0rD9Qy/bhgkCikxr6+X3EPcHmxpA5t2t8F1YxLbZ
         Ows90xPrezvmjDki6udgdTfGAxNytRXLnPoRBrAki1ZBjLBMQ2a8zwkXUjLXsmoVPU7C
         NA2R5xkjHzjo1oOLG58EoW21sOatV31fl/VeGRjlSeZzn4kqkwgar/zKnHkzwQ3UkCUn
         I/egD1e1/aOyZttApW83k6VNb14xo4B1Kq3ooD6CnFwbfPoRjG/qvtUVUIyGE9SuW43X
         OZmgeriRm2P17rr746u8Wz+ErpSxHLtgSZ4Aq1Ypt8pWJi2HIR7YTmtlAK4FZiV8JBCc
         YKxw==
X-Gm-Message-State: AC+VfDw1Inhv4YGkQUH2gl0RMbZ5LiOEoj9Oyk9ZKz4MoWWZj7WfzB90
        hvP6+0B1D4US8PLn15jezzk=
X-Google-Smtp-Source: ACHHUZ5YF7Q3eqRHa9om4C4u5OPx/3tl0/VBTVbrnqC600ehL57VCuKyRs7HeJO0QQcCAgjBUaiMVw==
X-Received: by 2002:a05:6a20:5498:b0:101:3112:c839 with SMTP id i24-20020a056a20549800b001013112c839mr25646023pzk.15.1684090927295;
        Sun, 14 May 2023 12:02:07 -0700 (PDT)
Received: from yoga ([2400:1f00:13:3840:2d88:3593:2af7:2b37])
        by smtp.gmail.com with ESMTPSA id 78-20020a630351000000b0051815eae23esm10105322pgd.27.2023.05.14.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 12:02:06 -0700 (PDT)
Date:   Mon, 15 May 2023 00:31:59 +0530
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
Subject: [PATCH 1/2] dt-bindings: iio: temperature: Add support for tmp006
Message-ID: <e6e56cd513625c76435f444f13c640f9556fb2bc.1684089997.git.anupnewsmail@gmail.com>
References: <cover.1684089997.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684089997.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for TMP006, IR thermopile sensor.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>

Changes:
V1 -> V2: Removed redundant dt-binding from subject.
          Added supply information.
          Adhere to the generic node name.
---
 .../bindings/iio/temperature/ti,tmp006.yaml   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
new file mode 100644
index 000000000000..4915c3e2d721
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
+            vdd-supply = <&ldo4_reg>
+        };
+    };
-- 
2.34.1

