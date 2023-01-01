Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1BD65A98A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 10:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAAJpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 04:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAAJpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 04:45:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A2238B7;
        Sun,  1 Jan 2023 01:45:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FE3860D3D;
        Sun,  1 Jan 2023 09:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D4AC433F0;
        Sun,  1 Jan 2023 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672566340;
        bh=ZLGBlhqw5hH+SxGqvaz0vux+DdR7ulM6iEJUTeGEBI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LSwwzypnpxZ3H85D2YBEdZVPE/TRDKRP3ryXydYoZefESGnt6H7OCoiHhlCv76bTW
         WNsDwPgC2L39QzADbYxOUtZ5vf8ia3V9oTIiY7BB0vnSPuWFhY7jC39amHSpkjl9qZ
         RnqpefIgXHJkGnQ1HoqbDXd331YBoJFJiUklCqIbOf5rn5IbhXkBJ+3w+zLmlvodBn
         jTk9oK8pN9j1brqpgBsL/YkXwVd+D9XQyRRvDztUu5lG0D+pTEMEkceTPHysQ+6szl
         0WGgLxEBeq+937o1Ve2rDdsaqu8Ek9mJGTcCzJ1tK358+nYc9YyGg7PqyOmpi4lPZ9
         BBxKhRagu/abQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/2] docs/mm: Page Reclaim: add page label to allow external references
Date:   Sun,  1 Jan 2023 11:45:22 +0200
Message-Id: <20230101094523.1522109-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230101094523.1522109-1-rppt@kernel.org>
References: <20230101094523.1522109-1-rppt@kernel.org>
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 Documentation/mm/page_reclaim.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/page_reclaim.rst b/Documentation/mm/page_reclaim.rst
index 50a30b7f8ac3..3fccde066436 100644
--- a/Documentation/mm/page_reclaim.rst
+++ b/Documentation/mm/page_reclaim.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _page_reclaim:
+
 ============
 Page Reclaim
 ============
-- 
2.35.1

