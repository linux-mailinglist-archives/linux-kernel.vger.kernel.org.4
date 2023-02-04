Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E868A972
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjBDKRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjBDKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:17:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF9F6EAFD;
        Sat,  4 Feb 2023 02:17:14 -0800 (PST)
Date:   Sat, 04 Feb 2023 10:17:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675505832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=teelTh+iKlGzQQ4AB4tPE/FpJYA9DHVMjfiKfuy01vc=;
        b=V0a3BAjm+E3zg7sSi505dVxXHfoPLP+JC2KD54/xGTK68enc050gNPsPY262P9BJRu9djX
        N2x2ZVLlFdcJ4rusP39dC+ttn29r5iqOzLSYS/e96Jlr2mS9gDa3yHfiJ/H21P3B3v4ffU
        uSTUyz3gjGa1chc5MFX5JSv4zvJKZptdMYBg0ZjLu14m8NknZzmJFlOZnNFqRXp1kqaHfV
        Qfr2GpzEJroFgBPJEQAy/9Sq87puzXkEhG8ESBE1LThn7sU1Av82pv2+euGsT2wx0kKWWL
        ki7ouGhzv6cVfV+gWYuYDG3uHYhMRIHQzVJRM3vD3ucS5dxzDC/8UnQo8pkcbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675505832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=teelTh+iKlGzQQ4AB4tPE/FpJYA9DHVMjfiKfuy01vc=;
        b=A3pzcxqGbGKxGwRKxh4Cdgn+Ouec3pOJGBSWWSEFoJ6NRvdKkyiwuoBS/JbVN6wMAsn8PQ
        KtXF/dzHhsINTSBA==
From:   tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make struct check_options static
Cc:     linux@weissschuh.net, Josh Poimboeuf <jpoimboe@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221216-objtool-memory-v2-2-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-2-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Message-ID: <167550583192.4906.13829880413446846923.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     cfd66e81799f4a2fdc6447fa99bdb1871f45ff08
Gitweb:        https://git.kernel.org/tip/cfd66e81799f4a2fdc6447fa99bdb1871f4=
5ff08
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Tue, 27 Dec 2022 16:00:58=20
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 01 Feb 2023 09:15:23 -08:00

objtool: Make struct check_options static

It is not used outside of builtin-check.c.

Also remove the unused declaration from builtin.h .

Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/20221216-objtool-memory-v2-2-17968f85a464@wei=
ssschuh.net
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c           | 2 +-
 tools/objtool/include/objtool/builtin.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index a4f3940..7c17519 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -65,7 +65,7 @@ static int parse_hacks(const struct option *opt, const char=
 *str, int unset)
 	return found ? 0 : -1;
 }
=20
-const struct option check_options[] =3D {
+static const struct option check_options[] =3D {
 	OPT_GROUP("Actions:"),
 	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake",=
 "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/=
objtool/builtin.h
index fa45044..2a108e6 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -7,8 +7,6 @@
=20
 #include <subcmd/parse-options.h>
=20
-extern const struct option check_options[];
-
 struct opts {
 	/* actions: */
 	bool dump_orc;
