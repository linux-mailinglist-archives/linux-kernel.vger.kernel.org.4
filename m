Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82BB6E508C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjDQTFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDQTE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF335BF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 557A462035
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 19:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26228C4339E;
        Mon, 17 Apr 2023 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681758295;
        bh=Es+n5/VxwrYKRoTO9yEi5YcqrEo9wXUokpGjthhzOWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RgJKJZP1Azyy4TtIdtY0e/Vw4MOdCwh3eRMrek9xlz58FkybYo90JfWDYWNFJRSPb
         SvesEN8BOVV13SyBwJeCHr9I3f0QTJRJ/TO0n7ftJKweAqvON4UY9Oah6ITeQLbdEI
         /MoOTIOoyfX//GONmpP6fAv3wXfANUVJMyxiY1UXRzpS8E4zBFvdWmOcmcd38/4737
         aq1RUS5eDBLgw6qTLA4zxqYK15kxqBKssKv7QidaALrYpqnv70mCyD0irRUofeQa0z
         QNRiXIBy1kh+Bk36UqyzHT+U65H7+AWL3CcUd3Ac05fzEcVeImSdl0zrhRksOXJYPr
         Cq4PNInLJMXBw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, vbabka@suse.cz, willy@infradead.org,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] mm/slab: add a missing semicolon on SLAB_TYPESAFE_BY_RCU example code
Date:   Mon, 17 Apr 2023 19:04:49 +0000
Message-Id: <20230417190450.1682-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417190450.1682-1-sj@kernel.org>
References: <20230417190450.1682-1-sj@kernel.org>
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

