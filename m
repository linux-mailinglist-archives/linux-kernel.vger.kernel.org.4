Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B372F6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbjFNHtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243066AbjFNHte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:49:34 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D46170E;
        Wed, 14 Jun 2023 00:49:31 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686728970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5N9NSA3ycLJUSucfBk1k0lUH03RfOeo/UXNYngARjpo=;
        b=bp/L3mDYJD0nORz8aM+ayzwsonaK5n4v4rtNVz9nKMSKsLrSSkUipHXdZ1mY43QoU+uFdm
        3fnhRBylAXt0Nvz+D++gKyQNwk+J8kQ2nrQM6umRSysGq5Zi7pPE5gEP3nzglXWOAJgGy3
        x3YDU+CkxIUjiWvMZ9yHisfbc9cMOkOi2AX6q0W5okEJvtsSS2/5SZywuec0PUezO4pbXX
        QTyGlH0y43NW/fK0ssYDUEUGiCUvyTNBvWfpM3+Z6BxNpFzXH0PYiVzQ+yciIEcdoHtxCF
        gvslU6pr8uWxnraOlODA5IEYNr7Qg7OYqSMZd2LqCGKwDPR1LsdE28bkV6F1gA==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E09851C0019;
        Wed, 14 Jun 2023 07:49:28 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 02/13] ASoC: dt-bindings: simple-card: Add additional-devs subnode
Date:   Wed, 14 Jun 2023 09:48:53 +0200
Message-Id: <20230614074904.29085-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614074904.29085-1-herve.codina@bootlin.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The additional-devs subnode allows to declared some virtual devices
as sound card children.
These virtual devices can then be used by the sound card and so be
present in the audio path.

The first virtual device supported is the audio IIO auxiliary device
in order to support an IIO device as an audio auxiliary device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/simple-card.yaml           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index b05e05c81cc4..59ac2d1d1ccf 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -148,6 +148,15 @@ definitions:
     required:
       - sound-dai
 
+  additional-devs:
+    type: object
+    description:
+      Additional devices used by the simple audio card.
+    patternProperties:
+      '^iio-aux(-.+)?$':
+        type: object
+        $ref: audio-iio-aux.yaml#
+
 properties:
   compatible:
     contains:
@@ -187,6 +196,8 @@ properties:
     $ref: "#/definitions/mclk-fs"
   simple-audio-card,aux-devs:
     $ref: "#/definitions/aux-devs"
+  simple-audio-card,additional-devs:
+    $ref: "#/definitions/additional-devs"
   simple-audio-card,convert-rate:
     $ref: "#/definitions/convert-rate"
   simple-audio-card,convert-channels:
@@ -359,6 +370,48 @@ examples:
         };
     };
 
+# --------------------
+# route audio to/from a codec through an amplifier
+# designed with a potentiometer driven by IIO:
+# --------------------
+  - |
+    sound {
+        compatible = "simple-audio-card";
+
+        simple-audio-card,aux-devs = <&amp_in>, <&amp_out>;
+        simple-audio-card,routing =
+            "CODEC LEFTIN", "AMP_IN LEFT OUT",
+            "CODEC RIGHTIN", "AMP_IN RIGHT OUT",
+            "AMP_OUT LEFT IN", "CODEC LEFTOUT",
+            "AMP_OUT RIGHT IN", "CODEC RIGHTOUT";
+
+        simple-audio-card,additional-devs {
+            amp_out: iio-aux-out {
+                compatible = "audio-iio-aux";
+                io-channels = <&pot_out 0>, <&pot_out 1>;
+                io-channel-names = "LEFT", "RIGHT";
+                snd-control-invert-range = <1 1>;
+                sound-name-prefix = "AMP_OUT";
+            };
+
+            amp_in: iio_aux-in {
+                compatible = "audio-iio-aux";
+                io-channels = <&pot_in 0>, <&pot_in 1>;
+                io-channel-names = "LEFT", "RIGHT";
+                sound-name-prefix = "AMP_IN";
+            };
+        };
+
+        simple-audio-card,cpu {
+            sound-dai = <&cpu>;
+        };
+
+        simple-audio-card,codec {
+            sound-dai = <&codec>;
+            clocks = <&clocks>;
+        };
+    };
+
 # --------------------
 # Sampling Rate Conversion
 # --------------------
-- 
2.40.1

