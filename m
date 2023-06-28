Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CC0740CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjF1JbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjF1JZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:25:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272EF2D78;
        Wed, 28 Jun 2023 02:25:23 -0700 (PDT)
Date:   Wed, 28 Jun 2023 09:25:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687944320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OnY1F7yX7rrK4j9xMOZ9K3sCE9M5bOJmvrjoSo9v6Fo=;
        b=bAGn807W54K4kJSM53DgYfa0ZEeVO3CqePQShk7uyfpyRUzS85N7YhGQxwi+niazPYqQzb
        XCOB5P3LZgNLtJL/RV1yLh5YMwKQ/WZkiWF2jcL/kE/vizfYCoDhJMLY1f20BzTwSV0n/1
        TGidNV1kYLFPjPlUxwS3Dh/6xOJFKX0IfsBet8ns/zPC1IrkXi68KtCXs/shVmey7wqPsn
        XuhPKODWX53eCKJLVSB5Mh36wx+9SFTGMnyjyKmeoKAQTiro8wWO5/EBYR+CxLUJDWtWg5
        8o6QRGK1QtOfU571Vr4zjxQeYLWAf9xqgDsFpoBnK/LcEtv6jNLu6wimyF/eEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687944320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OnY1F7yX7rrK4j9xMOZ9K3sCE9M5bOJmvrjoSo9v6Fo=;
        b=R/jzqjkI1KmfosKVLjX7mV47vM5Yw6aayY/Ux8Gx5nV2P2TCmytW6tVYjlGjWVADvJ1X3c
        FiVBqdrr9DShBbDA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Remove btrfs_assertfail() from the
 noreturn exceptions list
Cc:     David Sterba <dsterba@suse.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
MIME-Version: 1.0
Message-ID: <168794431960.404.13615748804101554026.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     cc592643a3ea1b2231628fb414dee203633a11c0
Gitweb:        https://git.kernel.org/tip/cc592643a3ea1b2231628fb414dee203633a11c0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 Jun 2023 11:16:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Jun 2023 11:21:50 +02:00

objtool: Remove btrfs_assertfail() from the noreturn exceptions list

Upstream merge commit:

  6f612579be9d Merge tag 'objtool-core-2023-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

... generated a (minor) semantic conflict that was not resolved: the btrfs_assertfail()
entry that was removed from the list in tools/objtool/check.c in:

  b831306b3b7d ("btrfs: print assertion failure report and stack trace from the same line")

... because btrfs_assertfail() was changed from a noreturn function into
a macro.

But the list was moved to a different file, in a different enumeration format:

  6245ce4ab670 ("objtool: Move noreturn function list to separate file")

And has to be removed from tools/objtool/noreturns.h post-merge as well.

Do it explicitly.

Cc: David Sterba <dsterba@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/noreturns.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 1514e84..e45c7cb 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -14,7 +14,6 @@ NORETURN(__stack_chk_fail)
 NORETURN(__ubsan_handle_builtin_unreachable)
 NORETURN(arch_call_rest_init)
 NORETURN(arch_cpu_idle_dead)
-NORETURN(btrfs_assertfail)
 NORETURN(cpu_bringup_and_idle)
 NORETURN(cpu_startup_entry)
 NORETURN(do_exit)
