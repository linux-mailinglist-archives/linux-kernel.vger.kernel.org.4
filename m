Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1F66988B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbjAMNco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241135AbjAMNcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:32:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FC47F449;
        Fri, 13 Jan 2023 05:23:06 -0800 (PST)
Date:   Fri, 13 Jan 2023 13:23:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673616184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3G1w5pdZU1FIx8tJLnQ2VJQUnMung6oi9cvwhN5A48=;
        b=HMFMdlMa2JnD0nMC34RVW4wZRkR2Ndqv8a7RO+grDE8FTTe8VGUs5tkAJLX9G9w52Y8/pM
        jbEzrvWDSjf/tJMiDVy6u3497P8QQ7TjztBTXI8SHMKr6EpvpodKkxvKd/23hY42Cx3lrH
        uQvOndk3h+PmhBydP8JhSwADhFVD/12KcxQgI1a1BSniezWE74N1kXTHdEWMD+TZx+V+SQ
        PE06y5RQuXbUjxS8arzXcz8RQVilFyaEqMs23AdxXsgRjhwTIwD+QLW2r1yBjPXgtrnu+Z
        1jV19eQ+XWHcL9Tp/B4CaKexXQOozmQnJjP0FpVCvqt/+JzBuojDJPRQARQa7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673616184;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3G1w5pdZU1FIx8tJLnQ2VJQUnMung6oi9cvwhN5A48=;
        b=kWI3zL47TdDPVvXXnuv/FWfYRl/n00/pbuuGCGCgCnG2d/1zrzTbyOteXv3Az77dD1enIS
        1DkOU51SXun/AhDA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cpu: Remove misleading comment
Cc:     Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230113130126.1966-1-jgross@suse.com>
References: <20230113130126.1966-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <167361618361.4906.17805909377526158491.tip-bot2@tip-bot2>
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

Commit-ID:     d55dcb7384b1234d3caf70c2f8199c4184502ff9
Gitweb:        https://git.kernel.org/tip/d55dcb7384b1234d3caf70c2f8199c4184502ff9
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 13 Jan 2023 14:01:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 14:20:20 +01:00

x86/cpu: Remove misleading comment

The comment of the "#endif" after setup_disable_pku() is wrong.

As the related #ifdef is only a few lines above, just remove the
comment.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230113130126.1966-1-jgross@suse.com
---
 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d..7670397 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -567,7 +567,7 @@ static __init int setup_disable_pku(char *arg)
 	return 1;
 }
 __setup("nopku", setup_disable_pku);
-#endif /* CONFIG_X86_64 */
+#endif
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
