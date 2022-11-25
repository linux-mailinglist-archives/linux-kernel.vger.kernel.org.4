Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1997963854E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiKYIf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKYIfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:35:48 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8676B2D77C;
        Fri, 25 Nov 2022 00:35:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJV30xGDWtj5C5lAYoxG7xUxxSZOA/ot9FUCNiCeIxRjrKVNFYhKTImtyK+M7Ljw2ICrDFm+U/MRLTOXjVxL3vEIcF/l/EUVRWuXuuc0SFtXI36mlZd9PBIftHzHVTjw/qF6gxJAYsIKvEeQNmqUVVmDJmvHpbfIB01iJswi4iMEWzxcZ0v5xu8hUkEqr2CArZ1G0yEpXn3oaIrisB8UwEndr0anYTAVqBUC7HBTrYtZqMy3tQoepRxGi3aVCBWKBZhgbxi/MKRz/zHQq7CdWjPJ5q6FK8Z1z5DE1K0VQmhIXllKJZQq/SBXl5FAnT8tS/HtD4Y6F1bC0YZXeB8E2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxxbkWH4Ok5gqDUM9+y8AQPJClOqYYBnY5ZEuEZRr7k=;
 b=fjw99r0j1g9NSg2lkXIKiJ3ywG0vfe5kWLYcQCRTv/lY4dEo7rzKSv7uj8maHm2OxmbQKIi/WNn3VLqmm5AZLvIk3rPcFSmjNV3RklcpsjEju8A/sMz11dUeG1d90PG8rZeseJ41Apwf13TYqFJ+kVBbxfbm80osO1ayM9K2FnuBZ4JyXqwq2g0xHnvcASm8uZwmrUI1Sw4kFe5TAUje9OPa1hq3FeGTNyYugjcpixVUCbMFjfzB4JUkBEc7lgoINiXI4HHxVa0XVS/vIjE6CRE3+tB6V3edlulhIKmKFVTc16MzMgY5VVws3UbReDQPs7o+wF00DJW4z9PcP68DlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxxbkWH4Ok5gqDUM9+y8AQPJClOqYYBnY5ZEuEZRr7k=;
 b=0ACDM9LwCJhrX9z0x0Jl3+hkrZPf8+6K3PiKv0WDYGatYtsP2ihfL5ZG6U+ZSwx5aWcM3uaaUKbTf24ckLf4kEf/knzGElJ4YX94xF91H5erh+dKdsOdtNUvQVLI5XEpLJoG6SoQApABA/nsyMZ2edlYfgum+mGqW8LK4ilhHvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by PAXPR08MB6751.eurprd08.prod.outlook.com (2603:10a6:102:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.5; Fri, 25 Nov
 2022 08:35:44 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 08:35:44 +0000
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
Subject: [PATCH v3 2/3] dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
Date:   Fri, 25 Nov 2022 09:35:25 +0100
Message-Id: <20221125083526.2422900-3-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
References: <20221125083526.2422900-1-gerald.loacker@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0501CA0011.eurprd05.prod.outlook.com
 (2603:10a6:800:92::21) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|PAXPR08MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbdecfa-1922-4a2f-f902-08dacec00b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+O084nUOvlBqQ2JAfCmXSqb+sSC7il8/zCRDJkMHBq4QjTJSp6rLHZGpjqftVm3GoPNwyJJXxLAl/1E+ol15Z6s619gp646Oq46RaC504KlwLF4G4aapUtLL1Uo0Y5PM7CWK/rldCoudBO9caCmorVkbSBjSzELt+C0zX5kEQ9aztpIoP8MLmRM93AHR9klvmwEQF9+vI2Cpw8O8Juh6kAB5OP8tps2M54Lv5A7/1ik9jpNGgCFUz/Le5gSM8TzF0yLSC+GYxirRa8DyrBf1UFaWM5OjVWaPgb22q+MyL+gvTaW61I3P6Cs94IOzJk0nDd4BpWbXp75bArN2UIMXd9vBuR0HLzsmE4Cye1nrJ25K7NwZL3Bpy/pkYG7kytaM7KCGVl8RuHzp+MW34K8r9Y7OIy3v/alSHU4NeORKWGYkKh3R8qAQi5y+73FswW5VHwao/AJ3q+z4YbLFyEQbhxGchO9T1C90R5GwX5J9hKedO0zwBUOdKwTJK3ZZMxbMv7gNgKf9zBISdf/LaoAvWzZcRduigHaHTyxIF82vUo7/NDnNKw6yY/3rx7+kMmh21Bwnyd38qhMjaGrVlO5vSru6gDR4LrOHaJuNxtFkvI0oGUCEt0dBHZCMoetwqyvDs4b4VcQ8yfxg9tXUZay8wjWzrwMdjaxPEzcdmM5n+MDhKhJ7CjIZc6EXDPoshLKQ9LwYbyT+8ppPYK4bYBZjYMSUEPX/HqTR8nuh0vU1g5/9XyytOL/77RmQXTyNyeT/PHOcOhtvP62w7e+7l112A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39840400004)(451199015)(966005)(478600001)(6486002)(186003)(44832011)(7416002)(41300700001)(2616005)(1076003)(316002)(54906003)(38100700002)(38350700002)(36756003)(6506007)(6666004)(52116002)(26005)(6512007)(86362001)(4326008)(66946007)(66556008)(8676002)(66476007)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHdqaCs0ZWx4ZWRYK1NRK3JoWExTRjJIUjRWMUtqcU1sRENGSHhLdGVybVZV?=
 =?utf-8?B?aEIrK0FiNm0yVkI1OTBmRm1hZHQyUE50TThHOUp3MGpWVzIyYUlzT2cvL3VV?=
 =?utf-8?B?aW15cW00dXlaWVoxWXJEWE51K0xMeldqQld6WEYvc2VKbmJmMEFHNkFYTk04?=
 =?utf-8?B?Z3BaaCtjTnljdysvWk5Ub3czMWJSUExlS3oxMXVzYUoyMHNNYnJpbVV6eExI?=
 =?utf-8?B?YnhjNDZmNmxKV1FtMzBDeTdTSWJLVE5aNjNWMmtGZ0laQ2wyelBWQW5jOExQ?=
 =?utf-8?B?dDFMc1RCVXZ4ZmE5MmtOVTN2V2FCd3BWbnZxVWxXeXZkUEVQUGxlRUR5UTd5?=
 =?utf-8?B?Q0FGak9UdUYzc2lVOFpmQ0M1RmRpUjU2RWFhMVFJeDZNR01JT0ZqaXJmaklG?=
 =?utf-8?B?dWFQSUowd3Z2M3lDSDFNckFKNllVZUVVK0ZJbzN5UE94QisrOUhyREl0bGdD?=
 =?utf-8?B?MTZiT0tGcjQ2YS9lUUJGYUwrd2FuWUxtSTU4akpsSFBHMTZXeU0vbVc3Rnpo?=
 =?utf-8?B?Zk1yNXNuWDl0UHlnNURRMTArQzRVaTVlaHlUYVkrM3RPUE1LVFhDQ0xGcG50?=
 =?utf-8?B?bVhXbFVjd0FWYlB3ckxZVWpxajI4UzR6L2RxbURBbURaOUpaS3hoa0liQ3pN?=
 =?utf-8?B?UGVZL1NoMkRoZWlLUk9HcllKNlNoYXUvejlLd0pRVHFUN0ZtMlVXWUlPM1FD?=
 =?utf-8?B?UDQrOWlWcGY3cWxoTzFRMGxuN2FHL0NtQ29SU3dMZFNPZ05KUzVYYlh0MHlU?=
 =?utf-8?B?azhrc29HTnFnM2pOSjEybUYyOFBzZE9Uektya3h1TnNkRWhzNGIwOENMTGFC?=
 =?utf-8?B?eVhRZGNHdU9qQ2tWUDAwYmdJdUhsa3kyaVBRZXBpQzIwNGJlSlBaeUhSeElV?=
 =?utf-8?B?bmV2YllYTHNjd0ZqSDR4elRlSFVYRDF4alkzUklBVVdvTFZsS0tkcGxpajFD?=
 =?utf-8?B?Ni9CWlJwZWgraEVsc2d3N084ZjNlZkxBQ0xIamJkRnpDdkpPZ09xMElYeSs5?=
 =?utf-8?B?bWJFcjcrcUtxSG43aTFmUmVueHJocEp5b3F3QU1wT0NTNXRFVW9yanUxWWpo?=
 =?utf-8?B?MHppVG4yOUh4eXNNQTVZZld2Q1RVb2wrRDN0d0lRdGgvTkpLWTlrRmxnak00?=
 =?utf-8?B?R0F3R05RcnZwS0llbE9hNlNmVWNMTFE4YzZwelhQdjRVSjZVajBRL1hGTWhm?=
 =?utf-8?B?blFnOHgvZjI3S0hpMDhDNHNDZ1BmMEltVnBHT1NVc0wxOEJzbVVNdWU3ekxR?=
 =?utf-8?B?WXBGUU1RaUhTejBxSWJTY3RPVGhjUitTU3JNOVlqNzQxbUNTOTRKaHI3MXZ6?=
 =?utf-8?B?b3FBblo2SEVnc25tSDFJVWFrb3pvd0ZySTBFZzBIbC9jRnFZdVJtV29tWG14?=
 =?utf-8?B?eTladFN4TzZGT0wzTVk4OHd2cFVMVHFIYzY1WTZQai9xcGxSOW1yUzhxMVFI?=
 =?utf-8?B?a0cvWXUzb3l3b3FVVFBOSXNYZ2l6c0Vpenc2YzZRWXdTQ08wVmZyUFFLTFdB?=
 =?utf-8?B?akRIVU1yV09yQ3BqVEJGS2V2UHVKeUVLclloemU0UUVVUmplMjFQWFF2N1o5?=
 =?utf-8?B?eVNsc3I2b0d4a1FQbHVsQlNBbzZrVkdLZ1dWaGg0bmFzR2x2RlZQRVp4ckc3?=
 =?utf-8?B?MVNUTnVBT3dYb3piZEtEdEJxVHlwWm0xZzlGR3A2WDR4ZjBKSlpEVE5aQzZU?=
 =?utf-8?B?ekRWVktmVjdraVJXcGdua3d4SFBQNTdGeW91T3p2NWdMcTlaZ1h0THFRUG9C?=
 =?utf-8?B?TldyaUIyV0FYbEhsZGJyWDZTNk93Z3B3aG1yMSs3bGl0bVI4VUk3VFl3Zmta?=
 =?utf-8?B?OTQzWllOS0FoZXdrbWI2dkVUZEVsYW0xV2tjZFoxQlpNbmxLdXJXbjZOdEt6?=
 =?utf-8?B?UGUyVWlrdTFYdFdlVU1xeU1pY2JLUDZSWEU5WWtGUTNXeUt5NEVvQlQ3cUVQ?=
 =?utf-8?B?NjJNd29GTmViQWZENUV4SldZR3dwOG05MElZYVVBVG9xb3VXck5WQnZJMHU5?=
 =?utf-8?B?a3c5aFdHWFAwOFFWSmxUb2ZRRVV5MmhmSHRJYzcyM2Y5bkdwT1U5YWU5YXRL?=
 =?utf-8?B?aysrcktSM3pWMHp1bUt4eTJPTHhLUUREK2JUOFFBbjVRMmQwUnc0eEd2cVg5?=
 =?utf-8?B?b1Rxc2lIS2MyNnFkbFlKRE5NOGw0YUQyQ09LWEgxZENqK1BZZENlSWNPYzc2?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbdecfa-1922-4a2f-f902-08dacec00b0e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 08:35:44.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHdo4Iui7mYRdyB0ULvSMwHdiHyqP8WgUDX7e4pe1V9FoGEIhtOqsUo/d0+nD9O1Cv1KP4cY8j1Zz64JePUTiE5w9DUd60P1yzqCw7JB0Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6751
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

