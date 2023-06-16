Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA45733555
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjFPQBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbjFPQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:01:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2035.outbound.protection.outlook.com [40.92.91.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0866E35B0;
        Fri, 16 Jun 2023 09:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfaEVJqF0kSkDgSgShCYI9H8j1xIToK+etQO7qK759MC0BVpWWFYo4k7hF5lnEAWMEa7D391oNTUP+Ox3BojS+9vsreuylyYvVpk2MCrDwSfKj3Dg6RVhUOXKPAxDa67JZEVtZRodCc3tUoh/DvDyQT753zk2DGWpHhlojSENre6ZHPMzz71iQoZw8hUaD+Y5CSmdnqudUvs3WWed7GPHqOrSGmJQhADy8yTyTn0gLr8PJBwD5i5L56A5xs5LvoWepBjENlC0gpRHl7ZCY7vf5SFX6CnLja9ACZATy5ODV3HoQ4mGf6hZI3h7rnIf8TaM1eY8MTj5DYldd/KCWuMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zdgws7rt6JoJa6k9+BbppyJcqXIPw7UktAGi68OcFA=;
 b=SXy4b/Lnhx3cB77GjxxwiLlu6gii24WFyAycvw/yqFOAQxHwHPPvs8hkFvxjmhM+PGS1NBvqQbOHA5eELFQkN378V3NCls8Ll927q5Qs0j6kPyrNnQRbwMjwgYTvkW6w6gCQkVam+z6cp7RR7ERVDZiJ6YzETWV9zxP55Sb5MGgwZL7ty5xquvY4cJKVGGTVrYbGxw30TqmOpcZ+oV/gczCxRgOaByG8mgIDwLvFnM469ZScKyBFj1MoxpTEhGCQ5vPiyhEVaKWf5k2TCoHLqLErNiFtwlAjtEwxNH8uZBrdFUrwdOrJXtzDw3dbJrQmjjkHN5jbo3gDD9afGFEqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zdgws7rt6JoJa6k9+BbppyJcqXIPw7UktAGi68OcFA=;
 b=XIz9lIVfEhhiFNuM50v5Qf4qtV5e85wgtNOvaW75xk3cHvt/m5N3n5wkdyZGN9IgNRZ/ZrufdXniHd7Og8EyRVEqV+moquO81qnaIAgeyGyKUUpeH+tTJIIn0RHXQECeV1hCgMjZPGS1K4RRmpmi14ikFUpSfmWYABDJlM4Rjf1zne5MNXEgOXkN5rUORmhft6q+339H0tVmY8r0MQerOgp7vpdGG4tKBcqJ1S4EWIjg9L9cu8ufzrE//Nf45iupWGiuIeut52q2JO06gu9zxahtIr+MfR7bO9pPvHZcjTA7PSyDb2A07ME6v0opA/PDy4aO91XMVzw1ZCwgACSbmw==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS1PR10MB7959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 16:01:08 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 16:01:08 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH v2 4/6] hwmon: (sht3x)add medium repeatability support
Date:   Sat, 17 Jun 2023 00:00:15 +0800
Message-ID: <DB4PR10MB6261A70CD0444248ADDCC3219258A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
References: <20230616160017.21228-1-JuenKit_Yip@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [TR8zRAIgmce0rmx9nljsypsuFfKLdfzJ]
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230616160017.21228-4-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS1PR10MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 082444e3-e8da-4f59-1e98-08db6e82e5ef
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKzwu8YPsqYDy7f7AA4ui0PNuV6DC7KGvIqRE+OEEWSsMkc3bHafQDQP23sf/qPhROCUEezSvzmS4Xv8xcxt+CDnbgNYE42kZD166W8sEH975ohcOZqALYi0SRJJH8Th8lb6vDAAxzy7Z2MIxywpF3FCbxNvrlvokTPQq/UACLei33aFb0hQo+jycAIAceKBkx3jg+uRS0f1toJrjYIifBuDNb0sX2erDHcM1FPJQilIUot60ZT6SgXgszwnxSujM/KHjNO72UpnbPxgV6JZlLnTM7qYAMXVqT/3cTPCoxQSdg2t7rqhenRt4tNnqZXHm6pT0i8tpeUBu2gua1f1ZkeANaauxTng22P8wxqaEE++7bpAo/idTscM3oI9j9/ygseINcNOonnMv6fHQLBDOtNbb6fQmPiyr6IC80efkwPksScWaLsdNvMpNUblMhkw3kQs1UrbGdDAuV1L3a9du3V8b3lp5O7eoJo1jDiT4H4NW0G+vKlOVNSlJ3X3rf6iLzhkNe0ZxhSlfEzJw5KxCvVh6MrOJJRbUh8xqioY7XUQnyF3h7FSDq7NodjxQmZaW/U1tFEUHyeUHFfj/RsyxdXJE4XeC4aSbjjODE+NheWxj2XEB4MAp61XEIqq/xRIrEgqWZzNVNH5z/WuicFVHTjzGi5zDZS4OH6+RQHpMebe1PAhjfu761m7myVG1hQOhjHLVWkjz3x8MgHb9MRFo5pbiKQfyoXwHNQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7O21bMYsj4kqCc3/LbB6i+9qcbIMtakH76SA28024I3uRDigVgl9MKRig9kD64VnvEkVVqwQWvc8dm5oFNC3CDbllJ4JQHsSMM8q+pdlzDdkh0yIzzMv6vWLPkXeeGN/P/izJqrkLqUzpA2cqBzMr5KSWsJ+f/sdMv7pmbqd+M1kx0Mk8jJfYGGi2QxdkmoDZkcyvUe1JriISx23Mlh5HLlbIr2kfRp0sXBzMabuQC1wrHk3bBSu+7KEHrOzsqyfObjamegFRsfHv5oqcDXtMvPNg1yd6wzVgOax9eFIDouM1irOTzzHJeijCZxWQ+2NkdE8G7LoqtM5KT8mYS+Ay9XNPgSkB2oEIi7LZSZUuFYmgDks4yow/OS486PvoNadZ6AaCWsc5SxYND6kg3+2HhxZNenrR8rhk+EI8jswWMAZiEmdqS1WvtfNGra5sSda4vQojEBgXW2IWj8dpk5oQR72f5CtVfbR9G+rLy5QItFUNK5zuT4SOvoToqT4krzOjdggerNbVgEVnYgFMS+ljr6t+63EtJ0BC78vXsy7eD4HeB1U7dgOczgQoMB9qZ0AGhyLHnqFidLCclNV3fsTQzNtm2hmmbdK2ZFxHnPrGn8CoF0AgozYF10IGiaqGrO0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iuQPJbCq7HBhYGsUPyP111Otus1+OiiGeF0LRUMyN+Qyw0chtIi6zHyTWokx?=
 =?us-ascii?Q?lb/7o/QDEJGbxwN4UXLDkBl+7S1Rcrhjkp8VR3JmMveYy5aF1hfZ0RJ92+M7?=
 =?us-ascii?Q?TeQVR4FH90ZNw1vnTrX+vJCoeSJ6n/T+QfshKNfg+VvYdyy+ouZP7vQZ+Q/L?=
 =?us-ascii?Q?oi0fNf91QfmL9xdKYfx/aonRO1JDQ81okJLJhox61b0ujXwX0SFMkYKfG4/3?=
 =?us-ascii?Q?fl424JLkRKJXOsAKf1igHEIyySyT2axRFp4wYzPx1L9Kw0e5ShvnD66hTR/B?=
 =?us-ascii?Q?DEvXbK006IlycRxbEPeP1KBvmzWDS+gD8dyTkpioltVRioUk8RcwykEWVje5?=
 =?us-ascii?Q?KPIUJJP6zjbCynGgUlH3sv4waM3pM5da2zKKajh5a4lacBDHLlRNzo4COWCu?=
 =?us-ascii?Q?5yXP2gN/o84F6/lWJ5bJjRxaDNIPabG2fy4qc5aYAuT0JQgy5pF+YCn6GZX+?=
 =?us-ascii?Q?8k8imqqmPGgaY6gDKLR0hkzn6RyrY+FoWCu/tiRll5N+0UZNQSxQwTTvEMXx?=
 =?us-ascii?Q?MZUR96A2JVEuhZ/UJfHnNSRD8MrCCtSxT7Um8AwtntFEObzHke7ZtilqBtKP?=
 =?us-ascii?Q?0ikpO3u5adLwzLJpCbqsXUJ5WR8Wym/cHGaM3Cd0MNwP8v8VjnGC9WheyaWw?=
 =?us-ascii?Q?UVnM1EcgJPMNUTfk//CVeKPdvzi8zNIl31hIvvk4AfRJuQPWBf00MhUCs+3V?=
 =?us-ascii?Q?Ek1RvTfkfrz9HvCEgGZAdK4MoM6I0wfXSmMKP2/JuMewpoJ/9M60np4G1AtG?=
 =?us-ascii?Q?M5zV2CTLIBQEzRdz5kQsmTMC2O0JKyUWjLnHnpRI0BW/8bf8o+51cGqwLnyo?=
 =?us-ascii?Q?fo24cBwFEZylWgWO01nMzGwZMYTzpk7yFyM54Oab86xsdXVMkEYQ34r7FVF7?=
 =?us-ascii?Q?8VIaTTCkSWPmj0Mv/0hfTUFIgVvhd98En8r8KMt8z27nMdm32dc8VySHHQwV?=
 =?us-ascii?Q?5pOjD0ZcC9MLjEjOtV6/tnfERimGe4fscoQDz4YYcHJqed2p29BpmUW2DYr5?=
 =?us-ascii?Q?3+Ddm9E4sYFnVQp5ilxVNp8xRIBpsAAUQCd0PlcCBnYU1HYpKbTKSmf4j7+s?=
 =?us-ascii?Q?eKIRTG2ioNmeyvcr58OdnjpE8er8EeP0wJW/wI3aFdIPquabgQflGJklC95t?=
 =?us-ascii?Q?eCl50lvFyhLHBCrNtx0b9tP8EnbP+fFFOzsvrM1AWpEuz4niF2J1jAFNbuwR?=
 =?us-ascii?Q?UgyZ3GCt8SYM6J1JyRCiljJ+roa05t0KWqCM7J5+bhaPfjSXA4OTKMMgxFE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 082444e3-e8da-4f59-1e98-08db6e82e5ef
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:01:08.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7959
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add medium repeatability support for matching datasheet

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 drivers/hwmon/sht3x.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index ecc64febc..6174b8fa7 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -24,6 +24,9 @@
 /* commands (high repeatability mode) */
 static const unsigned char sht3x_cmd_measure_single_hpm[] = { 0x24, 0x00 };
 
+/* commands (medium repeatability mode) */
+static const unsigned char sht3x_cmd_measure_single_mpm[] = { 0x24, 0x0b };
+
 /* commands (low repeatability mode) */
 static const unsigned char sht3x_cmd_measure_single_lpm[] = { 0x24, 0x16 };
 
@@ -41,6 +44,7 @@ static const unsigned char sht3x_cmd_clear_status_reg[]        = { 0x30, 0x41 };
 
 /* delays for single-shot mode i2c commands, both in us */
 #define SHT3X_SINGLE_WAIT_TIME_HPM  15000
+#define SHT3X_SINGLE_WAIT_TIME_MPM   6000
 #define SHT3X_SINGLE_WAIT_TIME_LPM   4000
 
 #define SHT3X_WORD_LEN         2
@@ -68,6 +72,7 @@ enum sht3x_limits {
 
 enum sht3x_repeatability {
 	low_repeatability,
+	medium_repeatability,
 	high_repeatability,
 };
 
@@ -87,6 +92,20 @@ static const char periodic_measure_commands_hpm[][SHT3X_CMD_LENGTH] = {
 	{0x27, 0x37},
 };
 
+/* periodic measure commands (medium repeatability) */
+static const char periodic_measure_commands_mpm[][SHT3X_CMD_LENGTH] = {
+	/* 0.5 measurements per second */
+	{0x20, 0x24},
+	/* 1 measurements per second */
+	{0x21, 0x26},
+	/* 2 measurements per second */
+	{0x22, 0x20},
+	/* 4 measurements per second */
+	{0x23, 0x22},
+	/* 10 measurements per second */
+	{0x27, 0x21},
+};
+
 /* periodic measure commands (low repeatability mode) */
 static const char periodic_measure_commands_lpm[][SHT3X_CMD_LENGTH] = {
 	/* 0.5 measurements per second */
@@ -444,6 +463,9 @@ static void sht3x_select_command(struct sht3x_data *data)
 		if (data->repeatability == high_repeatability) {
 			data->command = sht3x_cmd_measure_single_hpm;
 			data->wait_time = SHT3X_SINGLE_WAIT_TIME_HPM;
+		} else if (data->repeatability ==  medium_repeatability) {
+			data->command = sht3x_cmd_measure_single_mpm;
+			data->wait_time = SHT3X_SINGLE_WAIT_TIME_MPM;
 		} else {
 			data->command = sht3x_cmd_measure_single_lpm;
 			data->wait_time = SHT3X_SINGLE_WAIT_TIME_LPM;
@@ -591,6 +613,8 @@ static ssize_t update_interval_store(struct device *dev,
 	if (mode > 0) {
 		if (data->repeatability == high_repeatability)
 			command = periodic_measure_commands_hpm[mode - 1];
+		else if (data->repeatability == medium_repeatability)
+			command = periodic_measure_commands_mpm[mode - 1];
 		else
 			command = periodic_measure_commands_lpm[mode - 1];
 
-- 
2.30.2

