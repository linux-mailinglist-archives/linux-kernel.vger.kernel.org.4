Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6A67127FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbjEZOFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243316AbjEZOFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:05:33 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04497187;
        Fri, 26 May 2023 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FzRiN17e/yyNKqv7h0raOzxRiZ8kyVQ7ynlXUHT0Rg=;
 b=rLmB5/rQzTciIrM/pikOEv3KDV4c4hesdnskL6WoBpTrML5XslkbKOrevkXYT1/9ziSvUr2XLasww33PGdC7IXR9ZTeRUl2Hgo9apywAfCXRI5gSZ1e75miAazsXmgmvlTeErKO7WQ23mQblkzVpYNY09/DrOJ380pxlYgcYyGfwiNgxh8ETHsOJyBMhZSr4ud9GTpgicMaSTt4nme5e4j0wcdf/ZUd7l+cay8+BC+/ejoRWxDEJeCfvEbuteJmIpuK9Xa4EqCVO9/4kipWpD+gEzah51Jj4a3/c7WBHBBFvYDyASaQ4cyoM6v3dGPj15bqqJ+965yK27iRXn4S4nA==
Received: from AS8PR04CA0162.eurprd04.prod.outlook.com (2603:10a6:20b:331::17)
 by AM9PR04MB8939.eurprd04.prod.outlook.com (2603:10a6:20b:40a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 14:05:25 +0000
Received: from VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:331:cafe::a3) by AS8PR04CA0162.outlook.office365.com
 (2603:10a6:20b:331::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18 via Frontend
 Transport; Fri, 26 May 2023 14:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT043.mail.protection.outlook.com (10.152.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.19 via Frontend Transport; Fri, 26 May 2023 14:05:24 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.58) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 26 May 2023 14:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b40lB53g8U18aT42pFwVfMmyvIGsh9Pzgwl3GAKZbcxWusQ/yAT/jxy4MpYkCyW7eCChplBYI4Nbs9xB6hkhHkKhDw12p9piri2naRjEO6Zr0gfH7tC0sYkld10GXQd3qHMFeKZkGtCKHDFzllFLmbpgVbGadnQ1IQ0arqAdcvldV+R0reSISGYPkBHOHonIamENCFbqUMaiaXuy6XaGSzE2zbgtbEMb8s81P2AXzrPlq41bff8feooiHI506hi3cf0Y+6l5oRaVmKKHokhjz9vfyDHyQ+d8BI1hO8pNP8IE4NDdh90paMBEDD+KOe/aKHGJNmouJARw1vnAC8/NQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbcKYv81bcUZD7GzGosrlKa7ij0ybxG4Mnxgfuw6I7U=;
 b=HdkQ0K3GiUhFryhQluUF3AEbW0E5htFwVCbFf2VLc2PSVyXQG0iTPH4uwmH9osVa+RtlwwKMa0gBgAoEATofhh9q33uiH0UuPXVPiHEZ/QQZcHVb/17Hg1Wwm+HWFwVWDqxg1GzGg+FWlSKFNg7HDpQ+PcHdWuYLEOSklCrq/iL+Wap3FPTyLIQ5Pm8BY8cLKm6yaoAWe751IFUi777AT6YiguUx2cgCHKlKKT2Y7TYBQaPCXtfxiR0/b+CCR2dnNVzrQPqXXkRmhXjEeQw+Iv1Q9yLAxuGGZAugCJYegZ46K83RFXAyBB11Xcjiaaqfls5DV9aY7fwjvScPyWlPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 14:05:19 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 14:05:19 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: clock: Add nvmem-clock
Date:   Fri, 26 May 2023 16:05:12 +0200
Message-ID: <20230526140513.6943-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::16) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PAXPR04MB9105:EE_|VE1EUR01FT043:EE_|AM9PR04MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8e2224-38ab-4347-b977-08db5df240a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rCjsyc5mj8dPICdp4AfFFL5xhE/7RNV/a1hrgIm26Orp3pVcpXIiD8QTu0shaqiDdnsqtDUYabjJgh+TbWOGLM0u+zt97+bjs7oMI/J4dqquQ6dX3hVA/i2ceQotdsKscyxUTsYU3ayw1wBrTUSAcef6awj8/q3TmOsbFYhjft8J4G/KMttshhIoMUEgDutlModBPR0nUsoCADhWMHO3L9I7B1yCW5HUCJq9E2EGFUukrxngxM0z7Luwce/vu0DvNg/pXH0j7JtFzrVRG4ZTOMAvJ+hfilvtqr0ak7cBh92lwUHz8PXaSJsLMwZWz/NPlOY4BnBMVemS1F2f3KC6mckH5U4nWkgB2aHmsGvhx4U1Vu4PFSYIMEyn3KukheBZKAx1IkTfHhlHGJeMb2fe5tdnQJVWO1F/MGO27sCHJN2VmvMWQrHQE+da5vbDYe3DxfsaRRTj66xfHbHSmzBscJ2bpn/DbbfZvFqt4nYdujEaCCCAR7sNhuA0KMAloPWTxQ7RuK6VI4WqjprbATTVaLbjReFh8nRKNp4TFz4b5Zt+F1D3uicTNKsNvoDYoKN3DF4MMoJmKm5Sfmc2zya95MQZgnywqxcEXJcANrgWIb8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39840400004)(376002)(136003)(366004)(451199021)(4326008)(36756003)(1076003)(41300700001)(8676002)(8936002)(186003)(6512007)(6506007)(26005)(42882007)(44832011)(2616005)(54906003)(316002)(83380400001)(5660300002)(66556008)(52116002)(6666004)(966005)(66476007)(66946007)(478600001)(83170400001)(38100700002)(38350700002)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105
X-CodeTwo-MessageID: 2c96edfa-320e-4068-99d9-81106d361768.20230526140524@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.4a78ae72-465e-443a-a075-45c4bdc136cb@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1deda913-65f9-4e2f-615a-08db5df23d64
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKlr0U4YaJnX9BJaLnsM4baK222UxdEx8rw7Vsm35QY6y0jrTup0uHTDglukOTJT6hqbrvfTRX7gQXK45cLwLM7CQ3mNMaOjIORvnZTEAgfZ0zt3D5H3PKuqENueHeeM8rf4qhVirhaVLkJeYNqpZ4ebseFR0KCN7omWLItG40XM3UCwanOyb6uZWJb0tCexjIFQz8t1uDxcbSNIcOYZE3LDqKvJJiPM6O30ddM8/mlrs7AdyghZ/mCrMSwETu1KC+bJp/ys9JJO6W1/9XZpngG5QSg9a+C+Bg9RE2X8YOoC3cSnZbSyQuCEzW5wXRJNIN0aUy9iIWXTqi76d9V1LyuTWrMzkj29DfM75Fidktd/7N8a91DQ/mHqGNPl25Doo/E9TM/YsCpjvzvn1MrAU00euTOYVVPQ17WaFyMbv5DctBsn/9xlzqZ36cPt3GPTnYwcEPwtcifnSkEcBilZEJoqPHA2Udn1JGS7+LmB7pAmWkkGNOQ3szglPBftz1gDR8T3Xm7w8pGumqjmuiKK0aqcqcHka7/tHU9zY1Fi56UGTFBcMm4/LUGqMPYxvYUKkIfnT0F3b6vMGRjvy8a+dnNZUUqx2+nmuSp/2S2mOk2nsEuMaOUpImn8bMmki4/LftR9mUZ25aDQzGQCksOp60YAKRdaxHMC7gj3ZZjkfPc1XY1tVft7cL+Sr/ujm9AQBMxN64OoXDoaA5MTnbWKog==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(376002)(136003)(396003)(451199021)(46966006)(36840700001)(5660300002)(54906003)(478600001)(966005)(8676002)(41300700001)(6486002)(6512007)(26005)(1076003)(6506007)(44832011)(316002)(4326008)(6666004)(8936002)(70586007)(70206006)(186003)(2616005)(2906002)(336012)(42882007)(83380400001)(47076005)(7596003)(356005)(7636003)(40480700001)(36860700001)(83170400001)(15974865002)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:05:24.8991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8e2224-38ab-4347-b977-08db5df240a1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8939
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

Add bindings for a fixed-rate clock that retrieves its rate from an
NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
or similar device.

Component shortages lead to boards being shipped with different clock
crystals, based on what was available at the time. The clock frequency
was written to EEPROM at production time. Systems can adapt to a wide
range of input frequencies using the clock framework, but this required
us to patch the devicetree at runtime or use some custom driver. This
provides a more generic solution.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Note this patch causes dt_binding_check errors that I need some help
with. It claims "clock-frequency" is a required property, though I don't
want it to be, and it also doesn't like the nvmem entries, claiming they
should match "pinctrl-[0-9]+". Cannot make sense of the error messages...


 .../bindings/clock/nvmem-clock.yaml           | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nvmem-clock.yam=
l

diff --git a/Documentation/devicetree/bindings/clock/nvmem-clock.yaml b/Doc=
umentation/devicetree/bindings/clock/nvmem-clock.yaml
new file mode 100644
index 000000000000..2e40df150b59
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nvmem-clock.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nvmem-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple fixed-rate clock source from NVMEM
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description:
+  Provides a clock rate from NVMEM. Typical usage is that the factory plac=
es a
+  crystal on the board and writes the rate into an EEPROM or EFUSE. If som=
e math
+  is required, one can add a fixed-factor clock using this clock as input.
+
+properties:
+  compatible:
+    const: nvmem-clock
+
+  "#clock-cells":
+    const: 0
+
+  nvmem-cells:
+    minItems: 1
+    maxItems: 2
+    description:
+      Reads clock-frequency and optionally clock-accuracy from an NVMEM pr=
ovider
+      in binary native integer format. The size of the NVMEM cell can be 1=
, 2, 4
+      or 8 bytes.
+
+  nvmem-cell-names:
+    items:
+      - const: clock-frequency
+      - const: clock-accuracy
+
+  clock-accuracy:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      accuracy of clock in ppb (parts per billion). Alternative for provid=
ing
+      this through nvmem, the nvmem provided value takes precedence.
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    xtal {
+      compatible =3D "fixed-clock";
+      #clock-cells =3D <0>;
+      nvmem-cells =3D <&efuse_xtal_freq>;
+      nvmem-cell-names =3D "clock-frequency";
+    };
+...
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
