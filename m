Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B747291B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbjFIHtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbjFIHru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1314830D2;
        Fri,  9 Jun 2023 00:47:44 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSXRmBdF1kkwvwVrlXr/CrK5/h7D+Oeb67qWTqXPAZk=;
        b=clEeeacPta/cCyqCtbfys08yGM2/5XYvhyWI4gjXv2XxBCzkrDhBEs2b4QU6tgkj1CJYke
        HGfgp0Pv7KB+XT0Kq8rWM7QhN42vVUEPlHd9XPH8DIkGlOAJlfAoov4WVKLTvOhQEwnB9x
        ULw9EeWncYyhbqTrIJe/64299V+zFCj4J/Qv2tpa3k93ABZx4ylj+1nwHJmWxKrULMbyzT
        5vUoSEcsiwUnPPceLCa7kWyCl79bGU8SF5tnj3ZKx0JGzm4HSyM+CWf3hGegW3h/kZTInO
        RswuM4TAB9XupXkconQewP+XakjEfT95PsFpxIrPQFODRvhxwX/+T5KHllQS5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSXRmBdF1kkwvwVrlXr/CrK5/h7D+Oeb67qWTqXPAZk=;
        b=lh2HfPxY9hGah1Y2G2g6oOsaKIA47z3lU3KQfiyf3dmy8eXKKJzaySXrQb91TwQys5fsWf
        8Bnv/jF02UVZx3CQ==
From:   "tip-bot2 for Lu Hongfei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] tools: Remove unnecessary variables
Cc:     Lu Hongfei <luhongfei@vivo.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230530075649.21661-1-luhongfei@vivo.com>
References: <20230530075649.21661-1-luhongfei@vivo.com>
MIME-Version: 1.0
Message-ID: <168629686313.404.5459876924248310571.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d49d1666aab51ad3caf79f414aff6b641837a6ea
Gitweb:        https://git.kernel.org/tip/d49d1666aab51ad3caf79f414aff6b641837a6ea
Author:        Lu Hongfei <luhongfei@vivo.com>
AuthorDate:    Tue, 30 May 2023 15:56:49 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 09:27:11 -07:00

tools: Remove unnecessary variables

There are several places where warnings variables are not needed,
remove them and directly return 0.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Link: https://lore.kernel.org/r/20230530075649.21661-1-luhongfei@vivo.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a13c257..4b869de 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3799,7 +3799,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 static int validate_unret(struct objtool_file *file, struct instruction *insn)
 {
 	struct instruction *next, *dest;
-	int ret, warnings = 0;
+	int ret;
 
 	for (;;) {
 		next = next_insn_to_validate(file, insn);
@@ -3897,7 +3897,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 		insn = next;
 	}
 
-	return warnings;
+	return 0;
 }
 
 /*
@@ -4132,7 +4132,6 @@ static int add_prefix_symbols(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
-	int warnings = 0;
 
 	for_each_sec(file, sec) {
 		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
@@ -4146,7 +4145,7 @@ static int add_prefix_symbols(struct objtool_file *file)
 		}
 	}
 
-	return warnings;
+	return 0;
 }
 
 static int validate_symbol(struct objtool_file *file, struct section *sec,
