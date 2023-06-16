Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1B27339B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjFPTV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345770AbjFPTVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E6525F;
        Fri, 16 Jun 2023 12:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3D4363EB1;
        Fri, 16 Jun 2023 19:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F0C433AD;
        Fri, 16 Jun 2023 19:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686943070;
        bh=/PqkZzi3PmcfmmQ2ShVZNSPJIc3ayquVqki2elLWBA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYrW9cm+OeRlKwfHbXjV7uGo3r6/53L5aXiZpIgz9CbhooZv0svdwy3KG+3gjDviP
         g600JjZC6WGUBJ8Ao8i1vOS2ef8fe5HL8Lo09xnPJqvawnLxGJ0BNLOdtS2DU8XbFO
         rqsM6NTwxkupSgRKVY5wiICRb1Xm/+peHg+PaUjmquV+CCNy1GffAX0B36347W3rEt
         tkj2wQOlIH3EAfsXY2L5KW01rNcwYCBJ1DrsIa8IR8iB9m6goXGF9JtfflAE03appl
         8ESApdmB5BaL1YQ73WzP13I0NNPwX5dIBNRYbPkB5AZ2NX3r2rQJFZxQRBzVvRigjw
         94cP3Y9asSwhg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] Docs/admin-guide/mm/damon/usage: fix typos in references and commas
Date:   Fri, 16 Jun 2023 19:17:38 +0000
Message-Id: <20230616191742.87531-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616191742.87531-1-sj@kernel.org>
References: <20230616191742.87531-1-sj@kernel.org>
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

Fix typos including a unnecessary comma and incomplete ':ref:' keywords.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 9b823fec974d..d2435dcc22f4 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -139,7 +139,7 @@ scheme of the kdamond.  Writing ``clear_schemes_tried_regions`` to ``state``
 file clears the DAMON-based operating scheme action tried regions directory for
 each DAMON-based operation scheme of the kdamond.  For details of the
 DAMON-based operation scheme action tried regions directory, please refer to
-:ref:tried_regions section <sysfs_schemes_tried_regions>`.
+:ref:`tried_regions section <sysfs_schemes_tried_regions>`.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
@@ -282,7 +282,7 @@ memory regions having specific access pattern of the interest.  The keywords
 that can be written to and read from the file and their meaning are as below.
 
 Note that support of each action depends on the running DAMON operations set
-`implementation <sysfs_contexts>`.
+:ref:`implementation <sysfs_contexts>`.
 
  - ``willneed``: Call ``madvise()`` for the region with ``MADV_WILLNEED``.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
@@ -432,8 +432,7 @@ starting from ``0`` under this directory.  Each directory contains files
 exposing detailed information about each of the memory region that the
 corresponding scheme's ``action`` has tried to be applied under this directory,
 during next :ref:`aggregation interval <sysfs_monitoring_attrs>`.  The
-information includes address range, ``nr_accesses``, , and ``age`` of the
-region.
+information includes address range, ``nr_accesses``, and ``age`` of the region.
 
 The directories will be removed when another special keyword,
 ``clear_schemes_tried_regions``, is written to the relevant
-- 
2.25.1

