Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FC065C5BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbjACSIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbjACSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:08:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7744313E39;
        Tue,  3 Jan 2023 10:08:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EF5EB81058;
        Tue,  3 Jan 2023 18:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530BBC433EF;
        Tue,  3 Jan 2023 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769283;
        bh=2fmXHBSVsGppJcRoTjCphJFENdR63eUoR0If3HwhaLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CowG0JQ5B9abMhnPu8BFk+cZ1dRtVF3jS5V9kfx5dWNJz8QGtvzdNH8XApG1gd+X6
         MAUq8OnJ9nEi3AUxvU2liKWJ63bm4POig7u7Rrm+EW2MhDDTmNMZ0+KnUI8FzOon7R
         Krk5S97AW4LsSZRd0SUyEYeI1c4vDBC+Kz/qPIo4eLVsdiFZ5Fl7+LuFNyBmSOY3rY
         /WZu/VUPJagzUcaT3niH2REI2S5+Nmtx6Apg7kbyDiGiw2KKxs+Aum/Q+CpAHui55C
         /m0yOjVO6K06R9yDP31+HmllM2EzSyyNO0ekAUlIYaQcIlMJzU7bnop0e3wvmROTCw
         sLWdMF1czYFzQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 5/5] Docs/admin-guide/mm/numaperf: increase depth of subsections
Date:   Tue,  3 Jan 2023 18:07:54 +0000
Message-Id: <20230103180754.129637-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103180754.129637-1-sj@kernel.org>
References: <20230103180754.129637-1-sj@kernel.org>
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

Each section of numaperf.rst has zero depth, and therefore be exposed to
the index of admin-guide/mm.  Especially 'See Also' section on the index
makes the document weird.  Hide the sections from the index by giving
the document a title and increasing the depth of each section.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/numaperf.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
index 166697325947..27868797621c 100644
--- a/Documentation/admin-guide/mm/numaperf.rst
+++ b/Documentation/admin-guide/mm/numaperf.rst
@@ -1,6 +1,9 @@
 .. _numaperf:
 
-=============
+================
+NUMA Performance
+================
+
 NUMA Locality
 =============
 
@@ -61,7 +64,6 @@ that are CPUs and hence suitable for generic task scheduling, and
 IO initiators such as GPUs and NICs.  Unlike access class 0, only
 nodes containing CPUs are considered.
 
-================
 NUMA Performance
 ================
 
@@ -96,7 +98,6 @@ for the platform.
 Access class 1 takes the same form but only includes values for CPU to
 memory activity.
 
-==========
 NUMA Cache
 ==========
 
@@ -170,7 +171,6 @@ The "size" is the number of bytes provided by this cache level.
 The "write_policy" will be 0 for write-back, and non-zero for
 write-through caching.
 
-========
 See Also
 ========
 
-- 
2.25.1

