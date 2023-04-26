Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465EB6EF0CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbjDZJNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbjDZJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4094225;
        Wed, 26 Apr 2023 02:12:35 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9+tbxi1xwAofZsvJzB71/MMe9Mf2Q8L9QuiXGZM8XI=;
        b=zHx6OnnatuhtH/w3NKyANPISLrIhZ7RLuQ5CjD8JXj4ZDgGKlpau5/RqoTuAjoKcPGu1BV
        K5HEFoRP5eFFpeHdzRjxy3dodJwpMIDYmOMQVteiKGRC3qCbRZC9VyxpMAKyun5LdxX630
        Vyl4KFmoYilRTSU1JhTHWUvBlfdg4oe+djz2tQ0uA4EIb4e3Ah6HDkc13KdsiT8RmqeAvB
        7stJRXCTTnsYIEFEUP9jLyOjmpg6RIKgt4PD2shj5EU/a9Q+hfmYq7w16xZXUOmFTylkVj
        ygkyk23iI2lyaLeIHD39VLhKPGtllLZATt7euYEYe8OYGf2PyEZMNg0DyH7BhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9+tbxi1xwAofZsvJzB71/MMe9Mf2Q8L9QuiXGZM8XI=;
        b=ByiKSqEWbdTQ76iZL11DYGcBTeUzgxariJZvhZSmi1xFy4AoNQRfZOFN1e4/WFqLsYu52S
        dkFZbYcVUcNemeDw==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Improve error
 message in .remove
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230313075430.2730803-4-u.kleine-koenig@pengutronix.de>
References: <20230313075430.2730803-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <168250035216.404.14983446522756531530.tip-bot2@tip-bot2>
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

Commit-ID:     8efcbe927c5129d5b2528bbb40034c7dde87a6b6
Gitweb:        https://git.kernel.org/tip/8efcbe927c5129d5b2528bbb40034c7dde8=
7a6b6
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Mon, 13 Mar 2023 08:54:28 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:13 +02:00

clocksource/drivers/timer-ti-dm: Improve error message in .remove

If a platform driver's remove callback returns an error code, the driver
core emits a generic (and thus little helpful) error message.

Instead emit a more specifc error message about the actual error and
return zero to suppress the core's message.

Note that returning zero has no side effects apart from not emitting
said error message. This prepares converting platform driver's remove
message to return void.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230313075430.2730803-4-u.kleine-koenig@peng=
utronix.de
---
 drivers/clocksource/timer-ti-dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index b24b903..098562b 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1197,7 +1197,10 @@ static int omap_dm_timer_remove(struct platform_device=
 *pdev)
=20
 	pm_runtime_disable(&pdev->dev);
=20
-	return ret;
+	if (ret)
+		dev_err(&pdev->dev, "Unable to determine timer entry in list of drivers on=
 remove\n");
+
+	return 0;
 }
=20
 static const struct omap_dm_timer_ops dmtimer_ops =3D {
