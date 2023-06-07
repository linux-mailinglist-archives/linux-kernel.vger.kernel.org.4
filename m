Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4B725C13
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbjFGKwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbjFGKwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:52:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE941BFB;
        Wed,  7 Jun 2023 03:52:13 -0700 (PDT)
Date:   Wed, 07 Jun 2023 10:52:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686135129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lN5zV2fk3EHTKS0RLX1DWrydAcnLirN8xLdvAuTiiU=;
        b=X7j6+xlfRFWfpzAyYxB+tPBApxKZ2Xl6Qa0+5kk/KQ3p9KvY6ejLuVTCQsM17KmlfH5dnR
        DuofXGilYEetmcPvW2To109zhxge3JCWs8fPZ9zflj51eWkBRtgGtPn5+hI0kt8TvCErk4
        xv8Z+XOD340nvYaTupAz+dm1QyDg+1EIHI9vBCqhnnwsDgPif7lwkQuikPpAxwLkqr0SGN
        yAMCgdwJmuceP5mqpo8V6cPa72+1jEDo9GsmEjw/mic/gSi0qx2TrXEnwit2b9e/XbL8O8
        aagDRsJpw8y01wbbWL6Semdk+ANHNIEqnyyc7gYDWS76fRsdIdt86/j33PdSjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686135129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lN5zV2fk3EHTKS0RLX1DWrydAcnLirN8xLdvAuTiiU=;
        b=ugiYpiP4Y+OThL8d6avUyR6kV2UCmjPPP8mY/KR0UP7dMalbNionzQ95hf2H/kMrZZt02V
        cn1nqjYcV4BEGECA==
From:   "tip-bot2 for Bo Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Remove repeated word in comments
Cc:     Bo Liu <liubo03@inspur.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230504085446.2574-1-liubo03@inspur.com>
References: <20230504085446.2574-1-liubo03@inspur.com>
MIME-Version: 1.0
Message-ID: <168613512909.404.6478565511895362622.tip-bot2@tip-bot2>
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

Commit-ID:     7e980867ced0037a65f588971b89769857b77aab
Gitweb:        https://git.kernel.org/tip/7e980867ced0037a65f588971b89769857b77aab
Author:        Bo Liu <liubo03@inspur.com>
AuthorDate:    Thu, 04 May 2023 04:54:46 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 07 Jun 2023 12:47:34 +02:00

x86/mm: Remove repeated word in comments

Remove the repeated word "the" in comments.

Signed-off-by: Bo Liu <liubo03@inspur.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230504085446.2574-1-liubo03@inspur.com
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 7159cf7..b18fe0d 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -231,7 +231,7 @@ within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
  * points to #2, but almost all physical-to-virtual translations point to #1.
  *
  * This is so that we can have both a directmap of all physical memory *and*
- * take full advantage of the the limited (s32) immediate addressing range (2G)
+ * take full advantage of the limited (s32) immediate addressing range (2G)
  * of x86_64.
  *
  * See Documentation/arch/x86/x86_64/mm.rst for more detail.
