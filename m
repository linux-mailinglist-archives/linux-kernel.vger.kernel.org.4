Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA216772C5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjAVVhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjAVVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:37:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E42216AE8;
        Sun, 22 Jan 2023 13:36:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD6F8B80B69;
        Sun, 22 Jan 2023 21:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E275EC4339E;
        Sun, 22 Jan 2023 21:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674423416;
        bh=clkwweBLCzG0Uo62eX5aQPwk/HsAYR54UNoF+5kvB1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXp/8AoZ5NemhfqiQOJqpc90MDm0X9GAOXs7K5DoSzz4EwgLuvZW4oGJkO4ALv5ZP
         8STwZ41HT+1EIfkh0209RU6Xms2vy6KQ0FoRZDeWLXTXXJvopZm0X/BXKoy8+GzVFE
         6QWr8nGNJnaj7toKYTRHjiccAh+mbrq4FFIeDsRoOLJe4FM5lHgRHJTPfnCFUX/YV1
         8YTU0gqoEWK0ILIN3A7cC9v9dzAPU4NFeMZpZL/bbjEm8WCLqiwGZdzrbauioceiGn
         8r+6mfpFeS99q8SZt2eH86w/v3cReJ8wF9wB2bP8goyX2Osg+jjsrEZDo8cFWEMBXY
         5e6RI2AqR8woQ==
From:   SeongJae Park <sj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] Docs/crypto/index: Add missing SPDX License Identifier
Date:   Sun, 22 Jan 2023 21:36:43 +0000
Message-Id: <20230122213650.187710-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122213650.187710-1-sj@kernel.org>
References: <20230122213650.187710-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing SPDX License Identifier for crypto documentation index file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/crypto/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/crypto/index.rst b/Documentation/crypto/index.rst
index da5d5ad2bdf3..95b0870e09b8 100644
--- a/Documentation/crypto/index.rst
+++ b/Documentation/crypto/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==========
 Crypto API
 ==========
-- 
2.25.1

