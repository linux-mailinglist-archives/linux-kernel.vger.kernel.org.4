Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD10702497
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbjEOGZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbjEOGZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:25:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8526A8;
        Sun, 14 May 2023 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IJUozzBV3ITTHoJunYUHYXDKWhVa9s20GQxi5ii0iE=;
 b=XijtSBbbKov+S8i3NiMkg5qTGC3qWLM7GyGMBjJB/9rojRwzcraHINXJACrfaRcDvIHc5f7WTw8NBsgCj2PZfIJLeVxJHweWVN+Hq1aOFu2fRCaC2PdJ/LcpfZPKxA7ikICgP4/k2daIETODV3OJUeIqhZ5uiSZPOo1MvuLXDGb4y7DUvmYT0gldniQqEfC6VIow3Se+LspqEx5EaSatjnrUnS/0gCEAf2xo3RWiS/NDtWAe3pclk8LiKtCDIZKsy5yvDP3x4pVg2K6qqvRjqdAoZIC7g98ACufw8+MZCCP59d37UztXbVDr6K8ovh3cjr6nKbU98wkZ41zKKVIdPQ==
Received: from DB6PR0202CA0019.eurprd02.prod.outlook.com (2603:10a6:4:29::29)
 by AM8PR04MB7379.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 06:25:14 +0000
Received: from DB5EUR01FT091.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::ea) by DB6PR0202CA0019.outlook.office365.com
 (2603:10a6:4:29::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29 via Frontend
 Transport; Mon, 15 May 2023 06:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT091.mail.protection.outlook.com (10.152.5.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.29 via Frontend Transport; Mon, 15 May 2023 06:25:13 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.177) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 15 May 2023 06:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBaiM/WCXzU7azsk2z7MAsu1ZxtEhQVkRNFFiuqYR14ininV5ZRlcfKGQag2lZ0MXv9h9Vp/4tlOypaCGl1SpZUBL494NvIzWNkG4UaF4dxq4jWmvxizGzZs9GtiL+oBqq+XnkpRZpVyCz+HgxEiQD0js29g2Ysk5u1w3LBKcTVn/24nblF1w3GnAKpqg3bGk49B1YvOCADf6e4OFIodMtL1EphQQyrY/PmRVP70Fd23O3AmSp8f0Lh2b8tBrHNR3DXeRRkPgMAX9H76Vq6MRTXqDC38D3AKwuWi+N4YHC3NGCGaafAQ9cZ+yopSabA9Q4wTqgIL9nnMp4uJjpv/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIGSnjgWpwba90XCwWe82ADgDCq40CxnyXT241WntnE=;
 b=fr3F4EGuPpupWgKrfmJ8OphfsWSbfvY73lpmnlMon3UrKRT/U53LiWlNsq/Va1k8Omr4YCNXpUxJ6iIDLNHsTcHKj2SIwnS1IVAJVIJahNC2Pioqwj+XT4sQak/th5ZKOdyKg70kux3uY4+xYTauyLNr5CbRfF4NEjyB2r7W26v2lArKJSXHpTypnzYmVDSsAUA2/pMyXlRwshkRgY0XA0DYEI+TX9EYVV1QEUEmkgufzEKJTwQMfh/lhlYM7zjv8MNRbNt1P41J28AyeNof3JgkckWhiLvChyVLczhCLXm1K2Xf485smiFVW4KcSRpSSEPwVAcqg5r2+ISrZigIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM9PR04MB8795.eurprd04.prod.outlook.com (2603:10a6:20b:40a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 06:25:09 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f4fa:8429:9de2:41c3]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f4fa:8429:9de2:41c3%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 06:25:09 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: usb: Add microchip USB5807 HUB
Date:   Mon, 15 May 2023 08:25:01 +0200
Message-ID: <20230515062502.29273-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:205:1::18) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM9PR04MB8795:EE_|DB5EUR01FT091:EE_|AM8PR04MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 674c377a-9796-4b20-fae4-08db550d249f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hg0yo2QMBwEJCIzTA1hbyI8WWnVlZPqcDnQwvVWw6YBs3VXcJ2HxMOTu/w9q5jA9/YjKBBJAloMrxY92hiSfqYNb+nd3tY2MlXvirxvafkp54ygrVktofopz5rT9xO/P/BARz6yBaB39IpKXQljbngWKH3hRKFrdJGTi7la7aVX6kgar4OgFojj4KYx/wmXia5WdL9tc7oF175TXGLbyQiOqDoTWw2xhWWyZpuLv0jyGQI3XvYIMoo+3ZgFfhtREhTKbGAa1NC2VeFghv1xeA16Wlgz6GWrZTR7WL/klSs27OlwLE+c4/Vy/+UgQ08b0yp0RRVvDnmqlVk+fqbw1Ys63XeZ1jHsMyKmHEFnw7s1B4Mm6ruZFCmm6pG3Yj61hdSnTDDeoid00Rqce8f14OnzGKC0HlVd6h6WCWjN0ObepoXj/f570a1rx8BDLswaIzNmuNf3MOweZZI1GhSzPsZhlfiJJ7f8LW2pwHsnDm7mK8b2qguRYgqFH+Wpod48c+Li261KMtoTvHlZD0z4I6nM22XtMW+ihRZeuWrO78+VaC3cbysQRlUTTkY9ejKgUzqRw69fxAXfTHHGvVvqC9rXIEd0acbblvExHQbP9PNg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39830400003)(451199021)(316002)(4326008)(66946007)(2906002)(5660300002)(44832011)(8936002)(8676002)(66476007)(66556008)(41300700001)(42882007)(54906003)(478600001)(2616005)(966005)(52116002)(36756003)(6666004)(6486002)(26005)(6512007)(1076003)(186003)(6506007)(83170400001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8795
X-CodeTwo-MessageID: 05461389-e3ba-428d-9dd9-8afea7a2ce17.20230515062513@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f4f6ec47-9e6b-4978-b229-53520227ed28@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT091.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e18b0fc3-4138-4113-e9e0-08db550d21e7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+Vp1piS8X/QO/wd22wnVS5Q8d3GnEjSU3RMERHgt7JY3bGQihIqQ8GUJ4X0ibt4FdycbVkNY0JE6Itd6ot6dagbKc/84d/oxucHtal2EHOz4UzBtnA3bd/fBj41VvbVMQROjK17Tlqvrau6thxj8NM2VxLggB5myXjds4njvIIuoJwMf7cDMicCt2Rxn9ZWEOi/WJ1q6byMcakG1Mdlfy/Pr5Vijysl1w4S4Qnux26WRbsuDSfeY7Rk7naFSQHSQtrVsrxjaldRcoh5YQ7OLir76K3dGffeMp4ed3CQZd+MqCiDMo1UNp/HK05B5y7XUUU37B3aOOhaKWxfFft9XTVnbdW56WbPEPCX+IyiifXG8vhnGa8rE9Gu3URIm1oAU5NKmyp0r3PpFVNu72E99NBAbq7XovxQE5W/emZrkq06tIUki6IUoiYT7MNT7rt/50sbf5QXeWQCEFgHCwwmIBU+kCBO1GZv+BZ1lIWkHrBNDpomJr62NRQpYv8vwzu2RMM2f7UfiHydyYQOnX5t0zpXfENWu3RSBTMFkmBfEsB+qdM+YRMOB+IQQ8uCbwvX7B4xw6MwcVo3WmvgLRIcEZAVsPuLVfgkRi8OCHDjLD3GTA0zANyljxl7Zye7hLwWhmNxubPAAshDJtEujUFWdbdo4x+d9HY1XGqlW51LD/8/5G4UTz6V1ChUnMvIJ5PI
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39830400003)(451199021)(46966006)(36840700001)(316002)(4326008)(70586007)(70206006)(2906002)(5660300002)(44832011)(8936002)(8676002)(41300700001)(42882007)(54906003)(478600001)(2616005)(966005)(40480700001)(36756003)(6666004)(6486002)(26005)(6512007)(1076003)(186003)(15974865002)(6506007)(47076005)(336012)(36860700001)(7636003)(7596003)(356005)(83170400001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 06:25:13.8894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 674c377a-9796-4b20-fae4-08db550d249f
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT091.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7379
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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

Changes in v2:
Rename to microchip,usb5807.yaml
Remove reset-gpios description
Add maxItems
Add vddXX-supply properties

 .../bindings/usb/microchip,usb5807.yaml       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb5807=
.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5807.yaml b=
/Documentation/devicetree/bindings/usb/microchip,usb5807.yaml
new file mode 100644
index 000000000000..ac5f1a959aae
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,usb5807.yaml
@@ -0,0 +1,57 @@
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
