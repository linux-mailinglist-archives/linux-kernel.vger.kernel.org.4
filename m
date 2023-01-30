Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C643A6807BD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbjA3Ird (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjA3Ir0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:47:26 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2012117CE6;
        Mon, 30 Jan 2023 00:47:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCf/7MoKScJwema7NdyyU3/PkuJPSYbGVnJyxzQPodbj/ad88zBfx71U0TADrbNPV8bQ6OoaxX6w45rlraw+Sybl4mSO9arlY7fCDacJyKgUiaX+YFryxkaumtzOZGVnSHrE84y8E7m/PPBnpZrY8Atv5hpRF2H2bXh16VDEyi5HgQyCl1UdFFkKMNWpW6bC2y8pmn5D4tr9vSjMDVvDUJeHvos3keFZxlrzhrknZV3lHrQ007UPVSq/S+uXLGkHyiY/JPWq+m3Vi0WJ8jPQQUMvcgZbgln+4WEdabfXaZ+Xldx+yCqW0fVC8wIXXIYVEoSYGUePcVZJntp99Kbmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY2kbud4Cz5+FF2C2zYEFNIE5tFqzDn44DYSo08ciRk=;
 b=FnADakE8XPdk0Rso21rQCBSxes7v2gXGifrsYcUB+meeTu7c3TGP4FfsXPs5ds2lCFyvcTclxJdAgR8MeNb8pNWGuEuDw6bzXi8Gb1SiERp/AJR8hPiiSjnZqIrPTYdZT8V0SCUWz6CLdi/yxE/EzQKv47VOesAXyacu1JT4CWPZewFdPxYHEIp23t9eSIC61TzrMeWiIZf4YvtQZvB3zQrTwk6IfsY/rRZ11EfaOuWrOznODcpXgBEeGUrvJYwJ47xDQXlho08oLu6qVp+IR0tRC5I+QgYgl2a4tHGivPFR68i0F7aLyJM4Jw1uKisBR+MiNVj07hPqzrLdOm8+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NY2kbud4Cz5+FF2C2zYEFNIE5tFqzDn44DYSo08ciRk=;
 b=Iv/BnuxEh6wMWan4LHT5Htqss0QTi+yWQrLma2boEJD49oAECgxMhaQvtLisxnlUImpISWcuCZuPFJKw34KdOckqU/OjN+pv+J3Rgv+zrE9bTYpigfvlsqsSdbBjhopLVpo29DuRIVJlKZsY6Oy3R/8gy+BAuDeYq1Hh04+hJok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS2PR08MB9046.eurprd08.prod.outlook.com (2603:10a6:20b:5fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 08:47:24 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219%2]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 08:47:24 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH v3 1/2] dt-bindings: media: i2c: add imx415 cmos image sensor
Date:   Mon, 30 Jan 2023 09:47:09 +0100
Message-Id: <20230130084710.297004-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230130084710.297004-1-michael.riesch@wolfvision.net>
References: <20230130084710.297004-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS2PR08MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d20fbb1-0bd1-43ac-c99a-08db029e9b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZeobmEo6iStgjyJC0mQcUikr+9wR/UC3XuJXpeBX5nRZqyb+iAtJdCgx3krF+YdtBExPSjPVzH4kwhPaEbJ3Be/UjpgzNHsrfvG5ti3UubriX2doXiVU297hpn0iO7MCR3kQNnb7lDEHdquivl4GHiZfRvCXg02XQwpIolC12705QBpM6zBXXv8sZhKqqD0sjV52lv6DzxOvUZ6Qem8u3I8JFwqiUTTWKh0aqYyIMq15PXJRFUP4biAiWtO5+cD2H5IEMza2GFBfpUpGsIp7e8lsxLZ/acb2UErB69BJPl8FRrcKY2g3dMRs0avSHETcMXx35Xq9OgJEE+Z7unXDE4wss36/070/fysdbZ4w6lIXD2DCNmIBJqEKEuslU8X/ykfDx30o9IgCUM61L0TVOkvwTg0ib6zroC2Gty7LzJIKdch7BMD8APaefZr+GdN/rAv7miMElvY16yt15pBErXFFyGdmMAXH1wyEBr1ojvUSUheMwYFhw3+0yyUR6dnYMdUjcD77cQLMxkQPOFvVLr1502iACKA9Hx5rCzJTVR/7zE7Bq6Mo8HmVGhtA0G01+Sw4ARcCKVdkxZWKFYxfxSHVf2cEWk8yW9BWLFNDJNDVfwaTF/8Pi4V/sHlyjB1vQ+CUQMRiGzCBDcyumM6KxktUc/NsH1vGvpc0UqAy4aMC9wGXNPkqGC4hBboCPsk60DPFnRDrCrUVvD8lef9G3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39840400004)(376002)(346002)(366004)(396003)(451199018)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(8676002)(66476007)(8936002)(41300700001)(5660300002)(38100700002)(86362001)(1076003)(6666004)(966005)(6506007)(6512007)(186003)(7416002)(44832011)(2906002)(478600001)(52116002)(6486002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fk7rMQ0cywPVZP5FDH1sMYKEkMa/9/2e8dE9hsefaPbJPM4m48IoevPjRCO3?=
 =?us-ascii?Q?EeCwoOc8IBCsI4qkDpirwOc4qX4VxcuGx6+bJNTRV8LiClh6GfzaGS4NaOWS?=
 =?us-ascii?Q?qt5TUrindfZ+sRMdR85UE/OBpyFCnU9TDi4S/Zv1FGEzcOfJ3it2Ei3gA8PL?=
 =?us-ascii?Q?FdhKaAwpEeZkdPgmlkMI56tGQCO8Q9qkR0OGxezwM60na8j50rCJ/CDIoo+I?=
 =?us-ascii?Q?f6EpXDAcYw66kN1rfLTOdIYpK4LlpcLOlJYbCNZd+zUXS3XEU7GVqhD406yd?=
 =?us-ascii?Q?FeftVwMzUzxaxha3HkfcXfk9D6Z4SKsivtZL7RwwwdmQsplltv/Oc0yVRpzV?=
 =?us-ascii?Q?yQ4OeU6JReKJEUSwLYIBCO0KnGaKIW2EnjdMg4Fyvlazng3+CxqpKxicd7Ew?=
 =?us-ascii?Q?92iof+8EdG/lVZeoTobn8PnQXA6bzcdtO7l2zptvgnnK+AaGtkNuecZJDbKe?=
 =?us-ascii?Q?IGoxh9wRecxKx2Kob31lXagNTwj3SZkPHLCUh9en6UpL1nLq7+2g5Jwhw4Sj?=
 =?us-ascii?Q?Zm35EEKqCef4F4qvcJU4rda8wcr0XPBRp0URb7FttGWPXtPVkRIfcgcH/yUL?=
 =?us-ascii?Q?0loFFLzYYRAHPfymdDR+59z4ohCLkZ79SK96iD2l8BiJ4XJmhPWDYcjnqyxR?=
 =?us-ascii?Q?FsWlMh6S7LrmoXy7OvbfFt+66yLQstFlhpS16ATBSpi9V61909U68phX5HjR?=
 =?us-ascii?Q?sCedc4/ZKdaaGLrCt5T4Nf/gj4pF+RkzLrDeK+uJ6+QLsRj/zk4bYxeOUTcw?=
 =?us-ascii?Q?5GPv8j1KyZtEHnFxUTlEj1U1avbDNZ0SgaMjk0/t315Q2Uc6EwHw7hDBE5cb?=
 =?us-ascii?Q?uFkklP4fm0dzhj6c8jtZFniZqvRk3piOKArlljDJCi/3S0Fe7i92szYjT+UC?=
 =?us-ascii?Q?Ajmu29WiIugT5cZFEgHRX4BCXOu7j3OjRswouFTGi9SSM4ptVKLMVC+lyYsU?=
 =?us-ascii?Q?nO2h10hht2mS9XHncWnMBQDSxbe+xDTdiZ8VVHoAsRH7hkTnFVn4/axnBvgA?=
 =?us-ascii?Q?zWY/biCUDQqTfA/eDN38C0cv0u879uED0JphbxudpFE2/LgtJDYTE7pWjMMl?=
 =?us-ascii?Q?lrYS9/+odSBheIH2JAnrCVVg1kZPPgyhvH1UKmoVrTVBHUs9aJ9K2yStGYhr?=
 =?us-ascii?Q?Ilbe2XwU6KHlhY3AEHvOBtD5lKK7JKI8Yh9c/JXX5CKXA2H6+rZwvlEhe2hz?=
 =?us-ascii?Q?0co3togvYYfdi1dnrata7RBnSrpXpwLcdPd9/xquJty7pTAvHwfvOwYiUJZ/?=
 =?us-ascii?Q?z7rwtCFBO2eLjSU+LiuVw5KKh9AYybEZ4PDn0Dh/7AzvA70IMn8w6+INgpws?=
 =?us-ascii?Q?IAASNf9o7Lgk6REBuXUwlCQD/6MBki0JmC0e4j+k2lGwIl4IfPD8+QLj1CZh?=
 =?us-ascii?Q?KVhVhCx0xyc6pipcLau2ndM7KHHWzpqgrC3l36eOin5nkb8fH0hKTohASkkK?=
 =?us-ascii?Q?mGDtqCgaWmUJ90gTXs1qYqSRkUN9naRsY26l+54h5+XOy4TFFeaU3O9shWyg?=
 =?us-ascii?Q?XvUZ238ZYuP1jRzoYZE/EjcxgHnHViD4rGfol5VtVfxMI7rCSBBjSHXM0Su4?=
 =?us-ascii?Q?tDnLEQBVKopvvOPRmV3EFIQTVI/71i9q+/ZcgQxm1rnCQZmx6SxYChqp07kl?=
 =?us-ascii?Q?G/YIRhlka6tbe9NxWXGnhit+1vUb5dBYn+9uWT8QaXx+Phk2GfPG2Ujxqswe?=
 =?us-ascii?Q?j1deIH5bCfQIjDt4wMFagIOyjPA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d20fbb1-0bd1-43ac-c99a-08db029e9b70
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 08:47:24.0099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCcTkNlcXPhCTz5nNGp5njzTs04/6TYmeHeLoOBcCHtatZNom91pei3Xma73BPkinh9V+so5WWdZgYxdKPNpuvG6YwaCIwEIrwFQAfZds/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for the Sony IMX415 CMOS image sensor.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
v3:
 - move description from clock-names to clocks
 - drop clock-names property
 - drop "link-frequencies: true" in endpoint description

v2:
 - fix reference in port (must be /$defs/port-base)
 - describe data-lanes in more detail
 - remove unexpected property clock-lanes from example
 - sort properties in example alphabetically

 .../bindings/media/i2c/sony,imx415.yaml       | 122 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
new file mode 100644
index 000000000000..ffccf5f3c9e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/sony,imx415.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony IMX415 CMOS Image Sensor
+
+maintainers:
+  - Michael Riesch <michael.riesch@wolfvision.net>
+
+description: |-
+  The Sony IMX415 is a diagonal 6.4 mm (Type 1/2.8) CMOS active pixel type
+  solid-state image sensor with a square pixel array and 8.46 M effective
+  pixels. This chip operates with analog 2.9 V, digital 1.1 V, and interface
+  1.8 V triple power supply, and has low power consumption.
+  The IMX415 is programmable through I2C interface. The sensor output is
+  available via CSI-2 serial data output (two or four lanes).
+
+allOf:
+  - $ref: ../video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: sony,imx415
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: Input clock (24 MHz, 27 MHz, 37.125 MHz, 72 MHz or 74.25 MHz)
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog power supply (2.9 V)
+
+  dvdd-supply:
+    description: Digital power supply (1.1 V)
+
+  ovdd-supply:
+    description: Interface power supply (1.8 V)
+
+  reset-gpios:
+    description: Sensor reset (XCLR) GPIO
+    maxItems: 1
+
+  flash-leds: true
+
+  lens-focus: true
+
+  orientation: true
+
+  rotation: true
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes:
+            oneOf:
+              - items:
+                  - const: 1
+                  - const: 2
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
+
+        required:
+          - data-lanes
+          - link-frequencies
+
+    required:
+      - endpoint
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - avdd-supply
+  - dvdd-supply
+  - ovdd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imx415: camera-sensor@1a {
+            compatible = "sony,imx415";
+            reg = <0x1a>;
+            avdd-supply = <&vcc2v9_cam>;
+            clocks = <&clock_cam>;
+            dvdd-supply = <&vcc1v1_cam>;
+            lens-focus = <&vcm>;
+            orientation = <2>;
+            ovdd-supply = <&vcc1v8_cam>;
+            reset-gpios = <&gpio_expander 14 GPIO_ACTIVE_LOW>;
+            rotation = <180>;
+
+            port {
+                imx415_ep: endpoint {
+                    data-lanes = <1 2 3 4>;
+                    link-frequencies = /bits/ 64 <445500000>;
+                    remote-endpoint = <&mipi_in>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..c9fa893bf649 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19493,6 +19493,13 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml
 F:	drivers/media/i2c/imx412.c
 
+SONY IMX415 SENSOR DRIVER
+M:	Michael Riesch <michael.riesch@wolfvision.net>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
+
 SONY MEMORYSTICK SUBSYSTEM
 M:	Maxim Levitsky <maximlevitsky@gmail.com>
 M:	Alex Dubov <oakad@yahoo.com>
-- 
2.30.2

