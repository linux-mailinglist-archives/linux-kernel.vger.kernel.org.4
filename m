Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CEA70DCD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjEWMoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjEWMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:44:22 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE867109;
        Tue, 23 May 2023 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWBXE5eXsn4c22lXOUjfAhAKgi3sYvoXID+aypHVB2I=;
 b=hiogkd1Lrm13wFBbVDMSASiS81KDUZJbsz+TqA+1gDcmKqJkmyR5GSYOJqe1oCvOGPqW08qnVhegX9Tp3kDWUhP/Cu4k2fnS4hdba+7HI4xQGcV3K3mV+aBnFQ4RvziH9TnUv7ZTW1yrHVJeeyi0Bb/qrKa0SFgzl0mw8Jc5Qd9x2qyoAp/QLVRSY8O4Il1QNBQ6mxvp4E1m9hVu2lJLbOLUuePgNlWb3fxi2GS6vuq4ZooD+3wbzF2akvbyDZaqVzcYqv3Rcr0FqRduTU7UOKOX3DTmq2r1SmqwPyur/yXUiiJD3tiSmH0i0D0V51Jk7Wq/HDCWxdPIsJ5AbneKEg==
Received: from FR0P281CA0210.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:ad::14)
 by GVXPR04MB9830.eurprd04.prod.outlook.com (2603:10a6:150:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 12:44:08 +0000
Received: from VE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:ad:cafe::a4) by FR0P281CA0210.outlook.office365.com
 (2603:10a6:d10:ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.13 via Frontend
 Transport; Tue, 23 May 2023 12:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT025.mail.protection.outlook.com (10.152.2.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.14 via Frontend Transport; Tue, 23 May 2023 12:44:07 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.173) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 23 May 2023 12:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqjc1W93Qq8f8J/G42HTrH0dQmPnZWkWUm8LsZs7Di7zq60PVuLb2OT/OScXKs7RssUduvFy0sIZtCzGm4UY/8vL9POywx1GEttHPQR1uuZrrWH5RN2XLvPXeB3YP4/xLOM7dcyx546qoFa23CQwm5Us32zSXv+3ZJf0pO/w8zE2D4j+5TkFxz0S1kreRjVAcz3WySPD5xqPWUQaUj/JeK9MDPbYmB24XFwtzfSIDjQjM6lWmeWvoVo1eKKy3JGp5a0Gx0E8TQ3/XKDtG52cOa8caz9Dob+3Win7WUdLTp10CZQvnfibdKHfuA8Bkbj3+0LSubLFfcKXt6wrLPyl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLN9hm+TWL+hJ3jn9NhOtyBlAFlIf5R5oAH1YODsA4A=;
 b=AxZ5ftyk997Pa5iO2LwxLrOOzAPEUkGMH8/A0oejhFwxcN5anyMnBuuQu8WX60ulzwuJaxzXE0FMw+69U6qvlvlzIVpQpuqoRHarGXXbal1nSrJLCNHiAV/k7euxJCNRpT/blxnBS3pnROyxfFifI5AzEWC7C6ukZxWKpBDEV1Z5YGMblD3gurYmgHsMPncKSBzd1txFjDxYeBsh2dLMR4gZeKpHhr+gMCIlcgbhjsUzbL8HoI4z6ozW3yhmdBnmRvSrTkdULXdAmoUOuUVCK3p6Q9+Xybz1O76fOzO/Qwg+BMKA3fHQ3nXxqnqsdHMzc6d1E6O3m52idn6T78eVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM0PR04MB7172.eurprd04.prod.outlook.com (2603:10a6:208:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 12:44:01 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 12:44:01 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add microchip MCP3561/2/4R devices
Date:   Tue, 23 May 2023 14:43:53 +0200
Message-ID: <20230523124354.24294-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0119.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::24) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM0PR04MB7172:EE_|VE1EUR01FT025:EE_|GVXPR04MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 95675ff1-6b72-4602-54c5-08db5b8b6686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: em7b2e/WuM2Zr1Sh+I5WRyAb5ID21IRgwilS5TimOfllrrdMLSJ5s5U4b9ZXpwEHX1yCRfeRBkf02bqD/E6CiVSkqy28sldePa4IhfuFGtaMCHT9W/o5T1FjWN/98t7Kg6CwYUTD18nPXomfXkwcGM0Z7D3gayUz+gBO/uz9wue8dOkq8WqbF2oE4qFk54BZTvM0tocBxV/+qNjpZUtTi2qu0fs0eQnRQUH6u7QZdnTtJ1KiK0GMksHsne1a7onG9Ha/7HCVsJblhd2o1AvJeN3kDx1fVPX5WVoGLnLiSearPh7FLDURW5XvJgKh1qk4Jdmf1rIySFFSX1nrBCU6L0/rqRkSXHhpQzHndSLA/qW58MWNXavFRPqFMnbCq7Gbkz2PAodxlg7VZyxSh4ekRkFlk2FMJNqJyaW8oGeXdjagTUohH+rq8A13KkEHES66hOCT1AntGXuxEjEgkdf3kXmuXN3KRI4Qq/8hil99puQvb+YAn7b/Bzbwo3Ca5WuaTHHXGAeHi7+OKJ8VF0fHkWTqw6UdKrwd+nqrFLqhFNyJaH9TRvc+jUrKUbZDN2IT666bRxayz/E6TsT+QpvMuZLOC0Yf1EIrhuUzQn0A3/s=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(396003)(366004)(346002)(136003)(451199021)(52116002)(41300700001)(66946007)(66556008)(66476007)(2906002)(186003)(1076003)(44832011)(478600001)(26005)(6486002)(316002)(6666004)(4326008)(966005)(5660300002)(54906003)(6512007)(7416002)(8936002)(8676002)(36756003)(42882007)(2616005)(6506007)(83380400001)(83170400001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7172
X-CodeTwo-MessageID: 71ec28f6-9d44-4220-bfdf-3c1ccc38b7cf.20230523124406@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.5ebab164-53fc-4492-bb76-5cc2d7b3f4f0@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: acaf5fcf-7bba-4a1a-b80f-08db5b8b628d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngAlLyIKBCAwiGdvve/rEm36PKlyt9dpcOMqeMYoqIjtcUxpjfYT58XMvrG/qWA95gEHlkN1gjEU4Phc3zfQWgqIpF3ViTi7p062yPrtvwozioWTwgewUaFR22fmBKevGp2QA9uiVmFlgZIZCvKQssH5b25j/SVuQGSBXmdl6A/HWArpkVbCI/p0NNfuoHRGEP/yn8VRvJrljuEBNwNEXXl7Gqui+9CnVrNwhzMz3ryz/pfmu8xGT9jAubcDJyzvjwwVdHvWzHM2bTCMD4m8ExbfbGQbVN1iu3m/33JC9VulqZfXxpV+36dA3CJhlIpxRAIeZciDT0waN5vneQAqdAGw/wjwPQxfV9fj0Hgvi1SSAnlrKvbpeuGKnQXDrtIpFg70oq5SyoPE/kx08PRga1ReKKdljt4MpCPgSxcBFeLT0R82GChxC3um/cG5RnaJXUuDQZc7iSJDkYs9F8/D6KZySCv30balaJ4tEL9CPDxa8eKhQl7jem6FZeqWDHEdsz7PXVjMKNAR00l+x/PJoTCRNLSD0cqsU0oNACoWEUZgtQ1pwsUQWLHjL1vLrbF6948nL2EsYEh1UrVSTa0hVEQiR4ECTkF1RMgAGRtKnByReIy41Gvj19WA1ZmXt94F/da/hz3yTLgM0b6r/DXQRSOBhyoOHkIiODWShfkg7fhwXfTdXa5fBsRI3G4b4qgp
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39840400004)(451199021)(46966006)(36840700001)(2616005)(336012)(47076005)(6486002)(186003)(83380400001)(42882007)(2906002)(36860700001)(4326008)(70586007)(41300700001)(70206006)(316002)(6666004)(54906003)(478600001)(44832011)(5660300002)(26005)(1076003)(6512007)(6506007)(966005)(7416002)(8676002)(8936002)(40480700001)(82310400005)(7596003)(356005)(83170400001)(7636003)(36756003)(15974865002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 12:44:07.8593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95675ff1-6b72-4602-54c5-08db5b8b6686
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9830
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MCP3564R is a 24-bit ADC with 8 multiplexed inputs. The MCP3561R is
the same device with 2 inputs, the MCP3562R has 4 inputs. The device
contains one ADC and a multiplexer to select the inputs to the ADC.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 .../bindings/iio/adc/microchip,mcp356xr.yaml  | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp=
356xr.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp356xr.y=
aml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp356xr.yaml
new file mode 100644
index 000000000000..4aef166894c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp356xr.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+# Copyright 2023 Topic Embedded Systems
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,mcp356xr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP3561R/MCP3562R/MCP3564R ADC
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: |
+  Bindings for the Microchip MCP356xR 8-channel ADC devices. Datasheet and=
 info
+  can be found at: https://www.microchip.com/en-us/product/MCP3564R
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp3561r
+      - microchip,mcp3562r
+      - microchip,mcp3564r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  clocks:
+    description:
+      Phandle and clock identifier for external sampling clock.
+      If not specified, the internal crystal oscillator will be used.
+    maxItems: 1
+
+  interrupts:
+    description: IRQ line of the ADC
+    maxItems: 1
+
+  drive-open-drain:
+    description:
+      Whether to drive the IRQ signal as push-pull (default) or open-drain=
. Note
+      that the device requires this pin to become "high", otherwise it wil=
l stop
+      converting.
+    type: boolean
+
+  microchip,device-addr:
+    description: Device address when multiple chips are present on the sam=
e bus.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 1
+
+  vref-supply:
+    description:
+      Phandle to the external reference voltage supply.
+      If not specified, the internal voltage reference (2.4V) will be used=
.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      adc@0 {
+        compatible =3D "microchip,mcp3564r";
+        reg =3D <0>;
+        interrupt-parent =3D <&gpio5>;
+        interrupts =3D <15 2>;
+        spi-max-frequency =3D <20000000>;
+        microchip,device-addr =3D <1>;
+        vref-supply =3D <&vref_reg>;
+        clocks =3D <&xtal>;
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
