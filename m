Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329A16E0DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDMMtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDMMtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:49:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6B98A74;
        Thu, 13 Apr 2023 05:49:30 -0700 (PDT)
Date:   Thu, 13 Apr 2023 12:49:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681390168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLAZQxthnAOiIurDfw5zGDp0kN/9mkHLRzgaJt8JHLQ=;
        b=1aPQ5CzxwZJtT3sT4knjAIC5aJXEZ+g5TGo9tVG5ZfyofItT9vZncUvmk9fA50rH1dbA1t
        FM6yM+rWJ7RZ6Qsqg9bL3xiJaF0ueoTH8/r1g89rw1U9Gs7Lo3y1+N+qEyqTkve10cvPMA
        gv6sGMn3b/vfZjLYevc4q45lMu1zdKYeMcIoMJxxD/gVpqOWPdy7JNcPiYuuMQoyaZTKBp
        iNOiQ+oQghCNqcnYrzmnQNgMPgz0rIZHDlDtiYupK8XnoDWqn0er+3GSfpKMSV+KIh9d/X
        eqKYuGT6OxGtfyWZ+e7UpG7ijJLdByhqtsk2J2dZfUtgWuj0YCmo/CcyVh8g5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681390168;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLAZQxthnAOiIurDfw5zGDp0kN/9mkHLRzgaJt8JHLQ=;
        b=PLMqnrSiQkfmO0lzFCmtMILaVvGfDH3smrXDZBXuXi+DKjf9Bx1xORjkN0MP3xvmLQznhi
        HTq/a41WxlvkmdCw==
From:   "tip-bot2 for Matija Glavinic Pecotic" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/rtc: Remove __init for runtime functions
Cc:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <59f7ceb1-446b-1d3d-0bc8-1f0ee94b1e18@nokia.com>
References: <59f7ceb1-446b-1d3d-0bc8-1f0ee94b1e18@nokia.com>
MIME-Version: 1.0
Message-ID: <168139016723.404.3254458483027508395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     775d3c514c5b2763a50ab7839026d7561795924d
Gitweb:        https://git.kernel.org/tip/775d3c514c5b2763a50ab7839026d7561795924d
Author:        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
AuthorDate:    Thu, 06 Apr 2023 08:26:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Apr 2023 14:41:04 +02:00

x86/rtc: Remove __init for runtime functions

set_rtc_noop(), get_rtc_noop() are after booting, therefore their __init
annotation is wrong.

A crash was observed on an x86 platform where CMOS RTC is unused and
disabled via device tree. set_rtc_noop() was invoked from ntp:
sync_hw_clock(), although CONFIG_RTC_SYSTOHC=n, however sync_cmos_clock()
doesn't honour that.

  Workqueue: events_power_efficient sync_hw_clock
  RIP: 0010:set_rtc_noop
  Call Trace:
   update_persistent_clock64
   sync_hw_clock

Fix this by dropping the __init annotation from set/get_rtc_noop().

Fixes: c311ed6183f4 ("x86/init: Allow DT configured systems to disable RTC at boot time")
Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/59f7ceb1-446b-1d3d-0bc8-1f0ee94b1e18@nokia.com

---
 arch/x86/kernel/x86_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ef80d36..10622cf 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -33,8 +33,8 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
-static __init int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-static __init void get_rtc_noop(struct timespec64 *now) { }
+static int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+static void get_rtc_noop(struct timespec64 *now) { }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
