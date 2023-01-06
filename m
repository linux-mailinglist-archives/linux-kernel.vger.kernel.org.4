Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5CF660043
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjAFM3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjAFM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:29:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122613DBE8;
        Fri,  6 Jan 2023 04:29:44 -0800 (PST)
Date:   Fri, 06 Jan 2023 12:29:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673008181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z66MPSETAUTnm4sAZTxLL8F84UXTMZxMyIRCDiuflnM=;
        b=q2OidHKmZ8kxtK3ai+NcseOQS8lVWtfsOryf0c3DuAymJnHkZvrRnq5IE0pvIvxUfcMMeH
        Oi9sa2SJ+P9l9fKiGIbG7P3qp63XsC0SVdvA/gKmXqrXnhGpHxb5L8sfGLPPHHgWdaX4bO
        XmG/+6w/veTl5W5LfXeeQhohI/eTKz5UH/3Rkz39co91NrVrygwFm88r+82SEzRfCwsAQ7
        UkOjUGlZIIVU9U4wyzx8QBGTQ6qr87o/Ey9SausfRBonHZ8aIoiDED5HlD6i6fTw49WAGF
        zKCcPbI9CgS8rmFAqfOcluBc+Ij+auKPuHClmWS+pubFC4cHk6FWyohIX1XQcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673008181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z66MPSETAUTnm4sAZTxLL8F84UXTMZxMyIRCDiuflnM=;
        b=ElwrptI9079vEe26bp+7PbZhlymSFwTnXjcFO99A+sXqqMhvTM4XSYf9SwZuDI2lkuvQNn
        YtPg5G6saDWfZzDw==
From:   "tip-bot2 for Wang Yong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot/e820: Fix typo in e820.c comment
Cc:     Wang Yong <yongw.kernel@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221211103849.173870-1-yongw.kernel@gmail.com>
References: <20221211103849.173870-1-yongw.kernel@gmail.com>
MIME-Version: 1.0
Message-ID: <167300817793.4906.15796352008210613315.tip-bot2@tip-bot2>
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

Commit-ID:     47cdfb7b0a2733c157b27f772d852bfb9075384b
Gitweb:        https://git.kernel.org/tip/47cdfb7b0a2733c157b27f772d852bfb9075384b
Author:        Wang Yong <yongw.kernel@gmail.com>
AuthorDate:    Sun, 11 Dec 2022 10:38:49 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Jan 2023 13:21:04 +01:00

x86/boot/e820: Fix typo in e820.c comment

change "itsmain" to "its main".

Fixes: 544a0f47e780 ("x86/boot/e820: Rename e820_table_saved to e820_table_firmware and improve the description")
Signed-off-by: Wang Yong <yongw.kernel@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
