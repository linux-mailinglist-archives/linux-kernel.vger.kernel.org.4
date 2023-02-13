Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0C0694F40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjBMS0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjBMS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BA026AE;
        Mon, 13 Feb 2023 10:26:23 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9C/RHQ23PWQE6219xLIoTf2rCC7qnKzbFR98gTwWxA=;
        b=mzk9w/lqw0bnr7GqZJbONsR5+eD93+wiTTjo9RtvEM7OIMMsyEwpA7bhUVCmo9mvOT1FMF
        QzfHRI6PqDMDwJ5HMNAOJE1KCfTu575tp4FHfOxz889/eAynhEyssZkbrNpOthGTYSn98R
        LpF0tK1XyiH6KSitJL2jL/2FJ7LpKMzhXSltFHo48R8ZUKZSD79JFqqx1Ek9TYd+qMNNSY
        SNLs4O29UG+GenC0REgPu5+wB1FDN49LA+KNvuZiRPV8bxDxpEibv/WsVqNP0TG1DF2HYT
        0PIHK2ftYd0uVN+titKN5AsPge04tsCmPVcoJGchjpLqsUHW/mRRkCHugAPjwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9C/RHQ23PWQE6219xLIoTf2rCC7qnKzbFR98gTwWxA=;
        b=G0E9vtzzmJ4o2ihBKm5A1LPVYdQA9yCN2ud+IFyxpgvLYCu8O0YTYBt/KAIlkK29ktbH0o
        DGBD3eCwcIxP7rAg==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/em_sti: Mark driver as non-removable
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230207193010.469495-1-u.kleine-koenig@pengutronix.de>
References: <20230207193010.469495-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <167631278165.4906.17139987456534507798.tip-bot2@tip-bot2>
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

Commit-ID:     cf16f631b0bbd98df4b2ccc13346f564412eae68
Gitweb:        https://git.kernel.org/tip/cf16f631b0bbd98df4b2ccc13346f564412=
eae68
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Tue, 07 Feb 2023 20:30:10 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:17 +01:00

clocksource/drivers/em_sti: Mark driver as non-removable

The comment in the remove callback suggests that the driver is not
supposed to be unbound. However returning an error code in the remove
callback doesn't accomplish that. Instead set the suppress_bind_attrs
property (which makes it impossible to unbind the driver via sysfs).
The only remaining way to unbind a em_sti device would be module
unloading, but that doesn't apply here, as the driver cannot be built as
a module.

Also drop the useless remove callback.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230207193010.469495-1-u.kleine-koenig@pengu=
tronix.de
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/em_sti.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index ab190df..c04b47b 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -333,11 +333,6 @@ static int em_sti_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int em_sti_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent and clocksource */
-}
-
 static const struct of_device_id em_sti_dt_ids[] =3D {
 	{ .compatible =3D "renesas,em-sti", },
 	{},
@@ -346,10 +341,10 @@ MODULE_DEVICE_TABLE(of, em_sti_dt_ids);
=20
 static struct platform_driver em_sti_device_driver =3D {
 	.probe		=3D em_sti_probe,
-	.remove		=3D em_sti_remove,
 	.driver		=3D {
 		.name	=3D "em_sti",
 		.of_match_table =3D em_sti_dt_ids,
+		.suppress_bind_attrs =3D true,
 	}
 };
=20
