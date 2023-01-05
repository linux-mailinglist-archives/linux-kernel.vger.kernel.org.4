Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE68565F0BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjAEQEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjAEQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:04:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D6981AA15;
        Thu,  5 Jan 2023 08:04:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A563F1063;
        Thu,  5 Jan 2023 08:04:43 -0800 (PST)
Received: from R913NWR2.arm.com (unknown [10.163.47.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B9CC3F71A;
        Thu,  5 Jan 2023 08:03:58 -0800 (PST)
From:   Faiz Abbas <faiz.abbas@arm.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, Anurag.Koul@arm.com,
        Deepak.Pandey@arm.com, Faiz Abbas <faiz.abbas@arm.com>
Subject: [PATCH] ASoC: dt-bindings: simple-card: Document simple-audio-card,plat
Date:   Thu,  5 Jan 2023 21:33:46 +0530
Message-Id: <20230105160346.29018-1-faiz.abbas@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple card driver has support for adding cpu, codec and platform
nodes with the simple-audio-card prefix. Add documentation for the plat
binding.

Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
---
 .../bindings/sound/simple-card.yaml           | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index ed19899bc94b..fa67c76d4dbb 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -205,6 +205,8 @@ patternProperties:
     $ref: "#/definitions/dai"
   "^simple-audio-card,codec(@[0-9a-f]+)?$":
     $ref: "#/definitions/dai"
+  "^simple-audio-card,plat(@[0-9a-f]+)?$":
+    $ref: "#/definitions/dai"
 
   "^simple-audio-card,dai-link(@[0-9a-f]+)?$":
     description: |
@@ -285,6 +287,27 @@ examples:
         };
     };
 
+#-------------------------------
+# single DAI link with platform
+#-------------------------------
+ - |
+   sound {
+        compatible = "simple-audio-card";
+        simple-audio-card,format = "i2s";
+        simple-audio-card,mclk-fs = <384>;
+        simple-audio-card,cpu {
+                sound-dai = <&iofpga_i2s>;
+        };
+
+        simple-audio-card,codec {
+                sound-dai = <&hdmi_tx>;
+        };
+
+        simple-audio-card,plat {
+                sound-dai = <&audio_formatter>;
+        };
+};
+
 #--------------------
 # Multi DAI links
 #--------------------
-- 
2.25.1

