Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC40B6BB4F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjCONnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjCONms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:42:48 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169698EA3B;
        Wed, 15 Mar 2023 06:42:46 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 774C640004;
        Wed, 15 Mar 2023 13:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678887765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSK6QmzgFgboixiIAQGzqWb/rCb1DitwrXgQXi+UVkQ=;
        b=BRLGgg+d1mebPDYbuEfKpLaT3Gaa7+FVrT/MFfJaKNsKHljpx9AktNDEsYo4Wat28bPvu7
        upAw0DINnnx7y31brXY2IqqWJ7AqtEVStzfa7JpU4RxUrp/D8hIxjNZl5CEmn0pfXUQBwv
        KZKZriRkwtu0E3JsH5rGIN1l8JFV22Lv7ziO5kXwz77dIESwF+JrnMgmx277EUMZtbRBUI
        +FD+CtMrZUBUbiwbwPA64yNxPWFhJVS2C4zIAWa4KdpAcZ5zarFUe+gbqvWMZHtJVpPuZz
        oZea7nyYkNu4Zw7TFlydTbk11+UlWqIZ6EAORyoDWnhwnD4AikYJ7BY2JfpcCA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 5/7] dt-bindings: sound: Add support for the Lantiq PEF2256 codec
Date:   Wed, 15 Mar 2023 14:42:29 +0100
Message-Id: <20230315134231.233193-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315134231.233193-1-herve.codina@bootlin.com>
References: <20230315134231.233193-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lantiq PEF2256, also known as Infineon PEF2256 or FALC256, is a
framer and line interface component designed to fulfill all required
interfacing between an analog E1/T1/J1 line and the digital PCM system
highway/H.100 bus.

The codec support allows to use some of the PCM system highway
time-slots as audio channels to transport audio data over the E1/T1/J1
lines.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/lantiq,pef2256-codec.yaml  | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml

diff --git a/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
new file mode 100644
index 000000000000..acba3a0ccd1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/lantiq,pef2256-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lantiq PEF2256 codec device
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  Codec support for PEF2256.
+
+  The Lantiq PEF2256, also known as Infineon PEF2256 or FALC256, is a framer and
+  line interface component designed to fulfill all required interfacing between
+  an analog E1/T1/J1 line and the digital PCM system highway/H.100 bus.
+
+  The codec support allows to use some of the PCM system highway time-slots as
+  audio channels to transport audio data over the E1/T1/J1 lines.
+
+  The time-slots used by the codec must be set and so, the properties
+  'dai-tdm-slot-num', 'dai-tdm-slot-width', 'dai-tdm-slot-tx-mask' and
+  'dai-tdm-slot-rx-mask' must be present in the ALSA sound card node for
+  sub-nodes that involve the codec. The codec uses 8bit time-slots.
+  'dai-tdm-tdm-slot-with' must be set to 8.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: lantiq,pef2256-codec
+
+  lantiq,pef2256:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the PEF2256
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - lantiq,pef2256
+  - '#sound-dai-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    audio-codec {
+        compatible = "lantiq,pef2256-codec";
+        lantiq,pef2256 = <&pef2256>;
+        #sound-dai-cells = <0>;
+    };
-- 
2.39.2

