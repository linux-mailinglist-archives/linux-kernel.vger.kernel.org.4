Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A40723B9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjFFI1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbjFFI0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47D71B8;
        Tue,  6 Jun 2023 01:26:24 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039980;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fi8VwClKxFHmYf+7dhPTrzOI0O7eS4p0EvI4DS7OdGE=;
        b=XCKhVcieiLPcT8seg4Enj4aWuQS9tlHqu8+7aXmebyzp9jWqpqQBBfDDeosuAj4pMmvV8l
        uqk2lAr8Dq6ZZVWq7RvAvQWsLoLeGsp7lwxVwoYWn5akgl2Am7iiihrCyZnCN78XKYYAzP
        qwKt0F0JyjnBkRTgnkkWM+uYExXqlNQfBnxFXYsqva8TKNufMgqfRkdGf2HVd5mlw8pkZY
        /hvnPWsJB+cwDYzQ4sChQUlTV/Vlc+RfUV2NXGafKPBJNTN7bd6XdWlSihaFIwzJ41ILNm
        3scsm9fQNS0MV31eax7Q/ufGSArI+xYivakWoUg5IHOJRknF/lifpBtbnzaupw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039980;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fi8VwClKxFHmYf+7dhPTrzOI0O7eS4p0EvI4DS7OdGE=;
        b=QCrO6meeQQNPOLzXK2qODI5TcMzK/vtORldkh+Y5NkFbxPcz891F4c8hwh++nyKW2tKgLW
        RmUK9EJhYLX9XDAw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: scripts: remove leftover "${mult}"
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-16-mark.rutland@arm.com>
References: <20230605070124.3741859-16-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603998038.404.16631419212140549148.tip-bot2@tip-bot2>
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

Commit-ID:     e40e5298e692bb6b5a200b3f0f55e6e5adf0e5ad
Gitweb:        https://git.kernel.org/tip/e40e5298e692bb6b5a200b3f0f55e6e5adf0e5ad
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:18 +02:00

locking/atomic: scripts: remove leftover "${mult}"

We removed cmpxchg_double() and variants in commit:

  b4cf83b2d1da40b2 ("arch: Remove cmpxchg_double")

Which removed the need for "${mult}" in the instrumentation logic.
Unfortunately we missed an instance of "${mult}".

There is no change to the generated header.
There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-16-mark.rutland@arm.com
---
 scripts/atomic/gen-atomic-instrumented.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index a2ef735..68557bf 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -118,7 +118,7 @@ cat <<EOF
 EOF
 [ -n "$kcsan_barrier" ] && printf "\t${kcsan_barrier}; \\\\\n"
 cat <<EOF
-	instrument_atomic_read_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \\
 	arch_${xchg}${order}(__ai_ptr, __VA_ARGS__); \\
 })
 EOF
