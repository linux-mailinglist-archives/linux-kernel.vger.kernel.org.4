Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB866941F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjBMJvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBMJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:51:14 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D9D40E2;
        Mon, 13 Feb 2023 01:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnIcQKpn7T3xWt+hRcVnLgoi4APr4720xJYApFbi2Ns=;
 b=NOy/yveSPRqlKIKTCVbOwcj2iwvqF9KI/kkJQ6XE83yD4tIz/t3EgnWm7ViqLHaQZPLSmQiPu7XD0zJ5Irt9TOb8rOr7CPbpvL/zfNcUeUjOqy5J6GRRtpXp0n8jgKzvTgbDcwBORNUjHqTHmzjSOpGhfqPOCaWAKUrm4oP5LWU=
Received: from FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:92::10)
 by VE1PR08MB5840.eurprd08.prod.outlook.com (2603:10a6:800:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 09:51:08 +0000
Received: from VI1EUR04FT013.eop-eur04.prod.protection.outlook.com
 (2603:10a6:d10:92:cafe::5) by FR2P281CA0039.outlook.office365.com
 (2603:10a6:d10:92::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9 via Frontend
 Transport; Mon, 13 Feb 2023 09:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.74.137.176)
 smtp.mailfrom=wolfvision.net; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=wolfvision.net;
Received-SPF: Pass (protection.outlook.com: domain of wolfvision.net
 designates 13.74.137.176 as permitted sender)
 receiver=protection.outlook.com; client-ip=13.74.137.176;
 helo=eu21-emailsignatures-cloud.codetwo.com; pr=C
Received: from eu21-emailsignatures-cloud.codetwo.com (13.74.137.176) by
 VI1EUR04FT013.mail.protection.outlook.com (10.152.28.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 09:51:07 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.59) by eu21-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 13 Feb 2023 09:51:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6xcSR88LZGbib+fyVe9oK2ORyocb8u/aOA43l2MSU7m1aqCqekxKgxyfndA1z7P2GRJf/+ghZFwuTtVve/bMQ8Bbe9ekmf1drZIPS3RAya1xmDoQFBOoxOCImDP6qQoWYmnSX2enauBzmg2Dcy78Ky7cXAAn4p8Ji2D1vi2IQcMi8QHRkkubIds2tQ8Yj681AFKNKOzT9E7RreaubPynX8Fyhk+FV6BqvMCc9yPW+8LsjqcLRggXMzeakQufENvkFNd2TWsklmTTD2nGRSC+qqiBp5YEEv90GqYttaiJ5mf6nkEsB9u+fJQXxWi/L9Vxd0yNx8QSGiWrv2/3Fu2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLRTZLFoYTJIeoMBTdl40eFAMVBHUNlsT37eQizWmPg=;
 b=Tyo+Y/KvtdcmjuAPeRbDpRHwoSpKHKoQ/NWDtVj2t6Gc4UPeOUbDQgzDXfmKax05nBH2K4Yb6w/7R+lsy6cv6Lo+tqpJ+gQQRYuNUpZ972ScCZHmTGDGcTn0fFnw1V5OdC8wg1B8ZAfogs13QbC5vdpHd6n6fPoyZa3ni5HVzQLOe3rNF1llfr+kvcq9/sIffvOL5fH7/HHPZiG5haX374zBeGFgzNp0Zn8JMwF6tTfH/02Yw12Najyj1IjsNGQLc0i30o5Twssi0OItd4SEOUzFPSlxLqIc0VHJEfTQmFZbK9Tp+lua+VDWboPtPnV6WzRoKgeLvqDQG3/nNrfQ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM9PR08MB6289.eurprd08.prod.outlook.com (2603:10a6:20b:2d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 09:51:03 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1%5]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 09:51:03 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 1/2] rtc: pcf85363: add support for the quartz-load-femtofarads property
Date:   Mon, 13 Feb 2023 10:50:17 +0100
Message-ID: <20230213095018.2255225-2-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230213095018.2255225-1-javier.carrasco@wolfvision.net>
References: <20230213095018.2255225-1-javier.carrasco@wolfvision.net>
 <12dc51e4-622e-4a26-8bde-2795d77ce36e.e0c24246-04d4-485f-8d5f-1cc8fbefd095.f44d6731-6fc0-4ea1-bc6d-c08581fb532e@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0801CA0088.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::32) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM9PR08MB6289:EE_|VI1EUR04FT013:EE_|VE1PR08MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2df714-1362-4494-35d9-08db0da7d494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: motqge3XEMZPltmqWCCippfHVzbRQLn6VOIQu5gZUHOWIxIc1ObkObf7dAjuCltX1HaN0LEAgnfmdoHT9Y/AfD9YNUc8yXSeYrRCpe9fTjeBj70P23vRum3fGsO+xSiJVshelKdO/V+yo9lcNRfVdMQOpD0NHoEt2tlL4ljEPvX8JLmEM8dw0o53YLd7GTLA6kEL4mc4xGQsXuCnkV00JECEEU5x802VtgtyzktZKRaPRUghTRvndDZgrH+xY/PZy/66gYK9RQO8eFDsf6HYeepfbcqtr46wKqfhJMzk4e8nGp3SEXysHit8w4VDzM6ZUGLPahCE5r8l61G0rGYJkrWXtravNMSwFnHYUSKeQlptjInHhWoXme+mRLYKI0KMcVb1215KZSmW+KZ2X4tTGGpsdjrDvk+eudQjhkiZawfSES4uOh3QX98zAxMa689cCPFvXNPPwa/OpJEdE978PQoo5h6i6jciA1w30SnHmDIYNt4PpWZrMMSEQHeh3bOCBTVYV3B4yXmVDXFl0NfzWcTRllhZOlyroVLN+Z53Wl1afiAIky23KrKM3D7fev/qriXwglwYAHgw7NpE95ueBIIDYRcE9G4h0kyoz+A0tGkIYTon1drUgc7SPDDTjo+bikbyoGz+Jdun5gVMrLfhsSCu02wi4OBtKF5EnrYxSb7IxDNMmwDQPfjC+lxJcguAe053IGJ7t6lvDsWRi5XrEA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(136003)(396003)(366004)(376002)(346002)(451199018)(36756003)(44832011)(2906002)(5660300002)(6512007)(83380400001)(26005)(186003)(2616005)(38350700002)(66946007)(38100700002)(4326008)(8676002)(54906003)(316002)(66556008)(8936002)(66476007)(41300700001)(6666004)(478600001)(107886003)(1076003)(86362001)(6506007)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6289
X-CodeTwo-MessageID: 45814cf8-41e0-48ff-846d-3029de24e825.20230213095106@eu21-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR04FT013.eop-eur04.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 787155e9-60ee-4f1c-d370-08db0da7d191
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+gFb4pc/hifMbKYtm2YiiSrKcq9awdDthE91tCdozHnBGh49aQIYmUTYUJuKAcQXuAyP3DxRKsC80SPsfpN5ksPUtl3D/3sBRK4IuuFd33Cq6A42nBtKDVYZO7FlR5I89ThklvP7l8IEF4XtstBSuy1r4CdNhAJHy5n5ACw/xi+Z+ycqy5rhhA+aWgk1uu6ZSE5SxZyJhqqnuLbIHOax3jGR7Fg1YhyM+no42h6MLPHKA58V+KK16YQHgRX7GRenbvxjpH5vMmPtWamphp0sbNOywTYz9rnC7PVNU/7lL98o8IND2iQToSVZrqH+t2jftOAx08PUx6e4uGcCO6i5LCMoMt66XXlfCrH28MkXFXU0PXSh0wejqkPv2S4+/o955kbcmGPZT3cwIn5EskQzYGfycw2Dc/x/bV4VNCS+K1fxHK26alSUbpkVmW7L+26wNJ1ozmCE9DUsTEJQZbS9pq/Gt9ShDqqX2123DxYlAOmmJcbwNQHTYaxSfWWk2ZoPjrEdUNMyAt/5Nm229Auj0r3mdngODSel0YuAYp7Czz8sgRc0u3kizbEpN0aszY1ngWGnOyPazIQKhmS512Z1dDj/kR2Q76nSBx+g08P76LBp1pMiyIfRjy+OvwFNU3xcgOr38YNryPmIt/2aZ9w+dTn0JxHOjG4SdQia5VPD85gBotH2BZoPnczXq7332v7GiT0IHqosa7mdrNn3WpPxg==
X-Forefront-Antispam-Report: CIP:13.74.137.176;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eu21-emailsignatures-cloud.codetwo.com;PTR:eu21-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39830400003)(396003)(451199018)(46966006)(36840700001)(86362001)(36756003)(82310400005)(2906002)(5660300002)(8936002)(44832011)(41300700001)(36860700001)(7636003)(7596003)(83380400001)(356005)(6486002)(478600001)(8676002)(6512007)(186003)(26005)(40480700001)(4326008)(107886003)(316002)(336012)(2616005)(70586007)(54906003)(70206006)(6666004)(6506007)(1076003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:51:07.7271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2df714-1362-4494-35d9-08db0da7d494
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e94ec9da-9183-471e-83b3-51baa8eb804f;Ip=[13.74.137.176];Helo=[eu21-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT013.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quartz oscillator load capacitance of the PCF85263 and PCF85363 can
be adjusted to 6 pF, 7 pF (default) and 12.5 pF with the CL[1:0] bits in
the oscillator control register (address 25h).

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/rtc/rtc-pcf85363.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index c05b722f0060..941f9264cf0a 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -101,6 +101,10 @@
 #define PIN_IO_INTA_OUT	2
 #define PIN_IO_INTA_HIZ	3
=20
+#define OSC_CAP_SEL	GENMASK(1, 0)
+#define OSC_CAP_6000	0x01
+#define OSC_CAP_12500	0x02
+
 #define STOP_EN_STOP	BIT(0)
=20
 #define RESET_CPR	0xa4
@@ -117,6 +121,32 @@ struct pcf85x63_config {
 	unsigned int num_nvram;
 };
=20
+static int pcf85363_load_capacitance(struct pcf85363 *pcf85363, struct dev=
ice_node *node)
+{
+	u32 load =3D 7000;
+	u8 value =3D 0;
+
+	of_property_read_u32(node, "quartz-load-femtofarads", &load);
+
+	switch (load) {
+	default:
+		dev_warn(&pcf85363->rtc->dev, "Unknown quartz-load-femtofarads value: %d=
. Assuming 7000",
+			 load);
+		fallthrough;
+	case 7000:
+		break;
+	case 6000:
+		value |=3D OSC_CAP_6000;
+		break;
+	case 12500:
+		value |=3D OSC_CAP_12500;
+		break;
+	}
+
+	return regmap_update_bits(pcf85363->regmap, CTRL_OSCILLATOR,
+				  OSC_CAP_SEL, value);
+}
+
 static int pcf85363_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pcf85363 *pcf85363 =3D dev_get_drvdata(dev);
@@ -372,7 +402,7 @@ static int pcf85363_probe(struct i2c_client *client)
 			.reg_write =3D pcf85363_nvram_write,
 		},
 	};
-	int ret, i;
+	int ret, i, err;
=20
 	if (data)
 		config =3D data;
@@ -394,6 +424,11 @@ static int pcf85363_probe(struct i2c_client *client)
 	if (IS_ERR(pcf85363->rtc))
 		return PTR_ERR(pcf85363->rtc);
=20
+	err =3D pcf85363_load_capacitance(pcf85363, client->dev.of_node);
+	if (err < 0)
+		dev_warn(&client->dev, "failed to set xtal load capacitance: %d",
+			 err);
+
 	pcf85363->rtc->ops =3D &rtc_ops;
 	pcf85363->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
 	pcf85363->rtc->range_max =3D RTC_TIMESTAMP_END_2099;
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
