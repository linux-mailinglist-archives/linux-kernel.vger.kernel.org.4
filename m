Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DAC723B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbjFFI0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbjFFI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FECFA;
        Tue,  6 Jun 2023 01:26:17 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4Mz+yZ5wgoRWfsGdE2qATMR07LuxF6HxmI420vA0vw=;
        b=3IJoslHRT8Bsmg2Sr0pPb+P+nSSonQ30k7Sj5pa0C9bGYRG8UD41zffTNQsXCNlqdPDkXQ
        4T8ZD4fN5YZN4QBq9Y4dt12iTSUfmw0XeSObRdFLS76YROnyniM4VZ5XBNQ2v8W5mCuZ+z
        1GcZ1NmBcLmdV7vHiFm5hnu+uMP5XFlcjPz1NN29jG9waPz1w3LQ4AG+HYeTnhpimRf1p2
        srMfV5YQaVyT8GPwncECuBGbWCGGgGkBWtpiV5p6P47oKYhvaTL7Rzp7PfRsD5qLtAsjgu
        PKA2SIseDRr0b5ifKLUtenL2YKrtjPU1x0Q4fc1i5VSOZTP4ixvLSt80pBtrmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039976;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4Mz+yZ5wgoRWfsGdE2qATMR07LuxF6HxmI420vA0vw=;
        b=HhEvGpBwso+sIvSVLaX8ZB0uKku9boYpaz9aSFyP+29bF9x1Kt9dZxhKPH0C5cTVfQfKRb
        ilQ6x27gq8nPdECg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: docs: Add atomic operations to
 the driver basic API documentation
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-27-mark.rutland@arm.com>
References: <20230605070124.3741859-27-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603997541.404.16590439453491268749.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e74f4059d11f36e936b08e98bc96f654c308807a
Gitweb:        https://git.kernel.org/tip/e74f4059d11f36e936b08e98bc96f654c308807a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 05 Jun 2023 08:01:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:24 +02:00

locking/atomic: docs: Add atomic operations to the driver basic API documentation

Add the generated atomic headers to driver-api/basics.rst in order to
provide documentation for the Linux kernel's atomic operations.

At the same time, dtop the x86 atomic header, which provides kerneldoc
comments for some arch_atomic*_*() operations. The arch_atomic*_*()
operations are now purely an implenentation detail of the
raw_atomic*_*() ops, and outside of implementing the atomics, code
should use the raw_atomic*_*() forms.

[Mark: add atomic-{instrumented,long}.h, update commit message]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-27-mark.rutland@arm.com
---
 Documentation/driver-api/basics.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index 4b4d8e2..7671b53 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -84,7 +84,13 @@ Reference counting
 Atomics
 -------
 
-.. kernel-doc:: arch/x86/include/asm/atomic.h
+.. kernel-doc:: include/linux/atomic/atomic-instrumented.h
+   :internal:
+
+.. kernel-doc:: include/linux/atomic/atomic-arch-fallback.h
+   :internal:
+
+.. kernel-doc:: include/linux/atomic/atomic-long.h
    :internal:
 
 Kernel objects manipulation
