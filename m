Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D115B738E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFUSDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjFUSCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:02:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3F81710;
        Wed, 21 Jun 2023 11:02:39 -0700 (PDT)
Date:   Wed, 21 Jun 2023 18:02:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687370556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iQxjUsgsC/WPSkUYa9/qyRTPa+IzhBw37VPPoiW/Ep4=;
        b=h7FbXNQsQRLhBeeZn3zZamxvnTfjIQooDQ0Oqjva3XLlTzutSgY6oU6Ao0f+/0TCfhUm3X
        KHoYS6m0Cd5AmdiqwmDRPQ2kW6a68LnhhvD7FDfIfSWuJ1Y5px5RxQ/LTEWsZpna5M0PmF
        doE44RfGClxU2CBjkSHedUo49VXvVG3r6KoQsa0EFByCASyUFgRshfJzKJV0KCZSC0ZAHI
        tNtpwc9bXMkG4Iw+xXQzvbYJYKZrmWw/4FgA26Om7LHTa+3FTketRte2oLXi6F7SqkbXN7
        GWbRfiKfnPAPyoibmNNa6/ciyxtigY3ANBRZTG4tQ4f0B6QdV26dm/7HqZD07A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687370556;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iQxjUsgsC/WPSkUYa9/qyRTPa+IzhBw37VPPoiW/Ep4=;
        b=hawb49/GCpkH0I7iWNUPgYJRoPMFCEzd6JW4uCjRD2XBKrt6EhgRo0gTd6Qid4+EIF6tvh
        mvLj4YtjnMjyHfAw==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/acpi: Remove unused extern declaration
 acpi_copy_wakeup_routine()
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168737055575.404.2070205807282162061.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b360cbd254fde61cb500a4a3ca2e65dff3dfa039
Gitweb:        https://git.kernel.org/tip/b360cbd254fde61cb500a4a3ca2e65dff3dfa039
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Tue, 20 Jun 2023 17:45:19 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 21 Jun 2023 10:57:54 -07:00

x86/acpi: Remove unused extern declaration acpi_copy_wakeup_routine()

This is now unused, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/all/20230620094519.15300-1-yuehaibing%40huawei.com
---
 arch/x86/kernel/acpi/sleep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/sleep.h b/arch/x86/kernel/acpi/sleep.h
index 171a40c..054c15a 100644
--- a/arch/x86/kernel/acpi/sleep.h
+++ b/arch/x86/kernel/acpi/sleep.h
@@ -12,7 +12,6 @@ extern int wakeup_pmode_return;
 
 extern u8 wake_sleep_flags;
 
-extern unsigned long acpi_copy_wakeup_routine(unsigned long);
 extern void wakeup_long64(void);
 
 extern void do_suspend_lowlevel(void);
