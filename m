Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976D66941F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjBMJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjBMJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:51:16 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966093D5;
        Mon, 13 Feb 2023 01:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcKu++/WYRCaRYaG4luksm9gfDkx9bsPHBqlL6UlHzo=;
 b=u2cvK2JNeR+i7vptKcfBWvk08e2RVJKQWLEubcBZOuoZc/C2ywgj4mOYotf1GY4j2amVv/mWzRtN6b0U/o5Bz19axPpOfByKi0h7IO73fPwT+wcKOAAqLx+JuT2hEXyxFop5upewY9KYMXVbm/QETtQu7w9pLDpzS8+0MV0KrRE=
Received: from OS6P279CA0142.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3a::16)
 by GV1PR08MB7826.eurprd08.prod.outlook.com (2603:10a6:150:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 09:51:10 +0000
Received: from HE1EUR04FT029.eop-eur04.prod.protection.outlook.com
 (2603:10a6:e10:3a:cafe::3c) by OS6P279CA0142.outlook.office365.com
 (2603:10a6:e10:3a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 09:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.74.137.176)
 smtp.mailfrom=wolfvision.net; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=wolfvision.net;
Received-SPF: Pass (protection.outlook.com: domain of wolfvision.net
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 HE1EUR04FT029.mail.protection.outlook.com (10.152.27.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 09:51:09 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.59) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 13 Feb 2023 09:51:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0jSBs6ZhiP4WolN4/weRM40WNrfMRjk/8cuJTIjkIqQRgiXvpqsIOAeG1hmX14acJxnPwr9XmMnr7UkHXL5nMKXM4bY5Fr0ytZc/3BQlmB/hsqOOIkkRmPSRrexMOpFCye0r7PBt5MJjFH4H2R9ktoHQpr5QcSP8J1u7irII2AlyEVzo7GqmmhiYYiFxOtrDz7UQpRkhsuOCTRgdGaAoYEizruqWrnJ13xZKLU76V0eJBE5OuVXqdSTc05uBekc2U1kMrnxCMw5m2AQn789TGaBQPPNPEYuk0gUq8Y/pd8/KloA4ILs9iA/jkkmdY6WRZNEcgav3PzMpw/XRB6LOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZxtbqk2CgOuhrQEZS6c3ZhurL42v7Q/2zIJ4SReGgU=;
 b=oAJDgZTtqRtgTjd3GfNb6cKL+ayOWt8hVzCppeBh+pfllPCYvHF4wF2RuH26xCOFChYl8ensenBi2Imgd7dFfBv9ntZxdGGS9elCcrXBRaPonCxjuTaRyDwf9zbof6FjWsVVpV4ifniKNJM4rvKaRz00l60X9AHCSAeqPlPkfhne+1a06LB+JwacuGVp5ujMlHWeohZrZXZMMaEKdyXR5qLqBUUit7rTzQA8DTXQP3ocEl/Ab3CZmb/mx/aIUwsbXXErdmmczhITXUlNr2P3/PSD0PQzHiisX1jMumQsFzm2p0eTPgaYPb3pH1lnV3Imtz0qBK4liVI0KrgKE9bSlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM9PR08MB6289.eurprd08.prod.outlook.com (2603:10a6:20b:2d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 09:51:04 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1%5]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 09:51:04 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add quartz-load-femtofarads for pcf85263 and pcf85363
Date:   Mon, 13 Feb 2023 10:50:18 +0100
Message-ID: <20230213095018.2255225-3-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230213095018.2255225-1-javier.carrasco@wolfvision.net>
References: <20230213095018.2255225-1-javier.carrasco@wolfvision.net>
 <12dc51e4-622e-4a26-8bde-2795d77ce36e.e0c24246-04d4-485f-8d5f-1cc8fbefd095.f8cc75cd-465e-4339-8415-7d994963b841@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0801CA0088.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::32) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM9PR08MB6289:EE_|HE1EUR04FT029:EE_|GV1PR08MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8240c3-80e3-4bd2-6c1c-08db0da7d5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: FZJnrMX4EDTuTmTRSFOVd6mLUGqWigzfm+ox+gbeATK67JM4KDGfflOEKl4IhzBXr0glWIyvVv3TTGvozwhUEY1moDZBz444qZ+1w1QyLiD6p7viT6uvuL2GUkBnUiLm/REky5LKLL9QBzpsRJTuwuXrzhPAh3Dzab9SEGufNvkv32eExTp6P24IWJb1QlQu4bk30WA7XSUFm2YRDerwglXbKPCBukyLA9hm9PJeGB8jw1FdrdrD3UX1YHsEM3DtrYqzcqAOZbYUwebBVxBQrO4XzehNDf9e3fkoyidzlqfSBaEGASrCxQnz81hA1TsFhCVbdqGyGCsXRASa20U6DzVDQPOW4+FIGD8RXziCLWy+xHD8+4IcaYs68j0fy3jcVczWvWBlpL9nCHj0Ch+l+gyafVknTn0JlARkFvsn1BjyOfTuRmVEN4Bzn1jnnftiMYszT4ES4pNBWH7/X2UmfT7tkxuE5s0jNqAE23uDO/qtN7NYBD0oSxpxmXI7Rl+jDBi1cqOEDEWDSS20tVpf/8CcWuOeDotwKBO/aPWvxAplT3ewmMG8/9I7Hq7sHe+rSNjiCjGGbe8ilaXcff5i39BkJnPEN0QXgkVDHPOonFhAd1UNnmnJgZnxlZ45nxStLxzrHdt1Vz8b4HRwK/FJAuJuk0dNn4sMTlbcgD6oa6rtqtB2I6iE94nhjpCpFybR6FYvgZmvm7jQKvMZfVxQ7w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(136003)(396003)(366004)(376002)(346002)(451199018)(36756003)(44832011)(2906002)(5660300002)(6512007)(83380400001)(26005)(186003)(2616005)(38350700002)(66946007)(38100700002)(4326008)(8676002)(54906003)(316002)(66556008)(8936002)(66476007)(41300700001)(6666004)(478600001)(107886003)(1076003)(86362001)(6506007)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6289
X-CodeTwo-MessageID: 05539efd-bca4-460c-ad45-8556d7e6f79b.20230213095107@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR04FT029.eop-eur04.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ef8a78a4-c8b3-4cc3-7d84-08db0da7d1ff
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8ZDKTdzyskfeGHWqFeCdKODx5+rvvTCEbvK12kZwKLfU6/slqDv9FhQGU3rm5kD+M4bwr1uI71mhOhStUYxOR72yo8EHkHFGx+szYxAvDoRSU1YXqf+2Am5kb3I0VFrapUT4xoEpQr1yfzprVZtDr3nBJ9SNaW/I2Gw729i/Zy5UhVUg/jr6AR/6X5fV5VcA/ddnm5wfRrIJ9nkwcPLDOPK0GWVEvazI0jN11mCVizVKMkp8mRCacaWnUITQM6kwZdbmkLW0gazzkwmZTQnZXqs+cdnjOv9fagXUHzSfVc9pTC90dS6auyttzes1SV4X/iGQGvzZTCeZG9j1MBOzDwJsEAJuMq121u3u4/QVCRhTdPtb28lUptbjVx3PwWYVTtZppS1A8WYYBAFuHsRD47IxMJ5nsTv5xbot4GxFOcIlBVpqVF2vILidFgAvo1QIlNgkNW+0xxIzCV5du31UZ1XhCgfegLAb+BYQkMv+gORFzEudqsE3eNvkSthPGgJjZFbia9DYk7JaBD+FSUSAf8+WhBSy6UiZgzyT8YZhx6sMWTmROmq3KMPR9kYXQd/KRq/iDFHiihFNd70im7n9AWzMsel5pDHPP1MF8NnyPQR4d1ctxuOYDadoigIS3sIVwMMLYDvLfnZG4yL7sYE+OW9FdsOU78kdhkwKQCb0hQtC8HeO1rrTnnpC8YVHgTAdjB/nc4V3QPZYWepHorMxw==
X-Forefront-Antispam-Report: CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39850400004)(451199018)(46966006)(36840700001)(186003)(2906002)(6512007)(26005)(356005)(478600001)(86362001)(82740400003)(6506007)(1076003)(2616005)(5660300002)(7636003)(7596003)(44832011)(107886003)(36860700001)(6666004)(8936002)(41300700001)(316002)(6486002)(336012)(82310400005)(8676002)(70206006)(36756003)(70586007)(4326008)(83380400001)(40480700001)(47076005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:51:09.5146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8240c3-80e3-4bd2-6c1c-08db0da7d5ba
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e94ec9da-9183-471e-83b3-51baa8eb804f;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR04FT029.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7826
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These RTCs are handled by the pcf85363 device driver, which now supports
the quartz-load-femtofarads property.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../devicetree/bindings/rtc/nxp,pcf8563.yaml  | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml b/Docum=
entation/devicetree/bindings/rtc/nxp,pcf8563.yaml
index a98b72752349..aac7f7565ba7 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
+++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
@@ -9,9 +9,6 @@ title: Philips PCF8563/Epson RTC8564 Real Time Clock
 maintainers:
   - Alexandre Belloni <alexandre.belloni@bootlin.com>
=20
-allOf:
-  - $ref: rtc.yaml#
-
 properties:
   compatible:
     enum:
@@ -37,6 +34,23 @@ properties:
   start-year: true
   wakeup-source: true
=20
+allOf:
+  - $ref: rtc.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nxp,pcf85263
+              - nxp,pcf85363
+    then:
+      properties:
+        quartz-load-femtofarads:
+          description:
+            The capacitive load of the quartz(x-tal).
+          enum: [6000, 7000, 12500]
+          default: 7000
+
 required:
   - compatible
   - reg
--=20
2.37.2


Javier Carrasco =0A=
Research and Development=0A=
=0A=
Wolfvision GmbH =0A=
Oberes Ried 14 | 6833 Klaus | Austria =0A=
Tel: +43 5523 52250 <tel:+43552352250> | Mail: javier.carrasco@wolfvision.n=
et <mailto:javier.carrasco@wolfvision.net>=0A=
=0A=
Website: wolfvision.com <www.wolfvision.com> =0A=
Firmenbuch / Commercial Register: FN283521v Feldkirch/Austria=0A=
=0A=
