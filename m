Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C69665BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAKMq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjAKMqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:46:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FEBE1C;
        Wed, 11 Jan 2023 04:46:21 -0800 (PST)
Date:   Wed, 11 Jan 2023 12:46:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673441179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CBoRt39skz+jx4efNlFIgS/P6kHEEX3x4nw5kpDw6Q=;
        b=SF07QcbtcT/lnCU1V1GhDAcyJm/arq8PAFTmlRYG64FJsGMcaSTwlb+FiZDwIJvKqJ8g93
        wZ7OPQjsh5KHQr8Fg1BhgWV9tar3NKaOtjrl34bRWLkETQmAsx9ZPgKGBrH2CCg6JISSEV
        nhgydFw0ZVTWhfQNRDTJ5vT5FwkDR4X/gftc/7mEsE6Gy5UUZpQnix48W6GVt9hlSZsfIX
        MJsT8mQSMXV1yu2x4WHSaY98FRSsH+DpSqj+UtMSSDl3A0YY86g8o/m85U+qZGMT2WJ4BC
        pDJIYB74AI7mz57H2QsC0sxTHkne7E2ocf4P9js8xE3hGaojY7ql4iB7keks8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673441179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CBoRt39skz+jx4efNlFIgS/P6kHEEX3x4nw5kpDw6Q=;
        b=Xrvxo+5RFoiXCS+qNEux3IuG/Is5ZLBl9U1+za6Arlggg4L9cULESbvCODSy9smchQtlO0
        aB3odEIEo33YKTCw==
From:   "tip-bot2 for Wang Yong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot/e820: Fix typo in e820.c comment
Cc:     Wang Yong <yongw.kernel@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221211103849.173870-1-yongw.kernel@gmail.com>
References: <20221211103849.173870-1-yongw.kernel@gmail.com>
MIME-Version: 1.0
Message-ID: <167344117849.4906.7905462837632668543.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b7d1f15b5c274999dfe8dda60a9a516eebfbc3d0
Gitweb:        https://git.kernel.org/tip/b7d1f15b5c274999dfe8dda60a9a516eebfbc3d0
Author:        Wang Yong <yongw.kernel@gmail.com>
AuthorDate:    Sun, 11 Dec 2022 10:38:49 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 11 Jan 2023 12:45:03 +01:00

x86/boot/e820: Fix typo in e820.c comment

change "itsmain" to "its main".

Fixes: 544a0f47e780 ("x86/boot/e820: Rename e820_table_saved to e820_table_firmware and improve the description")
Signed-off-by: Wang Yong <yongw.kernel@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20221211103849.173870-1-yongw.kernel@gmail.com
---
 arch/x86/kernel/e820.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 9dac246..0614a79 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -53,7 +53,7 @@
  *
  * Once the E820 map has been converted to the standard Linux memory layout
  * information its role stops - modifying it has no effect and does not get
- * re-propagated. So itsmain role is a temporary bootstrap storage of firmware
+ * re-propagated. So its main role is a temporary bootstrap storage of firmware
  * specific memory layout data during early bootup.
  */
 static struct e820_table e820_table_init		__initdata;
