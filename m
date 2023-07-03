Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC63745537
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjGCGBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCGBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:01:15 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2107.outbound.protection.outlook.com [40.92.99.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8876AB6;
        Sun,  2 Jul 2023 23:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU1RcN1vZWW8xl9i/gtBCNGj9VyQy5A2GJsUktZeQdzZ+Fs7Il+7QlKzJvJbLhbj9NjJM4k7K41Q2nnMzdl1uP9zVwWUQTuwYSAXhI+xVcbIuIH86Vh1TCvewDb/7jLckxhfoFTCau8+3MnU+cpJ23synCs2PaJu2Inh6BqMWBNXzwIDGQkLL7wWwJAvGsL4zq2TBJpWHiLi3PJjfwtqj+dPURe9GYu/NaLQ9GHE1Clk9y7REGAkF1OU79owWT5s66SGQ6VzRAyh8sdR3jJcz5ERLEk03gzkhWh+tCcWRlliH/VSA/tbOsJsfHu7edvdFxKxvkOLiPsEjPnp4G+5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AaBpr/rGzMU/eCVW1j4z5uShwgdW5zkI90l+rqm+24=;
 b=hTuSG0Y0zwS+ElIhOksXhnlFVtOmRNNbJq+aA/BvSvKEitllRMiDY6olktmo7wv+FsfTW7/s3K6T21TLDrcC9Xi7ptIpsM15Z1bFMrPSLb6kglpuqD8fRLKT78aISJLWpdSyrOIJrbQXjbfcQmeLePcQDUrOZBDVBSCmo9bzMiFlJ2CJZ9GUs/M4a4Wrx+Xk/Uk2J5BCjaLGYR1UJYijl0gJ9BVuKooYg4ucEFKaG7QKHa70XdDqat7sC1YYyl6T8izCkPiW2cawHWrC5HHb5128hAaEUG4RmJ7GtokIzwMg482qTOx1tbAClPZOq4hZP2Tv1MqCodPzFCvqXqcipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AaBpr/rGzMU/eCVW1j4z5uShwgdW5zkI90l+rqm+24=;
 b=WWOXIT33itR1KI2+L0ffM+B1F9wY6gLiAOkB4zc1Ik9B6f9okZtjTWx8R9RzO0oX03CLBgVSuWo2rNjCc/Mz6tzdCHMuHp0BKNjZa0khX9BRrndtk8jTwXIZlDU+ZUhX/3oZowTiGP8YMl7HnB7ey+c8gtXKpm0SUWoTa7KwpmpBsZpDpi5L8qbgixN1flgSuASaWRZR/CG14F34iNz/D3rjxM/GhqdUw2J3NeC5O+aaiixDd1VZXdM0DpGhwJbgKviYm7aRx9ehXcfDF05JNNvXSGkalNqIjU7/nXhOyp+Mo2SrWy79aR1ypa8M1P14rqZiCPCXKD3Zx7pBHHvJ5w==
Received: from TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:242::11)
 by TYCP286MB3500.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Mon, 3 Jul
 2023 06:01:10 +0000
Received: from TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 ([fe80::75d1:d30d:7d07:903b]) by TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 ([fe80::75d1:d30d:7d07:903b%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 06:01:10 +0000
From:   Riwen Lu <luriwen@hotmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux@weissschuh.net,
        hdegoede@redhat.com, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v1] HID: i2c-hid: use print_hex_dump_debug to print report descriptor
Date:   Mon,  3 Jul 2023 14:01:00 +0800
Message-ID: <TYCP286MB260706B19C5E30EE2774784EB129A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [M7+xyUHamD/eX9Uc563d2Ii0v0/TFAIw]
X-ClientProxiedBy: TYCP286CA0283.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::11) To TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:242::11)
X-Microsoft-Original-Message-ID: <20230703060100.1877782-1-luriwen@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2607:EE_|TYCP286MB3500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c186320-a883-4999-eae5-08db7b8ae662
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCnaTCq/aGWwY32hIKIkVR4twvXcakOg4mWqT9nVq+JcFn8HJVZ08CmMSTdul7ppvac2cz5p5snubSjdL/P6ggiU9CDrt0uuhZ4nPRbvlat0mW+Ya7RTahL3Z+byPjfhkJ6yE8EMjgEwDBifxDWXeNgzrBi+CJZR8iknY12FpsPrOalH60gbCAOomPRZUF5Z23QauvHqtk3i4jYklO4fkLJc0OvC1PpyJkmdkK1eFv+ZQ08fdoq0eVlLwmfj74YWZU97p3w2Jde/qr09nuyiGZ7BcQW1Gt5q9UGE9nhxtGGheVny1oEcTgLPV4WqxV9l6/u6MRea/v8wql46fUbgw5h79kD7QFuLDG4aUZl44JofdOqcWsO+L2yKgnEeGxaDYbugo4hwGxzVG7/TQa4m+t/UuByOVSDGOtDsuKDaBgzdB5YV7nsKoLvtYbVVX0m83hrsX11C02AukQC6LnqimmTaNWFnyZw6jnQwgynMLrOHdD9l9grztz8DD+nwyEhg1SYY5150LDUUPcD0dnew+lTzK5CjS5x/AajNlGXGqFttcP4Yk+0Si4PQwfPZBCfj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pfO8D5Ylc+Ob+jvq8QKLk4ueJvCQ+X+aPhsoOtYQW3JgFcQSl0dSIY3pRcM/?=
 =?us-ascii?Q?uiD2nlCA3KPZucIDLMsi3iYsWNYrOCQT0BLFL9SqS4eTsdAzBcrj8qxNE+Ha?=
 =?us-ascii?Q?d2tERId0D4gPgZa1AwUO3dXZkiZD9QNmB+9AyrKa5TH9tz0ABpsJk6o1r3y3?=
 =?us-ascii?Q?veRAinsEtaSmCZYX7e18M+rVxFS0rNSqcZrxjAbQZkMzeS9bWMCepNge9fdw?=
 =?us-ascii?Q?6383ipOGbNdS305kRewCuqfs95ktA0NOB0K97tKd23nm29BGcgGg0ZsqCuIv?=
 =?us-ascii?Q?ZZYsSAHTDgWuUoV29V8xSEA/m+tsKpsVvfpGB1KXoqrxEY2idlPmOMV0hUuf?=
 =?us-ascii?Q?FUycqbsKKNPth3cTLVQVnLc8hvwReA9phm/ikD0UMxDvIN8Ot7XbK6O3GppZ?=
 =?us-ascii?Q?xzqjCS0hbgOfpXFshj79/MLE/E/glcorSwGeQTlED0MIPLI54CPaDPleNnkB?=
 =?us-ascii?Q?icmsyWk3cCXRoQkI8PxUK6pgNkGFEIjwvs5z8BlFEiw+nMXNWyGMetrZnoc0?=
 =?us-ascii?Q?9EwQTivRKN26uGM1YF1QDzKgC2kT/E8QBZqhOZ+IBJMQV/iMad87baiQLqwt?=
 =?us-ascii?Q?hqFHcSp7cFKePe6mI/MDRjJravbsWGGVfEIFTUbwia18nBR1dOEsnWx6EUNG?=
 =?us-ascii?Q?DcELEfV/h6NAc1sVnSJcJ7/NIFfVRsUdS0aIT6khQWT20WIaxeRTtAdUgD6P?=
 =?us-ascii?Q?GsObG/rkT+GwY7sNdmC6qzCzxrHmRooCMVJwB3UDPQsjbmqb6bWGx52i98zL?=
 =?us-ascii?Q?44lff/cl/FT3aaPfCW//6hJqyA3rR4pdlpg5UDwHjU3R+iQBd+pP5IrBQ9fi?=
 =?us-ascii?Q?zNpWnyMqZ3povLd3hacTyDC2eaIxzKb4XGvDoolkFH4U9zsXxCZ4Xv7L/aT6?=
 =?us-ascii?Q?JO+VGjY8dkT3yxVOqo9WiqoYulloetniO9mQJgR51gHe5FuWv28eAkKnBjvv?=
 =?us-ascii?Q?NMoNKWji6XzV54JrdT1jrtepDRRaaYfC1OBB9ZJ2+SIunQP0ZNrRRSZXKnuP?=
 =?us-ascii?Q?yC5UjkoMTiPF7WF19OxP/jJIbV0ZC2NURdCHoLuniXpQWU6sGVMZX2pfze7H?=
 =?us-ascii?Q?lQsAlLrW0X0sY4lPFrRZFOIl8yaKr0R1j2XXhJGAUTN7z3LVLvGw+3UCMB5v?=
 =?us-ascii?Q?R+XfHE3CUF4sgJ851eFQvRkz/zij8QxtGB1/vpbH/j1EQZHuUNuWMEC3STG/?=
 =?us-ascii?Q?cDmtdQiEnZY1O8AvKNKBWPSifVAcUi4QFrl28A=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c186320-a883-4999-eae5-08db7b8ae662
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 06:01:10.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riwen Lu <luriwen@kylinos.cn>

The format '%*ph' print up to 64 bytes long as a hex string with ' '
sepatator. Usually the size of report descriptor is larger than 64
bytes, so consider using print_hex_dump_debug to print out all of it for
better debugging.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index efbba0465eef..8e97fc01c852 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -772,7 +772,9 @@ static int i2c_hid_parse(struct hid_device *hid)
 		}
 	}
 
-	i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
+	i2c_hid_dbg(ihid, "Report Descriptor\n");
+	print_hex_dump_debug("  ", DUMP_PREFIX_OFFSET, 16, 1,
+			rdesc, rsize, false);
 
 	ret = hid_parse_report(hid, rdesc, rsize);
 	if (!use_override)
-- 
2.25.1

