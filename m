Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3FD694F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBMS04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjBMS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82726A0;
        Mon, 13 Feb 2023 10:26:27 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oeIxNcJGhJgVEJwKpljqbeMcT0vvyc7FTzOciIsVa6E=;
        b=Z3vjtcRSgJXZkXThdqMlIucnonhr0izGkoi9idf5/MNN9yuBj9pQOYNpuQ1/sBEMd47bcN
        GeS895VvMV9t3dMpa5ElY83UDAGP0LCvPiIgjorAVTMd2hvFs+ID1AqZwq3vNgrhGkOYCX
        niOAJ1oGTIuqvsZd0wS08ilj9yfPPLHsGF/pjH7MZJEAxn/wWOvyGQ1K1D65v6AbkTB+YY
        n0tEEt2lBQIRnvT7AuCAtIwxaHP0aMKy8oX7g2L9jGtn15r+xX8DE9aJE6xwBaAUYGHDXm
        f/dOhAZt8KRNMcSGTADR6jgWOyOxN3pc/biiZnjxv3hc7iMCAqCZkdsMl/GwoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oeIxNcJGhJgVEJwKpljqbeMcT0vvyc7FTzOciIsVa6E=;
        b=nqqCUxqUiG2KjYo5At4NawT83xWLqiXQ5pfwzCgmgCE4fa5DhzB59PN8tDVYfeNGt+zykq
        xGf/dnJx9DB4ZNDw==
From:   "tip-bot2 for Jean Delvare" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-microchip-pit64b: Drop
 obsolete dependency on COMPILE_TEST
Cc:     Jean Delvare <jdelvare@suse.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230121182911.4e47a5ff@endymion.delvare>
References: <20230121182911.4e47a5ff@endymion.delvare>
MIME-Version: 1.0
Message-ID: <167631278418.4906.16991122690299378770.tip-bot2@tip-bot2>
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

Commit-ID:     8d17aca90bcf36833271de6531edb58a91c40e9f
Gitweb:        https://git.kernel.org/tip/8d17aca90bcf36833271de6531edb58a91c40e9f
Author:        Jean Delvare <jdelvare@suse.de>
AuthorDate:    Sat, 21 Jan 2023 18:29:11 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:17 +01:00

clocksource/drivers/timer-microchip-pit64b: Drop obsolete dependency on COMPILE_TEST

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230121182911.4e47a5ff@endymion.delvare
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4469e7f..45085ab 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -706,7 +706,7 @@ config INGENIC_OST
 
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
