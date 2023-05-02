Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D7D6F3D26
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjEBFzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBFzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:55:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1446F40DD;
        Mon,  1 May 2023 22:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/9F5TIVnEa3jtNau3pDgdejErcb9qm0NtMIuESjm4I=;
 b=NeGdQbpnllQg9x2kkuYIFSeE6g4ePmp0UiwzvnuMU03NGpezuHuCpTi6EpXSoAwbDi4iAjXPfjafF1tugxbLwKTR5H3X4eJaDEwqCPeNLxcFGb1IdSDvsORBWt9SK4AheFw7XvCVWIO260BeqI5YqkP+GPT7LwsVfc1gRdNDGQIbcL0bmZ8P2j+svtmfdfNw1H1nvRVgoeD0j5k510btrCsMlKe28jd1tfXCrrce1q6lyldzSkelvagBfiB08uWuZvk4BgUpTizILlXQxuz4K79l7PudyZIpOHlf80teVbZbel1oFqlceFsZ1MaaBXMtG8NK7JORH/PV8JFM6q21GQ==
Received: from GV3P280CA0087.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::14) by
 AM9PR04MB8825.eurprd04.prod.outlook.com (2603:10a6:20b:408::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.31; Tue, 2 May 2023 05:55:10 +0000
Received: from HE1EUR01FT012.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a::4) by GV3P280CA0087.outlook.office365.com
 (2603:10a6:150:a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 05:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 HE1EUR01FT012.mail.protection.outlook.com (10.152.0.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 05:55:09 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.57) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 02 May 2023 05:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEGdH914PkaQQ2+ZjlKt9k1Ho02QwtnYNzt2ZJuLmjEn8dApbLFZuadaHYRr17K9QzGfRogAVcVWEeMGX1+VKgsG3VkDi8MjhBJibYz63Irw/HUjoQQOWLSt4tLJa8+vGzviuciTkC1kLLcBLcaToeXHVGVaoxCPcCQphHY8z4gbRyKVkMWaoFQ9TNbSEKGT42DQufoAm27hb4NCBnFmeGwrLkNAMscitqsbkktFDwLshU7n0dqub+gbkhGk6bRC98TyvZkcfPBUqr4TELaiN6MNGMNdfHVSG5xxwPyGueCG8xgGjEldrWSeA6KYkPPGGUfIwApsQuG+/LJQOvtPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=937BpYJivebPkn30MZYJH7UHEPC594LppC53nSjG9yQ=;
 b=mtEZJlt1wqqXKAsclFQ2tHHCaSYwfqxPOQ3c/b4uWwYYtW7b2/j7dZ0pJuCbMnRS8wg8AYGZzu2T/7HkMkJI+VdRB07qV1tfgNlFFyL3NRoYG2gMYKmJ/2sumB45lGFUDXuVPiEQemv4qMX3RrbINQYyM4NpMdh/FrL2A26CRDVXZzopYxkbuWGQkAwCBhbSto8VeH2zCbxG7/rDgXxjTD3mt3YepRNAtLIy8nEntfeYkLnK0RrdVZOZ0DEzqYP095cBKVY0dAggOmS1QlCZxSTArt6iOxCVRRXNJNu6I4JtPuOr/O8QYzO1gZCuLXihvUsfgo1a9dS6kKOJjc5XDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by PAXPR04MB8442.eurprd04.prod.outlook.com (2603:10a6:102:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Tue, 2 May
 2023 05:55:05 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f926:988f:ba30:342e]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::f926:988f:ba30:342e%3]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 05:55:05 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-rtc@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: pcf85363: Allow to wake up system without IRQ
Date:   Tue, 2 May 2023 07:54:58 +0200
Message-ID: <20230502055458.11004-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::8) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|PAXPR04MB8442:EE_|HE1EUR01FT012:EE_|AM9PR04MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e15be54-1882-4c3f-e4bf-08db4ad1c9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gcSkQK8uDbdrzAjS1jsSoXIRN2dzo0qsoNtQffVn9Lge779c4GOz3/dylO2nC9IDkpQK415St7FCLwQAVawL4+Ze1bBGQ74oqvceGMNgbYGGiB6fZtH+ZwtI4J3nYtr3aKgodX24UykQiCVn/ZtGTEWf5pDHiXwwHQVNXh4e11ZAoJ3n1h4o9fIgHIQ/zQw+SgJEYpAwU0oxSm9LkAm6E9RixQQhvTtVU1gwLxVTzyU5FYEuJBw2Qk7zYLYOrzcMfpa+peNeaP/MOerdOWjj71S7h5kY5sw5mA9l551VrkHRP8riSFrQExc9GoEzCAQRePpdza24jXusbZUSeAvjJz/p9DgPUZjokfvSsjBFgVjBL5A83hX9EmhRcGbfRBR3bWQ7QTzySLKPFx+zOvSyIHuHE+bKakv6vCh+x6RM657rqTqSTY+eqoq6nC64ymtbXfjOv+KkUBs8SuYgsDqnvVKOepcdaIezxG+/xZyQ0q8LbjqQims4WYiWy7hAf71KdnIzV6SL9LqoDJsQPgzhiOXw7u9+k7Ib10jk/AR61kQ30/DcNSsKSeFvJpvDMXvgGOYYGLfy4IaRJTPxoZs8h5IrMwpV9XJgXLHaY0ejWwWPfGUDopzMPbh8Cw1/5SUo
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(346002)(376002)(136003)(366004)(451199021)(6486002)(52116002)(36756003)(38100700002)(38350700002)(83170400001)(83380400001)(316002)(478600001)(186003)(66476007)(6512007)(1076003)(2906002)(26005)(6666004)(44832011)(6506007)(8676002)(66946007)(4326008)(6916009)(5660300002)(66556008)(8936002)(54906003)(41300700001)(42882007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8442
X-CodeTwo-MessageID: f494cfcd-3168-468f-899f-8e11873885d0.20230502055508@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.eeedf5db-4013-4c3b-be1c-1121df58f897@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT012.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 63950d9f-a5ab-490f-571b-08db4ad1c6d1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Si2r2lYisH/FwCse+hDtytdsNcmfvncgujDwOqo9ayC/ksoX8agia1C03Rt+tBEodLB5WTu46qJYoRYnG3mM5x1oyEtwCoPGDMwA8fHbQaywlythe/5tw+u8IiN9lsULZAYrEAaRdzLlRDTKMMotdDE/QVsyFYzXbcxfxYQVKvzM8AfKg9KdYIOzN20eFL2wmv/Ehs8abzzD0Dcqb4gho1gLw4iJk+1b1S39DrLVVFoJ/FBWfDj4rZnf3yZSs7Q9rt349i7BCGJhw6eWTz2zXB20IoTg5WJGAeHgfr+xWYCaUN0So12RoSpGjKMQnwDcd3jw3Ix9ytLwcJdEGsSI7rybVxK12DulL3zU25CHuzdsgc9rnjLDL5FkNSW3bcClGKVlOkEJ7M5TzBBHp/dReRvQPuBtBwdOeRiGCVCcdCql+AiuEPGfOcSJmhjZ2qj89DURJ9FJvvj20CCTmOHPkfZAYZVtVyRHJ4FasEXhpWVwHJCxqReJRSvzKXygx5va3RB62q4OIefmrAQFwKEdiMZIv72uGxniXL2KmOWQ66n0qEtojoX3Kq2z4UKmvxlO2+1jkFkDIuxc8FEWK0HmFoePl5pP3OG7poRPWCnkA7UbBGEE8aQv/bY2o8ayCjLH3NDnVCX6mPd9aXk6NfiefwWG03FjUddPjB1lPEV/RBY=
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39840400004)(346002)(136003)(451199021)(46966006)(36840700001)(82310400005)(7636003)(7596003)(356005)(6486002)(316002)(4326008)(6916009)(54906003)(36756003)(6666004)(5660300002)(478600001)(70206006)(41300700001)(70586007)(83170400001)(36860700001)(40480700001)(6506007)(186003)(1076003)(26005)(42882007)(47076005)(336012)(2616005)(15974865002)(44832011)(2906002)(8676002)(8936002)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 05:55:09.6837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e15be54-1882-4c3f-e4bf-08db4ad1c9da
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT012.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8825
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When wakeup-source is set in the devicetree, set up the device for
using the output as interrupt instead of clock. This is similar to
how other RTC devices handle this.

This allows the clock chip to turn on the board when wired to do
so in hardware.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 drivers/rtc/rtc-pcf85363.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 8958eadf1c3e..b1543bcdc530 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -434,23 +434,26 @@ static int pcf85363_probe(struct i2c_client *client)
 	pcf85363->rtc->range_max =3D RTC_TIMESTAMP_END_2099;
 	clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
=20
+	if (client->irq > 0 || device_property_read_bool(&client->dev,
+							 "wakeup-source")) {
+		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
+		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
+				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
+		device_init_wakeup(&client->dev, true);
+		set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
+	}
+
 	if (client->irq > 0) {
 		unsigned long irqflags =3D IRQF_TRIGGER_LOW;
=20
 		if (dev_fwnode(&client->dev))
 			irqflags =3D 0;
-
-		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
-		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
-				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
 		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, pcf85363_rtc_handle_irq,
 						irqflags | IRQF_ONESHOT,
 						"pcf85363", client);
 		if (ret)
-			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
-		else
-			set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
+			dev_warn(&client->dev, "unable to request IRQ, alarm not functional\n")=
;
 	}
=20
 	ret =3D devm_rtc_register_device(pcf85363->rtc);
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
