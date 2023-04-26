Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273D76EFDBB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbjDZW5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjDZW5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:57:49 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA1C358E;
        Wed, 26 Apr 2023 15:57:41 -0700 (PDT)
Date:   Wed, 26 Apr 2023 22:57:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1682549859; x=1682809059;
        bh=Am8voCH8GOR8bFHGaPEgtzx6XI7KOtL2F7jxIt9VklA=;
        h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=m4ielrnFyBQ2TxvtChRcyZBWNh+tAXXRh6t+84m84j5S0rfD4AWYZWLZ8oScmATL/
         ysX+HRHSPMP7YjpynvhWJupOrzkfCucNdCCHuE34OZyH/uUxqrH77BN2cmELkraQ4B
         oy7UucJpx9iGBTshXtV2Z/5iKbYfuSLUDrk4BZD2DO/98Lx7FguXDaELfiMDuO7CyT
         PBOKoEnxALza/SQJALqS0eOg4t3qqxXi8lxpDQnb3ddK6qkAYNZObIZLQMPMHA98iN
         DjN/n9JF9Y3nbJ2Kf07cH6Ps+K6YLjTRGjFQkBtwXjW42Pb5lQivp2E41/XGNOeWpg
         xu7hyYNu+icdw==
From:   materoy@proton.me
Cc:     Roy Matero <materoy@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: bindings: fix sorting of rust/bindings/bindings_helper.h's #includes
Message-ID: <20230426224748.34056-1-materoy@proton.me>
Feedback-ID: 71587999:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roy Matero <materoy@proton.me>

Fix sorting of rust/bindings/binding_helper.h's includes,
to maintain consistency and rust idoms

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1002

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


