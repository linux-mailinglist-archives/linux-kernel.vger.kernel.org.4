Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B526AD7CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCGG5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjCGG4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:56:35 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D21582A95;
        Mon,  6 Mar 2023 22:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcDiPQOUGt3PK+nvuKy0AuondQ6lHKnhj16GDxDeRlM=;
 b=u1gXLqQ0uvtUauBLLQlm2VAkpJ1Xp99p7gW3TB6smTXXB8vZxj3ZaG2Q+lJiltaZCBYohSLsKKqioosW5EKer7Lm/iKBBcGltWb3qZUN1i0VdorEoOEWTAxi9IUbVvEirT2LJ1ghQnDGDGGrp563gHkdZwkQpEGiBWt0KfgGvHkqIyPVsAHrrg1JSD6WLqey7ETc2XsFjyo/bfqZABAS/dxllA2fLPLv1JUMEAeuGNVR2Z3db8Qf3LTD7R074p2zT6Zrn9bBS06TL6JMRDRqy6UtN0oLfiQs6AyZTg9YZx8RmTttM3aW8+yBs9ain2eKoG59DV2GzwwQgYAJTqU57g==
Received: from FR0P281CA0127.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:97::8) by
 DUZPR04MB9897.eurprd04.prod.outlook.com (2603:10a6:10:4ad::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29; Tue, 7 Mar 2023 06:55:47 +0000
Received: from VE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:97:cafe::e5) by FR0P281CA0127.outlook.office365.com
 (2603:10a6:d10:97::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16 via Frontend
 Transport; Tue, 7 Mar 2023 06:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 VE1EUR01FT040.mail.protection.outlook.com (10.152.3.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 06:55:46 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.173) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 07 Mar 2023 06:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWzDf9162WpMLZNgFgvaN8lYa40UDPQJfQzONkHnXC86dfb2c9FKjTRYUL9Fdeu881Kt3x0XfocaU1I4PO+IJ46BsGrgwBYLNC3hrk3cVwPL0MtS5pUhmDe7WdtrV822BWyUXKT/iAUhbHjgNw0nllOHl/1KG2O2bTX03auWA+Fng8NhRqim3vl+iDVZr2I2NEztKcA3jNysZmVVele6Az1x43jEU3yTzeQBeEtsfJzdXC62UMeasP5R3eKHJ2GWufTli+AFHjaLDW3pr7hjK8eE76QMslm5tRtiDhXK60PgsezURl6V9wqpwWQGba2djtesUJVH8kAFsS+ZnJm/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1CPoGJvSe1uai+s0eWzNfY8h55wGTrzZG0PlRkHNOY=;
 b=aabzaVbNyk2ibyK4UZPf07lqHc7baxY9bl9d39DsgMPIBDKk/XTUwttCfDzJwsXw+fSWJguH9jgds0dO8wCveNrV6T+dveyG0AHYGnLSINGvGjQlXwEKacWUa2DlYFvs253qssxqBMdoPXIJN5REJi2eo2a2nigwIBJBCxBvFPd9UZADQ0havNXmSfApVCZqim38Su6hTjIFBRyhvclUoJswQrCtZ1dospCOQsi6OAZVA9utD86QTEw7jNT7h1PkxJbBeXfMIbTCHy/8CisF58qjmQoHLwO36EJBhKnDVJfLHVgXLpwmhHGYfG/0SyVFGqBd0Kiv3A867RCZfqOyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PAXPR04MB9107.eurprd04.prod.outlook.com (2603:10a6:102:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 06:55:41 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::a7e7:768:5a54:777a%7]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 06:55:41 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: Add TI ADS1100 and ADS1000
Date:   Tue, 7 Mar 2023 07:55:33 +0100
Message-ID: <20230307065535.7927-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0112.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::29) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PAXPR04MB9107:EE_|VE1EUR01FT040:EE_|DUZPR04MB9897:EE_
X-MS-Office365-Filtering-Correlation-Id: 026eeebd-b28d-4450-d93c-08db1ed8fa47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GF7s/aqjGrDhahRaNIsEhpiFXGa+TFGP4aZKjMSPN7aZ02BjKPeSfLdVoujDbpjqhTTJ/HeIe91Fi7x7sD4WCWBaJ6Go7wG3pHUfD6vCbEaTlmu/GeKctinagK8XQAf0zPeXVOvy9sKHhLhCjhw+zOA87vTj2A6CiKuT6bfZDr6y0ahs+Jfy8ggqilCnMeD7a4qNYxeAkctEzeYEYvVcXjhIJVEF2BM6N1D0hNXjdJkmaA7caEvVgiPtaD4ZddmThkbOkm5HPFsIgOxh9xFKbav2sr8Xyg7g9GXYnsAwNMWJZwhTolKeW2uwYvfEj2e2tNVrmPw55okqbplw6heBzXHfp1fNcpyQPzF689l6vPKv077JGbyb/dq3efvw7I9BiXsTnX1BPGnLUIDO6R0lsZT8iFAMVmBLNd3EFvzjX2HGkebCbAXd2O22Yhkkb/0oEt9gr7ZCRbgtUeC+x5pJ9yBzPR7yQmpRuZ26SxJiAKeCkDkIg+AKCjvi/d0/Ymp+iS0ZhW133R45TQgahAP/RJJCFxB97NMbQ99WugUqoFOpI6GHu2Z05gTYzY2VX3cBs+vPxhoRl2ejXE+oUz1GNRGGGmlWd+OvIyC0kMy+OkfEvZSuoT2/pxhtPofJtkDr9DW37RYJTvLscN8Bqydk/L2GhMSL/4TjvnZDVH3IU/fnVCepk+oqR4jorHdsTP4U
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39840400004)(376002)(346002)(396003)(451199018)(36756003)(4326008)(44832011)(41300700001)(66946007)(66556008)(66476007)(8676002)(8936002)(6506007)(5660300002)(2906002)(6666004)(83170400001)(38100700002)(38350700002)(52116002)(1076003)(26005)(966005)(6486002)(54906003)(316002)(478600001)(6512007)(2616005)(186003)(42882007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9107
X-CodeTwo-MessageID: d8b06f67-7ec2-4c9a-a671-017eb1800dc5.20230307065545@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.5423d502-0a89-419b-9ff2-cfd5bf0311ce@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 99fac0f5-50f9-4178-0d7c-08db1ed8f75d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7rWQtn/hnFlPX6LW8mcKGkzx42IQVX6rQRLtgooP5r11nmO8Ei/PLanKN0gl0UwYp0uYI4HjPwUvoH84L96MpUOV7fMwcKISs/eICeR+MueV7HlQRTnUmmZVyhLsM/KGwPBOgPZThN3zs9/9RsuXeDLLZRCWOXZ4MH9urSj2ixSwl2MwvDmNhrbaWO5sFyhiMB6Eo+d+onFOzxFX9eCxDfBBPyXHnrNmGaWlANMuWP1ktCSnkuZUL2ikqEcOPsai7a4xEUY/KMoNTnuGJb3jsiKGlrLrNiWc7kL1OsDTJmGa/gKUUpmD22ZWo4vmrM+eSXHAvudeeZR0jUmemSRhLbEJ6ToMA94w/DfRnnNJerhoSIeAlN3oTbBzI1iKmBioHVSfEjrvAVqIAtxsL9bWkwOzA5/YhNcVFBJsdu1vMOiu/xHNW6KpoDNu6G2J+lUOrM4j+crtlIqZX/V5rrg2bCTm1EjIzJmsAn3TM5Vfu3HfjSzNOkOlLU92YMrwEhEBM5hVPUxQPoF2ZSkcWr/pnOYDpTVgTHYF35ciDiN4DnBRAhnrJOGl48Up6teUWvsfZ+e67eOhXnIX2t1YfnKueNpwqUtdq2X7MQIsC45hpwKj4YFg0XgM08QWmulguGbe5KxISRujsP19+20g/YX0yrK94c0/IHOvbo0vzvMxQA=
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(39840400004)(136003)(451199018)(36840700001)(46966006)(36756003)(4326008)(70586007)(41300700001)(8676002)(8936002)(70206006)(44832011)(5660300002)(2906002)(15974865002)(7636003)(7596003)(356005)(83170400001)(36860700001)(6666004)(6512007)(6506007)(1076003)(966005)(6486002)(478600001)(54906003)(316002)(40480700001)(82310400005)(47076005)(42882007)(336012)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 06:55:46.2097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026eeebd-b28d-4450-d93c-08db1ed8fa47
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9897
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
