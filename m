Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49F773DAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFZJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFZJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:13:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C4ED9;
        Mon, 26 Jun 2023 02:11:39 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:11:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687770698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnyTaUvOTvBb93XLT3gmUFtDtDXy4QoVu3JMYssCDZ0=;
        b=vyvhWQqLzpXtNjfc6SpHXIUWzBmg2Vq09wJqtJvf6H1ALSyAFa+hWb2nzHASJpJgylJK9Z
        +bEHp1OHKjvJrTPcsY7CkF+W46sLFwWKX7JORFeuLfB5cCXTN3eJvA8H1Pn8hhhmlJohSy
        rZ+1lfoBXfTkPz37GqHD7AY965jDUIFmxEik6pfhXaZtXejkGQsBRYj1iQE+OS08Ai/mRD
        JO0+fIpH0HE7jcUB+UIfknupFfn6BmCHHeS38TiVztprY74I1XdtYr5cbjA2sSvcFS0mC6
        lMbNJ3qMfjhqBJ05nZM8ypyKaterz0mkM1bCy2XjsmqdRcrMF+ep1VQ3GX2FZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687770698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnyTaUvOTvBb93XLT3gmUFtDtDXy4QoVu3JMYssCDZ0=;
        b=miFbMEMZxh9av0ssEl4mIvzMzXIvM2W6o7hoX+YqgtIpExb1buCSZZvGLfTcFozZ520SCB
        osafnYR4jNQL45DQ==
From:   tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clk: imx: Drop inclusion of unused header
 <soc/imx/timer.h>
Cc:     u.kleine-koenig@pengutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230328100531.879485-2-u.kleine-koenig@pengutronix.de>
References: <20230328100531.879485-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Message-ID: <168777069783.404.11447699538733523877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     011da162da2f915989a571b557867f7eea699000
Gitweb:        https://git.kernel.org/tip/011da162da2f915989a571b557867f7eea6=
99000
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Tue, 28 Mar 2023 12:05:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 23 Jun 2023 09:33:43 +02:00

clk: imx: Drop inclusion of unused header <soc/imx/timer.h>

The clk drivers use none of the symbols defined in <soc/imx/timer.h>.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230328100531.879485-2-u.kleine-koenig@pengu=
tronix.de
---
 drivers/clk/imx/clk-imx1.c  | 1 -
 drivers/clk/imx/clk-imx27.c | 1 -
 drivers/clk/imx/clk-imx31.c | 1 -
 drivers/clk/imx/clk-imx35.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx1.c b/drivers/clk/imx/clk-imx1.c
index 22fc749..f6ea7e5 100644
--- a/drivers/clk/imx/clk-imx1.c
+++ b/drivers/clk/imx/clk-imx1.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx1-clock.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
=20
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index 5d17712..99618de 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -8,7 +8,6 @@
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx27-clock.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
=20
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index c44e18c..4c8d9ff 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -11,7 +11,6 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
=20
 #include "clk.h"
diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index 7dcbaea..3b6fdb4 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/err.h>
 #include <soc/imx/revision.h>
-#include <soc/imx/timer.h>
 #include <asm/irq.h>
=20
 #include "clk.h"
