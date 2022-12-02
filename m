Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699466401F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiLBITl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiLBISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:18:35 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACF313F1F;
        Fri,  2 Dec 2022 00:17:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669969049; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=KKwgdwJkmSqoAQSGxIHOyceZkreh9/SJb/7xMLTIwbJe3OvfbbBqEdN1/9kOn0TMjI4I+17HZ433/OJRgZS0x8q37VXBKi496q/lFI4RLJcYDuDnda7/gJAkgqmWKwCTO5b9GEAezfY0AdYCEV3K97XU/Bno35xPrdXU1LTSC/s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669969049; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ORW3PCrQfzAkTQ7duk9/RgOnxHxJYMd6++GTmA/EuUQ=; 
        b=W3DiYxW4gcKVHFV/GQFzCHL4SL14Cf4c/eT28EvSUtdcBQD3+efeaiXhdqqEjDIuV4YE5pD5FLp9sa6AyoKaUHkzUaAb5oKhF0rfLkQa9Z/E77rNFcM1v5bNm9XbLv5p9nz01jjx6m2o016mjb0fd6uwx8Y+fcVfmo/mbfZpNTE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669969049;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=ORW3PCrQfzAkTQ7duk9/RgOnxHxJYMd6++GTmA/EuUQ=;
        b=Eprz7xti57zaJ0er7EgoNKw2kE2b0CBhd4/sBrR2B+zleffWXxB6LPOO8k9dJ5RQ
        1CGao6jKAMyNjO7lq1dh32rE07qk1HMkQvP5MXcdl6xRBtDXjkF1ohge4eXocQhj17b
        uOXaYfQIG0OrF4y7lwC+5XEDV4AXbh03GYlO4z/E=
Received: from edelgard.fodlan.icenowy.me (120.85.99.229 [120.85.99.229]) by mx.zohomail.com
        with SMTPS id 1669969047936410.260924341292; Fri, 2 Dec 2022 00:17:27 -0800 (PST)
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
Subject: [PATCH v2 2/6] dt-bindings: usb: Add binding for Genesys Logic GL850G hub controller
Date:   Fri,  2 Dec 2022 16:16:43 +0800
Message-Id: <20221202081647.3183870-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202081647.3183870-1-uwu@icenowy.me>
References: <20221202081647.3183870-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
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
Changes in v2:
- Misc fixes suggested by Krzysztof, including property descriptions,
  single-item "items" and fixing the example's gpio property.
- Fixed $id.

 .../bindings/usb/genesys,gl850g.yaml          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml

diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
new file mode 100644
index 000000000000..966462ca6acb
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -0,0 +1,47 @@
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
+    usb {
+        dr_mode = "host";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hub: hub@1 {
+            compatible = "usb5e3,608";
+            reg = <1>;
+            reset-gpios = <&pio 7 2>;
+        };
+    };
-- 
2.38.1

