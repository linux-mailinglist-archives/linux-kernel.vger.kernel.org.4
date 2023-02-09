Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F5169112F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjBITU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBITUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:20:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3AB458A1;
        Thu,  9 Feb 2023 11:20:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 476CD61BA0;
        Thu,  9 Feb 2023 19:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BDCC4339C;
        Thu,  9 Feb 2023 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675970415;
        bh=x39PRc/T046lvvssIPKrbvAhJnKd48hEXRslXo6G51Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzFX5MPfuSPK29Lom5JhsbHaaPcgjVVf1YkoJfatDQvxT5JmnDvRrVYrsiJRGiXTK
         L2Pe4kmbM4k/370TpVO1iWj1l5UpsBTyojfgcZice2Ge5QrYw5xcSt9xvsFixlggAT
         01IJkraGTY4i3MaiKeoiBoklVgJwQqvr8lALW54YozE9TnHdqgC77AbXHHlGtEUH5k
         ig1KK8mmIgy5hjL/Rpehj3X6amPuwwYe2gV1NClvixj/EL1PV6LanqN4qivaSBtGmy
         kUJp6CL33PK925drX8e4s92T8z+AfPtOpzjgRBJhQgT1lwJzPyb+0i9jP/jaKTJysf
         dSNNcCw/cXYbQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Docs/admin-guide/mm/damon/usage: add DAMON debugfs interface deprecation notice
Date:   Thu,  9 Feb 2023 19:20:07 +0000
Message-Id: <20230209192009.7885-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209192009.7885-1-sj@kernel.org>
References: <20230209192009.7885-1-sj@kernel.org>
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

DAMON debugfs interface has announced to be deprecated after >v5.15 LTS
kernel is released.  And, v6.1.y has announced to be an LTS[1].

Though the announcement was there for a while, some people might not
noticed that so far.  Also, some users could depend on it and have
problems at  movng to the alternative (DAMON sysfs interface).

For such cases, note DAMON debugfs interface as deprecated, and contacts
to ask helps on the document.

[1] https://git.kernel.org/pub/scm/docs/kernel/website.git/commit/?id=332e9121320bc7461b2d3a79665caf153e51732c

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 9237d6a25897..9b823fec974d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -25,10 +25,12 @@ DAMON provides below interfaces for different users.
   interface provides only simple :ref:`statistics <damos_stats>` for the
   monitoring results.  For detailed monitoring results, DAMON provides a
   :ref:`tracepoint <tracepoint>`.
-- *debugfs interface.*
+- *debugfs interface. (DEPRECATED!)*
   :ref:`This <debugfs_interface>` is almost identical to :ref:`sysfs interface
-  <sysfs_interface>`.  This will be removed after next LTS kernel is released,
-  so users should move to the :ref:`sysfs interface <sysfs_interface>`.
+  <sysfs_interface>`.  This is deprecated, so users should move to the
+  :ref:`sysfs interface <sysfs_interface>`.  If you depend on this and cannot
+  move, please report your usecase to damon@lists.linux.dev and
+  linux-mm@kvack.org.
 - *Kernel Space Programming Interface.*
   :doc:`This </mm/damon/api>` is for kernel space programmers.  Using this,
   users can utilize every feature of DAMON most flexibly and efficiently by
@@ -487,13 +489,17 @@ the files as above.  Above is only for an example.
 
 .. _debugfs_interface:
 
-debugfs Interface
-=================
+debugfs Interface (DEPRECATED!)
+===============================
 
 .. note::
 
-  DAMON debugfs interface will be removed after next LTS kernel is released, so
-  users should move to the :ref:`sysfs interface <sysfs_interface>`.
+  THIS IS DEPRECATED!
+
+  DAMON debugfs interface is deprecated, so users should move to the
+  :ref:`sysfs interface <sysfs_interface>`.  If you depend on this and cannot
+  move, please report your usecase to damon@lists.linux.dev and
+  linux-mm@kvack.org.
 
 DAMON exports eight files, ``attrs``, ``target_ids``, ``init_regions``,
 ``schemes``, ``monitor_on``, ``kdamond_pid``, ``mk_contexts`` and
-- 
2.25.1

