Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC78F694F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBMS0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjBMS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CECA2103;
        Mon, 13 Feb 2023 10:26:27 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUYW88Z3PvwE7weQUKwxFw/NWF6SI7hmAUO2Ck8gTCg=;
        b=pAjik7xIa0Ys/v/btmFOeilYCYlpZEgMTC2TiDuPIP4N5sdRUULDW4zCL7WJ4ou8xeANhr
        8G7U5MP/cfRQG2kDadPSbw31zS4HSwLbd37OHnmqTTuPblx2gsSSGsxstPjPRds88qUbZE
        4s1kSE33FavgHULJ9W3jLVnUrixQ4lyzZYNrKTSHk3OC2ao0mZmA1d1uqcmor43aKdOJmp
        /E4GrGrLAMzUW625cDcaU1sNN9qc0eGgj72EioKh3YWol7fMZDn8AXAz5xkJXpM9/EUMJI
        1qqCFWviFK5wmbm2q2/yhAytqJ7XLawMwpzHYsEf5pusd/x5fyg77pnm6pf9aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUYW88Z3PvwE7weQUKwxFw/NWF6SI7hmAUO2Ck8gTCg=;
        b=79j+AQ5B860yhzGfNAG7LsO4Gg90zIy8fT3Kr6XS0IdCy64OI0E9sT0osPgPry7kIn25ti
        l42PdGAmfPQew9Dg==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sh_cmt: Mark driver as non-removable
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230123220221.48164-1-u.kleine-koenig@pengutronix.de>
References: <20230123220221.48164-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <167631278391.4906.3345100760900674930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c3daa4754f3c57231bf47dcf4bdf897bc5c5f1f1
Gitweb:        https://git.kernel.org/tip/c3daa4754f3c57231bf47dcf4bdf897bc5c=
5f1f1
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Mon, 23 Jan 2023 23:02:21 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:17 +01:00

clocksource/drivers/sh_cmt: Mark driver as non-removable

The comment in the remove callback suggests that the driver is not
supposed to be unbound. However returning an error code in the remove
callback doesn't accomplish that. Instead set the suppress_bind_attrs
property (which makes it impossible to unbind the driver via sysfs).
The only remaining way to unbind a sh_cmt device would be module
unloading, but that doesn't apply here, as the driver cannot be built as
a module.

Also drop the useless remove callback.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230123220221.48164-1-u.kleine-koenig@pengut=
ronix.de
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_cmt.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 7b952aa..8b2e079 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1145,17 +1145,12 @@ static int sh_cmt_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int sh_cmt_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent and clocksource */
-}
-
 static struct platform_driver sh_cmt_device_driver =3D {
 	.probe		=3D sh_cmt_probe,
-	.remove		=3D sh_cmt_remove,
 	.driver		=3D {
 		.name	=3D "sh_cmt",
 		.of_match_table =3D of_match_ptr(sh_cmt_of_table),
+		.suppress_bind_attrs =3D true,
 	},
 	.id_table	=3D sh_cmt_id_table,
 };
