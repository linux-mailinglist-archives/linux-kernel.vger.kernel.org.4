Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4D6EE159
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjDYLvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjDYLvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:51:32 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2050C49E2;
        Tue, 25 Apr 2023 04:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNceXVz2md6PzR4n/FvtdjtxO/pudl6Cg2sF1ffctgbmVq8hmTuZ/K/c7RNcavh2gWIRtblonEZndIxlpPpRg+ZTje9kOmwYTnfK4axAmxgOqepzyjbn0aFJVOQvx80619+d69VgeXZmPvID8SI9mqdZipb4qc2/qNG2Vx55tLUcs+J1Cm9Xyy7qS2qd+jTXtS6w8P5bXLl7BX1Pqu8Fmsm/MkUIevOsBndaC8lfPRttEPdEHG5GWQ23f9ET9n46NKDCnQHtTABqPeAgs7jQzwUU8ufxFCVClBr249qjHF9MQCUsC84mlw9fmsavWg1q6KzFWf7WYAa/yS7zqNEsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=layYqmVSFnwi96LY/EP8SoHFfbmOgCZ7UZfSL1nTpUU=;
 b=KZpHozEMalUaB4aH0mm8VGtfWLuSH5i7knfxuMQfwkZ/M17WqbrWaekq6spkBN89pjOHRmFbZCJiS10zy1DX/FpoC7WNoILnfcoDBTi3BtAq2MH3oVBOTxTtYttEllOzaoQQgOMWNINewp9cLBGLLR+fCWtanP2cJO9tLu/xsgk80uvcRhEuna5Gkzvyg5a7hkbQvHleeoqjOLM+Wr+dwyTY9HoNZwUJiZegArRqmWDh5m5oXd5LpV63XdwQHH+jRE9MmSXfBzFcPuPcjPH8VtVk06bYZp+cF9DkbpzFowRIVgcGWmbil9wqaIytdmvX3Mm0tjr20CG5rfQxt0+Bkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=layYqmVSFnwi96LY/EP8SoHFfbmOgCZ7UZfSL1nTpUU=;
 b=oGFyP3ouS/UVYP8fOujiIDRXtn8/g3FIJ+UditfU7pq4mjKet2aGSvGslKXL/6vfV3Qn6c+cylzpGUvP8TpZaxhxu2RPcrrUUzwVSB3hhJ82wwUBe3UZT9ZhNJeEepbi3TC8Bj6efmOQm/C4sIdTQZfIhJvZUdSAzuIiCtOI2n4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU2PR08MB10203.eurprd08.prod.outlook.com (2603:10a6:10:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 11:51:24 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6c5a:c28e:206:453%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 11:51:24 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [RFC v1 3/4] Input: st1232 - add virtual touchscreen and buttons handling
Date:   Tue, 25 Apr 2023 13:50:48 +0200
Message-Id: <20230425115049.870003-4-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU2PR08MB10203:EE_
X-MS-Office365-Filtering-Correlation-Id: f22e31cf-818c-4348-fb95-08db458364a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9odGcymKNUOaeaV8ZreQQScJt0Qfg76wjbeseEZmdtllcSmgxebjUnONQ7iawpwOCIKpAsmvcG2+VtijTQAZ7aQHiSdFhOUc9kULxOFJl8VwL7DuG0gNe6Q8MaqwEWCWE5+WxRKDhmd2k4pDCmMU0ydX2qiCgDxbvp+vq+ja5J8bAp+691ScIjehS1lCvUW3monpdTsNJSQRO4GAjaxDa0dQLn6hZs7P3DSuTeJOYHh44dGNsE/NGJbxCUh3Ny8SfL7t+MEit6+2VFw7JKlXVkSXfCAQ8EEXmU9zWjhm8iOpwVbD/Xca7jPKvvrvkkd1YbZSPAbUYFdVDeGU4h72aAhkxeniN5Q6U68KgGNmegQ7nLFNBaSnyD0Wi63lXM05Yh0RPj5d5iR+C4lsnMZjFiXZo2h1TTlY7VBmbjwbV+cM77pw3woLfhf7lWvR18xQ8zQ3q2l+aghsRmtNv+4sGNy1YyvuwFJjXN/aauCovJOLNS5hlEUvRZNxTgrv32IY8RWf2wFYkJkWqui1nmBWYnaR30/u378oLgPahaPLTH/IKGvA1HEcaCPhECA8a3ZLUWZnfGUL2I/VrnDa6Jtb+r0HIZBFWRU3WiomWqfMWDsigT/BdcqtkzAWR1upeLRX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(366004)(346002)(396003)(136003)(451199021)(38350700002)(36756003)(8676002)(8936002)(54906003)(478600001)(66476007)(66556008)(66946007)(4326008)(7416002)(44832011)(316002)(41300700001)(2906002)(38100700002)(5660300002)(2616005)(86362001)(186003)(26005)(6506007)(6512007)(1076003)(107886003)(52116002)(6486002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WONqWCT7x5/Aw3MVskBH26mEJ6QVH+6irYCBdxk9mAVKz/TkcKcgXTqEokJe?=
 =?us-ascii?Q?NJERVCS2JqGTGQLksfxFvSgr+b9aq6Pv/fIGkNJJfs4nIpIw99KBeUQtyG9D?=
 =?us-ascii?Q?LwXkdQDEnHtWt0hz9gMlUFrldhPLDtQMCceAhRuxxUP6I89QhewlekkH26Dm?=
 =?us-ascii?Q?zEe8qW8aRl1FmK9VnxkP0fDK1CprLhbY9GFFqqMbO32XjhvNROMCLEFyOYOG?=
 =?us-ascii?Q?SRfoHTf0VbHoUjYctM52JOeDYqXdkI9NCo1ARIB17RvY0DWd212LH7b+7/3A?=
 =?us-ascii?Q?PwqFT6n3dxSE8VnHtAvq1DZK8L/Dxar4aYkvYB/V7hSueuuQ0XstVL2Twldl?=
 =?us-ascii?Q?C/vJ8khGnMy5MtarSXKjYBquhUOpYvzONbQspUiF2DF3wh58lsPHZ7Xc3BQl?=
 =?us-ascii?Q?mIBOHkyFkPXe4eBLuZqxpD/Xr8feG3qxbSO4CbwsK4eK/9pKL3fSRr//xxhj?=
 =?us-ascii?Q?TqLzor6StdVxhoSHBbVbNrlSuk8OzF5CyL5MZ8g0H+bcGbxkpNgd7oGxI2Wb?=
 =?us-ascii?Q?q350/2o6JjCT9nq1bKrIHe3ITmbFNlvG/PSjjYrktnTvmWKG2uTmQ0PbYB4i?=
 =?us-ascii?Q?RHaUyBOx3cQ3BUC0Pb7JhqEPcUjW6fRlf4bUi/qpPt95VzOOamONvV5CkjnJ?=
 =?us-ascii?Q?mESzo9d3uKMFnaXGcrafyLtN2e9lkL3yh3OUhG1GQ9qaWuClB8W3QYIAhUW8?=
 =?us-ascii?Q?Jn3BXGfh0DfG4m2Dd/BqZvGHFR2gWXzGBFT0M4nlWidYMLTNDk36tl3keGwg?=
 =?us-ascii?Q?ZAj/eVLX5A1cWFwV40Jcw+1pyNFejapPPHFz0wNX6NksyqT7wKtHWJCIebcI?=
 =?us-ascii?Q?4K6QBgz8pkoZdbVDdOjqWILUBOz/aA+u+PHjA+48nSYMvIk0iKHL3LHSnLE/?=
 =?us-ascii?Q?urvFuuxcUASQffk8FQ6tUlWNuiQ+u6j8zw6kelR0Ze/rSwu3LqW2LCGHJKOy?=
 =?us-ascii?Q?PjmeQrgYfFh0UwL2/luMzgYhNnse+pWLX3YetAuTgXm52ZafJ8/FvgOOkbeI?=
 =?us-ascii?Q?G/pyYYVGbEPAiKgouSnQV+iXakqP/rmZLT/wua+46snoJT8pL1ffYO8Sf33i?=
 =?us-ascii?Q?TsW49ep/u0tX/MRreUoc/cPblutR3QoxfMZu1vsD8gVgs+2Z2bzR5VCMVz8K?=
 =?us-ascii?Q?UTimHqhe5dHh3ebNwaQSEc7ialfoIHdv/4nyOlYROO0WNaaXJQYfuEypDGuQ?=
 =?us-ascii?Q?DfiTEqdsOJNzd+k6WblVb0vFvWIIUdBK5kRWhcDuVkOmJDa/qBoNP/+m5hY4?=
 =?us-ascii?Q?O9LSNwbXDPzmUxzF5U3jyUVGWfcE/yhvI1PEo1Repjqh98TwkVExCoohkiAj?=
 =?us-ascii?Q?+PtogVa/IZrzMN8zOwgch6UXDPUOiSgizHYdrWQlKWCChKletaIvuBQtZT1p?=
 =?us-ascii?Q?t4Xql7AA/c9yJBvKe+AZz0SKGm3CqdcSqB+ssRE3m34/XyL4Tg93/3S0jKeG?=
 =?us-ascii?Q?f182WfbfolhK7K/t+brGOC5kZZwlpZyy/0qglg17jOHxiSJnu+VsMItrlSzQ?=
 =?us-ascii?Q?3xyJzaPM6CgEsXCMcKYVCquq5rqVCjNe1JKfsSjBVV7UqSd8XGqwPYidI7iE?=
 =?us-ascii?Q?qZHQUktgY4wcvB9o3rWZ2M/2p6NAohfz5wU6dYqOEyfsFl8sT+0xUSuUWNyT?=
 =?us-ascii?Q?le7WE6FGtcn1ZttSi+oZQEM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f22e31cf-818c-4348-fb95-08db458364a3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 11:51:23.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dTTTY1WKRDG9nCD9S7+VpPmJyGoAr+b6p0Yk7dSkK3vgyVmSrKCxmxVxFcnF8Dm/POb/orhAGIYWI1X96EpsrsgDqJFb9K/Dg5EI8bVmTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ts-virtobj to support overlay objects such as buttons and resized
frames defined in the device tree.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/st1232.c | 41 ++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index f49566dc96f8..025f43c532d8 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -22,6 +22,7 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/input/ts-virtobj.h>
 
 #define ST1232_TS_NAME	"st1232-ts"
 #define ST1633_TS_NAME	"st1633-ts"
@@ -56,6 +57,7 @@ struct st1232_ts_data {
 	struct touchscreen_properties prop;
 	struct dev_pm_qos_request low_latency_req;
 	struct gpio_desc *reset_gpio;
+	struct ts_virtobj_map *map;
 	const struct st_chip_info *chip_info;
 	int read_buf_len;
 	u8 *read_buf;
@@ -133,6 +135,7 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 	struct input_mt_pos pos[ST_TS_MAX_FINGERS];
 	u8 z[ST_TS_MAX_FINGERS];
 	int slots[ST_TS_MAX_FINGERS];
+	bool button_slot[ST_TS_MAX_FINGERS] = {false};
 	int n_contacts = 0;
 	int i;
 
@@ -143,6 +146,11 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 			unsigned int x = ((buf[0] & 0x70) << 4) | buf[1];
 			unsigned int y = ((buf[0] & 0x07) << 8) | buf[2];
 
+			if (ts_virtobj_button_event(ts->map, ts->input_dev, x, y))
+				button_slot[n_contacts] = true;
+			else if (!ts_virtobj_mt_on_touchscreen(ts->map, &x, &y))
+				continue;
+
 			touchscreen_set_mt_pos(&pos[n_contacts],
 					       &ts->prop, x, y);
 
@@ -158,12 +166,16 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 	for (i = 0; i < n_contacts; i++) {
 		input_mt_slot(input, slots[i]);
 		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
-		input_report_abs(input, ABS_MT_POSITION_X, pos[i].x);
-		input_report_abs(input, ABS_MT_POSITION_Y, pos[i].y);
+		if (!button_slot[i]) {
+			input_report_abs(input, ABS_MT_POSITION_X, pos[i].x);
+			input_report_abs(input, ABS_MT_POSITION_Y, pos[i].y);
+		}
 		if (ts->chip_info->have_z)
 			input_report_abs(input, ABS_MT_TOUCH_MAJOR, z[i]);
 	}
 
+	if (!n_contacts)
+		ts_virtobj_button_release_pressed(ts->map, ts->input_dev);
 	input_mt_sync_frame(input);
 	input_sync(input);
 
@@ -266,6 +278,11 @@ static int st1232_ts_probe(struct i2c_client *client)
 	ts->client = client;
 	ts->input_dev = input_dev;
 
+	/* map virtual objects if defined in the device tree */
+	ts->map = ts_virtobj_map_objects(&ts->client->dev, ts->input_dev);
+	if (IS_ERR(ts->map))
+		return PTR_ERR(ts->map);
+
 	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, NULL,
 						 GPIOD_OUT_HIGH);
 	if (IS_ERR(ts->reset_gpio)) {
@@ -292,18 +309,22 @@ static int st1232_ts_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
-	/* Read resolution from the chip */
-	error = st1232_ts_read_resolution(ts, &max_x, &max_y);
-	if (error) {
-		dev_err(&client->dev,
-			"Failed to read resolution: %d\n", error);
-		return error;
-	}
-
 	if (ts->chip_info->have_z)
 		input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
 				     ts->chip_info->max_area, 0, 0);
 
+	if (ts_virtobj_mapped_touchscreen(ts->map)) {
+		ts_virtobj_retrieve_abs(ts->map, &max_x, &max_y);
+	} else {
+		/* Read resolution from the chip */
+		error = st1232_ts_read_resolution(ts, &max_x, &max_y);
+		if (error) {
+			dev_err(&client->dev,
+				"Failed to read resolution: %d\n", error);
+			return error;
+		}
+	}
+
 	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
 			     0, max_x, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
-- 
2.37.2

