Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949516AC080
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCFNNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCFNNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:13:34 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B9EE3A0;
        Mon,  6 Mar 2023 05:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcDiPQOUGt3PK+nvuKy0AuondQ6lHKnhj16GDxDeRlM=;
 b=TwL8tJogRIpsZvNydO5mU5mINtflO5KlbzP42dTXkQMnu6jCNKmFtECh2OhJslT0raoLOwPDIAvCr+dKC02mTs7tR+VonHr4zAkMnPa03cEjRqwZsZ19i6pa0iX4CAFfeVIClBVRGKIQg15NNIa7eHHJgfpS0ujW6MgOqe4mZLB35mA7bcfV8GMWmhxS+7QI9/nxpwbRQ+mjOqM32F/7vmjb8jcYIyRgMpmKUhzYuLOrpLGVvfVD0grkE1Rk5KwEj08dacfhgqPbhnvJLbvz+YPu7oDtxhHmMMBPsdL/ewoD/b3vJyLwLWamKbFuio9qO+Utf2C7sRaf+Dmwl1HF8Q==
Received: from DUZPR01CA0192.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::15) by GV1PR04MB9513.eurprd04.prod.outlook.com
 (2603:10a6:150:1e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 13:13:24 +0000
Received: from DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:4b6:cafe::ee) by DUZPR01CA0192.outlook.office365.com
 (2603:10a6:10:4b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 13:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT026.mail.protection.outlook.com (10.152.5.2) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.17 via Frontend Transport; Mon, 6 Mar 2023 13:13:23 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.51) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 06 Mar 2023 13:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgeMcoib+m4UT2BNBDmafCS/10Ea4Cd+AffyNAGv+v7EAsIzfUxMjiN5bPWO6NrlRH5xBgaTFGZPVdJqpMCiXpR6dBSsXmFalMwiLmNFU4KdGFllc2AtHW/7zUMtmoLh1nKBntqd36zj/oR7NrHNQ9o8kfrOBiWbVN0tW+HamzxZO3G8/pNo9OL5oFS5C8/wbewUovY+bJj60DMOW9MeJKlyNVzqKWVzAp4zmTRkc6hgzQ8r+c0lyUgbSZag8vTdPMytcBuVgH09V+0N0/ws3KZMsRvEC6zTIsOc8WS7es9ChsI7D94PHAKWsKeThckO9yyJ29vNl5mUnWWN+arlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1CPoGJvSe1uai+s0eWzNfY8h55wGTrzZG0PlRkHNOY=;
 b=Sw44OutNKQ52zmT1od1M0HUJABiRgjHGwT7ejllXNfBndq9mCzisItPMm1q2yXmtzvHuD/mRomNjZedH+1c+Z+TGvpRJUWPHIwKBz07VppDXAupv42Ujfp96cauvL55+ImT7ycSGXG/zhsVhP4m10M7p5s3ITR5zmZ33BegxvoPTZUrUES55ziwEKJcYxgGgGdnyFxfxLxgUDlyqIGrWsKzZ6N53lgzLHGQzL+wLRufiX1Lvc3UJNn9ij7V8t91X9Nh7/kfjyIMXxswthQg0CRq1+ib/Vt5V94xTr27KxkZHkbA+cQjjW4hhHf70khym6bt5eMoR00ytCWQ+O8hUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM9PR04MB8355.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 13:13:19 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 13:13:19 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: Add TI ADS1100 and ADS1000
Date:   Mon, 6 Mar 2023 14:13:11 +0100
Message-ID: <20230306131312.7170-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0003.eurprd03.prod.outlook.com
 (2603:10a6:205:2::16) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM9PR04MB8355:EE_|DB5EUR01FT026:EE_|GV1PR04MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: a701bc40-2595-4054-71ea-08db1e4490e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zwPj+th92szjR7Cwhw6alRYl82VfxtZGKcNmWGa2j7wxMJqlOTlUkN2ZW6SObNxmoOFqqI67fLiN9tP45YVeZH+JOPQKoSBiu9lK5h0/Idl6598C8gOtBzqVfoY0eM0nJ3dq43JeIuq09AjEnQLCQZia5pv6vHZ/xUQ5wwat6k39bNRxPADwaOYj6wRkvB5JKpjSJ5np/0PVBwoAyat9HjomQ4bOWyb33vCSRnLNsIyGES475SpfwQSWrQ5HMdPYR181aDnz7+M8rN+1SJ6W/+30T7+bhfNgKrN82rR0tPNYiScOiLw/aJ2VSJh0NCij8HBW5XV/+W/2i7BPLNwwwtXLavSAlcCKThTwzslO61YN5DhnmpHqK38Q4gThzL39qIJuPN2VhFyqnUnhPakM8GBTKaRAjW/Yb1Jm0CQ2U7aBDI8vs8KzJpcEyblqwgwJEGW8ueKbe0k19RBfNegWxw+ypU5MxPZIov4s6O0zwIEZHLs8/1+lVpdEE1W395QOXrgIy99FQ+DLgaT8KHzySly/v+p9/KtXNEmhH2eulyz/NS5RW52uhSPOm5BVHdu7JRmEHFibH2BpPshmn4faDewTQpX+wvJPizQwmQSSVtOsPT3BdIXR3pC+eNkwXOQjRR4F5tz9swlKRAASQD1SVCnGGvlQoEBW7kFElI/eVbTcpCh8HMNCf2wQ49YoqEL4
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39830400003)(346002)(396003)(366004)(136003)(376002)(451199018)(8936002)(5660300002)(44832011)(66476007)(66556008)(66946007)(2906002)(8676002)(4326008)(54906003)(316002)(478600001)(52116002)(36756003)(6666004)(6512007)(1076003)(6506007)(966005)(6486002)(26005)(2616005)(41300700001)(83170400001)(42882007)(186003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8355
X-CodeTwo-MessageID: b049a3c8-4970-4689-928a-b83940e4ca04.20230306131323@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd3967b4-1646-4b17-a426-66ee84660804@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 35281612-809a-4050-518d-08db1e448de3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klTURBG/lVBfner7vvHn3DSyw1Xv+Te/H9p3urvE3oP6ExSy0t9Mf3rnWSRWa/iCsPA7YL157slvaxPf3oX2VdwFfkqeS2uFfIQQbRKKKGNubuESafmZkvVNjkoZ78496diQ2tb/qi2lw8T7/uHfOwDhR2Vc0a0iCPQLCYdjUSoIy3NddendzyB+FIkT/Y3PT2rEmZIdykzntl3Aj6n2KQg46SJn6OaU6SAZmPwb591LXD2rGHBeaGtY/aVWOcwWyGIt5xc3vWZtB5yRTvNAem3tBpmuUYDd9gbm3tbkm6dr7cVVw7OHK0A/hHlN9raRbmfhCtZopczLoN+TzAL+bl3lUjIHlEL9jd6ggGjkcAnSYnBwhYOQpx5uHwyOy0yIIrGe2qWOKws96BtzSxt+S1ilct7d4UJ7u6w38KhpNCFCfEi4EBryojn6HzWYXFL/FD8px7nHSupNqFJoO7wAMo/NEWfNqONkmgTteu6SZYoppRdAAXivTzZIj3OgAWY4dkMlYRG/tM4LTPoiGAiuy8VUQsIGZcc70cv++WAm5hSV/HSZXIWDH75FYan4wjR1apnX6VVN9AiQhAmkzwvKYLwQBXkSaaQbEFQT3etxd6+Y30nZbpD8/MSUPxWSqBe53NUSzylYDruP4Oaccj7NaASASnJxTBEGlO3D1IE/1cc=
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39830400003)(396003)(346002)(451199018)(46966006)(36840700001)(36756003)(4326008)(70206006)(70586007)(41300700001)(40480700001)(8936002)(8676002)(44832011)(1076003)(2906002)(5660300002)(7596003)(7636003)(83170400001)(356005)(15974865002)(36860700001)(6666004)(966005)(6486002)(478600001)(54906003)(316002)(82310400005)(47076005)(6512007)(6506007)(42882007)(2616005)(336012)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 13:13:23.8944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a701bc40-2595-4054-71ea-08db1e4490e8
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9513
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADS1100 is a 16-bit ADC (at 8 samples per second).
The ADS1000 is similar, but has a fixed data rate.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v2)

Changes in v2:
"reg" property is mandatory.
Add vdd-supply and #io-channel-cells

 .../bindings/iio/adc/ti,ads1100.yaml          | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1100.ya=
ml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
new file mode 100644
index 000000000000..970ccab15e1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1100/ADS1000 single channel I2C analog to digital converter
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: |
+  Datasheet at: https://www.ti.com/lit/gpn/ads1100
+
+properties:
+  compatible:
+    enum:
+      - ti,ads1100
+      - ti,ads1000
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#io-channel-cells":
+    const: 0
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
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        adc@49 {
+            compatible =3D "ti,ads1100";
+            reg =3D <0x49>;
+        };
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
