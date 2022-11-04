Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A962C619D7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiKDQjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiKDQim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:38:42 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB17D25EA4;
        Fri,  4 Nov 2022 09:38:40 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 67D3BC0009;
        Fri,  4 Nov 2022 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667579919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RuwsiKOoT3RSiv0ATWGMePKlt2FePql8/L/NJA2t6w=;
        b=n9oVsDaT4roOwYop7LYboPhnBKi8zEtj89MtGR9NiyT9IZ3gJZonBS3xoZfgIq1AKHJtC9
        d7akW49OR4Tvgaaw0haHKSbNuuI+9IAOtL1v6WPfOuTB9DBHmyJeS8M8smfTNvPM6XbndT
        q6Hg/Dv/EwedvTSZxrtw2XNdjFflR93YyfHMlG/GnaTuotK8hXgsp4LauHF03M3R6gXxB1
        ac3EqjkusVMfBJQhafOz4M9h6XstfGt8ZMQc0SK9Ev2tXVoj96Kxj3L9BDF46yCDhAtA5V
        HWlAZ/3Yj4GkjaUwZkPn64bEj/ooohClq8Bbdy/bLVLqaAcwxrpsT+UPXFAJpg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 3/6] dt-bindings: eeprom: Inherit from nvmem.yaml
Date:   Fri,  4 Nov 2022 17:38:30 +0100
Message-Id: <20221104163833.1289857-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EEPROMs can be nvmem providers. Let's make all EEPROM bindings
reference nvmem.yaml as they should, so that nvmem cells and layout
parsers can be safely described within the EEPROM nodes.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/eeprom/at24.yaml           | 5 ++++-
 Documentation/devicetree/bindings/eeprom/at25.yaml           | 1 +
 .../devicetree/bindings/eeprom/microchip,93lc46b.yaml        | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
index d14e0accbda8..84af0d5f52aa 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -10,6 +10,9 @@ title: I2C EEPROMs compatible with Atmel's AT24
 maintainers:
   - Bartosz Golaszewski <bgolaszewski@baylibre.com>
 
+allOf:
+  - $ref: /schemas/nvmem/nvmem.yaml
+
 select:
   properties:
     compatible:
@@ -183,7 +186,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
index 8b1c997caac1..0f5a8ef996d3 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
@@ -104,6 +104,7 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: /schemas/nvmem/nvmem.yaml
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml b/Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml
index 0c2f5ddb79c5..64cfd971c9c5 100644
--- a/Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml
+++ b/Documentation/devicetree/bindings/eeprom/microchip,93lc46b.yaml
@@ -47,6 +47,7 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - $ref: /schemas/nvmem/nvmem.yaml
 
 unevaluatedProperties: false
 
-- 
2.34.1

