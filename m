Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400AA664BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbjAJTFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbjAJTEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:04:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0537F640C;
        Tue, 10 Jan 2023 11:04:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3337B81977;
        Tue, 10 Jan 2023 19:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3871C43398;
        Tue, 10 Jan 2023 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673377446;
        bh=3/9jPsJGQOYl5LrCGMIIfDURssYf3Mb7HlJVYLs/nag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gr+KJKuOm+aZo2aKeZ1tF+IL9mDXelWveS7Wxk+bEcvzreVPihAtB2EuuMgEG4Op+
         bKsUP+zpKY5H5OKwlQ1yc0rztEYYZ8x1s0mC6r3gGnt5v4EHwJ3ZdU+seblcwUS9kJ
         JJRcXQkUBKSyGrsgIdCruJ94Gwan6MSt8zzoeUt8vJ7g0Q99TpzhfCz8DIwDVlC9eE
         gJ20GaqpN48kAhaG7aSW2eLbXd5U+5RPPD8klZYlhXRiw8ckt8WskQbS1YOuRi48x5
         oRbPJPB+t0mhZ/CMMxTEZVxHRugcJwXgT99Ih/Y3waWx7CCb1xMDDlrpLe5Egv3gyc
         nOaZIpD2tfnvw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] Docs/mm/damon/index: mention DAMOS on the intro
Date:   Tue, 10 Jan 2023 19:03:55 +0000
Message-Id: <20230110190400.119388-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110190400.119388-1-sj@kernel.org>
References: <20230110190400.119388-1-sj@kernel.org>
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

What DAMON aims to do is not only access monitoring but efficient and
effective access-aware system operations.  And DAMon-based Operation
Schemes (DAMOS) is the important feature of DAMON for the goal.  Make
the intro of DAMON documentation to emphasize the goal and mention
DAMOS.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/index.rst | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/index.rst
index 48c0bbff98b2..2983699c12ea 100644
--- a/Documentation/mm/damon/index.rst
+++ b/Documentation/mm/damon/index.rst
@@ -4,8 +4,9 @@
 DAMON: Data Access MONitor
 ==========================
 
-DAMON is a data access monitoring framework subsystem for the Linux kernel.
-The core mechanisms of DAMON (refer to :doc:`design` for the detail) make it
+DAMON is a Linux kernel subsystem that provides a framework for data access
+monitoring and the monitoring results based system operations.  The core
+monitoring mechanisms of DAMON (refer to :doc:`design` for the detail) make it
 
  - *accurate* (the monitoring output is useful enough for DRAM level memory
    management; It might not appropriate for CPU Cache levels, though),
@@ -14,12 +15,16 @@ The core mechanisms of DAMON (refer to :doc:`design` for the detail) make it
  - *scalable* (the upper-bound of the overhead is in constant range regardless
    of the size of target workloads).
 
-Using this framework, therefore, the kernel's memory management mechanisms can
-make advanced decisions.  Experimental memory management optimization works
-that incurring high data accesses monitoring overhead could implemented again.
-In user space, meanwhile, users who have some special workloads can write
-personalized applications for better understanding and optimizations of their
-workloads and systems.
+Using this framework, therefore, the kernel can operate system in an
+access-aware fashion.  Because the features are also exposed to the user space,
+users who have special information about their workloads can write personalized
+applications for better understanding and optimizations of their workloads and
+systems.
+
+For easier development of such systems, DAMON provides a feature called DAMOS
+(DAMon-based Operation Schemes) in addition to the monitoring.  Using the
+feature, DAMON users in both kernel and user spaces can do access-aware system
+operations with no code but simple configurations.
 
 .. toctree::
    :maxdepth: 2
-- 
2.25.1

