Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6725A745791
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjGCIp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGCIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:45:54 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E49E41;
        Mon,  3 Jul 2023 01:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPyxUB9FZIvENDpHXoEjeN9cGVZxJwmnGT8BIloWcTpkP87fDLyRzNVOUnP4CeQamveHB04BQPcaF/KZty3BiggLFSLg0vutoSVTw1Dd57a/dg0SfYvGEH1Nnao1KKJfDd8/wgbl9fUq+afMhUS6loWzppXNK6DJCs2kAqq3uwvrtXHzO/nZnm7nNgHkVRwivHfc9ux7zrLT8ghsrNF1pUH1y3cO1/tfP7OAWsdI7lwuii/ry99nMAoWhNlm4IGPmmnnoqZgG7Xp+lVAyB2LDX5+wNSSAMtZSIU7vBrvRty4pJqeTGA27WjEgQFBHa3dQNZD+yk3kzahOpX+DasJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCiik17iP7YL5rXLPuBEnLyYsobn0Usn312aI0kYPnM=;
 b=MkiaOpzAttKwPPlZ8KElnh84uBQ8N7fBwJWapxkKOA9C7U55bQtrn6wnzZQzny9QkjibrcZT1MgUwKJe1g43yG5srE2eWls8zQsXegPBxoI4RK7ZLIGEfygNvNrZpF8CnNKwBHGpLgucSpjiwQmKvTeYthk/G9rQUfBxmVXZPN9IhBi7URqnjESCnnPPpeBnxUx+Nkl5s0D2GAx3DCh8Qn30cIoLB6Owk2EafxYEZv4YdygLWiUmjSW8/YvBd7z/7PDw9GsPsTqwpiqmpYsZIvPk/XH/5briW62e73ugLyorfSl8WFAsZoz+yPrCxLhoWXi8naKMXKycEC2u3Qn2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCiik17iP7YL5rXLPuBEnLyYsobn0Usn312aI0kYPnM=;
 b=yUUyY5BEPbP7s7R4s65ncgg6YIchUbIEp7zwOLnIMdKlo5R2KbepmTCj98p+Le1c4BQexjIsyVtwVrfK2MFATTwDYlXtIf2Ay9uaaVb7QiVBQuwz6xaOYD69pZuBmBnvKqm//VuAHE0rqCA1FIcWlY+HHK1uRHuHvKaYOg0zkjw4GxzZJDu2soKjLQmsQkxwSApu0FHnYs2gR6zifnPXQ9fkm4W+8R6rya+lVpI7VVveOM4sI81vu/6uXXG0IHk/IYbfs6GTGfAX4W223W3QJCSSfxF97CXyTLGVgm6/Ghyw5KWwF0pO0OWFtiR2JJvARxgt/mnhxfFrCcZJsOmIHg==
Received: from FR0P281CA0127.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:97::8) by
 AS8PR04MB7912.eurprd04.prod.outlook.com (2603:10a6:20b:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 08:45:47 +0000
Received: from VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:97:cafe::1b) by FR0P281CA0127.outlook.office365.com
 (2603:10a6:d10:97::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17 via Frontend
 Transport; Mon, 3 Jul 2023 08:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 VE1EUR01FT059.mail.protection.outlook.com (10.152.3.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.13 via Frontend Transport; Mon, 3 Jul 2023 08:45:46 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.104) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 03 Jul 2023 08:45:45 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM7PR04MB6855.eurprd04.prod.outlook.com (2603:10a6:20b:dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 08:45:43 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 08:45:43 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: Input: exc3000 - Support power supply regulators
Date:   Mon, 3 Jul 2023 10:45:35 +0200
Message-ID: <20230703084536.8429-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:208:55::41) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM7PR04MB6855:EE_|VE1EUR01FT059:EE_|AS8PR04MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7702a9-1681-417c-caab-08db7ba1e54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UNLdJd9hEbj6gFJEChnfvJo6UfJDjHMtX0k7rTbdsJTi/SI+n9RFPPoLqCP2DK/Zsc7VuGdVLT4qvul1t8yN+SyVxhfGSEWwNRrsT07EPwgTtHEyZogv4CzzcWpGRHonSvPYyRRhurjVrFOkpQ6IoolyB+C7knepw58EMgNdgL69HGF36J0iIYNPa5z9k0hdg5AKz0ScNT+sFpG6BrjB2/C02tt3SMXjhkg8y7xLksxX6kljO+1fsMkfEgMMhIZfBGBXEZ+9Uv+w+MzK3bClpGlyHhQSvl2vGqAAPscpYe63f5Kkr/8o35MKa0hHporcbq/ELFCcUwI0bspmcGbGG3fHVKhlKxBFLUwdL1ipKwCa81E51MnyPNbvxtoVFFejz7JBHbDRDZ1L6df2OyVxX9G3WjktUdfdmJU4NEPQYEFOcmL4QjjncRwjs0G/geeKEPtYe4W0Amm9D8KosDklx+F3QsEUD8y/UdVauLexlFytdCg8ukwzBgYABBp+XBCwox1wcAGoVxU+kh+v1SiP0eFB33VQlBA7mGW8HutsDsVLLBY2L0sAcXX3eEh/FdBwEQpGvtg3DZ5rBeGlWwkb2wa6CUeEyauaHmUGcwM/f5zAkqmQ4xXD3Ctp2x788+K1
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39830400003)(396003)(376002)(136003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6512007)(6506007)(2616005)(186003)(42882007)(38350700002)(38100700002)(54906003)(66556008)(66946007)(4326008)(66476007)(52116002)(6486002)(83170400001)(316002)(5660300002)(8676002)(8936002)(44832011)(4744005)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6855
X-CodeTwo-MessageID: 19ed02e0-bb4e-4462-a2a0-92eb77d2344d.20230703084545@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.056940e6-2612-4bc3-a2f6-33121e64866d@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5a1df237-e6e2-49f6-0770-08db7ba1e315
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pp40PYH+nZFPfuLN0TEVyqW/KEJaTbdQkSDchtRQ0KvEdMcx0anywuGcx9jzIis8Lmi7/jaYOSMYCjnNjw62DFVOLcwbDxqztEbAGJyTw8aG47L19F98xxGk2kDbyKf4a86zGTSnF9NZgMy19tUpuohd6G/zdEgBl1/ABkD/sdHZYs0fTCifnqWxYT5wotiqdkQLMrWb4oubzvPTzNWn69Xhf8nfJihlA/ALtRcnx7yeM5lqHyj4y79f3woZGKj5jmITOYol4lSwr3mS5Hp/wUr+NSKurQMFOeFCWAALCgtODPwe/VKh5IEdooLuTJOrB8x7wdUTv93CglScAxVgxTx3WGtFp+tiKNEOlc8sm9t20pXNmeWacWpHoNZtS597v4W9f/5pjUeiYosuQP8+SOTNjN/77XfpDHwwwadkJ+3dLEyIeOgDtpSYa0vPUCdJPToUwMcCzjy1E4KEzgdbhAh8bYKQ/zh0/pygpQzzf2AKrisgfTPShyGuk9R3lBMxBmq+Yuoys1tzUZA07iAn18v9M/nBKxn7GrNOEglskJCegU/DI2mkDaYgzqvv2AcRy/2bXzt/0iMXlEi9SuceyF2ILWH2iACwpXnQPwxSLBhiK6iPLWRPTYm1qUxPGivPgYwY+y8EKYeorEMi1Xqz+KhchAZZhVgdbv9n31esWFEeGAdRbuUvHR86fJ7J6kcA
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(396003)(376002)(136003)(346002)(451199021)(36840700001)(46966006)(83170400001)(6666004)(478600001)(336012)(36860700001)(47076005)(6512007)(6486002)(7636003)(356005)(7596003)(6506007)(70586007)(70206006)(316002)(26005)(186003)(42882007)(1076003)(54906003)(4326008)(2616005)(5660300002)(8676002)(8936002)(44832011)(2906002)(41300700001)(40480700001)(15974865002)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 08:45:46.8501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7702a9-1681-417c-caab-08db7ba1e54f
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7912
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power supply regulator support to the exc3000 devices.
This provides the devicetree bindings.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 .../devicetree/bindings/input/touchscreen/eeti,exc3000.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc30=
00.yaml b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.=
yaml
index 007adbc89c14..9dc25d30a0a8 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
@@ -24,6 +24,8 @@ properties:
     maxItems: 1
   reset-gpios:
     maxItems: 1
+  vdd-supply:
+    description: Power supply regulator for the chip
   touchscreen-size-x: true
   touchscreen-size-y: true
   touchscreen-inverted-x: true
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
