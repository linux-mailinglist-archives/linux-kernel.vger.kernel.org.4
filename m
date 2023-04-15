Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7316E2DF7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 02:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjDOAiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 20:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDOAiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 20:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE447D80
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:38:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D083364AD9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 00:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E298CC433D2;
        Sat, 15 Apr 2023 00:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681519086;
        bh=Es+n5/VxwrYKRoTO9yEi5YcqrEo9wXUokpGjthhzOWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NBcuk7R/SX1FJHH9tUOzXxSzgOXFK5Jqi5KCLIAbzLZtDX8DdLN45vwOdbrn1N1Bd
         ISFzPFRifzqI3bAVZzGdl/W1i5fyj7JBkfcRYA6n5DohQ6mh2Ix3ROfzk831+gA0ZR
         bRSv3oYmsL6/IWhXgz1fKZVmbVInyF7xieLyHmQjX6oC0Xc2afdRsl6x1z+/LDnExG
         1+CQygGAwJFtemC6iFzc9RhEWz1lNHq3Mc/sKmuLymiUmppai4Mh+/fRUNHarwkHb8
         uLzBIfFqYcUXuzqJd9X5Z31m+r0KoTaLCL7r9iW38GqiwmhGGHihJmJ3FINdoI30vC
         bPR3UO5U7u5CA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/2] mm/slab: add a missing semicolon on SLAB_TYPESAFE_BY_RCU example code
Date:   Sat, 15 Apr 2023 00:37:52 +0000
Message-Id: <20230415003754.1852-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415003754.1852-1-sj@kernel.org>
References: <20230415003754.1852-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An example code snippet for SLAB_TYPESAFE_BY_RCU is missing a semicolon.
Add it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index f8b1d63c63a3..b18e56c6f06c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -53,7 +53,7 @@
  * stays valid, the trick to using this is relying on an independent
  * object validation pass. Something like:
  *
- *  rcu_read_lock()
+ *  rcu_read_lock();
  * again:
  *  obj = lockless_lookup(key);
  *  if (obj) {
-- 
2.25.1

