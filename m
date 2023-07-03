Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22837745790
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGCIp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGCIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:45:54 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57280E43;
        Mon,  3 Jul 2023 01:45:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnaSmarBGuoqnkLx6tEbSpe5QkrQItELFg60EvytNbiiBaqKSe8oKV4EabnJ3lvLx09AQEQR0O9pRZnJTTze60sXoz0Fx4LuSobq6nYGny+U/mPjExCD2nINtxGkqraBE8MpgZheg+v5uE0nK34xnmivdqPudozV8QSDl8VrpzxRkaMDE/JNyikaZcXxzgV8jKRXqxjRVE3pAi1yb1wRYJV6ezWyPUQ8h47xqthKN0JH3Z83NWd/uccpl2Kz32sHpuSZuohtw9iUMfNvIUgOCWjr7bPmEK33vv912oLePTY0nSs1YMG+8TaGs+Z5Pj7GXkuZpIGy4WMQ9T6piHE06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QXoq75EDbfYal+rThgqoX1YjD+VOCsaiUbIUhcOAqE=;
 b=OEKyJd1vQ0uYeZlx/GYmSzOrflnD9gIOZkoyEUnqUbMV1kwfKcm5yk1Ih66d5/IdgVi4AhQWwLtMTFKD+GOoG0tJvNGCUZ9ObUp5ttMaWZs+G/hgYjh6g70J9j+r0OZMs0whwGA5nB8crRj/Xyh38WlDWq0cGqmA316I5mvltybzyGK7o0/4Bqgp+c3i33yPaiSQAOquRY81NUTQKGomyTJKZCKDx0ccBAM7e0mXEMmg6fDR9UMPH43cL2FZosVmSNq77up/bbCYIDodpzJwF1jtn8yIEyieA9sknPuVCfNUFpdE0J9Ms9HYrgGe5bxNeh/zYrA5/fSaU3FzQizSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QXoq75EDbfYal+rThgqoX1YjD+VOCsaiUbIUhcOAqE=;
 b=zLPsH0XJODT1mmUKK4/YisjDM9ZS6dAYjnTEqyw6+IoTEnFzJOn+R3nX3FRfEvRvDvVqZECgy9rfFqkdOvu9lITJhAsaClkC4QJSGoU3LTkGjRoLkFA0F+WaUNRriM2tgW0S6bPCd6W2ErjiKYb3TRz9Mp8lONUzYBXOLrHoUBonsTk9fvzRHChALNNfU8FEfY+XxJF8J7r+70LvLOVE2zZgE+Nes4yRqvfr5BRdZ9Ewhd61q5HCy2Ozamcvw+kzdom4eRL5QEsf12coZCNgjC+hkz1fys+j5UV7Qq1cZj8LWuRg56G12ZTs768cVGmkene0LBjbpfVE/EqTUeONPw==
Received: from GV3P280CA0035.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::9) by
 AS4PR04MB9508.eurprd04.prod.outlook.com (2603:10a6:20b:4cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 08:45:48 +0000
Received: from HE1EUR01FT065.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::ae) by GV3P280CA0035.outlook.office365.com
 (2603:10a6:150:9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.30 via Frontend
 Transport; Mon, 3 Jul 2023 08:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 HE1EUR01FT065.mail.protection.outlook.com (10.152.0.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17 via Frontend Transport; Mon, 3 Jul 2023 08:45:47 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.104) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 03 Jul 2023 08:45:46 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM7PR04MB6855.eurprd04.prod.outlook.com (2603:10a6:20b:dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 08:45:44 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::4cd1:3e90:54e5:9696%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 08:45:44 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
CC:     Mike Looijmans <mike.looijmans@topic.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: exc3000 - Support power supply regulators
Date:   Mon, 3 Jul 2023 10:45:36 +0200
Message-ID: <20230703084536.8429-2-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703084536.8429-1-mike.looijmans@topic.nl>
References: <20230703084536.8429-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.12499438-d166-465a-8847-b25e1baa3dad@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:208:55::41) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM7PR04MB6855:EE_|HE1EUR01FT065:EE_|AS4PR04MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf2ca92-c9b0-4807-3a72-08db7ba1e5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JiTwIFbKf3DqooEZNQ4AjAZOJCtjRubJLtjZ2W0X2GsnNUpp9JP37OsgY10ahtaJ34cS59qL2T1Nt1LS6QuqEyOc2V59Z6Sv49JvJk/abC0+EEBEokN8G+uP52mN78sZJA8I9fpNXmDIlkez0Matt2xD+phXA5Z8fN7lCSxGN+yotbzqu5KY1qyMLhJqt4o84ZLHaCeirclvhM9PlZ/SsUX4D59U5I6uUZrDvIBjW56DqoUJJQ4A6fp6flHF6LJHdvWDqo/uAtzcxTInRj8hhUNNXYHnqggMz1rN2af7NbCMbsytHm9pMSxcEW3KHJizvKR9kNJN9QiBaCLjyv9jyt48TEw4l4ZK+Q3DHu2BCUrc0aXbpIiknqjrQ1LaW2Y19RUf76lbu2D3dVMKWc9EqDuUUAmpKSccmg374jAMn+HCCYm7z2VYvf3lqqVMZZlI42yGFxFTqhorNeZXsuZMyyiOjf34gqWOoawhZOGoOnWMVf8X106jZhfEjGoHRUg7eDVnSOVD/IXOivnuKsqvZd0w7MY/zewBpqmZZS8kLUqmG2vZ7TWT1HZrHSLPuoqt3mo5REAUh165a6OkDjJCufSPw1U0F+S98NenEF5TX2/oBsi9zCWHZHFJtdaE+ze4
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39830400003)(396003)(376002)(136003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6512007)(6506007)(2616005)(186003)(42882007)(38350700002)(38100700002)(54906003)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(83170400001)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6855
X-CodeTwo-MessageID: f8aa70e0-ee26-45c4-b99f-9b00ed1a30af.20230703084546@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT065.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a998b0c8-df9e-41db-3ce0-08db7ba1e36d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YG19hZ35YbxhTbF65f0KThr2VkrkJ7JRqXc30CVwwAjfBIOSmKXt5dKK10wJaGz7pTQcHJFmWyCT7apeu8voc3d5HqtordI2USv6gyE7XthJGOWkcXR7OgrwYWsNMa9j23W4G36nywcZCVLmYrKZDOm+Vjtzz7ndAoeF2anXMbt12xsHlV3z8/SpXix/R559RcIq5c7tJrCV62T6HyFLCKD+bN7e21WmQt8EpKsLicLT33nadTd+jzTef+gC3Ifs9ZdxIEH5i8UjT9jJHmgVMcxVfoSkDyAkpyoTVq3W0FTBJ6CcpLP1e1OBc1EYWl1etHnXnSFGhXBDu+SnxyjD9cs/FRo8q4tzXcR/xWY/HQWMhQxlMuC1BYBr2slI3rhXX6zfYsy4ivgTgBgKEhPgfZQ7ApemX00Z2WK/tU85tFvWOQAKQPAhLhJs0az/MMh7IWKwOIpbRVBpfRnrdH73vznpZ4tUi/mbGP7O7e6UO8XAjNDSwBuFqh5wJt7fWMf+dCrdProbStpmi9ATUt6fDM+jiqvXTxiJiHBoQkeqqrkZ4R3UOqIBejzn8y3sTaJZQxUGzU5zzTL/nXzdI6o00Oxs83B/RBaCkbjSUfHrenMqDxHmvkBfoQXDWrzBlzwoSwZdSl5Z8XY2dOlnekKXGsTAv2BhPFkjDyXVlxws9/jL7farvwUUF7QtCd/wSbJI
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39830400003)(396003)(346002)(451199021)(46966006)(36840700001)(1076003)(83170400001)(6506007)(4326008)(7636003)(7596003)(70586007)(70206006)(356005)(40480700001)(478600001)(41300700001)(316002)(36860700001)(47076005)(2616005)(336012)(82310400005)(83380400001)(42882007)(186003)(26005)(6512007)(54906003)(44832011)(8936002)(2906002)(15974865002)(5660300002)(6486002)(36756003)(6666004)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 08:45:47.6263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf2ca92-c9b0-4807-3a72-08db7ba1e5c6
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT065.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9508
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power supply regulator support to the exc3000 devices.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 drivers/input/touchscreen/exc3000.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscree=
n/exc3000.c
index 4af4c1e5d0da..3e50af8a4a2d 100644
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
+	error =3D devm_regulator_get_enable_optional(&client->dev, "vdd");
+	if (error && error !=3D -ENODEV)
+		dev_err_probe(&client->dev, error,
+			      "failed to request vdd regulator\n");
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
