Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22B77128A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbjEZOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjEZOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:38:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA1AE6B;
        Fri, 26 May 2023 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/he7sgygZdnV1Lw/xFXJOMp5Zi9JxPiJAl2JxOVDlY=;
 b=oJCTBeATVm5wS7xdL7yibQr1AsieWDe6OhrFV5OCnUo9f/IpbMy4du+uD7TpKAL7aVeXIeNeSACROp0AHfP/5YzI8B1UmutGmGE4Kli94ebUsYzOZg0wfku8ZowLYknUFNlz5MT6H84b9fOlITJQfCkGv973m0HJrWL3xOLh3s2cuiFdRBER2OmyNjXvPcELXkhc7r76w3iKRAedzd1sdqApE0aUn5N/xgCTMdNGzrkqR0NKmvaZXIcvSu3MRroGVB38Ucndkgsdu1Bnlo0dyJdWJcEd9os22fYE1dG4XEd8mZVtgMVhBkY1AafZgZ+KVCmtqHryAm8UYY7AqNZbhg==
Received: from AM5PR0402CA0018.eurprd04.prod.outlook.com
 (2603:10a6:203:90::28) by PAWPR04MB9912.eurprd04.prod.outlook.com
 (2603:10a6:102:387::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 14:38:18 +0000
Received: from VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:90:cafe::82) by AM5PR0402CA0018.outlook.office365.com
 (2603:10a6:203:90::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Fri, 26 May 2023 14:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT059.mail.protection.outlook.com (10.152.3.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.19 via Frontend Transport; Fri, 26 May 2023 14:38:17 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.234) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 26 May 2023 14:38:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDN7Dquc9jMsZWNOgIR6zoAHuKlr0tLcLOh4cM1O6CmVAxYmZzH0fWZ5aaXnuBSoZ264dGc3GX7VkxV2wwXLm6VUVxgRWmKKGlWwnuwNaRCIzJSYK6iwCKXfEncitTEUGnEimJPmg1XSSe7Gzt4oPfkS2z1NpUiWYkmdtnoaqOQfGvbkFgCZKcCyHGXIYrlpo1Nzjqw1VOhnn5GaHukV7jDnL7Bgx9Ig95a05PVub14C5J4G6CegcDxknYu27b1/usHoQJQTpIitt2ONULK0nW+JUMQN1rMSjQgXO7sRm1UgpX9POkF0a3PnDzaFLprtBTDtJ7PRHYQ2cAEogFdoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1beos1yn/KcQmEaFF+exCJ93r5RZ0cwAcZ4iWYSVLl0=;
 b=CB5COtqwonmgnCzDrnG0nSQknOCp2wQ8PJK36QkuTs2JixgSoZSr4jFp+EEzDhyJ5lPFgkeLussEFe7atc1G0oe1aIOtvLlFocUzmHO/uDeWZeAIpuzB7OY7l4D7T5xSEh9w+9MY0dgL8uQhgYCTtFOB6rtpav/8rNpezvWFbBYlAaKP7Z+HvUvG4DLzbAqTuD55/bZISE3cKnmk1YFB1MFC1dBVr1FDBUsMrrsmUCFuC0kOp53mXi7GI/8GL1TebwKgrtf4h25OB3Rq0Hatt6M4Fzvfcglh9EaZeM9yx3zx51+HtCk/SajwJyFgiNlQMxW4MB3qRTCwEEvI4GiAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 14:38:13 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 14:38:13 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: clock: Add nvmem-clock
Date:   Fri, 26 May 2023 16:38:06 +0200
Message-ID: <20230526143807.10164-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0005.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::10) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PA4PR04MB7775:EE_|VE1EUR01FT059:EE_|PAWPR04MB9912:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c71c2da-6e59-42b3-7a63-08db5df6d890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9DEvHyV6lMz+g/ljMYmRDNC67TGI4ONGis9hWxk1eI58nUZXzx+rZs6s7ERmqb7D2Orv0T1kcT07e4BgBiajsI6Yysxy/Mi7EU/HSFvf+1x2HoOBYGb8tlk+ZkZy8cqHjHQoTtwFnTgDyG74hPMJ+QGENsa4bYonL9Kkp22cbWqcZM8msJ+JzWroo2R6hUTRv/4cg+29habmDMXAxHKYTzwBRgvCODmg435KJavmDU4j4uGVkOopxAJO5Bvkt1UBD9nENwZhj3H/ajNKwyJlMug/MMPF2l1nsXblHg705G6peT12XjJHr2FNCp3SI1eg4wRjGRRM/r4MYgfvQDT7/6Y5i1GJoLVoJZ+QnpZheK6J/UXuwGEZwlFcALZoZVFvK7kdjxpT3FN26oLKVdwbyuPVwJujhGEyJZyNKzPp95CewUiRF1hLWHe/dc0iDTixtZfX7kk+km9jxDGFxBEBgKOtd+osvnyW/K2HNyQihmP9uc16nXSJtKle1HaWUFDxZ/fbiRoLqA+3tRQp0wd21o1HPR9BHI6hZtdaZPEMscRQucw1Mfqhgi7ajFIwogGL6XHkAlZNuXuz8yDljm58W42iSDKjZnzQcEHgSGg5bmA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39840400004)(136003)(451199021)(66946007)(66476007)(4326008)(66556008)(316002)(54906003)(478600001)(6486002)(52116002)(41300700001)(83170400001)(6666004)(186003)(966005)(6512007)(6506007)(26005)(8676002)(8936002)(44832011)(83380400001)(2906002)(42882007)(1076003)(38100700002)(2616005)(5660300002)(36756003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775
X-CodeTwo-MessageID: 8ac36df3-fe49-4a92-8277-24c6787e35dd.20230526143816@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2167d5ad-7e99-4eb9-a313-030fc7a7d546@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8d8d022a-4c4f-4246-10a4-08db5df6d5f0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQn8mhWla2EZvXfJUjZ+ykJiMAtB46GBd0dHm4/Q2ESrypRJVZc/+Zb63DvRGKzBm1XzX9IUeSpwj6HBMAlALjqWszBT+/qkgkkWA2qfh9emJ8cXJmBEDm8uIAdmAUPRmWnYvHFqO+7dQ8KyAfh0vsp7jwx6nNxnSm4ZsX4mLUIqm74k0TPw7FHhJlPpUvYCmW74QUSqB9NZuwtVtYBlRHp2YqVSDy1Q6+GKSRZJMcXTvPCKgmBEIRIbNpEqzhHkY5lU/GiNrjJTr16TCb/zrQZMhDpLhPmmHxbe5YdsMCCsmaiLCm0C+ys3KnM9dS1k6vEiZKGFdieVQLl2kjMTL+LerqxRuPdnEIUYIdbSb4KmOXxcerOPp5F9BIUakTj0E8e1dE8Ns4sMA/cWyX/FZ+Sun4LneGbBp7r+LJAN0m/fCGtFqVyBmN1i8XKxWcIw08fULDaPvFmbRTnrBoVSUuFkwSQfXvU4KP/R4cEM2WYlYdPZM4y7ZpGGzCBj7Wl2SkH2UOi+g6uE8l/J3cNkMLwSvaZ/nwxfKSuzomYKh9MqrLaFNHyE4jTmYwGR3sJJ1QhV3spFusqBWmwOsdx56x8PQzSgzvUgzmdI8HP5Ed9ujTo64jpPa+uKBQ5JgFY/52k2+NrF/iiB2TwVJGSeKIlfz8cGYm6UKLJ+CPEMqmFt7WrU9VOZXQcOB5QgtY8i4PRscgpbX9Cn9P2vazwNzQ==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39840400004)(376002)(346002)(451199021)(36840700001)(46966006)(7636003)(36756003)(83380400001)(54906003)(316002)(4326008)(70586007)(70206006)(966005)(478600001)(6666004)(40480700001)(82310400005)(8676002)(8936002)(2906002)(44832011)(6486002)(5660300002)(41300700001)(83170400001)(7596003)(356005)(36860700001)(6506007)(1076003)(26005)(186003)(6512007)(42882007)(47076005)(2616005)(336012)(15974865002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:38:17.7770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c71c2da-6e59-42b3-7a63-08db5df6d890
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9912
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

Changes in v2:
Changed "fixed-clock" into "nvmem-clock" in dts example
Add minItems:1 to nvmem-cell-names

 .../bindings/clock/nvmem-clock.yaml           | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nvmem-clock.yam=
l

diff --git a/Documentation/devicetree/bindings/clock/nvmem-clock.yaml b/Doc=
umentation/devicetree/bindings/clock/nvmem-clock.yaml
new file mode 100644
index 000000000000..af96a5e9372d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nvmem-clock.yaml
@@ -0,0 +1,63 @@
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
+    minItems: 1
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
+      compatible =3D "nvmem-clock";
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
