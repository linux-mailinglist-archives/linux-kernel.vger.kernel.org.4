Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0164869112B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjBITUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBITUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:20:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF918C153;
        Thu,  9 Feb 2023 11:20:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C6AE61A59;
        Thu,  9 Feb 2023 19:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557C8C433D2;
        Thu,  9 Feb 2023 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675970414;
        bh=swRBBVE/viI6KG+9S+fnzgo4Go35k+GOMOw/h5ENBfk=;
        h=From:To:Cc:Subject:Date:From;
        b=n98LMgfRjhS+NQiBVMD7yJTQxUiNwDOHp2zsiupAX66a4s99YZJ/ZjJI8UL/11rhY
         n7xJ9PJgVIacDV1DI2adJtyPmK8TDZTu5DSbeeYYrc77U7bs02uZo7xi94plOychbu
         btI0RKSBjoXXVUZCJ9GiAhhhVkewgja1zOyu0+5X5sNxnAfK+YEAKUEolr9pG47VOu
         24jWZYkoRHC+NKEhGf46GGCisAfytAk3tvtLPaPaNxkA+zmWCMbs0ui3vxhyemuesN
         2jwjcZu+ibGnLPQQZjBNkQTmCk2UL4k9r+QnIiNJH7yqTaOFzJqqfR3/7MU49Vg5+a
         ExV/fjc6WqjJg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
Date:   Thu,  9 Feb 2023 19:20:06 +0000
Message-Id: <20230209192009.7885-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Date: Thu, 9 Feb 2023 19:16:23 +0000
Subject: [PATCH 0/3] mm/damon: deprecate DAMON debugfs interface

DAMON debugfs interface has announced to be deprecated after >v5.15 LTS
kernel is released.  And, v6.1.y has announced to be an LTS[1].

Though the announcement was there for a while, some people might not
noticed that so far.  Also, some users could depend on it and have
problems at  movng to the alternative (DAMON sysfs interface).

For such cases, keep the code and documents with warning messages and
contacts to ask helps for the deprecation.

[1] https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=332e9121320bc7461b2d3a79665caf153e51732c

SeongJae Park (3):
  Docs/admin-guide/mm/damon/usage: add DAMON debugfs interface
    deprecation notice
  mm/damon/Kconfig: add DAMON debugfs interface deprecation notice
  mm/damon/dbgfs: print DAMON debugfs interface deprecation message

 Documentation/admin-guide/mm/damon/usage.rst | 20 +++++++++++++-------
 mm/damon/Kconfig                             |  7 ++++---
 mm/damon/dbgfs.c                             | 16 ++++++++++++++++
 3 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.25.1

