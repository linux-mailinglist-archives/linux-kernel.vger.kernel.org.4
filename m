Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CBD73D549
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjFYXZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFYXZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:25:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD99CD;
        Sun, 25 Jun 2023 16:25:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98de21518fbso214560166b.0;
        Sun, 25 Jun 2023 16:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687735551; x=1690327551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lAHVstITZzA8Q5MqoCBkNupEYNl7yx+dIPVaE6IqP6Q=;
        b=LVORXXF4nTpjvYLnTi6vueF1IN+cPMX2HaMqGACv3ozab/9KZsWw7xqn+gJwYmW6+q
         bmMIBoZZ483CbAy1ERzgs0Gko2AS/BSYliXKF+S+EReonvCxS3HnpujjVHOOi4Dgg68d
         GXo+/ZfEdtzNTppxNmzB6C0gzI7cVxq94j/JrjdEwTwWENowqf4ohzeOn6WfYehBTZpp
         l4clAZDW0okJO3r/ttuMIZCSDAcKNMIoe52h0lL0etO0aQ+BeNP0Bo+HJzzx0Lyye2tq
         cnRHsXNyk6qmjPSyRRXvCSLr1LqM9YfbIF2lrFPMdE1ayvwoALqqHc44bmazRgvLHFNR
         tlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687735551; x=1690327551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAHVstITZzA8Q5MqoCBkNupEYNl7yx+dIPVaE6IqP6Q=;
        b=PbuUMFzQwbn1NYATui/Oe0Kb5UMZXDBhvWXd5R9jOhyPlHr98fnZJlN6dZ6gRUeCYX
         TyWi3XkAWbrHFSEZt9o+MsUfGvfQEWSy6TwDqJ0yhuIsnpxySdaX0OK8cg84V6kKueJa
         XDbKj0vsgCpPoZltIB3Pb/gH89DUTXDSBaGsDxnqY0NBAzkU1VIVr9nKBU8dp9ruyPOi
         ivVWCaXBjWTGGGBCuay3k8C2Jkqtd41O9zqKc6uWnDKazpnVVXSuhDE/FWU8cK8kHNLl
         UetSFh/zuQChqqVpTEAxEOUth04Br5zyaDmckI/KXIUegkVmZR/zIH9Mb7D5Z0PU3BpD
         U+0w==
X-Gm-Message-State: AC+VfDwEvhnW+qeXyK859xTFUVPmKNPD120Dm01Q0vwUZymCJYlnWxKq
        cDJuhdQyHZMTxdslLNMQTEekVUB22wk=
X-Google-Smtp-Source: ACHHUZ4GjwLa91NLNXYrntKkFHHUi2S1jZClKU5CWWZFicGLQd6F4LOkQlWr1tV550iu3N09jn3Qhw==
X-Received: by 2002:a17:907:a42:b0:96f:afe9:25c7 with SMTP id be2-20020a1709070a4200b0096fafe925c7mr25150936ejc.10.1687735550569;
        Sun, 25 Jun 2023 16:25:50 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906a38700b00985ed2f1584sm2559932ejz.187.2023.06.25.16.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 16:25:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 31AD827C0054;
        Sun, 25 Jun 2023 19:25:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 25 Jun 2023 19:25:48 -0400
X-ME-Sender: <xms:_MyYZOeG7nS9YlTWGhXMbKrbw4_z9jbZZnVF4Kjtd_BF5N2JOsgy1A>
    <xme:_MyYZIMWrQ1kordw2Sz8jBkPWhoXYxvVnMVi3M9j7GgSZhIQxNwmjimchZP4B5c13
    3mk5jWkzxah567lMQ>
X-ME-Received: <xmr:_MyYZPifEKfshjRJwlRZVB1dXbjwdRmnDwdnJz_24L8v8ATVbDLZKAFlPOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehuddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepueeiheevfeegjedugeefheeihefgtefhhfdttdeifeejiefgieeuheeugeek
    feelnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgv
X-ME-Proxy: <xmx:_MyYZL9YUN8fXOw1KO5mdmqVyXn_FGJ30obrSFyh31mnpACndga_xA>
    <xmx:_MyYZKsnSfNrl-WZcYujatniLEWCjjlPyDPYIN2zZ5uowHbpJMYZmg>
    <xmx:_MyYZCEiVKwm5gw9JRqgkfhd1ez_lixb19vI3BrMgyGL6Qwt5a3IfQ>
    <xmx:_MyYZIB2h0BbksymoD0iqzj3xnlb_Qx3PF95w3nB5fglqpVut-2Hwg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Jun 2023 19:25:47 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v2] rust: alloc: Add realloc and alloc_zeroed to the GlobalAlloc impl
Date:   Sun, 25 Jun 2023 16:25:28 -0700
Message-Id: <20230625232528.89306-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While there are default impls for these methods, using the respective C
api's is faster. Currently neither the existing nor these new
GlobalAlloc method implementations are actually called. Instead the
__rust_* function defined below the GlobalAlloc impl are used. With
rustc 1.71 these functions will be gone and all allocation calls will go
through the GlobalAlloc implementation.

Link: https://github.com/Rust-for-Linux/linux/issues/68
Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
[boqun: add size adjustment for alignment requirement]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
Miguel, I fold my diff into Björn's original patch and make a v2, it
relies on the other patch:

	https://lore.kernel.org/rust-for-linux/6e61f06f-2411-0bcb-926b-0a6927096f20@gmail.com/

So this v2 (if all goes well) is targeted for v6.6, JFYI.

v1 -> v2:

*	Add size adjustment for align requirement.

 rust/kernel/allocator.rs | 59 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
index 66575cf87ce2..af723c2924dc 100644
--- a/rust/kernel/allocator.rs
+++ b/rust/kernel/allocator.rs
@@ -9,8 +9,17 @@
 
 struct KernelAllocator;
 
-unsafe impl GlobalAlloc for KernelAllocator {
-    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
+impl KernelAllocator {
+    /// # Safety
+    ///
+    /// * `ptr` can be either null or a pointer which has been allocated by this allocator.
+    /// * `layout` must have a non-zero size.
+    unsafe fn krealloc_with_flags(
+        &self,
+        ptr: *mut u8,
+        layout: Layout,
+        flags: bindings::gfp_t,
+    ) -> *mut u8 {
         // Customized layouts from `Layout::from_size_align()` can have size < align, so pads first.
         let layout = layout.pad_to_align();
 
@@ -26,9 +35,22 @@ unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
             size = size.next_power_of_two();
         }
 
-        // `krealloc()` is used instead of `kmalloc()` because the latter is
-        // an inline function and cannot be bound to as a result.
-        unsafe { bindings::krealloc(ptr::null(), size, bindings::GFP_KERNEL) as *mut u8 }
+        // SAFETY:
+        //
+        // * `ptr` is either null or a pointer returned from a previous k{re}alloc() by the function
+        //   safety requirement.
+        //
+        // * `size` is greater than 0 since it's either a `layout.size()` (which cannot be zero
+        //    according to the function safety requirement) or a result from `next_power_of_two()`.
+        unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags) as *mut u8 }
+    }
+}
+
+unsafe impl GlobalAlloc for KernelAllocator {
+    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
+        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
+        // requirement.
+        unsafe { self.krealloc_with_flags(ptr::null_mut(), layout, bindings::GFP_KERNEL) }
     }
 
     unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
@@ -36,6 +58,33 @@ unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
             bindings::kfree(ptr as *const core::ffi::c_void);
         }
     }
+
+    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
+        // SAFETY:
+        // * `new_size` when rounded up to the nearest multiple of `layout.align()`, will not
+        //   overflow `isize` by the function safety requirement.
+        // * `layout.align()` is a proper alignment (i.e. not zero and must be a power of two).
+        let layout = unsafe { Layout::from_size_align_unchecked(new_size, layout.align()) };
+
+        // SAFETY:
+        // * `ptr` is either null or a pointer allocated by this allocator by function safety
+        //   requirement.
+        // * the size of `layout` is not zero because `new_size` is not zero by function safety
+        //   requirement.
+        unsafe { self.krealloc_with_flags(ptr, layout, bindings::GFP_KERNEL) }
+    }
+
+    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
+        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
+        // requirement.
+        unsafe {
+            self.krealloc_with_flags(
+                ptr::null_mut(),
+                layout,
+                bindings::GFP_KERNEL | bindings::__GFP_ZERO,
+            )
+        }
+    }
 }
 
 #[global_allocator]
-- 
2.39.2

