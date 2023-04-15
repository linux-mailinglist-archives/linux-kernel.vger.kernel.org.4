Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9651A6E2ED2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 05:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjDODcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 23:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDODcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 23:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E871A4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 20:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11FD6649C2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050D3C433EF;
        Sat, 15 Apr 2023 03:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681529529;
        bh=Es+n5/VxwrYKRoTO9yEi5YcqrEo9wXUokpGjthhzOWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gfAHqZdYLDEtDBNe3izGYDVYbHgZDIpJe6szA/ogq2htIeX+b9ERpbUxB6TMIxL0u
         iNi4MOa0jem3Y/yIE+XIYwVVdw3GgvxjfIzAatbQuOugxH5EFQYOCVkyk9CuzV00NH
         q8+rxycDEB52drl3fQrIz+Dl7BdGKApw4hiFHSq08c3kTrtWFHdYj69pYVf4+pK0zm
         wCiN+0Rb72bkl7b4/8LNFQ+uxhDt/VL7CKoM+EEW4lMD4z2B2cNsT6iJ1Ju66wNGs0
         BPv3cP+eBH/KhtEaBqKFQ4lvK+lAd7Y4+tUdh+Ok4iC54B3un00hJsch43WLnveedB
         CDQYMt4sdn/8w==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, willy@infradead.org, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 1/2] mm/slab: add a missing semicolon on SLAB_TYPESAFE_BY_RCU example code
Date:   Sat, 15 Apr 2023 03:31:58 +0000
Message-Id: <20230415033159.4249-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415033159.4249-1-sj@kernel.org>
References: <20230415033159.4249-1-sj@kernel.org>
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

