Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F716ECA42
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjDXKWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjDXKVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:21:47 -0400
X-Greylist: delayed 2023 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 03:20:54 PDT
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5927C44A1;
        Mon, 24 Apr 2023 03:20:54 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 59B875EA96;
        Mon, 24 Apr 2023 12:35:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-2TUQh5iJ;
        Mon, 24 Apr 2023 12:35:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328959;
        bh=o2l9sFAZqeH2mMt7Top7hq0H/Mal02+WzUsAgGIp4lk=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Zoh8dV0+V6ps71el1y5+5iyxQSwTsSAisSDyovHWwkefK9wsvi10dBDJ3WFMmw1GF
         2QNa2uzNgNE6M1xfC2Et5VD1tG0W4ZwLqbyFydzw/IIQkGBfXoIs288PjFo6AK6AtZ
         ixGV48kgdC8ygJjFAC2bJxe+uFfD5PiDu7qrFNyY=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/43] dt-bindings: ata: Add DT bindings ep93xx pata
Date:   Mon, 24 Apr 2023 15:34:40 +0300
Message-Id: <20230424123522.18302-25-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML bindings ep93xx SoC.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/ata/cirrus,ep93xx-pata.yaml      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/cirrus,ep93xx-pata.yaml

diff --git a/Documentation/devicetree/bindings/ata/cirrus,ep93xx-pata.yaml b/Documentation/devicetree/bindings/ata/cirrus,ep93xx-pata.yaml
new file mode 100644
index 000000000000..24ed64cfa6d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/cirrus,ep93xx-pata.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/cirrus,ep93xx-pata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EP9312 PATA controller driver
+
+maintainers:
+  - Damien Le Moal <damien.lemoal@opensource.wdc.com>
+
+properties:
+  compatible:
+    const: cirrus,ep9312-pata
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    ide: ide@800a0000 {
+        compatible = "cirrus,ep9312-pata";
+        reg = <0x800a0000 0x38>;
+        interrupt-parent = <&vic1>;
+        interrupts = <8>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&ide_default_pins>;
+    };
+
+...
-- 
2.39.2

