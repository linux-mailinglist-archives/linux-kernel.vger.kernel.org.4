Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3799C70B6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjEVHq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjEVHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:46:35 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B45C5;
        Mon, 22 May 2023 00:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZE5TMcYFNg7zTYdK5PEtlmXKx8JmDZy7NJlDHLaTfw=;
 b=ERUix8rMJngh0t+DKCCZuTEoU3WeYZBWN9rPm6SmUjm25PLwM3S/mfKfjGfFP64IU5NILRSi2WDchs306U1WvCzDOTm6oeS/kKQQP1I29R4cc8jqVKRMXheVQC5C6pSKoRyAEVoEMLY9KIHt81mShoRhUjO2gPlDoVOlu/U9QMqx+Z0JfWTE6OSTYKzb6dgo05F7BlpEVsAlHZWGEPZEzxN0gAVsSjS5QhA5/YZuTTkaCUQF1Slv4aK52fmv/VCCABO07GH2A67HKPtJZ0MKYkIUWNpwkBc6bBwXoUC8GpN6gsYNmWT+SS7O8YMLcTgr2ug2rsGlK/ppshFrWO+G8w==
Received: from OS6P279CA0058.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:31::15)
 by DUZPR04MB9848.eurprd04.prod.outlook.com (2603:10a6:10:4dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 07:45:24 +0000
Received: from HE1EUR01FT074.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:31:cafe::36) by OS6P279CA0058.outlook.office365.com
 (2603:10a6:e10:31::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 07:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 HE1EUR01FT074.mail.protection.outlook.com (10.152.1.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.13 via Frontend Transport; Mon, 22 May 2023 07:45:22 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.169) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 22 May 2023 07:45:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGHCRCH+kLVzGh1Hts1LHN/5W79bC4IYcxAduVDpeQugGETwdpyMnPWSOqb7AeKH23A3cWoGBepKqQawhZJTSW56GqRIsY4Z+ujAcCPWivNx3ovVu7ElpqfLU+HOZX39MHPY05XuqyHVPrheDwEH42u/umSfvrSlc6AVeY/EyU+9M8FdXQTK4WiHfmTj2BGbIkF3wNtA8kGxAR2WSZ/q8B7Zcg7TVlGDTzgwYZHwTTUogeQJcA8zsTmPXkMFbRdr9i4AMfOvde80rkHoa25o46j8U1Np3nHdsoaT5x08GaH89KFPvlsxskgEXYmzBX/kakmMxnn3WCyekhTZdTLUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UymX+TrnVnU9DYP2Yagvw/X0G3lwcwREG6IhNGnbCA=;
 b=lTsXQkBK4IMAsd6qQUcTnYBqtMaubqcHFyyNzeTV16BAlDGXhsxGt33p4V0SoN72Xb83V5088To/ms34Edk4f/Oz2ybVofiLQ/GA72PpmrBlYblxkN7rOJO+jpWWYgUZenIgjMxaV401vcfrMyT6qb1amVKX09AiPL3/F53QQx3KibRWfeDmwD7BV6Ll2jGCVYXNyK4gpExpRFOwpW0dMatWAOp5JQSd1B1Ejw5JnV61GPnGMN7rEqpQD0L/QKUHLRLlEA9/jxCTGvjM42j/AWAElEL1Nbgeg+OlBAtyd4joy/1Us/z2gtVBK4a0wUWP2ou+CRtZWNLSW2wbhWfbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 07:45:17 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 07:45:17 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: usb: Add microchip USB5807 HUB
Date:   Mon, 22 May 2023 09:45:09 +0200
Message-ID: <20230522074510.16367-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0118.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::23) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|DB9PR04MB9626:EE_|HE1EUR01FT074:EE_|DUZPR04MB9848:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fcbe29-22d6-4272-580a-08db5a988040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: liUOlVoAy9eFPBrp0J0zuID6Qw4YwlKLWksH/175w6ZqjEQRF0kAT+DX7gLiZ9RqApPhfBPSiAUgZfA/Kjx1oB+YlAq+1Mq92VI9RTQZ5+/Rqw1rcKMOHpECksxwkNf+/1OBtc1icfVw3U0fyN2AxV6ixP7GhJhfWwc1sNKv3LsJaBhserBrzVYePOGLYuPUEoOqTvH9iJpoqXLYZn/L6pFMBKzbqe1V87ry2IfS1U2H1MvTCY6lqill5WBXwZpzs3AormdUpuuWKnWv0Qr99JUDW+VFcs6chYtaM5e66hXAWslTS6sNTaxmKDpYaE8jgpC6aPv3IqSgbmfNG/mN0f8pMqcL2jw8qahstKZP6TxNcYYlEpsTzcm9gY99E0+nDWnIY6dCcob2V37ewNW2f+lro6o5yn9P7M4amQITwY8NQasRuSlxB38Nn8PXjDRhAbFpLJjRETehBygtEUjEg2jWUTur6yuQnXzlm4sgUW7u07L0mAguyCD/vazCDlKpxVXXLZKiXwD6iT8vCG5IRz2hJ/LPnJwC4FR+t2Kj3OoXvmuur0LK78b3odHhKRTXVjZEE9yfnyV7VIjgyRG1GwE70PudQLqE2YwoUnmzXwM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39840400004)(396003)(346002)(451199021)(83170400001)(38350700002)(38100700002)(36756003)(44832011)(6512007)(6506007)(1076003)(8936002)(8676002)(42882007)(2616005)(2906002)(54906003)(478600001)(186003)(316002)(4326008)(26005)(41300700001)(5660300002)(66476007)(6666004)(6486002)(966005)(52116002)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9626
X-CodeTwo-MessageID: 14021261-a616-414b-9a72-3ce360b2298e.20230522074521@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.656f2a13-85bf-42a3-8490-f97f2538d8c3@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT074.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b9f7fe40-4b5d-4c41-bbaf-08db5a987c2c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /d23Jea/N9zhT2qnSAU1td8arnhslNPyAxsTHfBAattyMXyySw1dwsA0jAlwLIehwlC/6DIeQv7D01a2+FdtDZxYr5nW1ms4yAsPsDYO52OfUhdHPTNXAOZYr8irKLCG4MRixMyiwyQJ9mtvPzaZL3VxFOwhMOZcNjSohckvwRRNRK/4JcmnEsbrRoDj5BB6iXfmyfjNQy36RwcKoPS1OIbSnHSHPirEJpYBow7icakmAZNwirl/Zy+w1B8j4qG9C0wPX0pPnhQX2mx1TVtZZ1ODd9qrZbVj+yeVDbwPYigP0aBuBMoWO5/yQxf0PGzhfIb5Ki6stIPj/CWL+x5J1wH6FZ2sPI7WCO6ch8ocCzjGZBVHozsZCM8XDSekxW6ebh6Ewqsw/D40bW4ttdkQEqhKiHMa3CPyIdrd172TrcVS8XY5iA0aTX5p1xHNr9NZQSwTgVaPw8wGJDuSemOoS8Hivj8L3E8ni/ltzqv3qfnfPESQqk5auLImlZh96JQWY8e9Tda/dojkVCUILk6GWlgcWp176VXF+qVsAPF1qARhpMc/VtuRw0z5kgGHt7MgoMnB5+imFmvPBVZv5Q3HeFQ37mfnXCVivxM22y6RsoO8agUrl90STfE6iojbk9ACZuQShw4zEcITvuyWatEkQzrFsyqwdlnpqNfhIIwJ9qoFBRUiXTg1IIq531/SZGJF
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39840400004)(451199021)(46966006)(36840700001)(478600001)(186003)(54906003)(5660300002)(41300700001)(26005)(6666004)(966005)(6486002)(316002)(4326008)(44832011)(6512007)(1076003)(6506007)(336012)(8936002)(8676002)(2906002)(47076005)(42882007)(2616005)(36860700001)(70206006)(70586007)(83170400001)(356005)(7636003)(7596003)(36756003)(82310400005)(40480700001)(15974865002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 07:45:22.8575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fcbe29-22d6-4272-580a-08db5a988040
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT074.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9848
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB5807 is a 7-port USB 3.1 hub that can be configured by I2C.
This driver resets the chip, optionally allows D+/D- lines to be
swapped in the devicetree config, and then sends an ATTACH command to
put the device in operational mode.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v3:
Add minItems

Changes in v2:
Rename to microchip,usb5807.yaml
Remove reset-gpios description
Add maxItems
Add vddXX-supply properties

 .../bindings/usb/microchip,usb5807.yaml       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5807=
.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5807.yaml b=
/Documentation/devicetree/bindings/usb/microchip,usb5807.yaml
new file mode 100644
index 000000000000..0a92b2f9802e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,usb5807.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/microchip,usb5807.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip USB 3.1 SuperSpeed Hub Controller
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+properties:
+  compatible:
+    enum:
+      - microchip,usb5807
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vdd12-supply:
+    description: core power supply (1.2V)
+
+  vdd33-supply:
+    description: main power supply (3.3V)
+
+  swap-dx-lanes:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+    description:
+      Specifies the ports which will swap the differential-pair (D+/D-),
+      default is not-swapped.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      usb-hub@2d {
+        compatible =3D "microchip,usb5807";
+        reg =3D <0x2d>;
+        reset-gpios =3D <&gpio1 4 GPIO_ACTIVE_LOW>;
+        /* Swapped D+/D- on port 0 */
+        swap-dx-lanes =3D <0>;
+      };
+    };
--=20
2.17.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
