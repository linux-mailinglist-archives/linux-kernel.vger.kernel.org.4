Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30B9643CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiLFFxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 00:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiLFFxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:53:30 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7C626AD2;
        Mon,  5 Dec 2022 21:53:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670305995; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IXR+/KxxXp9HGmlxDhlYiIY7RdIlDRqki80PPtRNA2DhfRCHGHSOpPQBPlAslwJ6rtkZQuTuyk1Nd9nObvlAjmmddKzf84hJ7v9vztEYUG16oy4/fpPJvDZa1jOPZfPt3yokeIsbKEhuGnWoynpJIdocxsxRmr+VNq/mSxmmiho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670305995; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=BuIw4xDgq4VV/tg/CyfdQWLefl/clo1mTq+M3vk5PqY=; 
        b=jyL6ZUdo3zlWA8k11LtSRvoH2AQK2y0eQtysyl4cFpnkR+zmuNx5TqFZ9sRZfEUO1+ZBeLrA0yp7sT0A6pKzHHh3ZC0ahkiC3TkRUCBbB7esP0+4vVRbDhr9PNrLrhepoWqjrtvfW1bPMGBuzo6bncVvRgP3Plu9fa7r3B4dDXc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670305995;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=BuIw4xDgq4VV/tg/CyfdQWLefl/clo1mTq+M3vk5PqY=;
        b=LOWNcfXrbnfUjGAeWSk6wCdxWeK52iK5u2oc34nP+iNuhlBe3nZxoWT1oA6MRc0i
        RXtMZ7rW0mTbqusodtyOZKu5ft9W8HNI/dnZrOZijVLTQHzXJyNApAnhz83LpVpqwqQ
        rCuJI2dsuqNVbZId3GMqtTONAlFY+YciwdOy+GP8=
Received: from edelgard.fodlan.icenowy.me (120.85.99.143 [120.85.99.143]) by mx.zohomail.com
        with SMTPS id 1670305993579283.89111808030043; Mon, 5 Dec 2022 21:53:13 -0800 (PST)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v3 2/6] dt-bindings: usb: Add binding for Genesys Logic GL850G hub controller
Date:   Tue,  6 Dec 2022 13:52:24 +0800
Message-Id: <20221206055228.306074-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206055228.306074-1-uwu@icenowy.me>
References: <20221206055228.306074-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Genesys Logic GL850G is a USB 2.0 Single TT hub controller that
features 4 downstream ports, an internal 5V-to-3.3V LDO regulator (can
be bypassed) and an external reset pin.

Add a device tree binding for its USB protocol part. The internal LDO is
not covered by this and can just be modelled as a fixed regulator.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
Changes in v3:
- Re-introduce GPIO flags.
Changes in v2:
- Misc fixes suggested by Krzysztof, including property descriptions,
  single-item "items" and fixing the example's gpio property.
- Fixed $id.

 .../bindings/usb/genesys,gl850g.yaml          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml

diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
new file mode 100644
index 000000000000..a9f831448cca
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Genesys Logic GL850G USB 2.0 hub controller
+
+maintainers:
+  - Icenowy Zheng <uwu@icenowy.me>
+
+allOf:
+  - $ref: usb-device.yaml#
+
+properties:
+  compatible:
+    enum:
+      - usb5e3,608
+
+  reg: true
+
+  reset-gpios:
+    description: GPIO controlling the RESET# pin.
+
+  vdd-supply:
+    description:
+      the regulator that provides 3.3V core power to the hub.
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
+            compatible = "usb5e3,608";
+            reg = <1>;
+            reset-gpios = <&pio 7 2 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.38.1

