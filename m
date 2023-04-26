Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5B66EF0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbjDZJOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbjDZJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448A04498;
        Wed, 26 Apr 2023 02:12:36 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRL5IJ3LvDMVfAYC6WdsWyyoMjS8QGI98YOz7VpmQSQ=;
        b=jerJTNNtNMWGytAmrZZyB3vjldG7IJ/ILpl1hi8ofttnxbgN6xXI5WD0ULcKcZC6Wgn1E+
        j01rah3FAWrQcqKdoCDTRaeFuk2iJK894w30mLXxAnt5Da7A96DNDZ0rzxGVd9I+tTcD57
        +UkDUdCVOfbAksmIf5EqSL+V8xHxHK1J5eC3BNNj1MKAFOR870EBvaaIWeQmu+vMMCiWdh
        hsqTHkKj0EOUbxLTtv7W1FwrWInylRb1VVE+GDzH/nHKUATMYk/5t/lU36JMqmuYuJgKMz
        ART9BveDZnRxHspGdNR133m9Mm2SgjA+roUwmLffimOaJWey+/x+hMQYNPgLSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mRL5IJ3LvDMVfAYC6WdsWyyoMjS8QGI98YOz7VpmQSQ=;
        b=/HOeLQduLTG3WMBbf9ZhqjJoY5uhMYtcba7K8wDD8j7HZv1wy0zNqU6WeFYqppdB+GFc3A
        Q4jQWIUBhc7/KhBg==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Explicitly return
 0 for shared timer
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230403094017.9556-1-krzysztof.kozlowski@linaro.org>
References: <20230403094017.9556-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Message-ID: <168250035379.404.8034849977129225526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Commit-ID:     fd3f088f35f610a7ee3045b7d172b362342e43c6
Gitweb:        https://git.kernel.org/tip/fd3f088f35f610a7ee3045b7d172b362342e43c6
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Mon, 03 Apr 2023 11:40:17 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:13 +02:00

clocksource/drivers/exynos_mct: Explicitly return 0 for shared timer

For a shared timers, the mct_init_dt() should not initialize the clock
even with global comparator.  This is not an error, thus the function
should simply return 0, not 'ret'.

This also fixes smatch warning:

  drivers/clocksource/exynos_mct.c:635 mct_init_dt() warn: missing error code? 'ret'

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202304021446.46XVKag0-lkp@intel.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230403094017.9556-1-krzysztof.kozlowski@linaro.org
---
 drivers/clocksource/exynos_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index bfd6009..ef8cb1b 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -682,7 +682,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	 * processor cannot use the global comparator.
 	 */
 	if (frc_shared)
-		return ret;
+		return 0;
 
 	return exynos4_clockevent_init();
 }
