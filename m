Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42AB6A81AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCBL5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCBL50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:57:26 -0500
Received: from out-48.mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4044E3644D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:57:22 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677758240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lacV+ZSJrTyZ6DynOqgF52q9M292vYw544hATtzWJ1U=;
        b=UPiAwD8Aezv+ZVDhgXZdkVwLDXFcVnot+rOvl2jJwf7c8Suxiy8q7GI6bPjtYSyIjA8tDk
        fC221+XDLRZj9FDCNDJGtu6w0yl1R9tNbsw2+aONPjEsLCJJE7cGcqJqHMar//GHUUkIfc
        3/rI1S39VCkas1vViAtLhi+5YWO6GtA=
From:   richard.leitner@linux.dev
Date:   Thu, 02 Mar 2023 12:55:01 +0100
Subject: [PATCH 1/3] ASoC: dt-bindings: maxim,max9867: convert txt bindings
 to yaml
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230302-max9867-v1-1-aa9f7f25db5e@skidata.com>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
In-Reply-To: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215;
 i=richard.leitner@skidata.com; h=from:subject:message-id;
 bh=EaR0IGpFQVasEFVxFQvnkwT/6aa1vj6aIM7Wyp90Ang=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFIY+uUqpuu8L567xvpO/qcH++aum3UuKHtpqDmzzjSrfcIp
 hi9ZO0pZGMS4GGTFFFnsjbna3XPL3lcq6uTCzGFlAhnCwMUpABOZYM3wh9Nz/dKzhxdN9tqkeExNj7
 WC1bXg2LzqWQ5SrxRD8xg+6zEyrD716kr8idn3VK8Jh1j6Xt/AfyLhX/7yqCfTNmerz3nOwgsA
X-Developer-Key: i=richard.leitner@skidata.com; a=openpgp;
 fpr=3F330A87476D76EF79212C6DFC189628387CFBD0
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Leitner <richard.leitner@skidata.com>

Convert from max9867.txt to maxim,max9867.yaml and add missing
'#sound-dai-cells' property.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 .../devicetree/bindings/sound/max9867.txt          | 17 --------
 .../devicetree/bindings/sound/maxim,max9867.yaml   | 51 ++++++++++++++++++++++
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/max9867.txt b/Documentation/devicetree/bindings/sound/max9867.txt
deleted file mode 100644
index b8bd914ee697..000000000000
--- a/Documentation/devicetree/bindings/sound/max9867.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-max9867 codec
-
-This device supports I2C mode only.
-
-Required properties:
-
-- compatible : "maxim,max9867"
-- reg : The chip select number on the I2C bus
-
-Example:
-
-&i2c {
-	max9867: max9867@18 {
-		compatible = "maxim,max9867";
-		reg = <0x18>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max9867.yaml b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
new file mode 100644
index 000000000000..cefa43c3d34e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max9867.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/max9867.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX9867 CODEC
+
+description: |
+  This device supports I2C only.
+  Pins on the device (for linking into audio routes):
+      * LOUT
+      * ROUT
+      * LINL
+      * LINR
+      * MICL
+      * MICR
+      * DMICL
+      * DMICR
+
+maintainers:
+  - Ladislav Michl <ladis@linux-mips.org>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - maxim,max9867
+
+  '#sound-dai-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    &i2c {
+            max9867: max9867@18 {
+                    compatible = "maxim,max9867";
+                    #sound-dai-cells = <0>;
+                    reg = <0x18>;
+            };
+    };
+...

-- 
2.39.2

