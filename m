Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E3D639990
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 08:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiK0Hcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 02:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiK0Hcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 02:32:31 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F0F13DC9;
        Sat, 26 Nov 2022 23:32:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669534332; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Y+/S6KSQmJ4YwNXfHe55b213QfStSast38O08enHhPq1yxXk4komFAx0q+9Pc3xIS9HY4y23JQ4vCK7+pv3jfne+gVl1odRyq8s3Rzk5u3m+5BcIDtMxPm3B2AKoPIUWzlQy7amKH3zFxwZMf0/k6do5n1+2LxFZo+rH85BT5GE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669534332; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1C6hqrooialxkZsBgfuBXMNuzsLUfOjDavC8s3kDHqQ=; 
        b=UzyDmdyRLGDtpeVzO9glIHL/10FDuFpEz37C3i5qup1dl5zAdc7xpZw/cI8Gg7m1FmJ/8HkFlaBWEL7RIOtJukcnX2Bvjz9wjMIa+vAR/PzXIE+lbJtNJUxgYHnrn3PFq6nQb0uX3RVCL8FFnImu8Z15i6I1WeWKex/4pdq+mxY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669534332;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=1C6hqrooialxkZsBgfuBXMNuzsLUfOjDavC8s3kDHqQ=;
        b=bKbavFVeOxu6psP6wsB5jYdfZy01IGOH/aYEutrLVjW2slxafIOgpQLpQg6wb0yQ
        I49AP9dP7VWci9D1EGNRHjoaBrjGj3XxTsgd2WWExX7HAt4ok4LJ13wVMdM43j1LNfn
        4fpOkLDHNPdPpqiwKh10CXPsCNQd8q8Mrd0/Pg8w=
Received: from edelgard.fodlan.icenowy.me (112.94.100.108 [112.94.100.108]) by mx.zohomail.com
        with SMTPS id 1669534331301345.07916607731534; Sat, 26 Nov 2022 23:32:11 -0800 (PST)
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
Subject: [PATCH 2/6] dt-bindings: usb: Add binding for Genesys Logic GL850G hub controller
Date:   Sun, 27 Nov 2022 15:31:36 +0800
Message-Id: <20221127073140.2093897-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221127073140.2093897-1-uwu@icenowy.me>
References: <20221127073140.2093897-1-uwu@icenowy.me>
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
 .../bindings/usb/genesys,gl850g.yaml          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml

diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
new file mode 100644
index 000000000000..d1fe539db399
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/realtek,rts5411.yaml#
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
+    items:
+      - enum:
+          - usb5e3,608
+
+  reg: true
+
+  reset-gpios:
+    description: GPIO specifier for GRST# pin.
+
+  vdd-supply:
+    description:
+      phandle to the regulator that provides power to the hub.
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
+            reset-gpios = <&pio 7 2 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.37.1

