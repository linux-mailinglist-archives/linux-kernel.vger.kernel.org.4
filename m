Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57716735D15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjFSRgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSRgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:36:11 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2099.outbound.protection.outlook.com [40.92.52.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1127D198;
        Mon, 19 Jun 2023 10:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9vVHjjrWExmzwrYc+eZwILjdfCwzeFdB3SDPlWQ8sg0ekhEky3Rc12PXY14RiC0ly0f2l+rQfjw5yL1+5yuO8NNOfmdJHO4bBM7+MloqYGnGeB02pjuKPj8TtzS/0tPPWaqseJXnwLEEbXoNDywtQHrpocq919cqWJF3F3vVaRRwH/WBO0ziw2XQAk+i7c79USGcVzO2zIVPMD8eoHSatH0TFpEkMPHvoK8OmI12JDaFOhccv51ULPwg1MiJ7rsU/SURwBpqjMUruX8YsniOKfKXCp/mcU3IQwUaM+GV3SNZzLXwlbJJW0KMRwqBYBz6dTs6MGnPdAJo3k7uwzgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W5sGyE0FHgelKsdN3ABfS3WEGxsfjGO+o1QLaIGiEY=;
 b=f4ijL40EGfPxva8UNUJb1mCRaXUr0XbqbQzik1htHiO9w+j9dgFzcrTiEA4AQXD3y5fCVsdGykWz+iXFAfPvM/tr09QlbRwg/KSHXPZqcYuVCBQyzWidyKSHsj3KG+uCrjmQAomTYPwh8Dc/YwWjHaudvqjylvoq16lh4ApmnYEvkViAPQz/bSsSjRdqIDrWw0x+GTDs4QVhkMQEvNkEkNZbgtp5bVnel8JzVWblNoHYe11Hbsm4yB5rWf0jN7Sa+Lqd1r1XF7p5yAyS1oRkQuKrfRMIckFAXf+MBlCbL2DF+NAMnZKp5fYT1R605Bmr+pK6xdTrM5P0DVP6wIZA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W5sGyE0FHgelKsdN3ABfS3WEGxsfjGO+o1QLaIGiEY=;
 b=Ud23W4olBQRyC15CAs1i2KheeJg5ANbTkchoV0/nx/EOwEhMKn+BrA6FKqXZmEOesnIQbfG37p2ODXveSkmwvy61U/tX32tzzflmSmynoLEOGlUl5FvkzvhbQN9iwi9nACy0Rk8G3OF4RCLpPniLZW8M0dNCEv3u08QvQ6YRCTstS7ZtLFhL41JrApgS61EsHjVXPi5Yh1ZvIy2FzrP1k+p/AEwlFX5WJ2hbTSln/PjLjCeB4vm/fWYjHcOuwArtSuhsu9Ev1pP6H8pOU9QF5zSk84RAqHbpq9XifGxCLEPqeFTtq1yRgsPmTLy8W2DtsjdtuG+kIr5GTqTNcjgCpw==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by PSBPR01MB3736.apcprd01.prod.exchangelabs.com
 (2603:1096:301:c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 17:36:04 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::5b31:f8db:585d:f204]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::5b31:f8db:585d:f204%4]) with mapi id 15.20.6477.037; Mon, 19 Jun 2023
 17:36:04 +0000
From:   Ziyang Huang <hzyitc@outlook.com>
To:     ulf.hansson@linaro.org
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH] mmc: meson-mx-sdhc: Fix initialization frozen issue
Date:   Tue, 20 Jun 2023 01:34:59 +0800
Message-ID: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Ha8s9ocL9A7hZ/kMk7SASICLp16GahifJ9ESr1XIBxsWh7/mnmausw==]
X-ClientProxiedBy: TYCP286CA0138.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::13) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20230619173459.3519226-1-hzyitc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|PSBPR01MB3736:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1a064f-37b8-46c2-eeec-08db70eba811
X-MS-Exchange-SLBlob-MailProps: fNPDeqDZc0K6hVw23M7B2oWHpv2m4/wpDpVXMaMmZuPS0Tbxd+cNPQjtZulelqVySuZTgwbmAoOlMTNDn/dCX/w+wreOnRbqYF+hUF2RUoQE8ieT34bQSDJl3EsLutjD+PR7wLixaiWLv1wzh99Jt1hi3hdJjoBr2FFmFHj45ymZtCYF2Z40X3QNolBZXJtxdl6EacAFEYFD8emhPm+vVBOfLOPMw3goIwPeHz+CGsi6tFeQI+iJanoZOrLUk2HXVjPSVM75jtvTLXtw6iKaEuyFbSqs9pOg8l+Z/YGq6nQUcIzCZy3c2lbbKYZk9A3rWtvCGMm/HP2RiT1VMW4VW+x306SEY3XLVaU5U1qLrNhrnXrLnz8PhqTMaSBsc2FscLd+3u0JyldJyghEl58VitgXUr7UiR9lycOq1J+uyPGpkKKtn9KlaTIUVZdOqkMAHuOZEQYJ5itX5e0Zgm6dLgqwi1gYzqPp5SMTRRrzI+hBPB7BvFwPjZnGGvJo0Y/rZw8Ady7/rNNNdfgQjUXtgTIfpgh5Xzy9vCukx3SHAC8c/CG0N9DunSCaphdBA5RwymV7/wCxYh0Sr9w1Ansn6mZGrYs0T3M5knjvZTaSwdKnlRPpNq+63u5a/8bCd9a4chkiwJgsRtq9I3SrPUDi3XaJcPSNF0oX2pTlr/ke4tS2tJscvbmnn2yx6MYF52l6cZoYGpqKwGIoc3IkBSYNeZ2r+qt1CAmtuxxYMn6S+Vboe29/88bxxAO+cnQcKlGCIM5rUaCOHtMR0Ruuyg6j5A==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hd+lyzDkKxKrgdBGwGLRx/vYSIaUgehxZPA8MxUR6QWcPFrH3aoeoT5R69lukd3hl0pKrJ4BuMo7Tri3VI3WFCCDtCSYaySVHomu4F948639TabVk6grNqa6nL+Z3ctGHPlkn+XfhxlL6PWNhSh+tUGmWKb7r4PZKbAPiNNJ/iZRx3GQbCMdPelVFPKyyN85iEQrZPtVUqU7GGMuBwMXD12jbEuX0FOiSNuFniJuxD7PiXySsmdN2jA4b2Y+xpjF6iFPKwGgHxX/u7A2uJV38gIeIOdqXy2zD5CopqDyOu+8sPayGI1N2NFunVjcY4L/x0tMsmHOcTh4gLWaejA/PuBjKZ7chjIzN+ZTRgHScJ607fVOTvmskTFTnwuJ5uoYH87HmQRIsl5EZOORELsL6ZlozG5BxV7hkPfp0uRqPHTirm+IrxepcPzOw3KuASfbe6bebfLCFxyd66i0mlemFzBdN6kyUQ0xNWo/JQO9WNFaxMtOdPcz0/mtiqlJRwsoIzeSGyn5u8c11s7KVBbm4mRwjH+GOh2DRLNrVb9Zqs5YpIvMsKrckz1Ltue1HICZMdBSnyJLOyDjC67rK/GP+WMQzhH5pxs9LJkQFQUgU2djz2e4opr6chYBzWBZ+V+o
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUU1T81Vm6mP4MuaAY8eTyIErnbCwahEr4TA+hsTlJ3alGufGXNVBMFhJyw6?=
 =?us-ascii?Q?1pIBh8Q/O+OC/s5tZ0pnGMcknTcGnn6aL0MtANUN3FvWrEuKyN8qeBR8vzJr?=
 =?us-ascii?Q?2z6iOIDNfRrwO+X3ffhUbofjs3n8X8eN1aU6MK2EWt8M0gL963YsiLJ6x5qk?=
 =?us-ascii?Q?QHUGtvCJSr7ByYMXImqsB8UODYrx+GjArzuyQJLwyx3wm70R3hxuLeUGXTPB?=
 =?us-ascii?Q?cphy0Rt1mkhzuByEkQNuzJzu+tTkpLGZQsUwQ0lqE+Fu2cKzUVTaQgL35DrY?=
 =?us-ascii?Q?4mzr13qI0OG02AoTFMeamVkpCtzeB60eO4ITXcTxehhlRo11gP9iaXeGANuL?=
 =?us-ascii?Q?fm64omC0jbnnh7ZVlMzedFkArG/DRMG2UZra/9YgLLvrjddklJD9tqqbZFqg?=
 =?us-ascii?Q?t8+o0BTuFbQCM8s4Yabjcidf27ACxIggABqqv8M9cmB6+Gexbno92maZe8P/?=
 =?us-ascii?Q?GImKcFephUOv1uJrLJ69CbinllwIi2FrA/bxc11mw7bXdk/KJJVkIFexvVOb?=
 =?us-ascii?Q?hCQ5SjqqPNFub0OnFb5x61KQaXt4DvJOFuYnVwW8eHX86Ipp33Sjxz22DjiJ?=
 =?us-ascii?Q?rTFS90LZSJvruXHUCLsw9YTHsxXV/+Gb0yiNQnD6wMefQlPZ7jqIzfqSPKI9?=
 =?us-ascii?Q?JN1KsiZpeyedOaJYwbY0DsupKfQxG7uYB8w+vEmZXdJgP17ep0kJ1s6H1YD2?=
 =?us-ascii?Q?hR51paBoNjGzUOWuRCVWtBn/g188dp28o4aguufQpV0YHZikCqneA4d+Vhha?=
 =?us-ascii?Q?4njfVegytxDYwwyB1sYzOUGSUdKvin7bwqXj4TO1GpHh9r1beTz+Ly2Z8Ctl?=
 =?us-ascii?Q?8t8yjDiUxAWOt9tS+q1IKU5O/CmaG+CxJA2uiWsZ6+bi7lMi/A47Utr8joZq?=
 =?us-ascii?Q?80fjT40aM+jGl59EE9qDU2G/u7lxQiUcaIrIqV/snHkl82Cmc6xgyaDJUqmN?=
 =?us-ascii?Q?T7ejJJjhc4t8WT60I/s3Qzi0HgtRl4DJESRCQsLnEiggu4+OT8AOy+17E7+i?=
 =?us-ascii?Q?Ei2wR8I85Wv2LbYQTMGk9nhIpG0BJd0m9rbjGG/ysRIfY8rskUlNfJP4Hynp?=
 =?us-ascii?Q?hdG3HzGMKdD6Yx3UXfci/ACD1KMmpp3rtDURQHOHhxFOCEEtrInVsFb2vPzs?=
 =?us-ascii?Q?qeSDSd+Z2Zm6wTur8SLzEJYNa0bAIdYiwWDY4Grm4iqOcYfNrdVnldAF3pft?=
 =?us-ascii?Q?JuEnmgEWCi63aveKsUW7YXwH9qjqNIZ09ORziUL616n8o2uKy+hiLw1xYAM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1a064f-37b8-46c2-eeec-08db70eba811
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 17:36:04.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR01MB3736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
Then we set rx_clk_phase to 11 or 15 which is out of range and make
hardware frozen. After we send command request, no irq will be
interrupted and the mmc driver will keep to wait for request finished,
even durning rebooting.

So let's set a common value - 1 just for initialization. Then let
meson_mx_sdhc_execute_tuning() to find the accurate value for data
transfer.

Fixes: e4bf1b0970ef ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index da85c2f2..a01090a2 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -269,7 +269,6 @@ static int meson_mx_sdhc_enable_clks(struct mmc_host *mmc)
 static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct meson_mx_sdhc_host *host = mmc_priv(mmc);
-	u32 rx_clk_phase;
 	int ret;
 
 	meson_mx_sdhc_disable_clks(mmc);
@@ -290,31 +289,12 @@ static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
 		mmc->actual_clock = clk_get_rate(host->sd_clk);
 
 		/*
-		 * according to Amlogic the following latching points are
-		 * selected with empirical values, there is no (known) formula
-		 * to calculate these.
+		 * This value is just for initialization. For data transmission,
+		 * meson_mx_sdhc_execute_tuning() will find a accurate value
 		 */
-		if (mmc->actual_clock > 100000000) {
-			rx_clk_phase = 1;
-		} else if (mmc->actual_clock > 45000000) {
-			if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
-				rx_clk_phase = 15;
-			else
-				rx_clk_phase = 11;
-		} else if (mmc->actual_clock >= 25000000) {
-			rx_clk_phase = 15;
-		} else if (mmc->actual_clock > 5000000) {
-			rx_clk_phase = 23;
-		} else if (mmc->actual_clock > 1000000) {
-			rx_clk_phase = 55;
-		} else {
-			rx_clk_phase = 1061;
-		}
-
 		regmap_update_bits(host->regmap, MESON_SDHC_CLK2,
 				   MESON_SDHC_CLK2_RX_CLK_PHASE,
-				   FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE,
-					      rx_clk_phase));
+				   FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE, 1));
 	} else {
 		mmc->actual_clock = 0;
 	}
-- 
2.34.1

