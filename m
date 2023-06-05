Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4933C722816
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjFEOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjFEOCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:02:07 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2048.outbound.protection.outlook.com [40.107.13.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F7A116;
        Mon,  5 Jun 2023 07:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFHaM/Yg+z6PiN+yCwkKDmPrukzUL2NSS/b0FLnSbkwHFpMYS4Rj5SrGAMo8mzr5NAq8KxM7DL3nx2KulSxzmML3MjHZwIPWSvoCJpah9bczNvRCYAWG9l5gg7c2ZEYEAL9SVm6EuOxuuD5y/libP+FvAHruUyaE72dm8PAgNLUHeQOXtmjJ+ceabFwMQnCZLXEZW54g9w6iwiqa81cet6Ds83lruURBlr7dVA69j1yQkT75YFFdI95FuLBgVlCT3XTrGrYnZqgWJpEY8yzECNCvsjl7xptulB5Uv0TWwtWLmuKonj30YtUVzaW6+zXAD5MVvZ0kqTQYA5y3W/vNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lNXeiXeKaOrPCfdcNDTCRrucNM2b7pPwuqXjA/Aefw=;
 b=kI9DM6VF320TaovQ9Lv8iTtiyoNQTNO3/1f7eh1XsyPYTRwvUZql7rBu2+Sina3pOBxA30jOpesThCvvyJpn2iU/X0tWP+C7ojCiYzntP/piK/WV2C8NpHZaiWYQ+SnVOMtmCUPSCH9i+UzjofWXtEJS9+uH29i5hCAQl9xoyv66AQVi2KWgwJ2Xkdo8t7jdDIeKsHoEu3sKZ85l0foUNJhlDLgWTfrxX0ZOhHYBTI8APYuObnIGRzxp/uNTkA+v9CUQGrFG039/iSchVy23g3ajftMBDQSjis4WijfHlbz4jCqLx26nVCYhc0k2leR+a5aNXcY0LhHLOwDVkgEmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lNXeiXeKaOrPCfdcNDTCRrucNM2b7pPwuqXjA/Aefw=;
 b=ATvSWnHtNHRjKAK9S76+9SDbtBZoc17ddvs4/fyOFsi7795CPC16AX0DVTUe4ht1FZVssrZZq6bfXDbeziK62my5axN3gkbWe4Tse9y3bfsRi0F5RxwQDBSaHlexByRiFoZIJ/ZsYeYfD8jo+9XwbGybCdQ7f4RDjAor3+b039g4zALinilI7ydELeeCRPsnIr7Vd0XGvPTF5UJ0qrQ8CAKhwDpq33vG+vAeo0RYjD3nvWNfUgY/+J0o/trVKB18eiIGsB00akd/bO0DqHz7FjE1cttdoPgKu8RnUZhHQaa76MPLPDU4s7bLrZiXeFtSwljd7stqQDrh5hs4ElUULA==
Received: from DU2P250CA0021.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::26)
 by AS1PR04MB9264.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 14:02:00 +0000
Received: from DB5EUR01FT003.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:231:cafe::2a) by DU2P250CA0021.outlook.office365.com
 (2603:10a6:10:231::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 14:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT003.mail.protection.outlook.com (10.152.4.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Mon, 5 Jun 2023 14:01:59 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (104.47.0.58) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 05 Jun 2023 14:01:58 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM9PR04MB8193.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 14:01:56 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 14:01:56 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: clock: fixed-clock: Add nvmem support
Date:   Mon, 5 Jun 2023 16:01:48 +0200
Message-ID: <20230605140149.16841-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0048.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::21) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM9PR04MB8193:EE_|DB5EUR01FT003:EE_|AS1PR04MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: d5955bbc-e96c-4cb2-911e-08db65cd6e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: +1YJIbKTxhmr40D6ks/9k1REx4EnXf8xOsB2iySDRNb4wijnxFgNvHtEFf7UuXfAzvGjoqKCt/xPpWD5PkL6IKVDftyV0wB/q3ya6IUS7CjMsWdz1g+WmEpTCas9RECnBVT7aChXiK6D+umRNT2QNZnooLIaRtfWao+Xjg3yxT0aXXoyRZ1Mfk3ZMFgyPELShJlIr26tNI7lCAhWo781HjZ0a802x4MXwgJDmA6a4AE/yLCGOQ8rjHTQmNv42vDvkR6rgqcv2c5BAsnV0kskuavJ7Ea1+JxH8F6Ua2O/eLnPuRExv91kz1qiV11V1c+aig+uqxFpNb39En/3N+RWHAWhLmzCEdNGvdEwVrd9UOOIlJVfLGk6cPSJW0i94+yRA1uvcheWS+rZHZFiySGIDDESZsQ5Ao3deC1K5CbCTzOS0NRmtFPYGkeAlviQkn+lig5v1mOBvzO8/7JdPurIp3w0HlhL+IeY2d+it4jEMrwB8o0wfMZQEgjdDKOD8KrXxaQu1IHHRQr4G7qdKjVG6ih+URmbxzWPVRZimAQM9r/pYHaSlgty6sTGGv5HRsc+yQKssRjVKeRP8ZG3TNnTVrWkq+UfSAEt+4ziNXOz3+mrBFq46YuF6AmTHsupeZVf
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39840400004)(346002)(451199021)(83380400001)(42882007)(83170400001)(44832011)(54906003)(478600001)(8676002)(8936002)(41300700001)(316002)(66476007)(66946007)(66556008)(5660300002)(38100700002)(38350700002)(4326008)(6486002)(36756003)(6666004)(52116002)(2906002)(6512007)(186003)(6506007)(1076003)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8193
X-CodeTwo-MessageID: dfc8aea8-809c-42e7-97dc-b341cdba78b5.20230605140158@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2d27bfea-4746-444c-89f4-e5d35cb7de66@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT003.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8a71bac3-1948-469f-02b4-08db65cd6c1e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wn57WN3gC7M83faiCQMM+7wN20PAfyzlagr3liDC1dT1jOnUA1icrCyEGxya5AxVS6inSSH++DTQqhCGjhIrWTaz4Ah010qxw9IdCsTYGJqUypFYzovv5feUMD8Kt+/EFWf4S3SI3dTASAffP9lV8L9GkxQ0X/CEnq/E/b0u2tJHOzV3va+97aogkHNOfc3W2HSVV7fb6MGBMSRDWKNISS8vC/FevQrCpEp1mKTqHGgs7P4ksQFfD1YeDxY8/KPmAkUZ0CQQFNo0aInYMBT9d7Qx2tbP8va9dNHYL+E49f9HJw4t8EGknKKycVyHD49dBvgK370w4HFYGnT8Y3SVKFHwitrVXWHBy5SQNXq/wHmPLkZATc6k3Ita8jr4p8eezEy809zpgXfRpPgDYEQqvBcMznvvyLjkg558zvrWpabkcjZSDI2PJfd2tGjY9G4Ph0VP/aUwzd2Q6zt26FqmdoQ/v/8+kics1sSQGX5ZTvdP1p74hF6ltlwSDZcDJ/P+TZWD2hx/3qQvdA/HcYx02+tFiZubdRuuH2bbILDR+2XXz0SbL8f1DqDB2gR59T31LKojATzgAx2scVS0U7McCNKhWGHBOF2R+P5sEC9ooORd362c6N0KEphWb4itR1rva/aMFuaCa8pEy0xnWNhisHJ0E8Vs5EKahNoomp6xey+9lZE5CliRnNeU3NlgkW7
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(47076005)(83380400001)(336012)(42882007)(15974865002)(83170400001)(44832011)(54906003)(40480700001)(478600001)(8676002)(8936002)(316002)(70206006)(70586007)(356005)(7596003)(7636003)(4326008)(5660300002)(41300700001)(36756003)(6486002)(6666004)(2906002)(82310400005)(36860700001)(186003)(6506007)(1076003)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 14:01:59.2429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5955bbc-e96c-4cb2-911e-08db65cd6e4d
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT003.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9264
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Changes in v4:
Use proper "if" block and add example dts

Changes in v3:
Modify fixed-clock instead of introducing nvmem-clock

Changes in v2:
Changed "fixed-clock" into "nvmem-clock" in dts example
Add minItems:1 to nvmem-cell-names

 .../bindings/clock/fixed-clock.yaml           | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/Doc=
umentation/devicetree/bindings/clock/fixed-clock.yaml
index b0a4fb8256e2..71a5791da438 100644
--- a/Documentation/devicetree/bindings/clock/fixed-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
@@ -12,7 +12,9 @@ maintainers:
=20
 properties:
   compatible:
-    const: fixed-clock
+    enum:
+      - fixed-clock
+      - fixed-clock-nvmem
=20
   "#clock-cells":
     const: 0
@@ -26,11 +28,41 @@ properties:
   clock-output-names:
     maxItems: 1
=20
+  nvmem-cells:
+    minItems: 1
+    maxItems: 2
+    description:
+      Reads clock-frequency and/or clock-accuracy from an NVMEM provider i=
n
+      binary native integer format. The size of the NVMEM cell can be 1, 2=
, 4
+      or 8 bytes. If the contents of the nvmem are all zeroes or all 0xff,=
 the
+      value reverts to the one given in the property.
+
+  nvmem-cell-names:
+    minItems: 1
+    items:
+      - const: clock-frequency
+      - const: clock-accuracy
+
 required:
   - compatible
   - "#clock-cells"
   - clock-frequency
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fixed-clock-nvmem
+    then:
+      required:
+        - nvmem-cells
+        - nvmem-cell-names
+    else:
+      properties:
+        nvmem-cells: false
+        nvmem-cell-names: false
+
 additionalProperties: false
=20
 examples:
@@ -41,4 +73,12 @@ examples:
       clock-frequency =3D <1000000000>;
       clock-accuracy =3D <100>;
     };
+  - |
+    clock {
+      compatible =3D "fixed-clock-nvmem";
+      #clock-cells =3D <0>;
+      clock-frequency =3D <48000000>;
+      nvmem-cells =3D <&efuse_xtal_freq>;
+      nvmem-cell-names =3D "clock-frequency";
+    };
 ...
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
