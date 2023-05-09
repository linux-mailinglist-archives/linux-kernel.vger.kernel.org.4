Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF746FC0A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjEIHqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjEIHql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:46:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20621.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBB97EC0;
        Tue,  9 May 2023 00:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIBKRvSi9SjHx+ESwD7KfkJSdYDX8MgCsmDJxFiMG2g=;
 b=AN5b2xq5BCSr21JdPhk0+Bm0JjhGGOz0FQewEN34CJ6VhmZ9b1Yhr/LlKTEp5+cHCxHnIT38BvZWs7shPL1xyQmH1VU2icJ0pJCx8LVgO7dZEiTyXYtgqjvgT6NfJq93jBHG4Kmei18EG9s9S6xlUX3UlkZS3TM1aY9nb6vSBaTXR7uEj0lAxnoBvDQp+VpNfyXbLBmOQNaLhkdAWFguBxq5RyFQfxe210IDZbQCirxblBmjoRzcb+tObqUo0ckue4FeQB0ewtY3PC8jU98KlZ2euZOROx/jlKENZA71h5PGCJDSlI41xhJfKCDZblv5skpMtK+h9yURtIZo1XKulQ==
Received: from DU2PR04CA0055.eurprd04.prod.outlook.com (2603:10a6:10:234::30)
 by DU2PR04MB8871.eurprd04.prod.outlook.com (2603:10a6:10:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 07:46:34 +0000
Received: from DB5EUR01FT008.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:234:cafe::fe) by DU2PR04CA0055.outlook.office365.com
 (2603:10a6:10:234::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 07:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB5EUR01FT008.mail.protection.outlook.com (10.152.4.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 07:46:33 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (104.47.2.56) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 09 May 2023 07:46:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DccIktF01RSLxHWEXM5jbz9Rc+U2pGxrp9qk7lGUMDIDNnRK2k5ciEmLQfnRcwMnSdOj3LLO8bqNg3O/a6WYp2sPtFjFMj+zISODo3L1vspwBJHMd6CFF9ZGswMuyo0OsCz83Jtprq68/Qh7/u81t1C0OdS6UGmzDFcytksebbVpDpM6JUj2AsPBgDFXj6v4roiduCGM1WrYGfku8/9Ci/BI5BQw4y25zBFQCv7zSTKh1A4Nlu670RrwY0mAulR3NlNkgLh0ez0/vOCyecSzi76N3TTIE+ywC/H39lEdinJngpfSlgIXmrlyxp+AM8dE+MRzTYN5IiEOhBwmaCZ+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9LftdFbV/WNRh2vOn29IPJR/mhdPigxzD+O59Y5Idw=;
 b=GrvCWoeGFDmkFV0C8bdTVb6xmb7jW98uQWOWjDHPlXUQClqDcgQev7RAHBgBuIhiMsL8k4afuoiEHm3wxlG7wAguVhwXKKjCWz1j/LKFojweI9FvMOsSn5bwj/Q80+0H4zmoH5phU7VH4AC4EkArQeJxv5PN9bce9I/Ldut3iTscOz9///QvtICWup+BpG99f9EzAppRyQPnqjjOywihjdIaJwV2KWbcjoLpooxWyMXZPlK/s8Qv1Clmp/rmQuZchHCc+Zt4QT0ERNyFlu834BD93/kjxiQjSb4dkdqXIk2qUBma2tiTP90prrtEncrLE9FETeT6KJETsWR2xdVkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AM6PR04MB6520.eurprd04.prod.outlook.com (2603:10a6:20b:f7::16)
 by PAXPR04MB8288.eurprd04.prod.outlook.com (2603:10a6:102:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 07:46:28 +0000
Received: from AM6PR04MB6520.eurprd04.prod.outlook.com
 ([fe80::8cf4:9979:4ca8:213c]) by AM6PR04MB6520.eurprd04.prod.outlook.com
 ([fe80::8cf4:9979:4ca8:213c%6]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 07:46:28 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: usb: misc: Add microchip USB5807 HUB driver
Date:   Tue, 9 May 2023 09:46:20 +0200
Message-ID: <20230509074621.29774-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::13) To AM6PR04MB6520.eurprd04.prod.outlook.com
 (2603:10a6:20b:f7::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM6PR04MB6520:EE_|PAXPR04MB8288:EE_|DB5EUR01FT008:EE_|DU2PR04MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: ca92ee56-7c29-4665-5e0f-08db50618290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MGvirCiUsmn8F8KEH378vOfQAM/NM3bqvQr6gOSJ+j09qKnAhpWGZ1lVqpS49Fr3yyHW4Wahyco+6Ufe4grsXVCQW8L6KlNoHNv1/YDEqxKgK58lUWU6Ax3ptmn+e+AybW3g99A8wta3e4RxIdfY0mIPxy91S6Hqzlqdt35samekPRiEcpNe3bhGYwWsOuh01ON8D2mlhR54l6LM+6CzmYnSzsO7M2MYdWKevuk3cWlaqOYfxJHfjkV7Bmhh5KVZNu8k9ERPgxZKrykgGFg/N4k5o2p18FKVuLuBM/ovrr+ccZpEMXt8KBjgngfpPgDVj3l52jawvASpBF/oXvl9ibo/y7kYWNQ7oputrfl9qYYUg8Yayv3Fp0qJBlKK3dN/bjquUHbp1JiAOa655Jhpedfhcsbw3xG/cr4UZ9WmawAoD9d49tYKbOk2CwTPY603iiCn+tTA5VqqqsXzJ1XRvV4x3D6pPHD7eZdFbOFeBhW/bw3QI5lZyH0cIdYNRtsXdzkIxF9/hZlNBSU+Y8ypR1wt3Un02pwu7MjRzMeFk0dtNzCtErXbCs/RTs5Eab6YBIitHJ9lrTvBIWcdIGSZ0vyKqmLiPRArW5AcHWW9+y0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6520.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39840400004)(451199021)(2906002)(316002)(8676002)(8936002)(41300700001)(66476007)(478600001)(5660300002)(4326008)(54906003)(6666004)(66946007)(66556008)(44832011)(966005)(52116002)(6486002)(1076003)(6506007)(6512007)(26005)(186003)(83170400001)(36756003)(2616005)(42882007)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8288
X-CodeTwo-MessageID: 4f37d938-63bc-44c4-af5e-a7ba09e465be.20230509074631@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.73717b19-477a-47ab-9efb-48f096304ca8@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT008.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bb7689ca-8c83-489d-d799-08db50617f35
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5P6E9mrozFq9iztGpa7mBJXeCQ12uIUJGCLMFXBaSBcNgS/wf7S7znQ4uGi3NXLZUDLAEV6HZndcF7qhCI5eG3cFsCRwIvfbpojHQa9BqOF68NxQ4v9XntsSGHUYrgdMvk1T7IwDH6H1Qgmv99HnMapJfUWEIgMNpelbzElvM9gGNyLP0f50cw9JmePdb40NoJ9WLzbB0p1bcpG2Ll7FlplBzFMzqeBZkRfUi9XdOR3k8tXkfZHkrndR6JaopWAz5IDb16WLxXivuo63H9sqQI5W8dRswwtjngq0fOzkpyCFXw6V5i9j73ySUDlJapaIunrFzT6QLCS7J79Rxs1DmEQhJao6sRGYqenfB79DSF0vv2qMke3KPNccNu4H0LcS3a/k4GN4nTeefyCSzOEFDki3caMrWRFZ4OuiVp5TaU0mWuNf3cKfeeFbcAPf9pYcB8wDMjlNfVD4+wtd6JRAPLIm89t16NdzF/Z1sGPVssehbNTkPem7cmSO914JAZu3J/vTF29ZXrLYO7INlriDH/D2V0qaGmoJ+iedUdnq0JzYS6RQefgYs2d+MRHNOw12vH4xAc2Be5JLuhw4ScH9/10Ip8texRBi074bHvPyFIAytpnUWh5RQsoV4PAUF+uJl0Z4qDzZdNB/7/ojU7AEqdrBEoLWlZpxJspOJIELKI=
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39830400003)(376002)(346002)(451199021)(36840700001)(46966006)(966005)(70206006)(4326008)(336012)(478600001)(70586007)(6486002)(6666004)(316002)(54906003)(15974865002)(36756003)(47076005)(42882007)(1076003)(36860700001)(6506007)(6512007)(26005)(2616005)(8936002)(5660300002)(41300700001)(8676002)(44832011)(2906002)(82310400005)(40480700001)(356005)(7636003)(186003)(7596003)(83170400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 07:46:33.4200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca92ee56-7c29-4665-5e0f-08db50618290
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT008.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8871
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

 .../devicetree/bindings/usb/usb5807.yaml      | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/usb5807.yaml

diff --git a/Documentation/devicetree/bindings/usb/usb5807.yaml b/Documenta=
tion/devicetree/bindings/usb/usb5807.yaml
new file mode 100644
index 000000000000..06b94210c281
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb5807.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/usb5807.yaml#
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
+    description: |
+      Should specify the gpio for hub reset
+
+  swap-dx-lanes:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: |
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
