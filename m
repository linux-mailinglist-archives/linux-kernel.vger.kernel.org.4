Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C76F2F29
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjEAHdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAHdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 03:33:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0FB10C1;
        Mon,  1 May 2023 00:33:07 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b87d23729so1539242b3a.0;
        Mon, 01 May 2023 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682926386; x=1685518386;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yhF2kJmDkq2QyRMJA1sSrfW3XhDRwS7D+Qmpc0RRM4=;
        b=VZZxD7r2iGrZsIMqiq5AnEdCCjdy7onR430ShOA2rU35wBTpDESQ4j+2rKI1SvHeKr
         +mFd0JhacVXyVXoxkXoJ09KhVt4WZW9GB6yU4djfPuGw2jbKENQp5yjfHjA58eqH2d+A
         DGHynAQy8wklYUC18OMEQy6/oxMg9BqRz1V7pp2mO1nRn8vgi+QffiwELMpqzi9Tu2m2
         I9c0Czm5uN64cNSJO7ei0Fpr1dAh75nKCg5tRUaCgUu3V8PDSrQc9Uku7IyIKkG3yBmu
         oQrV0PGbjWeGaZonLUlBchnv+oATpTs/T73WI8VyTiwBZjsj1OTzhAjl4GNgssNeGsrk
         gXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682926386; x=1685518386;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yhF2kJmDkq2QyRMJA1sSrfW3XhDRwS7D+Qmpc0RRM4=;
        b=jeBg4KMDDk3P8rog+WHp4xKwENRHUU5UzNExT4gWdVbDkSoi0FkxJ7RoWKI+2iobd4
         bf/Hwl66W2ZiaE7QD0enAIhLQq3TXAl3n1cflzgjsy7MMDp7oPcgGC0yEPGk6p7dT3qn
         4sMJTDiUaaXPcIUyOrpVZErmHyMoj8tJEULwNNxif8h1q5twxZvntAHptuK7wqb1D1yb
         159oEdcGBRVe/fwzv0iwgAqvVt25HGKaFPW0d6RPl6zsVS0lN7XziitypsuHMp8jAQ5v
         Lx6Qg5xczQVnYD21Htqi5BE4l51wYmAFxGaRYvtjQ2Ku95Fz1LPYh16+d0zBz3L1BeEb
         XvPA==
X-Gm-Message-State: AC+VfDxUxy2RWBI/fatKBkuA17+wf26ZSQIZXvef62yYnUsfQW6qL35P
        NuMcrQw57VloYmIY+ylKCOc=
X-Google-Smtp-Source: ACHHUZ6co/rMjhKOyb8zdQZ5OT1jZtqQKGVeuw7UI+b+nt1E3eecgXiTDcBvvb/qw7EgrleM6/S5kQ==
X-Received: by 2002:a05:6a00:2281:b0:640:dbe4:1901 with SMTP id f1-20020a056a00228100b00640dbe41901mr16901796pfe.14.1682926386295;
        Mon, 01 May 2023 00:33:06 -0700 (PDT)
Received: from yoga ([2400:1f00:13:800:1d90:2dc1:65b:f2f3])
        by smtp.gmail.com with ESMTPSA id f195-20020a6238cc000000b0063b8428b0d8sm19241571pfa.152.2023.05.01.00.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 00:33:05 -0700 (PDT)
Date:   Mon, 1 May 2023 13:02:59 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        KCHSU0@nuvoton.com, linux-kernel@vger.kernel.org,
        anupnewsmail@gmail.com
Subject: [PATCH] ASoC: dt-bindings: nau8540: Convert to dtschema
Message-ID: <ZE9rK6mktPByvRRz@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the NAU8540 audio CODEC bindings to DT schema

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../devicetree/bindings/sound/nau8540.txt     | 16 --------
 .../bindings/sound/nuvoton,nau8540.yaml       | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nau8540.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml

diff --git a/Documentation/devicetree/bindings/sound/nau8540.txt b/Documentation/devicetree/bindings/sound/nau8540.txt
deleted file mode 100644
index 307a76528320..000000000000
--- a/Documentation/devicetree/bindings/sound/nau8540.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-NAU85L40 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-  - compatible : "nuvoton,nau8540"
-
-  - reg : the I2C address of the device.
-
-Example:
-
-codec: nau8540@1c {
-       compatible = "nuvoton,nau8540";
-       reg = <0x1c>;
-};
diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
new file mode 100644
index 000000000000..ac344e435a5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8540.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nuvoton,nau8540.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton Technology Corporation NAU85L40 Audio CODEC
+
+maintainers:
+  - KCHSU0@nuvoton.com, broonie@kernel.org
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: nuvoton,nau8540
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1c {
+            compatible = "nuvoton,nau8540";
+            reg = <0x1c>;
+        };
+    };
-- 
2.34.1

