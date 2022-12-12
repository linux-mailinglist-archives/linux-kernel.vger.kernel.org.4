Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC0364AA33
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiLLW0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiLLWZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:25:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E891AA10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:25:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rFA-0004ed-Aj; Mon, 12 Dec 2022 23:25:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rF8-00477B-3Y; Mon, 12 Dec 2022 23:25:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rF8-004boY-8L; Mon, 12 Dec 2022 23:25:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/3] soc: bcm: bcm2835-power: Drop empty platform remove function
Date:   Mon, 12 Dec 2022 23:25:47 +0100
Message-Id: <20221212222549.3779846-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
References: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=847; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YA9WoGHoY7R972abK95mgPE3N7JNtOTwwwX67OXM7D8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjl6phLvpuJT7rc+GZCKmx/3Cghq6shy0PKwzjgBwu PON5wPCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY5eqYQAKCRDB/BR4rcrsCdYVB/ 4r7dxLFRFOBn+PPwI3rMvLE2OkSoNYxTOw9Js97zD/pPpczI6rlb+Otgc9w1oAFTvG91dxyKbcIc99 THwWbX2aORuFk5gGotUm6/aoQrZKCdVQQzVyJAGUtuLGehp29uOMjwSephYvNqLhiOa2aIMh44Z33r EtlBCWyZp5SDuEdfxKJE9diZRhUBkw1YgMRpW3ufomkeNqHKxkRZsBwo9OHEaDWKc4PQwvFjP/jrQG BNPSU7OnniZHMneb8nLHlbW41hzDdEvpJPWXBtY4KHLvEOJ9N1KDEFm/c8NOYW0aw9iOXqxVHjOSdR muXZunkIdeNepqzG6h9SHxGBjnF9Md
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A remove callback just returning 0 is equivalent to no remove callback
at all. So drop the useless function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/bcm/bcm2835-power.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 5bcd047768b6..bf51f03f77d6 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -701,14 +701,8 @@ static int bcm2835_power_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm2835_power_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver bcm2835_power_driver = {
 	.probe		= bcm2835_power_probe,
-	.remove		= bcm2835_power_remove,
 	.driver = {
 		.name =	"bcm2835-power",
 	},
-- 
2.38.1

