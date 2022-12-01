Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B115963EA4B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiLAHXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiLAHXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:23:19 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B730D45A37;
        Wed, 30 Nov 2022 23:23:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jo7Ilyv7Fusd6vk1hUPWTXxOsf6mE0IeN2d1g6jHQKHA0eOWlb5lZkSNcHKnXgPNpRcsRfy87kujjPrVzxRp65b2LMPIKNB49E7YTa5JKZZJw2YKwioUkkN+CLRRiESeR3GLqeR33xaaHLNIELFJ+KqCEOAJPMftHw3vQmpHC6cPPqyaMpZMvb9NJsUkMVurznC+PI77TT2w04kXvgeXHouNTxWs2KT4YWKUsIi9e36APRkwTMgV8FyWIaPvkl2iy3+8LpqUTl/2KEPgOh3ptg3XYZ1FXEkiB7aULUSgoZEORdHGncRPMWefuXAZ/e7LgVJ3Ghd/qmZpbLamY7ef5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcTrI2e03/n02a2qEVj5OqMq+C5Epm4gNCCaNxoObWE=;
 b=k6HDFnJlug4r4qXUY2jp724D71/S4AB7WRjKzdpCoY6ENjz2DUq+ToorocieDUobVSTTZLH9LURtqy3rshuwZ2lwURSxOSAad04jGY0TCdg29zHFy7IHZ9CLVYbOaGDDNCqGJKaSssR42a1PhF2ZXeuHPY0Z6CLlbDXC8tu/gIFL1M/GoTamRuxGaVXKOsP1CSzE7ya+gMFo1LMGUNxcODR8tInffh0OnVj0BY+cVlrZ8jBOhFzHeottGmV18tJaVWaaoMcsfGlTZzl2Nr8BR+q6ANA3PqRxISkTvNx1ccAe41yLcV1G9cRZkcva0okecnYL94MxT0lwmpDbGqwJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcTrI2e03/n02a2qEVj5OqMq+C5Epm4gNCCaNxoObWE=;
 b=Bft+8wn1o8tTRnaspUVpz7vIQeTsRMHWMkmW8LMgup1y5zDLTqMQiG02XZkdrCvLNnEIF37lo35KQOcV8TJzSAWKYTK5tDTdMo/hLUzzOEwcvb6Sx2KEcXhPa2FnJd8B8+wDwqAk8NRqiiNehVN2poFGj2fnC9Ixbgk6AhKk4RQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS8PR08MB6023.eurprd08.prod.outlook.com (2603:10a6:20b:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 07:23:06 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 07:23:06 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/3] dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
Date:   Thu,  1 Dec 2022 08:22:19 +0100
Message-Id: <20221201072220.402585-3-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221201072220.402585-1-gerald.loacker@wolfvision.net>
References: <20221201072220.402585-1-gerald.loacker@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0501CA0024.eurprd05.prod.outlook.com
 (2603:10a6:800:92::34) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS8PR08MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2beabe-e4a2-46a0-f400-08dad36ce423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+hLmNdiImaZqAvZ7ze+KyuKZm304h1Q7XfyEE/IPhaLCW4LUeiPIkZrvln9Jf5zN+UzcMI6ApZKVH8d2z1J1zNdTvY3pSWP4BRxMbB5BxpDMA115lW0kyOQOCWlDVVz7w9xOXrU9dPKu98c3CpwU9SXvEu1tWrtEOt5TTLCRRqN1itvJhmJ67Mgem3tEgol7V2EFF7FvTSLGK0mRT+P3eACR+rDcQmHQ2phfdDAIdzu/UWbJUUWLgFDKIIOmENgQI0c8HldQZU/gRxdUS9LXWei1ADa008UkqzmmsPyyr8eiylo/RlAxeimnb9lVgFabqIgXnZKoIlWchULx7tSo9yGvCu3KThskaKYWh0u9HsbbqP1/rTepeevKx7ZZMLtvlEOr8o1FSAgBM/dO2zgLM/F5Ez0M0K3cYXnBQgUAV5VNBUESTJoxARFykTpFDYNo6t367UZ5osVjNJtjaE2fgAOyCmZ8Uu0iIIXHj5THJHoxfkNPms1RSXCdi3vivvEQGvE4kVWPYdiEMrS0LO6poRmY2VAqbNMZv6xSjJNw5DOR4FQGxFl+MiY52mcibnRPRORhRwTwK1JZxe2OSjQceN9ygEJscVoUlhq7JGOGCD2LCID6jIxaVyGAQ8M5J3/1of0pNsVFBkPNJJYuVYC2QsX4oQO4UhHoCNR/fiOl1TvXGRMubMbkaipc/UrJXcNhImLc9wH5bmfVfSWXYnjCnDB/6/GwOqX6fs5SyHEUzaYPFWJZm7x5MZyonGiPVEP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(136003)(39850400004)(451199015)(8936002)(5660300002)(186003)(36756003)(66476007)(41300700001)(4326008)(66556008)(54906003)(316002)(8676002)(38100700002)(86362001)(6486002)(6512007)(2616005)(66946007)(26005)(478600001)(7416002)(52116002)(1076003)(966005)(6666004)(38350700002)(6506007)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FwdW93S0FMZitKZXQzbGdra2NDR3dlZ1BkNzlxWDlhSkFtT0tMT240Y0F3?=
 =?utf-8?B?c0RKekRvNEYwdUpvVjdDemVoZTZBK0Y0Rk12UWdqd3R3NkN6QmczSWJRQ0pw?=
 =?utf-8?B?c3FUNlgvK3BCM05zSG9DNXN5SHdYcTBCNXhyNzdMNng0TkZlS1NUTm0rSzV3?=
 =?utf-8?B?RnJ0dnZqU0pBZG1Rb0gwSWF2bnErbXlwTTRTckhJcjdRWEJOVUFSWjlZSVNN?=
 =?utf-8?B?Wmd2YitmN3Q1SXR3M25wUU51cnc4c2pSdmFkY1JBMXF3WjZHZ3VMNUZtZDN3?=
 =?utf-8?B?RzQzei96TjYwU213ZlpGMUlwOENPeVlHYkRxYi9sSzdFZHVMcHRXVFc3V240?=
 =?utf-8?B?UTErc2phMFF5OFNCN1dqdU1XREdLZi84OU0zcDF0K2RNZyswUFR5aFk5M3pC?=
 =?utf-8?B?R2xtcUwxRkdmelJBM0Y2TGdFTlVtRWgrTDEvVElKRlNCNkxGL3hDYzFKQ0lX?=
 =?utf-8?B?SFdGVTJQTFd2bWl1NDc3TW9EdXA2V2FyV3hrT3Exc3QzZk1pRnlVOHRGTm1Q?=
 =?utf-8?B?U3gwSEhWNXRVV0ZoU3VEYnBTRFFQTGtVd2M2V3pYTnl1dXV0RU5PQ1d0Y0VF?=
 =?utf-8?B?ZUNlYkUvUVlXOFZrS2huVkF5YWFyMWYxZFA2RTBXeWl3bkJvZzkzNm9pMlBn?=
 =?utf-8?B?RE04QkZMTFloMHBKM0c2THVabkNIMTE5bkl4QXVoMWdJWDd0VDZKR1JpaVZi?=
 =?utf-8?B?bGNrdHMzSFMzN1phLytNdjVwZlg3K2NNUTRqTnlabUNGanlNdDFROHBqLzFP?=
 =?utf-8?B?dWk2ZGxmK1o0bGtDMzVoRWYwZndzejV3WjJnYmhjU3o2WEw3dHJLWDZDVk5y?=
 =?utf-8?B?aUkwUnFFM2lKcnlmUjYzS202QmQ3bFIzdmc5Nm84Vmt2dENhOVFpTm1YTWMw?=
 =?utf-8?B?VXIwOHF3NnVLQWYwSWhoR1c2c2E4Y2xqZGk0V2Y3b2ZFeHdqc2E1UmFUOURp?=
 =?utf-8?B?NXA5ZFdROTRIeWRBTXpSZ3cvMjM4NjhsdlQ4bUwxNy8reWNscmZyRTNEZzgy?=
 =?utf-8?B?cmpVR0k1WHhxSzMxTmtaYnNxZyswbkk4VE55b3VXbmRVMlE0TnRzZUlIZWdS?=
 =?utf-8?B?OFcvdXpqeUxGc3lEYVh2TzhLTnN2R29DZ3RRUXd1alpBcVl3QjFqSmQxNHpT?=
 =?utf-8?B?S3FKcVNEdW10RzRnTFl2Qm9ueFB5NkhCb0E0MEtwQmU5eUZmK2QvaWI1RnlN?=
 =?utf-8?B?VjJPalVlajZqWmdLd3p5OTJyaEpPREdWRlBZT0VqS3U5M0dYZVpubGlMTW95?=
 =?utf-8?B?cSs1L2dLYytNLzhsZStzZDRtOXZkUFE3WlgxK0xaNVhaVnd4YWliRy94MkdU?=
 =?utf-8?B?enBoTERmV1dSUk9PYWlpT1RLbDd1eTBkbXRTOFJHQUJLelpKemFLSjBEMkhk?=
 =?utf-8?B?NVRDdlhORS9yaEFqREdjQ2dkc0V6elV2Yk92UlF1MkI5TjUydWhmSy8wMEFU?=
 =?utf-8?B?VHpHRThNWXhLMmZ0ZUQ0Sml4b3lQU1dGL1FscndmTDR3NnYvWTJTZ1l0Zm1x?=
 =?utf-8?B?Ly9UUy9KRWprcm1SUjdnQnNoVkpJSWU3QjRpek1saXd6dHZieUZIUWZtaysz?=
 =?utf-8?B?WnFIb2ZrTTl5Zk9yd0ZHaUhDZ3o0UW1IMzFXQW1LMDgwbmp4SitZSitETk9R?=
 =?utf-8?B?bEpseHlkZ2xZcDdYc2dYSSs4QnBKMmxTVW9YNThpNUhYUnZMcXFyTCtiYmhL?=
 =?utf-8?B?ZEFBb05XblNHMUJyK3NjSXFrcjZvallLcVVITS9YdlpnQ0E1MDhZVTJPY3o3?=
 =?utf-8?B?blU4ZitQbUxxVHdGRFlPWGJDUWdNeFZuZ0tQaTQrL09weE45K2FlcXYyZzNL?=
 =?utf-8?B?b3NHcDY3QUZRYkdRSlpjN2hhUi9BTHE0dFlmbi9LcWhka3N3SmlIdzhxdkxi?=
 =?utf-8?B?cHVEakFQQjVSS0dpTlFtTVlpYVBvNFlMUk4yMDJqMFZyU01HSE80cFVIQXpy?=
 =?utf-8?B?MlpxaDE2Vm1NQ0F2aS9pU1RrdXUrcC80RFF3N3BtKzVGemRvRnNGMklkb2U4?=
 =?utf-8?B?YXpVR0lDeXZTRGQ2REZ3cjFjTTlyT25vZVBNZk1TT2tGS2d5QXd6dnJMbE8v?=
 =?utf-8?B?OXVnSmp1SGpRZXVyS3lPSlp3YU8vUHh4OXhsZnhzWSs4L0ZlN1ZYRjQyaXlU?=
 =?utf-8?B?N3Jockc0cmg5Z211VjNNdHhPaFdBZEdGeUFjT0Q2V0JMQXlzUTNsd0x2UStJ?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2beabe-e4a2-46a0-f400-08dad36ce423
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 07:23:06.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrzPTDbNM77NpZ+eIhvq3NlYrCgl3DDKeAEnwggFIK319PB3KZ5Vr0aK3QimXQTrArmbdh99dGfbVA0g+kSFRi5VXXNSxSUd8B/c0Rm7OXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for TI TMAG5273.

Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v6:
 - no changes
 
Changes in v5:
 - no changes
 
Changes in v4:
 - no changes
 
Changes in v3:
 - dropped quotes from strings
 
Changes in v2:
 - Removed nodename
 - Changed angle-enable to angle-measurement and used strings
 - Added interrupts
 - Removed vcc-supply from required properties
 - Changed i2c-0 to i2c in examples

 .../iio/magnetometer/ti,tmag5273.yaml         | 75 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
new file mode 100644
index 000000000000..121d540b7b6e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/ti,tmag5273.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor
+
+maintainers:
+  - Gerald Loacker <gerald.loacker@wolfvision.net>
+
+description:
+  The TI TMAG5273 is a low-power linear 3D Hall-effect sensor. This device
+  integrates three independent Hall-effect sensors in the X, Y, and Z axes.
+  The device has an integrated temperature sensor available. The TMAG5273
+  can be configured through the I2C interface to enable any combination of
+  magnetic axes and temperature measurements. An integrated angle calculation
+  engine (CORDIC) provides full 360° angular position information for both
+  on-axis and off-axis angle measurement topologies. The angle calculation is
+  performed using two user-selected magnetic axes.
+
+properties:
+  compatible:
+    const: ti,tmag5273
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  ti,angle-measurement:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Enables angle measurement in the selected plane.
+      If not specified, "x-y" will be anables as default.
+    enum:
+      - off
+      - x-y
+      - y-z
+      - x-z
+
+  vcc-supply:
+    description:
+      A regulator providing 1.7 V to 3.6 V supply voltage on the VCC pin,
+      typically 3.3 V.
+
+  interrupts:
+    description:
+      The low active interrupt can be configured to be fixed width or latched.
+      Interrupt events can be configured to be generated from magnetic
+      thresholds or when a conversion is completed.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@35 {
+            compatible = "ti,tmag5273";
+            reg = <0x35>;
+            #io-channel-cells = <1>;
+            ti,angle-measurement = "x-z";
+            vcc-supply = <&vcc3v3>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..ea7acec52f8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20613,6 +20613,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Odd Fixes
 F:	sound/soc/codecs/tas571x*
 
+TI TMAG5273 MAGNETOMETER DRIVER
+M:	Gerald Loacker <gerald.loacker@wolfvision.net>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
+
 TI TRF7970A NFC DRIVER
 M:	Mark Greer <mgreer@animalcreek.com>
 L:	linux-wireless@vger.kernel.org
-- 
2.37.2

