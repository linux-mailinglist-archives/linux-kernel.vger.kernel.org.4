Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0586596DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiL3JgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiL3Jfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:35:53 -0500
Received: from out29-174.mail.aliyun.com (out29-174.mail.aliyun.com [115.124.29.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E185101DA;
        Fri, 30 Dec 2022 01:35:50 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1891346|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.129484-0.000739146-0.869777;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.Qh0Qg9S_1672392919;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Qh0Qg9S_1672392919)
          by smtp.aliyun-inc.com;
          Fri, 30 Dec 2022 17:35:22 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        povik+lin@cutebit.org, pierre-louis.bossart@linux.intel.com,
        james.schulman@cirrus.com, flatmax@flatmax.com,
        cezary.rojewski@intel.com, srinivas.kandagatla@linaro.org,
        tanureal@opensource.cirrus.com, steve@sk2.org, stephan@gerhold.net,
        zhuning0077@gmail.com, shumingf@realtek.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
Cc:     zhaolei@awinic.com, liweilei@awinic.com, yijiangtao@awinic.com,
        duanyibo@awinic.com
Subject: [PATCH V8 5/5] ASoC: dt-bindings: Add schema for "awinic,aw883xx"
Date:   Fri, 30 Dec 2022 17:34:54 +0800
Message-Id: <20221230093454.190579-6-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230093454.190579-1-wangweidong.a@awinic.com>
References: <20221230093454.190579-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Add a DT schema for describing Awinic AW883xx audio amplifiers. They are
controlled using I2C.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 .../bindings/sound/awinic,aw883xx.yaml        | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
new file mode 100644
index 000000000000..b677427ebcd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/awinic,aw883xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW883xx Smart Audio Amplifier
+
+maintainers:
+  - Stephan Weidong Wang <wangweidong.a@awinic.com>
+
+description:
+  The Awinic AW883XX is an I2S/TDM input, high efficiency
+  digital Smart K audio amplifier with an integrated 10.25V
+  smart boost convert.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: awinic,aw883xx
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  sound-name-prefix: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        audio-codec@34 {
+            compatible = "awinic,aw883xx";
+            reg = <0x34>;
+            reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.38.1

