Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C569B707ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjERLIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjERLI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:08:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23ED1738;
        Thu, 18 May 2023 04:08:04 -0700 (PDT)
Date:   Thu, 18 May 2023 11:08:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684408082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ko8LLVq0J3s3/oBlP9goTDT5idFvI9SCS6DzWm6/CKk=;
        b=M0CfnLAxTsAfqFMZwAAfjU2jNbpbl7fcyde0hpIZT4qhuOtvmBo5o2aR4iIvSdJAVSvcoI
        LP2abQ2L5c9FdhqCSDoWm1t7di49jFxHH0WkPVZ5udmBFQ2ubvxUC0dZggmx5zzHgAds1J
        aqWia06UZqiPqPusbgK0twJhqP2lXzAJEsGvOiirKnpW4+GvKw4f9csmlAKosmxKMAQ91N
        j2+rhrCN+PIcXqPIfgeHowsW4mcECrFoYP2X0VGIlm9z3qDAX99Ebd+f69Xrdxcp9JCzBM
        DjPZ3b3KnYBwE6U9gBkgySz/6oK7pSkih9Dshd/00YTgWfuJ/oEwa6g/hxhVlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684408082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ko8LLVq0J3s3/oBlP9goTDT5idFvI9SCS6DzWm6/CKk=;
        b=vXTL9VpE1lXBYFZnKDQVSlihqqzFlUXbcc18QDR78FrSgDZzKPxbYyP6XGo5MY4KikN8mI
        WsKXgsH0NzJdMRDw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove superfluous global_noreturns entries
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2725d7f2ccc2361c6903de9ebaa2b5bb304f7ac2.1681853186.git.jpoimboe@kernel.org>
References: <2725d7f2ccc2361c6903de9ebaa2b5bb304f7ac2.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168440808166.404.8322530260978250724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     34245659debd194cbd4148d2ee5176306bdf8899
Gitweb:        https://git.kernel.org/tip/34245659debd194cbd4148d2ee5176306bdf8899
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 18 Apr 2023 14:27:52 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:31:54 -07:00

objtool: Remove superfluous global_noreturns entries

lbug_with_loc() no longer exists, and resume_play_dead() is static
(objtool only checks globals and weaks).

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/r/2725d7f2ccc2361c6903de9ebaa2b5bb304f7ac2.1681853186.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8dac1e3..8c2762d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -217,7 +217,6 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"kthread_complete_and_exit",
 		"kthread_exit",
 		"kunit_try_catch_throw",
-		"lbug_with_loc",
 		"machine_real_restart",
 		"make_task_dead",
 		"mpt_halt_firmware",
@@ -225,7 +224,6 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"panic",
 		"panic_smp_self_stop",
 		"rest_init",
-		"resume_play_dead",
 		"rewind_stack_and_make_dead",
 		"sev_es_terminate",
 		"snp_abort",
