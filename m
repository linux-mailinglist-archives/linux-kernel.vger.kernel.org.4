Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6CC6E01BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjDLWS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDLWS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1674C1F;
        Wed, 12 Apr 2023 15:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC97F63942;
        Wed, 12 Apr 2023 22:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE84C433D2;
        Wed, 12 Apr 2023 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681337934;
        bh=Q0bqOpoIZZcmgwns//TSAMeE2DQS7zVb958Lhe91z04=;
        h=From:To:Cc:Subject:Date:From;
        b=JKJrm/Wp+slCy+gATbqfwo+lkM2NDwq6z3YpgXrdo7eZt3jqCO+BcU4NQhB6cJYtu
         mMyMSXEX7XqtW1REGrbKjegPVgutMNxLl1fcEIOKvNh/ZfHlGTb3zGvKC/NTigVsDr
         JGin1H+5CYBqnvpiDDX0yuzXqAYtg+aDDybnm0dEO3IJUc8AEs86bboxD3waAiRGM2
         RmEDleiG1ZzN9RUhmcBGmD4z/2JRTLhickJu5P4PqLp6E0GoZBkIbb3vSiGmQeiAs5
         601QGIdqCqZMn4EnfZaOWEbuZZkUnhpvUvWmiB+J7uGiZ5G6rW4ujHo8nfLhuuSVJO
         bP51V859j8ZUg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <benno.lossin@proton.me>
Subject: [PATCH] MAINTAINERS: add Benno Lossin as Rust reviewer
Date:   Thu, 13 Apr 2023 00:18:22 +0200
Message-Id: <20230412221823.830135-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno has been involved with the Rust for Linux project for
the better part of a year now. He has been working on solving
the safe pinned initialization problem [1], which resulted in
the pin-init API patch series [2] that allows to reduce the
need for `unsafe` code in the kernel. He is also working on
the field projection RFC for Rust [3] to bring pin-init as
a language feature.

His expertise with the language will be very useful to have
around in the future if Rust grows within the kernel, thus
add him to the `RUST` entry as reviewer.

Link: https://rust-for-linux.com/the-safe-pinned-initialization-problem [1]
Link: https://lore.kernel.org/rust-for-linux/20230408122429.1103522-1-y86-dev@protonmail.com/ [2]
Link: https://github.com/rust-lang/rfcs/pull/3318 [3]
Cc: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..bf9deaa4aa5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18225,6 +18225,7 @@ M:	Wedson Almeida Filho <wedsonaf@gmail.com>
 R:	Boqun Feng <boqun.feng@gmail.com>
 R:	Gary Guo <gary@garyguo.net>
 R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
+R:	Benno Lossin <benno.lossin@proton.me>
 L:	rust-for-linux@vger.kernel.org
 S:	Supported
 W:	https://github.com/Rust-for-Linux/linux

base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.40.0

