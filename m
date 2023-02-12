Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F64B69395D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 19:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBLSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 13:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 13:33:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E198C1026F;
        Sun, 12 Feb 2023 10:33:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74846B80D32;
        Sun, 12 Feb 2023 18:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4CDC433D2;
        Sun, 12 Feb 2023 18:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676226779;
        bh=TbK+dfs1uQABYq4uLbFCwyXI3AlbIhsE9h4Y4YYFcU8=;
        h=From:To:Cc:Subject:Date:From;
        b=YLCNvPm3/Ce5DBOtdIxv6eHSjKlXTD4aCgjjcQA5VXaz1Ei604pCnjl+hFJZ6DTqZ
         c9XQCP1Iz1lLvd2XGeRdLma6+gG02QdFqSbcG9vurv/84DRTuqo3K+oykAM0VYD2gQ
         5uQ75I4SeI5Jk9OhJDrZMFQKxxRsiqwTILiEhdLx39BzEi7mG+g7XtmwhTvssOcEDa
         +VK6P1qG4i3hRAlKBPjaQ4SNZUUWTZmThahLuDddhGa+rMnYOHBb3aN9xqfvHBVAHd
         6lckaleVSbSbZLj6Z92E0AeS+Kz1SS11uJL2s4zIWBl6lRv51+bOvlG+YNOvaI66Xt
         rdaOH/bHzeG/A==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust for 6.3
Date:   Sun, 12 Feb 2023 19:32:49 +0100
Message-Id: <20230212183249.162376-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A new set of features for the Rust support.

By the time you pick this, these commits will have been in linux-next
for quite a while. No conflicts expected. No changes to the C side.

Please pull for v6.3 -- thanks!

Cheers,
Miguel

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux tags/rust-6.3

for you to fetch changes up to 7ea01d3169a28d090fc8f22e7fcb4e4f1090c2d2:

  rust: delete rust-project.json when running make clean (2023-02-07 11:24:50 +0100)

----------------------------------------------------------------
Rust changes for v6.3

More core additions, getting closer to a point where the first Rust
modules can be upstreamed. The major ones being:

- Sync: new types 'Arc', 'ArcBorrow' and 'UniqueArc'.

- Types: new trait 'ForeignOwnable' and new type 'ScopeGuard'.

There is also a substantial removal in terms of lines:

- 'alloc' crate: remove the 'borrow' module (type 'Cow' and trait
  'ToOwned').

----------------------------------------------------------------
Boqun Feng (1):
      rust: MAINTAINERS: Add the zulip link

Finn Behrens (1):
      rust: prelude: prevent doc inline of external imports

Gary Guo (1):
      rust: compiler_builtins: make stubs non-global

Maíra Canal (1):
      rust: delete rust-project.json when running make clean

Miguel Ojeda (1):
      rust: alloc: remove the `borrow` module (`ToOwned`, `Cow`)

Wedson Almeida Filho (12):
      rust: sync: add `Arc` for ref-counted allocations
      rust: sync: allow type of `self` to be `Arc<T>` or variants
      rust: sync: allow coercion from `Arc<T>` to `Arc<U>`
      rust: sync: introduce `ArcBorrow`
      rust: sync: allow type of `self` to be `ArcBorrow<T>`
      rust: sync: introduce `UniqueArc`
      rust: sync: add support for dispatching on Arc and ArcBorrow.
      rust: types: introduce `ScopeGuard`
      rust: types: introduce `ForeignOwnable`
      rust: types: implement `ForeignOwnable` for `Box<T>`
      rust: types: implement `ForeignOwnable` for the unit type
      rust: types: implement `ForeignOwnable` for `Arc<T>`

 MAINTAINERS                     |   1 +
 Makefile                        |   2 +-
 rust/Makefile                   |  15 ++
 rust/alloc/borrow.rs            | 498 --------------------------------------
 rust/alloc/lib.rs               |   3 +-
 rust/alloc/vec/mod.rs           |   3 +
 rust/bindings/bindings_helper.h |   1 +
 rust/bindings/lib.rs            |   1 +
 rust/compiler_builtins.rs       |   5 +-
 rust/helpers.c                  |  19 ++
 rust/kernel/lib.rs              |   6 +
 rust/kernel/prelude.rs          |   8 +-
 rust/kernel/sync.rs             |  10 +
 rust/kernel/sync/arc.rs         | 524 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/types.rs            | 215 ++++++++++++++++-
 15 files changed, 808 insertions(+), 503 deletions(-)
 delete mode 100644 rust/alloc/borrow.rs
 create mode 100644 rust/kernel/sync.rs
 create mode 100644 rust/kernel/sync/arc.rs
