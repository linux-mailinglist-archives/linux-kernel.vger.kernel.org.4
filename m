Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DD35F3FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiJDJbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJDJ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D74D2E9CB;
        Tue,  4 Oct 2022 02:27:28 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biHS/6afv08hz9ohIcnhdTXRTY5pfINVf58sOAMYA84=;
        b=QvgF5rkbD8uLj0r6RD6iKHrzRz8IIQClpPoWCoxIcDGNH2FkdUZEsJug4QvpTUj//OfSfg
        v9TbbG0EvoWa5H7paQNmizWJ7kOobho2sZuxpP9eTZdow5A+cP8kC+4lE003pFOoImgieC
        39JdlJVJykMn0VlU+0BF1O/JLwh+X4lo4hgo07PdveNCTXu1f2xiB/DyXK1XdkiyULK6/L
        lCIeZPw+d7P6PEK1NkvXxgICFRqbgkPfzGeH6BsQeAgWY5yW0ZDpONwJpZ9Xv93tMZ4YsD
        MQ69MryJYzGNODISKJDitE/x5o6cNUb080SDt87b32V7urxME15gerClMiXEPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biHS/6afv08hz9ohIcnhdTXRTY5pfINVf58sOAMYA84=;
        b=tWP0nNdXj1RG85VGEv30Wq0sP4LSV4j3jy9qFcn+rT+aXqaRKPdI3XbvOAEoHcIzyeUsjW
        6EL+JoYw/XWcAhDA==
From:   "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/renesas-ostm: Add support for
 RZ/V2L SoC
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220907080056.3460-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220907080056.3460-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <166487564588.401.1151960893998483436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     eaa1a955094b20ca4b1c5064200d140b27f8d96f
Gitweb:        https://git.kernel.org/tip/eaa1a955094b20ca4b1c5064200d140b27f8d96f
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Wed, 07 Sep 2022 09:00:56 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 07 Sep 2022 10:12:56 +02:00

clocksource/drivers/renesas-ostm: Add support for RZ/V2L SoC

The OSTM block is identical on Renesas RZ/G2L and RZ/V2L SoC's, so instead
of adding dependency for each SoC's add dependency on ARCH_RZG2L. The
ARCH_RZG2L config option is already selected by ARCH_R9A07G044 and
ARCH_R9A07G054.

With the above change OSTM will be enabled on RZ/V2L SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220907080056.3460-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/renesas-ostm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 21d1392..8da972d 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -224,7 +224,7 @@ err_free:
 
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
 
-#ifdef CONFIG_ARCH_R9A07G044
+#ifdef CONFIG_ARCH_RZG2L
 static int __init ostm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
