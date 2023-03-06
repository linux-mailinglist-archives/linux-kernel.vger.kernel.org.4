Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295C66AD137
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCFWKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCFWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:10:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379423A876;
        Mon,  6 Mar 2023 14:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8B80B8111A;
        Mon,  6 Mar 2023 22:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8604C433D2;
        Mon,  6 Mar 2023 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678140615;
        bh=KN5F0AoFgFiAv14Zs4VVwE5Kztdka3CdrjT1Qq8snyQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ar1g9Pvs6nI2YGY1crohlcib7jgCpYuLpx4nEfJAxZaICCg/2qHbFgKQMpwWYc5T/
         pReSqdlGSEgLqnK86GkxEVCGVmg6ocyZwGYIOESDg2YItz4gk2Uq3Y6At8fw2A3XYq
         2mR1D9LlFGahqIsYtr/+CBUT7ZRazFDCeoMUePlUeSEuw95eUclar8nfFeN52xkpro
         JXr2YK5zrIZz9Jz+WV6IKAgKW1gyWPAQnmUi0cUxXcVx45kt7JRp2LoAEVLQfAXEDr
         ZPummfBAAz0Iz9r5LDb+JsNZozRIqIq3rgrHmCS6RKFpP/Eq12V+qJ3uOIQxFXiF4t
         JcnRdmf6WL4bw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Cc:     linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH] docs: rust: point directly to the standalone installers
Date:   Mon,  6 Mar 2023 23:09:59 +0100
Message-Id: <20230306220959.240235-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Quick Start guide points to the Rust programming language front
page when it mentions the possibility of using the standalone
installers instead of `rustup`.

This was done to have a hopefully stable link, but it is not too
helpful: readers need to figure out how to reach the standalone
installers from there.

Thus point directly to the page (and anchor) with the table that
contains the standalone installers (plus signing key etc.).

If the link breaks in the future, we can always update it as
needed. And anyway having the full link includes the domain and
gives more information about where the old docs were in such
a broken link case, which may help.

Link: https://lore.kernel.org/linux-doc/CANiq72=gpzQyh1ExGbBWWNdgH-mTATdG5F600jKD1=NLLCn7wg@mail.gmail.com/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/quick-start.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index 13b7744b1e27..253d47791f0f 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -40,7 +40,7 @@ and run::
 
 Otherwise, fetch a standalone installer or install ``rustup`` from:
 
-	https://www.rust-lang.org
+	https://forge.rust-lang.org/infra/other-installation-methods.html#standalone
 
 
 Rust standard library source

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

