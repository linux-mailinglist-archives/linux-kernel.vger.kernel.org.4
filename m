Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27095B40B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiIIUac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiIIU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94712F206
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B97C4620D6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 20:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305CCC433D6;
        Fri,  9 Sep 2022 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755347;
        bh=IVI0uztyLdqiIcGkJ6QAz29p+51cm+1zAFG0uPXs980=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgCf8HHYz+Mue5wkrTQp6HPSQvKWiS/WVzqdQZ76t+jXZZ+M0gL9R8qffIzGMLUW4
         92RFwyduoEUZ0+aR+LCs+MpVfSZEnThVH9Vlw3KufEnPHRUeRwEasfpxjMHsbwy/pP
         hpSsNN8qLbSWViLgcBT4yBxnERNoRJozW708Q61kRTx/30Y2q6e7ZyeYNN+dl50gFS
         Wc1v3CwpWYo8TzfSgsV6ufZ24ffJBOuHYMRPDjoiOWIdd2hTjPbeDDHBwuTlzVLPpn
         pCHcYxQv96BEUtIo3sb1X9+DK2VOPkwbJEOrNXsEgGWixbdDw4bmv4P30J5xYxE7L6
         v3zLn5MuGGngA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 5/7] mm/damon/Kconfig: Notify debugfs deprecation plan
Date:   Fri,  9 Sep 2022 20:28:59 +0000
Message-Id: <20220909202901.57977-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202901.57977-1-sj@kernel.org>
References: <20220909202901.57977-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b18402726bd1 ("Docs/admin-guide/mm/damon/usage: document DAMON
sysfs interface") announced the DAMON debugfs interface deprecation
plan, but it is not so aggressively announced.  As the deprecation time
is coming, this commit makes the announce more easy to be found by
adding the note to the config menu of DAMON debugfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 66265e3a9c65..7821fcb3f258 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -68,6 +68,9 @@ config DAMON_DBGFS
 
 	  If unsure, say N.
 
+	  This will be removed after >5.15.y LTS kernel is released, so users
+	  should move to the sysfs interface (DAMON_SYSFS).
+
 config DAMON_DBGFS_KUNIT_TEST
 	bool "Test for damon debugfs interface" if !KUNIT_ALL_TESTS
 	depends on DAMON_DBGFS && KUNIT=y
-- 
2.25.1

