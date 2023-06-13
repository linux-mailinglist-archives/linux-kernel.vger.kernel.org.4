Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA2372E8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjFMQo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFMQoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:44:55 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B89C;
        Tue, 13 Jun 2023 09:44:51 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75d536afa43so72727585a.1;
        Tue, 13 Jun 2023 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686674690; x=1689266690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IdNyT3h/2Lj1GbQumw7eHKxO5LcFAdyfwGjCcOob+Zo=;
        b=lTe2j27ro7nHxwhpMNVMaiaqsf4h8H9Q/qLOKjmvScJxCAHq1286pDm9kGwx1Wlvgn
         xmyViIgptANeoO7AQV2B5sp4LEOOF4lfarWLeXHPIxInTmN+6ryQEUFD/6tu8M1orOxu
         hZwdlAxBJpy7ljsHMKQIjzPhlgZ28MEq85t+VshZ4QjCeQtGHxzh5pMioiw0BU3UWGsD
         OYRGhDbbwU7lVsc09Kc+Vg/PLTwpOMB89vA2wUOpyC78UJ5ZIiMLe3ylNprTuYNjLeWH
         KWImR8JsSnnpr6bzg8QEmOXKdtsV6ua/C8h7fRVX8QtNUfmzk376Xr+D4TBpO3mhJJnZ
         LRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686674690; x=1689266690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdNyT3h/2Lj1GbQumw7eHKxO5LcFAdyfwGjCcOob+Zo=;
        b=DzVod5mSYo/G8Tu3Tjx569EtHvq3GunqpM5fAgqGyVt+VbEwItYenQBJhxcjH1z57F
         Hi9G2SMUm97jlM/dQbUtrTBWbgdejjkqXhfl0MclhLc8vxyBasiCFUoQ3dfGEyW2m4FK
         14QDk/hU1Ae9/3NAcj8qpNO06dOpn4+tz0KS0vD5Zhnom4YXMyHLcvI8VoDmgQi9M238
         6pH7i1C6+UvFgNzfuv12Yd5mwN+pGXU4Uimldn8uOHZC2fH2X+L1lNlFxyJvWpttmAve
         lfooTa9JCkyUbIH44x/hrvtYqB3YRJxy7rVWl29wLmYEgbhP9ju9MCTjnebF5SEg0Wme
         ohOA==
X-Gm-Message-State: AC+VfDx99m84V/6xO1SLGMhk9TFExmcuG4bvRVjvmJCjW/hFuiiYCpiD
        MkBQyQLaA4aYi1fbcPSR61c=
X-Google-Smtp-Source: ACHHUZ4xnn+16fUiAKlxfeCVeOhanJqobW3OzNkpPJDwLznYPOp0hNxDwK7UD1IIJuplfx+fgqczwA==
X-Received: by 2002:a37:511:0:b0:75e:b8ae:a4dd with SMTP id 17-20020a370511000000b0075eb8aea4ddmr14101150qkf.13.1686674690343;
        Tue, 13 Jun 2023 09:44:50 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c16-20020a05620a135000b0075aff6f835bsm3746625qkl.19.2023.06.13.09.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 09:44:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 92A5D27C0054;
        Tue, 13 Jun 2023 12:44:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 13 Jun 2023 12:44:48 -0400
X-ME-Sender: <xms:_ZyIZCEMpKU3-0FQezo9hIr467C7165mPS6_leTnoG_hcXlBsQdw4A>
    <xme:_ZyIZDXsIP48kLEAol0ApxB2Ct_MvTYpIUc-IwlXBzEIp5nxs25-ya-_ezy6xkB1s
    XrMDpMwCJjNLAm63w>
X-ME-Received: <xmr:_ZyIZMKIeHYCuwQFSbzwClCCq57qpEjQEnWPm28vakOP_Vyw-c4eDwzAlcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedujedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepfeekieejhfevhfffgfeftdektdevueelgffgjeefhfduheeljeeiieekvdef
    hfehnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqh
    hunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:_ZyIZMHy609JHLuw-CGaHlviIaJq9EF5Za9rmGWUXMhgmdiQMbWVMQ>
    <xmx:_ZyIZIWGv2dL329uWW1nEu3yzcMIY7gSBZFr1cqWNfYEGSzNs25heA>
    <xmx:_ZyIZPNg6hhPotxbNG4wHr1CSBeNcSROi_GLpyj-5ID9SlkgJfZ_Yw>
    <xmx:AJ2IZC_t6OmZoq9xsmiOl8jjfC6rLsw97goNv-8JHfsiThOjA6soBA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jun 2023 12:44:45 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andreas Hindborg <nmi@metaspace.dk>, stable@vger.kernel.org
Subject: [PATCH] rust: allocator: Prevents mis-aligned allocation
Date:   Tue, 13 Jun 2023 09:42:58 -0700
Message-Id: <20230613164258.3831917-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the KernelAllocator simply passes the size of the type Layout
to krealloc(), and in theory the alignment requirement from the type
Layout may be larger than the guarantee provided by SLAB, which means
the allocated object is mis-aligned.

Fixes this by adjusting the allocation size to the nearest power of two,
which SLAB always guarantees a size-aligned allocation. And because Rust
guarantees that original size must be a multiple of alignment and the
alignment must be a power of two, then the alignment requirement is
satisfied.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Co-developed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
Signed-off-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Cc: stable@vger.kernel.org # v6.1+
---
Some more explanation:

* Layout is a data structure describing a particular memory layout,
  conceptionally it has two fields: align and size.

  * align is guaranteed to be a power of two.
  * size can be smaller than align (only when the Layout is created via
    Layout::from_align_size())
  * After pad_to_align(), the size is guaranteed to be a multiple of
    align

For more information, please see: 

	https://doc.rust-lang.org/stable/std/alloc/struct.Layout.html

 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/allocator.rs        | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3e601ce2548d..6619ce95dd37 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,3 +15,4 @@
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
 const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
+const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
index 397a3dd57a9b..66575cf87ce2 100644
--- a/rust/kernel/allocator.rs
+++ b/rust/kernel/allocator.rs
@@ -11,9 +11,24 @@
 
 unsafe impl GlobalAlloc for KernelAllocator {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
+        // Customized layouts from `Layout::from_size_align()` can have size < align, so pads first.
+        let layout = layout.pad_to_align();
+
+        let mut size = layout.size();
+
+        if layout.align() > bindings::BINDINGS_ARCH_SLAB_MINALIGN {
+            // The alignment requirement exceeds the slab guarantee, then tries to enlarges the size
+            // to use the "power-of-two" size/alignment guarantee (see comments in kmalloc() for
+            // more information).
+            //
+            // Note that `layout.size()` (after padding) is guaranteed to be muliples of
+            // `layout.align()`, so `next_power_of_two` gives enough alignment guarantee.
+            size = size.next_power_of_two();
+        }
+
         // `krealloc()` is used instead of `kmalloc()` because the latter is
         // an inline function and cannot be bound to as a result.
-        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8 }
+        unsafe { bindings::krealloc(ptr::null(), size, bindings::GFP_KERNEL) as *mut u8 }
     }
 
     unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
-- 
2.39.2

