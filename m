Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBB6C05EE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjCSWCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCSWCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:02:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558601DBAE;
        Sun, 19 Mar 2023 15:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E19E4B80D29;
        Sun, 19 Mar 2023 22:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9914FC433A0;
        Sun, 19 Mar 2023 22:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263276;
        bh=76mqBcXOclj70wK6vJnPXYiLxzzEBqv+7zktuDN4On8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUXzADYnvUt8jvBwlLbVomIIwpWr3m/fWNfNtQVriQSqwUkj2ZQ+OlQip8jRy+3ow
         aggOLR+nBPstDeDYoCVDuML8MQZLa3SSC2CwN/E0vJj4yzNurI9Il7fULzcWCisbra
         c7yB8r9CFGkQKDwiNPZKiJcPeWXDbrN/71RMaDACWGeE8j2JER9CcCCibhgZKC8/Ai
         kbrHlM/EvN/6IV6er2DGjJCzH+6Z1ob66/8rM3N6IqLfI81LXX3uHQGJVWw+sgkSHV
         J9v5GLpbpWEkXzeGh4WuYYJSZn6QLtRjsE1mebhfEDeaoxlsshPaZKo0qbGN9N4NbW
         c0B/T0aRKxRqQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 15/15] MAINTAINERS: extend memblock entry to include MM initialization
Date:   Mon, 20 Mar 2023 00:00:08 +0200
Message-Id: <20230319220008.2138576-16-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319220008.2138576-1-rppt@kernel.org>
References: <20230319220008.2138576-1-rppt@kernel.org>
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

and add mm/mm_init.c to memblock entry in MAINTAINERS

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7002a5d3eb62..b79463ea1049 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13368,13 +13368,14 @@ F:	arch/powerpc/include/asm/membarrier.h
 F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
 
-MEMBLOCK
+MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION
 M:	Mike Rapoport <rppt@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/core-api/boot-time-mm.rst
 F:	include/linux/memblock.h
 F:	mm/memblock.c
+F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
 MEMORY CONTROLLER DRIVERS
-- 
2.35.1

