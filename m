Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510A95F3FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiJDJag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D0CE0C6;
        Tue,  4 Oct 2022 02:27:23 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ucu2pxOFWa9YmhWK6Ml0myyRN1b9Zg5sURvvP5cu93o=;
        b=iAm+4hwaZC0/no3fqkDBunOO47PryBpLJAMdN+LEWsPmI1y4Ph1rY23vOYHr0QEhRUHrTm
        EQZakn7OX2M8TMfn8Rp3PiKyadHU5Tn6fxTorRRkAVBJPwtrXhDdC6W089+0VhoB108Vos
        WnY1G/wYhkvicCa5bdylUrqyhW60eUTqImDb+Iu31JWKKcQh66D+UiLMPcqJwf2G+JMCh2
        MNIcWkzLKmJnMDlWwN8+ZcDG+0ExvLVwstLknkI7/OoqJOlPcXu7/GbJLCfSjYlpTZZgAt
        41no2/8ry5rYyJv/frPBWJPY1RmREDylIKAaIlI3jazRMHObKUW420HDKeD7NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ucu2pxOFWa9YmhWK6Ml0myyRN1b9Zg5sURvvP5cu93o=;
        b=IUUckWM5wXIHKJ1T3Jpjf+3jxKz3dN7PQTvoKBb9+bA7+xH6a/LkI8Rn8NsP7xaakP64T8
        1sEOJMpxhuDRGJCQ==
From:   "tip-bot2 for Vincent Whitchurch" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Enable building on ARTPEC
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220609112738.359385-5-vincent.whitchurch@axis.com>
References: <20220609112738.359385-5-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Message-ID: <166487564059.401.6259173309737962773.tip-bot2@tip-bot2>
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

Commit-ID:     55ccdab79524ce9a46965af6e1908b90fa92b303
Gitweb:        https://git.kernel.org/tip/55ccdab79524ce9a46965af6e1908b90fa92b303
Author:        Vincent Whitchurch <vincent.whitchurch@axis.com>
AuthorDate:    Thu, 09 Jun 2022 13:27:38 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:45 +02:00

clocksource/drivers/exynos_mct: Enable building on ARTPEC

This timer block is used on ARTPEC-8.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Link: https://lore.kernel.org/r/20220609112738.359385-5-vincent.whitchurch@axis.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4f2bb73..4469e7f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -434,7 +434,7 @@ config ATMEL_TCB_CLKSRC
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
-	depends on ARCH_EXYNOS || COMPILE_TEST
+	depends on ARCH_ARTPEC || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  Support for Multi Core Timer controller on Exynos SoCs.
 
