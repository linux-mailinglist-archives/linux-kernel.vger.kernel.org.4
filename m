Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594866A9FDF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCCTHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 14:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:07:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772B0193DC;
        Fri,  3 Mar 2023 11:07:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 101EE618C4;
        Fri,  3 Mar 2023 19:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65A9EC433EF;
        Fri,  3 Mar 2023 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677870431;
        bh=PHnhYJw7lOKNC/K62bUFD6whVdSdzWvUpSbIX01GCTU=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=YlbkJhPMzCpHIviAFYQabFWCkexKHlS+sFLFri41D+cY/QDv79r6ctkq0QLbmbW5I
         Bm2p9TlQtyDFEJTuzyOpki50MZICVdQL+A6mL8HUAGa4lqKBsQaiKve7iaAVMxG3el
         lz9ixYrHtoqb+X7eoFQJeixnCN7wvzskIaBvvdQ3Ii83kxuiZI8ehoApEAIvlgmbvg
         Mew/v02FDGTKVHtxwXa7zpboBp4qDBEwk4t86CvIIV95SaxAh6KLMK7R9tUoVT7lJT
         +s1F0vTP7U+XpRkX5UbujRLYJ8A4LcA5XHQYjmcCcvUST30F9hKkLwt5gPb65+ApuR
         Un3ZtOAeLlKpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 529BEC7EE2F;
        Fri,  3 Mar 2023 19:07:11 +0000 (UTC)
From:   Patrick Blass via B4 Relay 
        <devnull+patrickblass.mailbox.org@kernel.org>
Date:   Fri, 03 Mar 2023 20:06:29 +0100
Subject: [PATCH] rust: str: fix requierments->requirements typo for rust
 str
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-str-rs-typo-v1-1-d022b4a57591@mailbox.org>
X-B4-Tracking: v=1; b=H4sIADRFAmQC/x2N0QpAQBBFf0XzbAqbwq/Iw+4azIOlmU0k/27pP
 p1up3ODkjApdNkNQgcrbyFBmWfgFxtmQh4TQ1VUpkhDjYKiGK99Q0el9009utZMkAxnldCJDX7
 5nNVqJPmOXWji88/0w/O8RFEmYnYAAAA=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Niklas Mohrin <dev@niklasmohrin.de>
Cc:     Geoffrey Thomas <geofft@ldpreload.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viktor Garske <viktor@v-gar.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Blass <patrickblass@mailbox.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205;
 i=patrickblass@mailbox.org; h=from:subject:message-id;
 bh=g3xJefQ8BmKAXAFUnDC8xFZ5SkostIUiVotzVhaztoc=; =?utf-8?q?b=3DowEBbQKS/ZAN?=
 =?utf-8?q?AwAIAfr4tNPd5QZuAcsmYgBkAkVeU24iFhTfN+ud2zUjZukIEj9jZkHDkPJ0KTfS_?=
 =?utf-8?q?zsYYtjqJAjMEAAEIAB0WIQRyvooYoKyvwaJCarP6+LTT3eUGbgUCZAJFXgAKCRD6+?=
 =?utf-8?q?LTT3eUGbpw4EA_C4KmCm4ce1obC81DpHCncMJR8ODGcnmy/oGrsOnVXZHIShD8Ve3?=
 =?utf-8?q?uOtZ+JZFET+8lDz1q5S+Rjlbbgk_QG9KoTymReH2sNC96yCCy2ZClOPvDAtVvRVuX?=
 =?utf-8?q?zIDPGTFHlvqmVPMbfq+nTeynAoTdY2iEZjkdD3fsh_AzXlMX6c4tToXwQM/VLby4v?=
 =?utf-8?q?rVo0wPp9NjPJRPA+ntk1+gtqzHRyeWzbdrFXhqVSXM+iv6xO6H27+XL_cUgG4gn5B?=
 =?utf-8?q?5LT2n7xntqw1nKHTgkE7wXmnOxyPnVFrBZAYw2XcsEEyZEjipB6zqZlbA/xpY/xnu?=
 =?utf-8?q?aa06_R/ipAsUHiZv9POQZ/Kcg8IE/MJWQZ6O7m0ZS2xitvI6Y+tQtOooCjPan4dMQ?=
 =?utf-8?q?uZcADI4leGNNz1hTNI_GoO0xuJFGQ/IBcPGRQf04h8QtNpZpqT0dJ/GB7OjdDD53Y?=
 =?utf-8?q?I4JJCqZmzGqbC/D0Mj/tDhQ6FBJUNq6y_1E9FOqwNFjyR0iWWz3KPvjyzSntF/S7Q?=
 =?utf-8?q?zq+VmQUidg0cBOHZu5WWfJ51mPlMzLMkv796IU1lxFd32n_dQexjejIHgpQP+qCsb?=
 =?utf-8?q?f6wCE5cHUALFDAQZPwMVsvTqwaHs6BrXaSLP0lRGdHIT9lyjQ0w/vVnxh65O?=
 ykWIfZzDYmX6+z2cyKLv8E+Od+L52A/af90PSeBrtJ6PAJTIy+rCXZ4YvaWw==
X-Developer-Key: i=patrickblass@mailbox.org; a=openpgp;
 fpr=72BE8A18A0ACAFC1A2426AB3FAF8B4D3DDE5066E
X-Endpoint-Received: by B4 Relay for patrickblass@mailbox.org/default with auth_id=36
X-Original-From: Patrick Blass <patrickblass@mailbox.org>
Reply-To: <patrickblass@mailbox.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Blass <patrickblass@mailbox.org>

Fix a trivial spelling error in the rust str file.

Fixes: 247b365dc8dc ("rust: add `kernel` crate")
Reported-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/978
Signed-off-by: Patrick Blass <patrickblass@mailbox.org>
---
 rust/kernel/str.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index b771310fa4a4..cd3d2a6cf1fc 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -408,7 +408,7 @@ impl RawFormatter {
     /// If `pos` is less than `end`, then the region between `pos` (inclusive) and `end`
     /// (exclusive) must be valid for writes for the lifetime of the returned [`RawFormatter`].
     pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
-        // INVARIANT: The safety requierments guarantee the type invariants.
+        // INVARIANT: The safety requirements guarantee the type invariants.
         Self {
             beg: pos as _,
             pos: pos as _,

---
base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
change-id: 20230303-str-rs-typo-be1cc85db93f

Best regards,
-- 
Patrick Blass <patrickblass@mailbox.org>

