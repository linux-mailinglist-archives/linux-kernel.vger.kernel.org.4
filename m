Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D89629296
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiKOHhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiKOHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:37:38 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140042.outbound.protection.outlook.com [40.107.14.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4E6209AA;
        Mon, 14 Nov 2022 23:37:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf14vd/QAF/eq4K3W5wei5FPizC3v+3YTG6HWiwjw6lS8htHJSOk1cTsVvu7Szhk9Mkvmq5fPamjc4Jhm5O9efK7ftfI8WBMjrAh7q2UeUzvaxPSUe2nhh+pl3MDP/QOyd6TN/8KltuXrZjxF+9yyECWi2oWS9xdRNfyNzx3cPAf513nuH3NpBq788KcdxlmN1J+A5xMYcicm+R59u+2nLcGGGZLVki8mxogjlk2F86plIPhVOKLJfAhhz5Aa2bXyAXc21L1UGRcaw+svcIYJax4mnKUiq2LLOHUm6zOYZNY6FtRyIOmPoLolHmAdDFj4SH5nyIaEu3Gn0Urc4BxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKkktckgcoLhaPIuecgGEjPGNGph/Tl8jonJhS5cOP8=;
 b=YzxDM3+lOgvwz8nl9uXbux31BeD1a+iIgGXbLGuiT5QJk9mgF78CdyaN4Bmz9KiIfPQCdtlCvJ3UkgVSgYgqXgOQalPkkNXUb3FIn/da7NjrnuU5MvVIa9ZL/Mu7AjBIYhOk3HU5qZ+q5Yvj6YC3QJSS2aLYV8Jr4BM5KjSZmMJywyP0nQnGwbZm7gD2HAbZ79MyrIVHUWXnZV7had3biD7I4Qpnqk7YCg9XlvDe1f9aFWSE0wUpoaVNmBv2vU4ICMXi7baWxJW910TUenBuvpjmrNAS3OlhnyAqA9baSVM5UqBRYShHMB95vWrLYNMAo2kyUOdA4UE4G6lIWlxcOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKkktckgcoLhaPIuecgGEjPGNGph/Tl8jonJhS5cOP8=;
 b=OWYhJuLqkCtLrgmyy5BAnMn37leSH9Z6nqhHmSUKzCoa44MK5dk7ICqNaJBtQdDzRgi6K7tRQw9z1mx89oONJMUd4WrJ636gHUnbO7e18xakpRbG7A7Kl0xDp1IZqbHhq6idX9hEeTtI0m6D7n+XeSa3Vvy9XTeP5izVDEw5ayI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS2PR08MB9572.eurprd08.prod.outlook.com (2603:10a6:20b:608::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.7; Tue, 15 Nov
 2022 07:37:36 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5834.006; Tue, 15 Nov 2022
 07:37:36 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Subject: [PATCH 1/2] dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
Date:   Tue, 15 Nov 2022 08:37:17 +0100
Message-Id: <20221115073718.2377311-2-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
References: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0017.eurprd08.prod.outlook.com
 (2603:10a6:803:104::30) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS2PR08MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: c3af0130-8ea1-4106-8205-08dac6dc43fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csp/AlVOXbsny1iREfL4sQikfzqsdwegwy8ePmCuUn3QHkr5l0ZlI3YD3YTCpQn71jRffOoVgtB/tEwznHKJy3tHAtEJ/Y9x4rUVkhhr5snHZsmHeE4TJaHP6YNrC0e05Lb0GBH6L5zr2LSsP+wKL9eRC2Ta2HMdDBpqan17fOSSAaYBmk5hwApA/28jPb3V0X924ht10/po2AzOU2BhfVjLN4FtRTBhvU7pVgSgWnvMI7dvVwcYLxHrYBzjijc6D1mPn3Q/Q63SsY2kLQ+ZJsBjxE8M8/1Z6hB14VTMxmvlMkmrs8uhC3h2Z3LAUlEm0e40eadFDTOj0l1z0LXs0OurI5nEpXByUPlVm/m0TBUei2hF7yFc3IjS9rWyYIfAyc4HoMvsG0D/VrOmUGrGp1TqyZVFXcD7YRk/hoXNQPClCI74pW6gRsJOeykODD96nDuJsUJ+fxiad5mEei+lXokS4m1ealy8GBW4pevmGP661GA3l5gRrgPiKUXSudVgNf7HSOyUoksILEbblFprTyUbqSaXi1S2JhH/IurHrJKg1ojTwgy88QMC1q9JfAaXIoZUai7TCHzhKctnAQzxJsqNlEwCEP0pdryBdvKG9ngd4hx/w+eP/610cy+mj0Sh6Ud4JagJo4SH1p65j0RMLoPAbppDn6MrOqwmz+mwsjg/vuqNWY9DllxC1mHTBWxtWaaOiD5uk425/Gp+GCmvZ7qYoPav5G7ZaADxlee/MYDVrE+ty5xy9FBSZhjXdcdE10fBgwwddFoeQridthWoPyquu7XS3sIXrLLHTahT2CVTPecTLapfDBXrH7c1BCY3sYO2bYqQhyBjaKauqKD/PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39850400004)(376002)(451199015)(186003)(107886003)(86362001)(41300700001)(2616005)(26005)(6512007)(6666004)(6506007)(38100700002)(4326008)(8676002)(1076003)(54906003)(38350700002)(66556008)(66476007)(2906002)(5660300002)(36756003)(66946007)(966005)(6486002)(7416002)(316002)(8936002)(52116002)(478600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFkyN2VSOStKWVRuSTlCaTEwY1piYnpHUExCUXNCblFWRTM3ak5rdlZHcmp6?=
 =?utf-8?B?M0pxQ21ndUdqUnNHM1lTNDQydGoyYnM3d0tXV214OVBpbGxlbFNJa2V1eUta?=
 =?utf-8?B?Yko4Wmh3Vmd4aVVGSW5vQTJrRE9IQWdHNlJDYmhUR3VlM25jZ2gxNHNBdmRH?=
 =?utf-8?B?eHAzWk0xSjBiYzJxZGYxdGtsdmFaK2RNMk84S3ZUbXZqaGRXVTRZeFh0VGhN?=
 =?utf-8?B?ckZpc1N5azFZSVkwSWtDS09VdlVLRmRHQm41cHRISllMOXBXUE94eFlRc2tD?=
 =?utf-8?B?VEpBOHZOVDBqeXViZ2FIdVpkSENYRE1JZ0pSNXJvM1pZeTlPbE5keUk0U0Fw?=
 =?utf-8?B?TFZ6VUxkQlNvL1g4anNKZGxJMWNzbEh5T0JjNG9PRmlmZVlVVXNTdHBCWFFB?=
 =?utf-8?B?c1BuZzBkQ08zenJ3SXZFbDJzOTY5a3VZN2p4bHgweFY5MlIrWURmRVB0Tzgw?=
 =?utf-8?B?UEhPYmd0WEcySGg3R01WTlpURUNFWWJ0OGxMNnFIWHQyNThEUThPT3Rod0JO?=
 =?utf-8?B?REZCRU9TUklLRUVKSHVNbUZQc3V2bi8wUmtJL2xTZFhaN2h4c0poUVV3U1Bw?=
 =?utf-8?B?M3lZaGthQTFMcHFQY01PU1B4MnlqeTVpSS9qbTFycmMxRThVcTNXbVpMNnQy?=
 =?utf-8?B?MzBLQ3o4K3hJd3MrVHJ5ZFBubEtjK2IxLzB0M3N2NUtvRnlGdXczZDJEaUIr?=
 =?utf-8?B?L240L2FrZlJCSTZqMFBLZGtKenI1YUlPSnRBV2NEZjlQWUlyL0ZnZFZkdldw?=
 =?utf-8?B?eXIrU2RqRDgyS0UxbVRYemFHN2VsQXFQWlZjZVhTellGVEovdERaazZsK0xa?=
 =?utf-8?B?L3JnSFEwalM4YjVROTVLUE5PdHdIVjl5M0hRaWF2M1lGZzdrUFV2d24rdU4r?=
 =?utf-8?B?MFVyQTBCaGdHN3dOTVlMaUpPOHRqU1lDbmF6TlZxSzE5UU9HZVdGZllyYXcw?=
 =?utf-8?B?VXVnRS90OGhFVXRrZUN1OWkrbHJjYW00OUpDWFIxQkxkWW1ndFl1UVZ0L2tF?=
 =?utf-8?B?MzhhUDRUemNuMGkrZFB5eFlJd3FHWE5nOVBJdDdzUmJJcDQ5eXRaeHd4aG8y?=
 =?utf-8?B?eHRuOE5BY0hQZUVKTTR5MDhUYkFlOWhiRVF5bzdWV3pEanRUVlFpYkhrL2VD?=
 =?utf-8?B?bnhvbHZ5WG5YZldoMUl4bGJUUDNteTQ1SFF5N1oraDhidklJdVU3M1JEY3dU?=
 =?utf-8?B?a09oUE9pczhZQ2ZjaXJBQ0pyc3dKeTBQeXhjVkxyRUFuSWU5OVJyT0V0d3Zw?=
 =?utf-8?B?R0x1UDNVUEdUTXZlbGZGL3hxNHJtS2UxOE95UjlaWnZnZkhLMkR3YWVNNEor?=
 =?utf-8?B?cDJ5YnFBRUFUUE0wa2dqUk00ZzVvREtQeHRZWW9Ub1ZYK1FEaWJxb2ZMTE03?=
 =?utf-8?B?cEhGNXZudklUWW0wRytHN0VEakk2OGNDYWdLNHVNWEhROGxGOFZ5Q0pIeWVD?=
 =?utf-8?B?QWRUakVWaExYdWE3Uy9XRmk3Sml4c1J5MHA0K2NaYktBbER5ZWYvYTZMN3F2?=
 =?utf-8?B?UGNVbHFWK1RzL1JsSTdoSkZ5YTNPYXhMSTczcUxQcEJTNkNxVnhiYndDeDlB?=
 =?utf-8?B?MUQrc1c5c0hMNUgwZHVlMDBaZUJzaDRHeUkyNFR3b0hEcERxS2IzbzI1ZVY3?=
 =?utf-8?B?WDcvQWVPbzhoN1M3TnhzZVdpOHcxbkNyQ2RFREtnWkgwUjVlU012ejFGYmR5?=
 =?utf-8?B?TGFONGNrZHY2RjlxVUxnSklMK3JVQ20xSWxxUlgyK01VcThoYnRoeDhVdk5r?=
 =?utf-8?B?UXdubXkzeGFoVFd1QWhzbDFLKzNTdlVUZU9DWklEMGJDcVVNVmR5cEJTS1pq?=
 =?utf-8?B?aE5NT05hRUdUczJHeUtDUUI1U1R6WjlRdVg2elhkYis1MHpsTGtOdzR3ZVI2?=
 =?utf-8?B?WUhmdzArcGplbVRBTW9QVy9zTjRIRzMrTEFFMlpFZmZ5dlRCVGRoUXBVL0ZR?=
 =?utf-8?B?QmxUUjJHWUw2bm1UMnoxekxkWW9OZHI5Nm1hMzNndjduS3ZiaUpZYjVhWFlM?=
 =?utf-8?B?c3diL0lnT2RKZnhxMW0ra1RCeklxMVBSNXYyM2tDNkRaZXhPRFd5eUN2QW9r?=
 =?utf-8?B?UVlyN0Y3OXlVRGZ0MHF6NzhLNjRkK0NoMk12czNZYnFBaGJ0R3RBOU9vQnpQ?=
 =?utf-8?B?TmdtOGIxU21Nd2tyL2xLUi93dzhaN0tQMFZiaTR0Z0pWS0s0N0pJdWhjTjFI?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c3af0130-8ea1-4106-8205-08dac6dc43fc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 07:37:36.3323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tR4d29R+w+HOSID9VpahhKL4H1Uheb/PGcrZJmBC12D7lIUD3n1GyWE14VSgdZAE3NcrFwWXSTQ63r6O9bKoGAsikxGfxEIgjxzAaIjm5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9572
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation file for TI TMAG5273.

Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
---
 .../iio/magnetometer/ti,tmag5273.yaml         | 72 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
new file mode 100644
index 000000000000..2f5b0a4d2f40
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ti,tmag5273.yaml
@@ -0,0 +1,72 @@
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
+  $nodename:
+    pattern: '^magnetometer@[0-9a-f]+$'
+
+  compatible:
+    const: ti,tmag5273
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  ti,angle-enable:
+    description:
+      Enables angle measurement in the selected plane.
+      0 = OFF
+      1 = X-Y (default)
+      2 = Y-Z
+      3 = X-Z
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+
+  vcc-supply:
+    description:
+      A regulator providing 1.7 V to 3.6 V supply voltage on the VCC pin,
+      typically 3.3 V.
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c-0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@35 {
+            compatible = "ti,tmag5273";
+            reg = <0x35>;
+            #io-channel-cells = <1>;
+            ti,angle-enable = <3>;
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

