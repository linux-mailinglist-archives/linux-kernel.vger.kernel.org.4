Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960606EF0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbjDZJND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbjDZJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A72420F;
        Wed, 26 Apr 2023 02:12:34 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGAJjuVajFTqz5VQpTt1LrqF3WkHJWal8RsfcvGbvSg=;
        b=qmx6ZHIOwgnvRaH+qPXEWf426o4hsGxYGoowUsFy5eDJ7dyjo0R/PeT4YqUb3twMn0znys
        H1lzderR70fAxe9NieaeqIfHeb0VyDz5oMevYwR23s719U+H45EbwiXon8xNNsBQyhNah9
        oFYJ06QLCzKzY7g801UJwAbPYGfmA883b7n1DxDg/yFI0Zw+r/ME87AmcEaLzXrz/2QlwU
        iRdnTb7IKjXNM/Cu1cKgCeEY5wxtUpNP2xP9DF7/wiLyPr8p0VOaCmH3fVtnYk7pTAh8Jr
        jSB9IPWSApphMhh46hyNXViHHv0q+qWBZ/UwL/l42lIYeVDtwPt6odBW37XNUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGAJjuVajFTqz5VQpTt1LrqF3WkHJWal8RsfcvGbvSg=;
        b=86zCoIGf2i/7uRwfBAdx77s+CWHxt/KaNHnqSgGfrN7XIPfr4/6sSuH2kmgm/CEvauVr81
        ZOH3FhCOWP3N7+Aw==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Convert to
 platform remove callback returning void
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230313075430.2730803-6-u.kleine-koenig@pengutronix.de>
References: <20230313075430.2730803-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <168250035161.404.623276263898104408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b1f0390048e2641d3451f8cdbbef24c79d1a8fdd
Gitweb:        https://git.kernel.org/tip/b1f0390048e2641d3451f8cdbbef24c79d1=
a8fdd
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Mon, 13 Mar 2023 08:54:30 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:13 +02:00

clocksource/drivers/timer-ti-dm: Convert to platform remove callback returnin=
g void

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230313075430.2730803-6-u.kleine-koenig@peng=
utronix.de
---
 drivers/clocksource/timer-ti-dm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index 098562b..ab7a6ca 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1177,7 +1177,7 @@ err_disable:
  * In addition to freeing platform resources it also deletes the timer
  * entry from the local list.
  */
-static int omap_dm_timer_remove(struct platform_device *pdev)
+static void omap_dm_timer_remove(struct platform_device *pdev)
 {
 	struct dmtimer *timer;
 	unsigned long flags;
@@ -1199,8 +1199,6 @@ static int omap_dm_timer_remove(struct platform_device =
*pdev)
=20
 	if (ret)
 		dev_err(&pdev->dev, "Unable to determine timer entry in list of drivers on=
 remove\n");
-
-	return 0;
 }
=20
 static const struct omap_dm_timer_ops dmtimer_ops =3D {
@@ -1275,7 +1273,7 @@ MODULE_DEVICE_TABLE(of, omap_timer_match);
=20
 static struct platform_driver omap_dm_timer_driver =3D {
 	.probe  =3D omap_dm_timer_probe,
-	.remove =3D omap_dm_timer_remove,
+	.remove_new =3D omap_dm_timer_remove,
 	.driver =3D {
 		.name   =3D "omap_timer",
 		.of_match_table =3D omap_timer_match,
