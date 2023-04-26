Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F696EF0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbjDZJNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbjDZJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7206C4487;
        Wed, 26 Apr 2023 02:12:35 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNXgzTy+QeO7E1VlP5wXZTqBLDL997Vo79lkZlCNccM=;
        b=UNWDPUuaecbyJcp9fYT8D5lgD76P3pfGIrxFxm3fdKjmijtJ/8qWCEW0j3Q7blgmHPEmsu
        nGOtIt9x9HbggxIMW3Y885zjXSr+A2repewews/17sJ9wtZ1MBC8I7Bb0KBfSJ5/JGwWYC
        EQB2CY4UuxP+xWPPTlE+S4vAeYABGyhjUo5T+E/zfqtsfeCjZDMlLo8dqYfU4/0BCGi579
        ol6pOX1uLdIvWAbZAZ70b6zvoc22c5GUs7RCd0uFmjhp+T76++qdZ/wifhVhNzBPu//E/P
        vO3Czj8AqU79XfntixsxUI6Ujxng8K0QL1Qt/Btwf7/NLLVWCLmJ6ZgtQjRG7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500352;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNXgzTy+QeO7E1VlP5wXZTqBLDL997Vo79lkZlCNccM=;
        b=HgS3za8wZeC+yB4jFTLqXmJwwh9JEmgVtg4BatkDHaxH5ywA8SSJP1W7XgNJmV8Q8dE0Ht
        5aS73n0zsGY0ZDAQ==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-stm32-lp: Mark driver as
 non-removable
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230313075430.2730803-3-u.kleine-koenig@pengutronix.de>
References: <20230313075430.2730803-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <168250035240.404.8830089641941944537.tip-bot2@tip-bot2>
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

Commit-ID:     ede38f924a9e3c60382a13576347dc41967e8762
Gitweb:        https://git.kernel.org/tip/ede38f924a9e3c60382a13576347dc41967=
e8762
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Mon, 13 Mar 2023 08:54:27 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:13 +02:00

clocksource/drivers/timer-stm32-lp: Mark driver as non-removable

The comment in the remove callback suggests that the driver is not
supposed to be unbound. However returning an error code in the remove
callback doesn't accomplish that. Instead set the suppress_bind_attrs
property (which makes it impossible to unbind the driver via sysfs).
The only remaining way to unbind an stm32-lp device would be module
unloading, but that doesn't apply here, as the driver cannot be built as
a module.

Also drop the useless remove callback.

[dlezcano] : Fixed up the wrong function removed

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230313075430.2730803-3-u.kleine-koenig@peng=
utronix.de
---
 drivers/clocksource/timer-stm32-lp.c |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer=
-stm32-lp.c
index db2841d..0adf22d 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -195,11 +195,6 @@ out_clk_disable:
 	return ret;
 }
=20
-static int stm32_clkevent_lp_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent */
-}
-
 static const struct of_device_id stm32_clkevent_lp_of_match[] =3D {
 	{ .compatible =3D "st,stm32-lptimer-timer", },
 	{},
@@ -207,11 +202,11 @@ static const struct of_device_id stm32_clkevent_lp_of_m=
atch[] =3D {
 MODULE_DEVICE_TABLE(of, stm32_clkevent_lp_of_match);
=20
 static struct platform_driver stm32_clkevent_lp_driver =3D {
-	.probe	=3D stm32_clkevent_lp_probe,
-	.remove =3D stm32_clkevent_lp_remove,
+	.probe  =3D stm32_clkevent_lp_probe,
 	.driver	=3D {
 		.name =3D "stm32-lptimer-timer",
 		.of_match_table =3D of_match_ptr(stm32_clkevent_lp_of_match),
+		.suppress_bind_attrs =3D true,
 	},
 };
 module_platform_driver(stm32_clkevent_lp_driver);
