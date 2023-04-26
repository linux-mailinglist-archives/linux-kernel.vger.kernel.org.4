Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BD56EF0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbjDZJOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbjDZJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D404226;
        Wed, 26 Apr 2023 02:12:35 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQK9TSaek0IhyUumlIsOAJS3PZ7m3d2pI3cWfiwZNFc=;
        b=pYW406mZuUwIQoe110TwEWGYRnC072R20Y1Dp+CX17axv+zT+nRXCtqX1YjcQHJ5vsFEPK
        Wsa2wvgYbgEbQHMAcIRGmz15XuNh6fmF6gwqhCgmw7Dnumf/B6THSSd9WH2djgmR+Gb5ik
        nh9osI5+oGqIb2tDOB7O8xma2IH0x8veG3QpvD1zUX7dLTjnUzx3Z/Gkxzf1BX5WtONeGi
        a6k5h+KmzfAQUJgkOkFirybRambo7PogekRPOYn24wonjqUIeiz7Nv62D1NKuHXQLheGX+
        I0wYXEFs3mOlaax0pIe/8K2hzWrApLgNvUVmdajHrDD3vlFi8jzt4lTpbQChhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQK9TSaek0IhyUumlIsOAJS3PZ7m3d2pI3cWfiwZNFc=;
        b=lRYX/C8ZohkKIkm6KQtT1VAZZrlkbf98/jupUls321+w4Haf8YI1ab/mf7HjWXUkU1AYF0
        dJ4fKxYQWtJ2xCDQ==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sh_mtu2: Mark driver as non-removable
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230313075430.2730803-2-u.kleine-koenig@pengutronix.de>
References: <20230313075430.2730803-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <168250035266.404.6498503358644410758.tip-bot2@tip-bot2>
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

Commit-ID:     78012e3880a62e0eb130a0b5a10230162ad42a06
Gitweb:        https://git.kernel.org/tip/78012e3880a62e0eb130a0b5a10230162ad=
42a06
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Mon, 13 Mar 2023 08:54:26 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:13 +02:00

clocksource/drivers/sh_mtu2: Mark driver as non-removable

The comment in the remove callback suggests that the driver is not
supposed to be unbound. However returning an error code in the remove
callback doesn't accomplish that. Instead set the suppress_bind_attrs
property (which makes it impossible to unbind the driver via sysfs).
The only remaining way to unbind a sh_tmu2 device would be module
unloading, but that doesn't apply here, as the driver cannot be built as
a module.

Also drop the useless remove callback.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230313075430.2730803-2-u.kleine-koenig@peng=
utronix.de
---
 drivers/clocksource/sh_mtu2.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 169a1fc..6bd2d02 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -484,11 +484,6 @@ static int sh_mtu2_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int sh_mtu2_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent */
-}
-
 static const struct platform_device_id sh_mtu2_id_table[] =3D {
 	{ "sh-mtu2", 0 },
 	{ },
@@ -503,10 +498,10 @@ MODULE_DEVICE_TABLE(of, sh_mtu2_of_table);
=20
 static struct platform_driver sh_mtu2_device_driver =3D {
 	.probe		=3D sh_mtu2_probe,
-	.remove		=3D sh_mtu2_remove,
 	.driver		=3D {
 		.name	=3D "sh_mtu2",
 		.of_match_table =3D of_match_ptr(sh_mtu2_of_table),
+		.suppress_bind_attrs =3D true,
 	},
 	.id_table	=3D sh_mtu2_id_table,
 };
