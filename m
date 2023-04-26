Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8659C6EF0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjDZJO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbjDZJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A134495;
        Wed, 26 Apr 2023 02:12:35 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AD++uZqsO1TQvdELJ+jJo+eoOluJlmJJrrN46Beilj4=;
        b=uX/N76n0Pm/oJBlhoLXcuQuEUymv1seEjg6ExkoUq0DTrVesMdomD7iTKHf507Z1COMryY
        bFaN0KZ3UBkiQ1AGkSocY9bR2fWw26QeyKn2BgECXtty0wKLZQV6mTAA820ZCs9qlGnxnI
        zxELjtmAtBujYt2dYthwgn0CWpqueuEV5vLAge1ijEOU1LsoWaGvH2sxFIOXrVZi0J2oF8
        Un2YajMYMtV2YPQs6YTWWoPDOLic2MBMnesWYJmPEAEYiBOJFKZ3UsPhlhFdEfydGV+rvZ
        LCGy+RZbXfWeUgmUlmjmDHLqIpY/KFxNcu4S7uI8jvZagV+XwisWjvT9pbqVgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500353;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AD++uZqsO1TQvdELJ+jJo+eoOluJlmJJrrN46Beilj4=;
        b=12Ef82nXAyJkxsuwWwonCcTPWH9g5OxLJc+4WbdBNovK59W1D30QN4purxWFWm0poONSCc
        zKV70F6F8MM1gqAA==
From:   "tip-bot2 for Fabio Estevam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-imx-gpt: Remove non-DT function
Cc:     Fabio Estevam <festevam@denx.de>, u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307124313.708255-1-festevam@denx.de>
References: <20230307124313.708255-1-festevam@denx.de>
MIME-Version: 1.0
Message-ID: <168250035320.404.1746468610150984093.tip-bot2@tip-bot2>
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

Commit-ID:     f68a40ee4732731f149961abab27a45b6c11f413
Gitweb:        https://git.kernel.org/tip/f68a40ee4732731f149961abab27a45b6c1=
1f413
Author:        Fabio Estevam <festevam@denx.de>
AuthorDate:    Tue, 07 Mar 2023 09:43:13 -03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:13 +02:00

clocksource/drivers/timer-imx-gpt: Remove non-DT function

mxc_timer_init() was originally only used by non-DT i.MX platforms.

i.MX has already been converted to be a DT-only platform.

Remove the unused mxc_timer_init() function.

Signed-off-by: Fabio Estevam <festevam@denx.de>
Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230307124313.708255-1-festevam@denx.de
---
 drivers/clocksource/timer-imx-gpt.c | 19 -------------------
 include/soc/imx/timer.h             |  7 -------
 2 files changed, 26 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-=
imx-gpt.c
index 7b2c70f..ca3e4cb 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -420,25 +420,6 @@ static int __init _mxc_timer_init(struct imx_timer *imxt=
m)
 	return mxc_clockevent_init(imxtm);
 }
=20
-void __init mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type t=
ype)
-{
-	struct imx_timer *imxtm;
-
-	imxtm =3D kzalloc(sizeof(*imxtm), GFP_KERNEL);
-	BUG_ON(!imxtm);
-
-	imxtm->clk_per =3D clk_get_sys("imx-gpt.0", "per");
-	imxtm->clk_ipg =3D clk_get_sys("imx-gpt.0", "ipg");
-
-	imxtm->base =3D ioremap(pbase, SZ_4K);
-	BUG_ON(!imxtm->base);
-
-	imxtm->type =3D type;
-	imxtm->irq =3D irq;
-
-	_mxc_timer_init(imxtm);
-}
-
 static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_ty=
pe type)
 {
 	struct imx_timer *imxtm;
diff --git a/include/soc/imx/timer.h b/include/soc/imx/timer.h
index b888d50..25f29c6 100644
--- a/include/soc/imx/timer.h
+++ b/include/soc/imx/timer.h
@@ -13,11 +13,4 @@ enum imx_gpt_type {
 	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
 };
=20
-/*
- * This is a stop-gap solution for clock drivers like imx1/imx21 which call
- * mxc_timer_init() to initialize timer for non-DT boot.  It can be removed
- * when these legacy non-DT support is converted or dropped.
- */
-void mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type);
-
 #endif  /* __SOC_IMX_TIMER_H__ */
