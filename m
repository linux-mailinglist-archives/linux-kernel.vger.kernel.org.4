Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3F5FC041
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 07:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJLF47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 01:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJLF4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 01:56:53 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623E0ABD42;
        Tue, 11 Oct 2022 22:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665554196; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=l0ZmpSuYtDi5QJ4pEpBhr7XKkN0csdx3TsjI/rkXNMkDCfxSOMKOc6p7ehyG2Sh83LFEyqD8cEEH+qW9OMQ7ogKxxC90b7wtXWUTwMb7dtsSnBLsWJDM4xND+3q/1sOr7GEGD/1Tph85UBP/O6ju8CeN386uZfbRa3h7/Aw6xf0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665554196; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=rIOcS1OPdlQxTt3UA0JfYxANFs/SYjhsbkgEyI8apBw=; 
        b=Xapiq/b1vGV+DAwjFxowYJFTrs13qbH26wU7VerY4LELeFBTpNr2X4yPt4je1GAy2vVFMl+FbfLs7nlJbYvHnK7LaoXFLPweM8Imb31ZgJApfOTefbbIN0NWrLhGrMeg8bLVkmOR8901i0SEQVRx6uVEWgVMFVHPMP2hK2w83xE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665554196;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=rIOcS1OPdlQxTt3UA0JfYxANFs/SYjhsbkgEyI8apBw=;
        b=GuvsOp5UCB5oOJ+1hA2YY4cebeBu87m9yx/Ybv4VRq7OHcSm7+xr+W6450zgM1G3
        Uue+ZV62u6eqrKEveNeiPltofpWU83iJ0XJNaJ3V2L8KVzYCeoWid/hQQaCRVuezt2f
        Yx89R9ultXnlVFRlO3geWpnllW3t0VdrVqrpg6Eo=
Received: from edelgard.fodlan.icenowy.me (112.94.102.144 [112.94.102.144]) by mx.zohomail.com
        with SMTPS id 1665554195157378.470387366199; Tue, 11 Oct 2022 22:56:35 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 02/10] dt-bindings: phy: add binding document for Allwinner F1C100s USB PHY
Date:   Wed, 12 Oct 2022 13:55:54 +0800
Message-Id: <20221012055602.1544944-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221012055602.1544944-1-uwu@icenowy.me>
References: <20221012055602.1544944-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner F1C100s has the most simple USB PHY among all Allwinner SoCs,
because it has only one OTG USB controller, no host-only OHCI/EHCI
controllers.

Add a binding document for it. Following the current situation of one
YAML file per SoC, this one is based on
allwinner,sun8i-v3s-usb-phy.yaml, but with OHCI/EHCI-related bits
removed. (The same driver in Linux, phy-sun4i-usb, covers all these
binding files now.)

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- Clarify the relation with other phy-sun4i-usb bindings.
- Added Rob's ACK.

 .../phy/allwinner,suniv-f1c100s-usb-phy.yaml  | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
new file mode 100644
index 000000000000..22ff8e0f2331
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/allwinner,suniv-f1c100s-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner F1C100s USB PHY Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <mripard@kernel.org>
+
+properties:
+  "#phy-cells":
+    const: 1
+
+  compatible:
+    const: allwinner,suniv-f1c100s-usb-phy
+
+  reg:
+    maxItems: 1
+    description: PHY Control registers
+
+  reg-names:
+    const: phy_ctrl
+
+  clocks:
+    maxItems: 1
+    description: USB OTG PHY bus clock
+
+  clock-names:
+    const: usb0_phy
+
+  resets:
+    maxItems: 1
+    description: USB OTG reset
+
+  reset-names:
+    const: usb0_reset
+
+  usb0_id_det-gpios:
+    maxItems: 1
+    description: GPIO to the USB OTG ID pin
+
+  usb0_vbus_det-gpios:
+    maxItems: 1
+    description: GPIO to the USB OTG VBUS detect pin
+
+  usb0_vbus_power-supply:
+    description: Power supply to detect the USB OTG VBUS
+
+  usb0_vbus-supply:
+    description: Regulator controlling USB OTG VBUS
+
+required:
+  - "#phy-cells"
+  - compatible
+  - clocks
+  - clock-names
+  - reg
+  - reg-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/clock/suniv-ccu-f1c100s.h>
+    #include <dt-bindings/reset/suniv-ccu-f1c100s.h>
+
+    phy@1c13400 {
+        compatible = "allwinner,suniv-f1c100s-usb-phy";
+        reg = <0x01c13400 0x10>;
+        reg-names = "phy_ctrl";
+        clocks = <&ccu CLK_USB_PHY0>;
+        clock-names = "usb0_phy";
+        resets = <&ccu RST_USB_PHY0>;
+        reset-names = "usb0_reset";
+        #phy-cells = <1>;
+        usb0_id_det-gpios = <&pio 4 2 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.37.1

