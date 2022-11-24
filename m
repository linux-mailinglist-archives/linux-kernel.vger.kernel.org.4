Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6894E638090
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 22:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKXVVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 16:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKXVVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 16:21:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC10942D9;
        Thu, 24 Nov 2022 13:21:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20347B821DD;
        Thu, 24 Nov 2022 21:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67664C433D7;
        Thu, 24 Nov 2022 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669324881;
        bh=ew0j918CPCZ3BCkCfl4ilV0ZC0sdlaLXkkNEQyNFiwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJmT6SE5SJA1ZiuoIDKQK7YvF+WpstqdQXLA2OAwmGzcllHfgqeMqHBQmw3fIDzBh
         6/4db/iEOf/VXaVubqIXasXS+XfUwUpC4hIG+yryfKETPVmo/SatiMQHssPRl9LxF2
         HHd3aXxHc66tRm4Hs6ZmhQOYs/W4WRl81HNoyDx1kjhPKt9XkO4VkR0oxIeARx/ZWT
         p2w5sT7EmdFs/6tgNZtVwDDM4WtHoRa1vgujGujBRqBqfAZPEbQYUczoRmlOng9tL9
         sU3WWusdLWjBWHoAb2N8MZqjiUK1cv71Jw3MesaBo1Rvo7NslMPD8xh+SrC+xjOStS
         u3xZsD3pP/T2g==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 04/11] Docs/admin-guide/damon/reclaim: document 'skip_anon' parameter
Date:   Thu, 24 Nov 2022 21:21:07 +0000
Message-Id: <20221124212114.136863-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124212114.136863-1-sj@kernel.org>
References: <20221124212114.136863-1-sj@kernel.org>
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

Document the newly added 'skip_anon' parameter of DAMON_RECLAIM, which
can be used to avoid anonymous pages reclamation.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 4f1479a11e63..ff335e96e0d8 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -205,6 +205,15 @@ The end physical address of memory region that DAMON_RECLAIM will do work
 against.  That is, DAMON_RECLAIM will find cold memory regions in this region
 and reclaims.  By default, biggest System RAM is used as the region.
 
+skip_anon
+---------
+
+Skip anonymous pages reclamation.
+
+If this parameter is set as ``Y``, DAMON_RECLAIM does not reclaim anonymous
+pages.  By default, ``N``.
+
+
 kdamond_pid
 -----------
 
-- 
2.25.1

