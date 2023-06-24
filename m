Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E573CBCE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjFXQC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 12:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFXQCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 12:02:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2034.outbound.protection.outlook.com [40.92.89.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69A0E5F;
        Sat, 24 Jun 2023 09:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbABwz8SXG3WN7XqNBGENLH1pj0/bkb6zdqhly7N77teCuZJVAWuWyWeD0tnAw8ZmYQWG1DcWoJB8289hxRJBKGJKA4vdQKOAk85JUnX30hkBAjwRE5V452hmwYqSF4YlbuEI3aoqO3VO2mbzZgrSE/Pext/tw/HFJzYoHs9VYSuSmQJ8FxSbRoG2quCtrQNLwdl7HVXkrcVpTWVAPFhRk8n8dinAD/R/sQmEU4rKihqHJ/cakZvUAIatH7V/2IZohLVl3ExeQV2fkjJUyc80nWOlPL7IgWiOBu6XynQlJjMzBcsrODz9OenM6CtvR+R3DrYMyltuwMUef3ml73vaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h7pafd5UrjLQONNEg0P/Pj78wXpnRORgZc854zpH2Q=;
 b=eMO+aiZ3IO3kw5cP4lcK3UGyT8Uu0aDb0nC52t7YPIzFRUN3X9t52grWZxqunAK/leejpEynqZJOpuqsk3JmdFTGaGKB2uXkWMBePY0xQKMNVrv+vklmreq6IA3CIR5FUgWHcH/QqSE2Eu9YI3Qs12x4GEjkR6veVR5dJJRgYQroGz2DuwpKlUKVDiuJEPN5P/jBU9Gco/Hw76rsEjC6JOF0TojvJr1FgVoMCQaelvxXDGeezXNyFzG7MzVTA5tzamymqY0n1W5j2JMJ0iScqweyWQffFK6rIgNGhFtZTFoGN22CSiLd6A3Z6RGNjCIiyGxJjxS7XIjR/arJ71NVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h7pafd5UrjLQONNEg0P/Pj78wXpnRORgZc854zpH2Q=;
 b=aWTwDhgvuSoS7KlppLDuhplyibENyEADF+yeIrvYK3LJI6r/+rc+UzY87qk+9V1lPOFrcaeVw1e5+kC2sO4rrJ5Tt/A8pSvLyzRa4iJuyLXeJszKqGtpkKeR98Z5SHekNSMCye/uv88iDX9f1KKgmUNw5Sh25MLN7tSnNBkuLTDiWibNtmvT1vp2o6LwxcVrkKEwDt+5xo6gVmUY97GeGoEhCsxGFHn1l+OsvKBLZ4j3K6T/5wMHI5HRrHpgC765ut/pqmBfLmCz43yA+kytK2zqTVJoSU3cEcSXlEbhH96eEy3WvPEsoCbbLAOnmpBCHN5Mjt8mDWYAUkRnXXoKXA==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS8PR10MB6102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:570::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 16:02:21 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6521.024; Sat, 24 Jun 2023
 16:02:21 +0000
From:   JuenKit_Yip@hotmail.com
To:     jdelvare@suse.com, linux@roeck-us.net,
        krzysztof.kozlowki+dt@linaro.org, conor+dt@kernel.org,
        broonie@kernel.org, vincent@vtremblay.dev, michal.simek@amd.com,
        geert+renesas@glider.be
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH 2/3] hwmon: (sht3x) add device-tree support
Date:   Sun, 25 Jun 2023 00:01:47 +0800
Message-ID: <DB4PR10MB62616C555E4D76672BDC6B7B9220A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230624160148.218786-1-JuenKit_Yip@hotmail.com>
References: <20230624160148.218786-1-JuenKit_Yip@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [JrKxpSX0kTrz7X1sw6tVWGcXZnPhKkgm]
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230624160148.218786-2-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS8PR10MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e765205-61ca-4ae2-2a09-08db74cc641f
X-MS-Exchange-SLBlob-MailProps: quCBMN2EvO8+XqhgFcE/gp7gtTgZ/RFY7abg/gSsBcG/bcc2aMCOyP/uLBNiycN2EVuY96h9hO/oBAsEIHfurams20hAAit7bubAG/RZEkl606Kr2cdX8xFnFmVlH0IbKq0Acx9M6zv8C7ArCbitmKBTpIXYxK7g876diqm/Hs6YXBH/XvByEhcJCr7yugALaZWiH9qDWm+m7gC6J0q/J8NJisqC6lRK3JYr9+Yv3e4h6wayaR1G97pis+xnpqX+Z1x8DoI84WzaMrqbHyEVo7svNEQd2TwSkKq6PqR4s7aDaQ8fIk7KBLMH7S7x3l1xCoTXxz1f0CIjmGvBozbU/2cFRLjzCUUwbwJO76as3wg7o0JzjoVc+Vu/Kn7k12jbRQD0A38Y87BNDABtV0NBw1BGM735DFSlcgj4aVcz7Anukqx1ojOnkL22vx+bXq55a6UC5RFuFBrNTnjHSLAfFpRHsMO13bVEqtxHTJkqME++LiWVk4fz5SGUR2pG+kK+ingKCVHZxq0+f5fSJwyGniC0I5u3GhZ1PIgqHrEZESz/FBvxw+XJjFVoYiUHjC7w1L7Mz8Wg6ePr7MazQ0wsXneklmfKyLmwkVHNlsLJP34XN784HEVRiDpkjx5CytrcRz8RFojyLKVlmrkOccTXPDXohwull6W8bxYVukvTmV43SSyhLF8mcBgINYr59KXthJpxQ/TRRs/9IdrTkIauAg==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zN1fZ7BU9jRS8F5tK2/n0FF+N/wzqRXBBFMDtmJHn3nPtVn95GWggFphNgWjruJa2csasC+EBdJyaGA/c66OlAeSzHQ0ntda8uWjboL2ZjTryZoiAU/zo5PaW8XmuAn1mBSn8kAuHLkk7NboBVqU8p7zxEGGX+qVCAUIu5XgewMWHjaCjmFm2pGNOLtBekJW9mPboGtPMTqFzNaqHBEykk+a1IBPgFae65kb5zQK6JoTuCuB8D5KNTSBvfagEuMrBeCxzcxnJilFF2J+yniYfSkrMbJC+swLGTxX1cqTblKVRiKAmLC/hetctrjM1zTtns9fnpXGDPpKYOYKds/UsPqm3OTh5Z1hTQZ64fm7ac9HJNX2zcJWxYimAROeY6zAEf/QrTt0CgJza8tfdw4/scE+k0/+51NMwfEWfDlDps0qu95LlMfF/fzz/XDk58H7y+Zl0rArnxWWI22Z3XOUrBCXp/WxmGkNczv8GV/dHgXQYVafHDObo+FscnyBMEM26Jrb4zthGbXlJCy+30rM3eF8m+WT5c73AtBrZCM21lN9QPcHgrVyF3CwGjW+8ROvxbel5Z4kza4jczUzHHCxiZt+F6pjw//RmD5WJjQHeiVkJbJ02sikAuJGfqzM7Xby
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LSo1YnJPlXV6p17R+3UY/GxviPSB9kkxfdKH3rIqesOvPaw8zxcb01LSCNPL?=
 =?us-ascii?Q?5hV180FxtlN9scFJvcdczp2HILAR6aV7+i6TKmhzXvC77lu0z4LSh4i4qFOo?=
 =?us-ascii?Q?QKsyJp1vecIuTVjNhONhj2/ZTQ6QYOKU8p8U+MnY3+3f9YRisUGo7Qn7BEzx?=
 =?us-ascii?Q?JSajzYPyDO2y6S85n6izef3gTQuUhazCsACxq1dc+GL9p7ZVsgLADmIMvmq5?=
 =?us-ascii?Q?i/F7yPoorla3/LDCZFgkgGnZGVfOB41CrOklYYXlWvO1Kzekh9VmCLAVOkUh?=
 =?us-ascii?Q?Bxw+RYFrLD1V1V8UcbDUS/uwYpR7YFWUoowgFWdZoB1ZUZPj6bGEtq/TQgio?=
 =?us-ascii?Q?SkgYXBaHMdpJ2R3j0VqSbTMyIy87HRnp13Z1IDNl0GJOzqdBYgQfKgWH0Vum?=
 =?us-ascii?Q?/cRE3FHs1qMHrh5jEBXZ/e7birT/mNSNgeHHUHr4mb0gcI9lHXym0N0cVXc4?=
 =?us-ascii?Q?W3g6O+mQI51mQ2Uinl9C36ItxeG9yl1g+Z88rV+Ds7bJv8yzNziqwjd5d1a/?=
 =?us-ascii?Q?Tj67fTQ6wkrsbJezUs7BLCMTFkbpAK1pPhbe8u051MwjUdrjoXQ8UNCaVOkw?=
 =?us-ascii?Q?6FmBesol7a+B2NpciVv5Yj06xOdXmSxl5GoPuoJau1jNEp7XrV5N8rWHNFM+?=
 =?us-ascii?Q?FmwhnSgMedwIBQn8tcRCJlw7vm9h1ix4pfJuK1EdYFsJSIpsRjmyQKIAFgHG?=
 =?us-ascii?Q?M//OlFXuzggdrZOUf6OWOznhlXwd7XOzSwq1gVLdHpgQNvR4u1Qn8GHDeWff?=
 =?us-ascii?Q?UUqoReAiqqFvu8EUk+3OC4h2eB/hRgEfBpKOLlOkkjDu4rZTSK9RprNaRNP7?=
 =?us-ascii?Q?3+KPdUg5iqHdTTs8V5ejrfpddFGkZ+wjWIuiiGQBacIW09OLNEuz2AFIKLt8?=
 =?us-ascii?Q?SfigASKJeFu+AYGWWRi+F8ZbwUW0xVESnYzptEBOl943VHyws+dfPnAdxIZi?=
 =?us-ascii?Q?qIdykNkpG8u+YHlM9MVipl2nAdP/TQ1zouShdYC7QNkqm2LEFI2OFqZblwNj?=
 =?us-ascii?Q?JNQpsby9tNopQxJoBBmJiBn+ua9xqrT761GELanYqsVCiXxkfusnXHL3jjuW?=
 =?us-ascii?Q?8aHAPZbQsU6jyqeOOYsFvK8Hzoa/7jCS/xk4Xpfewgkh/eL5q3Ypsm4OFh+H?=
 =?us-ascii?Q?uUpZb4r7dxhVxxq8Atp5KtMkCG1Ha0HM2gbs5tw0z1oBm2RZ0cP6XHJWOy3A?=
 =?us-ascii?Q?TcN7n9Z+01c+QLqxWQyiQDou63/Ff/YXPcA45JMZNu25P0DqNOjG++tLcFE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e765205-61ca-4ae2-2a09-08db74cc641f
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 16:02:20.9622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JuenKit Yip <JuenKit_Yip@hotmail.com>

add "compatible" property for supporting device-tree

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 drivers/hwmon/sht3x.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 9b2dadd11eeb..e7648c011e5f 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -925,8 +925,18 @@ static const struct i2c_device_id sht3x_ids[] = {
 
 MODULE_DEVICE_TABLE(i2c, sht3x_ids);
 
+/* devicetree ID table */
+static const struct of_device_id sht3x_of_match[] = {
+	{ .compatible = "sensirion,sht3x" },
+	{ .compatible = "sensirion,sts3x" },
+	{},
+};
+
 static struct i2c_driver sht3x_i2c_driver = {
-	.driver.name = "sht3x",
+	.driver = {
+		.name = "sht3x",
+		.of_match_table = of_match_ptr(sht3x_of_match),
+	},
 	.probe       = sht3x_probe,
 	.id_table    = sht3x_ids,
 };
-- 
2.30.2

