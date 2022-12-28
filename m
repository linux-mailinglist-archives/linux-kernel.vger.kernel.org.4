Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8628F657523
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiL1KGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiL1KFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:05:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A0DF2;
        Wed, 28 Dec 2022 02:05:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so15604888pjh.5;
        Wed, 28 Dec 2022 02:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XddeMIQqpQATN+V02+mnCt6s/9dpQm+lysoFjgM/iXM=;
        b=bk9fPXdUuyhpiB21Zc6lECqP3DGFcZuDaRjM9NiTQcDW49oyZnaprUVChuBu13cveQ
         +tuR2ei4Gmmks6GNZpxuFlZ48YVzWw+gkqvpwyUiSGGq/Y2syUZgKcfFTnDPhxp3VgIC
         BpOrcy7TMVP3fdt3Ik2ZrM5IVJRK9/7SH+CxvzZgWFQNNwfov1ra7ELkyAC7d6Y4EqHn
         F5nagEcXFH3dZzg3tuNpg9MQsoqD03c8DCLicI0G+mRDOd4fj51Bny/By7Ut0BsCtl8D
         J1F8UKUC0yEtzECuDGWz7qceGVaLHeKQ7RyFNkYllKcWZxwBbvn5aHZQ+miHxIV/waIE
         z0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XddeMIQqpQATN+V02+mnCt6s/9dpQm+lysoFjgM/iXM=;
        b=xKMPbeXG91DdqmU7AJFR+BW06R4hbFDFpjr6SkVWaqZEkF/xV+EZtx+sWT91Ucr3G2
         OcZm1zqR2r88uPxnyZGZonSNI7enIB9jcYNGzpa4+iUFlIWFC1psYforF58W6ja1aodg
         +e2a/MJF/aKVTG6uH+98SZnQ3VEXForycdYB01WfiAtIt93tZn4n4fd8FATSIcBGs9Pl
         9v5egeuI2rSFbzc9qoHmWcFVye8ZY9sx12qd8o4CTLeH6UsAajx3Wl8ZRITIeNXUtJkV
         bqaRmBvhulQZbys0O83wRzR7wyjcBvLWprtYUyPr5+hnqmRAUL/n/6+kuZqPLkqKq+13
         JrrA==
X-Gm-Message-State: AFqh2kpxkfKi1BvjDE4x+XzcNsA5hxr98V0z5lMkQQy/UtKwkd1Ssybr
        +zEaPxvfXbKTqySmsV5peuTpwS9iSDyj5A==
X-Google-Smtp-Source: AMrXdXsGyKPlSNurOpXtQXDm488FCNp4MXLMzNFxR/gCvJmOImwthWm4FQ5Snt8HpVO9Gw2aqoOuyg==
X-Received: by 2002:a17:902:da86:b0:189:747e:97cc with SMTP id j6-20020a170902da8600b00189747e97ccmr35072825plx.26.1672221951502;
        Wed, 28 Dec 2022 02:05:51 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019277df45a6sm5794915plb.53.2022.12.28.02.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:05:51 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/11] dt-bindings: usb: Add binding for Via lab VL817Q7 hub controller
Date:   Wed, 28 Dec 2022 10:03:17 +0000
Message-Id: <20221228100321.15949-9-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228100321.15949-1-linux.amoon@gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIA Lab VL817-Q7 is a USB 3.1 Gen 1 4-Port hub controller that
features 4 downstream ports, an internal 5V regulator and has
external reset pin.

Add a device tree binding for its USB protocol part.
The internal LDO is not covered by this and can just be modelled
as a fixed regulator.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../bindings/usb/vialab,vl817q7.yaml          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml

diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
new file mode 100644
index 000000000000..4ae995160fd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Via labs VL817Q7 USB 3.1 hub controller
+
+maintainers:
+  - Anand Moon <linux.amoon@gmail.com>
+
+allOf:
+  - $ref: usb-device.yaml#
+
+properties:
+  compatible:
+    enum:
+      - vialab,usb2109
+
+  reg: true
+
+  reset-gpios:
+    description: GPIO controlling the RESET# pin.
+
+  vdd-supply:
+    description:
+      the regulator that provides 5.0V core power to the hub.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    usb {
+        dr_mode = "host";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hub: hub@1 {
+            compatible = "vialab,usb2109"
+            reg = <1>;
+            reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.38.1

