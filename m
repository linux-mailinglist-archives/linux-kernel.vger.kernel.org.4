Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D952871195C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241945AbjEYVnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241879AbjEYVnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:43:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAFB134;
        Thu, 25 May 2023 14:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 186D164B66;
        Thu, 25 May 2023 21:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C201C4339C;
        Thu, 25 May 2023 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685051002;
        bh=pAFa7HjQcx+ryoZoo4sJVjdW99Hl1Us5CqTxI7BWAYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1A0tFYgWDn5FVYiNaylQFNzXACGLTl6XaeSun3nAY6cxd7j4cbM62HvjMInzXGVF
         ITZMEKzaOKPGGv7WAHa4kK6HXx/Vz1uPfJTn9s8RpNji2siobULCWgMXZbNJLjPMHs
         2/ACgdIDPn4BifqOaxC/TI36gn1iZHLXPwpLXx714PesThwWjpJPQpRSdcE11AfXye
         apBJRMF5DdsyTAoCWbiaMtzVy5g0fFbBYk7tMGx1iplnT4Ya4b6m4vhurRrgTEBJVG
         CqaLEW/orZWTA7XaqCGzDPRzgnRwy0ceUKdt/QjssIqIUAb9UHndd6BNi10PHd0Ph9
         w4ppJKX97Umzw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] Docs/mm/damon/maintainer-profile: fix typos and grammar errors
Date:   Thu, 25 May 2023 21:43:06 +0000
Message-Id: <20230525214314.5204-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
References: <20230525214314.5204-1-sj@kernel.org>
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

Fix a few typos and grammar erros in DAMON Maintainer Profile document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index 24a202f03de8..a84c14e59053 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -3,7 +3,7 @@
 DAMON Maintainer Entry Profile
 ==============================
 
-The DAMON subsystem covers the files that listed in 'DATA ACCESS MONITOR'
+The DAMON subsystem covers the files that are listed in 'DATA ACCESS MONITOR'
 section of 'MAINTAINERS' file.
 
 The mailing lists for the subsystem are damon@lists.linux.dev and
@@ -15,7 +15,7 @@ SCM Trees
 
 There are multiple Linux trees for DAMON development.  Patches under
 development or testing are queued in damon/next [2]_ by the DAMON maintainer.
-Suffieicntly reviewed patches will be queued in mm-unstable [1]_ by the memory
+Sufficiently reviewed patches will be queued in mm-unstable [1]_ by the memory
 management subsystem maintainer.  After more sufficient tests, the patches will
 be queued in mm-stable [3]_ , and finally pull-requested to the mainline by the
 memory management subsystem maintainer.
-- 
2.25.1

