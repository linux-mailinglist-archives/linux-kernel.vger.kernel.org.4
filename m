Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117C36EF0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbjDZJNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbjDZJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6084219;
        Wed, 26 Apr 2023 02:12:35 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MgZCJQCK3AX5WcTn6XiMT44OCvMHe53xr/eNTpm8o2c=;
        b=yaXS9Y39lAg8WsrZ1mUlGZtU9NXBtRY/KhOP5Rn+O0cnoN+GfwOe9yS6WRKn2UDs5uC8Hu
        +FwPdpRU3mUEHwrnztlFOWoJ7IYCF6+uqPDPO/u/pY31C1yq2FMvjoHq4LZIqhe6vV/aSU
        Ke9Yg2MARZFSnWKZMhBpiI9jN4y1YG/f3vwvu9nICkUBThcQAbV6Rmq/SO6vCvIef74i/6
        JtiUlEmNmCmBJ0LzJgNaE7mnWhtx8JUw3uvxdK6XRlGCG/iy96Bx7cgI7ullmWoVV0YHv9
        lLPuodX3CfvI3ZmfBPVjboYEqedYBd4lKMxyjg3M9Z8j0AwR227CxnXg5rGPFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MgZCJQCK3AX5WcTn6XiMT44OCvMHe53xr/eNTpm8o2c=;
        b=Q6y6/ZBd3H+yWomhb8iiRTxb3DiAqGtLobfJRARbDkEz4PV5/B9SYUeI2qAZ4cmKG1aHpO
        2+vblywE9jq4DmAQ==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-tegra186: Convert to
 platform remove callback returning void
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230313075430.2730803-5-u.kleine-koenig@pengutronix.de>
References: <20230313075430.2730803-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <168250035186.404.12792243780091538646.tip-bot2@tip-bot2>
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

Commit-ID:     d7b76421c03fa58d16a52eb839302f582602997a
Gitweb:        https://git.kernel.org/tip/d7b76421c03fa58d16a52eb839302f58260=
2997a
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Mon, 13 Mar 2023 08:54:29 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:13 +02:00

clocksource/drivers/timer-tegra186: Convert to platform remove callback retur=
ning void

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
Link: https://lore.kernel.org/r/20230313075430.2730803-5-u.kleine-koenig@peng=
utronix.de
---
 drivers/clocksource/timer-tegra186.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
index ea74288..ccc762d 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -447,15 +447,13 @@ unregister_tsc:
 	return err;
 }
=20
-static int tegra186_timer_remove(struct platform_device *pdev)
+static void tegra186_timer_remove(struct platform_device *pdev)
 {
 	struct tegra186_timer *tegra =3D platform_get_drvdata(pdev);
=20
 	clocksource_unregister(&tegra->usec);
 	clocksource_unregister(&tegra->osc);
 	clocksource_unregister(&tegra->tsc);
-
-	return 0;
 }
=20
 static int __maybe_unused tegra186_timer_suspend(struct device *dev)
@@ -505,7 +503,7 @@ static struct platform_driver tegra186_wdt_driver =3D {
 		.of_match_table =3D tegra186_timer_of_match,
 	},
 	.probe =3D tegra186_timer_probe,
-	.remove =3D tegra186_timer_remove,
+	.remove_new =3D tegra186_timer_remove,
 };
 module_platform_driver(tegra186_wdt_driver);
=20
