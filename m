Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A24174B878
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjGGVGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGGVGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:06:49 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2142B1BE8;
        Fri,  7 Jul 2023 14:06:48 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-78372b895d6so89488939f.2;
        Fri, 07 Jul 2023 14:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764007; x=1691356007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsmkCXtt1/Ie/i62Qx5OYBjxzfr/7TqmjkdxzkTOMHo=;
        b=aDR2wnuE/5Y8TY4PyXsJKvKpsz7iRQ/su69mK78AdIjHj8DsirM+nzC5Dz5M+Mt5dD
         zTs7Z7eh3OXqWTnloQe+v9rUEo3DKDfBJwnOvP0X6O5+S2c1go3o4RfA3NQLboAlrTq1
         8csWit66TmhkqPdnmfQc//V5dOIp/QQOT2Z5YEDb826EkFt/Ha70K5JtC1wh03QK41zA
         G1AVTADSjQznwQL5xNRmn+2UfdNeWxGJf9NiAlYSn4fItd4/DHOuDVUOMF779UFki627
         c0jUUoUtejKU2+kmgLNFEpDj55HxjewCsaukgMEk2lZPvOagBKWvLMnI7nVkyHFx3WHS
         9dxA==
X-Gm-Message-State: ABy/qLa0Uzy/Q7f7RN4kP54dWLgH4sB2ml1iBE37z1oKFPKUH0nwPfhG
        lkOq754UUdre89Bl7ezjrPLrveWXRw==
X-Google-Smtp-Source: APBJJlF0NqZyk+kOePWf4tPR6zQ0SW1fzsw7bbKDzg0TH94gwND+UbwC0Sq8WxQiy3PuHChGbqYNMg==
X-Received: by 2002:a5e:c005:0:b0:785:5917:a35f with SMTP id u5-20020a5ec005000000b007855917a35fmr6819221iol.8.1688764007306;
        Fri, 07 Jul 2023 14:06:47 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l12-20020a02ccec000000b0042b05586c52sm1538288jaq.25.2023.07.07.14.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:06:46 -0700 (PDT)
Received: (nullmailer pid 868731 invoked by uid 1000);
        Fri, 07 Jul 2023 21:06:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Helen Koike <helen.koike@collabora.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: dt-bindings: Merge OV5695 into OV5693 binding
Date:   Fri,  7 Jul 2023 15:06:04 -0600
Message-Id: <20230707210604.868002-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OV5695 binding is almost the same as the OV5693 binding. The only
difference is 'clock-names' is defined for OV5695. However, the lack of
clock-names is an omission as the Linux OV5693 driver expects the same
'xvclk' clock name.

'link-frequencies' is required by OV5693, but not OV5695. Just drop it
from being required. Expressing it conditionally would be ugly. It
shouldn't really be required either as the driver only supports 1
frequency anyways.

The rockchip-isp1 binding example is missing required properties, so it
has to be updated as well.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/i2c/ov5695.txt  | 41 -------------------
 .../bindings/media/i2c/ovti,ov5693.yaml       | 19 +++++----
 .../bindings/media/rockchip-isp1.yaml         |  1 +
 3 files changed, 13 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5695.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/ov5695.txt b/Documentation/devicetree/bindings/media/i2c/ov5695.txt
deleted file mode 100644
index 640a63717d96..000000000000
--- a/Documentation/devicetree/bindings/media/i2c/ov5695.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-* Omnivision OV5695 MIPI CSI-2 sensor
-
-Required Properties:
-- compatible: shall be "ovti,ov5695"
-- clocks: reference to the xvclk input clock
-- clock-names: shall be "xvclk"
-- avdd-supply: Analog voltage supply, 2.8 volts
-- dovdd-supply: Digital I/O voltage supply, 1.8 volts
-- dvdd-supply: Digital core voltage supply, 1.2 volts
-- reset-gpios: Low active reset gpio
-
-The device node shall contain one 'port' child node with an
-'endpoint' subnode for its digital output video port,
-in accordance with the video interface bindings defined in
-Documentation/devicetree/bindings/media/video-interfaces.txt.
-The endpoint optional property 'data-lanes' shall be "<1 2>".
-
-Example:
-&i2c7 {
-	ov5695: camera-sensor@36 {
-		compatible = "ovti,ov5695";
-		reg = <0x36>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&clk_24m_cam>;
-
-		clocks = <&cru SCLK_TESTCLKOUT1>;
-		clock-names = "xvclk";
-
-		avdd-supply = <&pp2800_cam>;
-		dovdd-supply = <&pp1800>;
-		dvdd-supply = <&pp1250_cam>;
-		reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
-
-		port {
-			wcam_out: endpoint {
-				remote-endpoint = <&mipi_in_wcam>;
-				data-lanes = <1 2>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
index 359dc08440a8..a3d73a87d797 100644
--- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
@@ -5,26 +5,29 @@
 $id: http://devicetree.org/schemas/media/i2c/ovti,ov5693.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Omnivision OV5693 CMOS Sensor
+title: Omnivision OV5693/OV5695 CMOS Sensors
 
 maintainers:
   - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
 
 description: |
-  The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, CMOS
-  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
+  The Omnivision OV5693/OV5695 are high performance, 1/4-inch, 5 megapixel, CMOS
+  image sensors that deliver 2592x1944 at 30fps. It provides full-frame,
   sub-sampled, and windowed 10-bit MIPI images in various formats via the
   Serial Camera Control Bus (SCCB) interface.
 
-  OV5693 is controlled via I2C and two-wire Serial Camera Control Bus (SCCB).
-  The sensor output is available via CSI-2 serial data output (up to 2-lane).
+  OV5693/OV5695 are controlled via I2C and two-wire Serial Camera Control Bus
+  (SCCB). The sensor output is available via CSI-2 serial data output (up to
+  2-lane).
 
 allOf:
   - $ref: /schemas/media/video-interface-devices.yaml#
 
 properties:
   compatible:
-    const: ovti,ov5693
+    enum:
+      - ovti,ov5693
+      - ovti,ov5695
 
   reg:
     maxItems: 1
@@ -34,6 +37,9 @@ properties:
       System input clock (aka XVCLK). From 6 to 27 MHz.
     maxItems: 1
 
+  clock-names:
+    const: xvclk
+
   dovdd-supply:
     description:
       Digital I/O voltage supply, 1.8V.
@@ -72,7 +78,6 @@ properties:
 
         required:
           - data-lanes
-          - link-frequencies
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
index 0bad7e640148..e466dff8286d 100644
--- a/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-isp1.yaml
@@ -199,6 +199,7 @@ examples:
             wcam: camera@36 {
                 compatible = "ovti,ov5695";
                 reg = <0x36>;
+                clocks = <&cru SCLK_TESTCLKOUT1>;
 
                 port {
                     wcam_out: endpoint {
-- 
2.40.1

