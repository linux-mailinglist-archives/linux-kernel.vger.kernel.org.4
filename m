Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9681671FECE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjFBKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjFBKSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:18:32 -0400
Received: from out0-199.mail.aliyun.com (out0-199.mail.aliyun.com [140.205.0.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE62E7;
        Fri,  2 Jun 2023 03:18:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047202;MF=changxian.cqs@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.TJK9myK_1685701102;
Received: from localhost(mailfrom:changxian.cqs@antgroup.com fp:SMTPD_---.TJK9myK_1685701102)
          by smtp.aliyun-inc.com;
          Fri, 02 Jun 2023 18:18:23 +0800
From:   "Qingsong Chen" <changxian.cqs@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Qingsong Chen" <changxian.cqs@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        <rust-for-linux@vger.kernel.org>
Subject: [PATCH v2 0/3] Rust scatterlist abstractions
Date:   Fri, 02 Jun 2023 18:18:16 +0800
Message-Id: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

This is a version of scatterlist abstractions for Rust drivers.

Scatterlist is used for efficient management of memory buffers, which is
essential for many kernel-level operations such as Direct Memory Access
(DMA) transfers and crypto APIs.

This patch should be a good start to introduce the crypto APIs for Rust
drivers and to develop cipher algorithms in Rust later.

Changelog:
----------
v1 -> v2:
- Split the old patch into smaller parts.
- Remove the selftest module, and place those use cases in the doc.
- Repair some invalid hyperlinks in the doc.
- Put some `cfgs` inside functions to avoid boilerplate.
====================

Qingsong Chen (3):
  rust: kernel: add ScatterList abstraction
  rust: kernel: implement iterators for ScatterList
  rust: kernel: add SgTable abstraction

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  14 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 502 ++++++++++++++++++++++++++++++++
 4 files changed, 518 insertions(+)
 create mode 100644 rust/kernel/scatterlist.rs

-- 
2.40.1

