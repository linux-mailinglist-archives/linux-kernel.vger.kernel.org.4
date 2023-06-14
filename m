Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CBD72F6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243147AbjFNHtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjFNHtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:49:31 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145F310DA;
        Wed, 14 Jun 2023 00:49:29 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686728968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyTXVmL/5teIh8xuYTUUi3ltQcCGVDf6AcEbfADS6og=;
        b=TRiogZYVcJY4TPV0AG3+ydZ67VsDompUurAfaNpaYziqsXa+4y2hRwXbjRLvghlvEH9Fyl
        GCFvM5EeYxA5dArn1NaACEBreYajq63EQqCDEZXwTx+N+Dbg43YwzSPS9XQkhjjtVj6kFt
        5P64v/pLVZEuVKhyniNvkVSFd2GqVQhKnOZuJRqa9WbKT7+5Jdp/gfuHObc3NCO7omT1dU
        WiqibqqX8ylvbRDB+bnr+ChlhxXwHBXSPiBs85KNuAr/YY43PFlIPdlhBY1SHiObTxst2N
        DDsZzfsFe7n+baW96/e56HLqdiFo0OwdAEfowrlH5/LhcJJW9KKXZWYfAwWsuQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPA id 879101C0008;
        Wed, 14 Jun 2023 07:49:27 +0000 (UTC)
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
Subject: [PATCH v4 01/13] ASoC: dt-bindings: Add audio-iio-aux
Date:   Wed, 14 Jun 2023 09:48:52 +0200
Message-Id: <20230614074904.29085-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614074904.29085-1-herve.codina@bootlin.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Industrial I/O devices can be present in the audio path.
These devices needs to be viewed as audio components in order to be
fully integrated in the audio path.

audio-iio-aux allows to consider these Industrial I/O devices as
auxliary audio devices.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/audio-iio-aux.yaml         | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/audio-iio-aux.yaml

diff --git a/Documentation/devicetree/bindings/sound/audio-iio-aux.yaml b/Documentation/devicetree/bindings/sound/audio-iio-aux.yaml
new file mode 100644
index 000000000000..d3cc1ea4a175
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/audio-iio-aux.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/audio-iio-aux.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Audio IIO auxiliary
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description:
+  Auxiliary device based on Industrial I/O device channels
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: audio-iio-aux
+
+  io-channels:
+    description:
+      Industrial I/O device channels used
+
+  io-channel-names:
+    description:
+      Industrial I/O channel names related to io-channels.
+      These names are used to provides sound controls, widgets and routes names.
+
+  snd-control-invert-range:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      A list of 0/1 flags defining whether or not the related channel is
+      inverted
+    items:
+      enum: [0, 1]
+      default: 0
+      description: |
+        Invert the sound control value compared to the IIO channel raw value.
+          - 1: The related sound control value is inverted meaning that the
+               minimum sound control value correspond to the maximum IIO channel
+               raw value and the maximum sound control value correspond to the
+               minimum IIO channel raw value.
+          - 0: The related sound control value is not inverted meaning that the
+               minimum (resp maximum) sound control value correspond to the
+               minimum (resp maximum) IIO channel raw value.
+
+required:
+  - compatible
+  - io-channels
+  - io-channel-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    iio-aux {
+        compatible = "audio-iio-aux";
+        io-channels = <&iio 0>, <&iio 1>, <&iio 2>, <&iio 3>;
+        io-channel-names = "CH0", "CH1", "CH2", "CH3";
+        /* Invert CH1 and CH2 */
+        snd-control-invert-range = <0 1 1 0>;
+    };
-- 
2.40.1

