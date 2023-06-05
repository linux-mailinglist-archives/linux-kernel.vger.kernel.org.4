Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE03F722790
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjFENe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjFENea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:34:30 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2072.outbound.protection.outlook.com [40.107.14.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD13392;
        Mon,  5 Jun 2023 06:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKX0FDV3dL9oe/TkysoCRQWxe1ezoseBcNyxC67batSqSP2fK2ZnMc6XOz/24oCdeeWGtHUcNw/pbMjf9AIIJ4mbV8iM5yMdpMrbXEtsWhk78Wg3f51TK1KQzhBT9Q5vHMltxCn0GG75b3urnobzHdy7enFRJ+psk2P4UlPB88o3kBqNTYROyvcuZgowkTPjwgVPthL2NeOo/1hCazclRYzP7dcqNWK3h0frcQ/a1mhqosDTYKREoXLvHoOiK9G2PrSw0n2Mef51WH0aMuqYlOllp4sg+Wvt+zwTj9PmCxnw8ZSzGAiNH0yIxMYzsJKCMWBGRFv58sI5pP7M5t68OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FXCiI9knXGnsIlFlLM5Ggg76YHkGn4j1c5wbxIR2iw=;
 b=dR7ajaJhtbgSL12k/l3ufj6qrbiDYeEYxaRzQh5TV5dG55syvUAL5+m7xxPrNwJc7l+JZEo2WZncRSUbE07k7bgNSGFxe7la6FhcMVqx9b4E1u4Y5qQLnRNyxYP/al/qIJ6zW5Lza7pUFnPBusDLF5trWMcuTTG/ndhgv024IRLgBhJs+DnBtA7yMFd/8KV77QvWzhUwYG8+TZA6PS16rIUHP2jj0Oc04jQawaTDrKag9pWcevY4T2s44vwdZzHDnlDiPSI2IpqSFOA5CiDP8qp2/+8EXVSF7uJ10MR4XVVWVKeKCpPJqVTf3Jj6bneHUBaZQb5peONLQky0ySJDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FXCiI9knXGnsIlFlLM5Ggg76YHkGn4j1c5wbxIR2iw=;
 b=ZSgbCt/97ufDfu9IClwTVCD+7J692bDS8fc+R8P+xfC4SGm8bGfcyyplPpyCuzHOfz9ErEsSgiEm172k8dB5aJOdVh8eV3ZL6dOXAPGuDPERKwrCNF2yHai7s1irv9BacBiqGTgzPuvJtVX4pV8zpkH3phBG6L9nnJWQKWDnndbf/Cl9zkvHyCd5WzCjwJs+4xdjguexDOp6pb1R5eoy716r0UEjU4RchRn5nZJ0KiXag0x07LkrTDGoiv5xJDEf2FmF+0HSlc9J3M0qIUPZD5biNU9thXYGDGMqJkOKNn1vGKXWiUy1MPk2mOZXPXvx5scQ9Weln96wq4DDZjjn6A==
Received: from DB6PR0202CA0046.eurprd02.prod.outlook.com (2603:10a6:4:a5::32)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 13:34:22 +0000
Received: from DB5EUR01FT101.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::57) by DB6PR0202CA0046.outlook.office365.com
 (2603:10a6:4:a5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31 via Frontend
 Transport; Mon, 5 Jun 2023 13:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5EUR01FT101.mail.protection.outlook.com (10.152.5.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.19 via Frontend Transport; Mon, 5 Jun 2023 13:34:22 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.55) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 05 Jun 2023 13:34:21 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM0PR04MB7060.eurprd04.prod.outlook.com (2603:10a6:208:196::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 13:34:17 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 13:34:17 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: clock: fixed-clock: Add nvmem support
Date:   Mon, 5 Jun 2023 15:34:09 +0200
Message-ID: <20230605133410.15076-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0224.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::31) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM0PR04MB7060:EE_|DB5EUR01FT101:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: cff79382-eda9-4992-97b1-08db65c992a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 2mCgkIanbZpti5Lu1oMPysOXsaJ4nyC+ul61+ccQryCGxMl+yYhPXnQe+hUtZUP+LWnc4nA8jPCO3hZLvSGmHHekwUZw+etvaSMugtEjtMmzNBR2AFmPYW5IIyUqmIVK6/nCbP/hEltdixTKPV7RYnf0gj+ISZUdx0WWB+YkiCgQ0f6R9WUESfw2L55TWcCXV+49G8nmIsqZ/fVPEH0nWjAdIp1F6Ks5pvA9P6H5LSRDfShKocMdOoicfF61JlfbcqDDrh2ntQarq+ugkTaRhijHWi3skBhGRQKYuTgF426Zya2EcxkVsPCwta6EzC89F5O69eqrTPD8Arv3W0qfuEMPr2YMwb6aDRz9YaaHqF4LJI3uCIQyB//rZ14EjAyGoUJSz0Pay3/Ef5BViPp3kxO+l/eA1eb0O+++9xWPgAIpXI6E5hKtsCRyQ+Fpd0mZom94I2FXPpT5hQJuZiSdzrTGfGzIOFPIUpyil2xuJpzvcfLJl37kyrQqFxPi3+tFNjFkuWqL71hXzTk2TYtgLGrl44eA0artbvSRnUT4ypMshzN+sv60ydkcvy3H8jllIZTsEOqBp02CZWKrQtcvWvRyG39eLKMMJJMin2iV+ohJG2/Pu80La7NREGclY1dR
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39840400004)(346002)(451199021)(83380400001)(42882007)(83170400001)(44832011)(54906003)(478600001)(8676002)(8936002)(41300700001)(316002)(66476007)(66946007)(66556008)(5660300002)(38100700002)(38350700002)(4326008)(6486002)(36756003)(6666004)(52116002)(2906002)(6512007)(186003)(6506007)(1076003)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7060
X-CodeTwo-MessageID: 49737e2c-ba5a-4abe-a928-adb496cb9fc2.20230605133421@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.1d0217a8-661f-4359-b77b-02222c761b01@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT101.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: efe36504-e4ef-4eaa-456a-08db65c98fab
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkZPSp6X9g61Ic8YWCN1ashyRv8oEuenBivDkNt4ikxvMzr8LhHtYeIvwAkFchIl7H8dYMS6ed5SjVBBL+ZtxzdWCvFqgQr1QSFvS07Vrj5cmOk/uIx1ZL8Ta7QcVSnW10hJLr6jMYOlEhgUtmKTMjh4lUUgRRuwoCtO/6xSAvHG/+NOfooRir9Bi74xoVkqHMtj+EfLQPBpXTeXyJXwsSDyRBu0PWl+do+VDt3g6sztU7nC2F4gG98wAZCGPRJs97qUsTQASGUyogv1fMewZ6KHEVTbe+i3qb+JYPvQfsFtHVX1wVFjLZ+9t7ps0hxbsyBa13zMDiNkqao+NdEJmPOiDGXjLmGZP4+A1zo9exxyc7jKlpQqONVk2M/jXnWXsnWHOGxLxQSqpOWHR6cTq7nFL5K8+KivNGZvQYohCPn0iJyaBRtzFNpzUS4Kn2TDxY2+pkh4iVYRyKr+8Q/9EKefrihEAReZn4qiRdDR0AUa2ME6xdLohfB/7NIlXAfrrlHj2nR5EaOsqyRro0ogS88oOxttzDzekHao/woCquSinoRQ8B2wfSPUNIJMsWJHpjQbhP+8SRu8IrlWBGYAh/+a0ckLGaqHUGbZJOyWoGWqiG8BI1LxMnm2EWJ2FlY9juzSTJC/fRcotBP59Msk6/dcNbR3JEunTpMTJHfeU9YyfAw6mTK9CvTcuoRoePQE3K8d1PqX/u9rE5dFV9ESyA==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(47076005)(26005)(6512007)(2616005)(6506007)(1076003)(83380400001)(41300700001)(36860700001)(6486002)(6666004)(186003)(42882007)(336012)(83170400001)(478600001)(54906003)(4326008)(82310400005)(40480700001)(7636003)(7596003)(356005)(70206006)(70586007)(316002)(5660300002)(8936002)(8676002)(44832011)(2906002)(15974865002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 13:34:22.2408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff79382-eda9-4992-97b1-08db65c992a1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT101.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716
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

Changes in v3:
Modify fixed-clock instead of introducing nvmem-clock

Changes in v2:
Changed "fixed-clock" into "nvmem-clock" in dts example
Add minItems:1 to nvmem-cell-names

 .../bindings/clock/fixed-clock.yaml           | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/Doc=
umentation/devicetree/bindings/clock/fixed-clock.yaml
index b0a4fb8256e2..23e4df96d3b0 100644
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
@@ -33,6 +35,27 @@ required:
=20
 additionalProperties: false
=20
+if:
+  properties:
+    compatible:
+      contains:
+        const: fixed-clock-nvmem
+
+then:
+  properties:
+    nvmem-cells:
+      maxItems: 2
+      description:
+        Reads clock-frequency and/or clock-accuracy from an NVMEM provider=
 in
+        binary native integer format. The size of the NVMEM cell can be 1,=
 2, 4
+        or 8 bytes. If the contents of the nvmem are all zeroes or all 0xf=
f, the
+        value reverts to the one given in the property.
+
+    nvmem-cell-names:
+      items:
+        - const: clock-frequency
+        - const: clock-accuracy
+
 examples:
   - |
     clock {
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
