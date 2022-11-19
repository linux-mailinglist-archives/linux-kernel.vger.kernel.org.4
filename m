Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21205630F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiKSQZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiKSQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501F959FFF;
        Sat, 19 Nov 2022 08:24:17 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbvTo8n+0L4VHhoU6ZYs0QInSugEwaROee+5EdNGS50=;
        b=Pb2cgJtBSZdin5JinnLJm+DgH+/B0v8Fn0lU71BnECafWhaOGXl8ixcDpz+stFGkvSjKXu
        B5++/hPwCrPXCw5Kw7tbaxJN6dlqzEULcHL9twpUEWOHaJEcDGof6ja+ud5m/wyFwOevib
        L9Kgi7afEilJZe5Fo80bmHrllU7ISlWBWVbUbqL3BsXre1HTK69inIp0C6Q74/DrjtouLy
        kisFR0jIaF/WQxOgbsbdC55s2PMskR889uCTPiNYaixeSd7rqwGh/wEz6aVd501ipSzS8M
        vTwnTcEntRcLVglw0yP6FU1OEvyLIy1479Cjpht3zG6MDQmhUq0ZywBEs0/p9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbvTo8n+0L4VHhoU6ZYs0QInSugEwaROee+5EdNGS50=;
        b=AAJ+qrKbujzlqRv6QvO5OKvLWzcHkbA3EmlPRoM0zxtJ/A4/gyFv75DROSMb6WtgggHe9+
        36nxC5ofVFo3DlCg==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] platform/x86/intel/ifs: Remove unused selection
Cc:     Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117035935.4136738-2-jithu.joseph@intel.com>
References: <20221117035935.4136738-2-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887505465.4906.7039915057720991895.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     10d4853e4c5cd64b9ef1e5579bb2e89bceab4175
Gitweb:        https://git.kernel.org/tip/10d4853e4c5cd64b9ef1e5579bb2e89bceab4175
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Wed, 16 Nov 2022 19:59:20 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Nov 2022 14:59:20 +01:00

platform/x86/intel/ifs: Remove unused selection

CONFIG_INTEL_IFS_DEVICE is not used anywhere. The selection in
Kconfig is therefore pointless. Delete it.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20221117035935.4136738-2-jithu.joseph@intel.com
---
 drivers/platform/x86/intel/ifs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
index c341a27..89152d4 100644
--- a/drivers/platform/x86/intel/ifs/Kconfig
+++ b/drivers/platform/x86/intel/ifs/Kconfig
@@ -4,7 +4,6 @@ config INTEL_IFS
 	# Discussion on the list has shown that the sysfs API needs a bit
 	# more work, mark this as broken for now
 	depends on BROKEN
-	select INTEL_IFS_DEVICE
 	help
 	  Enable support for the In Field Scan capability in select
 	  CPUs. The capability allows for running low level tests via
