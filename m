Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64D8694F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjBMS0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBMS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AABA6EB5;
        Mon, 13 Feb 2023 10:26:24 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGg2QXQKl2CgLX1ZcBsVOjfuAPw42Vx4U2RONkij9ec=;
        b=CH9GC2WFCixUvaf78/HF1IpsR8TXSjL9De8kbUDOw9sD/IsupvEpMUZX92zfoju9x9LXAF
        Fz0ILrWr/J99jYmTr12TcuGBaUjIFSVF8QKfsfiEHgsQ4jU1B2YcTrCyQ7tg5zHzeHSWgs
        Npzc8Fpxc8Tp0E7Nsi3utqBImi9EMb7cJqUFvqMBTkJYMDHGHBDLkyjqRvR0QILLo8sUxW
        017Csp3lcXBMAKgQYzEF07mJaelJqE/WKNnyAOqCSXk/pnEXoO8o6SCGCllW+zddEORGVj
        RcmJloeCC6XSD9PY2rbW9JEcBi7Xn6R1OTbYUjKhRsuKYEMaEhfAsFlqWwihgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGg2QXQKl2CgLX1ZcBsVOjfuAPw42Vx4U2RONkij9ec=;
        b=E78YwoE8OdA/N1opVM1T3RKE3AhF1uQfswOyd/IaxZ21qzOODbNq6G83u+bsrgRFjPyHbI
        n8hKJoe+U79ZQDDA==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sh_tmu: Mark driver as non-removable
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230207193614.472060-1-u.kleine-koenig@pengutronix.de>
References: <20230207193614.472060-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <167631278189.4906.11559302770332050280.tip-bot2@tip-bot2>
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

Commit-ID:     d8c695d310a8607fd1d6a2750368467c4e0cef6a
Gitweb:        https://git.kernel.org/tip/d8c695d310a8607fd1d6a2750368467c4e0=
cef6a
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Tue, 07 Feb 2023 20:36:14 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:17 +01:00

clocksource/drivers/sh_tmu: Mark driver as non-removable

The comment in the remove callback suggests that the driver is not
supposed to be unbound. However returning an error code in the remove
callback doesn't accomplish that. Instead set the suppress_bind_attrs
property (which makes it impossible to unbind the driver via sysfs).
The only remaining way to unbind a sh_tmu device would be module
unloading, but that doesn't apply here, as the driver cannot be built as
a module.

Also drop the useless remove callback.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230207193614.472060-1-u.kleine-koenig@pengu=
tronix.de
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_tmu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index b00dec0..932f31a 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -632,11 +632,6 @@ static int sh_tmu_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int sh_tmu_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent and clocksource */
-}
-
 static const struct platform_device_id sh_tmu_id_table[] =3D {
 	{ "sh-tmu", SH_TMU },
 	{ "sh-tmu-sh3", SH_TMU_SH3 },
@@ -652,10 +647,10 @@ MODULE_DEVICE_TABLE(of, sh_tmu_of_table);
=20
 static struct platform_driver sh_tmu_device_driver =3D {
 	.probe		=3D sh_tmu_probe,
-	.remove		=3D sh_tmu_remove,
 	.driver		=3D {
 		.name	=3D "sh_tmu",
 		.of_match_table =3D of_match_ptr(sh_tmu_of_table),
+		.suppress_bind_attrs =3D true,
 	},
 	.id_table	=3D sh_tmu_id_table,
 };
