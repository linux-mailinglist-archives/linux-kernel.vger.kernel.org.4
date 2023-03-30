Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258476D0E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjC3SwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjC3SwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:52:09 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC316E053;
        Thu, 30 Mar 2023 11:51:55 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q88so14721561qvq.13;
        Thu, 30 Mar 2023 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680202315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47c2PWe5qVyOha958jeE3aoNiiHAs1FUFUGGzZPy6+s=;
        b=i+yPxp67+6wWMO6khlTB7hcLHxO3x5IUhf5QLePIW3oTXsKlFXYc6o4bVv/6jnUca/
         +cGP2fi/kcJ+j/nb+t+xXj/lmjDg4cY3bP2uxSya64ST3ZZTDnObxvXiMgFJsSouwRda
         WaFGskNfwTZWPSgmnx0VCLMNSLEpFzYigZMgsmpMynQ8vTe6XCwTdy5d9kRIHxMKkkIy
         Ro8gL4mycEyt3WqErpEaBcrKj4FHt2t/FXkhynvPkBVdpsEQxV3WOVkb7/2F0vFUe2wT
         /WPFYucwZMmF35crfOorCaJckDzoQOpEkU4JZqQzFX4RT3SYRy7wFU1E49G89B7WVd5w
         6Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680202315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47c2PWe5qVyOha958jeE3aoNiiHAs1FUFUGGzZPy6+s=;
        b=4s4f0pOX0t5og5Wc/g/FxGqWBD9QlgzIAlTnerpWl+EQ2uWG6zffe79QZqFuX4oRrI
         UT14fQn/ro7LYB5LoNnQHh84a9IpVeXGsYkZigXKt3vOcUV7QReQEqTw2dgr9QbzVHY7
         a4U85XVcIXr2MIPDkfB5AIxwf6AYdJChYfuI5cJ3trrPK96lshwg8QaQE41zIP2zIkcV
         wjx8459QbW7MdKA10JqojuHzmUwiQjzT7Rb535WrOB+AiT5X12em5YfzB52bC+ENUmGz
         1+pZHsL90s1qNKNRXs1FVGkRvkUsANDy+WODmkihgwsUoJTYhcprn2zGeUKTbRK+AuNC
         0hUg==
X-Gm-Message-State: AAQBX9f2uatVmRdc5evrK0roOTalPLlxQg240Bi1AnPa++qRi3rMf85b
        I1NNFy05phMx87Geqg/RaUs=
X-Google-Smtp-Source: AKy350afu04tCKTl/mkx1KSAbuLdHxHoW4h+N7kPyrx2raFUmNSxENkwGYAutU0eOwmO1BZvqA9vYA==
X-Received: by 2002:ad4:5dcd:0:b0:5a9:c0a1:d31a with SMTP id m13-20020ad45dcd000000b005a9c0a1d31amr35356911qvh.49.1680202314820;
        Thu, 30 Mar 2023 11:51:54 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l2-20020a37f902000000b007422fd3009esm79251qkj.20.2023.03.30.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 11:51:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id B1A2227C0054;
        Thu, 30 Mar 2023 14:51:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 30 Mar 2023 14:51:53 -0400
X-ME-Sender: <xms:SdolZH6chbPT7xkezYY8101iVtPwWd-gWXp9mzT2NZvLWqpvoKMf4Q>
    <xme:SdolZM7xmkqZF6oDyqrDkAnJxBRuj67-QIKBvymFtOaG_TttX2qJNUiM74tQCitCv
    BpEttfAkgbuRVd43g>
X-ME-Received: <xmr:SdolZOdggH7l5hf2QJcmCpWt8L8fgBkWKhhjg04p3QDvUq74Iszl4JxLs_osKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehledgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:SdolZII4kB9iIa9M-yz0fTCBcq7JnnsSdlrnRPbejOzxTOsGed9EJQ>
    <xmx:SdolZLKfSBN2tHShTRpzQovc2fU0WzCxhth208dwfIBVB3h46MOPSg>
    <xmx:SdolZByHZIqHl1Oml3ixm6w3iQX7Bu_d1UmsaWZ4hBetQaHGt3xOEA>
    <xmx:SdolZNyY2uMb4HForYuYOnC6_EZC4-jJT1Du4Y47lo0Y5Q7M_Qd_eA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Mar 2023 14:51:53 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [DRAFT 2/2] locking/selftest: Add AA deadlock selftest for Mutex and SpinLock
Date:   Thu, 30 Mar 2023 11:51:03 -0700
Message-Id: <20230330185103.1444086-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330185103.1444086-1-boqun.feng@gmail.com>
References: <ZCXZMNj7aOKbC7Ev@boqun-archlinux>
 <20230330185103.1444086-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c       |  3 +-
 lib/rust_locking_selftest.rs | 99 ++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 9ef3ad92bc47..a4830e3cc998 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -60,6 +60,7 @@ __setup("debug_locks_verbose=", setup_debug_locks_verbose);
 #define LOCKTYPE_RTMUTEX 0x20
 #define LOCKTYPE_LL	0x40
 #define LOCKTYPE_SPECIAL 0x80
+#define LOCKTYPE_RUST	0x100
 
 static struct ww_acquire_ctx t, t2;
 static struct ww_mutex o, o2, o3;
@@ -1427,7 +1428,7 @@ static int testcase_successes;
 static int expected_testcase_failures;
 static int unexpected_testcase_failures;
 
-static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
+void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 {
 	int saved_preempt_count = preempt_count();
 #ifdef CONFIG_PREEMPT_RT
diff --git a/lib/rust_locking_selftest.rs b/lib/rust_locking_selftest.rs
index 61560a2f3c6b..c050edf2ac9a 100644
--- a/lib/rust_locking_selftest.rs
+++ b/lib/rust_locking_selftest.rs
@@ -2,11 +2,110 @@
 
 //! Selftests for Rust locking APIs.
 
+use kernel::pr_cont;
 use kernel::prelude::*;
 const __LOG_PREFIX: &[u8] = b"locking selftest\0";
 
+extern "C" {
+    fn dotest(
+        testcase_fn: extern "C" fn(),
+        expected: core::ffi::c_int,
+        lockclass_mask: core::ffi::c_int,
+    );
+}
+
+/// Same as the definition in lib/locking-selftest.c
+#[allow(dead_code)]
+enum Expectation {
+    Failure = 0,
+    Success = 1,
+    Timeout = 2,
+}
+
+trait LockTest {
+    const EXPECTED: Expectation;
+    const MASK: i32;
+
+    fn test();
+}
+
+extern "C" fn bridge<T: LockTest>() {
+    T::test();
+}
+
+fn test<T: LockTest>() {
+    pr_cont!("\n");
+    pr_cont!("{}: ", core::any::type_name::<T>());
+    unsafe {
+        dotest(bridge::<T>, T::EXPECTED as core::ffi::c_int, T::MASK);
+    }
+    pr_cont!("\n");
+}
+
+struct SpinLockAATest;
+
+impl LockTest for SpinLockAATest {
+    const EXPECTED: Expectation = Expectation::Failure;
+    const MASK: i32 = 0x100; // TODO
+
+    fn test() {
+        use kernel::static_lock_class;
+        use kernel::sync::SpinLock;
+        use kernel::{c_str, stack_pin_init};
+
+        let key = static_lock_class!();
+        let name = c_str!("A1");
+
+        stack_pin_init!(
+            let a1 = SpinLock::new(0, name, key)
+        );
+
+        stack_pin_init!(
+            let a2 = SpinLock::new(0, name, key)
+        );
+
+        let a1 = a1.unwrap();
+        let a2 = a2.unwrap();
+
+        let _x = a1.lock();
+        let _y = a2.lock();
+    }
+}
+
+struct MutexAATest;
+
+impl LockTest for MutexAATest {
+    const EXPECTED: Expectation = Expectation::Failure;
+    const MASK: i32 = 0x100; // TODO
+
+    fn test() {
+        use kernel::static_lock_class;
+        use kernel::sync::Mutex;
+        use kernel::{c_str, stack_pin_init};
+
+        let key = static_lock_class!();
+        let name = c_str!("A1");
+
+        stack_pin_init!(
+            let a1 = Mutex::new(0, name, key)
+        );
+
+        stack_pin_init!(
+            let a2 = Mutex::new(0, name, key)
+        );
+
+        let a1 = a1.unwrap();
+        let a2 = a2.unwrap();
+
+        let _x = a1.lock();
+        let _y = a2.lock();
+    }
+}
+
 /// Entry point for tests.
 #[no_mangle]
 pub extern "C" fn rust_locking_test() {
     pr_info!("Selftests for Rust locking APIs");
+    test::<SpinLockAATest>();
+    test::<MutexAATest>();
 }
-- 
2.39.2

