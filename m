Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BACE671A52
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjARLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjARLQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:16:45 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BDA458B1;
        Wed, 18 Jan 2023 02:32:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsYqyBDSstqF1o4hC3ZZCwpC+q8vzo7xCf38KX0NfWSG4BjZ/HMO4gCwPibyDEQzL3MyXUAIpTbuUafWcZnlNR2+42kTwhmBtwYSZUXljcOrh7aEPoNFtSkuJjrEMBP3fR3LZbrKXXOPtEgIGZz8nYMHRVQPrtMiKWctx6fa/3zqde6VJkRPOiNuQ6zh01vwJ6vSBaYbuIHdh//qxB9nuePi1IOb7rPsqr/KORUtzBZ3lHN8N5WVkhPj+7UzQ86WwL4lGitk0ioCl5AmYvfnwY0TKfq9l5YqpztGQw3CpXs34xplQnz+tVoZK8bJfZWs0HO3jXwYE2oi5a01hNo6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vryhRBJFdNxBWzhe/MQfm5Mx7tNmJ6fraVBj+N90tAM=;
 b=KpWVowkGF8jImEnTlru2/zkoDiElw/lwceZEpoLetnylFIfPwk8JJrFqoDs49Nf+ZIVHorlITDBRLEjfx81JPEdaYIG1CNrJmmCY2MxZ8T9vx4j2KzRWM2oYVaBF2FqKgp0DrHtnArLItBOoQuQitBndOhx5YEVNoQpn19zFY4ldH0rbq9Dw5IbWvc6U7nilgMAbRk1k0czEI6A8Zvxe0s19vyOQcM7oyimhYbt+DsFTxcYrqi1chuqdxXNJt8qYBTcWmR+YBFRpvf3Yt7abIH4VDvu0JfQ+brhGDfTlSZG8dx7DPRH9c56RC7Igw6g00k6qNLsEwKCJctmMMD1uDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vryhRBJFdNxBWzhe/MQfm5Mx7tNmJ6fraVBj+N90tAM=;
 b=LZ1SWqIUybPVKyuz6kpHGEe+i/SvLx7XGBP/I6ntPAjfbvdTN8zdTWJAJSuuEmqhYH2dJ8JI8sHqzyZJ4e4fb3gpA6tr/esrQKc07UW3ho1rlRiE3EmZQOPBzYq8wfJSQ/WfTqGMAEX4MQ8sepG+h/I8cf5WWtiSDWJoDQg+fqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS8PR08MB5990.eurprd08.prod.outlook.com (2603:10a6:20b:296::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 10:32:55 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219%2]) with mapi id 15.20.5986.022; Wed, 18 Jan 2023
 10:32:55 +0000
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
        Shawn Tu <shawnx.tu@intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH 1/2] dt-bindings: media: i2c: add imx415 cmos image sensor
Date:   Wed, 18 Jan 2023 11:32:38 +0100
Message-Id: <20230118103239.3409674-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230118103239.3409674-1-michael.riesch@wolfvision.net>
References: <20230118103239.3409674-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::17) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS8PR08MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 50850b39-bd3c-4364-0743-08daf93f5bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YadP+eanf9tbRlRwLtxHl1d08wcNsavUI6ipId/hfQOcXf0VIYkvMIBqpd03ic2QmnB4ok4cqeJpbSRvvF1vcllSYw6eADNBGFD778nkxOw5R9xkw/imgV+zOCTgiOdFUYIgayOphMlhGZbDaqGhHVtSh+LxP+mxg/nk3bX/mN7ns9oeRCytuNkhGUaFo1UdDGSmcdfojpUwAS2EjPF7Q/J4s+f3YuqlQjtI7qi0Ju01ylyTW8D7Lt8lJA8phJuk5NK35RS0sQFOd2/MTRnPDOFxLzpOfPMHbHyqiV3I8X24e/BEx/EQ9DvC1/gdJVicVypjsl68ryrr84ZZI/C+7D1HK9C6FLLREDmdfTkreylUZRMuWu+Pnn8u5H0IUJwLfnY9Ljfu5qmRdwsc+Pl46iQoWlp7TuRf7iix1TGTU9rL83Q8t3JJ2A2H7KDXqNhBs2uUi0Jfc3zgI6PjGCr76ODPdH83HBlRGpWqtP43yp7rNR0HN6begqtYQ7GB+4T6LPH3jmvBMM7+8INRbCSwKMzTtMN+Xcz+5URSFcYUFiLpqk9Gv+902Ld928HMJX5GvqCkrR6OKrNz7tXV74i2/87avSh/TJ7vOWjBygEEX1V4TU7nVTX7t5KZLjKV3orQJLh29DOynhK4SWRS0y43NOVaJ6s4t+D+OcIrh3TxT20=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(376002)(396003)(346002)(136003)(366004)(451199015)(52116002)(4326008)(6486002)(966005)(478600001)(36756003)(86362001)(38100700002)(6512007)(1076003)(186003)(2616005)(83380400001)(2906002)(6666004)(6506007)(316002)(5660300002)(66946007)(7416002)(66476007)(8676002)(41300700001)(66556008)(8936002)(44832011)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PQrtg3+1MdXeaB7f8sfJ8HTnJocJoHmcpHsnlZgkMzrid/pdygBid35hFpEH?=
 =?us-ascii?Q?x14mieXwuE1dM8iNB7Ghu94PrgF2GG+QJ8RUEBf9rdedkJKhoPuarRcDpB0H?=
 =?us-ascii?Q?QOuBinncRGL7Y3PrG0BQaVjYtdCi2UOIblCoXH/lGlG3hfXXoz8iilWzYWER?=
 =?us-ascii?Q?09ZTmRNEhbduVyYYE73GFAaLWw4tr+5lWZ9uAqSPnQvRlv5QcccKw+L0NKZJ?=
 =?us-ascii?Q?h3BdTrxcNQ5VpqThWZ1LjhX84YuY7+vyGDtm/1XUYq5Scf8qoSxwAzrY3MPK?=
 =?us-ascii?Q?3ahyZpbtPbPBLSfl7+AO0p6FSzefj3k2yDfkUxTMnZFs5+o5yvzp8g6FFdl3?=
 =?us-ascii?Q?vk7PZHn/wXM+VHbVZeFnGkR6g2fKGG5yP+3FOwNaerbjOCe23zr+9jWu2NQg?=
 =?us-ascii?Q?rSSKT/Ke1OEGZztiH0ah9akdINiGBt3LpuK7xMKA4kHoOvf/h9aVJTA8NiMs?=
 =?us-ascii?Q?y6VrR0SZjexbOH6KOvfYHpak5+KgsqjE1AVgqjJED+J/sGiIbHUGQp2z8vLZ?=
 =?us-ascii?Q?+FK67zt6il7B2zJXWMeRcq8JSKGgXbGJAM+Mnok192JY+jNfUa45LlwHpJCb?=
 =?us-ascii?Q?X9poDpn2ACCXxZdMCH/fweyjeMc6ccSrE4p1qOUgIuz6qQODFcVQQzeWqWaY?=
 =?us-ascii?Q?t79AmljqGvZRI8IZTYeQWmUnqWCyUfTk34d7L7TfBK0wu9hIeHZYV9TtBYEG?=
 =?us-ascii?Q?+7R3jEZou0tUeFDu4N+hywWIVUwL/2zhxdlvTlncN6iq4sUp72gt27hHEAls?=
 =?us-ascii?Q?vzpqAf00UtBkpNw46VdNbTGR21x2gZcacCwqYG8PjKn+QM5AZOLkzY7kPssq?=
 =?us-ascii?Q?d/sJnzwMs8rKXRF0LuDNW/j4POE7g5nbGTj5xt7WjaYwwCWJnjHUc7EDio4T?=
 =?us-ascii?Q?P/1AfKt7ytfbitX1/HkKghV8LrmapOKo7UWL+GsEN5+LfXjFLglFwD57y9ZQ?=
 =?us-ascii?Q?8prPek2/u+54QO1vc/EwEIVdmYNxNaRJ0drFVP6VyMp5zwCzfG5KV6y86m/v?=
 =?us-ascii?Q?ETovnmAq1ONbwofzOMa7RdFWvNWIVm722k2/vu8yNTBH0F0vhTES2FlcoYoz?=
 =?us-ascii?Q?K0a5DXTu3tYA1bMRXT4uhVp5t/htiwroGwNaXEdn2FirSF3n52Gku7O2sMTp?=
 =?us-ascii?Q?TWdFjq70Kialp1Pa+O+15OkOvvNM/MA1pRgFSQfQno6xSyAmLs5Q10VU1hsI?=
 =?us-ascii?Q?0Wx2yND4f5GILrLEc9gI9wqksnq+/lJLYCwOIQB+3PJvof0udqG9gXRRucMV?=
 =?us-ascii?Q?1JgCnJM2rZaHwy3TBL9/kiBhYkOSy/G1T1931ayiVdiUeemIkm6+Ng+AiJS0?=
 =?us-ascii?Q?YRa4hCZSj1muEaj+WyQ8HiBge7/ZXgrMp3pdBeK3xgRmK4h+Hec3/aCHeXIx?=
 =?us-ascii?Q?KeTmYuXUzmBN6bWI6iKpcxGJKcg7CIWnupdwLyZAjY9wUTK8YEhV+F1hm6Z7?=
 =?us-ascii?Q?VPlx/VeTK/I2nY2EiiWPvl1b8JEzRYLGBMoN8p7EiGxG+m+fzkcBk9n5wVfk?=
 =?us-ascii?Q?Nhzex0NXaaL4YJk/IWD7pNUlmT5k6/2Cpqb5R6zA4rY87SKOerDDA2d62Uue?=
 =?us-ascii?Q?j/Ws7Sht8XiwmSzN8+QiyS89mGlUkQxUzZF8SawbA6QPBU7rGKj7QTbcp6B6?=
 =?us-ascii?Q?+3QjAZTdzfg82k4cK5N4KHbxkG0ZQtOU3b2eFAQZ20pikHjljs7NzskVwA83?=
 =?us-ascii?Q?0zqIT6kJfDddTUr3vOYQLo1ME+4=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 50850b39-bd3c-4364-0743-08daf93f5bf9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 10:32:54.9211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exebdLwgQx81IgVNf3MdmyTjZMpmTfWgR7HMop2aewK6v+GCmd3ycjlhMq0zy7U0wfWjhLLAxTXEmHr6+7jZWMp8iRazKFmaZY0FsmlQpS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5990
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
 .../bindings/media/i2c/sony,imx415.yaml       | 120 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
new file mode 100644
index 000000000000..ae54834a2341
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
@@ -0,0 +1,120 @@
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
+    maxItems: 1
+
+  clock-names:
+    description: Input clock (24 MHz, 27 MHz, 37.125 MHz, 72 MHz or 74.25 MHz)
+    items:
+      - const: inck
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
+    $ref: /schemas/graph.yaml#/properties/port
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          data-lanes: true
+          link-frequencies: true
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
+  - clock-names
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
+            clock-names = "inck";
+            dvdd-supply = <&vcc1v1_cam>;
+            ovdd-supply = <&vcc1v8_cam>;
+            lens-focus = <&vcm>;
+            rotation = <180>;
+            orientation = <2>;
+            reset-gpios = <&gpio_expander 14 GPIO_ACTIVE_LOW>;
+
+            port {
+                imx415_ep: endpoint {
+                    remote-endpoint = <&mipi_in>;
+                    clock-lanes = <0>;
+                    data-lanes = <1 2>;
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

