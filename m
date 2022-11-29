Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E88E63B9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiK2GqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiK2GqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:46:01 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503E218BE;
        Mon, 28 Nov 2022 22:45:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oemw4uvjArMSPOjG9AJ/sAKfoSF3Pj3XIzSWQNnh2OIrlbIyZMYpQnPpSMHr+hpRSWQDKmAVvAQaYzAwnaP4Z682Y/mafpadYRYlV+EVQvg8/+P6Ok+sjwauNv2cstwpXL5KCPJyD2jYuihkXBtKqFmFwh25Nmwbe5njUXjRDAp3trpky/NZdxobSu5CaD2H4cv1bn7Dad2OVG0/VbMz9nwAtQWV9hYb4vAz8939dbeEatlS+meuNY5jiB21OAnwCr7NdWRY+s8zc98qw3/KHgcLEG6uEw2pBPOaoZfiuaP/ki+FMkGGhTi7/vuUwTzAU8oyXl8sqOKqfiPpU8Hsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IghivhoFXPCp07cRabnAVKMCM9GCgoMI0kJ1DwDuyrE=;
 b=VHkjGeg66RxG7wTw8e8xY6caxgxOiyhsqFPiwaIVaVikf8J23E5MdiJeEVoLwa5WRjg8DuQf0hCpPsfBlW2kOxYLu6PG9Dh+sCebAZzVLesC1MB6tuujLu6C/GWblyTLq01xrY5U1pXlw1vMhhBEKSJ12+XdB+eHy2EW3L295pO+2uikQZEfsf2ppGams9/H+dqPb16A5syVBJN8pP6n7WTFGEuLk9jC9fOV8621+DeCCl0AwboBkH7ReQTQE1vFPpUuuXaMUChLM7/MxVaB/oASQ7Vi0ioVPCerDbasEslXJRMplejrf7K5Wksltz4qtN3mJpfsV/rh4HK4RRdH0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IghivhoFXPCp07cRabnAVKMCM9GCgoMI0kJ1DwDuyrE=;
 b=WeTAVaEU8z1j8MswDS8W+wgWva3DDoOpEtH786pZw3Yz7ZxKhf7FubTv0Mr4Mv8x5lKhREL2JT+/9Emna7D/EOcIao9Jv8Gi4D3VKVZw0aykUUSFwQvdv69GprmzOHPGH8fPubcIupdr5Xq3Pxv9+gxJd9zRwF1ChElxX+aVp70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS4PR08MB7685.eurprd08.prod.outlook.com (2603:10a6:20b:504::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Tue, 29 Nov
 2022 06:45:57 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Tue, 29 Nov 2022
 06:45:57 +0000
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
Subject: [PATCH v4 2/3] dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
Date:   Tue, 29 Nov 2022 07:45:39 +0100
Message-Id: <20221129064540.3218982-3-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221129064540.3218982-1-gerald.loacker@wolfvision.net>
References: <20221129064540.3218982-1-gerald.loacker@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0107.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::36) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS4PR08MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: ce25c3e9-57a7-4e68-9748-08dad1d55ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+nG2vu8esayOSHNW5tPsLidU0D4o1yrCzz6GTdLjavM8nu5vqlGnrywugNgnOzaOe1YKr5iTTaRDzCWAx4BYfhx731G7SU+rEn3DvyB0yL8KRICVIzwZXh8PbjYLKerXTo0KXu4/4eZRg1bGtexsjnhnvz7C3RYgrwo7Cjn6ybVCUA3o831fWFfdHag+mss+kJZRn1n9SKzUiDHUFIfUcYTUlCeKr5bQ9hZk53g6tnrKXtaNK6Ka5tfQoikAcdczfvzPrH6zPYp2lhF5NbMEQxozBo74IBTEZNNTnVfo+UM4lskrzXpB9jfEuWVgvdQsZzsy1f3HCXPEL3JrL11DA9S7PVCakD9ZjJugBehClDZ/os6jO0QSgsXAKVEna4A0stcdjD+LrPY1UsUTotbJUw18FrP/ZPZ5BF4tlV3Kq50ZVNObzym3dl7Dhf6C1OOGh7wHipl/0Cx68vDSKr51nJfqn4qbKdDskzqxJuvrG6RfXwjxZ+KjgM+wVK6WfVXddOqGxLpKA0S4QHCUH+/RX0Wg4p/s9AGDHwby8zlX9ai5YkH8hk37X40pcCS7ttufjNU160ZqzzCJihRIyzuo/uGCmNZhrGh+Wf7LqcoSGqzJ0YwA/Pd6LD2dKhar8/k+f0ItFq0eKXtqP5GaIAeXGe1gXx2E2vDDhV8BvO2gqdt9hPjTwakZEv4wZjm/TZhf66cRLt1wpiiE6OPJnIudTx37ZsmP8wIG9o6C9YoGNDzocu5geHj2YbZPgiAkB43
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(346002)(39850400004)(396003)(451199015)(966005)(6506007)(6486002)(86362001)(52116002)(478600001)(6666004)(36756003)(26005)(316002)(2616005)(41300700001)(8936002)(6512007)(1076003)(54906003)(5660300002)(7416002)(44832011)(38350700002)(38100700002)(2906002)(66946007)(66556008)(4326008)(66476007)(8676002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1VqS3RUSkV2ajJlVDRVQ2JNOVhNQ0ZvUndOYVIrRVcwdHNOZmxaSXl6Q1J6?=
 =?utf-8?B?V1E1ZU9oNHJIMnUvWWEzcmNIVWEwNlhvTkZkM0N5NThUTGt6d1Q2UjlTQTh0?=
 =?utf-8?B?YnBjdlhDcVpmb0RVMjYzQTdWdUh5VG9jbENFU2JtUkNJeFZKOVkzUWNwekNj?=
 =?utf-8?B?SU1aTFM4L1NVWnBZRXN2clFYL2dPVWF1TTJRdms1a0gxay83OVYxZ2dRRjN0?=
 =?utf-8?B?dWxrYnpWT1NnaGdBaVZiaU1seU84ZW96SHFFYTQ4K0ZaRGozdG1HN1MxMzFn?=
 =?utf-8?B?Q2N4R1o0bVJxelhBT0hUK2JHQ0FFcXpSRVNYbGhBODBZSGhHQlNVVXN1K3Y1?=
 =?utf-8?B?T3Z0clBZWVBSZ0ZIMUoxbVdPQXBFNlRnTWU1NkQ5MFpOLzlneU15VUx4RStp?=
 =?utf-8?B?SjlPaHZUTGhQWEIweVNPOUdFWlN3SWxvbmlKMFAwS09KTGhWblZGUXlkWktR?=
 =?utf-8?B?amo0dWRYQjdrTitIaXRMbnhLd0gvbmVyQnhHVFJzNXBBdTQ5KzM4ODhuWjc2?=
 =?utf-8?B?SUxQRkltd1VFaG9mekMxbjg4NnNqK2FHWWZQVWhESlN4V0t0MERsSDd6WGhy?=
 =?utf-8?B?RTFuZU9zOGpyYU1IWUhWL2NMUk1paTVvQ3BvNXdFdTFnMjVjclY4SlRJc1RG?=
 =?utf-8?B?UnR2K3Z6TzllMzFFRCtqcUc0L1dQZ05ZV3dYbGhES25YMDdlSjVTdmZkU05Z?=
 =?utf-8?B?RHJESi81Qkk2NGoyVHdSZ29wK0NBUmpXbTkwMFBqNXIvMkQxVmlMVXdqdHdn?=
 =?utf-8?B?b0l4TW94ZzhJMmlJN2x4dzNsTVpDTDROekxaM3BjTlpESzg3eHJ1ZDVTRUY3?=
 =?utf-8?B?NWI3ei9CYkFoSGVFT1ZBZVJudXY1OTdacytvYnpTdXg0VGVjYWJwU3ljVHhS?=
 =?utf-8?B?SzlNS1o1RWZpOWtNRmhjRGpocHFFWENPY0FNM2I2WVZmVDdkZGRRSnptVjZQ?=
 =?utf-8?B?OEZvS21saE5jbmF5VWNZMlQ1TlJGOTYycHQ2UjcrbnJsR1dGVXE5Q1AxaHJ5?=
 =?utf-8?B?Y0xVY2FWSW9lT0NxUWxMTHZwYVcwVTBXQUtZdWN5NGxqbWhYdERkNWM3RWsz?=
 =?utf-8?B?b1JERVdQVW40TUJRS25EakV2emhxTEtrZEhMRy9Oem94N0JzTTVsZ2FWejE0?=
 =?utf-8?B?M24vZjFPSTNYdWVtVThSazdGVHBRc2Zod1AxSXcxaWVYajlzN1J4WFg1RjRT?=
 =?utf-8?B?L1lvbVUzcTZYNjByelRlVjBFUjNTb216NDNQcGk3V0V5aUtyVG52cnIvT3JI?=
 =?utf-8?B?aWEyV1ZRWjU0N3kzSmtRYVd5ZXV6TUFUT0hYb3JHRThoMlY1SDlyUkxrUlhM?=
 =?utf-8?B?WGg1dEhaRUpxTTloU1ZEZTRFQlpkOUtBUnJrYi9nVTBIbG05elRCZEIzdXZr?=
 =?utf-8?B?YjlzWGhodDdrNUNXS3pYeDdxRXlvM1IvejhMcm56bGU0VkRBbGNXcUsydUcv?=
 =?utf-8?B?ZFpPUUVRUzBVeVBybkUwSTFGMnhYcXBkUWtnQU9sZS9uejVhUzNOL2VUNXdH?=
 =?utf-8?B?QTRWUGUzbHBaaU0wZXRCdXZrdlhRWTRIY25pTW1MZmExUmxhYXFXVDBzc2t4?=
 =?utf-8?B?b3Y0MUJxVGFrNkE4L2FMQk9YRkJiTVdBMUhpR1FSUVpla2J0ejRURXVyZi9x?=
 =?utf-8?B?YTBnMzJ4WG5Za2pSbVlRVEhpbVh2bEovS3M3TkJFQzJPNjVnVkxKUUxncXNP?=
 =?utf-8?B?YVFCZUE4NWt3SG5aNUxzbDN6NTRDUDl2SUVaQmpjUGdjNFFQUGJ3b29wM0gr?=
 =?utf-8?B?UHpoTmFjbUlJRHVudXNTQ2pKeFRQZ1JYaitlbGs4QWh4NnltNzZyT0VlTEZ3?=
 =?utf-8?B?YklKWlBETjQrMmYvZGR4b0R5cE1HaDNRcHFKdU5TRVQ1TnVKQS9pQjVvR01z?=
 =?utf-8?B?SEdoalRhYTFPQjJuZW9wcTcwQnh5VWJQMjhlQ2RCWmF4UGRhVmVvWnI0VHNP?=
 =?utf-8?B?YUZWbFFhdFNWLzY4U1ozYSt6Q3JqeGZSZW5pUjFSZWRlcGp4NDJxODZXcURW?=
 =?utf-8?B?T0FSYTdnSWowMkx6aDVVUnA0LzVFd1NJRGgyMSt2S28rZVhqblU0WXBQeU5Z?=
 =?utf-8?B?WVZQYjh1L0c0dmpQWStuV0d2d1lzRHBMTWtYNFY1WFRQcldrRlFUZVM1V0Zs?=
 =?utf-8?B?K0owMkxMQTZJNzJGd1lWeHdidVNaYWVsUzd5ejhlcmpTWUhPcnFlZE0zSEli?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ce25c3e9-57a7-4e68-9748-08dad1d55ec1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 06:45:57.5424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4WbfHQl2REHgcKVqWxKxmeZh2fIbiG4DkTpk6CrSv1r2DSx1YN+AXwyI8CB+y4jsYACLjTlE4n8INNEUnNXIAvnqzEAd1oB0IW5mExX3eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7685
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

