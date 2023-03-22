Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8B6C5375
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjCVSQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCVSQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:16:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531364A9D;
        Wed, 22 Mar 2023 11:16:47 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:16:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679509006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4ed9wOd5E4IQ7/49nmwLZdd9I3ON4s/AWtcEBl92lfg=;
        b=Nibg+CIi6tjDL09xxLGewRzKYWCBgg4ZexQocKkshvT/bacBmPEUhasvOq7a/SBq6cD3g2
        +Kgfg9Zowpu0L1bB1evUAmwfyLMRKi1fbWCVBW/uT5NGsEBA4vMkuj8+5comjamCqyNDZP
        DYG+nb3ywEwnl+M1YuVAdMl53+V2rbAIuA6hy8ZCxXavu0I9kRgeGmpWxTu7IwXUKv01dU
        TmiLO3pg6lX4PV46QTE6pLr8tjCkh+zRbEp6zl9BrEzOE+JR9NM71KJ/WIp5u6sRjosHg2
        LEYWgvnC6biOE99/mM/g+z5DRO6Oa/RS0kfYxTYQv2r76Khl4zQbvssqVBFQXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679509006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4ed9wOd5E4IQ7/49nmwLZdd9I3ON4s/AWtcEBl92lfg=;
        b=2NKiZoWLqUJq5bYY9WqoK23xUSWMr1OaMZ03GoJ8FFp8n/qI3kGYyN70nwNOnk9w/J2fa6
        DOKlTQ2xT9nLQNCQ==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/platform/intel-mid: Remove unused definitions
 from intel-mid.h
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950900603.5837.7897149755988999930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b72d6965eeac4503445ab64bc0aede4934e0a7a6
Gitweb:        https://git.kernel.org/tip/b72d6965eeac4503445ab64bc0aede4934e0a7a6
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Thu, 16 Feb 2023 21:39:58 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 22 Mar 2023 11:08:40 -07:00

x86/platform/intel-mid: Remove unused definitions from intel-mid.h

After a few rounds of removal and refactoring Intel MID related code
some artifacts are left untouched. However, they are not used anywhere.
Remove them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230216193958.2971-1-andriy.shevchenko%40linux.intel.com
---
 arch/x86/include/asm/intel-mid.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index c201083..a3abdcd 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -20,25 +20,4 @@ extern void intel_mid_pwr_power_off(void);
 
 extern int intel_mid_pwr_get_lss_id(struct pci_dev *pdev);
 
-#ifdef CONFIG_X86_INTEL_MID
-
-extern void intel_scu_devices_create(void);
-extern void intel_scu_devices_destroy(void);
-
-#else /* !CONFIG_X86_INTEL_MID */
-
-static inline void intel_scu_devices_create(void) { }
-static inline void intel_scu_devices_destroy(void) { }
-
-#endif /* !CONFIG_X86_INTEL_MID */
-
-/* Bus Select SoC Fuse value */
-#define BSEL_SOC_FUSE_MASK		0x7
-/* FSB 133MHz */
-#define BSEL_SOC_FUSE_001		0x1
-/* FSB 100MHz */
-#define BSEL_SOC_FUSE_101		0x5
-/* FSB 83MHz */
-#define BSEL_SOC_FUSE_111		0x7
-
 #endif /* _ASM_X86_INTEL_MID_H */
