Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17736EFC99
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjDZVqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjDZVp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:45:59 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07FE1FF2;
        Wed, 26 Apr 2023 14:45:56 -0700 (PDT)
Date:   Wed, 26 Apr 2023 21:45:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1682545552; x=1682804752;
        bh=XRs8BIXjRa7l+HwAU9FqrtJAc1iiE4XQ0MrbmDyg07Q=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=fHiQlcLvzyw0n0V1FL6XiXx64u41B3F4jgRLB1/biHA3N3XXJJIC1gT2bKcDYf+D7
         j5zoFuoevot1VmX6Y1whesJp3bSFJMU1OPkbrE5+RICgItRDkB/SnEFpMk8YcyxdjZ
         ryqmhk41+lVZEGRUij9F83eGsXDbFPn/hmmnWVvdGNLWIHcIswgB8hjfgG0HNqNp8K
         omOMlSUeFijZd8WhAi/hQlP/iBp2a3IAotuENvDEgyLvKSvQD3Wukxq28/kk6QkZm4
         NjTXjQQQD0QCE2WsQOdLXTabkvWk6ODkxmYeLU9UvcheQUqN/QHF6ZUpY5n70RS1D/
         +QIeovE6xSGvA==
To:     alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
        yakoyoku@gmail.com, aliceryhl@google.com, materoy@proton.me,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Roy Matero <materoy@proton.me>
Cc:     ojeda@kernel.org
Subject: [PATCH] rust: fix sorting of rust/bindings/bindings_helper.h's #includes Suggested by: Miguel Ojeda <ojeda@kernel.org> Link: https://github.com/Rust-for-Linux/linux/issues/1002
Message-ID: <ZEmbeAUklqmb8leS@virtual>
Feedback-ID: 71587999:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roy Matero <materoy@proton.me>
---
 rust/bindings/bindings_helper.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helpe=
r.h
index 50e7a76d5455..dc8d97272e71 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -6,10 +6,10 @@
  * Sorted alphabetically.
  */

-#include <linux/slab.h>
 #include <linux/refcount.h>
-#include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/wait.h>

 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL =3D GFP_KERNEL;
--
2.40.1


