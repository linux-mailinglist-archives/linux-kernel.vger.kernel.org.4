Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6752374B185
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjGGNLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjGGNLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:11:04 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE9F1FF0;
        Fri,  7 Jul 2023 06:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2QOjgIliM7itAwZNMcgE6kNyiRIXsjIw3EWSkHjF+FnIrU/7jT7pZbD8BmcF7hhDbpkphoSMu0BF6FwhFm6/fL3ENm6Ve4hLcHr8nAnNvcf06LpXutjPhXCJJjaAgtwaO3GF2ohQIw7/wzpjA377QUctLRm/ReDfWsbgH9MokwgsoVFsBDC2hXJgKu9vcWOJxU6ji7aRWuuyLZIyoeO2xJT7gYpQJov4biQFyBUbbeb256b0KzO+08dKz2tSpdo30LQ8Nl66zb/GDMSsLSUxwoSCsNwkIZNs/n65RFrKLZY058+0eCNEXJqVz1WRHNwFrycJJE8OE+fcD3zgKZH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVgvWbkOF/IFTQLpsubIH02XoZ8iTo+ESZhSIIaVwxc=;
 b=F3eTD94GMZ1W9lRyb65JADQPTPbhN3UdU4SSRaT60j5R6Tm70hHsc9c5hBD3pFiJc22qZvIee27FzKovSOVpA6RT4wOJWdgahT1ygp/Rg75aW4vlw2/7O8heCSJOms+5dv2WrbRnk1F3XNPlYIYyNwerd9srK+gToDRdEwlBf5/dkUs1oQ0RHxAs7zNGNcfJWlwejHaPDfb0Xr3BMlrpoOEEd4FRjZ2hWBIEh8hMJ5NWcXj/vHvpIJ+hWwBN7nShqnZAM9e++C40gVMBY7ivk0cMvQK+HrDtutJakxObwkr32GvE9KAvWVy4rmmlTMtEXWcMywj40YB+ByW0OlYJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVgvWbkOF/IFTQLpsubIH02XoZ8iTo+ESZhSIIaVwxc=;
 b=MTHYILH1/Oi0p1UtRchnP1wnS2j6iJjc/k26UNn2SaWbvFVGJfSOfs1GGMQceboya1zPHv7qz94HdhduHty1B5/jNfjVwm8X0CEiQ6TUulHZYNDBT1WYtmR5Ddd1Ri3Fl3ZL0WGbXsMN/Z9qXCuQ7U1S+u6yjwPfYu2QRXLhaohA3l9At/lN2Qy6ZNrDW67xX6Sux+DDZSnGRLFzQcnkiE73PFmWtqphziBDkqxnzd+gUMgJW5pLyfeiqFXsC/nzR9ckUHCpIcw1vhhojmFiiacLQoiWDPlM1gTFB+n506wFsU9rNalM9utqru09dNEYG+JTaBAzspOKvigo0hLDzQ==
Received: from OS6P279CA0179.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:38::17)
 by AM9PR04MB8524.eurprd04.prod.outlook.com (2603:10a6:20b:433::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 13:10:57 +0000
Received: from HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:38:cafe::83) by OS6P279CA0179.outlook.office365.com
 (2603:10a6:e10:38::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 13:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 HE1EUR01FT043.mail.protection.outlook.com (10.152.0.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.13 via Frontend Transport; Fri, 7 Jul 2023 13:10:57 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.42) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 07 Jul 2023 13:10:56 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AS8PR04MB8817.eurprd04.prod.outlook.com (2603:10a6:20b:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 13:10:52 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 13:10:52 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Input: exc3000 - Support power supply regulators
Date:   Fri, 7 Jul 2023 15:10:42 +0200
Message-ID: <20230707131042.10795-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230707131042.10795-1-mike.looijmans@topic.nl>
References: <20230707131042.10795-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.e9863e93-aebd-4f13-b014-08dab638277d@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::19) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AS8PR04MB8817:EE_|HE1EUR01FT043:EE_|AM9PR04MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: b112cde5-bed6-4676-4505-08db7eeb9a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: X2n2s8PiEkgZLi2Qw6TwHMnopaRnt0zA1sCY4tPxdYwSPl3ql3gnHynUmqC2ZwSAS/HuxA1xEjCE55m3IRhNqWqgya0nMHQfjTWsMk1rkCftQ/4H0Driej659mV8zwS9uYr7En6saSpN4H1WDRtU+2W7eS/55YQ2UMS1zYq9lyLP4uUDJo0iN5pU3gTJ9d5UpS4R0RLvw48G9PT8Mbzp0Dy+fdxWr/R6bSE5KE2b6RTElNy+6g9Ihee8+0ZZKK4lbRe7GiaS5CW8W0ICQ5h9C0tmxB6dOm8fj8COpJtmjn5cUKX7L5xs5uEsD2E0+W7RajJFASLANl5dw99VeKwHkRZ7NDfJuYvWb/ONHWdnvYVNdhp24PZPMTeEObPHvzVhJhFOWs6KRYHktXZZxVfqO6JHc/7/g0ao6rfq7DSmxb1h24GvrwlrfafB0DV5479AFeqy1b4loaAaWspFdm4gYOFaNH9MevQ4A6XH8oVixrtTMH9l0zU0xx7IW9s3AIh3XhgPC0qTvevOYpr+B4RTFmNhr6++ME1VlB0mNFLf2dg3hjJb65l67zNJ1ktBCsQsfqCfcZvq4wyVS2K5UHju5+ZGyVb1DpPaqMz3AM80OD5nPUCxr9zlrmHX8+tIx5Bk
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(366004)(346002)(376002)(136003)(451199021)(6486002)(6666004)(52116002)(6512007)(42882007)(186003)(6506007)(1076003)(26005)(83380400001)(36756003)(2616005)(38350700002)(38100700002)(83170400001)(66556008)(66476007)(66946007)(4326008)(44832011)(316002)(2906002)(8936002)(8676002)(5660300002)(41300700001)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8817
X-CodeTwo-MessageID: f70c9e22-1b55-4047-9e8f-d0ed698bd164.20230707131055@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6f31972c-e10b-49f1-e944-08db7eeb961d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3Rx3djhfBd8IUfAGV8AzbGy4z04FiIMULp/5uGoa3bD0rTmGVxq7IwB83+jA4vzJYgq3AGSi+CPue1G4mOICN5PJfGQvziTSsP0abkEmoWrmtZveLqkmNIboTlvDMusq18jnE4Q1bDwDLKgTUPt8C4jQByT0CIy+Y7KTh3k6J0hBY0wtqAPsS8Bwk48JW7MuBaTx2abun1njX1B2YcbTVCfsfFtjyl4VHuxJdTFGRJbe4ju+zF15fFHUzKtpAcyHJMG5cHLCddGBaybqDH+ZV/SFXGAR5WJYAzaA6xB7yslH22bUX6mI9petKyW3MeZt4LfgYdgAQMjSuWhaXMInB4uv+tESm3EuO3XdLSidkBVgL9PzEQLAT9x9lMv/ew/pWZbED0F1u6t2MxNUwXTWT06LCqhZ1uTrvetPGwnyl0zDxcC6x+tWyokqaHHuShFOxPUOaqBsc1XtuT9j/6iHpsm2C1omDOK6GeEuE+CPIpBQNq/c2FXdAV2nIQLFm0XpxqhqzQhOc3WdF68fnyYF+u7xZWaE8MqpngWg/U5Uta/ZkH/4QdIPIDIBpOzPN1plFzAbh+VLgZgQg7T14UEC2opBI/VZ7iQzY7KhVGD9NoKND2PWzfnl+iZLYDbF5hB/E5D5FYthA6rGXcVVHtKEwNLzdhgxXTzZjygtAdi5s+DdUmaWrt6uK62Acl9ZkTC
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39840400004)(396003)(136003)(451199021)(46966006)(36840700001)(44832011)(8936002)(8676002)(36860700001)(83380400001)(41300700001)(47076005)(83170400001)(5660300002)(316002)(336012)(2906002)(2616005)(42882007)(70586007)(40480700001)(70206006)(356005)(7596003)(7636003)(4326008)(82310400005)(54906003)(186003)(6486002)(1076003)(26005)(15974865002)(6506007)(478600001)(36756003)(6512007)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 13:10:57.0476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b112cde5-bed6-4676-4505-08db7eeb9a2e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8524
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power supply regulator support to the exc3000 devices.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v2:
Add missing "return" statement
Use devm_regulator_get_enable without _optional

 drivers/input/touchscreen/exc3000.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscree=
n/exc3000.c
index 4af4c1e5d0da..e3f6d21b3c1b 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sizes.h>
 #include <linux/timer.h>
 #include <asm/unaligned.h>
@@ -360,6 +361,12 @@ static int exc3000_probe(struct i2c_client *client)
 	if (IS_ERR(data->reset))
 		return PTR_ERR(data->reset);
=20
+	/* For proper reset sequence, enable power while reset asserted */
+	error =3D devm_regulator_get_enable(&client->dev, "vdd");
+	if (error && error !=3D -ENODEV)
+		return dev_err_probe(&client->dev, error,
+				     "failed to request vdd regulator\n");
+
 	if (data->reset) {
 		msleep(EXC3000_RESET_MS);
 		gpiod_set_value_cansleep(data->reset, 0);
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
