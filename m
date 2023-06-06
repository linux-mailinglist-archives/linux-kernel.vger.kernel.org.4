Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146AF723B81
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbjFFI03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbjFFI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:26:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9557F1B8;
        Tue,  6 Jun 2023 01:26:20 -0700 (PDT)
Date:   Tue, 06 Jun 2023 08:26:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686039978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4jfTcldGWxcn4L5earE++TpUl93n9C+kqEHaM4j+RY8=;
        b=yOVktKWQJZ1DOtjSvqSlD/HFMkQbmoh8KrEHsF4zZFs/ChKQgIG6GxPJ69DOSVOvaYN5dF
        p5BpngfbVpMCfPlrqCpXjkW+H7lZ35HvSZj9dP/fU0dYtjZpLN1JhWSIarS2LD6skAu0gF
        24zm/j2ExOuXnlOTgadnL3rXQQznb9DQq6P9HpqLZ7obovQ0/nye08W9cGiiME2N9Lrpj4
        xPQkEQPuD5XYYy+e1W6MVwCf/gbyIIkIh2tVl6PVhtEbhtc7go1nCPuwvGG/R22vUXBYFq
        WYdr1y1ZMXSN4F4DbnY/mFCQDNc6EIrQNWX+hAvlW6FNvDr2IIHtSi1S2Uq9cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686039978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4jfTcldGWxcn4L5earE++TpUl93n9C+kqEHaM4j+RY8=;
        b=JR1GSUJwKFbZTPXFAz23sFC3JxtlIeWvNSW+5WbaEk/9dkRM5vV1n0pw2BxDWsgEA0sc7x
        sWOQlL0ExbAj33Dg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: scripts: split pfx/name/sfx/order
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605070124.3741859-22-mark.rutland@arm.com>
References: <20230605070124.3741859-22-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <168603997800.404.7782037544697697205.tip-bot2@tip-bot2>
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

Commit-ID:     b916a8c765692444388891f5b9c5b6e941e16d42
Gitweb:        https://git.kernel.org/tip/b916a8c765692444388891f5b9c5b6e941e16d42
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 05 Jun 2023 08:01:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:57:21 +02:00

locking/atomic: scripts: split pfx/name/sfx/order

Currently gen-atomic-long.sh's gen_proto_order_variant() function
combines the pfx/name/sfx/order variables immediately, unlike other
functions in gen-atomic-*.sh.

This is fine today, but subsequent patches will require the individual
individual pfx/name/sfx/order variables within gen-atomic-long.sh's
gen_proto_order_variant() function. In preparation for this, split the
variables in the style of other gen-atomic-*.sh scripts.

This results in no change to the generated headers, so there should be
no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230605070124.3741859-22-mark.rutland@arm.com
---
 scripts/atomic/gen-atomic-long.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 75e91d6..1383217 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -36,10 +36,15 @@ gen_args_cast()
 gen_proto_order_variant()
 {
 	local meta="$1"; shift
-	local name="$1$2$3$4"; shift; shift; shift; shift
+	local pfx="$1"; shift
+	local name="$1"; shift
+	local sfx="$1"; shift
+	local order="$1"; shift
 	local atomic="$1"; shift
 	local int="$1"; shift
 
+	local atomicname="${pfx}${name}${sfx}${order}"
+
 	local ret="$(gen_ret_type "${meta}" "long")"
 	local params="$(gen_params "long" "atomic_long" "$@")"
 	local argscast="$(gen_args_cast "${int}" "${atomic}" "$@")"
@@ -47,9 +52,9 @@ gen_proto_order_variant()
 
 cat <<EOF
 static __always_inline ${ret}
-raw_atomic_long_${name}(${params})
+raw_atomic_long_${atomicname}(${params})
 {
-	${retstmt}raw_${atomic}_${name}(${argscast});
+	${retstmt}raw_${atomic}_${atomicname}(${argscast});
 }
 
 EOF
