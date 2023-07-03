Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2512745E2D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjGCOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGCOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:08:58 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2106.outbound.protection.outlook.com [40.92.65.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D67D106;
        Mon,  3 Jul 2023 07:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuBNbXDTkqDNaQcsC64Z4OKFsov+QoHbu4CDvYoUUqHv+ovEzMqNII4mZmIjChEZcuCIYj1n2S0kcnRjHdmDX+2w6VSBu7gKqrBMTa+2zN5ER7Tqhkydv83pyLim8mtRw8AsD0JY/CVaErrzdeKThHO/r618do9CFoGZh4sZFceYZa1csHqoTWKegS1CWY2NlklIP/7+QVW35vtKvqfdfMh/htTY/Mj5KqmxFb3HNSAlIKWjRQkeMvqzRTcHhLpla31cyl7NviNysuZQ+Rs1369wXJhlYGDB+B6Nd/3AY5G2aHQXVDm0KjTqeN3rljtWIl2b00ECRQkuvG6rqxP5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o4vrPZZxBA3YbyvZ2e6l7Nv6AYaTFI9R/bVHAHCW90=;
 b=aQztKHbzUAkm/X9Tl2Ae3z2voarwFNfea8KVUhXxA9sWAiqqNUdQzQA0RvuxlYA3/yegnijWqusP3qW98WQF0QbLyHl0poM50qvmmazQNvzGPWIDSdCLsk106m+LZaWIT9V0v7g5HAwOliDx/fw9MacOT77d7NXY8bKyp2WYEXIsIhsqWKdC+HEV7e3OOW7KCw09+4dcv4wjeVrJ5seohHzspet5pvhxU7CZ3sWKzTBGiSI1FHn5yk3pbsjSq0V/Im8puKtdm40JPzbafuzZAAF08uof5CDTaB2FzfX7Q8KFER2zKn5+lVtENypiymPX0kq1xAr4Pl2W2lkCkDhkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3o4vrPZZxBA3YbyvZ2e6l7Nv6AYaTFI9R/bVHAHCW90=;
 b=gSnhYl2RQta5Pg8JJrca5RwKgzFUnYOX5UbYUbpy5pQg+Dad/74O/d0SZSAVSZnQVRF7Dkx3DZvdOjCTtBQCXBNsqqsIJOpJH5qSL0u0vQyHIpVlGO33SgjRY2+WzigEF3MIlRacqPHYg0aqkriUrapnTQnf9LZUxgSSouFJSN4+R7JyjK26Cmim9dVMitTPt+6V8d3grVrWs+rGkr+uu9U4k+rBD/JJx15JWMynlp+Do1AP261uLhBQ9COCHD8AM+GqPOai1pZCdEwVIU+iPy7QXLX7iHyreq3h27PxWqNn44aEq2CygGEdxl9T8Gf9zFB1026Xu+XAlykdlNao5Q==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AM7PR10MB3891.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 14:08:55 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 14:08:55 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH v3 2/3] hwmon: (sht3x) add devicetree support
Date:   Mon,  3 Jul 2023 22:08:17 +0800
Message-ID: <DB4PR10MB6261E4DD4C96EB70787BAEDF9229A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703140818.427403-1-JuenKit_Yip@hotmail.com>
References: <20230703140818.427403-1-JuenKit_Yip@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [i+9QzgfcsI/Ia8JV328O+M9WodjiKC0G5px+Ko3RhAkveJgS3sbLoNRH0Q6cgMyo]
X-ClientProxiedBy: TYCP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::10) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230703140818.427403-2-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AM7PR10MB3891:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f960fe6-1086-4d95-c8db-08db7bcf093a
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmqqpqVHbY8r+bVyFie8RCx7fvT8zfkaX1SdFMNaZJtY+DXh6UBngZFEZNcSbQInbuCQADIZ9zURatVlL7Nc1HBuKhn5t/RufEmpDs9Ns7npmOgD5h0Ef0V9VHHORwxq3uPmx543zjSjZu7rfQSNVPLJQocravUb19fFLRdW8hKZPffG8xLDl21cNH1XSKvAjOf4REw5Geir99pEAGR2td6vFcxHxUVTo8iJ5J/MchVx45wyF2GMDd/sFlh0ZRpnyQTB7Zj3vGGjCX3OFdbnSSHcbjG/HCfFAzMoXJuOl8UA6SSKj8k2LKDln6K5Rug+9P6qpDeP6YMQJZHonJ677V7MDeR3WX4y9+B1tBxTXpHc1JvK2lffHV3+sLiqKFynEAFSTCgThWQRQcECF3M3USWg28oIoD7soU8P611KFnNSoFPjGqmAfqcJYO08VBcrnfFVuWlaaM/3Jst+Z0Z2lEQYQ1ZtPCsrCjfCZRYMJtOgkPZVpwtJzr8Nlo99d4q55hvPpRCZPt3qhjA9zVYKm4AI+CHe/mYlj/QTRL1a3OTLw+FsaM7ByZhyjOrnNtmczVJhpJLK2ga2OyPMySRjiWiXxtO07+E+JAeQ+uJoGT2vXB1EuG0eqgvXegmrYUdz1z++ybf3w3B0DnvUpIdUQIyqZLcvBJT1PWAI90D/pgSK3GDaus37soK5quwCWGkNlvJa4R58wZwIeABZm5dFumUoA3T1BWpU2YosChxDiCWxFgxejmxdvIGnvA0Io04V9uU=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSsMyskNX6kGg3ukSUfX1LWQNWFQ9WWxF+emPVGhNnW0ytV6F5nGdFOo3RidnijhdcG0xBqOQl88Q89G9Vl50V++d8ewqX/qf7xylJzXBnRQvqj44sKxdIlGz1G5/NxYOHZgHWB6oyry86RLKQf5i/Z69J41IBnzyHjH2Gie+pOWrAfAvQne6Nk/YZ9LaMut5IF4hA87ngISYA3x1HOdbBUzHvaZaMHH3KwIjZosgl1cQRtNhw9f4pJR9s/rKVX32R8bx8XCOWx43K2a3vxz41q6mauAwk7urKGm77NxmVw5uo3O4yyiWKDidDZz+0HW1YTjj2xUzhlZrTjMyimm5qsISoz+cCAkgxZdPclx9oSxUIoTsj2NjUM2jX8zhoXQgpgjpVN07EWeQ86R5XVbvvywVvoMVTX5iYjksh3Ngbq9cirJRq2sZJ9RKOjEM4WPghoY6b48njTIZH9knJjyG88VLiXiiliUgIkUVjULgPJuCJkVnTE8qUXP9GqjMiS7IJE9vlutEPqXBus4h3rK3HD3lY/wN7C9G/pha+jO68Mcl9x7/44/gofnwd1o9vscLKQfBVF5IkIF5oOK+bEVjK+uPwEXEuEAGM9KXZJakKffjbbyigA/KE5FAbSYzA7W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vLV9NgFHJiAlr8e3XrDPz5D37+tDBSUZcXwRW2qaeNlW27yZ9h1MAj2K7f5U?=
 =?us-ascii?Q?N3iuRM5KQOjVce86OLsZAQYDQ5BBcLnaTE9bMEOIaKcCsCBnT20A8f2YnxDa?=
 =?us-ascii?Q?sBAO+PJ4ia3bt65phtpWsMBrgSVGb5XBbSYldIdMEiHY/If5y/jDIGKAMvyk?=
 =?us-ascii?Q?b8PYJj6NHzuDB1acfTjevKK0sD6Al6vws5mlBDK9F4RHg1A6Bzn9N79G5fKV?=
 =?us-ascii?Q?tgt7PuuTqX7Ko6OVfiCRi7mEsNOoLm+51plyZCXtUtJnHoZtT/dvFZMWk5HY?=
 =?us-ascii?Q?lQZ71bFy0+bwgQnS4BgcH8+Tsl0s17tLIgAG2s2/778RHXrhxZyrWyYVejOF?=
 =?us-ascii?Q?2G8Q81FGuSripxBl1wuBEyHYaNq4DB0IGhT3r5pAYrw1byf4zZ6IvNEW5oEk?=
 =?us-ascii?Q?VU3PFoIgODZhXkTk2WD97pUvymhzOCL1anEbWSIXWN2RhlRoF9zf8hAmuaqH?=
 =?us-ascii?Q?uNENsRwQ8FD5m5vz96DmIvnlZCCtQHdOkdGgxJbBydFiuZcYlHxzXjANU4jk?=
 =?us-ascii?Q?NbGO+gzqn5hHX1JPwuNyB0J2kfM9ogw2IkfNXIZGtMZwrbKHC05BVsVcPM7G?=
 =?us-ascii?Q?Zzenhpp4BGGZU6mqhRh/ojtFLtX9+mLB40i7AqQLE6f+hog3H1g7cv2VzwRN?=
 =?us-ascii?Q?/OUtCjFsxfM/6XWvkSpSmRkS9VuYJ5LvvFULfwL+njMpKWPYQO/90BGOGNav?=
 =?us-ascii?Q?nx2HWBGSbQAYHL1fWOcgnf5moIuwDHvR/NZYngOrqJ8Yi67KApHMux9gnzYN?=
 =?us-ascii?Q?V8qjdgllzrOEK6zedPxYQ8VYwtLhWpBcvMvJVWq79NeYzw6GPeZtIJWTpsMC?=
 =?us-ascii?Q?JpfkBpYl6GhwL0mHyfGefhirDLPNq8PV3ENZtVRxR3n9YBZQptp7bGHMpF/Q?=
 =?us-ascii?Q?Zk53WMqRbwsSgh2/ET1CMeLoXmhoy97Z7PratlDCmDSifG7DDeHs8HOeKd8z?=
 =?us-ascii?Q?G7hcNJDZdzteC70WeW0keKveDwor5QGg45XHYB3Y/Biemk35vjC/jLWtcVzs?=
 =?us-ascii?Q?eye2Wvnh/3/aJZk8pM+sKZgDIDedMNYuA+FOl/6cJ/LxCddReD7OMiRmI8ZE?=
 =?us-ascii?Q?B7H1gxtH4PdGO9rynYFaSRBt772VauQpMWwEml2gvI1oWZXCmOJsG23yPRVB?=
 =?us-ascii?Q?YZc/Mr9dkzP5NKtU3tljDsbA3Ti88siz5ufleqT2Z6WdTjrXbWDqdd26L7nK?=
 =?us-ascii?Q?ndY1hyv0S7KNrrWqPP64BbkBzdA9UP2DN7jwTHFKcNszX9Je/u+zkQx6BWrq?=
 =?us-ascii?Q?4HK5QfG92G8Ny9rNGPn41APibz21q79SFpCdJ0L04CAOJDPe7wINDWMBuYb9?=
 =?us-ascii?Q?XDU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f960fe6-1086-4d95-c8db-08db7bcf093a
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 14:08:55.0823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add "compatible" property for supporting devicetree

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
v3:
  - fix wildcards problem

 drivers/hwmon/sht3x.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 79657910b79e..bb8586233adc 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -911,8 +911,23 @@ static int sht3x_probe(struct i2c_client *client)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+/* devicetree ID table */
+static const struct of_device_id sht3x_of_match[] = {
+	{ .compatible = "sensirion,sht30" },
+	{ .compatible = "sensirion,sht31" },
+	{ .compatible = "sensirion,sht35" },
+	{ .compatible = "sensirion,sts30" },
+	{ .compatible = "sensirion,sts31" },
+	{ .compatible = "sensirion,sts35" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sht3x_of_match);
+
 static struct i2c_driver sht3x_i2c_driver = {
-	.driver.name = "sht3x",
+	.driver = {
+		.name = "sht3x",
+		.of_match_table = sht3x_of_match,
+	},
 	.probe       = sht3x_probe,
 	.id_table    = sht3x_ids,
 };
-- 
2.39.2

