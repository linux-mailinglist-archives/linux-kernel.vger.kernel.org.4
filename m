Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB26011E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiJQO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJQOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF9568CD9;
        Mon, 17 Oct 2022 07:54:02 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJqV4cURhzV3SHiX0YBOhg+HE7NujCTHFpoxTnmh758=;
        b=Jw7poZGEPM7BdPeRqmJ12YmBPWHcDlyH4BuPBElDwSIvqnsoJJY/06DqPgMSU5pNqZQM9A
        oWcF/f4qddJcKHhTdJxCNZttL2mul39u/z9+1MkowC9eRiSRT6ZdTYVtZwFRcAso8+tSXz
        Mw4PjZTPGqNZkJzmAu/yz+nDnhQUEMxvH5S3pGHE8dxtDt/iTgBezppT7Ps/w5H7DstB6n
        6nsGFx0c1l+i5YezCukVKjVSzp3k/KIJR4y+46QPV/jPmh5L5dG6+CuYre+EjQTtSTEuAP
        r9fPjkukVxuMUKBIBAtT2LOepmTncbeXzCCHgtzgmNeZTabYDOFbksPdi/18rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018440;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJqV4cURhzV3SHiX0YBOhg+HE7NujCTHFpoxTnmh758=;
        b=OCu4dibKUPUUjZTB/OUDBLz7diupYvD6ciKF6QwLfgn8igO8vCwzKgt3aUUM1YvrvKXL2W
        LJnbEPRmLHp22VCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Add --hacks=skylake
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111146.120821440@infradead.org>
References: <20220915111146.120821440@infradead.org>
MIME-Version: 1.0
Message-ID: <166601843905.401.508580570975897954.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0c0a6d8934e2081df93ba0bfc0cf615cc9c06988
Gitweb:        https://git.kernel.org/tip/0c0a6d8934e2081df93ba0bfc0cf615cc9c06988
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:07 +02:00

objtool: Add --hacks=skylake

Make the call/func sections selectable via the --hacks option.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111146.120821440@infradead.org
---
 scripts/Makefile.lib                    |  1 +
 tools/objtool/builtin-check.c           |  7 ++++++-
 tools/objtool/check.c                   | 10 ++++++----
 tools/objtool/include/objtool/builtin.h |  1 +
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3aa384c..85f0275 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -254,6 +254,7 @@ objtool := $(objtree)/tools/objtool/objtool
 
 objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
+objtool-args-$(CONFIG_CALL_DEPTH_TRACKING)		+= --hacks=skylake
 objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
 objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
 objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 24fbe80..0a04f8e 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -57,12 +57,17 @@ static int parse_hacks(const struct option *opt, const char *str, int unset)
 		found = true;
 	}
 
+	if (!str || strstr(str, "skylake")) {
+		opts.hack_skylake = true;
+		found = true;
+	}
+
 	return found ? 0 : -1;
 }
 
 const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
-	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr", "patch toolchain bugs/limitations", parse_hacks),
+	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake", "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f578e03..1461c88 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4352,10 +4352,12 @@ int check(struct objtool_file *file)
 			goto out;
 		warnings += ret;
 
-		ret = create_direct_call_sections(file);
-		if (ret < 0)
-			goto out;
-		warnings += ret;
+		if (opts.hack_skylake) {
+			ret = create_direct_call_sections(file);
+			if (ret < 0)
+				goto out;
+			warnings += ret;
+		}
 	}
 
 	if (opts.mcount) {
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 42a52f1..22092a9 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -14,6 +14,7 @@ struct opts {
 	bool dump_orc;
 	bool hack_jump_label;
 	bool hack_noinstr;
+	bool hack_skylake;
 	bool ibt;
 	bool mcount;
 	bool noinstr;
